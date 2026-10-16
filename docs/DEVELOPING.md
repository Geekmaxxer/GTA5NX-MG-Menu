# Developing MEGATARD Menu

## Source layout

`source/ragemenu.sc` is the main entry point. Shared state/constants/rendering
live in `core/`; input, selection and apply handling live in `features/` and
`submenus/`; gameplay helpers, persistence and loaders live in `util/`.
`achievement_controller.sc` starts/restarts the menu through the game's script
loader. `commands_scripthook_nx.sch` declares the external runtime APIs.

Keep UI changes coherent: row count, drawing, descriptions, selector detection,
Left/Right handling, A action, scrolling and back navigation must agree.
Implement cleanup/OFF behavior for gameplay effects. Keep per-frame work bounded,
yield model requests, and release resources. Compile small changes early.

## Build commands

See the root [README](../README.md) for the complete menu/controller/binding build.
For one custom script, run from the repository root:

```powershell
./tools/Build-Any.ps1 `
  -Source './source/chaosmod.sc' `
  -DevNgRoot 'C:/modding/dev_ng' `
  -SwitchHeaderReferenceFolder 'C:/modding/stock/script_rel.rpf' `
  -OutputDirectory './out-chaosmod-test1'
```

The other wrappers use the same `BuildCommon.ps1` engine. `Build-Menu.ps1` and
`Build-Controller.ps1` accept `-Source`; `Build-Both.ps1` accepts
`-RagemenuSource` and `-ControllerSource`. Output names derive from entry-point
names. `-DryRun` still compiles/converts and checks adaptation but does not write
the adapted NSC or claim it was built.

`-DevNgRoot` configures the compiler tree. Engine includes come from the Release
configuration in its `singleplayer/GTA5_SP.scproj`, with this repository's
`source/` appended. Check that the project's external paths resolve on your
machine; the compiler and engine headers are not redistributed here.

The pipeline is:

```text
.sc -> sc.exe (Win64 script bytecode) -> .sco
    -> scriptrc_x64.exe -> .pc.nsc
    -> NscAdapter + same-build stock reference -> raw .nsc
```

The adapter strips the RSC7 envelope and copies only page-base bytes
`0x00..0x07` and build-word bytes `0x18..0x1B`. It verifies every changed byte
against the reference, writes atomically and checks compiled names. It does not
crossmap native hashes or prove target-game compatibility.

Folder references resolve `<Name>.nsc`, then `achievement_controller.nsc`, then
the first `.nsc` by ordinal name. Stock has no `ragemenu.nsc`, so its normal
reference is the controller. The measured stock `script_rel.rpf` profile is
`0x00007FF7BAD5B3A8 / 0x94C75B53`. `script.rpf` uses a different profile.
Matching these bytes alone does not establish compatibility with a new build.

Every build includes entry-point/header snapshots and a `.build.json` manifest.
Compilation, adaptation, packaging and Switch runtime testing are separate
steps. Keep your untouched archive, last console-tested archive and new test
archive separate. The benign `Unrecognized aes key name ...` compiler notice
is not an error when the tool exits successfully.

## ScriptHookV-NX bindings

The complete builder requires a separate ScriptHookV-NX SDK/source checkout.
Alternatively, after using a lower-level build wrapper:

```powershell
python C:/modding/ScriptHookV-NX/tools/native_bindings.py `
  --script ./out-test1/ragemenu.nsc --output ./out-test1/ragemenu.snb
python C:/modding/ScriptHookV-NX/tools/inspect_mod.py ./out-test1/ragemenu.snb
```

Regenerate bindings after every NSC rebuild and install NSC/SNB as a pair.
Fifteen custom entries currently produce a 304-byte manifest. Its small size is
expected: it describes custom-native binding identities, not source/debug symbols.
A capability-check call cannot make missing native registration safe before
script binding; install the matching runtime/manifest before launch.

Legacy `MEGASAVE/MEGALOAD` remain intentional for this menu's existing settings.
New independent mods should use the public `SHVNX_SAVE/SHVNX_LOAD` interfaces.
Manager API 3 separates startup policy, load requests, execution and residency.
Kill Process cancels cooperative scripts; it cannot unmap executable code or
undo a plugin's gameplay effects. See the upstream
[ScriptHookV-NX SDK](https://github.com/Geekmaxxer/ScriptHookV-NX).

## Inspect and test

The existing decompiler source is vendored under `tools/third_party`; the
inspector project uses that layout directly. No submodule checkout is needed.

```powershell
dotnet build tools/SwitchMenuTools.slnx -c Release
dotnet test tools/NscTests/NscTests.csproj -c Release

dotnet run --project tools/NscAdapter -c Release --no-build -- --validate-names out-test1/ragemenu.nsc
dotnet run --project tools/NscDump -c Release --no-build -- --compare-native-tables out-test1/ragemenu.nsc out-test1/ragemenu.pc.nsc
dotnet run --project tools/NscDump -c Release --no-build -- --compare-native-tables out-test1/ragemenu.nsc C:/modding/stock/script_rel.rpf
```

Self-comparison must retain every native. Stock-folder union coverage should
contain the stock natives; custom runtime natives are expected exceptions and
must match the public declarations/runtime. A union match proves presence,
not every native's signature or behavior. Linear opcode-scan warnings occur
on stock scripts too; they are not automatically corruption.

Synthetic tool tests run without game data. Historical artifact/stock tests
return early when their optional local fixtures are absent, so a green suite
alone is not a real-game validation result. The compiled menu must also pass
name/header/native checks and hardware testing.

Hardware checks should cover fresh launch, menu open/close, changed options and
OFF/reset, death/respawn, vehicle entry/exit, settings after restart, plugin
startup modes and long descriptions in the selected languages.

## Catalog maintenance

The checked-in PED/door/custom NSC catalogs are ready for normal builds.
Regeneration is optional. Supply your own metadata with `-ModelEnums` or
`-NameFile` to `Gen-PedCatalog.ps1` / `Gen-DoorCatalog.ps1`. The custom NSC
generator requires `-StockNscDirectory` and accepts `-ScanDirectories`.
Review generated diffs; preserve handwritten helper sections and bounded page
sizes. Never check in extracted stock scripts or compiler/engine files.

## Contributing

Keep feature patches focused and describe the final behavior and validation.
Use a new build directory, regenerate bindings and keep console testing explicit.
Do not add game archives, compiled artifacts, private SD settings, toolchains,
keys or build caches. The menu's GPL-2.0 license and the upstream decompiler's
notices remain in effect; ScriptHookV-NX has a separate license.
