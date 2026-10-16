# BuildCommon.ps1 - the single build engine for the MG-SwitchMenu SDK.
#
# Dot-source this file from a thin wrapper (Build-Any.ps1, Build-Menu.ps1,
# Build-Controller.ps1, Build-Both.ps1). Every wrapper goes through
# Invoke-BuildSet, so the output name, the source snapshot, the reference
# resolution and the manifest all come from exactly one implementation.
#
# The script name is derived from the -Source file, never hardcoded, and the
# header reference is resolved by NscAdapter (see --name) so the tools and the
# build scripts cannot disagree about which stock script supplied the bytes.
#
# Requires PowerShell 5.1+. No PowerShell 7 syntax is used.

Set-StrictMode -Version 1.0

# Captured at dot-source time, while $PSScriptRoot is reliably this file.
$script:BuildToolsRoot = $PSScriptRoot
$script:BuildSourceRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\source'))

# Set by Invoke-ScriptBuild. Returning this through the pipeline is unsafe:
# the external compilers write to stdout, so anything assigned from a function
# that runs them would capture compiler output as well.
$script:LastBuildArtifacts = $null

function Resolve-DevNgToolchain {
    <#
        Validates and returns the DEV compiler toolchain paths. Pass the same
        root the SDK documents: X:\gta5\script\dev_ng
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$DevNgRoot
    )

    $root = [IO.Path]::GetFullPath($DevNgRoot)
    $toolchain = @{
        Root     = $root
        Sc       = Join-Path $root 'sc.exe'
        ScriptRc = Join-Path $root 'scriptrc_x64.exe'
        Project  = Join-Path $root 'singleplayer\GTA5_SP.scproj'
    }

    foreach ($key in @('Sc', 'ScriptRc', 'Project')) {
        if (-not (Test-Path -LiteralPath $toolchain[$key])) {
            throw "Required toolchain file is missing: $($toolchain[$key])"
        }
    }
    return $toolchain
}

function Get-IncludePath {
    <#
        Reads the Release include paths out of GTA5_SP.scproj, substitutes
        $(script), and appends the SDK source directory.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$ProjectPath,
        [Parameter(Mandatory = $true)][string]$DevNgRoot,
        [Parameter(Mandatory = $true)][string]$SourceRoot
    )

    $projectXml = [xml](Get-Content -LiteralPath $ProjectPath)
    $release = $projectXml.ProjectEditorSettingsVer3_0.CompilingSettingsList.CompilingSettings |
        Where-Object { $_.ConfigurationName -eq 'Release' } |
        Select-Object -First 1
    if ($null -eq $release) { throw "Could not find Release include paths in $ProjectPath" }

    $parts = @()
    foreach ($entry in $release.IncludePaths.string) {
        $parts += $entry.Replace('$(script)', $DevNgRoot)
    }
    $parts += $SourceRoot
    return ($parts -join ';')
}

function Assert-HeaderReference {
    <#
        Returns either a resolved file path or the folder itself. A folder is
        passed through untouched so NscAdapter (with --name) is the one and only
        place that decides which script inside it supplies the header bytes.
    #>
    param(
        [string]$SwitchHeaderReference,
        [string]$SwitchHeaderReferenceFolder
    )

    $hasFile = -not [string]::IsNullOrWhiteSpace($SwitchHeaderReference)
    $hasFolder = -not [string]::IsNullOrWhiteSpace($SwitchHeaderReferenceFolder)

    if (-not $hasFile -and -not $hasFolder) {
        throw 'Specify either -SwitchHeaderReference or -SwitchHeaderReferenceFolder.'
    }
    if ($hasFile -and $hasFolder) {
        throw 'Specify only one of -SwitchHeaderReference / -SwitchHeaderReferenceFolder.'
    }

    if ($hasFile) {
        $full = [IO.Path]::GetFullPath($SwitchHeaderReference)
        if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
            throw "Header reference file is missing: $full"
        }
        return $full
    }

    $folder = [IO.Path]::GetFullPath($SwitchHeaderReferenceFolder)
    if (-not (Test-Path -LiteralPath $folder -PathType Container)) {
        throw "Header reference folder is missing: $folder"
    }
    return $folder
}

