param(
    [Parameter(Mandatory=$true)][string]$InputZip,
    [Parameter(Mandatory=$true)][string]$OutputZip,
    [string]$InstallGuide
)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression
$inputFile=(Resolve-Path -LiteralPath $InputZip).ProviderPath
$outputFile=[IO.Path]::GetFullPath($OutputZip)
if ($inputFile -eq $outputFile -or (Test-Path -LiteralPath $outputFile)) { throw 'Select a new output ZIP.' }
$distribution=Join-Path (Split-Path $PSScriptRoot -Parent) 'distribution'
$relative='atmosphere/contents/0100b00b51230000/exefs/main.npdm'
$expected='db97307619f2dd536f06c38703721e6164470742a81522edfb273778937e650f'
if ((Get-FileHash -LiteralPath (Join-Path $distribution $relative) -Algorithm SHA256).Hash -ne $expected) { throw 'Shared NPDM checksum failed.' }
[void](New-Item -ItemType Directory -Path ([IO.Path]::GetDirectoryName($outputFile)) -Force)
Copy-Item -LiteralPath $inputFile -Destination $outputFile
$zip=[IO.Compression.ZipFile]::Open($outputFile,[IO.Compression.ZipArchiveMode]::Update)
try {
    $files=,@((Join-Path $distribution $relative),$relative)
    foreach($name in @('Install-SD-Access.ps1','Install-SD-Access.cmd','SD-ACCESS.md')) { $files+=,@((Join-Path $distribution $name),$name) }
    if($InstallGuide) { $files+=,@((Resolve-Path -LiteralPath $InstallGuide).ProviderPath,'how to install.txt') }
    foreach($pair in $files) {
        $entry=$zip.GetEntry($pair[1])
        if($entry) {
            if($pair[1] -eq $relative) {
                $stream=$entry.Open();$hasher=[Security.Cryptography.SHA256]::Create()
                try { $hash=[BitConverter]::ToString($hasher.ComputeHash($stream)).Replace('-','').ToLowerInvariant() }
                finally { $stream.Dispose();$hasher.Dispose() }
                if($hash -ne $expected) { throw 'Archive has a different NPDM; preserve and patch its custom metadata first.' }
            }
            $entry.Delete()
        }
        [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,$pair[0],$pair[1],[IO.Compression.CompressionLevel]::Optimal)
    }
} finally { $zip.Dispose() }
$read=[IO.Compression.ZipFile]::OpenRead($outputFile)
try {
    $entry=$read.GetEntry($relative);if(-not $entry) { throw 'Packaged NPDM is missing.' }
    $stream=$entry.Open();$hasher=[Security.Cryptography.SHA256]::Create()
    try { $actual=[BitConverter]::ToString($hasher.ComputeHash($stream)).Replace('-','').ToLowerInvariant() }
    finally { $stream.Dispose();$hasher.Dispose() }
    if($actual -ne $expected) { throw 'Packaged NPDM readback failed.' }
} finally { $read.Dispose() }
Write-Host ('Verified SD-access package: '+$outputFile)
