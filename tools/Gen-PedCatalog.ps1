<#
.SYNOPSIS
    Generates the PED catalog tables in source\util\util_ped_catalog.sch from
    game metadata instead of hand-typed CASE lines.

.DESCRIPTION
    The Switch menu cannot enumerate peds at runtime: unlike vehicles there is
    no numeric model-count native and no index->model native, and peds have no
    display-name-from-model native either.  (Vehicles can do it because
    GET_NUM_DLC_VEHICLES / GET_DLC_VEHICLE_MODEL /
    GET_DISPLAY_NAME_FROM_VEHICLE_MODEL all exist; the ped equivalents do not.)

    The data-driven equivalent therefore has to happen at build time.  This
    script reads the authoritative model list from the dev_ng enum dump
    (core\game\data\model_enums.sch) and emits the SWITCH tables.

    Every entry in model_enums.sch carries a trailing comment naming the
    metadata file the model came from, which is what makes filtering possible:
        A_F_Y_BEACH_01=-945854168,   // x:/gta5/assets_ng/export/data/peds.pso.meta
    Filtering on the ped metadata files reproduces the catalog exactly, in the
    game's own alphabetical order: peds.pso.meta (683 basegame models) plus the
    seven DLC ped packs (77 more) = 760 entries.

    Only the table region is generated.  The hand-written helpers from
    FIND_PED_CHOICE_BY_NAME onwards are preserved verbatim from the existing
    file, so the include layout and all public function names are unchanged.

.PARAMETER ModelEnums
    Path to model_enums.sch.  Defaults to the workspace dev_ng tree.

.PARAMETER SourceFilter
    Regex tested against the trailing metadata comment of each enum entry.
    Default 'peds(\.pso)?\.meta' = basegame peds.pso.meta (683) plus the seven
    DLC ped packs present in the dump (77 more) = 760 entries.
    Use 'peds\.pso\.meta' to narrow to the basegame-only set (683).

.PARAMETER NameFile
    Alternative source: a plain text file of model names, one per line.
    Lines starting with '#' and blank lines are ignored.

.PARAMETER OutputFile
    The .sch to write (also the file the hand-written tail is read from).

.PARAMETER PageSize
    Entries per generated page.  Must match the dispatch emitted below and the
    compiler's SWITCH block limit; 96 is the verified value.

.PARAMETER ExtractTo
    Dump the current catalog's names to a seed text file and exit.  Use this to
    capture a baseline before regenerating, or to seed -NameFile.

.PARAMETER Verify
    Generate in memory and compare against OutputFile without writing.

.PARAMETER NoProvenance
    Emit the original three-line header instead of the provenance banner, for
    byte-exact comparison against a pre-generator file.

.EXAMPLE
    # Prove the generator reproduces the existing catalog exactly.
    .\Gen-PedCatalog.ps1 -NoProvenance -Verify

.EXAMPLE
    # Capture the current 683 names as a seed file.
    .\Gen-PedCatalog.ps1 -ExtractTo .\ped_catalog_names.txt

.EXAMPLE
    # Regenerate from a hand-edited name list.
    .\Gen-PedCatalog.ps1 -NameFile .\ped_catalog_names.txt
#>
param(
    [string]$ModelEnums = 'X:\gta5\script\dev_ng\core\game\data\model_enums.sch',

    [string]$SourceFilter = 'peds(\.pso)?\.meta',

    [string]$NameFile,

    [string]$OutputFile = (Join-Path $PSScriptRoot '..\source\util\util_ped_catalog.sch'),

    [int]$PageSize = 96,

    [string]$ExtractTo,

    [switch]$Verify,

    [switch]$NoProvenance
)

$ErrorActionPreference = 'Stop'
$OutputFile = [IO.Path]::GetFullPath($OutputFile)
if (-not (Test-Path -LiteralPath $OutputFile)) { throw "OutputFile is missing: $OutputFile" }

# Read raw so the CRLF layout survives a round trip exactly.
$originalText = [IO.File]::ReadAllText($OutputFile)
$originalLines = $originalText -split "`r`n"

# The tail is everything from the first hand-written helper onward.
$tailStart = -1
for ($i = 0; $i -lt $originalLines.Count; $i++) {
    if ($originalLines[$i] -match '^FUNC INT FIND_PED_CHOICE_BY_NAME\(') { $tailStart = $i; break }
}
if ($tailStart -lt 0) { throw "Could not find the FIND_PED_CHOICE_BY_NAME tail marker in $OutputFile" }
[string[]]$tail = $originalLines[$tailStart..($originalLines.Count - 1)]

# --- name sources -----------------------------------------------------------

