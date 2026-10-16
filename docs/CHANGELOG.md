# v1.0.6

- Added ScriptHookV-NX Plugins to Menu Settings, including discovery/rescan,
  per-plugin details, memory/status display and manual Load Now.
- Added verified Disabled, Manual and Auto startup policies. Saving a startup
  policy and starting/stopping current execution are separate actions.
- Added Kill Process to each plugin's details page and live running/stopped
  status. Cooperative cancellation retains the NRO mapping until GTA closes.
- Integrated SD settings persistence through ScriptHookV-NX while retaining
  the menu's existing settings layout and legacy save/load native hashes.
- Repaired shared description rendering to split long UTF-8 text into bounded
  HUD components and measure the same text that is drawn. Cached wrapping and
  panel sizing retain the descriptions and translations.
- Added a build command that generates `ragemenu.snb` from the exact final NSC.
- Updated the source modules, catalogs and build/inspection tools to the current
  development tree. Stock binaries and local build output are excluded.

## Validation scope

The newer description renderer passed 57 compiled checks and 14 matched
menu/runtime checks locally. Game font metrics were modeled in those tests;
Switch visual confirmation remains pending. A checkout rebuild and its binding
are checked separately in [build verification](BUILD-VERIFICATION.md).
