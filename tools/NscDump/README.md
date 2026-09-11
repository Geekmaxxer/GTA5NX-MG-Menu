# NscDump

`NscDump` is a read-only inspector for the Switch port's `.nsc` script
containers. It is deliberately separate from the game build and never writes
to an RPF or to the source scripts.

Build it from the repository root:

```powershell
dotnet build \NscDump\NscDump.csproj -c Release --no-restore
```

Inspect an extracted script:

```powershell
dotnet run --project \NscDump\NscDump.csproj -c Release --no-build -- path\to\pausemenu.nsc
```

Scan a directory of extracted Switch scripts and get one compact row per file:

```powershell
dotnet run --project \NscDump\NscDump.csproj -c Release --no-build -- --scan-dir path\to\nscs
```

The scan reports each script's code length, native-slot count, total candidate
`CALL_NATIVE` candidates, and candidates whose big-endian slot index is outside
the script's native table. Because this is a linear opcode walk, the latter
column is a warning for follow-up control-flow decoding, not proof of a corrupt
script. It is intended for comparing a complete extraction before editing
anything.

Generate a crossmap-ready database from the same extraction:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --native-db path\to\nscs \switch-native-db.json
```

The JSON records the rotation-decoded 64-bit value, every script/index where it
occurs, and the original stored value. Values found in the bundled PC table are
annotated when available; an absent PC name is expected for port-specific or
newer natives.

Compare a Switch resource against a PC `.ysc`/raw script before attempting a
patch:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --compare-native-tables switch.nsc pc.ysc
```

The report distinguishes PC hashes that match after the Switch rotation from
direct byte-for-byte matches. Only the former are candidates for a translated
native index; an unmatched call still needs a verified Switch equivalent.

The URL form is useful for public reference binaries and does not write them to the repository:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --compare-native-url local-switch.nsc https://example/script.ysc.full
```

Write a reviewable per-index crossmap instead of modifying either input:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --write-crossmap local-switch.nsc pc.ysc \crossmap.json
```

The crossmap decodes the stored rotation on both resources and records the
matching Switch indices, so an unmatched or ambiguous entry can be rejected
before any script or RPF is changed.

For a separate candidate file, copy only the observed Switch header profile to
an output resource:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --adapt-header switch-reference.nsc candidate.ysc output.nsc
```

This changes only the page-base and build-specific header word, writes a new
file, and leaves code, pointers, native entries, and the compiled script name
untouched. It is a preparation/inspection step, not proof that the candidate
will load in-game or a replacement for packing it into `script_rel.rpf`.

Search the extracted resources for references to a script's JOAAT name hash:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --find-script path\to\nscs achievement_controller
```

This is a hint for identifying startup/host relationships; a hash occurrence
alone does not prove that the surrounding code launches the script.

Validate compiled-name invariants before packaging a resource:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --validate-names path\to\script_rel,rpf
```

This checks that each filename matches the internal script name and that the
header's script-name JOAAT matches it. These checks catch the common mistake of
renaming a compiled output after it was built.

Run `--native-db` separately on `script,rpf` and `script_rel,rpf`. They contain
the same filenames but different compiled resources and therefore different
native-index tables. A database from one archive must not be used to patch a
script from the other.

The report includes the tagged resource pointers, code/page sizes, native
slots after the GTA V rotation, and `CALL_NATIVE` sites. The native names are
best-effort lookups against the bundled PC table; a `<unmapped>` result is
expected for hashes changed by the Switch port or by a newer game build.
