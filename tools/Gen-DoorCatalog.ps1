<#
.SYNOPSIS
    Generates the door/gate model catalog in source\util\util_door_catalog.sch
    from game metadata.

.DESCRIPTION
    The "Open Closest Door" row in the World and Weather tab needs a list of
    door-capable models.  There is no runtime native that enumerates doors: the
    complete door API works from a MODEL plus a POSITION
    (GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE to find, then
    SET_STATE_OF_CLOSEST_DOOR_OF_TYPE / DOOR_SYSTEM_* to open), so the model set
    has to be known at build time.

    Like the ped catalog, this reads the authoritative model list from the
    dev_ng enum dump (core\game\data\model_enums.sch), where every entry carries
    a trailing comment naming the metadata file it came from.  Names are
    selected by -NameFilter rather than by metadata file, because door props are
    spread across many level metadata files (v_lev_doors.xml, int_lev_des.xml,
    the v_fences packs, int_mp_doors.xml, ...) with no single pack to key on.

    -ExcludeFilter then removes everything that matched on name alone but is not
    an openable door: LOD/HIP variants ('..._L1', '..._FRAME'), gate posts
    ('GATEPOST'), signs, glass panels, frames, bell buttons and so on.  Those are
    parts of or decorations on a door rather than the door itself, and the search
    native cannot open them.

    Unlike Gen-PedCatalog.ps1 there is no hand-written tail: this file is
    entirely generated, so the generator can create it from nothing.

.PARAMETER ModelEnums
    Path to model_enums.sch.  Defaults to the workspace dev_ng tree.

.PARAMETER NameFilter
    Regex tested against each enum entry's model name.  Default matches
    DOOR|GATE|GARAGE|SHUTTER|BARRIER.

.PARAMETER ExcludeFilter
    Regex of model names to drop from -NameFilter's matches.  Default removes
    LOD/HIP suffixes and non-door parts (FRAME|POST|HINGE|HANDLE|BELL|KNOB|
    PLATE|SIGN|GLASS|LIGHT|LAMP|BUZZER|MARKER|_LOCK|_LID|WINCH|RAILING|TRIM|
    COLLISION|CRASH|PLUG).

.PARAMETER FallbackModel
    Model name returned by every accessor's out-of-range path.  Must be a member
    of the generated list; the generator refuses to emit a file that references a
    name the final set does not contain.

.PARAMETER NameFile
    Alternative source: a plain text file of model names, one per line.  Lines
    starting with '#' and blank lines are ignored.  -ExcludeFilter is not applied.

.PARAMETER OutputFile
    The .sch to write.

.PARAMETER PageSize
    Entries per generated SWITCH page.  Must stay within the compiler's SWITCH
    block limit; 96 is the value verified by the ped catalog.

.PARAMETER ExtractTo
    Dump the current catalog's model names to a seed text file and exit.

.PARAMETER Verify
    Generate in memory and compare against OutputFile without writing.

.PARAMETER NoProvenance
    Emit a short fixed banner instead of the full provenance banner.

.EXAMPLE
    # Prove the generator reproduces the committed catalog exactly.
    .\Gen-DoorCatalog.ps1 -Verify

.EXAMPLE
    # Regenerate from the model metadata.
    .\Gen-DoorCatalog.ps1

.EXAMPLE
    # Capture the current list as a seed file.
    .\Gen-DoorCatalog.ps1 -ExtractTo .\door_catalog_names.txt
#>
param(
    [string]$ModelEnums = 'X:\gta5\script\dev_ng\core\game\data\model_enums.sch',

    [string]$NameFilter = 'DOOR|GATE|GARAGE|SHUTTER|BARRIER',

    [string]$ExcludeFilter = '_L1$|_L2$|_LD$|_LOD$|_SLOD$|_HIP$|FRAME|POST|HINGE|HANDLE|BELL|KNOB|PLATE|SIGN|GLASS|LIGHT|LAMP|BUZZER|MARKER|_LOCK|_LID|WINCH|RAILING|TRIM|COLLISION|CRASH|PLUG',

    [string]$FallbackModel = 'PROP_DOOR_01',

    [string]$NameFile,

    [string]$OutputFile = (Join-Path $PSScriptRoot '..\source\util\util_door_catalog.sch'),

    [int]$PageSize = 96,

    [string]$ExtractTo,

    [switch]$Verify,

    [switch]$NoProvenance
)

$ErrorActionPreference = 'Stop'
$OutputFile = [IO.Path]::GetFullPath($OutputFile)

# The output file is optional on first generation; -Verify and -ExtractTo are
# the only modes that require it to already exist.
$originalText = $null
$originalLines = @()
if (Test-Path -LiteralPath $OutputFile) {
    $originalText = [IO.File]::ReadAllText($OutputFile)
    $originalLines = $originalText -split "`r`n"
}

# --- name sources -----------------------------------------------------------

function Get-CatalogNamesFromSch {
    param([string[]]$Lines)
    $names = New-Object System.Collections.Generic.List[string]
    foreach ($line in $Lines) {
        if ($line -match '^\s+CASE \d+ RETURN ([A-Z0-9_]+) BREAK$') {
            $names.Add($Matches[1])
        }
    }
    return $names
}

