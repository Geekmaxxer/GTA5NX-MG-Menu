// The scrollbar column is no longer rendered; reclaim that space on the
// right while keeping the menu's left edge in the same screen position.
CONST_FLOAT MENU_W 0.250
CONST_FLOAT MENU_TOP 0.150
CONST_FLOAT ROW_H 0.038
// Menu version, used by the on-screen version tag and the first-load welcome
// message so the two can never drift apart. Declared as a global string in
// core_globals.sch: this compiler has no CONST_STRING.
// Auto Save countdown position: absolute screen coordinates, kept together so
// the block can be nudged without touching the draw code.
// AUTO_SAVE_TIMER_X is the LEFT edge of both lines, not a right edge: the block
// is drawn left-justified (the form batch39 used, which rendered correctly on
// hardware) so the label and the timer always sit on two clean horizontal lines
// sharing this x. 0.800 pushes the pair further right as requested: "Auto
// Saving in:" is about 0.07 wide at scale 0.300, so the label ends near 0.87 and
// the large timer digits near 0.85 - both clear of the screen edge, and clear of
// the speedometer, which wraps at 0.905.
CONST_FLOAT AUTO_SAVE_TIMER_X 0.800
CONST_FLOAT AUTO_SAVE_TIMER_Y 0.012

// Portable Radio station catalog count (26 stations, excluding Self Radio).
CONST_INT RADIO_STATION_COUNT 26

// Emergency-vehicle siren mute (Vehicle Settings Row 27: Silent Sirens (Hold R3)).
// When enabled, driven by the horn input while seated in an EMERGENCY-class vehicle,
// so the only tuning is the hold time and the re-assert cadence.
// HOLD_MS is how long the horn must be held before the mute toggles; the hold
// detector latches on toggle so one long honk cannot flip it repeatedly.
CONST_INT SIREN_MUTE_HOLD_MS 1000
// Same bounded re-assert cadence the hazards use, for the same reason: some
// vehicle state changes re-enable the siren audio by themselves.
CONST_INT SIREN_MUTE_TICK_MS 500
// 1 = force the siren on when arming, so the mute has a running siren to
// silence and the light bar matches the muted siren. 0 = never touch the
// siren state and only drive the audio flag.
CONST_INT SIREN_MUTE_FORCE_SIREN 1
// 1 = assert SET_VEHICLE_ACT_AS_IF_HAS_SIREN_ON while muted so traffic and NPC
// reactions still yield even if the horn cycle left the siren off.
CONST_INT SIREN_MUTE_TRAFFIC_YIELD 1

// "Open Closest Door" (World and Weather tab).  The door search is staged over
// frames because there is no nearest-door native: every candidate model in
// util_door_catalog.sch has to be probed with its own spatial query.
// DOOR_SEARCH_RADIUS is how far each probe looks; 50m covers a street and the
// far side of most buildings without dragging in distant level geometry.
CONST_FLOAT DOOR_SEARCH_RADIUS 50.0
// Candidate models probed per frame.  746 models at 16/frame resolves in about
// 47 frames (~0.8s at 60fps).  This is the one tuning knob if the probe ever
// costs frame time on hardware.
CONST_INT DOOR_SCAN_PER_FRAME 16
// How long the Opened!/Closed!/No Doors result stays on the row.
CONST_INT DOOR_FEEDBACK_MS 3000
// "Touch Opens Doors" background proximity cache and per-frame sweep.
CONST_FLOAT TOUCH_DOOR_RADAR_RADIUS 15.0
CONST_INT TOUCH_DOOR_SCAN_PER_FRAME 24
CONST_INT TOUCH_DOOR_CACHE_SLOTS 4

