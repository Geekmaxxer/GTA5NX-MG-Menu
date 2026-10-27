// Bridge Natives for ScriptHookV-NX persistence
NATIVE FUNC BOOL MEGASAVE(INT &buffer, INT size, INT testStorage = 0) = "0x4d45474153415645"
NATIVE FUNC INT MEGALOAD(INT &buffer, INT size, INT testStorage = 0) = "0x4d4547414c4f4144"

BOOL g_open = FALSE
BOOL g_home = TRUE
INT g_tab = 0
INT g_item = 0
INT g_scroll = 0
INT g_home_item = 0
INT g_home_scroll = 0
INT g_page_item[8]
INT g_page_scroll[8]
INT g_lsc_item = 0
INT g_lsc_scroll = 0
INT g_time_choice = 1
INT g_weather_choice = 0
BOOL g_god = FALSE
BOOL g_invisible = FALSE
BOOL g_no_ragdoll = FALSE
BOOL g_fast_run = FALSE
BOOL g_fast_swim = FALSE
BOOL g_super_jump = FALSE
BOOL g_drunk = FALSE
BOOL g_infinite_ammo = FALSE
BOOL g_infinite_clip = FALSE
BOOL g_explosive_ammo = FALSE
BOOL g_weapon_upgrades_open = FALSE
INT g_weapon_upgrades_item = 0
INT g_weapon_upgrades_scroll = 0
INT g_weapon_tint_choice = 0
INT g_weapon_choice = 0
// Ring buffer of entities spawned by Special Gun (Vehicle Gun / PED Gun).
INT g_projectile_slot = 0
VEHICLE_INDEX g_projectile_vehicles[16]
PED_INDEX g_projectile_peds[16]
BOOL g_explosive_melee = FALSE
BOOL g_super_punch = FALSE
INT g_super_punch_time = 0
BOOL g_infinite_parachute = FALSE
// Staged "Explode All" (Misc row).  EXPLODE_ALL_NEARBY_VEHICLES fills this queue
// once and PROCESS_EXPLODE_QUEUE drains a few vehicles per frame, so one press
// can never detonate the whole sweep inside a single tick.  The queue is plain
// state rather than a task, so it cannot be left running.
VEHICLE_INDEX g_explode_queue[64]
INT g_explode_queue_count = 0
INT g_explode_queue_index = 0
INT g_attacker_weapon_choice = 0
BOOL g_attacker_spawn_pending = FALSE
MODEL_NAMES g_pending_attacker_model = PLAYER_ZERO
WEAPON_TYPE g_pending_attacker_weapon = WEAPONTYPE_PISTOL
INT g_attacker_request_time = 0
PED_INDEX g_menu_attackers[128]
INT g_menu_attacker_count = 0
BOOL g_attacker_god = FALSE
BOOL g_attacker_open = FALSE
INT g_attacker_item = 0
INT g_attacker_scroll = 0
BOOL g_attacker_rage = FALSE
BOOL g_never_wanted = FALSE
BOOL g_ignore_police = FALSE
INT g_wanted_level_choice = 5
BOOL g_vehicle_god = FALSE
BOOL g_seatbelt = FALSE
BOOL g_doors_locked = FALSE
BOOL g_mobile_radio = FALSE
BOOL g_was_in_vehicle = FALSE
BOOL g_player_in_vehicle = FALSE
// ===========================================================================
// Smooth 30 FPS Frame Optimization Cache & Stagger Dispatcher
// ===========================================================================
PED_INDEX g_cached_player_ped = NULL
PLAYER_INDEX g_cached_player_id = NULL
VECTOR g_cached_player_coords = <<0.0, 0.0, 0.0>>
BOOL g_cached_player_in_veh = FALSE
VEHICLE_INDEX g_cached_player_veh = NULL
BOOL g_cached_player_dead = FALSE
INT g_frame_phase = 0
BOOL g_special_gun_clean_needed = FALSE
BOOL g_dispatch = TRUE
BOOL g_civilian_reports = TRUE
BOOL g_night_vision = FALSE
BOOL g_thermal_vision = FALSE
BOOL g_motion_blur = FALSE
BOOL g_camera_shake = FALSE
BOOL g_vehicle_auto_repair = FALSE
BOOL g_vehicle_always_max = FALSE
VEHICLE_INDEX g_vehicle_always_max_applied_vehicle = NULL
BOOL g_vehicle_quick_entry_exit = FALSE
BOOL g_vehicle_horn_boost = FALSE
FLOAT g_horn_boost_speed = 10.0
BOOL g_vehicle_turbo = FALSE
INT g_vehicle_acceleration_level = 0
// g_npc_vehicle_speed_level and its tracking state (g_npc_speed_next_update,
// g_npc_speed_applied, g_npc_speed_tracked[64], g_npc_speed_tracked_count) were
// removed in batch38 with the NPC Vehicle Speed row.
BOOL g_godmode_tow_hook = FALSE
VEHICLE_INDEX g_tow_hook_towed = NULL
INT g_vehicle_grip_level = 0
BOOL g_vehicle_bulletproof_tyres = FALSE
// Tracks whether the bulletproof-tyres toggle is currently forcing the tyres
// unburstable, so the main loop can restore bursting exactly once on the falling
// edge.  Without it the loop had to write TRUE every frame, which made the
// Wheels & Tyres "Tyres Can Burst" row impossible to switch off.
BOOL g_bulletproof_tyres_applied = FALSE
BOOL g_vehicle_speedometer = FALSE
INT g_vehicle_speed_unit = 0
VEHICLE_INDEX g_speedometer_cached_veh = NULL
STRING g_speedometer_cached_name = ""
BOOL g_lsc_open = FALSE
VEHICLE_INDEX g_lsc_vehicle
INT g_lsc_slot_choice = 0
INT g_lsc_mod_choice = -1
INT g_lsc_primary_colour = 0
INT g_lsc_secondary_colour = 0
INT g_lsc_pearlescent_colour = 0
INT g_lsc_wheel_colour = 0
INT g_lsc_xenon_colour = 0
INT g_lsc_neon_colour = 0
INT g_lsc_wheel_type = 0
INT g_lsc_window_tint = 0
INT g_lsc_plate_style = 0
BOOL g_lsc_turbo = FALSE
BOOL g_lsc_xenon = FALSE
BOOL g_lsc_neon = FALSE
// ---- LS Customs depth (v0.9.9) -------------------------------------------
// Mod kit awareness.  Every LSC write path used to force SET_VEHICLE_MOD_KIT
// (vehicle, 0), which is the *stock* kit.  On a car whose interior / hydraulics
// / chassis2-5 / lowrider variants live in a second kit (the lowrider add-on
// kits) GET_NUM_VEHICLE_MODS reported 0 for exactly those slots, so the
// Interior rows could never do anything no matter which car was used.  The
// choice is an explicit index into the car's own kit list; -1 means "follow the
// car", which is what SYNC_LSC_VEHICLE_STATE() writes back after resolving it,
// so the row always shows the kit that is actually active.
INT g_lsc_kit_choice = -1
// Submenu navigation state.  One open flag / item / scroll per page, matching
// the Neon Animation and Vehicle Control submenus exactly.
BOOL g_hydro_open = FALSE
INT g_hydro_item = 0
INT g_hydro_scroll = 0
BOOL g_interior_open = FALSE
INT g_interior_item = 0
INT g_interior_scroll = 0
BOOL g_wheeltyre_open = FALSE
INT g_wheeltyre_item = 0
INT g_wheeltyre_scroll = 0
BOOL g_lsc_extras_open = FALSE
INT g_lsc_extras_item = 0
INT g_lsc_extras_scroll = 0
// Hydraulics state.  g_hydro_level is an index into MOD_HYDRO (-1 = stock);
// g_hydro_hold_preset/g_hydro_hold_level remember what the hold tick re-asserts
// so the same values are pushed back, not the live selector values (which may
// have been moved on without pressing Apply).
INT g_hydro_level = -1
BOOL g_hydro_enabled = FALSE
BOOL g_hydro_control = FALSE
INT g_hydro_preset = 0
INT g_hydro_front_height = 20
INT g_hydro_rear_height = 20
INT g_hydro_left_height = 20
INT g_hydro_right_height = 20
INT g_hydro_wheel = 0
INT g_hydro_wheel_height = 20
INT g_hydro_wheel_state = 0
INT g_hydro_raise_speed = 4
BOOL g_hydro_hold = FALSE
BOOL g_hydro_soft = FALSE
INT g_hydro_hold_preset = 0
INT g_hydro_hold_tick = 0
// Lowrider interior page.  g_interior_slot is an index into the lowrider slot
// list (`INTERIOR_SLOT()` in util_vehicle_catalog.sch), not a raw MOD_TYPE, so
// the selector can be labelled and bounds-checked in one place.
INT g_interior_slot = 0
INT g_interior_choice = -1
INT g_interior_fill_index = 0
INT g_lsc_trim_colour = 0
INT g_lsc_metal_colour = 0
// Wheels & Tyres page.
INT g_wheeltyre_variation = 0
BOOL g_wheeltyre_smoke = FALSE
BOOL g_wheeltyre_can_burst = TRUE
BOOL g_wheeltyre_soft_suspension = FALSE
// FALSE = MOD_WHEELS (front / all wheels), TRUE = MOD_REAR_WHEELS (the bike rear
// wheel slot).  Both are real MOD_TYPE members.
BOOL g_wheeltyre_rear_slot = FALSE
// Extras & Livery page.  g_lsc_livery -1 = stock; g_lsc_extra is the Extras
// slot (0-11).  g_lsc_extra_exists / g_lsc_extra_on hold the last probe result so
// the toggle path cannot write an extra the car does not carry.
INT g_lsc_livery = -1
INT g_lsc_extra = 0
BOOL g_lsc_extra_exists = FALSE
BOOL g_lsc_extra_on = FALSE

