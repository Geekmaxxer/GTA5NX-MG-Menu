USING "rage_builtins.sch"
USING "commands_pad.sch"
USING "commands_graphics.sch"
USING "commands_hud.sch"
USING "commands_player.sch"
USING "commands_entity.sch"
USING "commands_fire.sch"
USING "commands_object.sch"
USING "commands_ped.sch"
USING "commands_weapon.sch"
USING "commands_law.sch"
USING "commands_vehicle.sch"
USING "commands_audio.sch"
USING "commands_clock.sch"
USING "commands_misc.sch"
USING "commands_camera.sch"
USING "commands_streaming.sch"
USING "commands_water.sch"
USING "commands_dlc.sch"
USING "commands_path.sch"
USING "commands_extrametadata.sch"
USING "commands_task.sch"
USING "commands_stats.sch"
USING "commands_cutscene.sch"
USING "commands_interiors.sch"
USING "commands_script.sch"
USING "stats_enums.sch"

// Constants first: core_globals.sch sizes a bounded array with
// STRIPPER_TRACK_MAX, and this compiler requires every name to be declared
// before use.  core_constants.sch holds nothing but CONST_* declarations (no
// globals, no functions), so it is safe to include ahead of the globals - and
// the note in core_constants.sch claiming it is "included before both" is now
// actually true.
USING "core/core_constants.sch"
USING "core/core_globals.sch"
USING "core/core_localization.sch"
USING "core/core_menu.sch"
USING "util/util_teleport.sch"
USING "util/util_door_catalog.sch"
USING "util/util_world.sch"
USING "util/util_ped_catalog.sch"
USING "util/util_story_peds.sch"
USING "core/core_outfit.sch"
USING "util/util_spooner.sch"
USING "util/util_nsc_loader.sch"
USING "util/util_plugin_manager.sch"
USING "util/util_saved_vehicles.sch"
USING "util/util_vehicle_catalog.sch"
USING "util/util_weapons.sch"
USING "util/util_chauffeur.sch"
USING "features/features_main.sch"
USING "util/util_persistence.sch"
USING "submenus/submenus_all.sch"

