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
USING "commands_task.sch"
USING "commands_stats.sch"
USING "stats_enums.sch"

BOOL g_open = FALSE
BOOL g_home = TRUE
INT g_tab = 0
INT g_item = 0
INT g_scroll = 0
INT g_home_item = 0
INT g_home_scroll = 0
INT g_page_item[9]
INT g_page_scroll[9]
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
BOOL g_explosive_ammo = FALSE
BOOL g_fire_ammo = FALSE
BOOL g_explosive_melee = FALSE
INT g_attacker_model_choice = 0
INT g_attacker_weapon_choice = 0
BOOL g_attacker_spawn_pending = FALSE
MODEL_NAMES g_pending_attacker_model = PLAYER_ZERO
WEAPON_TYPE g_pending_attacker_weapon = WEAPONTYPE_PISTOL
INT g_attacker_request_time = 0
BOOL g_never_wanted = FALSE
BOOL g_ignore_police = FALSE
BOOL g_vehicle_god = FALSE
BOOL g_seatbelt = FALSE
BOOL g_doors_locked = FALSE
BOOL g_mobile_radio = FALSE
BOOL g_was_in_vehicle = FALSE
BOOL g_player_in_vehicle = FALSE
BOOL g_dispatch = TRUE
BOOL g_civilian_reports = TRUE
BOOL g_night_vision = FALSE
BOOL g_thermal_vision = FALSE
BOOL g_motion_blur = FALSE
BOOL g_camera_shake = FALSE
BOOL g_vehicle_auto_repair = FALSE
BOOL g_vehicle_turbo = FALSE
INT g_vehicle_acceleration_level = 0
INT g_vehicle_top_speed_level = 0
BOOL g_vehicle_cornering = FALSE
BOOL g_vehicle_bulletproof_tyres = FALSE
BOOL g_vehicle_speedometer = FALSE
INT g_vehicle_speed_unit = 0
BOOL g_lsc_open = FALSE
INT g_lsc_slot_choice = 0
INT g_lsc_mod_choice = -1
INT g_lsc_primary_colour = 0
INT g_lsc_secondary_colour = 0
INT g_lsc_wheel_type = 0
BOOL g_lsc_turbo = FALSE
BOOL g_lsc_xenon = FALSE
BOOL g_lsc_neon = FALSE
INT g_vehicle_spawn_choice = 0
BOOL g_vehicle_spawn_pending = FALSE
BOOL g_delete_previous_spawned_vehicle = TRUE
VEHICLE_INDEX g_last_spawned_vehicle
VEHICLE_INDEX g_spawned_custom_vehicles[500]
INT g_spawned_custom_vehicle_count = 0
MODEL_NAMES g_pending_vehicle_model = ADDER
INT g_vehicle_spawn_request_time = 0
BOOL g_spawner_open = FALSE
INT g_spawner_item = 0
INT g_spawner_scroll = 0
INT g_spawn_count = 1
BOOL g_spawn_maxed = FALSE
INT g_spawn_alignment = 0
INT g_spawn_facing = 0
INT g_spawn_remaining = 0
INT g_spawn_index = 0
FLOAT g_spawn_heading = 0.0
BOOL g_keyboard_active = FALSE
INT g_keyboard_target = 0
INT g_cash_amount = 0
BOOL g_everyone_ignores = FALSE
BOOL g_low_population = FALSE
BOOL g_hud_hidden = FALSE
BOOL g_radar_hidden = FALSE
BOOL g_first_person = FALSE
BOOL g_npc_brawl = FALSE
INT g_next_npc_brawl_update = 0
PED_INDEX g_brawl_peds[32]
INT g_brawl_ped_count = 0
BOOL g_respawn_at_death = FALSE
BOOL g_respawn_pending = FALSE
INT g_respawn_ready_ticks = 0
VECTOR g_last_living_position = <<0.0, 0.0, 0.0>>
INT g_respawn_location_choice = 4
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

CONST_FLOAT MENU_W 0.280
CONST_FLOAT MENU_TOP 0.150
CONST_FLOAT ROW_H 0.038

PROC MENU_TEXT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y + g_menu_y)
ENDPROC

PROC MENU_TEXT_RIGHT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, x)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_TAB(FLOAT x, STRING label, BOOL selected)
    IF selected
        DRAW_RECT(x, 0.204 + g_menu_y, 0.060, 0.034, g_accent_r, g_accent_g, g_accent_b, 255)
        MENU_TEXT(x - 0.025, 0.194, 0.205, 255, 255, 255, label)
    ELSE
        DRAW_RECT(x, 0.204 + g_menu_y, 0.060, 0.034, 28, 30, 34, 245)
        MENU_TEXT(x - 0.025, 0.194, 0.205, 190, 198, 210, label)
    ENDIF
ENDPROC

PROC DRAW_OPTION(FLOAT y, STRING label, STRING value, BOOL selected, INT state)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        IF state = 0
            rr = 162
            gg = 50
            bb = 55
        ELIF state = 1
            rr = 27
            gg = 142
            bb = 82
        ELSE
            rr = g_accent_r
            gg = g_accent_g
            bb = g_accent_b
        ENDIF
    ENDIF
    DRAW_RECT(g_menu_x, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    IF state = 0
        MENU_TEXT_RIGHT(g_menu_x + 0.098, y - 0.012, 0.290, 255, 100, 100, value)
    ELIF state = 1
        MENU_TEXT_RIGHT(g_menu_x + 0.098, y - 0.012, 0.290, 95, 245, 150, value)
    ELSE
        MENU_TEXT_RIGHT(g_menu_x + 0.098, y - 0.012, 0.290, 210, 230, 255, value)
    ENDIF
ENDPROC

PROC DRAW_NUMBER_OPTION(FLOAT y, STRING label, INT value, BOOL selected)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        rr = g_accent_r
        gg = g_accent_g
        bb = g_accent_b
    ENDIF
    DRAW_RECT(g_menu_x, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    DISPLAY_TEXT_WITH_NUMBER(g_menu_x + 0.098, y - 0.012 + g_menu_y, "~1~", value)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_SPEEDOMETER()
    IF NOT g_vehicle_speedometer
        EXIT
    ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) OR IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() OR IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN()
        EXIT
    ENDIF

    SET_TEXT_RENDER_ID(1)
    SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(TRUE)
    SET_SCRIPT_GFX_DRAW_ORDER(GFX_ORDER_BEFORE_HUD_PRIORITY_LOW)

    FLOAT vehicleSpeed = GET_ENTITY_SPEED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF g_vehicle_speed_unit = 0
        vehicleSpeed = vehicleSpeed * 2.23694
        SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
        SET_TEXT_SCALE(0.9, 0.9)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MPH")
            END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.720)
    ELSE
        vehicleSpeed = vehicleSpeed * 3.6
        SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
        SET_TEXT_SCALE(0.9, 0.9)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("KMPH")
            END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.720)
    ENDIF

    SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
    SET_TEXT_SCALE(0.9, 0.9)
    SET_TEXT_OUTLINE()
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("NUMBER")
        ADD_TEXT_COMPONENT_INTEGER(ROUND(vehicleSpeed))
    END_TEXT_COMMAND_DISPLAY_TEXT(0.908, 0.760)
ENDPROC

PROC DRAW_ATTACKER_MODEL(FLOAT y, BOOL selected)
    SWITCH g_attacker_model_choice
        CASE 0 DRAW_OPTION(y, "Attacker Model:", "< Michael >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Attacker Model:", "< Franklin >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Attacker Model:", "< Trevor >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Attacker Model:", "< Random >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_ATTACKER_WEAPON(FLOAT y, BOOL selected)
    SWITCH g_attacker_weapon_choice
        CASE 0 DRAW_OPTION(y, "Attacker Weapon:", "< Pistol >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Attacker Weapon:", "< SMG >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Attacker Weapon:", "< Rifle >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Attacker Weapon:", "< Shotgun >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_ATTACKER_SPAWN()
    SWITCH g_attacker_model_choice
        CASE 0 g_pending_attacker_model = PLAYER_ZERO BREAK
        CASE 1 g_pending_attacker_model = PLAYER_ONE BREAK
        CASE 2 g_pending_attacker_model = PLAYER_TWO BREAK
        CASE 3
            SWITCH GET_RANDOM_INT_IN_RANGE(0, 3)
                CASE 0 g_pending_attacker_model = PLAYER_ZERO BREAK
                CASE 1 g_pending_attacker_model = PLAYER_ONE BREAK
                CASE 2 g_pending_attacker_model = PLAYER_TWO BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    SWITCH g_attacker_weapon_choice
        CASE 0 g_pending_attacker_weapon = WEAPONTYPE_PISTOL BREAK
        CASE 1 g_pending_attacker_weapon = WEAPONTYPE_SMG BREAK
        CASE 2 g_pending_attacker_weapon = WEAPONTYPE_ASSAULTRIFLE BREAK
        CASE 3 g_pending_attacker_weapon = WEAPONTYPE_PUMPSHOTGUN BREAK
    ENDSWITCH
    REQUEST_MODEL(g_pending_attacker_model)
    g_attacker_spawn_pending = TRUE
    g_attacker_request_time = GET_GAME_TIMER()
ENDPROC

PROC FINISH_ATTACKER_SPAWN()
    PED_INDEX attacker
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.0>>)
    attacker = CREATE_PED(PEDTYPE_CIVMALE, g_pending_attacker_model, spawnPosition, GET_ENTITY_HEADING(PLAYER_PED_ID()), TRUE, FALSE)
    IF DOES_ENTITY_EXIST(attacker)
        GIVE_WEAPON_TO_PED(attacker, g_pending_attacker_weapon, 9999, TRUE, TRUE)
        SET_PED_AS_ENEMY(attacker, TRUE)
        SET_PED_RELATIONSHIP_GROUP_HASH(attacker, RELGROUPHASH_HATES_PLAYER)
        SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_PLAYER)
        SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_PLAYER, RELGROUPHASH_HATES_PLAYER)
        SET_PED_FLEE_ATTRIBUTES(attacker, FA_NEVER_FLEE, TRUE)
        SET_PED_COMBAT_ABILITY(attacker, CAL_PROFESSIONAL)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(attacker, TRUE)
        TASK_COMBAT_PED(attacker, PLAYER_PED_ID())
        SET_PED_KEEP_TASK(attacker, TRUE)
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
    g_attacker_spawn_pending = FALSE