// ---- Bennys / lowrider capability (v0.9.9) --------------------------------
// The three LSC rows that exist to get the player into a car that can actually
// take a lowrider kit.  Nothing here duplicates state that already lives above:
// the kit/level globals are read back by SYNC_LSC_VEHICLE_STATE, and the
// conversion reuses the proven spawner globals for its model request.
BOOL g_bennys_open = FALSE
INT g_bennys_item = 0
INT g_bennys_scroll = 0
// Vehicle Support Check page.  Read-only: no apply path, no selector, so nothing
// on it can change the car or the menu.
BOOL g_support_open = FALSE
INT g_support_item = 0
INT g_support_scroll = 0

// Convert To Custom.  The conversion is asynchronous for the same reason the
// spawner is - the target model has to stream - and it is staged so an aborted
// or failed conversion can never delete the car the player is sitting in.
// g_convert_pair is the verified stock->custom table index (-1 = not running);
// g_convert_source_vehicle is the car being replaced, kept only so it can be
// deleted AFTER the player is confirmed to be in the new one.
BOOL g_convert_pending = FALSE
INT g_convert_pair = -1
INT g_convert_request_time = 0
VEHICLE_INDEX g_convert_source_vehicle
// Result feedback for the Convert To Custom row: 0 idle, 1 converted,
// 2 no variant for this car, 3 target model absent from this build,
// 4 could not create the target, 5 timeout.
INT g_convert_feedback = 0
INT g_convert_feedback_until = 0