function Get-AdapterDll {
    <#
        Builds NscAdapter once per build and returns the produced DLL path.
        Invoking the DLL directly beats "dotnet run" here: no restore/build round
        trip per script, and an unambiguous error when the tool itself does not
        compile.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$ToolsRoot
    )

    $project = Join-Path $ToolsRoot 'NscAdapter\NscAdapter.csproj'
    $dll = Join-Path $ToolsRoot 'NscAdapter\bin\Release\net8.0\NscAdapter.dll'
    if (-not (Test-Path -LiteralPath $project)) { throw "NscAdapter project is missing: $project" }

    # Write-Host, not a bare call: the caller assigns this function's output, so
    # build output would otherwise be captured into the returned path. 2>&1 keeps
    # native stderr from becoming a terminating error under 'Stop'.
    & dotnet build $project -c Release --nologo -v minimal 2>&1 | Write-Host
    if ($LASTEXITCODE -ne 0) { throw "NscAdapter failed to build (exit code $LASTEXITCODE)" }
    if (-not (Test-Path -LiteralPath $dll)) { throw "NscAdapter.dll was not produced at $dll" }
    return $dll
}

function Get-FileSha256 {
    param([Parameter(Mandatory = $true)][string]$Path)
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-GitCommit {
    <#
        Returns the current commit, or $null when git is absent or the path is
        not in a repository. The workspace and X:\gta5\script\dev_ng have no
        .git, so the manifest records null with a reason instead of failing.
    #>
    param([Parameter(Mandatory = $true)][string]$Path)

    try {
        $output = & git -C $Path rev-parse HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace($output)) {
            return ([string]$output).Trim()
        }
    } catch {
        return $null
    }
    return $null
}

function Copy-SourceSnapshot {
    <#
        Copies every entry point plus the whole .sch tree beside the build, so a
        later failure can be reproduced or reverted. Only the files that were
        actually compiled are copied: the old wrappers also copied the *other*
        script, leaving snapshot dirs with a file that was never built.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$SourceRoot,
        [Parameter(Mandatory = $true)][string]$OutputDirectory,
        [Parameter(Mandatory = $true)][string[]]$EntryPoints
    )

    foreach ($entry in $EntryPoints) {
        Copy-Item -LiteralPath $entry -Destination (Join-Path $OutputDirectory ([IO.Path]::GetFileName($entry))) -Force
    }

    $rootFull = [IO.Path]::GetFullPath($SourceRoot)
    Get-ChildItem -LiteralPath $rootFull -Recurse -Filter '*.sch' -File | ForEach-Object {
        $relative = $_.FullName.Substring($rootFull.Length).TrimStart('\')
        $destination = Join-Path $OutputDirectory $relative
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $destination -Force
    }
}

function Get-PayloadInfo {
    <#
        Asks NscAdapter to describe a file and parses the "KEY value" lines it
        prints. The header offsets live only in NscCore, so this script never
        hardcodes them.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$AdapterDll,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $lines = & dotnet $AdapterDll --info $Path 2>&1
    $info = [ordered]@{
        fileBytes       = $null
        payloadBytes    = $null
        barePayload     = $null
        rsc7Envelope    = $null
        pageBase        = $null
        buildWord       = $null
        codeLength      = $null
        statics         = $null
        natives         = $null
        internalName    = $null
        nameHash        = $null
        nameHashMatches = $null
        profile         = $null
    }

    foreach ($line in $lines) {
        if     ($line -match '^FILE_BYTES\s+(\d+)')                              { $info['fileBytes'] = [int]$matches[1] }
        elseif ($line -match '^PAYLOAD_BYTES\s+(\d+)')                           { $info['payloadBytes'] = [int]$matches[1] }
        elseif ($line -match '^BARE_PAYLOAD\s+(\w+)')                            { $info['barePayload'] = $matches[1] }
        elseif ($line -match '^RSC7_ENVELOPE\s+(\w+)')                           { $info['rsc7Envelope'] = $matches[1] }
        elseif ($line -match '^PAGE_BASE\s+(0x[0-9A-Fa-f]+)')                    { $info['pageBase'] = $matches[1] }
        elseif ($line -match '^BUILD_WORD\s+(0x[0-9A-Fa-f]+)')                   { $info['buildWord'] = $matches[1] }
        elseif ($line -match '^CODE_LENGTH\s+(\d+)')                             { $info['codeLength'] = [int]$matches[1] }
        elseif ($line -match '^STATICS\s+(\d+)')                                 { $info['statics'] = [int]$matches[1] }
        elseif ($line -match '^NATIVES\s+(\d+)')                                 { $info['natives'] = [int]$matches[1] }
        elseif ($line -match '^INTERNAL_NAME\s+(.+)$')                           { $info['internalName'] = $matches[1].Trim() }
        elseif ($line -match '^NAME_HASH\s+(0x[0-9A-Fa-f]+)\s+joaat_match=(\w+)') { $info['nameHash'] = $matches[1]; $info['nameHashMatches'] = $matches[2] }
        elseif ($line -match '^PROFILE\s+(.+)$')                                 { $info['profile'] = $matches[1].Trim() }
    }

    if ($info['barePayload'] -ne 'yes') {
        Write-Warning "the produced $Path is not a bare payload; it will not install into script_rel.rpf as a file entry"
    }
    return $info
}

