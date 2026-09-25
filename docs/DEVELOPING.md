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
  page-base `0x00007FF7BAD5B3A8`, word@0x18 `0x94C75B53`.
- The working ragemenu builds (`out-batch32b`, v0.9.2 release) instead carry
  `0x00007FF6619AB3A8 / 0x00000000` because they were adapted with the older
  `out-current-task-final\ragemenu.nsc` reference. Both profiles load the same
  way in practice, but new builds should prefer the stock-folder profile so the
  bytes are traceable to the target build.
- `ragemenu.nsc` exists only in our builds; the stock extraction has no
  ragemenu.nsc (confirmed by `--find-script ... ragemenu` = 0 matches), so
  folder mode falls back to `achievement_controller.nsc`.
- `achievement_controller.nsc` is referenced by `freemode.nsc` (hash hunt shows
  `achievement_controller.nsc` + `freemode.nsc`), i.e. it is a real hosted stock
  script, which is why it is the preferred stable fallback.
- Rule: `-SwitchHeaderReference <single .nsc>` for exact work (must be the same
  build); `-SwitchHeaderReferenceFolder <stock folder>` for convenience. Folder
  mode resolves `<folder>\<Name>.nsc` first, else `achievement_controller.nsc`,
  else the first `.nsc` found. NscAdapter and NscDump accept the same folder
  argument directly.
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
# (rotation + direct) — proves the adapter preserved code/natives.
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --compare-native-tables "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc" "MG-SwitchMenu SDK\out-<batch>\ragemenu.pc.nsc"

# Folder coverage: every decoded native in the candidate exists somewhere in
# stock script_rel.rpf (batch32b ragemenu: 319/319, 0 unmatched, 1020 scripts).
# This is union coverage, not per-script index proof — keep the self-compare too.
dotnet run --project "MG-SwitchMenu SDK\tools\NscDump\NscDump.csproj" -c Release --no-build -- --compare-native-tables "MG-SwitchMenu SDK\out-<batch>\ragemenu.nsc" "stock nsc's for cross-reference\script_rel.rpf"
```

`--native-db` must be run separately per archive; `script.rpf` and
`script_rel.rpf` hold the same filenames but different compiled resources.

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

- `Build-Any.ps1 -Source <any .sc>`: name-derived outputs (`<Name>.sco`,
  `<Name>.pc.nsc`, `<Name>.nsc`); snapshots `<Name>.sc` + all `.sch`. Verified:
  ragemenu.sc -> byte-identical `.nsc`/`.sco` vs Build-Menu (SHA256 match), and
  achievement_controller.sc -> clean build (`--scan-dir` 76545/89, name check
  only flags `*.pc.nsc`, self-compare 89/89).
- `Build-Menu.ps1` (default `source\ragemenu.sc`), `Build-Controller.ps1`
  (default `source\achievement_controller.sc`): same pipeline, fixed names.
- `Build-Both.ps1`: builds both scripts into one output dir (shared snapshot,
  per-script adapt; `achievement_controller.nsc` preferred as folder fallback).

Typical commands (workspace root):

```powershell
& 'MG-SwitchMenu SDK\tools\Build-Any.ps1' `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReferenceFolder "stock nsc's for cross-reference\script_rel.rpf" `
  -OutputDirectory 'MG-SwitchMenu SDK\out-<batch>' `
  -Source 'MG-SwitchMenu SDK\source\ragemenu.sc'
```

The known-good compiler warning `Unrecognized aes key name ... using default
'fefffff'` is benign (build still succeeds, e.g. batch32b 35911 insns / 1864
statics). Any `Error:`/`throw` line otherwise is a real failure.

NscDump extras: `--scan-dir` accepts a single `.nsc` file;
`--compare-native-tables <candidate> <stock folder>` reports
`FOLDER_MATCHES n/n` union coverage; `--adapt-header` accepts a folder
reference (prefers `achievement_controller.nsc`, else first `.nsc`).


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
