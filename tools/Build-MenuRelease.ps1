<#
.SYNOPSIS
    Builds the v1.0.6 menu/controller and the matching ScriptHookV-NX binding.
.DESCRIPTION
    Uses the existing SanScript build engine and a separate ScriptHookV-NX SDK
    checkout. Does not modify game archives, install files, or include subsdk5.
#>
param(
    [Parameter(Mandatory = $true)][string]$DevNgRoot,
    [Parameter(Mandatory = $true)][string]$ScriptHookRoot,
    [string]$SwitchHeaderReference,
    [string]$SwitchHeaderReferenceFolder,
    [Parameter(Mandatory = $true)][string]$OutputDirectory,
    [string]$Python = 'python'
)

$ErrorActionPreference = 'Stop'
$bindingTool = Join-Path ([IO.Path]::GetFullPath($ScriptHookRoot)) 'tools\native_bindings.py'
if (-not (Test-Path -LiteralPath $bindingTool -PathType Leaf)) {
    throw "ScriptHookV-NX binding generator is missing: $bindingTool"
}
if (-not (Get-Command $Python -ErrorAction SilentlyContinue)) {
    throw "Python was not found: $Python"
}
$outPath = [IO.Path]::GetFullPath($OutputDirectory)
if (Test-Path -LiteralPath $outPath) {
    throw 'Use a new output directory to preserve previous builds.'
}

& (Join-Path $PSScriptRoot 'Build-Both.ps1') -DevNgRoot $DevNgRoot `
    -SwitchHeaderReference $SwitchHeaderReference `
    -SwitchHeaderReferenceFolder $SwitchHeaderReferenceFolder `
    -OutputDirectory $outPath
if ($LASTEXITCODE -ne 0) { throw "Menu/controller build failed: $LASTEXITCODE" }

$menuPath = Join-Path $outPath 'ragemenu.nsc'
$bindingPath = Join-Path $outPath 'ragemenu.snb'
& $Python $bindingTool --script $menuPath --output $bindingPath 2>&1
if ($LASTEXITCODE -ne 0) { throw "Binding generation failed: $LASTEXITCODE" }
if (-not (Test-Path -LiteralPath $bindingPath -PathType Leaf)) {
    throw 'The matching ragemenu.snb was not produced.'
}
Copy-Item -LiteralPath $bindingTool -Destination (Join-Path $outPath 'native_bindings.py')
Write-Output "BINDING $bindingPath"
Write-Output 'Install ragemenu.nsc and ragemenu.snb together with a matching ScriptHookV-NX runtime.'
$global:LASTEXITCODE = 0
