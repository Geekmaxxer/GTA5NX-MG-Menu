# Menu stability audit

The v1.1 stability revision corrects catalogue persistence, temporary string
ownership, vehicle controls and mission-sensitive cleanup. All existing menu
features remain available. This revision has local verification; physical
Switch acceptance is pending.

## Review coverage

The audit covers all 25 `.sc` and `.sch` source files, including the main menu,
achievement-controller launcher and optional Chaos Mod and dealership scripts.
Control flow, asynchronous requests, entity ownership, persistence, navigation,
rendering and packaging were reviewed. Generated catalogues received structural
checks rather than an individual gameplay test of every model.

| Area | Review and verification |
| --- | --- |
| Menu and core modules | Page counts, selectors, apply actions, navigation state, keyboard completion, description components and scaleform lifetime. |
| Persistence and loaders | Failed-write recovery, committed catalogue generations, filename character encoding, saved-vehicle records, plugin identity and cooperative auxiliary shutdown. |
| Player and NPC features | Model type checks, character ownership, freecam restoration, bodyguard formation, attacker relationships, chauffeur targeting and pending-spawn cancellation. |
| Vehicle modules | Model requests, previews, tracking, replacement transactions, acceleration/grip ownership, tyre controls and modification selectors. |
| World, teleport and weapons | Streaming ownership, collision readiness, objective selection, mission entities, delayed explosions and projectile cleanup. |
| Catalogues and localization | Complete domains for 760 PEDs, 746 doors, 314 props, 112 story characters, 190 static vehicle choices, 93 weapons and 14 chauffeur vehicles; translation argument counts across every source file. |
| Achievement controller | Comparison with the matching local upstream source isolates the menu-launch integration; achievement/progression logic remains unchanged. |
| Distribution | Matching NSC/SNB files, controller parity, runtime/NPDM placement, archive readback and unchanged unrelated payloads. |

This is a source and artifact audit. It does not establish that every animation,
model, mission, cutscene, third-party script or combination of options is safe.

## Corrections

### Persistence and string ownership

- The NSC reader now accepts the same character codes that its encoder writes.
  Previously code 1 (`a`) was rejected, making many saved names unreadable.
- Failed NSC page/root writes preserve the committed catalogue and allow a
  subsequent retry. Damaged committed records remain blocked.
- Failed settings writes retain their pending state and last successful shadow.
  Retries are paced; a failed menu-close flush no longer discards the change.
- Keyboard completion marks changed settings for saving. Disabling persistence
  writes the preference as well. Language changes have an independent shadow.
- Clearing saved settings acknowledges the write result and leaves current
  session options unchanged. Unchanged options do not immediately recreate the
  cleared record.
- Custom names, model searches, IPL names and plate input use owned text buffers.
  Each customized story character retains its own label.
- Saved vehicles report failed writes and retry. Incomplete records are rejected.
  New records also checksum their count/header; version 1 records remain readable.

### Player, NPC and entity lifetimes

- Character profiles identify Michael as `PLAYER_ZERO` and Franklin as
  `PLAYER_ONE`. Browsing profiles no longer changes the active custom-PED owner.
- Custom PED entry points reject non-PED models. Model replacement refreshes the
  frame's player cache; pending spawns are cancelled during player transitions.
- Freecam restores the visibility, first-person and noclip state captured when
  it was enabled.
- Bodyguard formation uses the script engine's degree-based trigonometry.
  Dismissing bodyguards, attackers or stripper PEDs cancels pending spawns.
- Attackers use a dedicated relationship group rather than rewriting the
  game's shared enemy group.
- The armed chauffeur targets non-mission opponents fighting the player or
  driver. A moved waypoint updates the route. Chauffeur replacement retains the
  previous vehicle until both replacement entities have been created.
- Story visual replacements retain original alpha values for cleanup and do
  not suppress the original model's streaming while a replacement is pending.
  Model requests have a bounded fallback; visual proxies start without collision. Registered cutscene actors remain alive
  until playback has ended, including customization changes during a scene.
- Object Spooner reclaims missing objects' slots and retains matching metadata.
  Its object creation paths reject PED and vehicle models.

### Vehicles and mission-sensitive actions