// Persistent Settings submenu (util_persistence.sch). The row count lives here
// rather than in that module because features_main.sch needs it for
// ITEM_COUNT(), and this compiler requires every name to be declared before use:
// core_constants.sch is included before both, so it is the only place the count
// can be stated once and seen by both files.
//
// 14 rows are the feature plus its own storage diagnostics. Rows 14-24 are the
// frame-time probe readout (core_globals.sch g_prof_*), added for the v0.9.9
// hitch hunt: the hitch survived switching "Save To Disk After Change" off, so
// it had to be measured rather than reasoned about. They are read-only except
// row 24, which clears the counters, and none of them is a selector row (see
// IS_SELECTOR_ACTIVE in features_main.sch).
CONST_INT PERSIST_MENU_ROWS 25

// Persistent Settings storage geometry (util_persistence.sch). These two counts live
// here rather than in that module for the same reason PERSIST_MENU_ROWS does:
// core_globals.sch sizes the write-shadow arrays that PERSIST_SAVE_DELTA uses with
// them, and this compiler requires every name to be declared before use - and
// core_globals.sch is included long before util_persistence.sch. Same shape as
// STRIPPER_TRACK_MAX below, which sizes g_stripper_peds.
//
//   PERSIST_BOOL_SLOTS - one bit per setting; 64 bits x 3 containers = 192 usable,
//                        of which 37 are allocated in the registry.
//   PERSIST_INT_SLOTS  - one byte per setting; 8 bytes x 5 payload containers = 40.
CONST_INT PERSIST_BOOL_SLOTS 37
CONST_INT PERSIST_INT_SLOTS 27

// Bodyguard follow sweep (features_main.sch).  Guards inspected per follow tick.
// The sweep is round-robin and wraps, so the per-frame cost is bounded no matter
// how large the guard army is, while every guard is still visited within a few
// ticks at 128.  Before this the sweep walked the whole array and re-resolved
// each guard's slot with a linear scan, which made one tick O(n^2).
CONST_INT BODYGUARD_FOLLOW_SCAN_PER_TICK 128

// Misc "Explode All" (features_main.sch).  The sweep collects its candidates
// once, then the queue is drained this many vehicles per frame.  Detonating the
// whole sweep inside one tick was up to 64 explosions of physics, particle and
// audio work in a single frame; the same vehicles still explode, just spread
// over roughly (64 / this) frames.
CONST_INT EXPLODE_BURST_PER_FRAME 4

// Misc page row count.  Lives here because two places must agree on it:
// ITEM_COUNT() (features_main.sch) and DRAW_SCROLLING_ROWS() in DRAW_PAGE()
// (submenus_all.sch).  "Show Live Coordinates" at row 13 makes it 14.
CONST_INT MISC_MENU_ROWS 14
CONST_INT LIVE_COORDS_UPDATE_MS 125

// ---------------------------------------------------------------------------
// LS Customs depth (v0.9.9).  Row counts live here rather than in
// util_vehicle_catalog.sch for the same reason PERSIST_MENU_ROWS does:
// features_main.sch needs them for ITEM_COUNT(), and core_constants.sch is
// included before both, so this is the only place a count can be stated once
// and seen by every file that must agree on it.
// ---------------------------------------------------------------------------
// 19 original rows (0-18, every one hardware-verified - their indices are
// untouched) plus seven organised depth entries: Mod Kit, Mod Kit Type, Mod Kit
// Count, Hydraulics, Lowrider Interior, Wheels & Tyres, Extras & Livery, and
// (v0.9.9) three "get the right car" entries: Bennys & Lowriders, Convert To
// Custom and Vehicle Support Check.  A stock car has no hydraulic mod data in ANY
// kit, so these three rows are what turn "the hydraulics rows do nothing" into a
// car the player can actually fit them to.
CONST_INT LSC_MENU_ROWS 30
CONST_INT LSC_PLATE_STYLE_COUNT 13
// Hydraulics page: 18 hardware-verified rows (indices untouched) plus, appended
// so no verified index moves, row 18 "Lowrider Support" - the row that says why
// the other seventeen do nothing on a car that has no lowrider kit.
CONST_INT HYDRO_MENU_ROWS 19
CONST_INT INTERIOR_MENU_ROWS 11
// Wheels & Tyres: family, variation, wheel slot, apply, tyre smoke,
// tyres-can-burst and the reduced-suspension-force "stance" toggle.  Every row
// maps to a real native in commands_vehicle.sch; nothing here is invented.
// (There is no index-based tyre-smoke colour native - only
// SET_VEHICLE_TYRE_SMOKE_COLOR taking raw RGB - so that row is deliberately not
// offered rather than shipping a guessed palette.)
CONST_INT WHEELTYRE_MENU_ROWS 10
// MOD_WHEEL_TYPE members 0-12: Sport, Muscle, Lowrider, SUV, Offroad, Tuner,
// Bike, HiEnd, then Supermod1-5.  The old LSC "Wheel Type" row stopped at 9, so
// the last three families were unreachable.
CONST_INT WHEEL_FAMILY_COUNT 13
// Extras & Livery: livery index/name/apply, then the 12 vehicle extras
// (DOES_EXTRA_EXIST / IS_VEHICLE_EXTRA_TURNED_ON / SET_VEHICLE_EXTRA).
CONST_INT LSC_EXTRAS_MENU_ROWS 10

