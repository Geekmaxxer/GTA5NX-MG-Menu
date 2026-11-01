// *****************************************************************************************
// *****************************************************************************************
//
//      SCRIPT NAME     :   chaosmod.sc
//      TITLE           :   Chaos Mod V-NX (Refined Nintendo Switch Edition)
//      AUTHOR          :   Geekmaxxer & Antigravity
//      DESCRIPTION     :   High-octane timed random chaos effects every 30 seconds with
//                          sleek top-center HUD progress bar, warning audio chimes,
//                          dynamic physics & gameplay mutators, input isolation, and
//                          guaranteed zero-leak state cleanup.
//                          Shortcuts: Hold RB + D-Pad Left (Pause) & Right (Skip).
//
// *****************************************************************************************
// *****************************************************************************************

USING "rage_builtins.sch"
USING "commands_script.sch"
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
USING "commands_task.sch"
USING "commands_fire.sch"
USING "commands_cutscene.sch"
USING "commands_interiors.sch"

// -------------------------------------------------------------------------
// CONSTANTS
// -------------------------------------------------------------------------
CONST_INT CHAOS_EFFECT_COUNT             35

// -------------------------------------------------------------------------
// STATICS (Script-Level Persistence for RAGE VM Fixed Stack Pools)
// -------------------------------------------------------------------------
BOOL g_chaos_active                     = TRUE
INT g_chaos_current_effect              = -1
INT g_chaos_timer_duration              = 20000
INT g_chaos_remaining_ms                = 20000
INT g_chaos_last_tick                   = 0
FLOAT g_chaos_current_timescale         = 1.0

BOOL g_chaos_chime_3s                   = FALSE
BOOL g_chaos_chime_2s                   = FALSE
BOOL g_chaos_chime_1s                   = FALSE

TEXT_LABEL_63 g_chaos_effect_name       = "Waiting for Chaos..."
INT g_chaos_color_r                     = 0
INT g_chaos_color_g                     = 220
INT g_chaos_color_b                     = 255

// Active periodic ticks & cooldowns
INT g_chaos_meteor_tick                 = 0
INT g_chaos_traffic_tick                = 0
INT g_chaos_riot_tick                   = 0
INT g_chaos_slip_cooldown               = 0
INT g_chaos_bounce_tick                 = 0
INT g_chaos_airstrike_tick              = 0
INT g_chaos_jesus_horn_tick             = 0
INT g_chaos_bomber_tick                 = 0
INT g_chaos_fast_hour                   = 12
INT g_chaos_fast_min                    = 0
BOOL g_chaos_drunk_applied              = FALSE

// Async model request state (never block with WAIT(0) inside effect triggers)
BOOL g_chaos_spawn_pending              = FALSE
MODEL_NAMES g_chaos_spawn_model         = DUMMY_MODEL_FOR_SCRIPT
INT g_chaos_spawn_deadline              = 0

// Tracked entity slots for guaranteed zero-leak cleanup
PED_INDEX g_chaos_tracked_peds[4]
VEHICLE_INDEX g_chaos_tracked_vehs[4]
PED_INDEX g_chaos_bomber_ped            = NULL
VEHICLE_INDEX g_chaos_last_modified_veh = NULL

// -------------------------------------------------------------------------
// HELPER: Clamping
// -------------------------------------------------------------------------
FUNC FLOAT CHAOS_CLAMP(FLOAT val, FLOAT minVal, FLOAT maxVal)
    IF val < minVal RETURN minVal ENDIF
    IF val > maxVal RETURN maxVal ENDIF
    RETURN val
ENDFUNC

// -------------------------------------------------------------------------
// HELPER: Audio Cues
// -------------------------------------------------------------------------
PROC CHAOS_PLAY_SOUND(STRING soundName, STRING soundSet)
    PLAY_SOUND_FRONTEND(-1, soundName, soundSet, TRUE)
ENDPROC

// -------------------------------------------------------------------------
// HELPER: Notifications & Subtitles
// -------------------------------------------------------------------------
PROC CHAOS_SHOW_TICKER(STRING msg)
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
    ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(msg)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
ENDPROC

PROC CHAOS_SHOW_SUBTITLE()
    BEGIN_TEXT_COMMAND_PRINT("STRING")
    ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_chaos_effect_name)
    END_TEXT_COMMAND_PRINT(3500, TRUE)
ENDPROC

PROC CHAOS_RESET_VEHICLE_MODIFIERS(VEHICLE_INDEX veh)
    IF DOES_ENTITY_EXIST(veh) AND NOT IS_ENTITY_DEAD(veh)
        SET_VEHICLE_FRICTION_OVERRIDE(veh, 1.0)
        SET_VEHICLE_FRICTION_OVERRIDE(veh, -1.0)
        SET_VEHICLE_STEER_BIAS(veh, 0.0)
        SET_VEHICLE_HANDBRAKE(veh, FALSE)
        SET_VEHICLE_CHEAT_POWER_INCREASE(veh, 1.0)
    ENDIF
ENDPROC

// -------------------------------------------------------------------------
// CLEANUP: Scoped State Restoration & Zero Entity Leaks
// Only resets states modified by the active effect so RageMenu toggles are preserved!
// -------------------------------------------------------------------------
PROC CHAOS_CLEANUP_ACTIVE_EFFECT()
    PED_INDEX playerPed = PLAYER_PED_ID()
    PLAYER_INDEX player = PLAYER_ID()
    VEHICLE_INDEX curVeh = NULL
    INT index = 0

    IF DOES_ENTITY_EXIST(playerPed) AND IS_PED_IN_ANY_VEHICLE(playerPed)
        curVeh = GET_VEHICLE_PED_IS_IN(playerPed, FALSE)
    ENDIF

    SWITCH g_chaos_current_effect
        CASE 0
        CASE 1
            SET_GRAVITY_LEVEL(GRAV_EARTH)
        BREAK
        CASE 2
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.0)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.0)
        BREAK
        CASE 4
            IF DOES_ENTITY_EXIST(playerPed)
                RESET_PED_MOVEMENT_CLIPSET(playerPed, 0.25)
            ENDIF
            REMOVE_ANIM_SET("MOVE_M@DRUNK@VERYDRUNK")
            STOP_GAMEPLAY_CAM_SHAKING(TRUE)
            g_chaos_drunk_applied = FALSE
        BREAK
        CASE 5
            SET_NIGHTVISION(FALSE)
        BREAK
        CASE 6
            SET_SEETHROUGH(FALSE)
        BREAK
        CASE 7
            SET_ARTIFICIAL_LIGHTS_STATE(FALSE)
        BREAK
        CASE 9
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_RESPECT, RELGROUPHASH_CIVMALE, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_RESPECT, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_CIVFEMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_RESPECT, RELGROUPHASH_CIVMALE, RELGROUPHASH_CIVFEMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_RESPECT, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_NONE, RELGROUPHASH_CIVMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_NONE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_NONE, RELGROUPHASH_COP, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_NONE, RELGROUPHASH_CIVMALE, RELGROUPHASH_COP)
        BREAK
        CASE 10
            STOP_GAMEPLAY_CAM_SHAKING(TRUE)
        BREAK
        CASE 13
        CASE 18
        CASE 19
        CASE 25
        CASE 26
            CHAOS_RESET_VEHICLE_MODIFIERS(curVeh)
            CHAOS_RESET_VEHICLE_MODIFIERS(g_chaos_last_modified_veh)
        BREAK
        CASE 14
        CASE 32
            SET_TIME_SCALE(1.0)
            g_chaos_current_timescale = 1.0
        BREAK
        CASE 15
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.0)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.0)
            CHAOS_RESET_VEHICLE_MODIFIERS(curVeh)
            CHAOS_RESET_VEHICLE_MODIFIERS(g_chaos_last_modified_veh)
        BREAK
        CASE 16
            SET_WEATHER_TYPE_NOW_PERSIST("CLEAR")
        BREAK
        CASE 27
            CLEAR_TIMECYCLE_MODIFIER()
            STOP_GAMEPLAY_CAM_SHAKING(TRUE)
        BREAK
    ENDSWITCH

    g_chaos_last_modified_veh = NULL
    g_chaos_current_timescale = 1.0

    // Release any pending async model request
    IF g_chaos_spawn_pending AND g_chaos_spawn_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
    ENDIF
    g_chaos_spawn_pending = FALSE
    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT

    // Delete / Dismiss Tracked Entities
    WHILE index < 4
        IF DOES_ENTITY_EXIST(g_chaos_tracked_peds[index])
            IF NOT IS_ENTITY_A_MISSION_ENTITY(g_chaos_tracked_peds[index])
                SET_PED_AS_NO_LONGER_NEEDED(g_chaos_tracked_peds[index])
            ELSE
                DELETE_PED(g_chaos_tracked_peds[index])
            ENDIF
            g_chaos_tracked_peds[index] = NULL
        ENDIF

        IF DOES_ENTITY_EXIST(g_chaos_tracked_vehs[index])
            IF NOT IS_ENTITY_A_MISSION_ENTITY(g_chaos_tracked_vehs[index])
                SET_VEHICLE_AS_NO_LONGER_NEEDED(g_chaos_tracked_vehs[index])
            ELSE
                DELETE_VEHICLE(g_chaos_tracked_vehs[index])
            ENDIF
            g_chaos_tracked_vehs[index] = NULL
        ENDIF
        index = index + 1
    ENDWHILE

    IF DOES_ENTITY_EXIST(g_chaos_bomber_ped)
        IF NOT IS_ENTITY_A_MISSION_ENTITY(g_chaos_bomber_ped)
            SET_PED_AS_NO_LONGER_NEEDED(g_chaos_bomber_ped)
        ELSE
            DELETE_PED(g_chaos_bomber_ped)
        ENDIF
        g_chaos_bomber_ped = NULL
    ENDIF
