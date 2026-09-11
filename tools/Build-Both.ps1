param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,

    [Parameter(Mandatory = $true)]
    [string]$SwitchHeaderReference,

    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,

    [string]$RagemenuSource = (Join-Path $PSScriptRoot '..\source\ragemenu.sc'),

    [string]$ControllerSource = (Join-Path $PSScriptRoot '..\source\achievement_controller.sc')
)

$ErrorActionPreference = 'Stop'

$DevNgRoot = [IO.Path]::GetFullPath($DevNgRoot)
$SwitchHeaderReference = [IO.Path]::GetFullPath($SwitchHeaderReference)
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$RagemenuSource = [IO.Path]::GetFullPath($RagemenuSource)
$ControllerSource = [IO.Path]::GetFullPath($ControllerSource)

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
$includePath = (($release.IncludePaths.string |
    ForEach-Object { $_.Replace('$(script)', $DevNgRoot) }) -join ';')

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
# Preserve the exact source inputs used for this build.
Copy-Item -LiteralPath $RagemenuSource -Destination (Join-Path $OutputDirectory 'ragemenu.sc') -Force
Copy-Item -LiteralPath $ControllerSource -Destination (Join-Path $OutputDirectory 'achievement_controller.sc') -Force

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

Write-Output 'These are raw Switch script payloads. Insert them into script_rel.rpf as normal compressed file entries, not as RPF resource entries.'