// ---- Spawn Stripper (Misc row 12) ----------------------------------------
// Bounded ring of menu-owned peds, exactly like g_brawl_peds: PRINT/PRUNE
// walk it and the oldest entry is replaced once it is full, so mashing A can
// never leak an entity per press.
INT g_stripper_choice = 0
BOOL g_stripper_spawn_pending = FALSE
MODEL_NAMES g_pending_stripper_model = S_F_Y_STRIPPER_01
INT g_stripper_request_time = 0
PED_INDEX g_stripper_peds[STRIPPER_TRACK_MAX]
INT g_stripper_count = 0
INT g_stripper_write_index = 0
INT g_vehicle_spawn_choice = 0
INT g_vehicle_spawn_category = 0
INT g_dlc_vehicle_index = 0
INT g_dlc_cars_count = -1
INT g_dlc_bikes_count = -1
INT g_dlc_aircraft_count = -1
INT g_dlc_boats_count = -1
BOOL g_vehicle_spawn_pending = FALSE
BOOL g_delete_previous_spawned_vehicle = TRUE
BOOL g_spawn_teleport_into_vehicle = FALSE
VEHICLE_INDEX g_last_spawned_vehicle
VEHICLE_INDEX g_spawned_custom_vehicles[MAX_TRACKED_CUSTOM_VEHICLES]
INT g_spawned_custom_vehicle_count = 0
MODEL_NAMES g_pending_vehicle_model = ADDER
INT g_vehicle_spawn_request_time = 0
BOOL g_spawner_open = FALSE
INT g_spawner_item = 0
INT g_spawner_scroll = 0
BOOL g_vehicle_list_open = FALSE
BOOL g_tp_stores_open = FALSE
INT g_tp_stores_item = 0
INT g_tp_stores_scroll = 0
BOOL g_tp_locs_open = FALSE
INT g_tp_locs_item = 0
INT g_tp_locs_scroll = 0
BOOL g_timeweather_open = FALSE
INT g_timeweather_item = 0
INT g_timeweather_scroll = 0
INT g_spawn_count = 1
BOOL g_spawn_maxed = FALSE
INT g_spawn_alignment = 0
INT g_spawn_facing = 0
BOOL g_auto_waypoint = FALSE
BOOL g_auto_waypoint_seen = FALSE
VECTOR g_last_auto_waypoint = <<0.0, 0.0, 0.0>>
BOOL g_auto_objective = FALSE
BOOL g_auto_objective_was_in_cutscene = FALSE
BOOL g_auto_objective_pending = FALSE
INT g_auto_objective_tp_time = 0
BOOL g_outfit_open = FALSE
INT g_outfit_item = 0
INT g_outfit_scroll = 0
BOOL g_radio_open = FALSE
INT g_radio_item = 0
INT g_radio_scroll = 0
INT g_radio_station_index = 0
BOOL g_ped_open = FALSE
// g_statman_* / g_stat_* / g_stat_verify_* used to live here. Removed with the
// Stat Manager submenu (see util_ped_catalog.sch).
// Auto-save feedback / HUD state.
BOOL g_auto_save_pending_announce = FALSE
INT g_auto_save_pending_since = 0
BOOL g_welcome_shown = FALSE
INT g_menu_start_time = 0
INT g_npc_density_choice = 2
INT g_pop_multiplier_sphere = -1
INT g_ped_item = 0
INT g_ped_scroll = 0
INT g_ped_choice = 0
BOOL g_ped_search_not_found = FALSE
INT g_ped_search_error = 0 // 1: seated; 2: streaming timeout
BOOL g_ped_search_has_value = FALSE
STRING g_ped_search_value = ""
BOOL g_ped_search_is_custom = FALSE
STRING g_current_ped_label = "PLAYER_ZERO"
MODEL_NAMES g_current_ped_label_model = PLAYER_ZERO
INT g_character_slot = 0
MODEL_NAMES g_franklin_ped = PLAYER_ZERO
MODEL_NAMES g_michael_ped = PLAYER_ONE
MODEL_NAMES g_trevor_ped = PLAYER_TWO
MODEL_NAMES g_pending_ped_model = PLAYER_ZERO
BOOL g_ped_change_pending = FALSE
INT g_ped_request_time = 0
INT g_spawn_remaining = 0
INT g_active_spawn_count = 0
INT g_spawn_index = 0
INT g_spawn_warp_index = -1
FLOAT g_spawn_heading = 0.0
BOOL g_keyboard_active = FALSE
INT g_keyboard_target = 0
INT g_cash_amount = 0
BOOL g_unlimited_oxygen = FALSE
BOOL g_unlimited_ability = FALSE
FLOAT g_teleport_x = 0.0
FLOAT g_teleport_y = 0.0
FLOAT g_teleport_z = 0.0
BOOL g_teleport_pending = FALSE
VECTOR g_pending_teleport_destination = <<0.0, 0.0, 0.0>>
INT g_teleport_request_time = 0
STRING g_vehicle_search_value = ""
BOOL g_vehicle_search_not_found = FALSE
BOOL g_vehicle_search_has_value = FALSE
INT g_time_hour = 12
INT g_time_minute = 0
INT g_time_second = 0
BOOL g_pause_time = FALSE
INT g_ipl_preset = 0
STRING g_custom_ipl_name = ""
STRING g_plate_value = ""
BOOL g_everyone_ignores = FALSE
BOOL g_low_population = FALSE
BOOL g_hud_hidden = FALSE
BOOL g_radar_hidden = FALSE
BOOL g_first_person = FALSE
BOOL g_accent_rgb = FALSE
INT g_accent_rgb_step = 0
INT g_accent_rgb_time = 0
INT g_accent_rgb_speed_index = 4
BOOL g_player_noclip = FALSE
BOOL g_player_freecam = FALSE
FLOAT g_player_noclip_z = 0.0
FLOAT g_player_noclip_ground_offset = 1.0
INT g_neon_speed_index = 4
PED_INDEX g_bodyguards[128]
BLIP_INDEX g_bodyguard_blip_handles[128]
INT g_bodyguard_count = 0
BOOL g_bodyguard_god = FALSE
BOOL g_bodyguard_open = FALSE
INT g_bodyguard_item = 0
INT g_bodyguard_scroll = 0
INT g_bodyguard_weapon_choice = 2
INT g_bodyguard_formation_choice = 0
BOOL g_bodyguard_follow = TRUE
BOOL g_bodyguard_allow_vehicle = TRUE
BOOL g_bodyguard_tp_too_far = TRUE
INT g_bodyguard_tp_distance = 50
BOOL g_guard_ped_open = FALSE
// Guard/attacker ped defaults are rebound to the real catalog entry named
// PLAYER_ZERO by INIT_MENU_DEFAULTS(); the literals below are only pre-init
// placeholders (choice 0 is the catalog's first model, which is A_C_BOAR).
INT g_guard_ped_item = 0
INT g_guard_ped_scroll = 0
INT g_guard_ped_choice = 0
STRING g_guard_ped_name = "PLAYER_ZERO"
BOOL g_guard_ped_search_not_found = FALSE
// Set when a bodyguard/attacker ped was typed by name and is not one of the
// catalog entries.  The spawn path then uses g_*_ped_model directly instead of
// indexing the catalog, so any ped in the game can guard you.
BOOL g_guard_ped_search_is_custom = FALSE
MODEL_NAMES g_guard_ped_model = PLAYER_ZERO
BOOL g_attacker_ped_open = FALSE
INT g_attacker_ped_item = 0
INT g_attacker_ped_scroll = 0
INT g_attacker_ped_choice = 0
STRING g_attacker_ped_name = "PLAYER_ZERO"
BOOL g_attacker_ped_search_not_found = FALSE
BOOL g_attacker_ped_search_is_custom = FALSE
MODEL_NAMES g_attacker_ped_model = PLAYER_ZERO
INT g_time_scale_level = 4
INT g_gravity_choice = 0
GROUP_INDEX g_bodyguard_group = NULL
INT g_bodyguard_follow_tick = 0
// Round-robin cursor for the follow sweep: the pass over the guard array is
// spread across ticks so a large guard army cannot cost one frame the whole scan.
INT g_bodyguard_scan_index = 0
BOOL g_bodyguard_blips = TRUE
BOOL g_bodyguard_spawn_pending = FALSE
MODEL_NAMES g_pending_bodyguard_model = PLAYER_ZERO
INT g_bodyguard_request_time = 0
BOOL g_neon_anim_open = FALSE
INT g_neon_anim_item = 0
INT g_neon_anim_scroll = 0
INT g_neon_mode = 0
INT g_neon_transition = 0
INT g_neon_anim_step = 0
INT g_neon_anim_time = 0
INT g_neon_saved_colour = 0
// Vehicle Control submenu (Vehicle Settings row 3). Mirrors the Neon Animation
// submenu pattern: its own open/item/scroll state plus one global per feature.
// g_vehicle_dirt_level is a 0-30 level index (0.5 dirt per step, i.e. 0.0-15.0)
// because the menu has no float-to-string formatter for row values.
BOOL g_vehicle_control_open = FALSE
INT g_vehicle_control_item = 0
INT g_vehicle_control_scroll = 0
INT g_vehicle_window_action = 0
INT g_vehicle_window_choice = 0
INT g_vehicle_seat_choice = 0
INT g_vehicle_dirt_level = 0
BOOL g_vehicle_hazards = FALSE
INT g_vehicle_hazards_tick = 0
BOOL g_skip_cutscenes = FALSE
BOOL g_vehicle_preview_enabled = TRUE
VEHICLE_INDEX g_vehicle_preview_vehicle = NULL
MODEL_NAMES g_vehicle_preview_model = DUMMY_MODEL_FOR_SCRIPT
INT g_vehicle_preview_request_time = 0
BOOL g_npc_brawl = FALSE
INT g_next_npc_brawl_update = 0
PED_INDEX g_brawl_peds[32]
INT g_brawl_ped_count = 0
BOOL g_respawn_at_death = FALSE
BOOL g_respawn_pending = FALSE
INT g_respawn_ready_ticks = 0
VECTOR g_last_living_position = <<0.0, 0.0, 0.0>>
INT g_respawn_location_choice = 4
INT g_menu_combo = 0
BOOL g_ped_death_recovery = FALSE
MODEL_NAMES g_ped_pre_death_model = PLAYER_ZERO
INT g_ped_stable_control_ticks = 0
INT g_accent_choice = 0
INT g_accent_r = 31
INT g_accent_g = 100
INT g_accent_b = 190
FLOAT g_menu_x = 0.200
FLOAT g_menu_y = 0.000
INT g_next_up_repeat = 0
INT g_next_down_repeat = 0
INT g_next_left_repeat = 0
INT g_next_right_repeat = 0
STRING g_selected_description = "Select an option."
// Shared description layout cache: no measurement or slicing on unchanged frames.
STRING g_description_cached_value = ""
TEXT_LABEL_63 g_description_chunks[10]
INT g_description_chunk_count = 0
INT g_description_cached_language = -1
FLOAT g_description_cached_x = 0.0
FLOAT g_description_cached_y = 0.0
FLOAT g_description_scale = 0.3
FLOAT g_description_height = 0.0
INT g_description_lines = 0
BOOL g_description_layout_valid = FALSE
SCALEFORM_INDEX g_instructional_scaleform = NULL