- Normal acceleration no longer forces a train's cruise speed. Car acceleration
  resets when changing vehicles and applies only to the player's driver seat.
  Grip cleanup covers vehicle and seat transitions. Temporary bulletproof tyres
  restore the captured burst state rather than assuming all tyres can burst.
- Tyre Smoke, Tyres Can Burst and Soft Suspension now toggle when applied.
  Hydraulic, interior and livery selectors use the vehicle's available variants.
- Saved convertible roofs use the correct engine state mapping. Saved-spawn
  selection remains consistent when a saved vehicle is deleted.
- Conversion protects mission vehicles and passengers, checks tracking capacity
  and confirms the player entered the replacement before deleting the source.
  Auto Delete Previous Car executes only after a new spawn succeeds.
- Teleports and previews no longer clear nearby entities. Teleports preserve
  existing game streaming/focus ownership and reject unready 2D destinations.
  Explicit 3D destinations retain a collision-scene fallback. Failed requests
  leave the player at the origin and display `NO COLLISION` on the action rows.
- Objective teleport no longer falls back to an arbitrary nearby map icon.
  Automatic objective teleport waits for player control after a cutscene.
- Cutscene skipping requests the normal ending once playback begins, preserving
  registered script actors instead of aborting scene preparation.
- Nearby clearing, queued vehicle explosions and special-gun targeting spare
  mission entities. Clear actions process a bounded nearby ambient selection;
  companions have their separate dismissal controls. Explode All pauses during
  missions. Area effects can still damage nearby entities indirectly.
- Riot cleanup acts on its tracked PEDs. Crazy drivers spare mission vehicles
  and drivers. The tow hook resolves an actual attachment rather than selecting
  a random nearby vehicle, and pauses during missions.
- Menu autosave waits while a custom player model or model transition is active.
  The cash selector saturates before signed integer overflow.

### Optional scripts

- Chaos suspends effects during missions, cutscenes and player transitions.
  It restores captured relationship values and tracks ambient torque overrides
  for cleanup rather than resetting unrelated vehicles.
- The dealership suspends interaction during missions/player transitions,
  restores its previous showroom IPL state, and leaves unrelated entities and
  mission-owned screen fades alone.
- Delivery confirms vehicle creation before charging funds. Failed payment
  discards the new delivery; prior purchased vehicles are released rather than
  deleted by a subsequent purchase.
- The updated auxiliary scripts handle menu shutdown requests before termination.
  A bounded grace period allows yielding work to reach cleanup. Arbitrary
  third-party scripts do not inherit this cleanup contract.
- The achievement launcher spaces failed restart attempts and releases its
  script-streaming reference after a launch attempt.

The optional scripts are separate source/build outputs. The standard EASY and
HARD installers do not add them. To use their revised cleanup handlers, rebuild
or replace `chaosmod.nsc` and `cardealership.nsc` in the installed script archive;
an older auxiliary binary does not receive the new shutdown behavior.

## Local verification

Run the portable source regression suite from the repository root:

```powershell
python ./tools/Test-MenuSource.py --output ./menu-source-verification.json
dotnet test ./tools/NscTests/NscTests.csproj -c Release
```

The source verifier executes selected live SanScript routines with deterministic
native models and checks all source metadata. It requires no proprietary engine
headers or game data. It does not execute the RAGE VM or native engine handlers.
The exact build, source hashes and results are recorded in
[stability-audit-verification.json](stability-audit-verification.json).

- [x] Complete source inventory and metadata checks.
- [x] Local state-transition and failure-injection regression checks.
- [x] Fresh compilation of the menu, launcher and both optional scripts.
- [x] Switch header adaptation, names, binding generation and native-table checks.
- [x] Reproduction from the GitHub source checkout.
- [x] Installer/archive readback and runtime pairing checks.
- [ ] Physical Switch acceptance of this stability revision.

## Combined hardware acceptance

Use the bundled v1.1 checklist for one combined session. Include fresh boot,
restart persistence, normal driving, mission entry, cutscene transitions,
death/respawn, and auxiliary-script unloading. Exercise cleanup after changing
cars, disabling freecam, cancelling model requests and clearing spawned objects.

Story model replacements, IPL changes, cutscene skipping and destructive effects
still depend on mission-specific engine behavior. The source guards reduce known
interference; they do not guarantee compatibility with every story sequence.
No feature removal is proposed by this audit.
