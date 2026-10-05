Set-StrictMode -Version 1.0
$script:BuildToolsRoot = $PSScriptRoot
$script:BuildSourceRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\source'))
$script:LastBuildArtifacts = $null
function Resolve-DevNgToolchain {
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
    param(
        [Parameter(Mandatory = $true)][string]$ToolsRoot
    )
    $project = Join-Path $ToolsRoot 'NscAdapter\NscAdapter.csproj'
    $dll = Join-Path $ToolsRoot 'NscAdapter\bin\Release\net8.0\NscAdapter.dll'
    if (-not (Test-Path -LiteralPath $project)) { throw "NscAdapter project is missing: $project" }
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
    $switchNsc = Join-Path $OutputDirectory "$Name.nsc"
    & $Toolchain['Sc'] $Source '-output' $sco '-ipath' $IncludePath '-PlatformName=Win64' '-final' '-forcename' '-nodeHeapSize=536870912' 2>&1
    if ($LASTEXITCODE -ne 0) { throw "SanScript compilation failed for $Name with exit code $LASTEXITCODE" }
    & $Toolchain['ScriptRc'] $sco $pcNsc '-uncompressedresources' '-aeskey' 'gta5' 2>&1
    if ($LASTEXITCODE -ne 0) { throw "scriptrc conversion failed for $Name with exit code $LASTEXITCODE" }
    $adapterArgs = @($AdapterDll, '--adapt-header', $HeaderReference, $pcNsc, $switchNsc, '--name', $Name, '--validate')
    if ($DryRun) { $adapterArgs += '--dry-run' }
    & dotnet @adapterArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Switch header adaptation failed for $Name with exit code $LASTEXITCODE" }
    $script:LastBuildArtifacts = @{ Sco = $sco; PcNsc = $pcNsc; Nsc = $switchNsc }
    if ($DryRun) {
        Write-Output "WOULD_BUILD $switchNsc"
    }
    else {
        Write-Output "BUILT $switchNsc"
    }
    Write-Output "INTERMEDIATE (do not install): $pcNsc"
}

function Invoke-BuildSet {
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
    $global:LASTEXITCODE = 0
}