// Bennys & Lowriders page: the custom variants that can actually carry the
// lowrider kit, one row each, all spawnable.
//
// The list and its stock counterparts are NOT guesswork and NOT taken from a
// wiki.  They are Rockstar's own tables, read out of this port's shipped dev
// source (X:\gta5\script\dev_ng) so the names are guaranteed to be legal
// identifiers in this build as well:
//
//   shared\include\public\vehicle_public.sch
//     GET_VEHICLE_SUPERMOD_MODEL()          -> stock  -> custom
//     GET_SUPERMOOD_VEHICLE_BASE_MODEL()    -> custom -> stock
//     IS_VEHICLE_A_SUPERMOD_MODEL(..., SUPERMOD_FLAG_HAS_HYDRAULICS)
//
// That third function is Rockstar's own answer to "which cars have hydraulics",
// and it corrects two things a name-based guess gets wrong:
//   * VOODOO is the CUSTOM and VOODOO2 is the plain stock car (inverted naming).
//   * The custom Tornado is TORNADO5, not TORNADO2.
//   * The custom Virgo's base is VIRGO3 (Virgo Classic), not VIRGO.
// BENNYS_MENU_ROWS is exactly the number of verified hydraulics-capable models.
CONST_INT BENNYS_MENU_ROWS 12

// Vehicle Support Check page.  Read-only diagnostics: this is the page that
// answers "why can I not fit hydraulics to this car", and it is what makes the
// hydraulics page honest instead of silently doing nothing.  Every row maps to an
// already-used native (GET_NUM_VEHICLE_MODS / IS_TOGGLE_MOD_ON / GET_NUM_MOD_KITS
// / GET_VEHICLE_MOD_KIT / GET_VEHICLE_MOD_KIT_TYPE / GET_ENTITY_MODEL /
// IS_MODEL_IN_CDIMAGE / GET_DISPLAY_NAME_FROM_VEHICLE_MODEL), so it adds no new
// native to the table.
CONST_INT SUPPORTCHECK_MENU_ROWS 10

// Convert To Custom staging.  The conversion is asynchronous for the same reason
// the vehicle spawner is (the target model has to stream), so it needs a request
// timeout; 8s matches the spawner's own 8000ms wait exactly.
CONST_INT CONVERT_REQUEST_TIMEOUT_MS 8000
// How long the row keeps showing the outcome of a conversion before returning to
// its preview state.  Same convention as DOOR_FEEDBACK_MS.
CONST_INT CONVERT_FEEDBACK_MS 4000