ENDPROC

FUNC INT LSC_SLOT()
    SWITCH g_lsc_slot_choice
        CASE 0 RETURN ENUM_TO_INT(MOD_SPOILER) BREAK
        CASE 1 RETURN ENUM_TO_INT(MOD_BUMPER_F) BREAK
        CASE 2 RETURN ENUM_TO_INT(MOD_BUMPER_R) BREAK
        CASE 3 RETURN ENUM_TO_INT(MOD_SKIRT) BREAK
        CASE 4 RETURN ENUM_TO_INT(MOD_EXHAUST) BREAK
        CASE 5 RETURN ENUM_TO_INT(MOD_CHASSIS) BREAK
        CASE 6 RETURN ENUM_TO_INT(MOD_GRILL) BREAK
        CASE 7 RETURN ENUM_TO_INT(MOD_BONNET) BREAK
        CASE 8 RETURN ENUM_TO_INT(MOD_ROOF) BREAK
        CASE 9 RETURN ENUM_TO_INT(MOD_ENGINE) BREAK
        CASE 10 RETURN ENUM_TO_INT(MOD_BRAKES) BREAK
        CASE 11 RETURN ENUM_TO_INT(MOD_GEARBOX) BREAK
        CASE 12 RETURN ENUM_TO_INT(MOD_HORN) BREAK
        CASE 13 RETURN ENUM_TO_INT(MOD_SUSPENSION) BREAK
        CASE 14 RETURN ENUM_TO_INT(MOD_ARMOUR) BREAK
        CASE 15 RETURN ENUM_TO_INT(MOD_WHEELS) BREAK
        CASE 16 RETURN ENUM_TO_INT(MOD_PLTHOLDER) BREAK
        CASE 17 RETURN ENUM_TO_INT(MOD_PLTVANITY) BREAK
        CASE 18 RETURN ENUM_TO_INT(MOD_INTERIOR1) BREAK
        CASE 19 RETURN ENUM_TO_INT(MOD_INTERIOR2) BREAK
        CASE 20 RETURN ENUM_TO_INT(MOD_INTERIOR3) BREAK
        CASE 21 RETURN ENUM_TO_INT(MOD_INTERIOR4) BREAK
        CASE 22 RETURN ENUM_TO_INT(MOD_INTERIOR5) BREAK
        CASE 23 RETURN ENUM_TO_INT(MOD_SEATS) BREAK
        CASE 24 RETURN ENUM_TO_INT(MOD_STEERING) BREAK
        CASE 25 RETURN ENUM_TO_INT(MOD_LIVERY) BREAK
    ENDSWITCH
    RETURN ENUM_TO_INT(MOD_SPOILER)
ENDFUNC

PROC APPLY_LSC_MOD()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available > 0
        g_lsc_mod_choice = g_lsc_mod_choice + 1
        IF g_lsc_mod_choice >= available g_lsc_mod_choice = -1 ENDIF
        IF g_lsc_mod_choice < 0
            REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
        ELSE
            SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()), g_lsc_mod_choice)
        ENDIF
    ENDIF
ENDPROC

PROC APPLY_LSC_MAX_TO_VEHICLE(VEHICLE_INDEX vehicle)
    INT slot = 0
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    WHILE slot <= ENUM_TO_INT(MOD_LIVERY)
        INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
        IF available > 0 SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), available - 1) ENDIF
        slot = slot + 1
    ENDWHILE
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TURBO, TRUE)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_XENON_LIGHTS, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, TRUE)
    g_lsc_turbo = TRUE
    g_lsc_xenon = TRUE
    g_lsc_neon = TRUE
ENDPROC

PROC APPLY_LSC_MAX()
    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDPROC

PROC DRAW_LSC_SLOT_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_lsc_slot_choice
        CASE 0 DRAW_OPTION(y, "Mod Slot:", "< Spoiler >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Mod Slot:", "< Front bumper >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Mod Slot:", "< Rear bumper >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Mod Slot:", "< Side skirts >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Mod Slot:", "< Exhaust >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Mod Slot:", "< Chassis >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Mod Slot:", "< Grille >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Mod Slot:", "< Hood >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Mod Slot:", "< Roof >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Mod Slot:", "< Engine >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Mod Slot:", "< Brakes >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Mod Slot:", "< Transmission >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Mod Slot:", "< Horn >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Mod Slot:", "< Suspension >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Mod Slot:", "< Armor >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Mod Slot:", "< Wheels >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Mod Slot:", "< Plate Holder >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, "Mod Slot:", "< Vanity Plate >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, "Mod Slot:", "< Interior 1 >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Mod Slot:", "< Interior 2 >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Mod Slot:", "< Interior 3 >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "Mod Slot:", "< Interior 4 >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Mod Slot:", "< Interior 5 >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, "Mod Slot:", "< Seats >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, "Mod Slot:", "< Steering Wheel >", selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, "Mod Slot:", "< Livery >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_SCROLL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 10
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        SWITCH index
            CASE 0 DRAW_OPTION(y, "Max All Available Mods", "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_OPTION(y, "Apply Mod Slot", "APPLY", g_item = index, 2) BREAK
            CASE 3 DRAW_OPTION(y, "Primary Colour", "< cycle palette >", g_item = index, 3) BREAK
            CASE 4 DRAW_OPTION(y, "Secondary Colour", "< cycle palette >", g_item = index, 3) BREAK
            CASE 5 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 6 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon lights", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 7 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon kit", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 8 DRAW_OPTION(y, "Wheel Type", "< cycle >", g_item = index, 3) BREAK
            CASE 9 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
        ENDSWITCH
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_LSC_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "LS CUSTOMS")
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Vehicle Upgrades", "NO VEHICLE", g_item = 0, 0)
    ELSE
        DRAW_LSC_SCROLL_ROWS()
    ENDIF
ENDPROC

FUNC INT ITEM_COUNT()
    IF g_tab = 3 AND g_spawner_open RETURN 8 ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN 1 ENDIF
        RETURN 10
    ENDIF
    SWITCH g_tab
        CASE 0 RETURN 14 BREAK
        CASE 1 RETURN 6 BREAK
        CASE 2 RETURN 6 BREAK
        CASE 3 RETURN 16 BREAK
        CASE 4 RETURN 6 BREAK
        CASE 5 RETURN 3 BREAK
        CASE 6 RETURN 15 BREAK
        CASE 7 RETURN 8 BREAK
        CASE 8 RETURN 5 BREAK
    ENDSWITCH
    RETURN 1
ENDFUNC

FUNC INT ACTIVE_ITEM_COUNT()
    IF g_home RETURN 9 ENDIF
    RETURN ITEM_COUNT()
ENDFUNC

PROC UPDATE_SCROLL()
    INT maxScroll = ACTIVE_ITEM_COUNT() - 8
    IF maxScroll < 0 maxScroll = 0 ENDIF
    IF g_item >= ACTIVE_ITEM_COUNT() g_item = ACTIVE_ITEM_COUNT() - 1 ENDIF
    IF g_item < g_scroll g_scroll = g_item ENDIF
    IF g_item > g_scroll + 7 g_scroll = g_item - 7 ENDIF
    IF g_scroll > maxScroll g_scroll = maxScroll ENDIF
ENDPROC

PROC SAVE_NAVIGATION_STATE()
    IF g_home
        g_home_item = g_item
        g_home_scroll = g_scroll
    ELIF g_spawner_open
        g_spawner_item = g_item
        g_spawner_scroll = g_scroll
    ELIF g_lsc_open
        g_lsc_item = g_item
        g_lsc_scroll = g_scroll
    ELSE
        g_page_item[g_tab] = g_item
        g_page_scroll[g_tab] = g_scroll
    ENDIF
ENDPROC

PROC DRAW_SCROLLBAR()
    INT total = ACTIVE_ITEM_COUNT()
    INT maxScroll = total - 8
    IF maxScroll > 0
        FLOAT trackHeight = 0.276
        FLOAT thumbHeight = trackHeight * (8.0 / TO_FLOAT(total))
        FLOAT travel = trackHeight - thumbHeight
        FLOAT offset = travel * (TO_FLOAT(g_scroll) / TO_FLOAT(maxScroll))
        DRAW_RECT(g_menu_x + 0.126, 0.401 + g_menu_y, 0.004, trackHeight, 40, 43, 48, 235)
        DRAW_RECT(g_menu_x + 0.126, 0.401 - (trackHeight * 0.5) + (thumbHeight * 0.5) + offset + g_menu_y, 0.006, thumbHeight, 188, 198, 212, 245)
    ENDIF
ENDPROC

PROC DRAW_HOME()
    INT titleR = 255
    INT titleG = 255
    INT titleB = 255
    IF g_accent_choice = 10
        titleR = 35
        titleG = 45
        titleB = 65
    ENDIF
    DRAW_RECT(g_menu_x, 0.413 + g_menu_y, MENU_W, 0.525, 8, 9, 12, 220)
    DRAW_RECT(g_menu_x, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    DRAW_RECT(g_menu_x, 0.640 + g_menu_y, MENU_W - 0.012, 0.060, 0, 0, 0, 180)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.060, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.057, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CATEGORIES")
    IF g_scroll = 0
        DRAW_OPTION(0.268, "Player Settings", ">>>", g_item = 0, 2)
        DRAW_OPTION(0.306, "Weapon Options", ">>>", g_item = 1, 2)
        DRAW_OPTION(0.344, "Wanted Level", ">>>", g_item = 2, 2)
        DRAW_OPTION(0.382, "Vehicle Settings", ">>>", g_item = 3, 2)
        DRAW_OPTION(0.420, "World and Weather", ">>>", g_item = 4, 2)
        DRAW_OPTION(0.458, "Portable Radio", ">>>", g_item = 5, 2)
        DRAW_OPTION(0.496, "Teleport Options", ">>>", g_item = 6, 2)
        DRAW_OPTION(0.534, "Misc Options", ">>>", g_item = 7, 2)
    ELSE
        DRAW_OPTION(0.268, "Weapon Options", ">>>", g_item = 1, 2)
        DRAW_OPTION(0.306, "Wanted Level", ">>>", g_item = 2, 2)
        DRAW_OPTION(0.344, "Vehicle Settings", ">>>", g_item = 3, 2)
        DRAW_OPTION(0.382, "World and Weather", ">>>", g_item = 4, 2)
        DRAW_OPTION(0.420, "Portable Radio", ">>>", g_item = 5, 2)
        DRAW_OPTION(0.458, "Teleport Options", ">>>", g_item = 6, 2)
        DRAW_OPTION(0.496, "Misc Options", ">>>", g_item = 7, 2)
        DRAW_OPTION(0.534, "Menu Settings", ">>>", g_item = 8, 2)
    ENDIF
    DRAW_SCROLLBAR()
    MENU_TEXT(g_menu_x - 0.130, 0.617, 0.250, 190, 198, 210, "DPAD: select")
    MENU_TEXT(g_menu_x - 0.130, 0.641, 0.250, 190, 198, 210, "A: apply   B: back")
ENDPROC

PROC APPLY_TIME_CHOICE()
    SWITCH g_time_choice
        CASE 0 SET_CLOCK_TIME(6, 0, 0) BREAK
        CASE 1 SET_CLOCK_TIME(12, 0, 0) BREAK
        CASE 2 SET_CLOCK_TIME(18, 0, 0) BREAK
        CASE 3 SET_CLOCK_TIME(0, 0, 0) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_WEATHER_CHOICE()
    SWITCH g_weather_choice
        CASE 0 SET_WEATHER_TYPE_NOW_PERSIST("EXTRASUNNY") BREAK
        CASE 1 SET_WEATHER_TYPE_NOW_PERSIST("CLEAR") BREAK
        CASE 2 SET_WEATHER_TYPE_NOW_PERSIST("CLOUDS") BREAK
        CASE 3 SET_WEATHER_TYPE_NOW_PERSIST("OVERCAST") BREAK
        CASE 4 SET_WEATHER_TYPE_NOW_PERSIST("RAIN") BREAK
        CASE 5 SET_WEATHER_TYPE_NOW_PERSIST("THUNDER") BREAK
    ENDSWITCH
ENDPROC

PROC DISABLE_PORTABLE_RADIO()
    g_mobile_radio = FALSE
    SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(FALSE)
    SET_MOBILE_PHONE_RADIO_STATE(FALSE)
    SET_USER_RADIO_CONTROL_ENABLED(FALSE)
ENDPROC

PROC OPEN_MENU_KEYBOARD(INT target)
    g_keyboard_target = target
    g_keyboard_active = TRUE
    DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "ENTER VALUE", "NUMBERS ONLY", "", "", "", "", 10)
ENDPROC

PROC PROCESS_MENU_KEYBOARD()
    OSK_STATUS status = UPDATE_ONSCREEN_KEYBOARD()
    IF status = OSK_SUCCESS
        INT parsed = 0
        STRING result = GET_ONSCREEN_KEYBOARD_RESULT()
        IF STRING_TO_INT(result, parsed)
            IF parsed < 0 parsed = 0 ENDIF
            IF g_keyboard_target = 1
                IF parsed < 1 parsed = 1 ENDIF
                IF parsed > 500 parsed = 500 ENDIF
                g_spawn_count = parsed
            ELIF g_keyboard_target = 2
                g_cash_amount = parsed
            ENDIF
        ENDIF
        g_keyboard_active = FALSE
    ELIF status = OSK_CANCELLED OR status = OSK_FAILED OR status = OSK_INVALID
        g_keyboard_active = FALSE
    ENDIF
ENDPROC

PROC DELETE_ALL_CUSTOM_CARS()
    INT index = 0
    REPEAT g_spawned_custom_vehicle_count index
        IF DOES_ENTITY_EXIST(g_spawned_custom_vehicles[index])
            SET_ENTITY_AS_MISSION_ENTITY(g_spawned_custom_vehicles[index], TRUE, TRUE)
            DELETE_VEHICLE(g_spawned_custom_vehicles[index])
        ENDIF
    ENDREPEAT
    g_spawned_custom_vehicle_count = 0
ENDPROC

PROC DELETE_PREVIOUS_CUSTOM_CAR()
    IF DOES_ENTITY_EXIST(g_last_spawned_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_last_spawned_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_last_spawned_vehicle)
    ENDIF
ENDPROC

PROC REFILL_OWNED_WEAPON(PED_INDEX ped, WEAPON_TYPE weapon)
    INT maxAmmo = 0
    IF HAS_PED_GOT_WEAPON(ped, weapon)
        IF GET_MAX_AMMO(ped, weapon, maxAmmo)
            SET_PED_AMMO(ped, weapon, maxAmmo)
        ENDIF
    ENDIF
ENDPROC

PROC REFILL_ALL_OWNED_WEAPONS(PED_INDEX ped)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_COMBATPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_APPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MICROSMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ASSAULTRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_CARBINERIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ADVANCEDRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_COMBATMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PUMPSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SAWNOFFSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ASSAULTSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SNIPERRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_HEAVYSNIPER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADELAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADELAUNCHER_SMOKE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_RPG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MINIGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SMOKEGRENADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_BZGAS)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_STICKYBOMB)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MOLOTOV)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_FLARE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_STUNGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_FIREEXTINGUISHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PETROLCAN)
ENDPROC

