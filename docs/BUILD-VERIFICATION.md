# v1.1 stability verification

The [stability audit](STABILITY-AUDIT.md) and its
[verification record](stability-audit-verification.json) identify the audited
source, reproducible outputs and installer checks. The native-model source suite
passes 207 checks and the NSC tooling suite passes 62 tests. Physical acceptance
of this revision remains pending. Earlier records below retain their dated scope.

# v1.1 local verification

The [current record](v1.1-verification.json) identifies the exact menu/runtime pair. The GitHub checkout reproduces the menu and binding bytes. Physical v1.1 acceptance remains pending; the following records retain their original scope.

# Build verification

The v1.0.8 source was synchronized and rebuilt on 2026-10-27. All 23 menu script/header source files match the working SDK byte for byte. The existing menu layout and repository structure are preserved.

- Both scripts compiled and passed stock-header adaptation, name validation and matched binding checks.
- Tooling tests: 62 passed, zero failed.
- Menu native audit: 489 stock matches and 15 ScriptHookV-NX bindings, 504 total.
- Loader native audit: 89 of 89 stock matches.
- The loader uses the official 15,900-word pool for the current menu.

Build outputs are in the ignored `out-v108-source-sync-final1-20261027/` directory. Artifact hashes and payload details are recorded in [build-verification.json](build-verification.json).

No RPF archive was installed, and no new physical Switch gameplay test was performed for this synchronization. This synchronization does not stage files or create commits.
