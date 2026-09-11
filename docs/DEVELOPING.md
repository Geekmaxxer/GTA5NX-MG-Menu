# Developing safely

## Before editing

Keep three separate files:

1. The untouched game `update2.rpf`.
2. Your last hardware-tested working copy.
3. A new output copy for the current experiment.

Never edit the only working archive in place. Use an `.nsc` reference exported
from the exact target's `script_rel.rpf`; its header is version-sensitive.

## Native calls

`ragemenu.sc` names natives from the Rockstar `dev_ng` headers. The compiler
records them in the script's native table. The Switch port must recognize every
compiled native hash. If you add a native that is absent or mapped differently
in the target port, the game may fail to load or crash at the call site.

Keep a native-table report from stock scripts in the target `script_rel.rpf`
and compare every newly compiled script before putting it in an RPF. This SDK
does not pretend that PC and Switch native tables are universally identical.

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