ENDPROC

// -------------------------------------------------------------------------
// EFFECT TRIGGERING: 35 Rock-Solid Switch Chaos Effects
// -------------------------------------------------------------------------
PROC CHAOS_TRIGGER_NEXT_EFFECT()
    PED_INDEX playerPed = PLAYER_PED_ID()
    PLAYER_INDEX player = PLAYER_ID()
    VECTOR pCoords
    VEHICLE_INDEX pVeh = NULL
    VEHICLE_INDEX candVeh = NULL
    MODEL_NAMES candModel = DUMMY_MODEL_FOR_SCRIPT
    INT nextEffect = 0
    INT loopIdx = 0
    BOOL inInterior = FALSE

    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed)
        EXIT
    ENDIF

    // Clean up whatever effect was active previously
    CHAOS_CLEANUP_ACTIVE_EFFECT()

    // Pick random effect without repeating the exact same one twice
    nextEffect = GET_RANDOM_INT_IN_RANGE(0, CHAOS_EFFECT_COUNT)
    IF nextEffect = g_chaos_current_effect
        nextEffect = nextEffect + 1
        IF nextEffect >= CHAOS_EFFECT_COUNT
            nextEffect = 0
        ENDIF
    ENDIF
    g_chaos_current_effect = nextEffect

    pCoords = GET_ENTITY_COORDS(playerPed)
    inInterior = (GET_INTERIOR_FROM_ENTITY(playerPed) != NULL)
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        pVeh = GET_VEHICLE_PED_IS_IN(playerPed, FALSE)
    ENDIF

    SWITCH nextEffect
        // --- 0: Low Gravity ---
        CASE 0
            g_chaos_effect_name = "Low Gravity (Moon Physics)"
            g_chaos_color_r = 0
            g_chaos_color_g = 220
            g_chaos_color_b = 255
            SET_GRAVITY_LEVEL(GRAV_LOW)
        BREAK

        // --- 1: Zero Gravity ---
        CASE 1
            g_chaos_effect_name = "Zero Gravity (Space Physics)"
            g_chaos_color_r = 180
            g_chaos_color_g = 50
            g_chaos_color_b = 255
            SET_GRAVITY_LEVEL(GRAV_ZERO)
        BREAK

        // --- 2: Sonic Super Speed ---
        CASE 2
            g_chaos_effect_name = "Sonic Super Speed"
            g_chaos_color_r = 0
            g_chaos_color_g = 160
            g_chaos_color_b = 255
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.49)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.49)
        BREAK

        // --- 3: Super Jump ---
        CASE 3
            g_chaos_effect_name = "Super Jump"
            g_chaos_color_r = 50
            g_chaos_color_g = 255
            g_chaos_color_b = 50
        BREAK

        // --- 4: Drunk Walk ---
        CASE 4
            g_chaos_effect_name = "Drunk Mode"
            g_chaos_color_r = 255
            g_chaos_color_g = 140
            g_chaos_color_b = 0
            REQUEST_ANIM_SET("MOVE_M@DRUNK@VERYDRUNK")
            SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 1.0)
            g_chaos_drunk_applied = FALSE
        BREAK

        // --- 5: Night Vision ---
        CASE 5
            g_chaos_effect_name = "Extreme Night Vision"
            g_chaos_color_r = 0
            g_chaos_color_g = 255
            g_chaos_color_b = 100
            SET_NIGHTVISION(TRUE)
        BREAK

        // --- 6: Thermal Vision ---
        CASE 6
            g_chaos_effect_name = "Thermal Vision"
            g_chaos_color_r = 255
            g_chaos_color_g = 50
            g_chaos_color_b = 50
            SET_SEETHROUGH(TRUE)
        BREAK

        // --- 7: City Blackout & EMP ---
        CASE 7
            g_chaos_effect_name = "City Blackout & EMP"
            g_chaos_color_r = 180
            g_chaos_color_g = 180
            g_chaos_color_b = 180
            SET_ARTIFICIAL_LIGHTS_STATE(TRUE)
        BREAK

        // --- 8: Crazy Traffic ---
        CASE 8
            g_chaos_effect_name = "Crazy Traffic"
            g_chaos_color_r = 255
            g_chaos_color_g = 40
            g_chaos_color_b = 40
            g_chaos_traffic_tick = 0
        BREAK

        // --- 9: Armed Ped Riot ---
        CASE 9
            g_chaos_effect_name = "Armed Ped Riot"
            g_chaos_color_r = 230
            g_chaos_color_g = 0
            g_chaos_color_b = 0
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVMALE, RELGROUPHASH_CIVFEMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_COP, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVMALE, RELGROUPHASH_COP)
            g_chaos_riot_tick = 0
        BREAK

        // --- 10: Earthquake ---
        CASE 10
            g_chaos_effect_name = "Earthquake"
            g_chaos_color_r = 255
            g_chaos_color_g = 220
            g_chaos_color_b = 0
            SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", 0.75)
        BREAK

        // --- 11: Explosive Melee ---
        CASE 11
            g_chaos_effect_name = "Explosive Melee"
            g_chaos_color_r = 255
            g_chaos_color_g = 120
            g_chaos_color_b = 0
        BREAK

        // --- 12: Explosive Bullets ---
        CASE 12
            g_chaos_effect_name = "Explosive Ammo"
            g_chaos_color_r = 255
            g_chaos_color_g = 80
            g_chaos_color_b = 0
        BREAK

        // --- 13: Slippery Tires ---
        CASE 13
            g_chaos_effect_name = "Slippery Tires (Zero Friction)"
            g_chaos_color_r = 100
            g_chaos_color_g = 240
            g_chaos_color_b = 255
            IF DOES_ENTITY_EXIST(pVeh)
                SET_VEHICLE_FRICTION_OVERRIDE(pVeh, 0.08)
                g_chaos_last_modified_veh = pVeh
            ENDIF
        BREAK

        // --- 14: Matrix Slow Motion ---
        CASE 14
            g_chaos_effect_name = "Matrix Slow Motion (0.35x)"
            g_chaos_color_r = 0
            g_chaos_color_g = 200
            g_chaos_color_b = 180
            g_chaos_current_timescale = 0.35
            SET_TIME_SCALE(0.35)
        BREAK

        // --- 15: Fast Forward (Turbo World) ---
        CASE 15
            g_chaos_effect_name = "Fast Forward (Turbo World)"
            g_chaos_color_r = 255
            g_chaos_color_g = 230
            g_chaos_color_b = 0
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.49)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.49)
            g_chaos_traffic_tick = 0
            g_chaos_fast_hour = GET_CLOCK_HOURS()
            g_chaos_fast_min = GET_CLOCK_MINUTES()
            IF DOES_ENTITY_EXIST(pVeh)
                SET_VEHICLE_CHEAT_POWER_INCREASE(pVeh, 4.0)
                g_chaos_last_modified_veh = pVeh
                IF GET_ENTITY_SPEED(pVeh) > 1.0 AND GET_ENTITY_SPEED(pVeh) < 42.0
                    SET_VEHICLE_FORWARD_SPEED(pVeh, GET_ENTITY_SPEED(pVeh) + 12.0)
                ENDIF
            ENDIF
        BREAK

        // --- 16: Thunderstorm ---
        CASE 16
            g_chaos_effect_name = "Heavy Thunderstorm"
            g_chaos_color_r = 80
            g_chaos_color_g = 120
            g_chaos_color_b = 220
            SET_WEATHER_TYPE_NOW_PERSIST("THUNDER")
        BREAK

        // --- 17: Butter Legs ---
        CASE 17
            g_chaos_effect_name = "Butter Legs (Slip & Fall)"
            g_chaos_color_r = 240
            g_chaos_color_g = 200
            g_chaos_color_b = 50
            g_chaos_slip_cooldown = GET_GAME_TIMER() + 2500
        BREAK

        // --- 18: Stuck Gas Pedal ---
        CASE 18
            g_chaos_effect_name = "Stuck Gas Pedal (Full Throttle)"
            g_chaos_color_r = 255
            g_chaos_color_g = 40
            g_chaos_color_b = 40
            IF DOES_ENTITY_EXIST(pVeh)
                SET_VEHICLE_ENGINE_ON(pVeh, TRUE, TRUE, FALSE)
                SET_VEHICLE_FORWARD_SPEED(pVeh, 36.0)
                g_chaos_last_modified_veh = pVeh
            ENDIF
        BREAK

        // --- 19: Unstable Steering ---
        CASE 19
            g_chaos_effect_name = "Unstable Vehicle Steering"
            g_chaos_color_r = 200
            g_chaos_color_g = 100
            g_chaos_color_b = 255
        BREAK

        // --- 20: Meteor Shower ---
        CASE 20
            g_chaos_effect_name = "Meteor Shower"
            g_chaos_color_r = 255
            g_chaos_color_g = 90
            g_chaos_color_b = 0
            g_chaos_meteor_tick = 0
        BREAK

        // --- 21: Skyfall! ---
        CASE 21
            g_chaos_effect_name = "Skyfall!"
            g_chaos_color_r = 50
            g_chaos_color_g = 180
            g_chaos_color_b = 255
            IF DOES_ENTITY_EXIST(pVeh)
                TASK_LEAVE_ANY_VEHICLE(playerPed, 0, ECF_WARP_PED | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP)
            ENDIF
            // If player is inside an interior (like Simeon's showroom), shift X/Y slightly outside so they don't land on an interior roof shell
            IF inInterior
                pCoords.y = pCoords.y - 18.0
            ENDIF
            pCoords.z = pCoords.z + 160.0
            SET_ENTITY_COORDS(playerPed, pCoords, TRUE, TRUE, TRUE, TRUE)
            GIVE_WEAPON_TO_PED(playerPed, GADGETTYPE_PARACHUTE, 1, FALSE, TRUE)
        BREAK

        // --- 22: Rocket Boost Launch ---
        CASE 22
            g_chaos_effect_name = "Rocket Boost Launch!"
            g_chaos_color_r = 255
            g_chaos_color_g = 130
            g_chaos_color_b = 0
            IF DOES_ENTITY_EXIST(pVeh)
                APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pVeh, APPLY_TYPE_EXTERNAL_IMPULSE, <<0.0, 4.0, 32.0>>, 0, TRUE, TRUE)
            ELIF inInterior
                IF SET_PED_TO_RAGDOLL(playerPed, 1800, 1800, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(playerPed, APPLY_TYPE_EXTERNAL_IMPULSE, <<0.0, 14.0, 2.0>>, 0, TRUE, TRUE)
            ELSE
                IF SET_PED_TO_RAGDOLL(playerPed, 1800, 1800, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(playerPed, APPLY_TYPE_EXTERNAL_IMPULSE, <<0.0, 2.0, 24.0>>, 0, TRUE, TRUE)
                GIVE_WEAPON_TO_PED(playerPed, GADGETTYPE_PARACHUTE, 1, FALSE, TRUE)
            ENDIF
        BREAK

        // --- 23: Explode Nearby Cars ---
        CASE 23
            g_chaos_effect_name = "Explode Nearby Cars!"
            g_chaos_color_r = 255
            g_chaos_color_g = 30
            g_chaos_color_b = 0
            loopIdx = 0
            WHILE loopIdx < 6
                candVeh = GET_RANDOM_VEHICLE_IN_SPHERE(pCoords, 55.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
                IF DOES_ENTITY_EXIST(candVeh) AND candVeh != pVeh AND GET_DISTANCE_BETWEEN_COORDS(GET_ENTITY_COORDS(candVeh), <<-44.0, -1100.0, 26.4>>, TRUE) > 22.0
                    ADD_EXPLOSION(GET_ENTITY_COORDS(candVeh), EXP_TAG_HI_OCTANE, 1.0, TRUE, FALSE, 0.65)
                ENDIF
                loopIdx = loopIdx + 1
            ENDWHILE
        BREAK

        // --- 24: Instant 5-Star Wanted Level ---
        CASE 24
            g_chaos_effect_name = "Instant 5 Stars!"
            g_chaos_color_r = 200
            g_chaos_color_g = 0
            g_chaos_color_b = 0
            SET_PLAYER_WANTED_LEVEL(player, 5, FALSE)
            SET_PLAYER_WANTED_LEVEL_NOW(player, FALSE)
        BREAK

        // --- 25: Jesus Take The Wheel! ---
        CASE 25
            g_chaos_effect_name = "Jesus Take The Wheel!"
            g_chaos_color_r = 255
            g_chaos_color_g = 50
            g_chaos_color_b = 50
            g_chaos_jesus_horn_tick = 0
            IF DOES_ENTITY_EXIST(pVeh)
                SET_VEHICLE_ENGINE_ON(pVeh, TRUE, TRUE, FALSE)
                SET_VEHICLE_FORWARD_SPEED(pVeh, 38.0)
                g_chaos_last_modified_veh = pVeh
            ENDIF
        BREAK

        // --- 26: Invert Controls! ---
        CASE 26
            g_chaos_effect_name = "Invert Controls!"
            g_chaos_color_r = 255
            g_chaos_color_g = 120
            g_chaos_color_b = 0
        BREAK

        // --- 27: Acid Trip (Psychedelic) ---
        CASE 27
            g_chaos_effect_name = "Acid Trip (Psychedelic)"
            g_chaos_color_r = 255
            g_chaos_color_g = 0
            g_chaos_color_b = 255
            SET_TIMECYCLE_MODIFIER("spectator5")
            SET_TIMECYCLE_MODIFIER_STRENGTH(1.0)
            SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 1.25)
        BREAK

        // --- 28: Vehicle Cannon Blast ---
        CASE 28
            g_chaos_effect_name = "Vehicle Cannon Blast"
            g_chaos_color_r = 255
            g_chaos_color_g = 0
            g_chaos_color_b = 180
            IF NOT inInterior
                candModel = INT_TO_ENUM(MODEL_NAMES, HASH("adder"))
                IF IS_MODEL_IN_CDIMAGE(candModel) AND IS_MODEL_VALID(candModel)
                    REQUEST_MODEL(candModel)
                    g_chaos_spawn_model = candModel
                    g_chaos_spawn_deadline = GET_GAME_TIMER() + 2000
                    g_chaos_spawn_pending = TRUE
                ENDIF
            ENDIF
        BREAK

        // --- 29: Hostile Clown Attackers ---
        CASE 29
            g_chaos_effect_name = "Hostile Clown Attackers"
            g_chaos_color_r = 240
            g_chaos_color_g = 40
            g_chaos_color_b = 40
            candModel = INT_TO_ENUM(MODEL_NAMES, HASH("s_m_y_clown_01"))
            IF IS_MODEL_IN_CDIMAGE(candModel) AND IS_MODEL_VALID(candModel)
                REQUEST_MODEL(candModel)
                g_chaos_spawn_model = candModel
                g_chaos_spawn_deadline = GET_GAME_TIMER() + 2000
                g_chaos_spawn_pending = TRUE
            ENDIF
        BREAK

        // --- 30: Bouncy Traffic (Pogo Cars) ---
        CASE 30
            g_chaos_effect_name = "Bouncy Traffic (Pogo Cars)"
            g_chaos_color_r = 50
            g_chaos_color_g = 255
            g_chaos_color_b = 150
            g_chaos_bounce_tick = 0
        BREAK

        // --- 31: Ejector Seat! ---
        CASE 31
            g_chaos_effect_name = "Ejector Seat!"
            g_chaos_color_r = 255
            g_chaos_color_g = 200
            g_chaos_color_b = 0
            IF DOES_ENTITY_EXIST(pVeh)
                TASK_LEAVE_ANY_VEHICLE(playerPed, 0, ECF_WARP_PED | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP)
                IF SET_PED_TO_RAGDOLL(playerPed, 3000, 3000, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(playerPed, APPLY_TYPE_EXTERNAL_IMPULSE, <<0.0, 0.0, 22.0>>, 0, FALSE, TRUE)
            ELSE
                IF SET_PED_TO_RAGDOLL(playerPed, 2500, 2500, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                IF inInterior
                    APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(playerPed, APPLY_TYPE_EXTERNAL_IMPULSE, <<-8.0, -8.0, 2.0>>, 0, FALSE, TRUE)
                ELSE
                    APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(playerPed, APPLY_TYPE_EXTERNAL_IMPULSE, <<-5.0, -5.0, 8.0>>, 0, FALSE, TRUE)
                ENDIF
            ENDIF
        BREAK

        // --- 32: SuperHot (Aim for Bullet Time) ---
        CASE 32
            g_chaos_effect_name = "SuperHot (Aim for Bullet Time)"
            g_chaos_color_r = 255
            g_chaos_color_g = 40
            g_chaos_color_b = 40
            g_chaos_current_timescale = 1.0
            SET_TIME_SCALE(1.0)
        BREAK

        // --- 33: Airstrike Inbound! ---
        CASE 33
            g_chaos_effect_name = "Airstrike Inbound!"
            g_chaos_color_r = 255
            g_chaos_color_g = 60
            g_chaos_color_b = 0
            g_chaos_airstrike_tick = 0
        BREAK

        // --- 34: Suicide Bomber Ped! ---
        CASE 34
            g_chaos_effect_name = "Suicide Bomber Ped!"
            g_chaos_color_r = 255
            g_chaos_color_g = 80
            g_chaos_color_b = 0
            candModel = INT_TO_ENUM(MODEL_NAMES, HASH("a_m_m_skater_01"))
            IF IS_MODEL_IN_CDIMAGE(candModel) AND IS_MODEL_VALID(candModel)
                REQUEST_MODEL(candModel)
                g_chaos_spawn_model = candModel
                g_chaos_spawn_deadline = GET_GAME_TIMER() + 2000
                g_chaos_spawn_pending = TRUE
            ENDIF
        BREAK
    ENDSWITCH

    // Reset countdown timer with randomized duration between 15s and 30s
    g_chaos_timer_duration = GET_RANDOM_INT_IN_RANGE(15000, 30000)
    g_chaos_remaining_ms = g_chaos_timer_duration
    g_chaos_last_tick = GET_GAME_TIMER()
    g_chaos_chime_3s = FALSE
    g_chaos_chime_2s = FALSE
    g_chaos_chime_1s = FALSE

    // Announce triggered effect
    CHAOS_SHOW_SUBTITLE()
    CHAOS_PLAY_SOUND("CHALLENGE_UNLOCKED", "HUD_AWARDS")
ENDPROC

// -------------------------------------------------------------------------
// FRAME PROCESSING: Ongoing Effects (Jump, Ragdoll, Meteor, Bomber, Traffic)
// -------------------------------------------------------------------------
PROC CHAOS_PROCESS_FRAME_EFFECTS()
    PED_INDEX playerPed = PLAYER_PED_ID()
    PLAYER_INDEX player = PLAYER_ID()
    INT now = GET_GAME_TIMER()
    VECTOR pCoords
    VECTOR vGround
    VECTOR vSky
    VECTOR vTarget
    FLOAT groundZ = 0.0
    FLOAT steerWobble = 0.0
    VEHICLE_INDEX pVeh = NULL
    VEHICLE_INDEX candVeh = NULL
    PED_INDEX driverPed = NULL
    PED_INDEX nearbyPeds[16]
    INT nearbyCount = 0
    INT loopIdx = 0
    BOOL menuOpen = NOT IS_CONTROL_ENABLED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
    BOOL isAiming = FALSE
    DRIVINGMODE crazyMode = DF_SwerveAroundAllCars|DF_SteerAroundObjects|DF_DriveIntoOncomingTraffic|DF_ChangeLanesAroundObstructions|DF_UseShortCutLinks|DF_ForceJoinInRoadDirection|DF_UseWanderFallbackInsteadOfStraightLine

    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed)
        EXIT
    ENDIF

    pCoords = GET_ENTITY_COORDS(playerPed)
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        pVeh = GET_VEHICLE_PED_IS_IN(playerPed, FALSE)
    ENDIF

    // If the player exited or switched vehicles during a vehicle-modifying effect,
    // immediately restore the previous vehicle so it isn't left with locked handbrake/steer/friction.
    IF pVeh != g_chaos_last_modified_veh
        IF g_chaos_last_modified_veh != NULL
            CHAOS_RESET_VEHICLE_MODIFIERS(g_chaos_last_modified_veh)
        ENDIF
        g_chaos_last_modified_veh = pVeh
    ENDIF

    SWITCH g_chaos_current_effect
        // --- 2: Sonic Super Speed ---
        CASE 2
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.49)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.49)
        BREAK

        // --- 3: Super Jump ---
        CASE 3
            SET_SUPER_JUMP_THIS_FRAME(player)
        BREAK

        // --- 4: Drunk Walk ---
        CASE 4
            IF NOT g_chaos_drunk_applied
                IF HAS_ANIM_SET_LOADED("MOVE_M@DRUNK@VERYDRUNK")
                    SET_PED_MOVEMENT_CLIPSET(playerPed, "MOVE_M@DRUNK@VERYDRUNK", 1.0)
                    g_chaos_drunk_applied = TRUE
                ENDIF
            ENDIF
        BREAK

        // --- 8: Crazy Traffic ---
        CASE 8
            IF now >= g_chaos_traffic_tick
                g_chaos_traffic_tick = now + 900
                loopIdx = 0
                WHILE loopIdx < 8
                    candVeh = GET_RANDOM_VEHICLE_IN_SPHERE(pCoords, 85.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
                    IF DOES_ENTITY_EXIST(candVeh) AND candVeh != pVeh
                        driverPed = GET_PED_IN_VEHICLE_SEAT(candVeh, VS_DRIVER, FALSE)
                        IF DOES_ENTITY_EXIST(driverPed) AND driverPed != playerPed AND NOT IS_PED_INJURED(driverPed) AND NOT IS_PED_IN_GROUP(driverPed) AND GET_PED_RELATIONSHIP_GROUP_HASH(driverPed) != RELGROUPHASH_PLAYER
                            SET_DRIVER_ABILITY(driverPed, 1.0)
                            SET_DRIVER_AGGRESSIVENESS(driverPed, 1.0)
                            TASK_VEHICLE_DRIVE_WANDER(driverPed, candVeh, 45.0, crazyMode)
                            IF GET_ENTITY_SPEED(candVeh) < 18.0
                                SET_VEHICLE_FORWARD_SPEED(candVeh, 28.0)
                            ENDIF
                        ENDIF
                    ENDIF
                    loopIdx = loopIdx + 1
                ENDWHILE
            ENDIF
        BREAK

        // --- 9: Armed Ped Riot ---
        CASE 9
            IF now >= g_chaos_riot_tick
                g_chaos_riot_tick = now + 1500
                nearbyCount = GET_PED_NEARBY_PEDS(playerPed, nearbyPeds, PEDTYPE_INVALID)
                IF nearbyCount > COUNT_OF(nearbyPeds) nearbyCount = COUNT_OF(nearbyPeds) ENDIF
                loopIdx = 0
                WHILE loopIdx < nearbyCount
                    IF DOES_ENTITY_EXIST(nearbyPeds[loopIdx]) AND nearbyPeds[loopIdx] != playerPed AND NOT IS_PED_INJURED(nearbyPeds[loopIdx]) AND NOT IS_PED_A_PLAYER(nearbyPeds[loopIdx]) AND NOT IS_PED_IN_GROUP(nearbyPeds[loopIdx]) AND GET_PED_RELATIONSHIP_GROUP_HASH(nearbyPeds[loopIdx]) != RELGROUPHASH_PLAYER
                        GIVE_WEAPON_TO_PED(nearbyPeds[loopIdx], WEAPONTYPE_MICROSMG, 9999, TRUE, TRUE)
                        SET_PED_COMBAT_ATTRIBUTES(nearbyPeds[loopIdx], CA_ALWAYS_FIGHT, TRUE)
                        SET_PED_FLEE_ATTRIBUTES(nearbyPeds[loopIdx], FA_NEVER_FLEE, TRUE)
                        SET_PED_COMBAT_ABILITY(nearbyPeds[loopIdx], CAL_PROFESSIONAL)
                        TASK_COMBAT_HATED_TARGETS_AROUND_PED(nearbyPeds[loopIdx], 90.0)
                    ENDIF
                    loopIdx = loopIdx + 1
                ENDWHILE
            ENDIF
        BREAK

        // --- 11: Explosive Melee ---
        CASE 11
            SET_EXPLOSIVE_MELEE_THIS_FRAME(player)
        BREAK

        // --- 12: Explosive Ammo ---
        CASE 12
            SET_EXPLOSIVE_AMMO_THIS_FRAME(player)
        BREAK

        // --- 13: Slippery Tires ---
        CASE 13
            IF DOES_ENTITY_EXIST(pVeh)
                SET_VEHICLE_FRICTION_OVERRIDE(pVeh, 0.08)
            ENDIF
        BREAK

        // --- 14: Matrix Slow Motion (Pause slow-mo while RageMenu is open) ---
        CASE 14
            IF menuOpen
                g_chaos_current_timescale = 1.0
                SET_TIME_SCALE(1.0)
            ELSE
                g_chaos_current_timescale = 0.35
                SET_TIME_SCALE(0.35)
            ENDIF
        BREAK

        // --- 15: Fast Forward (Turbo World) ---
        CASE 15
            SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(player, 1.49)
            SET_SWIM_MULTIPLIER_FOR_PLAYER(player, 1.49)
            g_chaos_fast_min = g_chaos_fast_min + 2
            IF g_chaos_fast_min >= 60
                g_chaos_fast_min = g_chaos_fast_min - 60
                g_chaos_fast_hour = g_chaos_fast_hour + 1
                IF g_chaos_fast_hour >= 24
                    g_chaos_fast_hour = 0
                ENDIF
            ENDIF
            SET_CLOCK_TIME(g_chaos_fast_hour, g_chaos_fast_min, 0)
            IF DOES_ENTITY_EXIST(pVeh)
                IF GET_ENTITY_SPEED(pVeh) < 70.0
                    SET_VEHICLE_CHEAT_POWER_INCREASE(pVeh, 4.0)
                ELSE
                    SET_VEHICLE_CHEAT_POWER_INCREASE(pVeh, 1.0)
                ENDIF
            ENDIF
            IF now >= g_chaos_traffic_tick
                g_chaos_traffic_tick = now + 350
                loopIdx = 0
                WHILE loopIdx < 8
                    candVeh = GET_RANDOM_VEHICLE_IN_SPHERE(pCoords, 80.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
                    IF DOES_ENTITY_EXIST(candVeh) AND candVeh != pVeh
                        SET_VEHICLE_CHEAT_POWER_INCREASE(candVeh, 4.0)
                        IF GET_ENTITY_SPEED(candVeh) > 1.5 AND GET_ENTITY_SPEED(candVeh) < 38.0
                            SET_VEHICLE_FORWARD_SPEED(candVeh, GET_ENTITY_SPEED(candVeh) + 9.0)
                        ENDIF
                    ENDIF
                    loopIdx = loopIdx + 1
                ENDWHILE
            ENDIF
        BREAK

        // --- 17: Butter Legs ---
        CASE 17
            IF NOT DOES_ENTITY_EXIST(pVeh)
                IF now >= g_chaos_slip_cooldown
                    IF IS_PED_RUNNING(playerPed) OR IS_PED_SPRINTING(playerPed)
                        IF SET_PED_TO_RAGDOLL(playerPed, 2000, 2000, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                        g_chaos_slip_cooldown = now + 3500
                    ENDIF
                ENDIF
            ENDIF
        BREAK

        // --- 18: Stuck Gas Pedal ---
        CASE 18
            IF DOES_ENTITY_EXIST(pVeh)
                IF GET_ENTITY_SPEED(pVeh) < 38.0
                    SET_VEHICLE_FORWARD_SPEED(pVeh, GET_ENTITY_SPEED(pVeh) + 1.2)
                ENDIF
            ENDIF
        BREAK

        // --- 19: Unstable Steering ---
        CASE 19
            IF DOES_ENTITY_EXIST(pVeh)
                steerWobble = SIN(TO_FLOAT(now) * 0.0035) * 0.70
                SET_VEHICLE_STEER_BIAS(pVeh, steerWobble)
            ENDIF
        BREAK

        // --- 20: Meteor Shower ---
        CASE 20
            IF now >= g_chaos_meteor_tick
                g_chaos_meteor_tick = now + 750
                vGround.x = pCoords.x + GET_RANDOM_FLOAT_IN_RANGE(-40.0, 40.0)
                vGround.y = pCoords.y + GET_RANDOM_FLOAT_IN_RANGE(-40.0, 40.0)
                vGround.z = pCoords.z + 80.0
                IF GET_GROUND_Z_FOR_3D_COORD(vGround, groundZ)
                    vGround.z = groundZ
                ELSE
                    vGround.z = pCoords.z
                ENDIF
                vSky.x = vGround.x + GET_RANDOM_FLOAT_IN_RANGE(-12.0, 12.0)
                vSky.y = vGround.y + GET_RANDOM_FLOAT_IN_RANGE(-12.0, 12.0)
                vSky.z = vGround.z + 85.0
                SHOOT_SINGLE_BULLET_BETWEEN_COORDS(vSky, vGround, 250, TRUE, WEAPONTYPE_RPG, playerPed, TRUE, FALSE, 180.0)
                ADD_EXPLOSION(vGround, EXP_TAG_HI_OCTANE, 1.0, TRUE, FALSE, 0.55)
            ENDIF
        BREAK

        // --- 25: Jesus Take The Wheel ---
        CASE 25
            IF DOES_ENTITY_EXIST(pVeh)
                IF GET_ENTITY_SPEED(pVeh) < 32.0
                    SET_VEHICLE_FORWARD_SPEED(pVeh, GET_ENTITY_SPEED(pVeh) + 1.2)
                ENDIF
                steerWobble = SIN(TO_FLOAT(now) * 0.005) * 0.85
                SET_VEHICLE_STEER_BIAS(pVeh, steerWobble)
                IF now >= g_chaos_jesus_horn_tick
                    START_VEHICLE_HORN(pVeh, 900, HASH("HELDDOWN"), FALSE)
                    g_chaos_jesus_horn_tick = now + 1000
                ENDIF
            ENDIF
        BREAK

        // --- 26: Invert Controls ---
        CASE 26
            IF DOES_ENTITY_EXIST(pVeh)
                IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_MOVE_LEFT_ONLY) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_MOVE_LEFT_ONLY)
                    SET_VEHICLE_STEER_BIAS(pVeh, 0.90)
                ELIF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_MOVE_RIGHT_ONLY) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_MOVE_RIGHT_ONLY)
                    SET_VEHICLE_STEER_BIAS(pVeh, -0.90)
                ELSE
                    SET_VEHICLE_STEER_BIAS(pVeh, 0.0)
                ENDIF
                IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_ACCELERATE) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_ACCELERATE)
                    SET_VEHICLE_HANDBRAKE(pVeh, TRUE)
                ELSE
                    SET_VEHICLE_HANDBRAKE(pVeh, FALSE)
                ENDIF
            ELSE
                IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_UP_ONLY) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_DOWN_ONLY) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_LEFT_ONLY) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_RIGHT_ONLY)
                    IF now >= g_chaos_slip_cooldown
                        IF SET_PED_TO_RAGDOLL(playerPed, 800, 800, TASK_NM_SCRIPT, TRUE, TRUE, FALSE) ENDIF
                        g_chaos_slip_cooldown = now + 1800
                    ENDIF
                ENDIF
            ENDIF
        BREAK

        // --- 28: Vehicle Cannon Blast (Async Spawn) ---
        CASE 28
            IF g_chaos_spawn_pending
                IF HAS_MODEL_LOADED(g_chaos_spawn_model)
                    vTarget = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<0.0, 5.5, 0.4>>)
                    candVeh = CREATE_VEHICLE(g_chaos_spawn_model, vTarget, GET_ENTITY_HEADING(playerPed), FALSE, TRUE)
                    IF DOES_ENTITY_EXIST(candVeh)
                        SET_VEHICLE_FORWARD_SPEED(candVeh, 55.0)
                        g_chaos_tracked_vehs[0] = candVeh
                    ENDIF
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ELIF now >= g_chaos_spawn_deadline
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ENDIF
            ENDIF
        BREAK

        // --- 29: Hostile Clown Attackers (Async Spawn) ---
        CASE 29
            IF g_chaos_spawn_pending
                IF HAS_MODEL_LOADED(g_chaos_spawn_model)
                    vTarget = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<0.0, 7.5, 0.0>>)
                    g_chaos_tracked_peds[0] = CREATE_PED(PEDTYPE_CIVMALE, g_chaos_spawn_model, vTarget, GET_ENTITY_HEADING(playerPed), FALSE, TRUE)
                    IF DOES_ENTITY_EXIST(g_chaos_tracked_peds[0])
                        GIVE_WEAPON_TO_PED(g_chaos_tracked_peds[0], WEAPONTYPE_BAT, 1, FALSE, TRUE)
                        SET_PED_COMBAT_ATTRIBUTES(g_chaos_tracked_peds[0], CA_ALWAYS_FIGHT, TRUE)
                        SET_PED_COMBAT_ABILITY(g_chaos_tracked_peds[0], CAL_PROFESSIONAL)
                        TASK_COMBAT_PED(g_chaos_tracked_peds[0], playerPed)
                    ENDIF
                    vTarget = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<-5.0, 6.0, 0.0>>)
                    g_chaos_tracked_peds[1] = CREATE_PED(PEDTYPE_CIVMALE, g_chaos_spawn_model, vTarget, GET_ENTITY_HEADING(playerPed), FALSE, TRUE)
                    IF DOES_ENTITY_EXIST(g_chaos_tracked_peds[1])
                        GIVE_WEAPON_TO_PED(g_chaos_tracked_peds[1], WEAPONTYPE_KNIFE, 1, FALSE, TRUE)
                        SET_PED_COMBAT_ATTRIBUTES(g_chaos_tracked_peds[1], CA_ALWAYS_FIGHT, TRUE)
                        SET_PED_COMBAT_ABILITY(g_chaos_tracked_peds[1], CAL_PROFESSIONAL)
                        TASK_COMBAT_PED(g_chaos_tracked_peds[1], playerPed)
                    ENDIF
                    vTarget = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<5.0, 6.0, 0.0>>)
                    g_chaos_tracked_peds[2] = CREATE_PED(PEDTYPE_CIVMALE, g_chaos_spawn_model, vTarget, GET_ENTITY_HEADING(playerPed), FALSE, TRUE)
                    IF DOES_ENTITY_EXIST(g_chaos_tracked_peds[2])
                        GIVE_WEAPON_TO_PED(g_chaos_tracked_peds[2], WEAPONTYPE_BAT, 1, FALSE, TRUE)
                        SET_PED_COMBAT_ATTRIBUTES(g_chaos_tracked_peds[2], CA_ALWAYS_FIGHT, TRUE)
                        SET_PED_COMBAT_ABILITY(g_chaos_tracked_peds[2], CAL_PROFESSIONAL)
                        TASK_COMBAT_PED(g_chaos_tracked_peds[2], playerPed)
                    ENDIF
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ELIF now >= g_chaos_spawn_deadline
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ENDIF
            ENDIF
        BREAK

        // --- 30: Bouncy Traffic (Pogo Cars) ---
        CASE 30
            IF now >= g_chaos_bounce_tick
                g_chaos_bounce_tick = now + 1100
                loopIdx = 0
                WHILE loopIdx < 8
                    candVeh = GET_RANDOM_VEHICLE_IN_SPHERE(pCoords, 65.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
                    IF DOES_ENTITY_EXIST(candVeh) AND GET_DISTANCE_BETWEEN_COORDS(GET_ENTITY_COORDS(candVeh), <<-44.0, -1100.0, 26.4>>, TRUE) > 22.0
                        APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(candVeh, APPLY_TYPE_EXTERNAL_IMPULSE, <<0.0, 0.0, 9.5>>, 0, TRUE, TRUE)
                    ENDIF
                    loopIdx = loopIdx + 1
                ENDWHILE
            ENDIF
        BREAK

        // --- 32: SuperHot (Aim for Bullet Time — only slows game while aiming in!) ---
        CASE 32
            isAiming = IS_PLAYER_FREE_AIMING(player) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_AIM) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_AIM) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_AIM) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_AIM)
            IF isAiming AND NOT menuOpen
                g_chaos_current_timescale = 0.25
                SET_TIME_SCALE(0.25)
            ELSE
                g_chaos_current_timescale = 1.0
                SET_TIME_SCALE(1.0)
            ENDIF
        BREAK

        // --- 33: Airstrike Inbound! ---
        CASE 33
            IF now >= g_chaos_airstrike_tick
                g_chaos_airstrike_tick = now + 650
                vGround.x = pCoords.x + GET_RANDOM_FLOAT_IN_RANGE(-30.0, 30.0)
                vGround.y = pCoords.y + GET_RANDOM_FLOAT_IN_RANGE(-30.0, 30.0)
                vGround.z = pCoords.z + 80.0
                IF GET_GROUND_Z_FOR_3D_COORD(vGround, groundZ)
                    vGround.z = groundZ
                ELSE
                    vGround.z = pCoords.z
                ENDIF
                vSky.x = vGround.x + GET_RANDOM_FLOAT_IN_RANGE(-6.0, 6.0)
                vSky.y = vGround.y + GET_RANDOM_FLOAT_IN_RANGE(-6.0, 6.0)
                vSky.z = vGround.z + 85.0
                SHOOT_SINGLE_BULLET_BETWEEN_COORDS(vSky, vGround, 250, TRUE, WEAPONTYPE_RPG, NULL, TRUE, FALSE, 240.0)
                ADD_EXPLOSION(vGround, EXP_TAG_HI_OCTANE, 2.0, TRUE, FALSE, 0.75)
            ENDIF
        BREAK

        // --- 34: Suicide Bomber Ped (Async Spawn + Proximity Detonation) ---
        CASE 34
            IF g_chaos_spawn_pending
                IF HAS_MODEL_LOADED(g_chaos_spawn_model)
                    vTarget = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<0.0, 20.0, 0.0>>)
                    g_chaos_bomber_ped = CREATE_PED(PEDTYPE_CIVMALE, g_chaos_spawn_model, vTarget, GET_ENTITY_HEADING(playerPed), FALSE, TRUE)
                    IF DOES_ENTITY_EXIST(g_chaos_bomber_ped)
                        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_chaos_bomber_ped, TRUE)
                        SET_PED_FLEE_ATTRIBUTES(g_chaos_bomber_ped, FA_NEVER_FLEE, TRUE)
                        SET_PED_COMBAT_ATTRIBUTES(g_chaos_bomber_ped, CA_ALWAYS_FIGHT, TRUE)
                        GIVE_WEAPON_TO_PED(g_chaos_bomber_ped, WEAPONTYPE_GRENADE, 1, FALSE, TRUE)
                        TASK_GO_TO_ENTITY(g_chaos_bomber_ped, playerPed, -1, 1.3, 4.0)
                        g_chaos_bomber_tick = now + 2000
                    ENDIF
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ELIF now >= g_chaos_spawn_deadline
                    SET_MODEL_AS_NO_LONGER_NEEDED(g_chaos_spawn_model)
                    g_chaos_spawn_pending = FALSE
                    g_chaos_spawn_model = DUMMY_MODEL_FOR_SCRIPT
                ENDIF
            ENDIF
            IF DOES_ENTITY_EXIST(g_chaos_bomber_ped) AND NOT IS_ENTITY_DEAD(g_chaos_bomber_ped)
                IF GET_DISTANCE_BETWEEN_COORDS(GET_ENTITY_COORDS(g_chaos_bomber_ped), pCoords, TRUE) < 3.2
                    ADD_EXPLOSION(GET_ENTITY_COORDS(g_chaos_bomber_ped), EXP_TAG_HI_OCTANE, 4.0, TRUE, FALSE, 1.0)
                    SET_ENTITY_HEALTH(g_chaos_bomber_ped, 0)
                    SET_PED_AS_NO_LONGER_NEEDED(g_chaos_bomber_ped)
                    g_chaos_bomber_ped = NULL
                ELSE
                    IF now >= g_chaos_bomber_tick
                        TASK_GO_TO_ENTITY(g_chaos_bomber_ped, playerPed, -1, 1.3, 4.0)
                        g_chaos_bomber_tick = now + 2000
                    ENDIF
                ENDIF
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

