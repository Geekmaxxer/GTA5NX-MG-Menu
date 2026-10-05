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
$originalText = $null
$originalLines = @()
if (Test-Path -LiteralPath $OutputFile) {
    $originalText = [IO.File]::ReadAllText($OutputFile)
    $originalLines = $originalText -split "`r`n"
}

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
if ($names.Count -eq 0) { throw 'No names were found; refusing to emit an empty catalog.' }
if ($PageSize -le 0) { throw "PageSize must be positive (got $PageSize)." }
$bad = $names | Where-Object { $_ -notmatch '^[A-Z0-9_]+$' }
if ($bad) { throw "Invalid model names (must be [A-Z0-9_]): $($bad -join ', ')" }
$dupGroups = $names | Group-Object | Where-Object { $_.Count -gt 1 }
if ($dupGroups) {
    $dupText = ($dupGroups | ForEach-Object { "$($_.Name) x$($_.Count)" }) -join ', '
    throw "Duplicate model names: $dupText"
}
if ($names -notcontains $FallbackModel) {
    throw "FallbackModel '$FallbackModel' is not in the generated set. Pass -FallbackModel with a name from the list (see -ExtractTo)."
}
$count = $names.Count
$pageCount = [math]::Ceiling($count / $PageSize)
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
function Get-BodyLines {
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