PROC MENU_CAPTURE_INPUT()

    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_UP)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT)


    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_UP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_LEFT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT, TRUE)


    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_JUMP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_SPECIAL, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_HANDBRAKE, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_CIN_CAM, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_HEADLIGHT, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_PUSHBIKE_PEDAL, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_FLY_THROTTLE_UP, TRUE)
ENDPROC

PROC STOP_NPC_BRAWL()
    INT index = 0
    REPEAT g_brawl_ped_count index
        IF DOES_ENTITY_EXIST(g_brawl_peds[index])
            CLEAR_PED_TASKS(g_brawl_peds[index])
            SET_PED_KEEP_TASK(g_brawl_peds[index], FALSE)
            SET_PED_AS_ENEMY(g_brawl_peds[index], FALSE)
            SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[index], FALSE)
        ENDIF
    ENDREPEAT
    g_brawl_ped_count = 0
ENDPROC

FUNC BOOL IS_TRACKED_BRAWLER(PED_INDEX ped)
    INT index = 0
    REPEAT g_brawl_ped_count index
        IF g_brawl_peds[index] = ped RETURN TRUE ENDIF
    ENDREPEAT
    RETURN FALSE
ENDFUNC


PROC TASK_NEARBY_NPCS_TO_BRAWL()
    PED_INDEX nearbyPeds[32]
    INT index = 0
    INT pair = 0
    INT nearbyCount = GET_PED_NEARBY_PEDS(PLAYER_PED_ID(), nearbyPeds, PEDTYPE_INVALID)
    IF nearbyCount > COUNT_OF(nearbyPeds) nearbyCount = COUNT_OF(nearbyPeds) ENDIF
    STOP_NPC_BRAWL()
    REPEAT nearbyCount index
        IF nearbyPeds[index] != PLAYER_PED_ID()
        AND DOES_ENTITY_EXIST(nearbyPeds[index])
        AND NOT IS_PED_INJURED(nearbyPeds[index])
        AND NOT IS_PED_IN_ANY_VEHICLE(nearbyPeds[index])
        AND NOT IS_PED_A_PLAYER(nearbyPeds[index])
            IF g_brawl_ped_count < COUNT_OF(g_brawl_peds)
                g_brawl_peds[g_brawl_ped_count] = nearbyPeds[index]
                g_brawl_ped_count = g_brawl_ped_count + 1
            ENDIF
        ENDIF
    ENDREPEAT

    IF g_brawl_ped_count > 16 g_brawl_ped_count = 16 ENDIF
    pair = 0
    WHILE pair + 1 < g_brawl_ped_count
        SET_PED_AS_ENEMY(g_brawl_peds[pair], TRUE)
        SET_PED_AS_ENEMY(g_brawl_peds[pair + 1], TRUE)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[pair], TRUE)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[pair + 1], TRUE)
        TASK_COMBAT_PED(g_brawl_peds[pair], g_brawl_peds[pair + 1])
        TASK_COMBAT_PED(g_brawl_peds[pair + 1], g_brawl_peds[pair])
        SET_PED_KEEP_TASK(g_brawl_peds[pair], TRUE)
        SET_PED_KEEP_TASK(g_brawl_peds[pair + 1], TRUE)
        pair = pair + 2
    ENDWHILE
ENDPROC

PROC APPLY_ACCENT_CHOICE()
    SWITCH g_accent_choice
        CASE 0 g_accent_r = 31 g_accent_g = 100 g_accent_b = 190 BREAK
        CASE 1 g_accent_r = 185 g_accent_g = 35 g_accent_b = 48 BREAK
        CASE 2 g_accent_r = 205 g_accent_g = 145 g_accent_b = 28 BREAK
        CASE 3 g_accent_r = 125 g_accent_g = 62 g_accent_b = 188 BREAK
        CASE 4 g_accent_r = 20 g_accent_g = 150 g_accent_b = 105 BREAK
        CASE 5 g_accent_r = 0 g_accent_g = 170 g_accent_b = 210 BREAK
        CASE 6 g_accent_r = 235 g_accent_g = 110 g_accent_b = 25 BREAK
        CASE 7 g_accent_r = 220 g_accent_g = 55 g_accent_b = 130 BREAK
        CASE 8 g_accent_r = 85 g_accent_g = 95 g_accent_b = 115 BREAK
        CASE 9 g_accent_r = 155 g_accent_g = 205 g_accent_b = 35 BREAK
        CASE 10 g_accent_r = 230 g_accent_g = 230 g_accent_b = 235 BREAK
        CASE 11 g_accent_r = 210 g_accent_g = 75 g_accent_b = 25 BREAK
        CASE 12 g_accent_r = 55 g_accent_g = 55 g_accent_b = 55 BREAK
        CASE 13 g_accent_r = 35 g_accent_g = 135 g_accent_b = 215 BREAK
    ENDSWITCH
ENDPROC