function Get-CatalogNamesFromSch {
    param([string[]]$Lines)
    $names = New-Object System.Collections.Generic.List[string]
    foreach ($line in $Lines) {
        if ($line -match '^\s+CASE \d+ RETURN "([A-Z0-9_]+)" BREAK$') {
            $names.Add($Matches[1])
        }
    }
    return $names
}

function Get-NamesFromModelEnums {
    param([string]$Path, [string]$Filter)
    if (-not (Test-Path -LiteralPath $Path)) { throw "ModelEnums is missing: $Path" }
    $names = New-Object System.Collections.Generic.List[string]
    foreach ($line in [IO.File]::ReadAllLines($Path)) {
        if ($line -notmatch '^\s*([A-Z0-9_]+)\s*=\s*-?\d+\s*,\s*//\s*(\S.*)$') { continue }
        $name = $Matches[1]
        $comment = $Matches[2]
        if ($comment -notmatch $Filter) { continue }
        if ($name -eq 'DUMMY_MODEL_FOR_SCRIPT') { continue }
        $names.Add($name)
    }
    return $names
}

function Get-NamesFromFile {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) { throw "NameFile is missing: $Path" }
    $names = New-Object System.Collections.Generic.List[string]
    foreach ($line in [IO.File]::ReadAllLines($Path)) {
        $trimmed = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed)) { continue }
        if ($trimmed.StartsWith('#')) { continue }
        $names.Add($trimmed.ToUpperInvariant())
    }
    return $names
}

# -ExtractTo is a one-way dump of what the catalog currently contains.
if (-not [string]::IsNullOrWhiteSpace($ExtractTo)) {
    $current = Get-CatalogNamesFromSch -Lines $originalLines
    $ExtractTo = [IO.Path]::GetFullPath($ExtractTo)
    [IO.File]::WriteAllText($ExtractTo, (($current -join "`r`n") + "`r`n"), (New-Object System.Text.UTF8Encoding($false)))
    Write-Output "EXTRACTED $($current.Count) names -> $ExtractTo"
    return
}

if (-not [string]::IsNullOrWhiteSpace($NameFile)) {
    $names = Get-NamesFromFile -Path ([IO.Path]::GetFullPath($NameFile))
    $sourceLabel = "NameFile $([IO.Path]::GetFileName($NameFile))"
} else {
    $names = Get-NamesFromModelEnums -Path $ModelEnums -Filter $SourceFilter
    $sourceLabel = "ModelEnums $([IO.Path]::GetFileName($ModelEnums)) /$SourceFilter/"
}
$names = @($names)

# --- validation -------------------------------------------------------------

if ($names.Count -eq 0) { throw 'No names were found; refusing to emit an empty catalog.' }
if ($PageSize -le 0) { throw "PageSize must be positive (got $PageSize)." }

$bad = $names | Where-Object { $_ -notmatch '^[A-Z0-9_]+$' }
if ($bad) { throw "Invalid model names (must be [A-Z0-9_]): $($bad -join ', ')" }

# A duplicate CASE label is a compile error, so fail here with a clear message.
$dupGroups = $names | Group-Object | Where-Object { $_.Count -gt 1 }
if ($dupGroups) {
    $dupText = ($dupGroups | ForEach-Object { "$($_.Name) x$($_.Count)" }) -join ', '
    throw "Duplicate model names: $dupText"
}

$count = $names.Count
$pageCount = [math]::Ceiling($count / $PageSize)

# --- emit -------------------------------------------------------------------

$out = New-Object System.Collections.Generic.List[string]

if ($NoProvenance) {
    $out.Add('// Built from the release model catalog.  The compiler limits individual')
    $out.Add("// SWITCH blocks, so the complete $count-ped list is segmented internally while")
    $out.Add('// remaining one continuous scrollable selection in the menu.')
} else {
    $out.Add('// GENERATED FILE - DO NOT HAND-EDIT THE TABLES BELOW.')
    $out.Add('// Regenerate with: tools\Gen-PedCatalog.ps1')
    $out.Add('//')
    $out.Add("// Source: $sourceLabel")
    $out.Add("// Entries: $count over $pageCount page(s) of up to $PageSize.")
    $out.Add('//')
    $out.Add('// The compiler limits individual SWITCH blocks, so the complete list is')
    $out.Add('// segmented internally while remaining one continuous scrollable selection')
    $out.Add('// in the menu.  Names come from the game metadata because the Switch')
    $out.Add('// runtime exposes no ped model-count / index / display-name native.')
    $out.Add('//')
    $out.Add('// Everything from FIND_PED_CHOICE_BY_NAME onward is hand-written and is')
    $out.Add('// preserved verbatim by the generator.')
}