// Hydraulics "Hold Stance" re-assert cadence.  Same bounded cadence the siren
// mute (SIREN_MUTE_TICK_MS) and the hazards use, for the same reason: some
// vehicle state changes reset the hydraulic state by themselves, but
// re-asserting every frame would be a per-frame native burst for no visible
// gain.  500ms is below the point where a reset is noticeable.
CONST_INT HYDRO_HOLD_TICK_MS 500
// Stance presets offered by the hydraulics page (see HYDRO_PRESET_* ordering in
// util_vehicle_catalog.sch: Stock, Slammed, Max High, Bouncy, Free, Front Up,
// Rear Up, Lean Left, Lean Right).
CONST_INT HYDRO_PRESET_COUNT 9
// Height sliders are 0-100% in 5% steps (21 levels), stored as 0-20 so the row
// can use DRAW_NUMBER_OPTION: this compiler renders a float value as a blank
// row on Switch (see NEON_ANIM_SPEED_VALUE note in features_main.sch).
CONST_INT HYDRO_HEIGHT_LEVELS 21

// Spawn Stripper (Misc).  How many menu-owned stripper peds are tracked.  A
// bounded ring, not an ever-growing array: mashing A replaces the oldest ped
// instead of leaking one entity per press.
CONST_INT STRIPPER_TRACK_MAX 128
// The four models the Left/Right selector cycles (see STRIPPER_MODEL_FOR_CHOICE
// in util_ped_catalog.sch), and the lowrider slot list the Interior page walks.
CONST_INT STRIPPER_MODEL_COUNT 4
// Lowrider slots offerable by the Lowrider Interior page: INTERIOR1-5, SEATS,
// STEERING, KNOB, PLAQUE, ICE, TRUNK, ENGINEBAY1-3, CHASSIS2-5, DOOR_L, DOOR_R,
// PLTHOLDER, PLTVANITY.  MOD_HYDRO is deliberately excluded - it has its own
// page, where its height/state native pairs live.
CONST_INT INTERIOR_SLOT_COUNT 22

// Chauffeur submenu (Vehicle Settings tab, util_chauffeur.sch).
//
// A hired driver: spawns a black SUV with an NPC driver, seats the player in
// the front passenger seat, and drives to the player's waypoint - or cruises
// when there is not one.  The driving model is Rockstar's own taxi driver
// (X:\gta5\script\dev_ng\singleplayer\scripts\Ambient\Misc\taxiService.sc),
// whose two DRIVINGMODE flag sets and 12.0/25.0 cruise speeds are reused
// verbatim rather than invented.
CONST_INT CHAUFFEUR_MENU_ROWS 8
// The default black SUV.  SUBURBAN is NOT a model in this port's MODEL_NAMES
// enum (checked against core\game\data\model_enums.sch), so GRANGER - the
// federal SUV - stands in for it and is painted black.
CONST_INT CHAUFFEUR_VEHICLE_COUNT 14
// Cruise speeds, from taxiService.sc TAXI_SPEED_NORMAL / TAXI_SPEED_FAST, plus Aggressive.
CONST_FLOAT CHAUFFEUR_SPEED_NORMAL 12.0
CONST_FLOAT CHAUFFEUR_SPEED_RUSHED 25.0
CONST_FLOAT CHAUFFEUR_SPEED_AGGRESSIVE 40.0
// Same target radius / straight-line distance taxiLauncher.sc passes to
// TASK_VEHICLE_DRIVE_TO_COORD.
CONST_FLOAT CHAUFFEUR_TARGET_RADIUS 20.0
// The car and the driver stream separately, so the staged request waits for
// both; 8s matches the spawner's own wait exactly.
CONST_INT CHAUFFEUR_REQUEST_TIMEOUT_MS 8000
// Bounded re-assert cadence for the driver's god mode / tyres / drive task,
// the same shape SIREN_MUTE_TICK_MS and HYDRO_HOLD_TICK_MS already use.  It
// exists so the chauffeur can never become a per-frame native burst.
CONST_INT CHAUFFEUR_TICK_MS 500
// Armed Driver engagement radius, measured from the car - not the driver -
// because a seated driver's own position leads or lags the chase.
CONST_FLOAT CHAUFFEUR_ARMED_RANGE 50.0
// Default weapon: Micro SMG.  A one-handed gun so the drive-by pose works;
// MENU_WEAPON_FOR_CHOICE(11) is WEAPONTYPE_MICROSMG.
CONST_INT CHAUFFEUR_DEFAULT_WEAPON_CHOICE 11

