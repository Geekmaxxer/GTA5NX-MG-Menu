# Build verification

The v1.0.8 source was synchronized and rebuilt on 2026-10-27. All 23 menu script/header source files match the working SDK byte for byte. The existing menu layout and repository structure are preserved.

- Both scripts compiled and passed stock-header adaptation, name validation and matched binding checks.
- Tooling tests: 62 passed, zero failed.
- Menu native audit: 489 stock matches and 15 ScriptHookV-NX bindings, 504 total.
- Loader native audit: 89 of 89 stock matches.
- The loader uses the official 15,900-word pool for the current menu.

Build outputs are in the ignored `out-v108-source-sync-20261027/` directory. Artifact hashes and payload details are recorded in [build-verification.json](build-verification.json).

No RPF archive was installed, and no new physical Switch gameplay test was performed for this synchronization. Git history and the index were not changed.