FUNC BOOL IS_SELECTOR_ACTIVE()
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1 OR g_item = 2 OR g_item = 4 OR g_item = 5 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0
        IF g_item = 11 OR g_item = 12 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 4
        IF g_item = 0 OR g_item = 1 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 3 AND g_item = 15 AND NOT g_lsc_open RETURN TRUE ENDIF
    IF g_tab = 3 AND NOT g_lsc_open AND (g_item = 7 OR g_item = 8) RETURN TRUE ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF g_item = 1 OR g_item = 3 OR g_item = 4 OR g_item = 8 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 8
        IF g_item = 0 OR g_item = 1 OR g_item = 3 OR g_item = 4 RETURN TRUE ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

PROC ADJUST_SELECTOR(INT direction)
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1
            g_vehicle_spawn_choice = g_vehicle_spawn_choice + direction
            IF g_vehicle_spawn_choice < 0 g_vehicle_spawn_choice = 25 ENDIF
            IF g_vehicle_spawn_choice > 25 g_vehicle_spawn_choice = 0 ENDIF
        ELIF g_item = 2
            g_spawn_count = g_spawn_count + direction
            IF g_spawn_count < 1 g_spawn_count = 500 ENDIF
            IF g_spawn_count > 500 g_spawn_count = 1 ENDIF
        ELIF g_item = 4
            g_spawn_alignment = 1 - g_spawn_alignment
        ELIF g_item = 5
            g_spawn_facing = g_spawn_facing + direction
            IF g_spawn_facing < 0 g_spawn_facing = 3 ENDIF
            IF g_spawn_facing > 3 g_spawn_facing = 0 ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 0
        IF g_item = 11
            g_attacker_model_choice = g_attacker_model_choice + direction
            IF g_attacker_model_choice < 0 g_attacker_model_choice = 3 ENDIF
            IF g_attacker_model_choice > 3 g_attacker_model_choice = 0 ENDIF
        ENDIF
        IF g_item = 12
            g_attacker_weapon_choice = g_attacker_weapon_choice + direction
            IF g_attacker_weapon_choice < 0 g_attacker_weapon_choice = 3 ENDIF
            IF g_attacker_weapon_choice > 3 g_attacker_weapon_choice = 0 ENDIF
        ENDIF
    ENDIF
    IF g_tab = 4
        IF g_item = 0
            g_time_choice = g_time_choice + direction
            IF g_time_choice < 0 g_time_choice = 3 ENDIF
            IF g_time_choice > 3 g_time_choice = 0 ENDIF
        ENDIF
        IF g_item = 1
            g_weather_choice = g_weather_choice + direction
            IF g_weather_choice < 0 g_weather_choice = 5 ENDIF
            IF g_weather_choice > 5 g_weather_choice = 0 ENDIF
        ENDIF
    ENDIF
    IF g_tab = 3 AND g_item = 0
        g_vehicle_spawn_choice = g_vehicle_spawn_choice + direction
        IF g_vehicle_spawn_choice < 0 g_vehicle_spawn_choice = 25 ENDIF
        IF g_vehicle_spawn_choice > 25 g_vehicle_spawn_choice = 0 ENDIF
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 1
        g_lsc_slot_choice = g_lsc_slot_choice + direction
        IF g_lsc_slot_choice < 0 g_lsc_slot_choice = 25 ENDIF
        IF g_lsc_slot_choice > 25 g_lsc_slot_choice = 0 ENDIF
        g_lsc_mod_choice = -1
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 3
        g_lsc_primary_colour = g_lsc_primary_colour + direction
        IF g_lsc_primary_colour < 0 g_lsc_primary_colour = 8 ENDIF
        IF g_lsc_primary_colour > 8 g_lsc_primary_colour = 0 ENDIF
        SET_VEHICLE_COLOURS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_primary_colour, g_lsc_secondary_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 4
        g_lsc_secondary_colour = g_lsc_secondary_colour + direction
        IF g_lsc_secondary_colour < 0 g_lsc_secondary_colour = 8 ENDIF
        IF g_lsc_secondary_colour > 8 g_lsc_secondary_colour = 0 ENDIF
        SET_VEHICLE_COLOURS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_primary_colour, g_lsc_secondary_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 8
        g_lsc_wheel_type = g_lsc_wheel_type + direction
        IF g_lsc_wheel_type < 0 g_lsc_wheel_type = 9 ENDIF
        IF g_lsc_wheel_type > 9 g_lsc_wheel_type = 0 ENDIF
        SET_VEHICLE_WHEEL_TYPE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
    ENDIF
    IF g_tab = 3 AND g_item = 15
        g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
    ENDIF
    IF g_tab = 3 AND NOT g_spawner_open AND NOT g_lsc_open
        IF g_item = 7
            g_vehicle_acceleration_level = g_vehicle_acceleration_level + direction
            IF g_vehicle_acceleration_level < 0 g_vehicle_acceleration_level = 9 ENDIF
            IF g_vehicle_acceleration_level > 9 g_vehicle_acceleration_level = 0 ENDIF
        ENDIF
        IF g_item = 8
            g_vehicle_top_speed_level = g_vehicle_top_speed_level + direction
            IF g_vehicle_top_speed_level < 0 g_vehicle_top_speed_level = 9 ENDIF
            IF g_vehicle_top_speed_level > 9 g_vehicle_top_speed_level = 0 ENDIF
        ENDIF
    ENDIF
    IF g_tab = 8
        IF g_item = 0
            g_accent_choice = g_accent_choice + direction
            IF g_accent_choice < 0 g_accent_choice = 13 ENDIF
            IF g_accent_choice > 13 g_accent_choice = 0 ENDIF
            APPLY_ACCENT_CHOICE()
        ENDIF
        IF g_item = 1
            g_respawn_location_choice = g_respawn_location_choice + direction
            IF g_respawn_location_choice < 0 g_respawn_location_choice = 11 ENDIF
            IF g_respawn_location_choice > 11 g_respawn_location_choice = 0 ENDIF
        ENDIF
        IF g_item = 3
            g_menu_x = g_menu_x + (TO_FLOAT(direction) * 0.005)
            IF g_menu_x < 0.150 g_menu_x = 0.150 ENDIF
            IF g_menu_x > 0.850 g_menu_x = 0.850 ENDIF
        ENDIF
        IF g_item = 4
            g_menu_y = g_menu_y + (TO_FLOAT(direction) * 0.005)
            IF g_menu_y < -0.080 g_menu_y = -0.080 ENDIF
            IF g_menu_y > 0.120 g_menu_y = 0.120 ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC DRAW_TIME_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_time_choice
        CASE 0 DRAW_OPTION(y, "Time:", "< Morning >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Time:", "< Noon >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Time:", "< Evening >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Time:", "< Midnight >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WEATHER_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_weather_choice
        CASE 0 DRAW_OPTION(y, "Weather:", "< Extra sunny >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Weather:", "< Clear >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Weather:", "< Clouds >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Weather:", "< Overcast >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Weather:", "< Rain >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Weather:", "< Thunder >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_ACCENT_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_accent_choice
        CASE 0 DRAW_OPTION(y, "Accent colour:", "< Blue >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Accent colour:", "< Crimson >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Accent colour:", "< Gold >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Accent colour:", "< Purple >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Accent colour:", "< Emerald >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Accent colour:", "< Cyan >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Accent colour:", "< Orange >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Accent colour:", "< Pink >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Accent colour:", "< Slate >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Accent colour:", "< Lime >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Accent colour:", "< White >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Accent colour:", "< Burnt orange >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Accent colour:", "< Charcoal >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Accent colour:", "< Sky blue >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_MENU_X_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Menu horizontal:", "< adjust >", selected, 3)
ENDPROC

PROC DRAW_MENU_Y_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Menu vertical:", "< adjust >", selected, 3)
ENDPROC

PROC DRAW_RESPAWN_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_respawn_location_choice
        CASE 0 DRAW_OPTION(y, "Respawn location:", "< Last death >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Respawn location:", "< Franklin's house >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Respawn location:", "< Michael's house >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Respawn location:", "< Trevor's trailer >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Respawn location:", "< Hospital >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Respawn location:", "< Simeon's dealership >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Respawn location:", "< Ammu-Nation >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Respawn location:", "< Police station >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Respawn location:", "< Los Santos Customs >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Respawn location:", "< LS Airport >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Respawn location:", "< Maze Bank Tower >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Respawn location:", "< Grove Street >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_SPAWN_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_vehicle_spawn_choice
        CASE 0 DRAW_OPTION(y, "Vehicle:", "< Adder >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Vehicle:", "< Buffalo >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Vehicle:", "< Cheetah >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Vehicle:", "< Comet >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Vehicle:", "< Entity XF >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Vehicle:", "< Infernus >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Vehicle:", "< Sultan >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Vehicle:", "< Rapid GT >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Vehicle:", "< Carbonizzare >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Vehicle:", "< Feltzer >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Vehicle:", "< 9F >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Vehicle:", "< Dominator >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Vehicle:", "< Gauntlet >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Vehicle:", "< Elegy >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Vehicle:", "< Baller >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Vehicle:", "< Granger >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Vehicle:", "< Sandking >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, "Vehicle:", "< Mesa >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, "Vehicle:", "< Bati 801 >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Vehicle:", "< PCJ-600 >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Vehicle:", "< Akuma >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "Vehicle:", "< Sanchez >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Vehicle:", "< Faggio >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, "Vehicle:", "< Buzzard >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, "Vehicle:", "< Duster >", selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, "Vehicle:", "< Cargobob >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_SELECTED_VEHICLE_SPAWN()
    SWITCH g_vehicle_spawn_choice
        CASE 0 g_pending_vehicle_model = ADDER BREAK
        CASE 1 g_pending_vehicle_model = BUFFALO BREAK
        CASE 2 g_pending_vehicle_model = CHEETAH BREAK
        CASE 3 g_pending_vehicle_model = COMET2 BREAK
        CASE 4 g_pending_vehicle_model = ENTITYXF BREAK
        CASE 5 g_pending_vehicle_model = INFERNUS BREAK
        CASE 6 g_pending_vehicle_model = SULTAN BREAK
        CASE 7 g_pending_vehicle_model = RAPIDGT BREAK
        CASE 8 g_pending_vehicle_model = CARBONIZZARE BREAK
        CASE 9 g_pending_vehicle_model = FELTZER2 BREAK
        CASE 10 g_pending_vehicle_model = NINEF BREAK
        CASE 11 g_pending_vehicle_model = DOMINATOR BREAK
        CASE 12 g_pending_vehicle_model = GAUNTLET BREAK
        CASE 13 g_pending_vehicle_model = ELEGY2 BREAK
        CASE 14 g_pending_vehicle_model = BALLER BREAK
        CASE 15 g_pending_vehicle_model = GRANGER BREAK
        CASE 16 g_pending_vehicle_model = SANDKING BREAK
        CASE 17 g_pending_vehicle_model = MESA BREAK
        CASE 18 g_pending_vehicle_model = BATI BREAK
        CASE 19 g_pending_vehicle_model = PCJ BREAK
        CASE 20 g_pending_vehicle_model = AKUMA BREAK
        CASE 21 g_pending_vehicle_model = SANCHEZ BREAK
        CASE 22 g_pending_vehicle_model = FAGGIO BREAK
        CASE 23 g_pending_vehicle_model = BUZZARD BREAK
        CASE 24 g_pending_vehicle_model = DUSTER BREAK
        CASE 25 g_pending_vehicle_model = CARGOBOB BREAK
    ENDSWITCH
    IF IS_MODEL_IN_CDIMAGE(g_pending_vehicle_model)
        IF g_spawn_count < 1 g_spawn_count = 1 ENDIF
        IF g_spawn_count > 500 g_spawn_count = 500 ENDIF
        g_spawn_remaining = g_spawn_count
        g_spawn_index = 0
        g_spawn_heading = GET_ENTITY_HEADING(PLAYER_PED_ID())
        IF g_delete_previous_spawned_vehicle
            DELETE_PREVIOUS_CUSTOM_CAR()
        ENDIF
        REQUEST_MODEL(g_pending_vehicle_model)
        g_vehicle_spawn_pending = TRUE
        g_vehicle_spawn_request_time = GET_GAME_TIMER()
    ENDIF
ENDPROC

PROC START_ONE_SELECTED_VEHICLE_SPAWN()
    INT savedSpawnCount = g_spawn_count
    g_spawn_count = 1
    START_SELECTED_VEHICLE_SPAWN()
    g_spawn_count = savedSpawnCount
ENDPROC

PROC FINISH_SELECTED_VEHICLE_SPAWN()
    VEHICLE_INDEX spawnedVehicle
    INT column = 0
    INT row = 0
    FLOAT offsetX = 0.0
    FLOAT offsetY = 8.0
    IF g_spawn_alignment = 0
        column = g_spawn_index - ((g_spawn_index / 10) * 10)
        row = g_spawn_index / 10
        offsetX = (TO_FLOAT(column) - 4.5) * 5.0
        offsetY = 8.0 + (TO_FLOAT(row) * 7.0)
    ELSE
        column = g_spawn_index - ((g_spawn_index / 5) * 5)
        row = g_spawn_index / 5
        offsetX = (TO_FLOAT(column) - 2.0) * 7.0
        offsetY = 8.0 + (TO_FLOAT(row) * 5.0)
    ENDIF
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<offsetX, offsetY, 1.0>>)
    FLOAT spawnHeading = g_spawn_heading + (TO_FLOAT(g_spawn_facing) * 90.0)
    spawnedVehicle = CREATE_VEHICLE(g_pending_vehicle_model, spawnPosition, spawnHeading, FALSE)
    IF DOES_ENTITY_EXIST(spawnedVehicle)
        SET_VEHICLE_ON_GROUND_PROPERLY(spawnedVehicle)
        IF g_spawn_maxed
            APPLY_LSC_MAX_TO_VEHICLE(spawnedVehicle)
        ENDIF
        IF g_spawned_custom_vehicle_count < 500
            g_spawned_custom_vehicles[g_spawned_custom_vehicle_count] = spawnedVehicle
            g_spawned_custom_vehicle_count = g_spawned_custom_vehicle_count + 1
        ENDIF
        g_last_spawned_vehicle = spawnedVehicle
    ENDIF
    g_spawn_index = g_spawn_index + 1
    g_spawn_remaining = g_spawn_remaining - 1
    IF g_spawn_remaining <= 0
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
        g_vehicle_spawn_pending = FALSE
    ENDIF
ENDPROC

PROC MOVE_PLAYER_TO_RESPAWN_LOCATION()
    SWITCH g_respawn_location_choice
        CASE 0 SET_ENTITY_COORDS(PLAYER_PED_ID(), g_last_living_position) BREAK
        CASE 1 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-14.4, -1438.0, 31.1>>) BREAK
        CASE 2 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-852.4, 160.0, 65.6>>) BREAK
        CASE 3 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<1975.5, 3819.6, 33.4>>) BREAK
        CASE 4 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-449.7, -340.7, 34.5>>) BREAK
        CASE 5 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-47.1, -1112.3, 26.4>>) BREAK
        CASE 6 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-662.1, -948.5, 21.5>>) BREAK
        CASE 7 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<425.1, -979.5, 30.7>>) BREAK
        CASE 8 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-365.4, -131.4, 37.9>>) BREAK
        CASE 9 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1034.6, -2733.6, 20.2>>) BREAK
        CASE 10 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-75.0, -818.9, 326.2>>) BREAK
        CASE 11 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<102.9, -1939.7, 20.8>>) BREAK
    ENDSWITCH
