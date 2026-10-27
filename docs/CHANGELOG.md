# Changelog

## v1.0.8 source synchronization - 2026-10-27

- Synchronize all 23 menu script/header source files with the current working SDK, including saved vehicles and the current loader.
- Preserve the working menu layout and repository directory structure.
- Refresh binding-generation documentation and current runtime installation requirements.
- Rebuild both scripts against the stock Switch header and verify matched bindings. Local validation: 62 tests, 489 stock menu natives plus 15 custom bridge bindings, and 89 stock loader natives.
- No archive installation or new Switch gameplay test accompanies this source synchronization.


## v1.0.8 runtime bundle refresh - 2026-10-23

- Bundle the console-accepted ScriptHookV-NX v1.4 Preview runtime and matching menu binding.
- Synchronize the custom-native header and include plugin timing in NSC binding generation.
- Recompile the menu and achievement loader; both remain byte-identical to the current scripts.
- Preserve the 15,900-word loader pool, saved settings and current archive contents.
- Local validation: 62 tool tests; 489 stock native matches and 15 registered custom natives. Updated bundle gameplay testing remains pending.

- Corrected the release runtime pairing: the menu requires the newer manager
  runtime, and the previous ZIPs incorrectly retained Public Plugin Loader Test 1.

- The achievement controller now launches ragemenu directly in the official
  8,344-word SCRIPT_XML_STACK_SIZE pool. The previous 5,050-word launch and
  same-frame fallback have been replaced by one launch request.

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