// Performance optimization caches & dirty flags
INT g_instructional_buttons_mode = -1
INT g_instructional_cached_lang = -1
BOOL g_show_instructional_buttons = TRUE
BOOL g_menu_nav_dirty = TRUE
BOOL g_description_dirty = TRUE
INT g_description_cached_item = -1
INT g_description_cached_page_id = -1
FLOAT g_description_cached_extra_height = -0.020
BOOL g_chaos_mod_running = FALSE
INT g_chaos_mod_check_timer = 0
INT g_next_prune_tracked_entities_timer = 0
TEXT_LABEL_63 g_live_coords_cached_line_x = ""
TEXT_LABEL_63 g_live_coords_cached_line_y = ""
TEXT_LABEL_63 g_live_coords_cached_line_z = ""
FLOAT g_live_coords_cached_coord_x = 0.850

// Single source of truth for the menu version (version tag + welcome message).
STRING g_menu_version = "v1.0.8"
INT g_menu_language = 0
BOOL g_language_open = FALSE
INT g_language_item = 0
INT g_language_scroll = 0

// Auto Save (Player Settings): a silent timer-driven DO_AUTO_SAVE. The interval
// is in minutes; 0 means "toggle on, but never fire".
BOOL g_auto_save = FALSE
INT g_auto_save_interval = 10
INT g_next_auto_save_time = 0

// Persistent settings (see util_persistence.sch). Direct SD Card storage via
// ScriptHookV-NX (subsdk5). Eliminates game save file modification and corruption.
BOOL g_persist_enabled = TRUE
BOOL g_persist_save_disk = TRUE
BOOL g_persist_load_done = FALSE
BOOL g_persist_dirty = FALSE
INT g_persist_load_attempts = 0
INT g_persist_next_write = 0

// ScriptHookV-NX Direct SD Card Storage Buffer (1024 words = 4096 bytes, 4KB page aligned)
INT g_persist_sd_data[1024]