// -------------------------------------------------------------------------
// CONTROLLER INPUTS: Pause / Resume (Hold RB + D-Pad Left) & Skip (Hold RB + D-Pad Right)
// -------------------------------------------------------------------------
PROC CHAOS_PROCESS_CONTROLS()
    // Always disable Rockstar Editor Action Replay recording across all control groups
    // on the Nintendo Switch port; ReplayControl.cpp crashes the game if recording starts.
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_RECORD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_RECORD, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)

    // Ignore Chaos Mod button shortcuts while RageMenu is open (RageMenu disables FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
    IF NOT IS_CONTROL_ENABLED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
        EXIT
    ENDIF

    BOOL lbHeld = IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB)
    BOOL rbHeld = IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB)
    IF lbHeld OR NOT rbHeld
        EXIT
    ENDIF

    // While RB is held (without LB), suppress phone left/right, radio wheel, and context actions
    // so Hold RB + D-Pad Left [Pause/Resume] and Hold RB + D-Pad Right [Skip] work cleanly
    // and never touch D-Pad Down + A/Y (Rockstar Replay crash).
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_LEFT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_RIGHT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_RADIO_WHEEL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CONTEXT, TRUE)

    BOOL dpadLeftPressed = IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_LEFT) OR IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_LEFT)
    BOOL dpadRightPressed = IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_RIGHT) OR IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_RIGHT)

    // 1. Pause / Resume Toggle (Hold RB + D-Pad Left)
    IF dpadLeftPressed
        g_chaos_active = NOT g_chaos_active
        IF NOT g_chaos_active
            CHAOS_CLEANUP_ACTIVE_EFFECT()
            CHAOS_SHOW_TICKER("~y~Chaos Mod V-NX: ~s~PAUSED")
            CHAOS_PLAY_SOUND("NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        ELSE
            CHAOS_SHOW_TICKER("~g~Chaos Mod V-NX: ~s~RESUMED")
            CHAOS_PLAY_SOUND("SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
            CHAOS_TRIGGER_NEXT_EFFECT()
        ENDIF
    ENDIF

    // 2. Skip to Next Effect Immediately (Hold RB + D-Pad Right)
    IF dpadRightPressed
        g_chaos_active = TRUE
        CHAOS_TRIGGER_NEXT_EFFECT()
    ENDIF
ENDPROC

// -------------------------------------------------------------------------
// HUD DRAWING: Sleek Top-Center Countdown Progress Bar & Active Effect
// -------------------------------------------------------------------------
PROC CHAOS_DRAW_HUD()
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT remainingMs = g_chaos_remaining_ms
    FLOAT pct = 0.0
    FLOAT barW = 0.0
    FLOAT barX = 0.0
    INT secRemaining = 0
    INT barR = 0
    INT barG = 220
    INT barB = 255
    TEXT_LABEL_63 statusText

    // Do not draw if game is in a cutscene, loading, or player is dead
    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed) OR IS_CUTSCENE_PLAYING() OR IS_SCREEN_FADED_OUT()
        EXIT
    ENDIF

    // 1. Outer Frame / Drop Shadow (matches RageMenu dark backdrop tone)
    DRAW_RECT(0.500, 0.038, 0.304, 0.032, 8, 9, 12, 225)
    // 2. Inner Track Background (matches RageMenu row background tone)
    DRAW_RECT(0.500, 0.038, 0.298, 0.026, 20, 22, 26, 238)

    IF g_chaos_active
        IF remainingMs < 0 remainingMs = 0 ENDIF
        secRemaining = remainingMs / 1000

        pct = CHAOS_CLAMP(TO_FLOAT(remainingMs) / TO_FLOAT(g_chaos_timer_duration), 0.0, 1.0)
        barW = 0.294 * pct
        // Left-align filled progress bar inside the track
        barX = (0.500 - 0.147) + (barW * 0.5)

        // Color shifts to warning red when under 5s
        IF secRemaining <= 5
            barR = 255
            barG = 50
            barB = 20
        ELSE
            barR = g_chaos_color_r
            barG = g_chaos_color_g
            barB = g_chaos_color_b
        ENDIF

        IF barW > 0.001
            DRAW_RECT(barX, 0.038, barW, 0.022, barR, barG, barB, 230)
        ENDIF

        // Active Effect Title (Centered inside the bar)
        SET_TEXT_FONT(FONT_STANDARD)
        SET_TEXT_SCALE(0.290, 0.290)
        SET_TEXT_COLOUR(255, 255, 255, 255)
        SET_TEXT_WRAP(0.0, 1.0)
        SET_TEXT_CENTRE(TRUE)
        SET_TEXT_DROPSHADOW(1, 0, 0, 0, 220)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_chaos_effect_name)
        END_TEXT_COMMAND_DISPLAY_TEXT(0.500, 0.024)
        SET_TEXT_CENTRE(FALSE)

        // Subtitle Status / Shortcut (Below bar)
        SET_TEXT_FONT(FONT_STANDARD)
        SET_TEXT_SCALE(0.245, 0.245)
        SET_TEXT_COLOUR(220, 230, 255, 240)
        SET_TEXT_WRAP(0.0, 1.0)
        SET_TEXT_CENTRE(TRUE)
        SET_TEXT_DROPSHADOW(1, 0, 0, 0, 200)
        SET_TEXT_OUTLINE()
        statusText = "Next: "
        statusText += secRemaining
        statusText += "s  |  RB + DPad-Left [Pause]  |  RB + DPad-Right [Skip]"
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(statusText)
        END_TEXT_COMMAND_DISPLAY_TEXT(0.500, 0.056)
        SET_TEXT_CENTRE(FALSE)
    ELSE
        // Paused Bar Display
        DRAW_RECT(0.500, 0.038, 0.294, 0.022, 110, 85, 0, 200)

        SET_TEXT_FONT(FONT_STANDARD)
        SET_TEXT_SCALE(0.290, 0.290)
        SET_TEXT_COLOUR(255, 220, 0, 255)
        SET_TEXT_WRAP(0.0, 1.0)
        SET_TEXT_CENTRE(TRUE)
        SET_TEXT_DROPSHADOW(1, 0, 0, 0, 220)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~y~CHAOS MOD PAUSED~s~")
        END_TEXT_COMMAND_DISPLAY_TEXT(0.500, 0.024)
        SET_TEXT_CENTRE(FALSE)

        SET_TEXT_FONT(FONT_STANDARD)
        SET_TEXT_SCALE(0.245, 0.245)
        SET_TEXT_COLOUR(255, 255, 255, 240)
        SET_TEXT_WRAP(0.0, 1.0)
        SET_TEXT_CENTRE(TRUE)
        SET_TEXT_DROPSHADOW(1, 0, 0, 0, 200)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Hold RB + DPad-Left to Resume  |  RB + DPad-Right to Skip")
        END_TEXT_COMMAND_DISPLAY_TEXT(0.500, 0.056)
        SET_TEXT_CENTRE(FALSE)
    ENDIF
