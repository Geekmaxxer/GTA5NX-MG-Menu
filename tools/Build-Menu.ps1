param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,

    [Parameter(Mandatory = $true)]
    [string]$SwitchHeaderReference,

    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,

    [string]$Source = (Join-Path $PSScriptRoot '..\source\ragemenu.sc')
)

$ErrorActionPreference = 'Stop'

$DevNgRoot = [IO.Path]::GetFullPath($DevNgRoot)
$SwitchHeaderReference = [IO.Path]::GetFullPath($SwitchHeaderReference)
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$Source = [IO.Path]::GetFullPath($Source)

$sc = Join-Path $DevNgRoot 'sc.exe'
$scriptrc = Join-Path $DevNgRoot 'scriptrc_x64.exe'
$project = Join-Path $DevNgRoot 'singleplayer\GTA5_SP.scproj'
$adapterProject = Join-Path $PSScriptRoot 'NscAdapter\NscAdapter.csproj'

foreach ($required in @($sc, $scriptrc, $project, $adapterProject, $SwitchHeaderReference, $Source)) {
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
# Keep an exact source snapshot beside every build so a later failed test can
# always be reproduced or reverted without searching through the workspace.
Copy-Item -LiteralPath $Source -Destination (Join-Path $OutputDirectory 'ragemenu.sc') -Force
$controllerSnapshot = Join-Path $PSScriptRoot '..\source\achievement_controller.sc'
if (Test-Path -LiteralPath $controllerSnapshot) {
    Copy-Item -LiteralPath $controllerSnapshot -Destination (Join-Path $OutputDirectory 'achievement_controller.sc') -Force
}
$sco = Join-Path $OutputDirectory 'ragemenu.sco'
$pcNsc = Join-Path $OutputDirectory 'ragemenu.pc.nsc'
# The archive entry must be named ragemenu.nsc.  Keep the Win64 compiler
# intermediate separate so it cannot be installed by mistake.
$switchNsc = Join-Path $OutputDirectory 'ragemenu.nsc'

& $sc $Source '-output' $sco '-ipath' $includePath '-PlatformName=Win64' '-final' '-forcename' '-nodeHeapSize=536870912'
if ($LASTEXITCODE -ne 0) { throw "SanScript compilation failed with exit code $LASTEXITCODE" }

& $scriptrc $sco $pcNsc '-uncompressedresources' '-aeskey' 'gta5'
if ($LASTEXITCODE -ne 0) { throw "scriptrc conversion failed with exit code $LASTEXITCODE" }

& 'dotnet' run --project $adapterProject -c Release --no-restore -- --adapt-header $SwitchHeaderReference $pcNsc $switchNsc
if ($LASTEXITCODE -ne 0) { throw "Switch header adaptation failed with exit code $LASTEXITCODE" }

Write-Output "BUILT $switchNsc"
Write-Output "INTERMEDIATE (do not install): $pcNsc"
Write-Output 'This is a raw Switch script payload. Insert it into script_rel.rpf as a normal compressed file entry, not as an RPF resource entry.'