function Get-NamesFromModelEnums {
    param([string]$Path, [string]$Include, [string]$Exclude)
    if (-not (Test-Path -LiteralPath $Path)) { throw "ModelEnums is missing: $Path" }
    $names = New-Object System.Collections.Generic.List[string]
    $matched = 0
    foreach ($line in [IO.File]::ReadAllLines($Path)) {
        if ($line -notmatch '^\s*([A-Z0-9_]+)\s*=\s*-?\d+\s*,\s*//\s*(\S.*)$') { continue }
        $name = $Matches[1]
        if ($name -eq 'DUMMY_MODEL_FOR_SCRIPT') { continue }
        if ($name -notmatch $Include) { continue }
        $matched++
        if ($name -match $Exclude) { continue }
        $names.Add($name)
    }
    return @{ Names = $names; Matched = $matched }
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
    if (-not $originalText) { throw "OutputFile does not exist yet, so there is nothing to extract: $OutputFile" }
    $current = Get-CatalogNamesFromSch -Lines $originalLines
    $ExtractTo = [IO.Path]::GetFullPath($ExtractTo)
    [IO.File]::WriteAllText($ExtractTo, (($current -join "`r`n") + "`r`n"), (New-Object System.Text.UTF8Encoding($false)))
    Write-Output "EXTRACTED $($current.Count) names -> $ExtractTo"
    return
}

$matchedCount = 0
if (-not [string]::IsNullOrWhiteSpace($NameFile)) {
    $names = Get-NamesFromFile -Path ([IO.Path]::GetFullPath($NameFile))
    $sourceLabel = "NameFile $([IO.Path]::GetFileName($NameFile))"
} else {
    $result = Get-NamesFromModelEnums -Path $ModelEnums -Include $NameFilter -Exclude $ExcludeFilter
    $names = $result.Names
    $matchedCount = $result.Matched
    $sourceLabel = "ModelEnums $([IO.Path]::GetFileName($ModelEnums)) /$NameFilter/ minus /$ExcludeFilter/"
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

# The fallback is what every out-of-range path returns, so it has to be a name
# the emitted tables actually contain.  Refuse to emit a file that could hand an
# undeclared identifier to the compiler.
if ($names -notcontains $FallbackModel) {
    throw "FallbackModel '$FallbackModel' is not in the generated set. Pass -FallbackModel with a name from the list (see -ExtractTo)."
}

$count = $names.Count
$pageCount = [math]::Ceiling($count / $PageSize)

# --- emit -------------------------------------------------------------------

$out = New-Object System.Collections.Generic.List[string]

if ($NoProvenance) {
    $out.Add('// Built from the release model catalog.  The compiler limits individual')
    $out.Add("// SWITCH blocks, so the complete $count-model door list is segmented internally")
    $out.Add('// while remaining one contiguous scan.')
} else {
    $out.Add('// GENERATED FILE - DO NOT HAND-EDIT THE TABLES BELOW.')
    $out.Add('// Regenerate with: tools\Gen-DoorCatalog.ps1')
    $out.Add('//')
    $out.Add("// Source: $sourceLabel")
    $out.Add("// Entries: $count over $pageCount page(s) of up to $PageSize.")
    $out.Add('//')
    $out.Add('// Model names come from the game metadata because there is no door')
    $out.Add('// enumeration native: the door API takes a model plus a position.')
    $out.Add('//')
    $out.Add('// The compiler limits individual SWITCH blocks, so the complete list is')
    $out.Add("// segmented internally while remaining one contiguous scan of $count models.")
    $out.Add('//')
    $out.Add('// DOOR_MODEL_FOR_CHOICE() is the only entry point callers need; it maps a flat')
    $out.Add('// index to the model and hides the paging entirely.')
}

$out.Add('FUNC INT DOOR_MODEL_COUNT()')
$out.Add("    RETURN $count")
$out.Add('ENDFUNC')
$out.Add('')

for ($p = 0; $p -lt $pageCount; $p++) {
    $slice = $names[($p * $PageSize)..([math]::Min(($p + 1) * $PageSize - 1, $count - 1))]

    $out.Add("FUNC MODEL_NAMES DOOR_MODEL_PAGE_$p(INT choice)")
    $out.Add('    SWITCH choice')
    for ($i = 0; $i -lt $slice.Count; $i++) {
        $out.Add("        CASE $i RETURN $($slice[$i]) BREAK")
    }
    $out.Add('    ENDSWITCH')
    $out.Add("    RETURN $FallbackModel")
    $out.Add('ENDFUNC')
    $out.Add('')
}

$out.Add('FUNC MODEL_NAMES DOOR_MODEL_FOR_CHOICE(INT choice)')
$out.Add("    IF choice < 0 OR choice >= DOOR_MODEL_COUNT() RETURN $FallbackModel ENDIF")
for ($p = 0; $p -lt $pageCount; $p++) {
    $out.Add("    IF choice < $(($p + 1) * $PageSize) RETURN DOOR_MODEL_PAGE_$p(choice - $($p * $PageSize)) ENDIF")
}
$out.Add("    RETURN $FallbackModel")
$out.Add('ENDFUNC')
$out.Add('')

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
    if (-not $originalText) { throw "OutputFile does not exist, so there is nothing to verify against: $OutputFile" }
    $existingBody = Get-BodyLines -Lines $originalLines
    $generatedBody = Get-BodyLines -Lines ($generatedText -split "`r`n")
    if ($existingBody -ceq $generatedBody) {
        Write-Output "VERIFY_MATCH $count models, $pageCount pages (table region identical)"
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
Write-Output "DOOR_COUNT $count"
Write-Output "DOOR_PAGES $pageCount (page size $PageSize)"
if ($matchedCount -gt 0) { Write-Output "NAME_FILTER_MATCHED $matchedCount (before exclusion)" }
Write-Output "FALLBACK $FallbackModel"
Write-Output "SOURCE $sourceLabel"