ENDPROC

// -------------------------------------------------------------------------
// SCRIPT ENTRY POINT
// -------------------------------------------------------------------------
SCRIPT
    INT now = 0
    INT rawDelta = 0
    INT realDelta = 0

    // Ensure game world and player ped exist before initializing
    WHILE NOT DOES_ENTITY_EXIST(PLAYER_PED_ID())
        WAIT(100)
    ENDWHILE

    // Wait an additional 500ms for stable game frame
    WAIT(500)

    // Startup Announcements
    CHAOS_SHOW_TICKER("~r~Chaos Mod V-NX ~s~Active!~n~Random effects every 15-30s.~n~Hold ~y~RB + DPad-Left~s~ to Pause, ~y~RB + DPad-Right~s~ to Skip.")
    CHAOS_PLAY_SOUND("CHALLENGE_UNLOCKED", "HUD_AWARDS")

    // Seed initial timer with random duration between 15s and 30s
    g_chaos_timer_duration = GET_RANDOM_INT_IN_RANGE(15000, 30000)
    g_chaos_remaining_ms = g_chaos_timer_duration
    g_chaos_last_tick = GET_GAME_TIMER()
    g_chaos_current_timescale = 1.0
    g_chaos_effect_name = "Chaos Initialized - Get Ready!"
    g_chaos_active = TRUE

    WHILE TRUE
        WAIT(0)

        IF DOES_ENTITY_EXIST(PLAYER_PED_ID()) AND IS_ENTITY_DEAD(PLAYER_PED_ID())
            IF g_chaos_current_effect != -1
                CHAOS_CLEANUP_ACTIVE_EFFECT()
                g_chaos_current_effect = -1
            ENDIF
        ENDIF

        // 1. Process Controller Inputs
        CHAOS_PROCESS_CONTROLS()

        // 2. Active Chaos Loop
        IF g_chaos_active
            CHAOS_PROCESS_FRAME_EFFECTS()

            // Advance countdown using timescale-compensated delta so slow-motion
            // (SuperHot aim or Matrix Slow Motion) never slows down the ChaosMod timer.
            now = GET_GAME_TIMER()
            rawDelta = now - g_chaos_last_tick
            g_chaos_last_tick = now
            IF rawDelta < 0
                rawDelta = 0
            ENDIF
            IF rawDelta > 250
                rawDelta = 250
            ENDIF
            realDelta = rawDelta
            IF g_chaos_current_timescale > 0.05 AND g_chaos_current_timescale < 0.99
                realDelta = ROUND(TO_FLOAT(rawDelta) / g_chaos_current_timescale)
                IF realDelta < 16
                    realDelta = 16
                ENDIF
            ENDIF
            g_chaos_remaining_ms = g_chaos_remaining_ms - realDelta
            IF g_chaos_remaining_ms < 0
                g_chaos_remaining_ms = 0
            ENDIF

            // 3s, 2s, 1s audio warning chimes
            IF g_chaos_remaining_ms <= 3000 AND g_chaos_remaining_ms > 2000 AND NOT g_chaos_chime_3s
                CHAOS_PLAY_SOUND("5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET")
                g_chaos_chime_3s = TRUE
            ELIF g_chaos_remaining_ms <= 2000 AND g_chaos_remaining_ms > 1000 AND NOT g_chaos_chime_2s
                CHAOS_PLAY_SOUND("5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET")
                g_chaos_chime_2s = TRUE
            ELIF g_chaos_remaining_ms <= 1000 AND g_chaos_remaining_ms > 0 AND NOT g_chaos_chime_1s
                CHAOS_PLAY_SOUND("5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET")
                g_chaos_chime_1s = TRUE
            ENDIF

            // Timer expired -> Trigger next chaos effect!
            IF g_chaos_remaining_ms <= 0
                CHAOS_TRIGGER_NEXT_EFFECT()
            ENDIF
        ELSE
            g_chaos_last_tick = GET_GAME_TIMER()
        ENDIF

        // 3. Render Top-Center Chaos HUD
        CHAOS_DRAW_HUD()
    ENDWHILE
ENDSCRIPT

