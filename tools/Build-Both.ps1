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

# Thin wrapper over BuildCommon.ps1: builds both scripts into one output
# directory with one shared source snapshot. Both scripts resolve their header
# reference through the same NscAdapter rule, so they cannot pick different
# stock scripts from the same folder.
. (Join-Path $PSScriptRoot 'BuildCommon.ps1')

Invoke-BuildSet -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $OutputDirectory `
    -Source @($RagemenuSource, $ControllerSource) `
    -DryRun:$DryRun
