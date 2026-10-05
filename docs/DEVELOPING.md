# Developing safely

## Before editing

Keep three separate files:

1. The untouched game `update2.rpf`.
2. Your last hardware-tested working copy.
3. A new output copy for the current experiment.

Never edit the only working archive in place. Use `.nsc` reference(s) exported
from the exact target build. The stock folder
`stock nsc's for cross-reference\script_rel.rpf` (1026 files) is the current
verified source; `script.rpf` (1026 files) is a separate archive with different
compiled resources and native-index tables, so never mix their references or
databases.

## Header references (verified)

- Every verified stock `script_rel.rpf` script shares the same adapter profile:
  page-base `0x00007FF7BAD5B3A8`, word@0x18 `0x94C75B53`. New builds should use
  this profile so the header bytes are traceable to the target build. It is
  pinned as `NscProfiles.Stock` in `tools\NscCore\NscProfiles.cs`.
- `script.rpf` holds the same filenames but is a **different archive with a
  different profile** (measured on `achievement_controller.nsc`:
  `0x00007FF68FC2B3A8` / `0xFEA8BE0E`, 131072 bytes inflated vs 81920). NscAdapter
  warns when a reference matches no known profile, so a wrong-archive reference
  is caught instead of silently supplying header bytes.
- The older working ragemenu builds (`out-batch32b`, v0.9.2 release) carry the
  legacy profile `0x00007FF6619AB3A8 / 0x00000000` because they were adapted with
  the old `out-current-task-final\ragemenu.nsc` reference. Recorded as
  `legacy-adapted`; it still loads, but NscAdapter warns about it.
- `ragemenu.nsc` exists only in our builds; the stock extraction has no
  ragemenu.nsc (confirmed by `--find-script ... ragemenu` = 0 matches), so
  folder mode falls back to `achievement_controller.nsc`.
- `achievement_controller.nsc` is referenced by `freemode.nsc`, i.e. it is a real
  hosted stock script, which is why it is the preferred stable fallback.
- Rule: `-SwitchHeaderReference <single .nsc>` for exact work (must be the same
  build); `-SwitchHeaderReferenceFolder <stock folder>` for convenience.
- Folder resolution is implemented once, in `NscCore.NscReferenceResolver`, and
  both NscAdapter and the build scripts use it: `<folder>\<Name>.nsc` first (when
  `--name <Name>` is supplied), else `achievement_controller.nsc`, else the
  ordinal-first `.nsc`. Before this was unified, `Build-Any.ps1` and NscAdapter
  could select **different** files from the same folder - a real hazard, since
  `out-both-v2` and `out-both-v3` contain both scripts side by side.
- Folder reference does NOT validate compatibility: different builds/regions can
  share the 8+4 profile bytes while differing elsewhere, so folder mode still
  requires `--validate-names` + native checks + hardware testing.

## Native calls

`ragemenu.sc` names natives from the Rockstar `dev_ng` headers. The compiler
records them in the script's native table. The Switch port must recognize every
compiled native hash. If you add a native that is absent or mapped differently
in the target port, the game may fail to load or crash at the call site.

Keep a native-table report from stock scripts in the target `script_rel.rpf`
and compare every newly compiled script before putting it in an RPF. This SDK
does not pretend that PC and Switch native tables are universally identical.

Verified checks (run from the workspace root, `c:\Users\Megatard\Desktop\switchgta5`):

```powershell
# One-row summary per file (a single .nsc path also works, not just folders).
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --scan-dir "MG-SwitchMenu SDK\out-batch32b-pedselect-world-v1-20260924"
# batch32b: ragemenu.nsc 116980 / 319 / 1689 calls / 7 out-of-range (linear-walk
# warnings only, not corruption); identical row for ragemenu.pc.nsc.

# Compiled-name invariant: only *.pc.nsc should mismatch (internal name stays
# <Name>, e.g. ragemenu/achievement_controller). Stock script_rel.rpf = 1020/1020 clean.
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --validate-names "MG-SwitchMenu SDK\out-<batch>"
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --validate-names "stock nsc's for cross-reference\script_rel.rpf"

# Self-compare: adapted output vs its own Win64 intermediate must be 319/319
# (rotation + direct) - proves the adapter preserved code/natives.
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --compare-native-tables "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc" "MG-SwitchMenu SDK\out-<batch>\ragemenu.pc.nsc"

# Folder coverage: every decoded native in the candidate exists somewhere in
# stock script_rel.rpf (batch32b ragemenu: 319/319, 0 unmatched, 1020 scripts).
# This is union coverage, not per-script index proof - keep the self-compare too.
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --compare-native-tables "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc" "stock nsc's for cross-reference\script_rel.rpf"
```

