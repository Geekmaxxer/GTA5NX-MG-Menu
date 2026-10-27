# NscDump

`NscDump` is a read-only inspector for the Switch port's `.nsc` script
containers. It is deliberately separate from the game build and never writes
to an RPF or to the source scripts.

Container decoding, header field access and the compiled-name checks live in
`tools\NscCore`, which is shared with `NscAdapter`. Both tools therefore read the
RSC7 envelope and the header exactly the same way, including the fact that there
is no compression flag inside the envelope (see `docs\DEVELOPING.md`).

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

Copy only the observed Switch header profile onto a candidate, writing a new file:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --adapt-header switch-reference.nsc candidate.nsc output.nsc
```

The reference may be a single `.nsc` or a stock folder (a folder resolves to
`achievement_controller.nsc`, else the first `.nsc`).

Exactly two header fields are copied: the 8-byte page base at `0x00` and the
4-byte build word at `0x18`. Code, pointers, native entries and the compiled
script name are untouched, and every differing offset is verified to lie inside
those two regions before anything is written.

The default output is a **bare payload**, which is the form `script_rel.rpf`
accepts as a file entry. `--container` instead re-prepends the candidate's RSC7
envelope; that form is *not* installable and exists only to reproduce the older
behaviour - ten `out-*` directories contain `.nsc` files that were adapted
correctly but were still envelope-wrapped, and so could never be installed.
`--dry-run` verifies and reports without writing. This is a preparation step, not
proof that the candidate will load in-game, and not a replacement for packing it
into `script_rel.rpf`.

Search the extracted resources for references to a script's JOAAT name hash:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --find-script path\to\nscs achievement_controller
```

This is a hint for identifying startup/host relationships; a hash occurrence
alone does not prove that the surrounding code launches the script.

Validate compiled-name invariants before packaging a resource:

```powershell
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --validate-names path\to\script_rel.rpf
dotnet run --project analysis\NscDump\NscDump.csproj -c Release --no-build -- --validate-names path\to\ragemenu.nsc
```

Both a directory and a single file are accepted. This checks that each filename
matches the internal script name and that the header's script-name JOAAT matches
it, catching the common mistake of renaming a compiled output after it was built.
A `*.pc.nsc` is flagged by design, because its entry name would be `<Name>.pc`.
Files that cannot be decoded are reported as `ERROR` lines rather than aborting
the run.

Run `--native-db` separately on `script,rpf` and `script_rel,rpf`. They contain
the same filenames but different compiled resources and therefore different
native-index tables. A database from one archive must not be used to patch a
script from the other.

The report includes the tagged resource pointers, code/page sizes, native
slots after the GTA V rotation, and `CALL_NATIVE` sites. The native names are
best-effort lookups against the bundled PC table; a `<unmapped>` result is
expected for hashes changed by the Switch port or by a newer game build.