// Object Spooner submenu (Menu Settings tab Row 0, util_spooner.sch).
// Purely live-session memory entity spawner, relative matrix positioner,
// physics controller, bone attachment manager, and Switch pool cleaner.
CONST_INT SPOONER_MENU_ROWS 21
CONST_INT SPOONER_MAX_OBJECTS 128
CONST_INT SPOONER_CATALOG_COUNT 314
CONST_INT SPOONER_BONE_COUNT 10
CONST_INT SPOONER_FEEDBACK_MS 2200

// Maximum tracked spawned custom vehicles in g_spawned_custom_vehicles[].
CONST_INT MAX_TRACKED_CUSTOM_VEHICLES 128

// Custom NSC Loader submenu (Menu Settings tab Row 1, util_nsc_loader.sch).
// Switch keyboard .nsc filename entry (filtering out the 1,026 stock script_rel.rpf
// scripts and ragemenu.nsc), menu persistence across launches, active THREADID
// Header rows are dynamically returned by FUNC INT NSC_LOADER_HEADER_ROWS()
// in util_nsc_loader.sch (4 when >= 1 custom script is active, 3 when none).
CONST_INT NSC_MAX_CUSTOM_SCRIPTS 16
CONST_INT NSC_MAX_SAVED_LETTERS 100
CONST_INT NSC_PERSIST_SLOTS_PER_CHAR 44
CONST_INT NSC_PERSIST_CHAR_SLOTS 132
CONST_INT NSC_PERSIST_EXT_SLOTS 132
CONST_INT NSC_PERSIST_SEP_CODE 62
CONST_INT NSC_STAGE_IDLE 0
CONST_INT NSC_STAGE_TERMINATING 1
CONST_INT NSC_STAGE_LOADING 2
CONST_INT NSC_LOAD_TIMEOUT_MS 6000
CONST_INT NSC_TERMINATE_TIMEOUT_MS 2000
CONST_INT NSC_FEEDBACK_MS 2200

// Credits submenu (Menu Settings tab bottom row).
CONST_INT CREDITS_MENU_ROWS 6

// Special Gun Modes (Weapon Options tab Row 7, util_weapons.sch).
// 0 = OFF, 1 = Gravity Gun, 2 = Teleport Gun, 3 = Delete Gun,
// 4 = Airstrike Gun, 5 = Vehicle Gun, 6 = Force Gun, 7 = PED Gun.
CONST_INT SPECIAL_GUN_COUNT 8

// World Mayhem submenu (World and Weather tab Row 16, util_world.sch).
// 0 = City Blackout / EMP, 1 = Meteor Shower, 2 = Armed Ped Riot, 3 = Crazy Drivers.
CONST_INT WORLD_MAYHEM_MENU_ROWS 4

// Language submenu (Menu Settings tab Row 0).
// 0 = English, 1 = Spanish, 2 = German,
// 3 = Russian, 4 = Portuguese, 5 = French.
CONST_INT LANGUAGE_MENU_ROWS 6

// Custom Story PEDs submenu (PED Changer Row 0, util_story_peds.sch).
// 112 named story characters (0..111); the currently active playable protagonist
// (0 = Michael, 1 = Franklin, 2 = Trevor) is dynamically hidden from the list so
// 111 characters are visible at any time.
CONST_INT STORY_CHAR_COUNT 112
CONST_INT STORY_CS_MAX 8
CONST_INT STORY_PROXY_MAX 4

// ScriptHookV-NX Plugins Manager (Menu Settings tab Row 3, util_plugin_manager.sch).
CONST_INT PLUGIN_MGR_MAX_PLUGINS 16


