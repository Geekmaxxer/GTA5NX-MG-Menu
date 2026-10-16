param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,

    [string]$SwitchHeaderReference,

    [string]$SwitchHeaderReferenceFolder,

    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,

    [string]$Source = (Join-Path $PSScriptRoot '..\source\ragemenu.sc'),

    [switch]$DryRun
)

# Thin wrapper over BuildCommon.ps1. The default is the menu script, but the
# output name is derived from -Source, so passing a different .sc produces
# <thatName>.nsc rather than overwriting ragemenu.nsc.
. (Join-Path $PSScriptRoot 'BuildCommon.ps1')

Invoke-BuildSet -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $OutputDirectory `
    -Source @($Source) `
    -DryRun:$DryRun
