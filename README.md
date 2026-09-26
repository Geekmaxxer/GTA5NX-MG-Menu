# MEGATARD GTA5-NX Menu SDK

Source and build tooling for the MEGATARD single-player menu script. It is for
owned game dumps and offline single-player research. This repository contains
no Rockstar game files, no `update2.rpf`, no stock `.nsc` files, no compiler
binaries, no keys, and no prebuilt menu archive.

## What you need

- A version 2699 build of the patched GTA5 Switch port files with Rockstar's internal script build tools already
  available to you. Point `-DevNgRoot` at the folder containing `sc.exe`,
  `scriptrc_x64.exe`, and `singleplayer\GTA5_SP.scproj`.
- A partition or drive with the driver letter `X:\` and the GTA 5 SRC in it `X:\gta5\`
- .NET 8 SDK or newer for the included header adapter.
- An exported **stock Switch** `script_rel.rpf` script, such as
  `achievement_controller.nsc`, from the exact game/port version you target.
  This is **not** a static file shipped with this SDK — it's just a
  cross-reference. Pull your own copy straight out of the stock port's
  `update2.rpf` (`switch\levels\gta5\script\script_rel.rpf`) before building
  anything, and re-export it any time you target a different build/version.
- An RPF editor/library that can replace a file in `script_rel.rpf` as a normal compressed file entry. The original `achievement_controller.nsc` must
  already be present if you don't have the edited nsc already; this SDK does not supply or modify it. --> [OpenIV RPF Editor](https://openiv.com/) / [CodeWalker RPF Editor](https://www.gta5-mods.com/tools/codewalker-gtav-interactive-3d-map)

## Build the menu script

From PowerShell in tools:

```powershell
./tools/Build-Menu.ps1 `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReference 'path\to\achievement_controller.nsc' `
  -OutputDirectory './out'
```

The installable output is `out\ragemenu.nsc`: a raw Switch script payload with
the Switch header adaptation applied. `out\ragemenu.pc.nsc` is only the Win64
compiler intermediate; never put that file in `script_rel.rpf`. The script and
archive entry name must remain `ragemenu.nsc`. Add it as an ordinary compressed
file entry; do not make it an RPF resource entry or add an outer RSC7 wrapper.

## Build the loader script

From PowerShell in tools:

```powershell
./tools/Build-Controller.ps1 `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReference 'path\to\achievement_controller.nsc' `
  -OutputDirectory './out'
```

The output is `out\achivement_controller.nsc`

Note that `-SwitchHeaderReference` here is your own **stock** copy pulled from
`update2.rpf` - not this script's output. They happen to share a filename, but
the reference is the unmodified stock cross-reference you feed in, while
`out\achivement_controller.nsc` is the modified build you get out.

## Build both
From PowerShell in tools:

```powershell
./tools/Build-Both.ps1 `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReference 'path\to\achievement_controller.nsc' `
  -OutputDirectory './out'
```
The output is `out\ragemenu.nsc` & `out\achivement_controller.nsc`

## Build any script

From PowerShell in tools:

```powershell
./tools/Build-Any.ps1 `
  -DevNgRoot 'X:\gta5\script\dev_ng' `
  -SwitchHeaderReference 'path\to\achievement_controller.nsc' `
  -OutputDirectory './out' `
  -Source 'source\my_script.sc'
```

Unlike the three build scripts above, `Build-Any.ps1` isn't hardcoded to
`ragemenu` or `achievement_controller` - `-Source` is required, and the output
name is taken directly from the source file. Building
`source\my_script.sc` produces `out\my_script.nsc` (plus the matching
`out\my_script.sco` / `out\my_script.pc.nsc` intermediates). Use this for any
extra or one-off `.sc` script beyond the two built-in ones.

`-SwitchHeaderReference` isn't limited to `achievement_controller.nsc` here
either - any stock `.nsc` exported from the same build's `script_rel.rpf`
works as the cross-reference. Bigger stock scripts are the better pick: more
data for the header adapter to cross-reference against.

## Add it to your own archive

1. Back up your own working `update2.rpf`.
2. Open the archive for that rpf file, then navigate to `switch\levels\gta5\script\script_rel.rpf`.
3. Turn on Edit Mode within your RPF editor and add/replace `ragemenu.nsc`/`achivement_controller.nsc` (or your `Build-Any.ps1` output) from your output folder. It must be a normal RPF binary file entry—not an RPF resource entry. Let the RPF tool apply normal file compression; do not feed it an already-compressed resource payload.
4. Once you drop your files in you don't need to save, just exit out and replace your existing `update2.rpf` in `atmosphere\contents\0100b00b51230000\romfs\update`

The exact archive, controller, title ID, and native table are build-specific.
Do not use a reference script from a different version or port.

## Editing the menu

Modify [source/ragemenu.sc](source/ragemenu.sc) and it's source folders containing schematic (`.sch`) files. It is SanScript/C-like source
that uses Rockstar native declarations from the `dev_ng` include path. Keep
changes small and test each one.

- Add persistent state near the other `g_` globals.
- Add an item to the desired category in `DRAW_PAGE`, then match it in
  `ITEM_COUNT` and `APPLY_SELECTED`.
- Per-frame natives belong in the main `SCRIPT` loop; avoid issuing permanent
  gameplay changes every frame unless that native is documented to be
  frame-scoped.
- When adding a toggle, implement its OFF/reset path too. Test fresh boot,
  enable, disable, changing vehicle, dying, and closing the menu.
- Controls that share the menu's accept button must be blocked with
  `DISABLE_CONTROL_ACTION` while the menu is open. Keep menu navigation on
  `FRONTEND_CONTROL`; block gameplay actions on `PLAYER_CONTROL`.

`Build-*.ps1` performs these steps:

1. `sc.exe` compiles `.sc` to `.sco`. The compiler's include path (`-ipath`)
   also has `source/` itself appended, so any `.sch` header file in `source/`
   can be `#include`d by name without extra configuration.
2. `scriptrc_x64.exe` converts `.sco` to an **uncompressed** RSC7 script
   container with the `gta5` AES key label. Falls back to `fefffff` if it can't recognize the AES key name of your `.sc` script.
3. The included adapter copies only the observed Switch page-base and unknown
   header field from your same-build stock reference into the candidate.

Every `Build-*.ps1` run also copies every `.sch` file found in `source/`
(preserving subfolders) into the output directory alongside the compiled
`.sc`/`.nsc` files, so a given build's exact headers are snapshotted along
with its source and can always be reproduced or reverted later.

This is not an ARM64 compilation step. GTA's RAGE script VM executes the
script bytecode; the Switch-specific header values and the target's native
table must match the running port.

## Safety and limits

- Intended only for offline single-player. GTA Online will be supported once released on this build of the port.
- This project does not distribute game content, leaked sources, encryption
  keys, or console executable patches.
- Header adaptation is intentionally narrow. It does not crossmap native
  hashes. A newly used native must already be supported by your exact target;
  otherwise it can crash or fail to load.
- Build success is not a hardware test. Always keep a known-good archive and
  test one small change at a time.

### Contribution/Development
See [docs/DEVELOPING.md](docs/DEVELOPING.md) for a fuller checklist.