$out.Add('FUNC INT PED_CHOICE_COUNT()')
$out.Add("    RETURN $count")
$out.Add('ENDFUNC')
$out.Add('')

for ($p = 0; $p -lt $pageCount; $p++) {
    $slice = $names[($p * $PageSize)..([math]::Min(($p + 1) * $PageSize - 1, $count - 1))]

    $out.Add("FUNC MODEL_NAMES PED_MODEL_PAGE_$p(INT choice)")
    $out.Add('    SWITCH choice')
    for ($i = 0; $i -lt $slice.Count; $i++) {
        $out.Add("        CASE $i RETURN $($slice[$i]) BREAK")
    }
    $out.Add('    ENDSWITCH')
    $out.Add('    RETURN PLAYER_ZERO')
    $out.Add('ENDFUNC')
    $out.Add('')

    $out.Add("FUNC STRING PED_NAME_PAGE_$p(INT choice)")
    $out.Add('    SWITCH choice')
    for ($i = 0; $i -lt $slice.Count; $i++) {
        $out.Add("        CASE $i RETURN `"$($slice[$i])`" BREAK")
    }
    $out.Add('    ENDSWITCH')
    $out.Add('    RETURN "UNKNOWN_PED"')
    $out.Add('ENDFUNC')
    $out.Add('')
}

$out.Add('FUNC MODEL_NAMES PED_MODEL_FOR_CHOICE(INT choice)')
$out.Add('    IF choice < 0 OR choice >= PED_CHOICE_COUNT() RETURN PLAYER_ZERO ENDIF')
for ($p = 0; $p -lt $pageCount; $p++) {
    $out.Add("    IF choice < $(($p + 1) * $PageSize) RETURN PED_MODEL_PAGE_$p(choice - $($p * $PageSize)) ENDIF")
}
$out.Add('    RETURN PLAYER_ZERO')
$out.Add('ENDFUNC')
$out.Add('')

$out.Add('FUNC STRING PED_NAME_FOR_CHOICE(INT choice)')
$out.Add('    IF choice < 0 OR choice >= PED_CHOICE_COUNT() RETURN "UNKNOWN_PED" ENDIF')
for ($p = 0; $p -lt $pageCount; $p++) {
    $out.Add("    IF choice < $(($p + 1) * $PageSize) RETURN PED_NAME_PAGE_$p(choice - $($p * $PageSize)) ENDIF")
}
$out.Add('    RETURN "UNKNOWN_PED"')
$out.Add('ENDFUNC')
$out.Add('')

$out.AddRange($tail)
$generatedText = ($out -join "`r`n")

# --- verify / write ---------------------------------------------------------

function Get-BodyLines {
    # Drop the leading comment banner so the provenance wording cannot mask a
    # real difference between the existing and generated tables.
    param([string[]]$Lines)
    $i = 0
    while ($i -lt $Lines.Count -and $Lines[$i].StartsWith('//')) { $i++ }
    return ($Lines[$i..($Lines.Count - 1)] -join "`r`n")
}

if ($Verify) {
    $existingBody = Get-BodyLines -Lines $originalLines
    $generatedBody = Get-BodyLines -Lines ($generatedText -split "`r`n")
    if ($existingBody -ceq $generatedBody) {
        Write-Output "VERIFY_MATCH $count names, $pageCount pages (table region identical)"
        if ($originalText -ceq $generatedText) {
            Write-Output 'VERIFY_BYTE_IDENTICAL yes'
        } else {
            Write-Output 'VERIFY_BYTE_IDENTICAL no (header comment differs only)'
        }
    } else {
        $a = $existingBody -split "`r`n"
        $b = $generatedBody -split "`r`n"
        $max = [math]::Max($a.Count, $b.Count)
        $reported = 0
        for ($i = 0; $i -lt $max; $i++) {
            $av = if ($i -lt $a.Count) { $a[$i] } else { '<eof>' }
            $bv = if ($i -lt $b.Count) { $b[$i] } else { '<eof>' }
            if ($av -cne $bv) {
                Write-Output "VERIFY_DIFF line $($i + 1): existing='$av' generated='$bv'"
                $reported++
                if ($reported -ge 10) { break }
            }
        }
        Write-Output "VERIFY_MISMATCH (existing lines=$($a.Count), generated lines=$($b.Count))"
        exit 1
    }
    return
}

[IO.File]::WriteAllText($OutputFile, $generatedText, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "WROTE $OutputFile"
Write-Output "PED_COUNT $count"
Write-Output "PED_PAGES $pageCount (page size $PageSize)"
Write-Output "SOURCE $sourceLabel"