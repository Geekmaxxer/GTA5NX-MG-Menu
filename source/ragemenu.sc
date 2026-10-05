USING "rage_builtins.sch"
USING "commands_pad.sch"
USING "commands_graphics.sch"
USING "commands_hud.sch"
USING "commands_player.sch"
USING "commands_entity.sch"
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
USING "core/core_constants.sch"
USING "core/core_globals.sch"
USING "core/core_menu.sch"
USING "util/util_teleport.sch"
USING "util/util_door_catalog.sch"
USING "util/util_world.sch"
USING "util/util_ped_catalog.sch"
USING "core/core_outfit.sch"
USING "util/util_spooner.sch"
USING "util/util_nsc_loader.sch"
USING "util/util_vehicle_catalog.sch"
USING "util/util_weapons.sch"
USING "util/util_chauffeur.sch"
USING "features/features_main.sch"
USING "util/util_persistence.sch"
USING "submenus/submenus_all.sch"
SCRIPT
    INIT_MENU_DEFAULTS()
    INIT_CHAUFFEUR_DEFAULTS()
    g_menu_start_time = GET_GAME_TIMER()
    WHILE TRUE
        g_prof_t0 = GET_GAME_TIMER()
        IF g_prof_last_iter > 0
            g_prof_t1 = g_prof_t0 - g_prof_last_iter
            IF g_prof_t1 > g_prof_worst_frame
                g_prof_worst_frame = g_prof_t1
            ENDIF
        ENDIF
        IF MENU_COMBO_OPEN_PRESSED()
            g_open = NOT g_open
            IF g_open
                g_home = TRUE
                g_item = g_home_item
                g_scroll = g_home_scroll
                g_persist_open = FALSE
                g_spooner_open = FALSE
                g_nsc_loader_open = FALSE
            ELSE
                IF g_spawner_open
                    g_spawner_open = FALSE
                    CLEANUP_VEHICLE_PREVIEW()
                ENDIF
                PERSIST_FLUSH_NOW()
            ENDIF
            MENU_PLAY_SOUND("SELECT")
        ENDIF
        IF g_god SET_PLAYER_INVINCIBLE(PLAYER_ID(), TRUE) ENDIF
        IF g_never_wanted CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID()) ENDIF
        IF g_fast_run SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.49) ELSE SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.0) ENDIF
        IF g_fast_swim SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.49) ELSE SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.0) ENDIF
        IF g_super_jump SET_SUPER_JUMP_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_drunk AND HAS_ANIM_SET_LOADED("move_m@drunk@verydrunk")
            SET_PED_MOVEMENT_CLIPSET(PLAYER_PED_ID(), "move_m@drunk@verydrunk", 0.25)
        ENDIF
        IF g_explosive_ammo SET_EXPLOSIVE_AMMO_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_explosive_melee SET_EXPLOSIVE_MELEE_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_unlimited_oxygen APPLY_UNLIMITED_OXYGEN() ENDIF
        IF g_unlimited_ability APPLY_UNLIMITED_ABILITY() ENDIF
        PROCESS_SUPER_PUNCH()
        PROCESS_RGB_ACCENT()
        PROCESS_PLAYER_NOCLIP()
        PROCESS_NOCLIP_VEHICLE_LOCK()
        PROCESS_BODYGUARD_SPAWN()
        PROCESS_BODYGUARD_FOLLOW()
        PROCESS_NEON_ANIM()
        PROCESS_VEHICLE_HAZARDS()
        PROCESS_CHAUFFEUR()
        SET_EVERYONE_IGNORE_PLAYER(PLAYER_ID(), g_everyone_ignores)
        DISPLAY_HUD(NOT g_hud_hidden)
        DISPLAY_RADAR(NOT g_radar_hidden)
        IF g_npc_brawl AND GET_GAME_TIMER() >= g_next_npc_brawl_update
            TASK_NEARBY_NPCS_TO_BRAWL()
            g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
        ENDIF
        PROCESS_PED_DEATH_RECOVERY()
        PROCESS_DOOR_SCAN()
        PROCESS_EXPLODE_QUEUE()
        IF NOT g_respawn_at_death
            g_respawn_pending = FALSE
            g_respawn_ready_ticks = 0
        ELIF IS_ENTITY_DEAD(PLAYER_PED_ID())
            g_respawn_pending = TRUE
            g_respawn_ready_ticks = 0
        ELIF g_respawn_pending
            IF IS_PLAYER_CONTROL_ON(PLAYER_ID())
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
            g_last_living_position = GET_ENTITY_COORDS(PLAYER_PED_ID())
        ENDIF
        IF g_low_population
            SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME(0.25, 0.25)
            SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_RANDOM_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
            SET_PARKED_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0.25)
        ELSE
            SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(1.0)
            SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME(1.0, 1.0)
            SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(1.0)
            SET_RANDOM_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(1.0)
            SET_PARKED_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(1.0)
        ENDIF
        IF g_first_person SET_FOLLOW_PED_CAM_VIEW_MODE(CAM_VIEW_MODE_FIRST_PERSON) ENDIF
        IF g_vehicle_spawn_pending
            IF HAS_MODEL_LOADED(g_pending_vehicle_model)
                FINISH_SELECTED_VEHICLE_SPAWN()
            ELIF GET_GAME_TIMER() > g_vehicle_spawn_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
                g_vehicle_spawn_pending = FALSE
                g_active_spawn_count = 0
            ENDIF
        ENDIF
        IF g_convert_pending
            IF HAS_MODEL_LOADED(g_pending_vehicle_model)
                FINISH_VEHICLE_CONVERSION()
            ELIF GET_GAME_TIMER() > g_convert_request_time + CONVERT_REQUEST_TIMEOUT_MS
                CANCEL_VEHICLE_CONVERSION(5)
            ENDIF
        ENDIF
        IF g_attacker_spawn_pending
            IF HAS_MODEL_LOADED(g_pending_attacker_model)
                FINISH_ATTACKER_SPAWN()
            ELIF GET_GAME_TIMER() > g_attacker_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
                g_attacker_spawn_pending = FALSE
            ENDIF
        ENDIF
        PROCESS_STRIPPER_SPAWN()
        PROCESS_SPOONER_SPAWN_QUEUE()
        PROCESS_CUSTOM_NSC_LOADER()
        IF g_ped_change_pending
            MAINTAIN_PED_CHANGE_REQUEST()
            IF HAS_MODEL_LOADED(g_pending_ped_model)
                FINISH_PED_CHANGE()
            ELIF GET_GAME_TIMER() > g_ped_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_ped_model)
                g_ped_change_pending = FALSE
                IF g_ped_search_is_custom
                    g_ped_search_not_found = TRUE
                    g_ped_search_has_value = FALSE
                    g_ped_search_is_custom = FALSE
                ENDIF
            ENDIF
        ENDIF
        PROCESS_PENDING_TELEPORT()
        PROCESS_SKIP_CUTSCENES()
        PROCESS_VEHICLE_PREVIEW()
        REFRESH_CURRENT_PED_LABEL()
        g_player_in_vehicle = IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        IF g_infinite_parachute
            IF NOT HAS_PED_GOT_WEAPON(PLAYER_PED_ID(), GADGETTYPE_PARACHUTE)
                GIVE_WEAPON_TO_PED(PLAYER_PED_ID(), GADGETTYPE_PARACHUTE, 1)
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
        PROCESS_AUTO_OBJECTIVE_TELEPORT()
        IF g_lsc_open AND NOT g_player_in_vehicle
            g_item = 0
            g_scroll = 0
            g_lsc_vehicle = NULL
            g_hydro_item = 0
            g_hydro_scroll = 0
            g_interior_item = 0
            g_interior_scroll = 0
            g_wheeltyre_item = 0
            g_wheeltyre_scroll = 0
            g_lsc_extras_item = 0
            g_lsc_extras_scroll = 0
        ELIF g_lsc_open AND g_player_in_vehicle AND g_lsc_vehicle != GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
            SYNC_LSC_VEHICLE_STATE()
        ENDIF
        IF g_hydro_hold MAINTAIN_HYDRO_HOLD() ENDIF
        IF g_vehicle_control_open AND NOT g_player_in_vehicle
            g_vehicle_control_item = 0
            g_vehicle_control_scroll = 0
            g_item = 0
            g_scroll = 0
        ENDIF
        IF NOT g_player_in_vehicle
            g_vehicle_hazards = FALSE
        ENDIF
        IF g_mobile_radio AND g_player_in_vehicle AND NOT g_was_in_vehicle
            DISABLE_PORTABLE_RADIO()
        ENDIF
        g_was_in_vehicle = g_player_in_vehicle
        IF NOT g_player_in_vehicle
            g_vehicle_always_max_applied_vehicle = NULL
        ENDIF
        IF g_player_in_vehicle
            VEHICLE_INDEX currentVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
            FLOAT currentVehicleSpeed = GET_ENTITY_SPEED(currentVehicle)
            IF g_vehicle_auto_repair
                SET_VEHICLE_FIXED(currentVehicle)
                SET_VEHICLE_ENGINE_HEALTH(currentVehicle, 1000.0)
                SET_VEHICLE_PETROL_TANK_HEALTH(currentVehicle, 1000.0)
                SET_VEHICLE_BODY_HEALTH(currentVehicle, 1000.0)
                SET_VEHICLE_UNDRIVEABLE(currentVehicle, FALSE)
            ENDIF
            MAINTAIN_VEHICLE_GOD_STATE(currentVehicle)
            IF g_vehicle_always_max AND NOT IS_PED_IN_ANY_TRAIN(PLAYER_PED_ID())
                IF currentVehicle != g_vehicle_always_max_applied_vehicle
                    APPLY_LSC_MAX_TO_VEHICLE(currentVehicle)
                    g_vehicle_always_max_applied_vehicle = currentVehicle
                ENDIF
            ELIF NOT g_vehicle_always_max
                g_vehicle_always_max_applied_vehicle = NULL
            ENDIF
            IF IS_PED_IN_ANY_TRAIN(PLAYER_PED_ID())
                IF g_vehicle_acceleration_level > 0
                    SET_TRAIN_SPEED(currentVehicle, TRAIN_ACCELERATION_SPEED(g_vehicle_acceleration_level))
                    SET_TRAIN_CRUISE_SPEED(currentVehicle, TRAIN_ACCELERATION_SPEED(g_vehicle_acceleration_level))
                ELSE
                    SET_TRAIN_CRUISE_SPEED(currentVehicle, 15.0)
                ENDIF
            ELSE
                IF g_vehicle_acceleration_level > 0 AND currentVehicleSpeed < 72.0
                    SET_VEHICLE_CHEAT_POWER_INCREASE(currentVehicle, VEHICLE_MULTIPLIER_VALUE(g_vehicle_acceleration_level))
                ELSE
                    SET_VEHICLE_CHEAT_POWER_INCREASE(currentVehicle, 1.0)
                ENDIF
                IF g_vehicle_grip_level != 0
                    SET_VEHICLE_FRICTION_OVERRIDE(currentVehicle, VEHICLE_GRIP_VALUE(g_vehicle_grip_level))
                ELSE
                    SET_VEHICLE_FRICTION_OVERRIDE(currentVehicle, -1.0)
                ENDIF
                IF g_vehicle_bulletproof_tyres
                    SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, FALSE)
                    g_bulletproof_tyres_applied = TRUE
                ELIF g_bulletproof_tyres_applied
                    SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, TRUE)
                    g_bulletproof_tyres_applied = FALSE
                    g_wheeltyre_can_burst = TRUE
                ENDIF
            ENDIF
        ENDIF
        PROCESS_QUICK_VEHICLE_ENTRY_EXIT()
        PROCESS_HORN_BOOST()
        PROCESS_EMERGENCY_SIREN_MUTE()
        PROCESS_AUTO_SAVE()
        PROCESS_AUTO_SAVE_ANNOUNCE()
        PROCESS_MENU_WELCOME()
        g_prof_t1 = GET_GAME_TIMER()
        PROCESS_PERSISTENCE()
        g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
        IF g_prof_t1 > g_prof_worst_persist
            g_prof_worst_persist = g_prof_t1
        ENDIF
        PROCESS_GODMODE_TOW_HOOK()
        IF g_seatbelt
            IF g_player_in_vehicle
                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER_PED_ID(), KNOCKOFFVEHICLE_NEVER)
                SET_PED_CAN_BE_DRAGGED_OUT(PLAYER_PED_ID(), FALSE)
                SET_PED_CAN_RAGDOLL(PLAYER_PED_ID(), FALSE)
                SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(PLAYER_PED_ID(), FALSE)
                SET_PED_CONFIG_FLAG(PLAYER_PED_ID(), PCF_WillFlyThroughWindscreen, FALSE)
            ELSE
                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER_PED_ID(), KNOCKOFFVEHICLE_DEFAULT)
                SET_PED_CAN_BE_DRAGGED_OUT(PLAYER_PED_ID(), TRUE)
                IF NOT g_no_ragdoll SET_PED_CAN_RAGDOLL(PLAYER_PED_ID(), TRUE) ENDIF
                SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(PLAYER_PED_ID(), TRUE)
                SET_PED_CONFIG_FLAG(PLAYER_PED_ID(), PCF_WillFlyThroughWindscreen, TRUE)
            ENDIF
        ENDIF
        IF NOT g_open
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_UP)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_LOOK_BEHIND)
            ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_LOOK_BEHIND)
            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_LOOK_BEHIND)
            ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_VEH_LOOK_BEHIND)
            ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
            ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_DOWN)
        ENDIF
        IF g_open
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
                MENU_PLAY_SOUND("SELECT")
                IF g_home
                    g_tab = g_item
                    g_home_item = g_item
                    g_home_scroll = g_scroll
                    g_home = FALSE
                    g_item = g_page_item[g_tab]
                    g_scroll = g_page_scroll[g_tab]
                ELSE
                    g_prof_t1 = GET_GAME_TIMER()
                    APPLY_SELECTED()
                    g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
                    IF g_prof_t1 > g_prof_worst_apply
                        g_prof_worst_apply = g_prof_t1
                        g_prof_apply_tab = g_tab
                        g_prof_apply_row = g_item
                    ENDIF
                    MARK_PERSIST_DIRTY()
                ENDIF
            ENDIF
            IF IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL)
                MENU_PLAY_SOUND("BACK")
                IF g_home
                    g_open = FALSE
                    PERSIST_FLUSH_NOW()
                ELIF g_chauffeur_open
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
                    g_spawner_item = g_item
                    g_spawner_scroll = g_scroll
                    g_spawner_open = FALSE
                    CLEANUP_VEHICLE_PREVIEW()
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
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
                    g_ped_item = g_item
                    g_ped_scroll = g_scroll
                    g_ped_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
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
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELIF g_nsc_loader_open
                    g_nsc_loader_item = g_item
                    g_nsc_loader_scroll = g_scroll
                    g_nsc_loader_open = FALSE
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELIF g_persist_open
                    g_persist_item = g_item
                    g_persist_scroll = g_scroll
                    g_persist_open = FALSE
                    g_item = g_page_item[7]
                    g_scroll = g_page_scroll[7]
                ELSE
                    g_page_item[g_tab] = g_item
                    g_page_scroll[g_tab] = g_scroll
                    g_home = TRUE
                    g_item = g_home_item
                    g_scroll = g_home_scroll
                ENDIF
            ENDIF
            UPDATE_SCROLL()
            SAVE_NAVIGATION_STATE()
            g_prof_t1 = GET_GAME_TIMER()
            IF g_home DRAW_HOME() ELSE DRAW_PAGE() ENDIF
            g_prof_t1 = GET_GAME_TIMER() - g_prof_t1
            IF g_prof_t1 > g_prof_worst_draw
                g_prof_worst_draw = g_prof_t1
            ENDIF
            ENDIF
        ELIF g_instructional_scaleform != NULL
            SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(g_instructional_scaleform)
        ENDIF
        DRAW_SPEEDOMETER()
        DRAW_AUTO_SAVE_TIMER()
        g_prof_last_iter = GET_GAME_TIMER()
        g_prof_t1 = g_prof_last_iter - g_prof_t0
        IF g_prof_t1 > g_prof_worst_work
            g_prof_worst_work = g_prof_t1
        ENDIF
        WAIT(0)
    ENDWHILE
ENDSCRIPT