function Get-SourceFileHashes {
    <#
        SHA256 of every file that took part in the build: the entry points plus
        the whole .sch tree.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$SourceRoot,
        [Parameter(Mandatory = $true)][string[]]$EntryPoints
    )

    $list = New-Object System.Collections.ArrayList
    foreach ($entry in $EntryPoints) {
        [void]$list.Add([ordered]@{
            path   = [IO.Path]::GetFileName($entry)
            sha256 = (Get-FileSha256 -Path $entry)
        })
    }

    $rootFull = [IO.Path]::GetFullPath($SourceRoot)
    Get-ChildItem -LiteralPath $rootFull -Recurse -Filter '*.sch' -File |
        Sort-Object FullName |
        ForEach-Object {
            $relative = $_.FullName.Substring($rootFull.Length).TrimStart('\').Replace('\', '/')
            [void]$list.Add([ordered]@{
                path   = $relative
                sha256 = (Get-FileSha256 -Path $_.FullName)
            })
        }

    return $list
}

function Write-BuildManifest {
    <#
        Records exactly what produced this build: source hashes, tool hashes,
        the reference that supplied the header bytes, the payload header fields,
        and the four status flags. packaged and runtimeVerified are always
        written as false here; they are only ever set by hand after an RPF build
        and an on-hardware test.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$OutputDirectory,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$HeaderReference,
        [Parameter(Mandatory = $true)][hashtable]$Artifacts,
        [Parameter(Mandatory = $true)][string]$SourceRoot,
        [Parameter(Mandatory = $true)][string[]]$EntryPoints,
        [Parameter(Mandatory = $true)][hashtable]$Toolchain,
        [Parameter(Mandatory = $true)][string]$AdapterDll
    )

    $manifestPath = Join-Path $OutputDirectory "$Name.build.json"

    $payload = Get-PayloadInfo -AdapterDll $AdapterDll -Path $Artifacts['Nsc']
    $sourceHashes = @(Get-SourceFileHashes -SourceRoot $SourceRoot -EntryPoints $EntryPoints)

    $referenceIsFolder = Test-Path -LiteralPath $HeaderReference -PathType Container
    $referenceResolved = $HeaderReference
    if ($referenceIsFolder) {
        # Ask the adapter which file it actually picked, so the manifest records
        # the real reference rather than the folder that was passed in.
        $probe = & dotnet $AdapterDll --info $HeaderReference 2>&1 |
            Where-Object { $_ -like 'HEADER_REFERENCE*' } |
            Select-Object -First 1
        if ($probe -match ':\s*(.+)$') { $referenceResolved = $matches[1].Trim() }
    }

    $referenceSha = $null
    if (Test-Path -LiteralPath $referenceResolved -PathType Leaf) {
        $referenceSha = Get-FileSha256 -Path $referenceResolved
    }

    $dotnetVersion = ''
    $dotnetOutput = & dotnet --version 2>$null
    if ($dotnetOutput) { $dotnetVersion = ([string]$dotnetOutput).Trim() }

    $gitCommit = Get-GitCommit -Path $SourceRoot

    $manifest = [ordered]@{
        format   = 'switch-menu-build-manifest-v1'
        name     = $Name
        builtUtc = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        source   = [ordered]@{
            entryPoints = @($EntryPoints | ForEach-Object { [IO.Path]::GetFileName($_) })
            files       = $sourceHashes
        }
        reference = [ordered]@{
            supplied      = [IO.Path]::GetFullPath($HeaderReference)
            resolved      = [IO.Path]::GetFullPath($referenceResolved)
            suppliedKind  = $(if ($referenceIsFolder) { 'folder' } else { 'file' })
            resolvedFile  = [IO.Path]::GetFileName($referenceResolved)
            sha256        = $referenceSha
        }
        artifacts = [ordered]@{
            sco   = [ordered]@{ file = [IO.Path]::GetFileName($Artifacts['Sco']);   sha256 = (Get-FileSha256 -Path $Artifacts['Sco']);   bytes = (Get-Item -LiteralPath $Artifacts['Sco']).Length }
            pcNsc = [ordered]@{ file = [IO.Path]::GetFileName($Artifacts['PcNsc']); sha256 = (Get-FileSha256 -Path $Artifacts['PcNsc']); bytes = (Get-Item -LiteralPath $Artifacts['PcNsc']).Length }
            nsc   = [ordered]@{ file = [IO.Path]::GetFileName($Artifacts['Nsc']);   sha256 = (Get-FileSha256 -Path $Artifacts['Nsc']);   bytes = (Get-Item -LiteralPath $Artifacts['Nsc']).Length }
        }
        payload = $payload
        tools   = [ordered]@{
            scExe          = [ordered]@{ file = 'sc.exe';           sha256 = (Get-FileSha256 -Path $Toolchain['Sc']) }
            scriptRcX64Exe = [ordered]@{ file = 'scriptrc_x64.exe'; sha256 = (Get-FileSha256 -Path $Toolchain['ScriptRc']) }
            nscAdapterDll  = [ordered]@{ file = 'NscAdapter.dll';   sha256 = (Get-FileSha256 -Path $AdapterDll) }
            dotnetSdk      = $dotnetVersion
            devNgRoot      = $Toolchain['Root']
        }
        gitCommit                  = $gitCommit
        gitCommitUnavailableReason = 'neither the workspace nor the DEV toolchain root contains a .git directory; recorded as null'
        status = [ordered]@{
            compiled        = $true
            headerAdapted   = $true
            packaged        = $false
            runtimeVerified = $false
            note            = 'packaged and runtimeVerified are set only after an RPF build and an on-hardware test'
        }
    }

    $json = $manifest | ConvertTo-Json -Depth 12
    [IO.File]::WriteAllText($manifestPath, $json, (New-Object Text.UTF8Encoding($false)))
    Write-Output "MANIFEST $manifestPath"
}