// Write shadow (v0.9.9 hitch fix).  PERSIST_SAVE_DELTA - the writer the frame loop
// uses - compares each setting against the value this array says is already in the
// containers and writes only the difference.  A toggle or one Left/Right step
// changes a single slot, so a flush costs ~15 stat writes instead of all 240 that
// PERSIST_SAVE_ALL performs, and the per-action hitch the burst caused goes with
// them.  Declared as INT rather than BOOL so it can be compared numerically; the
// legal values are 0 and 1.
//
// g_persist_shadow_valid is FALSE whenever the containers may not hold what the
// shadow claims, in which case the next flush writes every slot and rebuilds it:
//   - after a boot that found no saved state (the containers have to be seeded),
//   - after PERSIST_CLEAR_ALL, which zeroes storage while the menu globals keep
//     their values, so the next flush has to restore all of them rather than the
//     one setting that happens to change next.
BOOL g_persist_shadow_valid = FALSE
INT g_persist_shadow_bool[PERSIST_BOOL_SLOTS]
INT g_persist_shadow_int[PERSIST_INT_SLOTS]
// When the current dirty run began.  MARK_PERSIST_DIRTY restarts the quiet window on
// every change so the write lands after the player stops interacting, and this caps
// how far that can be deferred so a long session of continuous fiddling still
// converges instead of never being written.
INT g_persist_dirty_since = 0
// Diagnostics shown by the Persistence submenu.
INT g_persist_written = 0
INT g_persist_failed = 0
// -1 = not checked, 0 = mismatch, 1 = matched.
INT g_persist_checksum_ok = -1
// 0 = saved state restored, 1 = no saved state, 2 = saved state had the feature
// switched off.
INT g_persist_boot_status = 1
// Human-readable result of the last self-test or Save/Reset action, shown on the
// "Self-Test Result" row.
STRING g_persist_status_text = "Not tested"
INT g_persist_selftest_pass = 0
INT g_persist_selftest_fail = 0
// Persistence submenu navigation state, mirroring the other submenus.
BOOL g_persist_open = FALSE
INT g_persist_item = 0
INT g_persist_scroll = 0

// "Open Closest Door" / "Close Closest Door" scan state.  The scan is staged
// over frames (see PROCESS_DOOR_SCAN in util_world.sch) because the door model
// list is far too large to probe in one tick.  g_door_candidate_distance starts
// well above DOOR_SEARCH_RADIUS so the first real hit always becomes the candidate.
// g_door_scan_mode: 0 = Open Closest Door, 1 = Close Closest Door.
BOOL g_door_scan_active = FALSE
INT g_door_scan_mode = 0
INT g_door_scan_index = 0
INT g_door_candidate_model_index = -1
VECTOR g_door_candidate_coords = <<0.0, 0.0, 0.0>>
FLOAT g_door_candidate_distance = 9999.0
// Row feedback: 0 = idle, 1 = no doors in range, 2 = opened/closed, 3 = found
// but it would not open/close.  g_door_feedback_until is set at result time,
// not press time, so the message is always displayed for the full DOOR_FEEDBACK_MS.
INT g_door_feedback = 0
INT g_door_feedback_until = 0
// "Touch Opens Doors" state (World and Weather tab).
BOOL g_touch_opens_doors = FALSE
BOOL g_touch_door_cache_seeded = FALSE
INT g_touch_door_scan_index = 0
INT g_touch_door_models[TOUCH_DOOR_CACHE_SLOTS]
VECTOR g_touch_door_coords[TOUCH_DOOR_CACHE_SLOTS]

// Emergency-vehicle siren mute (Vehicle Settings Row 27): when enabled, hold R3
// while seated in an EMERGENCY-class vehicle. g_siren_muted_veh keeps the exact
// vehicle that was muted so the release path can clear that vehicle even after
// the player has moved on, and so a parked ambulance cannot be left silent.
BOOL g_siren_mute_enabled = FALSE
BOOL g_siren_mute_armed = FALSE
INT g_siren_hold_start = 0
BOOL g_siren_hold_latched = FALSE
VEHICLE_INDEX g_siren_muted_veh = NULL
INT g_siren_mute_tick = 0

// ---------------------------------------------------------------------------
// Frame-time probe (v0.9.9 hitch hunt - diagnostics only, no behaviour).
//
// The reported hitch could not be attributed from source: every candidate (the
// ~264-call persistence burst, the frontend sound on every press, a row's apply
// path, the draw pass) is plausible on paper, and the one hypothesis that was
// testable from the menu - "Save To Disk After Change" - was falsified on
// hardware (turning it off did not stop the hitch).
//
// So the menu now measures instead of guessing.  Every counter is the worst
// single-frame cost seen since the last reset, in milliseconds, timed with
// GET_GAME_TIMER (the stock header itself notes it is precise enough for
// profiling).  Nothing here is branched on: the counters are only written and
// displayed, so the probe cannot change gameplay.
//
// g_prof_worst_frame is the number that matters: the gap between consecutive
// main-loop iterations, which spans WAIT(0) and is therefore the stall the
// player actually feels.  Comparing it against g_prof_worst_work splits the two
// possible causes:
//   worst_frame ~= worst_work   -> this script blocked, and the phase counters
//                                  below say which part of it.
//   worst_frame >> worst_work   -> the game did the work after the script
//                                  yielded, i.e. the script only asked for it.
// ---------------------------------------------------------------------------
INT g_prof_t0 = 0
INT g_prof_t1 = 0
// MENU_PLAY_SOUND needs its own start timestamp: it is called from inside the
// main loop's iteration, and g_prof_t0 has to keep holding the start of that
// iteration for the part-2 work calculation at the bottom of the loop. Reusing
// g_prof_t0 there would silently truncate every "Worst Script MS" reading to the
// time since the last menu press.
INT g_prof_sound_t0 = 0
INT g_prof_last_iter = 0
INT g_prof_worst_frame = 0
INT g_prof_worst_work = 0
INT g_prof_worst_persist = 0
INT g_prof_worst_burst = 0
INT g_prof_worst_sound = 0
INT g_prof_worst_apply = 0
INT g_prof_worst_draw = 0
// Where the worst APPLY landed, as tab*100+row, so the offending row can be
// identified from the readout alone.
INT g_prof_apply_tab = -1
INT g_prof_apply_row = -1
// Invocation counts: a phase worst of 0ms is ambiguous otherwise (never ran vs
// ran and was free).
INT g_prof_persist_count = 0
INT g_prof_sound_count = 0

