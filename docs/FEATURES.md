# MEGATARD Menu v1.0.8

The menu covers eight main categories:

| Category | Features |
| --- | --- |
| Player | God mode, health/armour, PED and outfit selection, custom story PEDs, bodyguards, attackers, no-clip/freecam, movement options, cash, portable stock radio and autosave. |
| Weapons | Weapon catalog, ammo/clip options, upgrades, explosive bullets and eight Special Gun modes. |
| Wanted | Wanted stars, never wanted, police ignore and dispatch/report controls. |
| Vehicles | Spawner, preview and saved vehicles, LS Customs and its subpages, vehicle controls, neon, chauffeur and cruise control. |
| World | Time/weather, IPLs, vision effects, gravity/time scale, door controls and World Mayhem. |
| Teleport | Waypoint/objective, stores, saved locations, coordinate entry and vehicle-aware teleporting. |
| Misc | Population/NPC options, HUD/radar controls, cleanup tools and live coordinates. |
| Menu | Language, Object Spooner, Custom NSC Loader, ScriptHookV-NX Plugins, appearance, positioning, open combo, persistent settings and credits. |

ScriptHookV-NX provides SD settings persistence and NRO discovery, startup modes,
manual loading, live status and cooperative process cancellation. The menu is
an optional frontend to that runtime; NROs can also autoload independently.

Descriptions use shared localized text rendering, wrapping and cached layout.
Language selection also supports following the game's language.

Additional SanScript examples included here are `chaosmod.sc` and
`cardealership.sc`. Build them separately with `Build-Any.ps1`; they are not
started automatically by the release builder.

Features depend on the target port's native support and available assets.
The feature list describes the source; it does not claim every option has
received a full hardware regression test. See [validation](CHANGELOG.md).
