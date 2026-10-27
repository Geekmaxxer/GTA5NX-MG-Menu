# v1.0.6 source verification ? 2026-10-16

- All 24 `.sc`/`.sch` files match the current workspace source byte for byte.
- The menu and controller compile, adapt and pass name validation from this
  checkout. The menu and its generated 304-byte binding match the existing
  Description Fix build exactly.
- Menu native self-check: 487/487 rotation and direct matches. Stock union:
  472 stock calls plus 15 expected custom calls, exactly matching the binding.
  Controller: 89/89 stock calls. The union read 1,020 stock scripts.
- All four .NET tooling projects build. 54 tooling tests pass; eight optional
  historical fixture cases return early without their external fixtures.
  The real builds/native comparisons above were performed separately.
- Included basic Chaos Mod and Car Dealership sources also compile and adapt.

[Artifact hashes and results](build-verification.json) identify this build.
Generated binaries, references, compiler files and build logs are kept outside
version control. This checkout rebuild has not been run on Switch; the latest
shared description renderer still needs visual testing. Prior user-confirmed
manager/persistence restart testing is described in [the changelog](CHANGELOG.md).

## Loader stack repair

The controller was rebuilt after switching its menu launch to the official
8,344-word pool and removing the second same-frame launch. Header/name checks,
89/89 native self matches and 89/89 stock matches passed. The compiled menu
and its binding are unchanged. This loader change still needs a Switch test.
See [controller verification](loader-stack-verification.json).

## Runtime packaging regression

The previous v1.0.6 ZIPs retained Public Plugin Loader Test 1 (`24fe83d2...`),
which lacks 12 of the current menu's custom natives. The actual ARM64 repair
guard reproduces a held menu with that module and permits it with the accepted
manager runtime (`209bec71...`). All 14 exact menu/plugin integration checks
pass with the replacement runtime and current binding. The user's failed report
also identifies Public Plugin Loader Test 1. A new combined console test is pending.
