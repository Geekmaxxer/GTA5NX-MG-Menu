# MEGATARD Menu v1.0.6 for GTA V Nintendo Switch

SanScript source and build tools for MEGATARD's single-player mod menu, with
[ScriptHookV-NX](https://github.com/Geekmaxxer/ScriptHookV-NX) SD settings and plugin management.
Created by **MEGATARD / @Geekmaxxer**.

Player, weapon, vehicle, world, teleport and NPC options sit alongside Object
Spooner, Custom NSC Loader, custom story PEDs, language settings and persistence.
See [Features](docs/FEATURES.md) and [v1.0.6 changes](docs/CHANGELOG.md).

## Requirements

- Windows, PowerShell 5.1 or newer, Python 3, and the .NET SDK selected by
  [tools/global.json](tools/global.json) (10.0.401 or a compatible later feature band).
  The adapter/tests target .NET 8, so its runtime must also be installed.
- Your own SanScript compiler tree containing `sc.exe`, `scriptrc_x64.exe`,
  `singleplayer/GTA5_SP.scproj`, and its matching includes. Pass its location
  through `-DevNgRoot`; compiler/project dependencies must also resolve there.
- Your own stock **Switch `script_rel.rpf`** reference script or extraction from
  the exact game build you target. `script.rpf` is a different archive.
- The ScriptHookV-NX SDK or source checkout for its binding generator, and the
  matching runtime installed on the Switch. v1.0.6 uses manager API 3 and custom
  natives; install the runtime and the matched binding before launching it. Use
  Public Preview 1 / Safe Manager Test 2 or a verified later runtime; Public
  Plugin Loader Test 1 lacks this menu's manager natives.
- An RPF editor to install the compiled scripts into your own archive.

The current integration targets title `0100b00b51230000`, executable build
`6e3e9b3af5746e74b615bd981080c9271bc226620`. Other game builds require a compatibility audit.
Compiler binaries, engine headers, keys, game archives and stock binary scripts
are external inputs. No prebuilt runtime or menu is included here.

## Build the menu and matching binding

Run from this repository's root; replace the example paths with your locations:

```powershell
./tools/Build-MenuRelease.ps1 `
  -DevNgRoot 'C:/modding/dev_ng' `
  -ScriptHookRoot 'C:/modding/ScriptHookV-NX' `
  -SwitchHeaderReferenceFolder 'C:/modding/stock/script_rel.rpf' `
  -OutputDirectory './out-v106-test1'
```

Use a new output directory for each build. This produces `ragemenu.nsc`,
`achievement_controller.nsc` and **the matching `ragemenu.snb`**, plus source
snapshots, intermediates and build manifests. It does not install anything.
`-SwitchHeaderReference <file>` can replace the folder option.

The lower-level `Build-Menu.ps1`, `Build-Controller.ps1`, `Build-Both.ps1` and
`Build-Any.ps1` remain available. They compile/adapt scripts but do **not**
generate ScriptHookV-NX bindings. See [Developing](docs/DEVELOPING.md).

## Install your build

Close GTA and back up your working files first.

1. Install the matching ScriptHookV-NX runtime's `subsdk5` under
   `atmosphere/contents/0100b00b51230000/exefs/`.
2. Add/replace `ragemenu.nsc` and `achievement_controller.nsc` in your own
   `update2.rpf/switch/levels/gta5/script/script_rel.rpf` as **normal compressed
   file entries**, then install your updated archive in the title's `romfs/update/`.
3. Copy the generated `ragemenu.snb` to `switch/gtav-scripthook/bindings/`.

Keep the existing `shop_controller.nsc`; this repository does not rebuild it.
Never install `*.pc.nsc` or `*.sco`, rename compiled scripts, or use an RPF
resource entry. Regenerate the `.snb` after every menu rebuild. It is a small
custom-native binding manifest, not a compiler debug database.

Open the menu with **LB + D-Pad Down** by default. Use D-Pad to navigate,
**A** to apply/open, **B** to return, and Left/Right on selectors. The combo
is configurable. **R3** jumps to the top of a page.

## Plugins and settings

Install NROs in `switch/gtav-scripthook/plugins/`. In
**Menu Settings -> ScriptHookV-NX Plugins**, select a plugin to view its status:

- **Load Now** starts a Manual or Auto plugin without changing its startup mode.
- **Startup Mode** selects Disabled, Manual or Auto; press A to save and confirm.
  This determines startup behavior. It does not stop a running plugin.
- **Kill Process** stops that plugin's cooperative scripts. Its executable and
  custom native handlers remain mapped until GTA exits; this does not reclaim a
  resident slot or reverse gameplay changes made by the plugin.

The runtime supports four resident NROs per session. Rescan discovers files;
replacing a resident NRO needs a game restart. A standalone manager is available
in the ScriptHookV-NX project for players without this menu.

Legacy menu SD settings remain under `switch/gtav-megatard/`. Keep existing
settings when updating. General portable native APIs and NRO SDK documentation
belong to the separate ScriptHookV-NX project.

## Development and validation

Edit the modules under `source/core`, `features`, `submenus` and `util`.
[Developing](docs/DEVELOPING.md) covers builds, native checks and contributions.

Menu persistence and manager startup policies were confirmed on Switch after
restart. The latest shared description-renderer repair passed local compiled
checks; **its visual behavior still needs Switch testing**. Compilation, header
validation and native-table coverage do not establish in-game behavior.

This project retains its [GPL-2.0 license](LICENSE). ScriptHookV-NX is a separate
project with its own license. Third-party decompiler code retains its original
notices. No GTA Online support is claimed.