`--native-db` must be run separately per archive; `script.rpf` and
`script_rel.rpf` hold the same filenames but different compiled resources.

## Container decoding (measured - do not re-guess)

There is **no compression flag** inside the RSC7 envelope. This was measured:

- Across the RSC7 files in both stock folders, byte@0x08 takes 19 distinct values
  (`00 01 02 03 04 10 11 12 20 21 22 23 24 31 80 81 82 83 A2`) and does not
  correlate with compression. `0x80` appears on a **deflate** stock entry
  (`achievement_controller.nsc`) *and* on our own **uncompressed** scriptrc output.
- u32@0x04 is `0x0C` and u32@0x0C is `0xC0000000` for every stock file; neither
  distinguishes compression.
- The old `IsUncompressedResource` heuristic (u64@16 inside the `0x7...` page-base
  band) matched **0 of 2044** stock files. It returned "deflate" for every stock
  entry only because deflate data never happens to look like a page base, so it
  was right by accident - and it would have been wrong for any stripped payload.

`NscCore.NscContainer` therefore decodes by trial and then *verifies*:

1. no RSC7 magic at offset 0 -> the file is already a payload;
2. RSC7 and the payload region is page-base shaped **and** self-consistent (the
   internal name hashes to the stored name hash) -> uncompressed;
3. RSC7 and the region inflates to a page-base-shaped payload -> deflate;
4. otherwise fail with a message naming both attempts.

Inflation is capped at 64 MiB so a malformed container cannot balloon.

Two related facts worth keeping:

- Our `.pc.nsc` payload region is **raw, not deflate** (`scriptrc
  -uncompressedresources`). Inflating it throws `Block length does not match with
  its complement`, which is exactly why "try deflate" must be able to fall back to
  raw rather than assume the region is compressed.
- An adapted `.nsc` must be a **bare payload with no RSC7 envelope**: that is the
  form `script_rel.rpf` accepts as a file entry. Ten older `out-*` directories
  contain `.nsc` files that still carry the envelope, because
  `NscDump --adapt-header` used to re-prepend it. Both tools now emit a bare
  payload by default (`NscDump` keeps `--container` as an explicit opt-in), and
  `NscAdapter --info` reports `BARE_PAYLOAD yes/no` with a note when an envelope is
  present.

### What the adapter writes

Exactly 12 bytes are written: the 8-byte page base at `0x00` and the 4-byte build
word at `0x18`, copied from the reference. On a real build only **6** byte
*values* change (`0x02,0x03,0x18,0x19,0x1A,0x1B`), because 6 of the 12 copied
bytes were already equal. After writing, `NscAdapt.Verify` proves: lengths are
equal, every differing offset lies within `{0x00-0x07} ∪ {0x18-0x1B}`, those bytes
equal the reference's, and the header reads back as the reference profile.
NscAdapter prints the before/after page base and build word plus the changed
offsets, and writes atomically (temp file, read back, then move) so a failed write
can never leave a truncated `.nsc` where a good one was.

Adapter exit codes: `0` ok, `2` usage, `3` bad reference, `4` bad candidate,
`5` verification failed, `6` write failed.

## Script-container pipeline

```text
ragemenu.scd
  -> sc.exe
ragemenu.sco
  -> scriptrc_x64.exe -uncompressedresources -aeskey gta5
ragemenu.pc.nsc (RSC7 wrapper + raw script payload)
  -> NscAdapter with same-build stock header reference

ragemenu.nsc
  -> Switch header-patched nsc via NSCAdapater

> Copy to -> `script_rel.rpf` / update2.rpf/switch/levels/gta5/script/script_rel.rpf
```

```text
achievement_controller.scd
  -> sc.exe 
achievement_controller.sco
  -> scriptrc_x64.exe -uncompressedresources -aeskey gta5
achievement_controller.pc.nsc (RSC7 wrapper + raw script payload)
  -> NscAdapter with same-build stock header reference

achievement_controller.nsc
  -> Switch header-patched nsc via NSCAdapter

> Replace existing file in -> `script_rel.rpf` / update2.rpf/switch/levels/gta5/script/script_rel.rpf
```

