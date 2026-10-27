<#
.SYNOPSIS
    Generates the 1,026 stock .nsc exclusion filter and custom .nsc candidate
    table in source\util\util_nsc_loader.sch.

.DESCRIPTION
    Scans the reference stock script directory:
        C:\Users\Megatard\Desktop\switchgta5\stock nsc's for cross-reference\script_rel.rpf
    to build a complete 1,026-entry stock .nsc hash filter (segmented into
    SWITCH pages of 90 cases to stay well within sc.exe's per-SWITCH limit),
    explicitly excludes ragemenu.nsc, and scans target script directories for
    any non-stock custom .nsc files.

    Everything from '// --- BEGIN HAND-WRITTEN NSC LOADER LOGIC ---' onward in
    source\util\util_nsc_loader.sch is preserved verbatim when regenerating.
#>
param(
    [string]$StockNscDirectory = "C:\Users\Megatard\Desktop\switchgta5\stock nsc's for cross-reference\script_rel.rpf",
    [string[]]$ScanDirectories = @(),
    [string]$OutputFile = (Join-Path $PSScriptRoot "..\source\util\util_nsc_loader.sch"),
    [int]$PageSize = 90
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $StockNscDirectory)) {
    throw "Stock NSC reference directory not found: $StockNscDirectory"
}

$stockFiles = Get-ChildItem -LiteralPath $StockNscDirectory -Filter "*.nsc" | Sort-Object Name
$stockNames = [System.Collections.Generic.List[string]]::new()
$stockSet = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

foreach ($f in $stockFiles) {
    $base = $f.BaseName.ToLowerInvariant()
    if ($stockSet.Add($base)) {
        $stockNames.Add($base)
    }
}

# Core menu script names to always ignore alongside the 1,026 stock .nsc files
$marker = "// --- BEGIN HAND-WRITTEN NSC LOADER LOGIC ---"
$handWrittenTail = ""
if (Test-Path -LiteralPath $OutputFile) {
    $existingContent = Get-Content -LiteralPath $OutputFile -Raw
    $markerIdx = $existingContent.IndexOf($marker)
    if ($markerIdx -ge 0) {
        $handWrittenTail = $existingContent.Substring($markerIdx)
    }
}

$sb = [System.Text.StringBuilder]::new()
$pageCount = [Math]::Ceiling($stockNames.Count / [double]$PageSize)

[void]$sb.AppendLine("// GENERATED HEADER SECTION - DO NOT HAND-EDIT ABOVE THE MARKER.")
[void]$sb.AppendLine("// Regenerate with: tools\Gen-CustomNscCatalog.ps1")
[void]$sb.AppendLine("//")
[void]$sb.AppendLine("// Stock reference baseline: C:\Users\Megatard\Desktop\switchgta5\stock nsc's for cross-reference\script_rel.rpf")
[void]$sb.AppendLine("// Stock .nsc count: $($stockNames.Count) across $pageCount SWITCH page(s) of up to $PageSize.")
[void]$sb.AppendLine("// Explicitly ignores all $($stockNames.Count) stock .nsc files and ragemenu.nsc.")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("FUNC INT STOCK_NSC_BASELINE_COUNT()")
[void]$sb.AppendLine("    RETURN $($stockNames.Count)")
[void]$sb.AppendLine("ENDFUNC")
[void]$sb.AppendLine("")

for ($p = 0; $p -lt $pageCount; $p++) {
    $start = $p * $PageSize
    $end = [Math]::Min($start + $PageSize, $stockNames.Count)
    [void]$sb.AppendLine("FUNC BOOL IS_STOCK_NSC_HASH_PAGE_$p(INT scriptHash)")
    [void]$sb.AppendLine("    SWITCH scriptHash")
    for ($i = $start; $i -lt $end; $i++) {
        $name = $stockNames[$i]
        [void]$sb.AppendLine("        CASE HASH(""$name"") RETURN TRUE BREAK")
    }
    [void]$sb.AppendLine("    ENDSWITCH")
    [void]$sb.AppendLine("    RETURN FALSE")
    [void]$sb.AppendLine("ENDFUNC")
    [void]$sb.AppendLine("")
}

[void]$sb.AppendLine("// Returns TRUE if scriptHash belongs to ragemenu.nsc or any of the $($stockNames.Count) stock")
[void]$sb.AppendLine("// base-game .nsc scripts in update.rpf/switch/level/gta/script (script_rel.rpf).")
[void]$sb.AppendLine("FUNC BOOL IS_STOCK_OR_CORE_NSC_HASH(INT scriptHash)")
[void]$sb.AppendLine("    IF scriptHash = 0 RETURN TRUE ENDIF")
[void]$sb.AppendLine("    IF scriptHash = HASH(""ragemenu"") RETURN TRUE ENDIF")
[void]$sb.AppendLine("    IF scriptHash = HASH(""ragemenu.nsc"") RETURN TRUE ENDIF")
[void]$sb.AppendLine("    IF scriptHash = HASH(""ragemenu.pc"") RETURN TRUE ENDIF")
for ($p = 0; $p -lt $pageCount; $p++) {
    [void]$sb.AppendLine("    IF IS_STOCK_NSC_HASH_PAGE_$p(scriptHash) RETURN TRUE ENDIF")
}
[void]$sb.AppendLine("    RETURN FALSE")
[void]$sb.AppendLine("ENDFUNC")
[void]$sb.AppendLine("")

if (-not [string]::IsNullOrEmpty($handWrittenTail)) {
    [void]$sb.Append($handWrittenTail)
} else {
    [void]$sb.AppendLine($marker)
}

[System.IO.File]::WriteAllText($OutputFile, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Output "Generated $OutputFile with $($stockNames.Count) stock exclusions."