ENDPROC

PROC TELEPORT_PLAYER_WITH_VEHICLE(VECTOR destination)
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        SET_ENTITY_COORDS(GET_VEHICLE_PED_IS_IN(playerPed), destination)
    ELSE
        SET_ENTITY_COORDS(playerPed, destination)
    ENDIF
ENDPROC

PROC MOVE_MENU_CURSOR(INT direction)
    g_item = g_item + direction
    IF g_item < 0 g_item = ACTIVE_ITEM_COUNT() - 1 ENDIF
    IF g_item >= ACTIVE_ITEM_COUNT() g_item = 0 ENDIF
ENDPROC

PROC PROCESS_MENU_DIRECTION_INPUT()
    INT now = GET_GAME_TIMER()
    IF g_keyboard_active EXIT ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP)
        MOVE_MENU_CURSOR(-1)
        g_next_up_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP) AND now >= g_next_up_repeat
        MOVE_MENU_CURSOR(-1)
        g_next_up_repeat = now + 70
    ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
        MOVE_MENU_CURSOR(1)
        g_next_down_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN) AND now >= g_next_down_repeat
        MOVE_MENU_CURSOR(1)
        g_next_down_repeat = now + 70
    ENDIF

    IF NOT g_home AND IS_SELECTOR_ACTIVE()
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
            ADJUST_SELECTOR(-1)
            g_next_left_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT) AND now >= g_next_left_repeat
            ADJUST_SELECTOR(-1)
            g_next_left_repeat = now + 70
        ENDIF
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
            ADJUST_SELECTOR(1)
            g_next_right_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT) AND now >= g_next_right_repeat
            ADJUST_SELECTOR(1)
            g_next_right_repeat = now + 70
        ENDIF
    ENDIF
ENDPROC