// ---------------------------------------------------------------------------
// Chauffeur submenu (Vehicle Settings tab, util_chauffeur.sch).
//
// Same shape as every other submenu: its own open/item/scroll state plus one
// global per feature, and one item/scroll pair per child page.  The three
// child pages (PED, Vehicle, Armed Driver) follow the bodyguard/attacker
// pattern, where the parent's g_chauffeur_open stays TRUE while a child is
// open so the B-back chain can save and restore the parent's cursor.
// ---------------------------------------------------------------------------
BOOL g_chauffeur_open = FALSE
INT g_chauffeur_item = 0
INT g_chauffeur_scroll = 0
BOOL g_chauffeur_ped_open = FALSE
INT g_chauffeur_ped_item = 0
INT g_chauffeur_ped_scroll = 0
BOOL g_chauffeur_vehicle_open = FALSE
INT g_chauffeur_vehicle_item = 0
INT g_chauffeur_vehicle_scroll = 0
BOOL g_chauffeur_armed_open = FALSE
INT g_chauffeur_armed_item = 0
INT g_chauffeur_armed_scroll = 0
// Driver PED, mirroring the guard/attacker ped state.  The literal name is a
// pre-init placeholder; INIT_MENU_DEFAULTS() rebinds it to the real catalog
// entry so the label and the spawned model can never disagree.
INT g_chauffeur_ped_choice = 0
STRING g_chauffeur_ped_name = "S_M_M_BOUNCER_01"
BOOL g_chauffeur_ped_search_not_found = FALSE
BOOL g_chauffeur_ped_search_is_custom = FALSE
MODEL_NAMES g_chauffeur_ped_model = S_M_M_BOUNCER_01
INT g_chauffeur_vehicle_choice = 0
// 0 = Normal (stops at lights), 1 = Rushed (Rockstar's taxi hurry mode).
INT g_chauffeur_style = 0
BOOL g_chauffeur_ignore_lights = FALSE
BOOL g_chauffeur_god = FALSE
BOOL g_chauffeur_bulletproof_tyres = TRUE
BOOL g_chauffeur_armed = FALSE
INT g_chauffeur_weapon_choice = CHAUFFEUR_DEFAULT_WEAPON_CHOICE
// The live driving-mode flag set, rebuilt whenever the style or the
// traffic-light toggle changes.  A global, not a function return, so the
// "DRIVINGMODE x = DF_A|DF_B" form matches taxiService.sc exactly.
DRIVINGMODE g_chauffeur_driving_mode = DF_SteerAroundStationaryCars|DF_StopForPeds|DF_StopAtLights|DF_ChangeLanesAroundObstructions|DF_StopForCars|DF_ForceJoinInRoadDirection|DF_SteerAroundObjects|DF_UseSwitchedOffNodes|DF_AvoidRestrictedAreas|DF_UseWanderFallbackInsteadOfStraightLine
// Staged spawn state: the car and the driver are requested together.
BOOL g_chauffeur_spawn_pending = FALSE
MODEL_NAMES g_pending_chauffeur_ped_model = S_M_M_BOUNCER_01
MODEL_NAMES g_pending_chauffeur_vehicle_model = GRANGER
INT g_chauffeur_request_time = 0
// Live entities.  Kept even after the menu is closed, so the driver keeps
// driving while the player browses; PROCESS_CHAUFFEUR() runs unconditionally.
VEHICLE_INDEX g_chauffeur_vehicle = NULL
PED_INDEX g_chauffeur_driver = NULL
INT g_chauffeur_tick = 0
// Armed Driver targeting.  The last ped the driver was told to shoot, so the
// shoot task is re-issued only when the target actually changes instead of
// every tick.
PED_INDEX g_chauffeur_armed_target = NULL

// ---------------------------------------------------------------------------
// Object Spooner submenu (Menu Settings tab Row 0, util_spooner.sch).
//
// Strictly live-session memory only: no file I/O, no XML/JSON, and no
// persistence stat slots.
// ---------------------------------------------------------------------------
BOOL g_spooner_open = FALSE
INT g_spooner_item = 0
INT g_spooner_scroll = 0

// Bounded entity tracking pool and compact packed per-object state arrays
OBJECT_INDEX g_spooner_objects[SPOONER_MAX_OBJECTS]
INT g_spooner_obj_flags[SPOONER_MAX_OBJECTS]
INT g_spooner_obj_rot[SPOONER_MAX_OBJECTS]
INT g_spooner_object_count = 0
INT g_spooner_selected_index = 0

// Active UI / Staging Sliders & Toggles
INT g_spooner_catalog_index = 0
FLOAT g_spooner_forward_offset = 2.50
FLOAT g_spooner_side_offset = 0.00
FLOAT g_spooner_height_offset = 0.00
FLOAT g_spooner_heading_offset = 0.00
BOOL g_spooner_freeze_pos = TRUE
BOOL g_spooner_collision = TRUE

// Attachment Manager UI State
INT g_spooner_bone_choice = 0
INT g_spooner_rot_axis = 0
FLOAT g_spooner_attach_x = 0.00
FLOAT g_spooner_attach_y = 0.00
FLOAT g_spooner_attach_z = 0.00
FLOAT g_spooner_attach_pitch = 0.00
FLOAT g_spooner_attach_roll = 0.00
FLOAT g_spooner_attach_yaw = 0.00

// Asynchronous Streaming & Status Feedback
BOOL g_spooner_spawn_pending = FALSE
MODEL_NAMES g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
INT g_spooner_spawn_start_ms = 0
INT g_spooner_feedback_code = 0
INT g_spooner_feedback_until = 0
TEXT_LABEL_63 g_spooner_custom_model_input = ""

// Live Object Spooner Prop Preview (static, collisionless preview in front of player)
INT g_spooner_preview_opacity = 80
OBJECT_INDEX g_spooner_preview_object = NULL
MODEL_NAMES g_spooner_preview_model = DUMMY_MODEL_FOR_SCRIPT
INT g_spooner_preview_request_time = 0
BOOL g_spooner_use_custom_preview = FALSE
MODEL_NAMES g_spooner_custom_preview_model = DUMMY_MODEL_FOR_SCRIPT

