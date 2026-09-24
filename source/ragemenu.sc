USING "rage_builtins.sch"
USING "commands_pad.sch"
USING "commands_graphics.sch"
USING "commands_hud.sch"
USING "commands_player.sch"
USING "commands_entity.sch"
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
USING "stats_enums.sch"

USING "core/core_globals.sch"
USING "core/core_constants.sch"
USING "core/core_menu.sch"
USING "util/util_teleport.sch"
USING "util/util_world.sch"
USING "util/util_ped_catalog.sch"
USING "core/core_outfit.sch"
USING "util/util_vehicle_catalog.sch"
USING "util/util_weapons.sch"
USING "features/features_main.sch"
USING "submenus/submenus_all.sch"

SCRIPT
    WHILE TRUE
        IF MENU_COMBO_OPEN_PRESSED()
            g_open = NOT g_open
            IF g_open
                g_home = TRUE
                g_item = g_home_item
                g_scroll = g_home_scroll
            ENDIF
            PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
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
        SET_EVERYONE_IGNORE_PLAYER(PLAYER_ID(), g_everyone_ignores)
        DISPLAY_HUD(NOT g_hud_hidden)
        DISPLAY_RADAR(NOT g_radar_hidden)
        IF g_npc_brawl AND GET_GAME_TIMER() >= g_next_npc_brawl_update
            TASK_NEARBY_NPCS_TO_BRAWL()
            g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
        ENDIF
        PROCESS_PED_DEATH_RECOVERY()
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
        IF g_attacker_spawn_pending
            IF HAS_MODEL_LOADED(g_pending_attacker_model)
                FINISH_ATTACKER_SPAWN()
            ELIF GET_GAME_TIMER() > g_attacker_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
                g_attacker_spawn_pending = FALSE
            ENDIF
        ENDIF
        IF g_ped_change_pending
            IF HAS_MODEL_LOADED(g_pending_ped_model)
                FINISH_PED_CHANGE()
            ELIF GET_GAME_TIMER() > g_ped_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_ped_model)
                g_ped_change_pending = FALSE
            ENDIF
        ENDIF
        PROCESS_PROJECTILE_SHOT()
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
        ELIF g_lsc_open AND g_player_in_vehicle AND g_lsc_vehicle != GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
            SYNC_LSC_VEHICLE_STATE()
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
                ELSE
                    SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, TRUE)
                ENDIF
            ENDIF
        ENDIF
        PROCESS_QUICK_VEHICLE_ENTRY_EXIT()
        PROCESS_HORN_BOOST()
        PROCESS_GODMODE_TOW_HOOK()
        IF g_seatbelt
            IF g_player_in_vehicle

                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER_PED_ID(), KNOCKOFFVEHICLE_NEVER)
                SET_PED_CAN_BE_DRAGGED_OUT(PLAYER_PED_ID(), FALSE)
                SET_PED_CAN_RAGDOLL(PLAYER_PED_ID(), FALSE)
                SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(PLAYER_PED_ID(), FALSE)
                SET_PED_CONFIG_FLAG(PLAYER_PED_ID(), PCF_WillFlyThroughWindscreen, FALSE)
            ELSE
                // Restore normal on-foot behavior after an intentional exit;
                // the seatbelt will be reapplied immediately on re-entry.
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
            ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
            ENABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_DOWN)
        ENDIF
        IF g_open
            IF g_keyboard_active
                PROCESS_MENU_KEYBOARD()
            ENDIF
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
            MENU_CAPTURE_INPUT()
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
            DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP)
            PROCESS_MENU_DIRECTION_INPUT()
            IF NOT g_keyboard_active AND IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT)
                PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                IF g_home
                    g_tab = g_item
                    g_home_item = g_item
                    g_home_scroll = g_scroll
                    g_home = FALSE
                    g_item = g_page_item[g_tab]
                    g_scroll = g_page_scroll[g_tab]
                ELSE
                    APPLY_SELECTED()
                ENDIF
            ENDIF
            IF NOT g_keyboard_active AND IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL)
                PLAY_SOUND_FRONTEND(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                IF g_home
                    g_open = FALSE
                ELIF g_spawner_open
                    g_spawner_item = g_item
                    g_spawner_scroll = g_scroll
                    g_spawner_open = FALSE
                    CLEANUP_VEHICLE_PREVIEW()
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
                    g_bodyguard_item = g_item
                    g_bodyguard_scroll = g_scroll
                    g_bodyguard_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_attacker_open
                    g_attacker_item = g_item
                    g_attacker_scroll = g_scroll
                    g_attacker_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_statman_open
                    g_statman_item = g_item
                    g_statman_scroll = g_scroll
                    g_statman_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_ped_open
                    g_ped_item = g_item
                    g_ped_scroll = g_scroll
                    g_ped_open = FALSE
                    g_item = g_page_item[0]
                    g_scroll = g_page_scroll[0]
                ELIF g_lsc_open
                    g_lsc_item = g_item
                    g_lsc_scroll = g_scroll
                    g_lsc_open = FALSE
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
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
            IF g_home DRAW_HOME() ELSE DRAW_PAGE() ENDIF
        ELIF g_instructional_scaleform != NULL
            SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(g_instructional_scaleform)
        ENDIF
        DRAW_SPEEDOMETER()
        WAIT(0)
    ENDWHILE
ENDSCRIPT
