param(
    [Parameter(Mandatory = $true)]
    [string]$DevNgRoot,
    [string]$SwitchHeaderReference,
    [string]$SwitchHeaderReferenceFolder,
    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,
    [Parameter(Mandatory = $true)]
    [string[]]$Source,
    [switch]$DryRun
)
. (Join-Path $PSScriptRoot 'BuildCommon.ps1')
Invoke-BuildSet -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $OutputDirectory `
    -Source $Source `
    -DryRun:$DryRun