// ---------------------------------------------------------------------------
// Custom NSC Loader submenu (Menu Settings tab Row 1, util_nsc_loader.sch).
//
// Switch keyboard .nsc filename entry (filtering out the 1,026 stock script_rel.rpf
// scripts and ragemenu.nsc), menu persistence across launches, active THREADID
// state table, and full reload execution state machine.
// ---------------------------------------------------------------------------
BOOL g_nsc_loader_open = FALSE
INT g_nsc_loader_item = 0
INT g_nsc_loader_scroll = 0

BOOL g_nsc_unload_open = FALSE
INT g_nsc_unload_item = 0
INT g_nsc_unload_scroll = 0
INT g_nsc_active_count = 0

INT g_nsc_discovered_count = 0
TEXT_LABEL_31 g_nsc_script_names[NSC_MAX_CUSTOM_SCRIPTS]
INT g_nsc_script_hashes[NSC_MAX_CUSTOM_SCRIPTS]
THREADID g_nsc_thread_ids[NSC_MAX_CUSTOM_SCRIPTS]
BOOL g_nsc_is_active[NSC_MAX_CUSTOM_SCRIPTS]

INT g_nsc_stack_choice = 0
INT g_nsc_async_stage = 0
INT g_nsc_async_slot = -1
INT g_nsc_async_deadline = 0
TEXT_LABEL_31 g_nsc_last_probed_name = ""
INT g_nsc_feedback_code = 0
INT g_nsc_feedback_until = 0

// ---------------------------------------------------------------------------
// ScriptHookV-NX Plugins Manager (Menu Settings tab Row 3, util_plugin_manager.sch).
// ---------------------------------------------------------------------------
BOOL g_plugin_mgr_open = FALSE
INT g_plugin_mgr_item = 0
INT g_plugin_mgr_scroll = 0
INT g_plugin_mgr_count = 0
BOOL g_plugin_mgr_ready = FALSE
BOOL g_plugin_mgr_detail_open = FALSE
INT g_plugin_mgr_slot = -1
INT g_plugin_mgr_policy_choice = 0
INT g_plugin_mgr_next_sync = 0
INT g_plugin_mgr_feedback = 0
INT g_plugin_mgr_action_error = 0
TEXT_LABEL_63 g_plugin_mgr_names[PLUGIN_MGR_MAX_PLUGINS]
STRING g_plugin_mgr_status_text[PLUGIN_MGR_MAX_PLUGINS]
INT g_plugin_mgr_states[PLUGIN_MGR_MAX_PLUGINS]
INT g_plugin_mgr_memory[PLUGIN_MGR_MAX_PLUGINS]
INT g_plugin_mgr_policies[PLUGIN_MGR_MAX_PLUGINS]
BOOL g_plugin_mgr_running[PLUGIN_MGR_MAX_PLUGINS]

// ---------------------------------------------------------------------------
// Credits submenu (Menu Settings tab bottom row).
// Read-only list of 6 entries; Up/Down navigates, B exits, A is non-interactive.
// ---------------------------------------------------------------------------
BOOL g_credits_open = FALSE
INT g_credits_item = 0
INT g_credits_scroll = 0

// ---------------------------------------------------------------------------
// Cruise Control (Vehicle Settings row 26) & Show Live Coordinates (Misc row 13).
// ---------------------------------------------------------------------------
BOOL g_vehicle_cruise_control = FALSE
BOOL g_cruise_active = FALSE
FLOAT g_cruise_target_speed = 0.0
VEHICLE_INDEX g_cruise_vehicle = NULL

BOOL g_show_live_coords = FALSE
VECTOR g_live_coords_pos = <<0.0, 0.0, 0.0>>
INT g_live_coords_next_update = 0

// ---------------------------------------------------------------------------
// Special Gun Modes (Weapon Options tab Row 7, util_weapons.sch).
// ---------------------------------------------------------------------------
INT g_special_gun_mode = 0
ENTITY_INDEX g_gravity_gun_entity = NULL
FLOAT g_gravity_gun_distance = 10.0
BOOL g_gravity_gun_holding = FALSE
INT g_gravity_gun_release_time = 0
INT g_special_gun_cooldown = 0
BOOL g_special_gun_spawn_pending = FALSE
INT g_special_gun_spawn_kind = 0
MODEL_NAMES g_special_gun_spawn_model = DUMMY_MODEL_FOR_SCRIPT
INT g_special_gun_request_time = 0
VECTOR g_special_gun_shot_dir = <<0.0, 1.0, 0.0>>
VECTOR g_airstrike_target = <<0.0, 0.0, 0.0>>
INT g_airstrike_bursts_left = 0
INT g_airstrike_next_ms = 0

// ---------------------------------------------------------------------------
// World Mayhem submenu (World and Weather tab Row 16, util_world.sch).
// ---------------------------------------------------------------------------
BOOL g_mayhem_open = FALSE
INT g_mayhem_item = 0
INT g_mayhem_scroll = 0
BOOL g_blackout = FALSE
BOOL g_meteor_shower = FALSE
INT g_next_meteor_ms = 0
BOOL g_riot_mode = FALSE
INT g_next_riot_ms = 0
BOOL g_crazy_drivers = FALSE
INT g_next_crazy_drivers_ms = 0