function Invoke-ScriptBuild {
    <#
        Compiles one .sc, converts it, adapts the header and verifies the result.
        The artifact paths are published through $script:LastBuildArtifacts
        rather than a return value: the compilers write to stdout, so assigning
        the call would capture compiler output along with the result.
    #>
    param(
        [Parameter(Mandatory = $true)][hashtable]$Toolchain,
        [Parameter(Mandatory = $true)][string]$IncludePath,
        [Parameter(Mandatory = $true)][string]$AdapterDll,
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$OutputDirectory,
        [Parameter(Mandatory = $true)][string]$HeaderReference,
        [switch]$DryRun
    )

    $sco = Join-Path $OutputDirectory "$Name.sco"
    $pcNsc = Join-Path $OutputDirectory "$Name.pc.nsc"
    # The archive entry must be named "<Name>.nsc", so the Win64 intermediate is
    # kept in a separate file that cannot be installed by mistake.
    $switchNsc = Join-Path $OutputDirectory "$Name.nsc"

    # Every native call below merges stderr into stdout with 2>&1. PowerShell 5.1
    # turns a native process's stderr into an ErrorRecord, and with
    # $ErrorActionPreference='Stop' that aborts the build - even though the
    # messages involved are benign (scriptrc's aes-key notice, the adapter's
    # provenance warnings). The exit code is what decides success.
    & $Toolchain['Sc'] $Source '-output' $sco '-ipath' $IncludePath '-PlatformName=Win64' '-final' '-forcename' '-nodeHeapSize=536870912' 2>&1
    if ($LASTEXITCODE -ne 0) { throw "SanScript compilation failed for $Name with exit code $LASTEXITCODE" }

    & $Toolchain['ScriptRc'] $sco $pcNsc '-uncompressedresources' '-aeskey' 'gta5' 2>&1
    if ($LASTEXITCODE -ne 0) { throw "scriptrc conversion failed for $Name with exit code $LASTEXITCODE" }

    # --name lets the adapter resolve the reference itself when a folder was
    # supplied, so this script never duplicates that rule. --validate checks the
    # script name invariants on the file that was just written.
    $adapterArgs = @($AdapterDll, '--adapt-header', $HeaderReference, $pcNsc, $switchNsc, '--name', $Name, '--validate')
    if ($DryRun) { $adapterArgs += '--dry-run' }
    & dotnet @adapterArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Switch header adaptation failed for $Name with exit code $LASTEXITCODE" }

    $script:LastBuildArtifacts = @{ Sco = $sco; PcNsc = $pcNsc; Nsc = $switchNsc }
    if ($DryRun) {
        # Never print BUILT for a file that was not written: this project treats
        # "compiled" as a claim that must stay true.
        Write-Output "WOULD_BUILD $switchNsc"
    }
    else {
        Write-Output "BUILT $switchNsc"
    }
    Write-Output "INTERMEDIATE (do not install): $pcNsc"
}

