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

# Thin wrapper. Every piece of build logic - the output name, the source
# snapshot, the reference resolution and the manifest - lives in
# BuildCommon.ps1 and NscCore. The output name comes from the -Source file, so
# building a different script produces differently named artifacts instead of
# silently reusing "ragemenu".
. (Join-Path $PSScriptRoot 'BuildCommon.ps1')

Invoke-BuildSet -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $OutputDirectory `
    -Source $Source `
    -DryRun:$DryRun
