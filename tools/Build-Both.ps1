param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,

    [string]$SwitchHeaderReference,

    [string]$SwitchHeaderReferenceFolder,

    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,

    [string]$RagemenuSource = (Join-Path $PSScriptRoot '..\source\ragemenu.sc'),

    [string]$ControllerSource = (Join-Path $PSScriptRoot '..\source\achievement_controller.sc')
)

$ErrorActionPreference = 'Stop'
$buildStart = Get-Date

$DevNgRoot = [IO.Path]::GetFullPath($DevNgRoot)
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$RagemenuSource = [IO.Path]::GetFullPath($RagemenuSource)
$ControllerSource = [IO.Path]::GetFullPath($ControllerSource)

if ([string]::IsNullOrWhiteSpace($SwitchHeaderReference) -and [string]::IsNullOrWhiteSpace($SwitchHeaderReferenceFolder)) {
    throw 'Specify either -SwitchHeaderReference or -SwitchHeaderReferenceFolder.'
}
if (-not [string]::IsNullOrWhiteSpace($SwitchHeaderReference) -and -not [string]::IsNullOrWhiteSpace($SwitchHeaderReferenceFolder)) {
    throw 'Specify only one of -SwitchHeaderReference / -SwitchHeaderReferenceFolder.'
}
if (-not [string]::IsNullOrWhiteSpace($SwitchHeaderReferenceFolder)) {
    $SwitchHeaderReferenceFolder = [IO.Path]::GetFullPath($SwitchHeaderReferenceFolder)
    if (-not (Test-Path -LiteralPath $SwitchHeaderReferenceFolder -PathType Container)) { throw "Header reference folder is missing: $SwitchHeaderReferenceFolder" }
    # achievement_controller.nsc exists in every stock extraction and shares the
    # verified page-base / unk18 profile, so prefer it as the stable adapter ref.
    $preferred = Join-Path $SwitchHeaderReferenceFolder 'achievement_controller.nsc'
    if (Test-Path -LiteralPath $preferred) {
        $SwitchHeaderReference = $preferred
        Write-Output "HEADER_REFERENCE_FOLDER match: $preferred"
    } else {
        $fallback = Get-ChildItem -LiteralPath $SwitchHeaderReferenceFolder -Filter '*.nsc' -File | Select-Object -First 1 -ExpandProperty FullName
        if ([string]::IsNullOrWhiteSpace($fallback) -or -not (Test-Path -LiteralPath $fallback)) { throw "No .nsc reference found in folder $SwitchHeaderReferenceFolder" }
        $SwitchHeaderReference = $fallback
        Write-Output "HEADER_REFERENCE_FOLDER fallback: $fallback"
    }
}
$SwitchHeaderReference = [IO.Path]::GetFullPath($SwitchHeaderReference)

$sc = Join-Path $DevNgRoot 'sc.exe'
$scriptrc = Join-Path $DevNgRoot 'scriptrc_x64.exe'
$project = Join-Path $DevNgRoot 'singleplayer\GTA5_SP.scproj'
$adapterProject = Join-Path $PSScriptRoot 'NscAdapter\NscAdapter.csproj'

foreach ($required in @($sc, $scriptrc, $project, $adapterProject, $SwitchHeaderReference, $RagemenuSource, $ControllerSource)) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Required file is missing: $required" }
}

$projectXml = [xml](Get-Content -LiteralPath $project)
$release = $projectXml.ProjectEditorSettingsVer3_0.CompilingSettingsList.CompilingSettings |
    Where-Object { $_.ConfigurationName -eq 'Release' } |
    Select-Object -First 1
if ($null -eq $release) { throw "Could not find Release include paths in $project" }
$includePath = ((($release.IncludePaths.string |
    ForEach-Object { $_.Replace('$(script)', $DevNgRoot) }) + (Join-Path $PSScriptRoot '..\source')) -join ';')

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
Copy-Item -LiteralPath $RagemenuSource -Destination (Join-Path $OutputDirectory 'ragemenu.sc') -Force
Copy-Item -LiteralPath $ControllerSource -Destination (Join-Path $OutputDirectory 'achievement_controller.sc') -Force
Get-ChildItem -LiteralPath (Join-Path $PSScriptRoot '..\source') -Recurse -Filter '*.sch' | ForEach-Object {
    $relative = $_.FullName.Substring(((Join-Path $PSScriptRoot '..\source') | Resolve-Path).Path.Length + 1)
    $destination = Join-Path $OutputDirectory $relative
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
    Copy-Item -LiteralPath $_.FullName -Destination $destination -Force
}

function Build-NscScript {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Source
    )

    $sco = Join-Path $OutputDirectory "$Name.sco"
    $pcNsc = Join-Path $OutputDirectory "$Name.pc.nsc"
    $switchNsc = Join-Path $OutputDirectory "$Name.nsc"

    & $sc $Source '-output' $sco '-ipath' $includePath '-PlatformName=Win64' '-final' '-forcename' '-nodeHeapSize=536870912'
    if ($LASTEXITCODE -ne 0) { throw "SanScript compilation failed for $Name with exit code $LASTEXITCODE" }

    & $scriptrc $sco $pcNsc '-uncompressedresources' '-aeskey' 'gta5'
    if ($LASTEXITCODE -ne 0) { throw "scriptrc conversion failed for $Name with exit code $LASTEXITCODE" }

    & 'dotnet' run --project $adapterProject -c Release --no-restore -- --adapt-header $SwitchHeaderReference $pcNsc $switchNsc
    if ($LASTEXITCODE -ne 0) { throw "Switch header adaptation failed for $Name with exit code $LASTEXITCODE" }

    Write-Output "BUILT $switchNsc"
}

Build-NscScript -Name 'ragemenu' -Source $RagemenuSource
Build-NscScript -Name 'achievement_controller' -Source $ControllerSource

$elapsed = (Get-Date) - $buildStart
Write-Output "BUILD_SECONDS $([math]::Round($elapsed.TotalSeconds, 1))"
Write-Output 'These are raw Switch script payloads. Insert them into script_rel.rpf as normal compressed file entries, not as RPF resource entries.'