function Invoke-BuildSet {
    <#
        The single entry point every wrapper calls. Builds each -Source into
        -OutputDirectory, snapshotting the exact sources and writing one
        <Name>.build.json per compiled script.
    #>
    param(
        [Parameter(Mandatory = $true)][string]$DevNgRoot,
        [string]$SwitchHeaderReference,
        [string]$SwitchHeaderReferenceFolder,
        [Parameter(Mandatory = $true)][string]$OutputDirectory,
        [Parameter(Mandatory = $true)][string[]]$Source,
        [switch]$DryRun
    )

    $ErrorActionPreference = 'Stop'
    $buildStart = Get-Date

    $toolsRoot = $script:BuildToolsRoot
    $sourceRoot = $script:BuildSourceRoot

    $toolchain = Resolve-DevNgToolchain -DevNgRoot $DevNgRoot
    $headerReference = Assert-HeaderReference -SwitchHeaderReference $SwitchHeaderReference -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder
    $includePath = Get-IncludePath -ProjectPath $toolchain['Project'] -DevNgRoot $toolchain['Root'] -SourceRoot $sourceRoot
    $adapterDll = Get-AdapterDll -ToolsRoot $toolsRoot

    $OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
    New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null

    $entryPoints = @()
    foreach ($item in $Source) {
        $full = [IO.Path]::GetFullPath($item)
        if (-not (Test-Path -LiteralPath $full -PathType Leaf)) { throw "Source file is missing: $full" }
        $entryPoints += $full
    }

    Copy-SourceSnapshot -SourceRoot $sourceRoot -OutputDirectory $OutputDirectory -EntryPoints $entryPoints

    foreach ($entry in $entryPoints) {
        $name = [IO.Path]::GetFileNameWithoutExtension($entry)
        Invoke-ScriptBuild -Toolchain $toolchain -IncludePath $includePath -AdapterDll $adapterDll `
            -Source $entry -Name $name -OutputDirectory $OutputDirectory `
            -HeaderReference $headerReference -DryRun:$DryRun

        if ($DryRun) {
            # No artifact was written, so there is nothing to hash. Recording a
            # manifest here would either fail or claim hashes that do not exist.
            Write-Output "DRY_RUN manifest skipped for $name (no artifact was written)"
        }
        else {
            Write-BuildManifest -OutputDirectory $OutputDirectory -Name $name `
                -HeaderReference $headerReference -Artifacts $script:LastBuildArtifacts `
                -SourceRoot $sourceRoot -EntryPoints @($entry) `
                -Toolchain $toolchain -AdapterDll $adapterDll
        }
    }

    $elapsed = (Get-Date) - $buildStart
    Write-Output "BUILD_SECONDS $([math]::Round($elapsed.TotalSeconds, 1))"
    Write-Output 'These are raw Switch script payloads. Insert them into script_rel.rpf as normal compressed file entries, not as RPF resource entries.'

    # A successful build must not leave a stale non-zero $LASTEXITCODE behind
    # from an internal native command (git probing for a repository, for
    # example). Anything that actually failed throws above, so reaching this
    # line means the whole chain succeeded.
    $global:LASTEXITCODE = 0
}