PROC APPLY_SELECTED()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX playerVehicle
    SWITCH g_tab
        CASE 0
            SWITCH g_item
                CASE 0
                    g_god = NOT g_god
                    SET_PLAYER_INVINCIBLE(PLAYER_ID(), g_god)
                BREAK
                CASE 1
                    SET_ENTITY_HEALTH(playerPed, GET_ENTITY_MAX_HEALTH(playerPed))
                    SET_PED_ARMOUR(playerPed, 100)
                BREAK
                CASE 2
                    g_invisible = NOT g_invisible
                    SET_ENTITY_VISIBLE(playerPed, NOT g_invisible)
                BREAK
                CASE 3
                    g_no_ragdoll = NOT g_no_ragdoll
                    SET_PED_CAN_RAGDOLL(playerPed, NOT g_no_ragdoll)
                BREAK
                CASE 4
                    g_fast_run = NOT g_fast_run
                BREAK
                CASE 5
                    g_fast_swim = NOT g_fast_swim
                BREAK
                CASE 6
                    g_super_jump = NOT g_super_jump
                BREAK
                CASE 7
                    g_drunk = NOT g_drunk
                    IF g_drunk
                        SET_PED_IS_DRUNK(playerPed, TRUE)
                        REQUEST_ANIM_SET("move_m@drunk@verydrunk")
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.30)
                    ELSE
                        SET_PED_IS_DRUNK(playerPed, FALSE)
                        RESET_PED_MOVEMENT_CLIPSET(playerPed)
                        STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                    ENDIF
                BREAK
                CASE 8
                    g_explosive_melee = NOT g_explosive_melee
                BREAK
                CASE 9 OPEN_MENU_KEYBOARD(2) BREAK
                CASE 10
                    SWITCH GET_ENTITY_MODEL(playerPed)
                        CASE PLAYER_ZERO STAT_SET_INT(SP0_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_ONE STAT_SET_INT(SP1_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_TWO STAT_SET_INT(SP2_TOTAL_CASH, g_cash_amount) BREAK
                    ENDSWITCH
                BREAK
                CASE 11
                    g_attacker_model_choice = g_attacker_model_choice
                BREAK
                CASE 12
                    g_attacker_weapon_choice = g_attacker_weapon_choice
                BREAK
                CASE 13 START_ATTACKER_SPAWN() BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH g_item
                CASE 0
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_PISTOL, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_COMBATPISTOL, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_APPISTOL, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_MICROSMG, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_SMG, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_ASSAULTRIFLE, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_CARBINERIFLE, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_ADVANCEDRIFLE, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_MG, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_COMBATMG, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_PUMPSHOTGUN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_SAWNOFFSHOTGUN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_ASSAULTSHOTGUN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_SNIPERRIFLE, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_HEAVYSNIPER, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_GRENADELAUNCHER, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_RPG, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_MINIGUN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_GRENADE, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_STICKYBOMB, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_MOLOTOV, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_SMOKEGRENADE, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_BZGAS, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_FLARE, 25, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_STUNGUN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_FIREEXTINGUISHER, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_PETROLCAN, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_KNIFE, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_NIGHTSTICK, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_HAMMER, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_BAT, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_CROWBAR, 9999, TRUE)
                    GIVE_DELAYED_WEAPON_TO_PED(playerPed, WEAPONTYPE_GOLFCLUB, 9999, TRUE)
                BREAK
                CASE 1
                    g_infinite_ammo = NOT g_infinite_ammo
                    SET_PED_INFINITE_AMMO(playerPed, g_infinite_ammo, WEAPONTYPE_INVALID)
                BREAK
                CASE 2
                    REFILL_ALL_OWNED_WEAPONS(playerPed)
                BREAK
                CASE 3 REMOVE_ALL_PED_WEAPONS(playerPed) BREAK
                CASE 4
                    g_explosive_ammo = NOT g_explosive_ammo
                BREAK
                CASE 5
                    g_fire_ammo = NOT g_fire_ammo
                BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH g_item
                CASE 0
                    g_never_wanted = NOT g_never_wanted
                    IF g_never_wanted
                        SET_MAX_WANTED_LEVEL(0)
                        CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID())
                    ELSE
                        SET_MAX_WANTED_LEVEL(5)
                    ENDIF
                BREAK
                CASE 1 CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID()) BREAK
                CASE 2
                    SET_PLAYER_WANTED_LEVEL(PLAYER_ID(), 5)
                    SET_PLAYER_WANTED_LEVEL_NOW(PLAYER_ID())
                BREAK
                CASE 3
                    g_ignore_police = NOT g_ignore_police
                    SET_POLICE_IGNORE_PLAYER(PLAYER_ID(), g_ignore_police)
                BREAK
                CASE 4
                    g_dispatch = NOT g_dispatch
                    ENABLE_DISPATCH_SERVICE(DT_POLICE_AUTOMOBILE, g_dispatch)
                    ENABLE_DISPATCH_SERVICE(DT_POLICE_HELICOPTER, g_dispatch)
                    ENABLE_DISPATCH_SERVICE(DT_SWAT_AUTOMOBILE, g_dispatch)
                    ENABLE_DISPATCH_SERVICE(DT_POLICE_ROAD_BLOCK, g_dispatch)
                    ENABLE_DISPATCH_SERVICE(DT_ARMY_VEHICLE, g_dispatch)
                BREAK
                CASE 5
                    g_civilian_reports = NOT g_civilian_reports
                    SET_DISPATCH_COPS_FOR_PLAYER(PLAYER_ID(), g_civilian_reports)
                BREAK
            ENDSWITCH
        BREAK
        CASE 3
            IF g_spawner_open
                SWITCH g_item
                    CASE 0 START_SELECTED_VEHICLE_SPAWN() BREAK
                    CASE 1 START_ONE_SELECTED_VEHICLE_SPAWN() BREAK
                    CASE 2 OPEN_MENU_KEYBOARD(1) BREAK
                    CASE 3 g_spawn_maxed = NOT g_spawn_maxed BREAK
                    CASE 6 g_delete_previous_spawned_vehicle = NOT g_delete_previous_spawned_vehicle BREAK
                    CASE 7 DELETE_ALL_CUSTOM_CARS() BREAK
                ENDSWITCH
            ELIF g_lsc_open
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    SWITCH g_item
                        CASE 0 APPLY_LSC_MAX() BREAK
                        CASE 2 APPLY_LSC_MOD() BREAK
                        CASE 3
                            g_lsc_primary_colour = g_lsc_primary_colour + 1
                            IF g_lsc_primary_colour > 8 g_lsc_primary_colour = 0 ENDIF
                            SET_VEHICLE_COLOURS(playerVehicle, g_lsc_primary_colour, g_lsc_secondary_colour)
                        BREAK
                        CASE 4
                            g_lsc_secondary_colour = g_lsc_secondary_colour + 1
                            IF g_lsc_secondary_colour > 8 g_lsc_secondary_colour = 0 ENDIF
                            SET_VEHICLE_COLOURS(playerVehicle, g_lsc_primary_colour, g_lsc_secondary_colour)
                        BREAK
                        CASE 5
                            g_lsc_turbo = NOT g_lsc_turbo
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_lsc_turbo)
                        BREAK
                        CASE 6
                            g_lsc_xenon = NOT g_lsc_xenon
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_XENON_LIGHTS, g_lsc_xenon)
                        BREAK
                        CASE 7
                            g_lsc_neon = NOT g_lsc_neon
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_FRONT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_BACK, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_LEFT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_RIGHT, g_lsc_neon)
                        BREAK
                        CASE 8
                            g_lsc_wheel_type = g_lsc_wheel_type + 1
                            IF g_lsc_wheel_type > 9 g_lsc_wheel_type = 0 ENDIF
                            SET_VEHICLE_WHEEL_TYPE(playerVehicle, INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
                        BREAK
                        CASE 9
                            REMOVE_VEHICLE_MOD(playerVehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
                            g_lsc_mod_choice = -1
                        BREAK
                    ENDSWITCH
                ELSE
                    g_lsc_open = TRUE
                ENDIF
            ELIF g_item = 0
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_spawner_open = TRUE
                g_item = g_spawner_item
                g_scroll = g_spawner_scroll
            ELIF g_item = 12
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_lsc_open = TRUE
                g_lsc_mod_choice = -1
                g_item = g_lsc_item
                g_scroll = g_lsc_scroll
            ELIF g_item = 14
                g_vehicle_speedometer = NOT g_vehicle_speedometer
            ELIF g_item = 15
                g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
            ELIF g_item > 0 AND g_item < 13 AND IS_PED_IN_ANY_VEHICLE(playerPed)
                playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                SWITCH g_item
                    CASE 1
                        g_vehicle_god = NOT g_vehicle_god
                        SET_ENTITY_INVINCIBLE(playerVehicle, g_vehicle_god)
                    BREAK
                    CASE 2
                        SET_VEHICLE_FIXED(playerVehicle)
                        SET_VEHICLE_ENGINE_HEALTH(playerVehicle, 1000.0)
                    BREAK
                    CASE 3
                        g_vehicle_auto_repair = NOT g_vehicle_auto_repair
                    BREAK
                    CASE 4 SET_VEHICLE_ON_GROUND_PROPERLY(playerVehicle) BREAK
                    CASE 5 SET_VEHICLE_ENGINE_HEALTH(playerVehicle, -4000.0) BREAK
                    CASE 6
                        g_doors_locked = NOT g_doors_locked
                        IF g_doors_locked
                            SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_LOCKED)
                        ELSE
                            SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_UNLOCKED)
                        ENDIF
                    BREAK
                    CASE 7
                        g_seatbelt = NOT g_seatbelt
                        IF g_seatbelt
                            SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_NEVER)
                        ELSE
                            SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_DEFAULT)
                        ENDIF
                    BREAK
                    CASE 8 BREAK
                    CASE 9 BREAK
                    CASE 10 g_vehicle_cornering = NOT g_vehicle_cornering BREAK
                    CASE 11 g_vehicle_bulletproof_tyres = NOT g_vehicle_bulletproof_tyres BREAK
                    CASE 12
                        g_vehicle_turbo = NOT g_vehicle_turbo
                        SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                        TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_vehicle_turbo)
                    BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 4
            SWITCH g_item
                CASE 0 APPLY_TIME_CHOICE() BREAK
                CASE 1 APPLY_WEATHER_CHOICE() BREAK
                CASE 2
                    g_night_vision = NOT g_night_vision
                    SET_NIGHTVISION(g_night_vision)
                BREAK
                CASE 3
                    g_thermal_vision = NOT g_thermal_vision
                    SET_SEETHROUGH(g_thermal_vision)
                BREAK
                CASE 4
                    g_motion_blur = NOT g_motion_blur
                    IF g_motion_blur
                        SET_TIMECYCLE_MODIFIER("scanline_cam_cheap")
                    ELSE
                        CLEAR_TIMECYCLE_MODIFIER()
                    ENDIF
                BREAK
                CASE 5
                    g_camera_shake = NOT g_camera_shake
                    IF g_camera_shake
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.5)
                    ELSE
                        STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                    ENDIF
                BREAK
            ENDSWITCH
        BREAK
        CASE 5
            SWITCH g_item
                CASE 0
                    IF IS_PED_IN_ANY_VEHICLE(playerPed)
                        DISABLE_PORTABLE_RADIO()
                    ELSE
                        g_mobile_radio = NOT g_mobile_radio
                        SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(g_mobile_radio)
                        SET_MOBILE_PHONE_RADIO_STATE(g_mobile_radio)
                        SET_USER_RADIO_CONTROL_ENABLED(g_mobile_radio)
                    ENDIF
                BREAK
                CASE 1 SET_RADIO_RETUNE_DOWN() BREAK
                CASE 2 SET_RADIO_RETUNE_UP() BREAK
            ENDSWITCH
        BREAK
        CASE 6
            SWITCH g_item
                CASE 0 TELEPORT_PLAYER_WITH_VEHICLE(<<501.7, 5604.4, 797.9>>) BREAK
                CASE 1 TELEPORT_PLAYER_WITH_VEHICLE(<<-75.0, -818.9, 326.2>>) BREAK
                CASE 2 TELEPORT_PLAYER_WITH_VEHICLE(<<-1034.6, -2733.6, 20.2>>) BREAK
                CASE 3 TELEPORT_PLAYER_WITH_VEHICLE(<<711.7, 1198.8, 348.5>>) BREAK
                CASE 4 TELEPORT_PLAYER_WITH_VEHICLE(<<-2047.4, 3132.1, 32.8>>) BREAK
                CASE 5 TELEPORT_PLAYER_WITH_VEHICLE(<<102.9, -1939.7, 20.8>>) BREAK
                CASE 6 TELEPORT_PLAYER_WITH_VEHICLE(<<-14.4, -1438.0, 31.1>>) BREAK
                CASE 7 TELEPORT_PLAYER_WITH_VEHICLE(<<-852.4, 160.0, 65.6>>) BREAK
                CASE 8 TELEPORT_PLAYER_WITH_VEHICLE(<<1975.5, 3819.6, 33.4>>) BREAK
                CASE 9 TELEPORT_PLAYER_WITH_VEHICLE(<<1274.8, -1710.0, 54.8>>) BREAK
                CASE 10 TELEPORT_PLAYER_WITH_VEHICLE(<<-47.1, -1112.3, 26.4>>) BREAK
                CASE 11 TELEPORT_PLAYER_WITH_VEHICLE(<<-449.7, -340.7, 34.5>>) BREAK
                CASE 12 TELEPORT_PLAYER_WITH_VEHICLE(<<425.1, -979.5, 30.7>>) BREAK
                CASE 13 TELEPORT_PLAYER_WITH_VEHICLE(<<-662.1, -948.5, 21.5>>) BREAK
                CASE 14 TELEPORT_PLAYER_WITH_VEHICLE(<<-365.4, -131.4, 37.9>>) BREAK
            ENDSWITCH
        BREAK
        CASE 7
            SWITCH g_item
                CASE 0
                    g_npc_brawl = NOT g_npc_brawl
                    IF g_npc_brawl
                        g_everyone_ignores = FALSE
                        TASK_NEARBY_NPCS_TO_BRAWL()
                        g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
                    ELSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 1
                    g_everyone_ignores = NOT g_everyone_ignores
                    IF g_everyone_ignores AND g_npc_brawl
                        g_npc_brawl = FALSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 2 g_low_population = NOT g_low_population BREAK
                CASE 3 g_hud_hidden = NOT g_hud_hidden BREAK
                CASE 4 g_radar_hidden = NOT g_radar_hidden BREAK
                CASE 5 g_first_person = NOT g_first_person BREAK
                CASE 6 CLEAR_AREA_OF_VEHICLES(GET_ENTITY_COORDS(playerPed), 50.0) BREAK
                CASE 7 CLEAR_AREA_OF_PEDS(GET_ENTITY_COORDS(playerPed), 50.0) BREAK
            ENDSWITCH
        BREAK
        CASE 8
            SWITCH g_item
                CASE 2 g_respawn_at_death = NOT g_respawn_at_death BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