SCRIPT
    INIT_MENU_DEFAULTS()
    INIT_CHAUFFEUR_DEFAULTS()
    INIT_STORY_PEDS_DEFAULTS()
    PERSIST_LOAD_SAVED_VEHICLES()
    g_menu_start_time = GET_GAME_TIMER()

    WHILE TRUE
        // Frame-time probe, part 1 of 2.  The gap between the previous iteration
        // and this one spans WAIT(0), so it includes any work the game chose to do
        // after this script last yielded - which is the ONLY way a stall caused by
        // the game reacting to a script call (rather than the call itself) becomes
        // visible.  g_prof_t0 must survive the whole iteration; g_prof_t1 is the
        // scratch used by every phase timer below.
        g_prof_t0 = GET_GAME_TIMER()
        IF g_prof_last_iter > 0
            g_prof_t1 = g_prof_t0 - g_prof_last_iter
            IF g_prof_t1 > g_prof_worst_frame
                g_prof_worst_frame = g_prof_t1
            ENDIF
        ENDIF
        // Smooth 30 FPS Frame Optimization: Cache player identity, coords, vehicle, and death state once per frame.
        g_cached_player_ped = PLAYER_PED_ID()
        g_cached_player_id = PLAYER_ID()
        IF DOES_ENTITY_EXIST(g_cached_player_ped)
            g_cached_player_dead = IS_ENTITY_DEAD(g_cached_player_ped)
            g_cached_player_coords = GET_ENTITY_COORDS(g_cached_player_ped)
            g_cached_player_in_veh = IS_PED_IN_ANY_VEHICLE(g_cached_player_ped)
            IF g_cached_player_in_veh
                g_cached_player_veh = GET_VEHICLE_PED_IS_IN(g_cached_player_ped, FALSE)
            ELSE
                g_cached_player_veh = NULL
            ENDIF
        ELSE
            g_cached_player_dead = TRUE
            g_cached_player_coords = <<0.0, 0.0, 0.0>>
            g_cached_player_in_veh = FALSE
            g_cached_player_veh = NULL
        ENDIF
        g_player_in_vehicle = g_cached_player_in_veh
        g_frame_phase = (g_frame_phase + 1) % 4

        IF MENU_COMBO_OPEN_PRESSED()
            g_open = NOT g_open
            IF g_open
                g_home = TRUE
                g_item = g_home_item
                g_scroll = g_home_scroll
                CLOSE_ALL_SUBMENUS()
                g_menu_nav_dirty = TRUE
                g_description_dirty = TRUE
            ELSE
                // Closing the menu while the Spawner is open used to leave its
                // preview car alive: the flag stayed set, so the preview kept
                // following the player (frozen, collisionless, doors locked) with
                // no submenu left open to press B in.  The item/scroll are kept,
                // so re-entering the Spawner still lands where it was left.
                IF g_spawner_open
                    CLEANUP_VEHICLE_PREVIEW()
                ENDIF
                IF g_spooner_open
                    CLEANUP_SPOONER_PREVIEW()
                ENDIF
                CLOSE_ALL_SUBMENUS()
                // Flush a pending settings change as the menu closes: the player has
                // finished with the row, so waiting out the persistence quiet window
                // would only risk the change being lost if the game is closed straight
                // after. PERSIST_REQUEST_DISK_SAVE stays debounced, so this cannot turn
                // every menu close into a save-file write.
                PERSIST_FLUSH_NOW()
                g_instructional_buttons_mode = -1
                g_instructional_cached_lang = -1
            ENDIF
            MENU_PLAY_SOUND("SELECT")
        ENDIF
        // The toggle itself applies both enable and disable. Do not force
        // invincibility off every frame: missions and cutscenes may use it.
        IF g_god SET_PLAYER_INVINCIBLE(g_cached_player_id, TRUE) ENDIF
        IF g_never_wanted CLEAR_PLAYER_WANTED_LEVEL(g_cached_player_id) ENDIF
        IF GET_GAME_TIMER() >= g_chaos_mod_check_timer
            g_chaos_mod_running = GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(HASH("chaosmod")) > 0
            g_chaos_mod_check_timer = GET_GAME_TIMER() + 2000
        ENDIF
        IF g_fast_run
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(g_cached_player_id, 1.49)
            g_fast_run_applied = TRUE
        ELIF g_fast_run_applied AND NOT g_chaos_mod_running
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(g_cached_player_id, 1.0)
            g_fast_run_applied = FALSE
        ENDIF
        IF g_fast_swim
            SET_SWIM_MULTIPLIER_FOR_PLAYER(g_cached_player_id, 1.49)
            g_fast_swim_applied = TRUE
        ELIF g_fast_swim_applied AND NOT g_chaos_mod_running
            SET_SWIM_MULTIPLIER_FOR_PLAYER(g_cached_player_id, 1.0)
            g_fast_swim_applied = FALSE
        ENDIF
        IF g_super_jump SET_SUPER_JUMP_THIS_FRAME(g_cached_player_id) ENDIF
        IF g_drunk
            IF HAS_ANIM_SET_LOADED("move_m@drunk@verydrunk")
                SET_PED_MOVEMENT_CLIPSET(g_cached_player_ped, "move_m@drunk@verydrunk", 0.25)
            ELSE
                REQUEST_ANIM_SET("move_m@drunk@verydrunk")
            ENDIF
        ENDIF
        IF g_explosive_ammo SET_EXPLOSIVE_AMMO_THIS_FRAME(g_cached_player_id) ENDIF
        IF g_explosive_melee SET_EXPLOSIVE_MELEE_THIS_FRAME(g_cached_player_id) ENDIF
        IF g_unlimited_oxygen APPLY_UNLIMITED_OXYGEN() ENDIF
        IF g_unlimited_ability APPLY_UNLIMITED_ABILITY() ENDIF
        IF g_super_punch PROCESS_SUPER_PUNCH() ENDIF
        IF g_accent_rgb AND g_accent_choice = 14 PROCESS_RGB_ACCENT() ENDIF
        IF g_player_noclip
            PROCESS_PLAYER_NOCLIP()
            PROCESS_NOCLIP_VEHICLE_LOCK()
        ENDIF
        IF g_bodyguard_count > 0 PROCESS_BODYGUARD_FOLLOW() ENDIF
        IF g_neon_mode != 0 PROCESS_NEON_ANIM() ENDIF
        IF g_vehicle_hazards PROCESS_VEHICLE_HAZARDS() ENDIF
        // Chauffeur (Vehicle Settings row 25).  Unconditional: the driver has
        // to keep driving to the waypoint - and keep responding to the style
        // and traffic-light rows - whether or not the menu is still open.
        IF g_chauffeur_spawn_pending OR DOES_ENTITY_EXIST(g_chauffeur_vehicle) PROCESS_CHAUFFEUR() ENDIF
        IF g_everyone_ignores
            SET_EVERYONE_IGNORE_PLAYER(g_cached_player_id, TRUE)
            g_everyone_ignores_applied = TRUE
        ELIF g_everyone_ignores_applied
            SET_EVERYONE_IGNORE_PLAYER(g_cached_player_id, FALSE)
            g_everyone_ignores_applied = FALSE
        ENDIF
        IF g_hud_hidden
            DISPLAY_HUD(FALSE)
            g_hud_hidden_applied = TRUE
        ELIF g_hud_hidden_applied
            DISPLAY_HUD(TRUE)
            g_hud_hidden_applied = FALSE
        ENDIF
        IF g_radar_hidden
            DISPLAY_RADAR(FALSE)
            g_radar_hidden_applied = TRUE
        ELIF g_radar_hidden_applied
            DISPLAY_RADAR(TRUE)
            g_radar_hidden_applied = FALSE
        ENDIF
        IF g_cached_player_dead
            IF g_open
                g_open = FALSE
                IF g_spawner_open CLEANUP_VEHICLE_PREVIEW() ENDIF
                IF g_spooner_open CLEANUP_SPOONER_PREVIEW() ENDIF
                CLOSE_ALL_SUBMENUS()
                g_instructional_buttons_mode = -1
                g_instructional_cached_lang = -1
            ENDIF
            IF g_player_noclip SET_PLAYER_NOCLIP_ENABLED(FALSE) ENDIF
            IF g_player_freecam SET_PLAYER_FREECAM_ENABLED(FALSE) ENDIF
        ENDIF
        IF g_special_gun_mode != 0 PROCESS_SPECIAL_GUN() ENDIF

        // ===================================================================
        // Smooth 30 FPS: 4-Phase Staggered Background Tasks (each ~7.5 Hz)
        // ===================================================================
        SWITCH g_frame_phase
            CASE 0
                IF GET_GAME_TIMER() >= g_next_prune_tracked_entities_timer
                    PRUNE_MENU_PED_TRACKING()
                    g_next_prune_tracked_entities_timer = GET_GAME_TIMER() + 5000
                ENDIF
                PROCESS_PED_DEATH_RECOVERY()
                PROCESS_CUSTOM_STORY_PEDS()
                PROCESS_STRIPPER_SPAWN()
                PROCESS_AUTO_OBJECTIVE_TELEPORT()
                IF g_ped_change_pending
                    IF g_cached_player_in_veh OR g_cached_player_dead OR IS_PED_INJURED(g_cached_player_ped)
                        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_ped_model)
                        g_ped_change_pending = FALSE
                    ELSE
                        MAINTAIN_PED_CHANGE_REQUEST()
                        IF HAS_MODEL_LOADED(g_pending_ped_model)
                            FINISH_PED_CHANGE()
                        ELIF GET_GAME_TIMER() > g_ped_request_time + 20000
                            SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_ped_model)
                            g_ped_change_pending = FALSE
                            g_ped_search_error = 2
                        ENDIF
                    ENDIF
                ENDIF
                BREAK

            CASE 1
                PROCESS_DOOR_SCAN()
                PROCESS_TOUCH_OPENS_DOORS()
                PROCESS_SPOONER_SPAWN_QUEUE()
                PROCESS_GODMODE_TOW_HOOK()
                IF g_vehicle_spawn_pending
                    IF HAS_MODEL_LOADED(g_pending_vehicle_model)
                        FINISH_SELECTED_VEHICLE_SPAWN()
                    ELIF GET_GAME_TIMER() > g_vehicle_spawn_request_time + 8000
                        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
                        g_vehicle_spawn_pending = FALSE
                        g_active_spawn_count = 0
                    ENDIF
                ELIF g_convert_pending
                    IF HAS_MODEL_LOADED(g_pending_vehicle_model)
                        FINISH_VEHICLE_CONVERSION()
                    ELIF GET_GAME_TIMER() > g_convert_request_time + CONVERT_REQUEST_TIMEOUT_MS
                        CANCEL_VEHICLE_CONVERSION(5)
                    ENDIF
                ENDIF
                BREAK

            CASE 2
                IF g_npc_brawl AND GET_GAME_TIMER() >= g_next_npc_brawl_update
                    TASK_NEARBY_NPCS_TO_BRAWL()
                    g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
                ENDIF
                PROCESS_WORLD_MAYHEM()
                PROCESS_CUSTOM_NSC_LOADER()
                PROCESS_BODYGUARD_SPAWN()
                IF g_attacker_spawn_pending
                    IF HAS_MODEL_LOADED(g_pending_attacker_model)
                        FINISH_ATTACKER_SPAWN()
                    ELIF GET_GAME_TIMER() > g_attacker_request_time + 8000
                        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
                        g_attacker_spawn_pending = FALSE
                    ENDIF
                ENDIF
                BREAK

            CASE 3
                PROCESS_EXPLODE_QUEUE()
                PROCESS_EMERGENCY_SIREN_MUTE()
                PROCESS_AUTO_SAVE()
                PROCESS_AUTO_SAVE_ANNOUNCE()
                PROCESS_SKIP_CUTSCENES()
                BREAK
        ENDSWITCH

        IF NOT g_respawn_at_death
            g_respawn_pending = FALSE
            g_respawn_ready_ticks = 0
        ELIF g_cached_player_dead

            g_respawn_pending = TRUE
            g_respawn_ready_ticks = 0
        ELIF g_respawn_pending
            IF IS_PLAYER_CONTROL_ON(g_cached_player_id)
                g_respawn_ready_ticks = g_respawn_ready_ticks + 1

                IF g_respawn_ready_ticks >= 20
                    MOVE_PLAYER_TO_RESPAWN_LOCATION()
                    g_respawn_pending = FALSE
                    g_respawn_ready_ticks = 0
                ENDIF
            ELSE
                g_respawn_ready_ticks = 0
            ENDIF
        ELSE
            g_last_living_position = g_cached_player_coords
        ENDIF
        // Only override *_DENSITY_MULTIPLIER_THIS_FRAME while Low Population is ON.
        // Calling them with 1.0 every frame when OFF overrides active mission
        // streaming/population budget reductions (such as jewelry_setup1 "Casing
        // the Jewel Store"), forcing 100% traffic/peds on top of heavy mission
        // interiors and exhausting Switch streaming memory.
        IF g_low_population
            SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME(0.25, 0.25)
            SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_RANDOM_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_PARKED_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
        ENDIF
        IF g_first_person SET_FOLLOW_PED_CAM_VIEW_MODE(CAM_VIEW_MODE_FIRST_PERSON) ENDIF
        // PROCESS_PROJECTILE_SHOT() was removed from this loop: the Fired Asset
        // feature it drives was pulled from the UI in v0.8.6 (spawned nothing on
        // Switch streaming), so g_projectile_choice can never leave 0 and the
        // call only tested that global every frame.
        IF g_teleport_pending PROCESS_PENDING_TELEPORT() ENDIF
        IF g_vehicle_preview_enabled AND g_open AND NOT g_home AND g_spawner_open AND g_vehicle_list_open
            PROCESS_VEHICLE_PREVIEW()
        ELSE
            CLEANUP_VEHICLE_PREVIEW()
        ENDIF
        IF g_open AND g_spooner_open
            PROCESS_SPOONER_PREVIEW()
        ELSE
            CLEANUP_SPOONER_PREVIEW()
        ENDIF
        IF g_open AND g_tab = 0 AND g_ped_open
            REFRESH_CURRENT_PED_LABEL()
        ENDIF
        IF g_infinite_parachute
            IF NOT HAS_PED_GOT_WEAPON(g_cached_player_ped, GADGETTYPE_PARACHUTE)
                GIVE_WEAPON_TO_PED(g_cached_player_ped, GADGETTYPE_PARACHUTE, 1)
            ENDIF
        ENDIF
        IF g_auto_waypoint
            IF IS_WAYPOINT_ACTIVE()
                BLIP_INDEX waypointBlip = GET_FIRST_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID())
                IF waypointBlip != NULL
                    VECTOR waypointPosition = GET_BLIP_COORDS(waypointBlip)
                    IF NOT g_auto_waypoint_seen OR VDIST(g_last_auto_waypoint, waypointPosition) > 5.0
                        g_last_auto_waypoint = waypointPosition
                        g_auto_waypoint_seen = TRUE
                        TELEPORT_PLAYER_FAST(waypointPosition)
                    ENDIF
                ENDIF
            ELSE
                g_auto_waypoint_seen = FALSE
            ENDIF
        ELSE
            g_auto_waypoint_seen = FALSE
        ENDIF
        IF g_lsc_open AND NOT g_player_in_vehicle AND NOT g_bennys_open
            g_item = 0
            g_scroll = 0
            g_lsc_vehicle = NULL
            // The child pages must not keep a stale cursor either: on foot they
            // render "NO VEHICLE" and every row needs a vehicle.
            g_hydro_item = 0
            g_hydro_scroll = 0
            g_interior_item = 0
            g_interior_scroll = 0
            g_wheeltyre_item = 0
            g_wheeltyre_scroll = 0
            g_lsc_extras_item = 0
            g_lsc_extras_scroll = 0
            g_bennys_item = 0
            g_bennys_scroll = 0
            g_support_item = 0
            g_support_scroll = 0
        ELIF g_lsc_open AND g_player_in_vehicle AND g_lsc_vehicle != g_cached_player_veh
            SYNC_LSC_VEHICLE_STATE()
        ENDIF
        // Hold Stance re-assert.  Cadence-limited inside the proc
        // (HYDRO_HOLD_TICK_MS) and it turns itself off if the player is on foot,
        // so this cannot become a per-frame native burst or a runaway loop.
        IF g_hydro_hold MAINTAIN_HYDRO_HOLD() ENDIF
        IF g_vehicle_control_open AND NOT g_player_in_vehicle
            // Keep the page open but send the cursor back to the top: every
            // row below needs a vehicle.
            g_vehicle_control_item = 0
            g_vehicle_control_scroll = 0
            g_item = 0
            g_scroll = 0
        ENDIF
        IF g_neon_anim_open AND NOT g_player_in_vehicle
            g_neon_anim_item = 0
            g_neon_anim_scroll = 0
            g_item = 0
            g_scroll = 0
        ENDIF
        IF NOT g_player_in_vehicle
            // Hazards are bound to one vehicle: clear them on exit so they
            // cannot stay lit on a car left behind or leak into the next one.
            g_vehicle_hazards = FALSE
        ENDIF
        IF g_mobile_radio AND g_player_in_vehicle AND NOT g_was_in_vehicle
            DISABLE_PORTABLE_RADIO()
        ENDIF
        g_was_in_vehicle = g_player_in_vehicle
        IF NOT g_player_in_vehicle
            g_vehicle_always_max_applied_vehicle = NULL
            IF g_accel_applied g_accel_applied = FALSE ENDIF
            IF g_grip_applied g_grip_applied = FALSE ENDIF
            IF g_bulletproof_tyres_applied g_bulletproof_tyres_applied = FALSE ENDIF
        ENDIF
        IF g_player_in_vehicle AND DOES_ENTITY_EXIST(g_cached_player_veh) AND NOT IS_ENTITY_DEAD(g_cached_player_veh)
            VEHICLE_INDEX currentVehicle = g_cached_player_veh
            FLOAT currentVehicleSpeed = GET_ENTITY_SPEED(currentVehicle)
            IF g_vehicle_auto_repair
                IF GET_ENTITY_HEALTH(currentVehicle) < 1000 OR GET_VEHICLE_ENGINE_HEALTH(currentVehicle) < 1000.0 OR GET_VEHICLE_BODY_HEALTH(currentVehicle) < 1000.0 OR GET_VEHICLE_PETROL_TANK_HEALTH(currentVehicle) < 1000.0
                    SET_VEHICLE_FIXED(currentVehicle)
                    SET_VEHICLE_ENGINE_HEALTH(currentVehicle, 1000.0)
                    SET_VEHICLE_PETROL_TANK_HEALTH(currentVehicle, 1000.0)
                    SET_VEHICLE_BODY_HEALTH(currentVehicle, 1000.0)
                    SET_VEHICLE_UNDRIVEABLE(currentVehicle, FALSE)
                ENDIF
            ENDIF
            MAINTAIN_VEHICLE_GOD_STATE(currentVehicle)
            IF g_vehicle_always_max AND NOT IS_PED_IN_ANY_TRAIN(g_cached_player_ped)
                IF currentVehicle != g_vehicle_always_max_applied_vehicle
                    APPLY_LSC_MAX_TO_VEHICLE(currentVehicle)
                    g_vehicle_always_max_applied_vehicle = currentVehicle
                ENDIF
            ELIF NOT g_vehicle_always_max
                g_vehicle_always_max_applied_vehicle = NULL
            ENDIF
            IF IS_PED_IN_ANY_TRAIN(g_cached_player_ped)
                IF g_vehicle_acceleration_level > 0
                    SET_TRAIN_SPEED(currentVehicle, TRAIN_ACCELERATION_SPEED(g_vehicle_acceleration_level))
                    SET_TRAIN_CRUISE_SPEED(currentVehicle, TRAIN_ACCELERATION_SPEED(g_vehicle_acceleration_level))
                ELSE
                    SET_TRAIN_CRUISE_SPEED(currentVehicle, 15.0)
                ENDIF
            ELSE
                // This only affects torque. Do not use SET_VEHICLE_MAX_SPEED or
                // MODIFY_VEHICLE_TOP_SPEED here: their limits/accumulation were
                // the source of the high-speed forced stop on the Switch port.
                // GTA has a hard high-speed stability boundary on this port. Stop
                // adding torque before that boundary; otherwise the engine snaps
                // the vehicle velocity back to zero. Normal vehicle physics remain
                // active, and the selected multiplier resumes when speed drops.
                IF g_vehicle_acceleration_level > 0 AND currentVehicleSpeed < 72.0
                    SET_VEHICLE_CHEAT_POWER_INCREASE(currentVehicle, VEHICLE_MULTIPLIER_VALUE(g_vehicle_acceleration_level))
                    g_accel_applied = TRUE
                ELIF g_accel_applied AND NOT g_chaos_mod_running
                    SET_VEHICLE_CHEAT_POWER_INCREASE(currentVehicle, 1.0)
                    g_accel_applied = FALSE
                ENDIF
                IF g_vehicle_grip_level != 0
                    SET_VEHICLE_FRICTION_OVERRIDE(currentVehicle, VEHICLE_GRIP_VALUE(g_vehicle_grip_level))
                    g_grip_applied = TRUE
                ELIF g_grip_applied AND NOT g_chaos_mod_running
                    SET_VEHICLE_FRICTION_OVERRIDE(currentVehicle, -1.0)
                    g_grip_applied = FALSE
                ENDIF
                // Force the tyres unburstable only while this toggle is ON, and
                // restore bursting once on the falling edge.  The old ELSE wrote
                // TRUE every single frame, which silently undid the Wheels & Tyres
                // "Tyres Can Burst" row one frame after the player set it.
                IF g_vehicle_bulletproof_tyres
                    SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, FALSE)
                    g_bulletproof_tyres_applied = TRUE
                ELIF g_bulletproof_tyres_applied
                    SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, TRUE)
                    g_bulletproof_tyres_applied = FALSE
                    // Keep the Wheels & Tyres row in agreement with the car.
                    g_wheeltyre_can_burst = TRUE
                ENDIF
            ENDIF
        ENDIF
        PROCESS_QUICK_VEHICLE_ENTRY_EXIT()
        PROCESS_HORN_BOOST()
        PROCESS_CRUISE_CONTROL()
        // Persistent settings: boot load, then debounced write-through. Runs
        // whether the menu is open or closed so a saved state (and saved language)
        // is restored on boot BEFORE PROCESS_MENU_WELCOME fires, and a change made
        // just before closing still lands.
        // Frame-time probe: the persistence phase. PROCESS_PERSISTENCE is cheap
        // on almost every frame (a character resolve plus two flag tests); the
        // only frame it is not is the one that runs PERSIST_SAVE_ALL, and that
        // burst is timed separately inside the proc (g_prof_worst_burst).
        g_prof_t1 = GET_GAME_TIMER()
        PROCESS_PERSISTENCE()
        g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
        IF g_prof_t1 > g_prof_worst_persist
            g_prof_worst_persist = g_prof_t1
        ENDIF
        PROCESS_MENU_WELCOME()

        IF g_seatbelt
            IF g_player_in_vehicle
                // Maintain every anti-eject state every frame: impacts can
                // reset individual ped flags, so the knock-off flag alone is
                // not sufficient for a true always-on seatbelt.
                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(g_cached_player_ped, KNOCKOFFVEHICLE_NEVER)
                SET_PED_CAN_BE_DRAGGED_OUT(g_cached_player_ped, FALSE)
                SET_PED_CAN_RAGDOLL(g_cached_player_ped, FALSE)
                SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(g_cached_player_ped, FALSE)
                SET_PED_CONFIG_FLAG(g_cached_player_ped, PCF_WillFlyThroughWindscreen, FALSE)
                g_seatbelt_applied = TRUE
            ELIF g_seatbelt_applied
                // Restore normal on-foot behavior once after an intentional exit;
                // the seatbelt will be reapplied immediately on re-entry.
                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(g_cached_player_ped, KNOCKOFFVEHICLE_DEFAULT)
                SET_PED_CAN_BE_DRAGGED_OUT(g_cached_player_ped, TRUE)
                IF NOT g_no_ragdoll SET_PED_CAN_RAGDOLL(g_cached_player_ped, TRUE) ENDIF
                SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(g_cached_player_ped, TRUE)
                SET_PED_CONFIG_FLAG(g_cached_player_ped, PCF_WillFlyThroughWindscreen, TRUE)
                g_seatbelt_applied = FALSE
            ENDIF
        ELIF g_seatbelt_applied
            SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(g_cached_player_ped, KNOCKOFFVEHICLE_DEFAULT)
            SET_PED_CAN_BE_DRAGGED_OUT(g_cached_player_ped, TRUE)
            IF NOT g_no_ragdoll SET_PED_CAN_RAGDOLL(g_cached_player_ped, TRUE) ENDIF
            SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(g_cached_player_ped, TRUE)
            SET_PED_CONFIG_FLAG(g_cached_player_ped, PCF_WillFlyThroughWindscreen, TRUE)
            g_seatbelt_applied = FALSE
        ENDIF
        IF NOT g_open
            IF g_was_menu_open
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT)
                ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_ACCEPT)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_UP)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP)
                // R3 is the menu's jump-to-top control, so its look-behind bindings
                // are re-enabled once on the frame the menu closes (see MENU_CAPTURE_INPUT).
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_LOOK_BEHIND)
                ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_LOOK_BEHIND)
                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_LOOK_BEHIND)
                ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_VEH_LOOK_BEHIND)
                ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
                ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_DOWN)
                g_was_menu_open = FALSE
            ENDIF
            // Keep Rockstar Editor / Action Replay recording (DPad-Down + A) suppressed
            // at all times on Switch so ReplayControl.cpp never attempts to allocate
            // an unallocated replay buffer during gameplay or add-on script shortcuts.
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_RECORD, TRUE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_RECORD, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_RECORD, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
        ENDIF
        IF g_open
            g_was_menu_open = TRUE
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
            IF g_keyboard_active
                PROCESS_MENU_KEYBOARD()
            ELSE
            MENU_CAPTURE_INPUT()
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP)
            PROCESS_MENU_DIRECTION_INPUT()
            IF IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT)
                IF NOT (NOT g_home AND g_tab = 7 AND g_credits_open)
                    MENU_PLAY_SOUND("SELECT")
                    IF g_home
                        g_tab = g_item
                        g_home_item = g_item
                        g_home_scroll = g_scroll
                        g_home = FALSE
                        g_item = g_page_item[g_tab]
                        g_scroll = g_page_scroll[g_tab]
                    ELSE
                        // Frame-time probe: the A-press work that is NOT persistence -
                        // opening a submenu (which can sync a page's rows) or a toggle
                        // row's one-shot native calls. Timed separately so a slow row
                        // can be pinned down by tab and index alone.
                        g_prof_t1 = GET_GAME_TIMER()
                        APPLY_SELECTED()
                        g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
                        IF g_prof_t1 > g_prof_worst_apply
                            g_prof_worst_apply = g_prof_t1
                            g_prof_apply_tab = g_tab
                            g_prof_apply_row = g_item
                        ENDIF
                        // Every toggle and apply row funnels through APPLY_SELECTED,
                        // so this is the one place that has to notice a settings
                        // change. It over-reports (an APPLY-only row such as a
                        // teleport marks dirty too), which costs one redundant
                        // write-through of values that did not change and cannot miss
                        // a real change - the right trade for a persistence layer.
                        IF NOT g_keyboard_active
                            MARK_PERSIST_DIRTY()
                        ENDIF
                    ENDIF
                    g_menu_nav_dirty = TRUE
                    g_description_dirty = TRUE
                ENDIF
            ENDIF
            IF IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL)
                MENU_PLAY_SOUND("BACK")
                IF g_home
                    g_open = FALSE
                    g_instructional_buttons_mode = -1
                    g_instructional_cached_lang = -1
                    // Same reason as the combo-close path above: a change that was made
                    // and then dismissed with B should not still be pending in the quiet
                    // window.
                    PERSIST_FLUSH_NOW()
                ELIF g_chauffeur_open
                    // Child pages first: g_chauffeur_open stays TRUE while one
                    // of them is open (its item/scroll are saved and restored
                    // here), exactly like g_bodyguard_open/g_guard_ped_open.
                    IF g_chauffeur_armed_open
                        g_chauffeur_armed_item = g_item
                        g_chauffeur_armed_scroll = g_scroll
                        g_chauffeur_armed_open = FALSE
                        g_item = g_chauffeur_item
                        g_scroll = g_chauffeur_scroll
                    ELIF g_chauffeur_vehicle_open
                        g_chauffeur_vehicle_item = g_item
                        g_chauffeur_vehicle_scroll = g_scroll
                        g_chauffeur_vehicle_open = FALSE
                        g_item = g_chauffeur_item
                        g_scroll = g_chauffeur_scroll
                    ELIF g_chauffeur_ped_open
                        g_chauffeur_ped_item = g_item
                        g_chauffeur_ped_scroll = g_scroll
                        g_chauffeur_ped_open = FALSE
                        g_item = g_chauffeur_item
                        g_scroll = g_chauffeur_scroll
                    ELSE
                        g_chauffeur_item = g_item
                        g_chauffeur_scroll = g_scroll
                        g_chauffeur_open = FALSE
                        g_item = g_page_item[3]
                        g_scroll = g_page_scroll[3]
                    ENDIF
                ELIF g_spawner_open
                    IF g_saved_veh_confirm_open
                        g_saved_veh_confirm_open = FALSE
                        g_item = g_saved_veh_delete_target + 1
                        g_scroll = 0
                    ELIF g_saved_vehicles_open
                        g_saved_vehicles_item = g_item
                        g_saved_vehicles_scroll = g_scroll
                        g_saved_vehicles_open = FALSE
                        g_saved_veh_feedback = 0
                        g_item = 1
                        g_scroll = 0
                    ELIF g_vehicle_list_open
                        g_vehicle_list_open = FALSE
                        CLEANUP_VEHICLE_PREVIEW()
                        g_item = 4
                        g_scroll = g_spawner_scroll
                    ELSE
                        g_spawner_item = g_item
                        g_spawner_scroll = g_scroll
                        g_spawner_open = FALSE
                        CLEANUP_VEHICLE_PREVIEW()
                        g_item = g_page_item[3]
                        g_scroll = g_page_scroll[3]
                    ENDIF
                ELIF g_vehicle_control_open
                    g_vehicle_control_item = g_item
                    g_vehicle_control_scroll = g_scroll
                    g_vehicle_control_open = FALSE
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
                ELIF g_neon_anim_open
                    g_neon_anim_item = g_item
                    g_neon_anim_scroll = g_scroll
                    g_neon_anim_open = FALSE
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
                ELIF g_weapon_upgrades_open
                    g_weapon_upgrades_item = g_item
                    g_weapon_upgrades_scroll = g_scroll
                    g_weapon_upgrades_open = FALSE
                    g_item = g_page_item[1]
                    g_scroll = g_page_scroll[1]
                ELIF g_tp_stores_open
                    g_tp_stores_item = g_item
                    g_tp_stores_scroll = g_scroll
                    g_tp_stores_open = FALSE
                    g_item = g_page_item[5]
                    g_scroll = g_page_scroll[5]
                ELIF g_tp_locs_open
                    g_tp_locs_item = g_item
                    g_tp_locs_scroll = g_scroll
                    g_tp_locs_open = FALSE
                    g_item = g_page_item[5]
                    g_scroll = g_page_scroll[5]
                ELIF g_timeweather_open
                    g_timeweather_item = g_item
                    g_timeweather_scroll = g_scroll
                    g_timeweather_open = FALSE
                    g_item = g_page_item[4]
                    g_scroll = g_page_scroll[4]
                ELIF g_mayhem_open
                    g_mayhem_item = g_item
                    g_mayhem_scroll = g_scroll
                    g_mayhem_open = FALSE
                    g_item = g_page_item[4]
                    g_scroll = g_page_scroll[4]
                ELIF g_outfit_open
                    g_outfit_item = g_item
                    g_outfit_scroll = g_scroll
                    g_outfit_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_radio_open
                    g_radio_item = g_item
                    g_radio_scroll = g_scroll
                    g_radio_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_bodyguard_open
                    IF g_guard_ped_open
                        g_guard_ped_item = g_item
                        g_guard_ped_scroll = g_scroll
                        g_guard_ped_open = FALSE
                        g_item = g_bodyguard_item
                        g_scroll = g_bodyguard_scroll
                    ELSE
                        g_bodyguard_item = g_item
                        g_bodyguard_scroll = g_scroll
                        g_bodyguard_open = FALSE
                        g_item = g_page_item[0]
                        g_scroll = g_page_scroll[0]
                    ENDIF
                ELIF g_attacker_open
                    IF g_attacker_ped_open
                        g_attacker_ped_item = g_item
                        g_attacker_ped_scroll = g_scroll
                        g_attacker_ped_open = FALSE
                        g_item = g_attacker_item
                        g_scroll = g_attacker_scroll
                    ELSE
                        g_attacker_item = g_item
                        g_attacker_scroll = g_scroll
                        g_attacker_open = FALSE
                        g_item = g_page_item[0]
                        g_scroll = g_page_scroll[0]
                    ENDIF
                ELIF g_ped_open
                    IF g_story_ped_picker_open
                        g_story_ped_picker_item = g_item
                        g_story_ped_picker_scroll = g_scroll
                        g_story_ped_picker_open = FALSE
                        g_item = g_story_peds_item
                        g_scroll = g_story_peds_scroll
                    ELIF g_story_peds_open
                        g_story_peds_item = g_item
                        g_story_peds_scroll = g_scroll
                        g_story_peds_open = FALSE
                        g_item = g_ped_item
                        g_scroll = g_ped_scroll
                    ELSE
                        g_ped_item = g_item
                        g_ped_scroll = g_scroll
                        g_ped_open = FALSE
                        g_item = g_page_item[0]
                        g_scroll = g_page_scroll[0]
                    ENDIF
                ELIF g_hydro_open
                    g_hydro_item = g_item
                    g_hydro_scroll = g_scroll
                    g_hydro_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_interior_open
                    g_interior_item = g_item
                    g_interior_scroll = g_scroll
                    g_interior_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_wheeltyre_open
                    g_wheeltyre_item = g_item
                    g_wheeltyre_scroll = g_scroll
                    g_wheeltyre_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_lsc_extras_open
                    g_lsc_extras_item = g_item
                    g_lsc_extras_scroll = g_scroll
                    g_lsc_extras_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_bennys_open
                    g_bennys_item = g_item
                    g_bennys_scroll = g_scroll
                    g_bennys_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_support_open
                    g_support_item = g_item
                    g_support_scroll = g_scroll
                    g_support_open = FALSE
                    g_item = g_lsc_item
                    g_scroll = g_lsc_scroll
                ELIF g_lsc_open
                    g_lsc_item = g_item
                    g_lsc_scroll = g_scroll
                    g_lsc_open = FALSE
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
                ELIF g_spooner_open
                    g_spooner_item = g_item
                    g_spooner_scroll = g_scroll
                    g_spooner_open = FALSE
                    CLEANUP_SPOONER_PREVIEW()
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELIF g_nsc_loader_open
                    IF g_nsc_unload_open
                        g_nsc_unload_item = g_item
                        g_nsc_unload_scroll = g_scroll
                        g_nsc_unload_open = FALSE
                        g_item = g_nsc_loader_item
                        g_scroll = g_nsc_loader_scroll
                        IF COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS() <= 0
                            IF g_item >= 3 g_item = 2 ENDIF
                        ENDIF
                        IF g_item >= NSC_LOADER_TOTAL_ROWS()
                            g_item = NSC_LOADER_TOTAL_ROWS() - 1
                        ENDIF
                        IF g_item < 0 g_item = 0 ENDIF
                    ELSE
                        g_nsc_loader_item = g_item
                        g_nsc_loader_scroll = g_scroll
                        g_nsc_loader_open = FALSE
                        g_item = g_page_item[7]
                        g_scroll = g_page_scroll[7]
                    ENDIF
                ELIF g_plugin_mgr_open
                    IF g_plugin_mgr_detail_open
                        g_plugin_mgr_detail_open = FALSE
                        g_plugin_mgr_slot = -1
                        g_item = g_plugin_mgr_item
                        g_scroll = g_plugin_mgr_scroll
                    ELSE
                        g_plugin_mgr_item = g_item
                        g_plugin_mgr_scroll = g_scroll
                        g_plugin_mgr_open = FALSE
                        g_item = g_page_item[7]
                        g_scroll = g_page_scroll[7]
                    ENDIF
                ELIF g_credits_open
                    g_credits_item = g_item
                    g_credits_scroll = g_scroll
                    g_credits_open = FALSE
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELIF g_persist_open
                    g_persist_item = g_item
                    g_persist_scroll = g_scroll
                    g_persist_open = FALSE
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELIF g_language_open
                    g_language_item = g_item
                    g_language_scroll = g_scroll
                    g_language_open = FALSE
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELSE
                    g_page_item[g_tab] = g_item
                    g_page_scroll[g_tab] = g_scroll
                    g_home = TRUE
                    g_item = g_home_item
                    g_scroll = g_home_scroll
                ENDIF
                g_menu_nav_dirty = TRUE
                g_description_dirty = TRUE
            ENDIF
            IF g_menu_nav_dirty
                UPDATE_SCROLL()
                SAVE_NAVIGATION_STATE()
                g_menu_nav_dirty = FALSE
            ENDIF
            UPDATE_CURRENT_DESCRIPTION()
            // Frame-time probe: the whole draw pass for one frame. The menu
            // redraws every frame it is open, so this is normally a constant
            // cost rather than a hitch source - unless a single page's draw does
            // something expensive, which this counter would expose.
            g_prof_t1 = GET_GAME_TIMER()
            IF g_home DRAW_HOME() ELSE DRAW_PAGE() ENDIF
            g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
            IF g_prof_t1 > g_prof_worst_draw
                g_prof_worst_draw = g_prof_t1
            ENDIF
            ENDIF
        ELIF g_instructional_scaleform != NULL
            SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(g_instructional_scaleform)
            g_instructional_scaleform = NULL
            g_instructional_buttons_mode = -1
            g_instructional_cached_lang = -1
        ENDIF
        DRAW_SPEEDOMETER()
        DRAW_AUTO_SAVE_TIMER()
        DRAW_LIVE_COORDINATES()
        // Frame-time probe, part 2 of 2: work done inside this iteration,
        // excluding WAIT(0).  Compared against g_prof_worst_frame this is what
        // separates a stall this script caused (fix: change the script) from a
        // stall the game performed after the script yielded (fix: stop asking it
        // to do that work) - the two need opposite fixes, which is why both are
        // measured rather than just the total.
        g_prof_last_iter = GET_GAME_TIMER()
        g_prof_t1 = g_prof_last_iter - g_prof_t0
        IF g_prof_t1 > g_prof_worst_work
            g_prof_worst_work = g_prof_t1
        ENDIF
        WAIT(0)
    ENDWHILE
ENDSCRIPT
