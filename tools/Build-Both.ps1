param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,
    [string]$SwitchHeaderReference,
    [string]$SwitchHeaderReferenceFolder,
    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,
    [string]$RagemenuSource = (Join-Path $PSScriptRoot '..\source\ragemenu.sc'),
    [string]$ControllerSource = (Join-Path $PSScriptRoot '..\source\achievement_controller.sc'),
    [switch]$DryRun
)
. (Join-Path $PSScriptRoot 'BuildCommon.ps1')
Invoke-BuildSet -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $OutputDirectory `
    -Source @($RagemenuSource, $ControllerSource) `
    -DryRun:$DryRun