ENDPROC

FUNC INT PAGE_COUNT()
    RETURN 9
ENDFUNC

PROC DRAW_PLAYER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_god DRAW_OPTION(y, "God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, "Heal + Armour", "APPLY", g_item = index, 2) BREAK
        CASE 2 IF g_invisible DRAW_OPTION(y, "Invisible Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Invisible Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_no_ragdoll DRAW_OPTION(y, "Disable Ragdoll", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Disable Ragdoll", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_fast_run DRAW_OPTION(y, "Fast Run", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Run", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_fast_swim DRAW_OPTION(y, "Fast Swim", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Swim", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 IF g_super_jump DRAW_OPTION(y, "Super Jump", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Super Jump", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 IF g_drunk DRAW_OPTION(y, "Drunk Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Drunk Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 IF g_explosive_melee DRAW_OPTION(y, "Explosive Melee", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Explosive Melee", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 9 DRAW_NUMBER_OPTION(y, "Cash Balance", g_cash_amount, g_item = index) BREAK
        CASE 10 DRAW_OPTION(y, "Apply Cash Balance", "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_ATTACKER_MODEL(y, g_item = index) BREAK
        CASE 12 DRAW_ATTACKER_WEAPON(y, g_item = index) BREAK
        CASE 13 DRAW_OPTION(y, "Send Attacker", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_MULTIPLIER(FLOAT y, STRING label, INT level, BOOL selected)
    IF level = 0
        DRAW_OPTION(y, label, "< OFF >", selected, 0)
    ELIF level = 1
        DRAW_OPTION(y, label, "< 1.25x >", selected, 3)
    ELIF level = 2
        DRAW_OPTION(y, label, "< 1.5x >", selected, 3)
    ELIF level = 3
        DRAW_OPTION(y, label, "< 2x >", selected, 3)
    ELIF level = 4
        DRAW_OPTION(y, label, "< 2.5x >", selected, 3)
    ELIF level = 5
        DRAW_OPTION(y, label, "< 3x >", selected, 3)
    ELIF level = 6
        DRAW_OPTION(y, label, "< 4x >", selected, 3)
    ELIF level = 7
        DRAW_OPTION(y, label, "< 5x >", selected, 3)
    ELIF level = 8
        DRAW_OPTION(y, label, "< 10x >", selected, 3)
    ELSE
        DRAW_OPTION(y, label, "< 20x >", selected, 3)
    ENDIF
ENDPROC

FUNC FLOAT VEHICLE_MULTIPLIER_VALUE(INT level)
    IF level = 1 RETURN 1.25 ENDIF
    IF level = 2 RETURN 1.5 ENDIF
    IF level = 3 RETURN 2.0 ENDIF
    IF level = 4 RETURN 2.5 ENDIF
    IF level = 5 RETURN 3.0 ENDIF
    IF level = 6 RETURN 4.0 ENDIF
    IF level = 7 RETURN 5.0 ENDIF
    IF level = 8 RETURN 10.0 ENDIF
    IF level = 9 RETURN 20.0 ENDIF
    RETURN 0.0
ENDFUNC

PROC DRAW_VEHICLE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Vehicle Spawner", "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_vehicle_god DRAW_OPTION(y, "Vehicle God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Vehicle God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, "Repair Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 3 IF g_vehicle_auto_repair DRAW_OPTION(y, "Auto Repair Vehicle", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Repair Vehicle", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 DRAW_OPTION(y, "Flip Vehicle upright", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Destroy Engine", "APPLY", g_item = index, 2) BREAK
        CASE 6 IF g_doors_locked DRAW_OPTION(y, "Lock Doors", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Lock Doors", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 IF g_seatbelt DRAW_OPTION(y, "Always Seatbelt", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Seatbelt", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_VEHICLE_MULTIPLIER(y, "Acceleration Boost", g_vehicle_acceleration_level, g_item = index) BREAK
        CASE 9 DRAW_VEHICLE_MULTIPLIER(y, "Top-Speed Boost", g_vehicle_top_speed_level, g_item = index) BREAK
        CASE 10 IF g_vehicle_cornering DRAW_OPTION(y, "High Cornering Grip", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "High Cornering Grip", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_vehicle_bulletproof_tyres DRAW_OPTION(y, "Bulletproof Tyres", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Bulletproof Tyres", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_vehicle_turbo DRAW_OPTION(y, "Turbo Mod", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo Mod", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 DRAW_OPTION(y, "LS Customs", "OPEN", g_item = index, 2) BREAK
        CASE 14 IF g_vehicle_speedometer DRAW_OPTION(y, "Speedometer", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Speedometer", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 IF g_vehicle_speed_unit = 0 DRAW_OPTION(y, "Speed Unit", "< MPH >", g_item = index, 3) ELSE DRAW_OPTION(y, "Speed Unit", "< KMPH >", g_item = index, 3) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Spawn Selected Vehicle(s)", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_VEHICLE_SPAWN_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_NUMBER_OPTION(y, "Spawn Count", g_spawn_count, g_item = index) BREAK
        CASE 3 IF g_spawn_maxed DRAW_OPTION(y, "Max Available Upgrades", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Max Available Upgrades", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_spawn_alignment = 0 DRAW_OPTION(y, "Alignment", "< Door to Door >", g_item = index, 3) ELSE DRAW_OPTION(y, "Alignment", "< Bumper to Bumper >", g_item = index, 3) ENDIF BREAK
        CASE 5
            IF g_spawn_facing = 0 DRAW_OPTION(y, "Facing", "< Forward >", g_item = index, 3)
            ELIF g_spawn_facing = 1 DRAW_OPTION(y, "Facing", "< Right >", g_item = index, 3)
            ELIF g_spawn_facing = 2 DRAW_OPTION(y, "Facing", "< Backward >", g_item = index, 3)
            ELSE DRAW_OPTION(y, "Facing", "< Left >", g_item = index, 3) ENDIF
        BREAK
        CASE 6 IF g_delete_previous_spawned_vehicle DRAW_OPTION(y, "Auto Delete Previous Car", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Delete Previous Car", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 DRAW_OPTION(y, "Delete All Custom Cars", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SPAWNER")
    INT index = g_spawner_scroll
    INT row = 0
    WHILE row < 8 AND index < 8
        DRAW_SPAWNER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_MISC_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_npc_brawl DRAW_OPTION(y, "Nearby NPC Brawl", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Nearby NPC Brawl", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 IF g_everyone_ignores DRAW_OPTION(y, "Everyone Ignores Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Everyone Ignores Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 IF g_low_population DRAW_OPTION(y, "Low Population", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Low Population", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_hud_hidden DRAW_OPTION(y, "Hide HUD", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide HUD", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_radar_hidden DRAW_OPTION(y, "Hide Radar", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide Radar", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_first_person DRAW_OPTION(y, "Force First Person", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Force First Person", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 DRAW_OPTION(y, "Clear Nearby Vehicles", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Clear Nearby Peds", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TELEPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Mount Chiliad", ">", g_item = index, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Maze Bank Tower", ">", g_item = index, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Los Santos Airport", ">", g_item = index, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Vinewood Sign", ">", g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Fort Zancudo", ">", g_item = index, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Grove Street", ">", g_item = index, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Franklin's House", ">", g_item = index, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Michael's House", ">", g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Trevor's Trailer", ">", g_item = index, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Lester's Warehouse", ">", g_item = index, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Simeon's Dealership", ">", g_item = index, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Hospital", ">", g_item = index, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Police Station", ">", g_item = index, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Ammu-Nation", ">", g_item = index, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Los Santos Customs", ">", g_item = index, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Max All Available Mods", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_OPTION(y, "Apply Mod Slot", "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Primary Colour", "< cycle palette >", g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Secondary Colour", "< cycle palette >", g_item = index, 3) BREAK
        CASE 5 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon Lights", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon Kit", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_OPTION(y, "Wheel Type", "< cycle >", g_item = index, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SCROLLING_ROWS(INT total, INT rowType)
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < total
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF rowType = 0 DRAW_PLAYER_ROW(index, y) ENDIF
        IF rowType = 1 DRAW_VEHICLE_ROW(index, y) ENDIF
        IF rowType = 2 DRAW_MISC_ROW(index, y) ENDIF
        IF rowType = 3 DRAW_TELEPORT_ROW(index, y) ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_PAGE()
    INT titleR = 255
    INT titleG = 255
    INT titleB = 255
    IF g_accent_choice = 10
        titleR = 35
        titleG = 45
        titleB = 65
    ENDIF
    DRAW_RECT(g_menu_x, 0.413 + g_menu_y, MENU_W, 0.525, 8, 9, 12, 220)
    DRAW_RECT(g_menu_x, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    DRAW_RECT(g_menu_x, 0.640 + g_menu_y, MENU_W - 0.012, 0.060, 0, 0, 0, 180)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.060, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.057, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    SWITCH g_tab
        CASE 0
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PLAYER SETTINGS")
            DRAW_SCROLLING_ROWS(14, 0)
        BREAK
        CASE 1
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WEAPON SETTINGS")
            DRAW_OPTION(0.268, "Give Upgraded Weapons", "APPLY", g_item = 0, 2)
            IF g_infinite_ammo DRAW_OPTION(0.306, "Infinite Ammo", "ON", g_item = 1, 1) ELSE DRAW_OPTION(0.306, "Infinite Ammo", "OFF", g_item = 1, 0) ENDIF
            DRAW_OPTION(0.344, "Refill All Ammo", "APPLY", g_item = 2, 2)
            DRAW_OPTION(0.382, "Remove All Weapons", "APPLY", g_item = 3, 2)
            IF g_explosive_ammo DRAW_OPTION(0.420, "Explosive Bullets", "ON", g_item = 4, 1) ELSE DRAW_OPTION(0.420, "Explosive Bullets", "OFF", g_item = 4, 0) ENDIF
            IF g_fire_ammo DRAW_OPTION(0.458, "Flaming Bullets", "ON", g_item = 5, 1) ELSE DRAW_OPTION(0.458, "Flaming Bullets", "OFF", g_item = 5, 0) ENDIF
        BREAK
        CASE 2
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WANTED LEVEL SETTINGS")
            IF g_never_wanted DRAW_OPTION(0.268, "Never Wanted", "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, "Never Wanted", "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, "Clear Wanted Level", "APPLY", g_item = 1, 2)
            DRAW_OPTION(0.344, "Wanted Level 5", "APPLY", g_item = 2, 2)
            IF g_ignore_police DRAW_OPTION(0.382, "Police Ignore Player", "ON", g_item = 3, 1) ELSE DRAW_OPTION(0.382, "Police Ignore Player", "OFF", g_item = 3, 0) ENDIF
            IF g_dispatch DRAW_OPTION(0.420, "Dispatch Services", "ON", g_item = 4, 1) ELSE DRAW_OPTION(0.420, "Dispatch Services", "OFF", g_item = 4, 0) ENDIF
            IF g_civilian_reports DRAW_OPTION(0.458, "Civilian Reports", "ON", g_item = 5, 1) ELSE DRAW_OPTION(0.458, "Civilian Reports", "OFF", g_item = 5, 0) ENDIF
        BREAK
        CASE 3
            IF g_spawner_open
                DRAW_SPAWNER_PAGE()
            ELIF g_lsc_open
                DRAW_LSC_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SETTINGS")
            DRAW_SCROLLING_ROWS(16, 1)
            ENDIF
        BREAK
        CASE 4
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WORLD AND WEATHER")
            DRAW_TIME_SELECTOR(0.268, g_item = 0)
            DRAW_WEATHER_SELECTOR(0.306, g_item = 1)
            IF g_night_vision DRAW_OPTION(0.344, "Night Vision", "ON", g_item = 2, 1) ELSE DRAW_OPTION(0.344, "Night Vision", "OFF", g_item = 2, 0) ENDIF
            IF g_thermal_vision DRAW_OPTION(0.382, "Thermal Vision", "ON", g_item = 3, 1) ELSE DRAW_OPTION(0.382, "Thermal Vision", "OFF", g_item = 3, 0) ENDIF
            IF g_motion_blur DRAW_OPTION(0.420, "Motion Blur", "ON", g_item = 4, 1) ELSE DRAW_OPTION(0.420, "Motion Blur", "OFF", g_item = 4, 0) ENDIF
            IF g_camera_shake DRAW_OPTION(0.458, "Camera Shake", "ON", g_item = 5, 1) ELSE DRAW_OPTION(0.458, "Camera Shake", "OFF", g_item = 5, 0) ENDIF
        BREAK
        CASE 5
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PORTABLE RADIO")
            IF g_mobile_radio DRAW_OPTION(0.268, "Portable Radio", "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, "Portable Radio", "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, "Previous Station", "APPLY", g_item = 1, 2)
            DRAW_OPTION(0.344, "Next Station", "APPLY", g_item = 2, 2)
        BREAK
        CASE 6
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "TELEPORT LOCATIONS")
            DRAW_SCROLLING_ROWS(15, 3)
        BREAK
        CASE 7
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "MISC AND NPC")
            DRAW_SCROLLING_ROWS(9, 2)
        BREAK
        CASE 8
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "MENU SETTINGS")
            DRAW_ACCENT_SELECTOR(0.268, g_item = 0)
            DRAW_RESPAWN_SELECTOR(0.306, g_item = 1)
            IF g_respawn_at_death DRAW_OPTION(0.344, "Enable Custom Respawn", "ON", g_item = 2, 1) ELSE DRAW_OPTION(0.344, "Enable Custom Respawn", "OFF", g_item = 2, 0) ENDIF
            DRAW_MENU_X_SELECTOR(0.382, g_item = 3)
            DRAW_MENU_Y_SELECTOR(0.420, g_item = 4)
        BREAK
    ENDSWITCH
    DRAW_SCROLLBAR()
    MENU_TEXT(g_menu_x - 0.130, 0.617, 0.250, 190, 198, 210, "DPAD: select")
    MENU_TEXT(g_menu_x - 0.130, 0.641, 0.250, 190, 198, 210, "A: apply   B: back")
ENDPROC

SCRIPT
    WHILE TRUE
        IF NOT g_open AND IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB)
        AND IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
            g_open = NOT g_open
            IF g_open
                g_home = TRUE
                g_item = g_home_item
                g_scroll = g_home_scroll
            ENDIF
        ENDIF
        IF g_god SET_PLAYER_INVINCIBLE(PLAYER_ID(), TRUE) ELSE SET_PLAYER_INVINCIBLE(PLAYER_ID(), FALSE) ENDIF
        IF g_never_wanted CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID()) ENDIF
        IF g_fast_run SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.49) ELSE SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.0) ENDIF
        IF g_fast_swim SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.49) ELSE SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER_ID(), 1.0) ENDIF
        IF g_super_jump SET_SUPER_JUMP_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_drunk AND HAS_ANIM_SET_LOADED("move_m@drunk@verydrunk")
            SET_PED_MOVEMENT_CLIPSET(PLAYER_PED_ID(), "move_m@drunk@verydrunk", 0.25)
        ENDIF
        IF g_explosive_ammo SET_EXPLOSIVE_AMMO_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_fire_ammo SET_FIRE_AMMO_THIS_FRAME(PLAYER_ID()) ENDIF
        IF g_explosive_melee SET_EXPLOSIVE_MELEE_THIS_FRAME(PLAYER_ID()) ENDIF
        SET_EVERYONE_IGNORE_PLAYER(PLAYER_ID(), g_everyone_ignores)
        DISPLAY_HUD(NOT g_hud_hidden)
        DISPLAY_RADAR(NOT g_radar_hidden)
        IF g_npc_brawl AND GET_GAME_TIMER() >= g_next_npc_brawl_update
            TASK_NEARBY_NPCS_TO_BRAWL()
            g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
        ENDIF
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
        g_player_in_vehicle = IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        IF g_lsc_open AND NOT g_player_in_vehicle
            g_item = 0
            g_scroll = 0
        ENDIF
        IF g_mobile_radio AND g_player_in_vehicle AND NOT g_was_in_vehicle
            DISABLE_PORTABLE_RADIO()
        ENDIF
        g_was_in_vehicle = g_player_in_vehicle
        IF g_player_in_vehicle
            IF g_vehicle_auto_repair SET_VEHICLE_FIXED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) ENDIF
            SET_VEHICLE_CHEAT_POWER_INCREASE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), VEHICLE_MULTIPLIER_VALUE(g_vehicle_acceleration_level))
            IF g_vehicle_top_speed_level > 0
                SET_VEHICLE_MAX_SPEED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), GET_VEHICLE_ESTIMATED_MAX_SPEED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) * VEHICLE_MULTIPLIER_VALUE(g_vehicle_top_speed_level))
            ELSE
                SET_VEHICLE_MAX_SPEED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), -1.0)
            ENDIF
            IF g_vehicle_cornering
                SET_VEHICLE_FRICTION_OVERRIDE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), 2.0)
            ELSE
                SET_VEHICLE_FRICTION_OVERRIDE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), -1.0)
            ENDIF
            IF g_vehicle_bulletproof_tyres
                SET_VEHICLE_TYRES_CAN_BURST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), FALSE)
            ELSE
                SET_VEHICLE_TYRES_CAN_BURST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), TRUE)
            ENDIF
        ENDIF
        IF g_seatbelt
            IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
                SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER_PED_ID(), KNOCKOFFVEHICLE_NEVER)
            ENDIF
        ENDIF
        IF g_open
            IF g_keyboard_active
                PROCESS_MENU_KEYBOARD()
            ENDIF
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
            DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
            MENU_CAPTURE_INPUT()
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_SPECIAL)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_JUMP)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_DUCK)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_HEADLIGHT)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_PUSHBIKE_PEDAL)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_FLY_THROTTLE_UP)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_HANDBRAKE)
            DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_CIN_CAM)
            PROCESS_MENU_DIRECTION_INPUT()
            IF NOT g_keyboard_active AND IS_DISABLED_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT)
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
                IF g_home
                    g_open = FALSE
                ELIF g_spawner_open
                    g_spawner_item = g_item
                    g_spawner_scroll = g_scroll
                    g_spawner_open = FALSE
                    g_item = g_page_item[3]
                    g_scroll = g_page_scroll[3]
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
        ENDIF
        DRAW_SPEEDOMETER()
        WAIT(0)
    ENDWHILE
ENDSCRIPT