Build entry points (`tools\`; all accept `-SwitchHeaderReference <file>` or
`-SwitchHeaderReferenceFolder <stock folder>`, plus `BUILD_SECONDS` timing):

All four build scripts are now **thin wrappers**. The engine lives once, in
`tools\BuildCommon.ps1` (`Invoke-BuildSet`), and the container/header logic lives
once, in `tools\NscCore\`. Each wrapper is 26-30 lines and only supplies defaults.

- `Build-Any.ps1 -Source <any .sc>`: the engine entry point. `-Source` is
  `[string[]]`, so several scripts can be built in one call.
- `Build-Menu.ps1` (default `source\ragemenu.sc`) and `Build-Controller.ps1`
  (default `source\achievement_controller.sc`): thin wrappers.
- `Build-Both.ps1`: builds both scripts into one output dir with one shared
  snapshot.

What the engine guarantees, per compiled script:

- **The output name is derived from `-Source`.** `Build-Menu.ps1 -Source foo.sc`
  produces `foo.sco` / `foo.pc.nsc` / `foo.nsc` / `foo.build.json` and snapshots
  `foo.sc`. It no longer silently writes `ragemenu.*`, which is what the old
  fixed-name wrappers did.
- **The snapshot contains only what was compiled**: the entry point(s) plus the
  `.sch` tree. The old wrappers also copied the *other* script into the output
  dir, producing snapshots containing a file that was never built.
- **The reference is resolved by NscAdapter** (`--name <Name>`), so the build
  scripts never duplicate the resolution rule.
- **`--validate` runs on the produced file**, so a name mismatch fails the build
  instead of reaching an RPF.
- **A `<Name>.build.json` manifest is written** next to the build. See below.
- `-DryRun` verifies and reports without writing the `.nsc`.

`BUILD_SECONDS` and `BUILD`/`INTERMEDIATE`/`MANIFEST` lines go to stdout; the
provenance warnings from NscAdapter go to stderr. All native invocations in the
engine use `2>&1`, because PowerShell 5.1 turns a native process's stderr into an
ErrorRecord and `$ErrorActionPreference='Stop'` would otherwise abort a build on a
benign warning. A successful run ends with `$LASTEXITCODE = 0`.

### Build manifest (`<Name>.build.json`)

Written by `Write-BuildManifest` for every compiled script. It records:

- SHA256 of every source file that took part (entry point + each `.sch`);
- SHA256 of the `.sco`, the `.pc.nsc` and the installable `.nsc`;
- the reference that was actually used (including which file a folder resolved
  to) and its SHA256;
- the payload header fields read back from the produced `.nsc` via
  `NscAdapter --info`: page base, build word, code length, statics, natives,
  internal name, name-hash match, profile, and `barePayload`;
- SHA256 of `sc.exe` and `scriptrc_x64.exe`, the `dotnet --version`, and the
  DEV toolchain root;
- `gitCommit` (null when there is no repository, with a stated reason);
- four status flags: `compiled`, `headerAdapted`, `packaged`, `runtimeVerified`.

`packaged` and `runtimeVerified` are always written `false`. They are never set
by a script: they are set by hand only after an RPF build and an on-hardware test.
That is deliberate - it keeps "compiled" from ever being mistaken for "runs on
hardware". Note the `.pc.nsc` hash is **not** reproducible across runs (it embeds
the run-specific Win64 page base), whereas the `.sco` and the adapted `.nsc` are;
pin builds by the `.nsc` hash.

Tools (`tools\`): `NscCore` (shared library), `NscAdapter` (exe), `NscDump` (exe),
`NscTests` (xunit), plus `SwitchMenuTools.slnx` and `global.json` (pins SDK
`10.0.401`, `rollForward: latestFeature`). Build and test the toolchain with:

```powershell
dotnet build "MG-SwitchMenu SDK\tools\SwitchMenuTools.slnx" -c Release
dotnet test  "MG-SwitchMenu SDK\tools\NscTests\NscTests.csproj" -c Release
```

`NscTests` is the only part of the SDK that can be tested without any Rockstar
files: the container format is known well enough to synthesise valid payloads and
RSC7 envelopes. It also contains end-to-end tests that run against the real build
and stock extraction when those are present (they return early when absent), so a
change to the decoder is checked against the published
`ragemenu.nsc` SHA256 (`1E00104C50D2867878B5394DD50A44CD3E4B9A6B8E33BB68610C388A7C78178F`).

- `Gen-PedCatalog.ps1` (not a build entry point): regenerates the PED catalog
  tables. See "PED catalog generation" below.
- `Gen-DoorCatalog.ps1` (not a build entry point): regenerates the door/gate model
  catalog behind World and Weather > Open Closest Door. See "Door catalog
  generation" below.

### PED catalog generation

The Switch runtime cannot enumerate peds. It has no ped model-count native, no
index-to-model native, and no display-name-from-model native, whereas vehicles
have all three (`GET_NUM_DLC_VEHICLES` / `GET_DLC_VEHICLE_MODEL` /
`GET_DISPLAY_NAME_FROM_VEHICLE_MODEL`). There is also no `snprintf`-style
formatting and no int-to-string native, so a runtime `"PED: %s"` string cannot be
built either. The data-driven equivalent is therefore build-time only.

`tools\Gen-PedCatalog.ps1` reads `ENUM MODEL_NAMES` from
`X:\gta5\script\dev_ng\core\game\data\model_enums.sch`, where every entry carries
a trailing comment naming the metadata file it came from:

```text
A_F_Y_BEACH_01=-945854168,   // x:/gta5/assets_ng/export/data/peds.pso.meta
```

The default `-SourceFilter 'peds(\.pso)-\.meta'` selects the game's ped models:
683 from `peds.pso.meta` plus 77 from the seven DLC ped packs present in the dump
= 760 entries, in the game's own alphabetical order. 760 still fits the existing
8 pages (7x96 + 88), so the page geometry and dispatch shape are unchanged.
Verified byte-identical:

```powershell
& 'MG-SwitchMenu SDK\tools\Gen-PedCatalog.ps1' -Verify
```

Reducing to `-SourceFilter 'peds\.pso\.meta'` narrows to the basegame-only 683
set; that combination was verified to reproduce the pre-generator file
byte-for-byte, which is how the generator was proven correct.

Only the table region is generated (`PED_CHOICE_COUNT`, the 8
`PED_MODEL_PAGE_n` / `PED_NAME_PAGE_n` pairs and the two `*_FOR_CHOICE`
dispatchers). Everything from `FIND_PED_CHOICE_BY_NAME` onward is hand-written and
is preserved verbatim from the existing file, so the include layout and every
public function name are unchanged. Regeneration is idempotent.

Other modes:

- `-ExtractTo <file>`: dump the current catalog's names to a seed list
  (`tools\ped_catalog_names.txt`, 760 lines).
- `-NameFile <file>`: generate from a hand-edited name list instead of the enum,
  for adding models that the dump does not contain.
- `-SourceFilter <regex>`: change which metadata families are included, e.g.
  `'peds\.pso\.meta'` for basegame-only.
- `-Verify`: compare against the on-disk file without writing; combine with
  `-NoProvenance` for a strict byte comparison against a pre-generator file.

Validation refuses to emit on empty input, invalid names, or duplicates (a
duplicate `CASE` label is a compile error). `-PageSize` must stay 96 to match the
emitted dispatch and the compiler's per-`SWITCH` limit.

### Door catalog generation

The "Open Closest Door" row (World and Weather, row 13) needs a list of
door-capable models, and there is no runtime native that enumerates doors. The
complete door API takes a model plus a position -
`GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE` to find, then
`SET_STATE_OF_CLOSEST_DOOR_OF_TYPE` / `DOOR_SYSTEM_*` to open - so the model set
has to be resolved at build time, exactly like the PED catalog.

`tools\Gen-DoorCatalog.ps1` reads the same `ENUM MODEL_NAMES` dump but selects by
**name**, not by metadata file: door props are spread across many level metadata
files (`v_lev_doors.xml`, `int_lev_des.xml`, the `v_fences` packs,
`int_mp_doors.xml`, ...) with no single pack to key on. The default filters are:

- `-NameFilter 'DOOR|GATE|GARAGE|SHUTTER|BARRIER'` -> 993 name matches.
- `-ExcludeFilter` drops what matched on name alone but is not an openable door
  (LOD/HIP suffixes, and `FRAME|POST|HINGE|HANDLE|BELL|KNOB|PLATE|SIGN|GLASS|
  LIGHT|LAMP|BUZZER|MARKER|_LOCK|_LID|WINCH|RAILING|TRIM|COLLISION|CRASH|PLUG`).
  Verified by hand: the excluded `GATEPOST`, `*_FRAME`, `*_L1` and `*_PLUG`
  entries are gate posts, frames, LODs and electrical props rather than doors,
  while the two lookalikes that are kept (`V_ILEV_BK_GATEDAM`,
  `V_ILEV_FINGATE`) are genuine dam and fin gates.

Result: **746 models over 8 pages of 96** (7x96 + 74). Unlike the PED catalog
there is no hand-written tail - the file is entirely generated, so the generator
creates it from nothing.

```powershell
& 'MG-SwitchMenu SDK\tools\Gen-DoorCatalog.ps1' -Verify
# VERIFY_MATCH 746 models, 8 pages (table region identical)
# VERIFY_BYTE_IDENTICAL yes
```

`DOOR_MODEL_FOR_CHOICE(INT)` is the only entry point callers need; it hides the
paging. `-FallbackModel` (default `PROP_DOOR_01`) is what every out-of-range path
returns, and the generator **refuses to emit** unless that name is actually in
the generated set, so it can never hand the compiler an undeclared identifier.
Other modes are the same as the PED generator: `-ExtractTo`, `-NameFile`,
`-Verify`, `-NoProvenance`.

The scan itself lives in `util_world.sch` (`PROCESS_DOOR_SCAN`, called from the
main loop every frame) and is deliberately staged: 746 spatial queries cannot fit
in one tick, so `DOOR_SCAN_PER_FRAME` (16, in `core_constants.sch`) models are
probed per frame, resolving in about 47 frames (~0.8s at 60fps). The scan runs
even while the menu is closed so it always terminates, and
`g_door_scan_index` only ever advances, so it cannot spin.

Typical commands (workspace root):

```powershell
& 'MG-SwitchMenu SDK\tools\Build-Any.ps1' `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReferenceFolder "stock nsc's for cross-reference\script_rel.rpf" `
  -OutputDirectory 'MG-SwitchMenu SDK\out-<batch>' `
  -Source 'MG-SwitchMenu SDK\source\ragemenu.sc'
```

The known-good `Unrecognized aes key name ... using default 'fefffff'` line comes
from `scriptrc_x64.exe` and is benign; the build still succeeds. Because it is
written to stderr, the engine merges native stderr into stdout (`2>&1`) so it can
never abort a build under `$ErrorActionPreference='Stop'`. Success is decided by
exit codes only.

Inspect any artifact without building:

```powershell
$adapter = "MG-SwitchMenu SDK\tools\NscAdapter\bin\Release\net8.0\NscAdapter.dll"
dotnet $adapter --info "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc"
dotnet $adapter --info "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc" "MG-SwitchMenu SDK\out-<batch>\ragemenu.pc.nsc"
dotnet $adapter --validate-names "MG-SwitchMenu SDK\out-<batch>"
```

`--info` is deliberately lenient: it still reports a file whose header cannot be
decoded, which is how the envelope-wrapped `.nsc` files in the older `out-*`
directories get identified (`BARE_PAYLOAD no`, plus an explicit note). Passing a
second path adds an adaptation preview (`WOULD_CHANGE changed=n offsets=...`).

NscDump extras: `--scan-dir` accepts a single `.nsc` file or a directory;
`--compare-native-tables <candidate> <stock folder>` reports `FOLDER_MATCHES n/n`
union coverage; `--validate-names` now accepts a single file as well as a
directory; `--adapt-header` accepts a folder reference and writes a **bare
payload** by default (`--container` re-adds the RSC7 envelope, `--dry-run` writes
nothing). It shares its container, header and name logic with NscAdapter through
`NscCore`, so the two can no longer disagree about formats.


The RSC7 wrapper and the RPF file entry are different layers. Do not create an
RPF resource entry for `ragemenu.nsc`; it must be a standard compressed binary
file entry. Do not rename compiled scripts: their internal name must match the
loader's expected name. You can change the name by editing lines **1141-1146** in `source\achievement_controller.sc` and changing it all-around the source tools.

## Feature checklist

For every new option, always test:

- fresh boot with the menu never opened;
- option ON;
- option OFF and visible/gameplay reset;
- entering/exiting a vehicle where relevant;
- death/respawn where relevant;
- returning to categories and closing the menu;
- reopening the menu after several minutes of play.

For streamed assets such as vehicles, request the model first and finish the
action from the main script loop only after `HAS_MODEL_LOADED` succeeds. Use a
short timeout and release the requested model on success and timeout. Do not
wait in a tight loop inside a menu action.

For selector rows, make `IS_SELECTOR_ACTIVE` true only for that row. D-pad
Left/Right should change a stored choice, while a separate `APPLY` row performs
the action. This prevents selecting a vehicle from accidentally spawning it.

Avoid spawning entities, model requests, or per-frame unbounded task creation
until you can prove cleanup and target-native compatibility. Keep gameplay
control suppression active only while the menu is visible.

When an accept button is also mapped to driving, attacks, cinematic controls,
or context actions, leave `INPUT_FRONTEND_ACCEPT` enabled for the menu and
disable each corresponding `PLAYER_CONTROL` action every frame the menu is
open. Test this on foot, driving, cinematic camera, and cutscene-adjacent
states.