// ---------------------------------------------------------------------------
// Custom Story PEDs submenu (PED Changer Row 0, util_story_peds.sch).
// g_story_ped_choice[charId]:
//   0        = character's stock default model (STORY_CHAR_DEFAULT_MODEL(charId))
//   1..760   = catalog choice + 1 (PED_MODEL_FOR_CHOICE(choice - 1))
//   -1       = custom OSK model (g_story_ped_custom_model[charId])
// ---------------------------------------------------------------------------
BOOL g_story_peds_open = FALSE
INT g_story_peds_item = 0
INT g_story_peds_scroll = 0
BOOL g_story_ped_picker_open = FALSE
INT g_story_ped_picker_item = 0
INT g_story_ped_picker_scroll = 0
INT g_story_ped_active_char = 0
BOOL g_story_ped_search_not_found = FALSE
STRING g_story_ped_custom_label = "CUSTOM PED"
INT g_story_ped_choice[STORY_CHAR_COUNT]
MODEL_NAMES g_story_ped_custom_model[STORY_CHAR_COUNT]
INT g_story_cs_char[STORY_CS_MAX]
PED_INDEX g_story_cs_ped[STORY_CS_MAX]
MODEL_NAMES g_story_cs_model[STORY_CS_MAX]
BOOL g_story_cs_registered[STORY_CS_MAX]
BOOL g_story_cs_was_active = FALSE
INT g_story_proxy_char[STORY_PROXY_MAX]
PED_INDEX g_story_proxy_real[STORY_PROXY_MAX]
PED_INDEX g_story_proxy_ped[STORY_PROXY_MAX]
MODEL_NAMES g_story_proxy_model[STORY_PROXY_MAX]
INT g_story_proxy_task_ms[STORY_PROXY_MAX]
INT g_story_next_scan_ms = 0
BOOL g_story_peds_any_active = FALSE

// ---------------------------------------------------------------------------
// Falling-edge state flags so OFF toggles never spam reset natives every frame
// and interfere with active story missions (such as "Casing the Jewel Store").
// ---------------------------------------------------------------------------
BOOL g_fast_run_applied = FALSE
BOOL g_fast_swim_applied = FALSE
BOOL g_everyone_ignores_applied = FALSE
BOOL g_hud_hidden_applied = FALSE
BOOL g_radar_hidden_applied = FALSE
BOOL g_seatbelt_applied = FALSE
BOOL g_accel_applied = FALSE
BOOL g_grip_applied = FALSE
BOOL g_was_menu_open = FALSE

// ---------------------------------------------------------------------------
// Saved Vehicles Submenu & SD Persistence (v1.0.7)
// ---------------------------------------------------------------------------
BOOL g_saved_vehicles_open = FALSE
INT g_saved_vehicles_item = 0
INT g_saved_vehicles_scroll = 0
BOOL g_saved_veh_confirm_open = FALSE
INT g_saved_veh_delete_target = -1
INT g_saved_veh_selected_index = -1
INT g_saved_vehicles_count = 0
INT g_saved_veh_feedback = 0
INT g_saved_veh_feedback_until = 0

// Track whether spawn was initiated from a saved vehicle
BOOL g_spawn_is_saved_vehicle = FALSE
INT g_spawn_saved_vehicle_index = -1

// 16 vehicles * 50 mod slots = 800 slots
INT g_saved_veh_mods[800]

// Vehicle metadata arrays (16 entries each)
TEXT_LABEL_31 g_saved_veh_names[16]
TEXT_LABEL_31 g_saved_veh_display_names[16]
INT g_saved_veh_model_hashes[16]
INT g_saved_veh_primary[16]
INT g_saved_veh_secondary[16]
INT g_saved_veh_pearlescent[16]
INT g_saved_veh_wheel_colour[16]
INT g_saved_veh_xenon[16]
INT g_saved_veh_window_tint[16]
INT g_saved_veh_wheel_type[16]
INT g_saved_veh_custom_tyres[16]
INT g_saved_veh_plate_style[16]
TEXT_LABEL_15 g_saved_veh_plate_text[16]
INT g_saved_veh_livery[16]
INT g_saved_veh_roof_state[16]
BOOL g_saved_veh_has_cust_prim[16]
INT g_saved_veh_cust_prim_r[16]
INT g_saved_veh_cust_prim_g[16]
INT g_saved_veh_cust_prim_b[16]
BOOL g_saved_veh_has_cust_sec[16]
INT g_saved_veh_cust_sec_r[16]
INT g_saved_veh_cust_sec_g[16]
INT g_saved_veh_cust_sec_b[16]
INT g_saved_veh_neon_enabled[16]
INT g_saved_veh_neon_r[16]
INT g_saved_veh_neon_g[16]
INT g_saved_veh_neon_b[16]
INT g_saved_veh_smoke_r[16]
INT g_saved_veh_smoke_g[16]
INT g_saved_veh_smoke_b[16]
BOOL g_saved_veh_turbo[16]
BOOL g_saved_veh_xenon_toggle[16]
BOOL g_saved_veh_smoke_toggle[16]
BOOL g_saved_veh_hydro_toggle[16]
INT g_saved_veh_extras[16]

// Staging variables while OSK keyboard is open
INT g_save_stage_model = 0
TEXT_LABEL_31 g_save_stage_display_name = ""
INT g_save_stage_primary = 0
INT g_save_stage_secondary = 0
INT g_save_stage_pearlescent = 0
INT g_save_stage_wheel_colour = 0
INT g_save_stage_xenon = 0
INT g_save_stage_window_tint = 0
INT g_save_stage_wheel_type = 0
INT g_save_stage_custom_tyres = 0
INT g_save_stage_plate_style = 0
TEXT_LABEL_15 g_save_stage_plate_text = ""
INT g_save_stage_livery = 0
INT g_save_stage_roof_state = 0
BOOL g_save_stage_has_cust_prim = FALSE
INT g_save_stage_cust_prim_r = 0
INT g_save_stage_cust_prim_g = 0
INT g_save_stage_cust_prim_b = 0
BOOL g_save_stage_has_cust_sec = FALSE
INT g_save_stage_cust_sec_r = 0
INT g_save_stage_cust_sec_g = 0
INT g_save_stage_cust_sec_b = 0
INT g_save_stage_neon_enabled = 0
INT g_save_stage_neon_r = 255
INT g_save_stage_neon_g = 255
INT g_save_stage_neon_b = 255
INT g_save_stage_smoke_r = 255
INT g_save_stage_smoke_g = 255
INT g_save_stage_smoke_b = 255
BOOL g_save_stage_turbo = FALSE
BOOL g_save_stage_xenon_toggle = FALSE
BOOL g_save_stage_smoke_toggle = FALSE
BOOL g_save_stage_hydro_toggle = FALSE
INT g_save_stage_extras = 0
INT g_save_stage_mods[50]

// SD Card Buffer for Saved Vehicles (2048 words = 8192 bytes, 8KB FAT32 cluster aligned)
INT g_persist_veh_sd_data[2048]

