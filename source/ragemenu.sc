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
BOOL g_infinite_clip = FALSE
BOOL g_explosive_ammo = FALSE
BOOL g_fire_ammo = FALSE
INT g_weapon_choice = 0
BOOL g_explosive_melee = FALSE
BOOL g_infinite_parachute = FALSE
INT g_attacker_model_choice = 0
INT g_attacker_weapon_choice = 0
BOOL g_attacker_spawn_pending = FALSE
MODEL_NAMES g_pending_attacker_model = PLAYER_ZERO
WEAPON_TYPE g_pending_attacker_weapon = WEAPONTYPE_PISTOL
INT g_attacker_request_time = 0
PED_INDEX g_menu_attackers[32]
INT g_menu_attacker_count = 0
BOOL g_never_wanted = FALSE
BOOL g_ignore_police = FALSE
INT g_wanted_level_choice = 5
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
BOOL g_vehicle_quick_entry_exit = FALSE
BOOL g_vehicle_horn_boost = FALSE
FLOAT g_horn_boost_speed = 10.0
BOOL g_vehicle_turbo = FALSE
INT g_vehicle_acceleration_level = 0
INT g_vehicle_grip_level = 0
BOOL g_vehicle_bulletproof_tyres = FALSE
BOOL g_vehicle_speedometer = FALSE
INT g_vehicle_speed_unit = 0
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
BOOL g_lsc_turbo = FALSE
BOOL g_lsc_xenon = FALSE
BOOL g_lsc_neon = FALSE
INT g_vehicle_spawn_choice = 0
INT g_vehicle_spawn_category = 0
INT g_dlc_vehicle_index = 0
BOOL g_vehicle_spawn_pending = FALSE
BOOL g_delete_previous_spawned_vehicle = TRUE
BOOL g_spawn_teleport_into_vehicle = FALSE
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
BOOL g_auto_waypoint = FALSE
BOOL g_auto_waypoint_seen = FALSE
VECTOR g_last_auto_waypoint = <<0.0, 0.0, 0.0>>
BOOL g_outfit_open = FALSE
INT g_outfit_item = 0
INT g_outfit_scroll = 0
BOOL g_ped_open = FALSE
INT g_ped_item = 0
INT g_ped_scroll = 0
INT g_ped_choice = 0
BOOL g_ped_search_not_found = FALSE
BOOL g_ped_search_has_value = FALSE
STRING g_ped_search_value = ""
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
VEHICLE_INDEX g_menu_train
BOOL g_everyone_ignores = FALSE
BOOL g_low_population = FALSE
BOOL g_hud_hidden = FALSE
BOOL g_radar_hidden = FALSE
BOOL g_first_person = FALSE
BOOL g_block_phone_hangup = FALSE
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
SCALEFORM_INDEX g_instructional_scaleform = NULL

CONST_FLOAT MENU_W 0.250
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

PROC DRAW_INSTRUCTIONAL_BUTTONS()
    IF g_instructional_scaleform = NULL
        g_instructional_scaleform = REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS")
    ENDIF
    IF NOT HAS_SCALEFORM_MOVIE_LOADED(g_instructional_scaleform)
        EXIT
    ENDIF
    BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "TOGGLE_MOUSE_BUTTONS")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(TRUE)
    END_SCALEFORM_MOVIE_METHOD()
    CALL_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "CLEAR_ALL")
    BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(0)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE))
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("Select")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUT_FRONTEND_ACCEPT))
    END_SCALEFORM_MOVIE_METHOD()
    BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(1)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL, TRUE))
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("Back")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUT_FRONTEND_CANCEL))
    END_SCALEFORM_MOVIE_METHOD()
    BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(2)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUTGROUP_FRONTEND_DPAD_ALL, TRUE))
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("Move")
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
        SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUTGROUP_FRONTEND_DPAD_ALL))
    END_SCALEFORM_MOVIE_METHOD()
    BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    END_SCALEFORM_MOVIE_METHOD()
    DRAW_SCALEFORM_MOVIE_FULLSCREEN(g_instructional_scaleform, 255, 255, 255, 220, 0)
ENDPROC

PROC MENU_DESCRIPTION_TEXT(STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.3, 0.3)
    SET_TEXT_COLOUR(205, 212, 220, 255)
    SET_TEXT_WRAP(g_menu_x - 0.130, g_menu_x + 0.105)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 150)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.130, 0.594 + g_menu_y)
ENDPROC

PROC DRAW_SELECTED_DESCRIPTION()
    STRING description = "Select an option."
    IF g_home
        SWITCH g_item
            CASE 0 description = "Player abilities, appearance, and character tools." BREAK
            CASE 1 description = "Give, refill, and modify your weapons and ammunition." BREAK
            CASE 2 description = "Control wanted level, police behavior, and dispatch." BREAK
            CASE 3 description = "Spawn, enter, repair, and customize vehicles." BREAK
            CASE 4 description = "Change time, weather, vision, and camera effects." BREAK
            CASE 5 description = "Enable the portable radio and change stations." BREAK
            CASE 6 description = "Teleport to map targets and fixed locations." BREAK
            CASE 7 description = "World population, NPC, HUD, and phone options." BREAK
            CASE 8 description = "Menu colors, position, and custom respawn behavior." BREAK
        ENDSWITCH
    ELIF g_outfit_open
        description = "Cycle the selected clothing slot with Left/Right; press A to change its texture."
    ELIF g_ped_open
        IF g_item = 0 description = "Search by PED model name; the result is applied when found." ENDIF
        IF g_item = 1 description = "Switch between Franklin, Michael, and Trevor saved PED profiles." ENDIF
        IF g_item >= 2 description = "Apply the selected PED model to the player." ENDIF
    ELIF g_spawner_open
        SWITCH g_item
            CASE 0 description = "Spawn the selected vehicle, using the configured count and layout." BREAK
            CASE 1 description = "Choose a base-game, DLC, aircraft, bike, or watercraft list." BREAK
            CASE 2 description = "Choose the model to spawn; DLC entries follow the installed content." BREAK
            CASE 3 description = "Set how many copies to create, from one to the maximum." BREAK
            CASE 4 description = "Apply the highest available upgrade to every spawned vehicle." BREAK
            CASE 5 description = "Choose door-to-door or bumper-to-bumper formation." BREAK
            CASE 6 description = "Choose the heading of spawned vehicles relative to the player." BREAK
            CASE 7 description = "Automatically remove the previous custom vehicle when spawning." BREAK
            CASE 8 description = "Delete every vehicle created by this menu." BREAK
            CASE 9 description = "Enter a spawned vehicle automatically after it is created." BREAK
            CASE 10 description = "Search an installed vehicle model by name and spawn it." BREAK
        ENDSWITCH
    ELIF g_lsc_open
        SWITCH g_item
            CASE 0 description = "Apply the best available upgrade in every supported mod slot." BREAK
            CASE 1 description = "Select the vehicle modification slot shown by the rows below." BREAK
            CASE 2 description = "Cycle and apply the available variant for the selected slot." BREAK
            CASE 3 description = "Shows how many variants the current slot provides." BREAK
            CASE 4 description = "Set the primary paint color." BREAK
            CASE 5 description = "Set the secondary paint color." BREAK
            CASE 6 description = "Set the pearlescent paint color." BREAK
            CASE 7 description = "Set the wheel paint color." BREAK
            CASE 8 description = "Change the vehicle wheel family." BREAK
            CASE 9 description = "Toggle the turbo modification." BREAK
            CASE 10 description = "Toggle xenon headlights." BREAK
            CASE 11 description = "Choose the xenon headlight color." BREAK
            CASE 12 description = "Toggle all four neon tubes." BREAK
            CASE 13 description = "Choose the neon light color." BREAK
            CASE 14 description = "Remove the currently selected slot's modification." BREAK
        ENDSWITCH
    ELSE
        SWITCH g_tab
            CASE 0
                SWITCH g_item
                    CASE 0 description = "Make the player immune to damage." BREAK
                    CASE 1 description = "Restore health and armor to full." BREAK
                    CASE 2 description = "Hide the player model from the world." BREAK
                    CASE 3 description = "Prevent the player from ragdolling." BREAK
                    CASE 4 description = "Increase running speed." BREAK
                    CASE 5 description = "Increase swimming speed." BREAK
                    CASE 6 description = "Allow the player to jump higher." BREAK
                    CASE 7 description = "Apply the drunk movement style." BREAK
                    CASE 8 description = "Make melee impacts explosive." BREAK
                    CASE 9 description = "Edit the cash value used by Apply Cash Balance." BREAK
                    CASE 10 description = "Write the selected cash value to the active character." BREAK
                    CASE 11 description = "Choose the model used for spawned attackers." BREAK
                    CASE 12 description = "Choose the weapon given to spawned attackers." BREAK
                    CASE 13 description = "Spawn an armed hostile attacker nearby." BREAK
                    CASE 14 description = "Keep a parachute available whenever needed." BREAK
                    CASE 15 description = "Open the clothing and apparel editor." BREAK
                    CASE 16 description = "Open the searchable PED model selector." BREAK
                    CASE 17 description = "Remove blood, wetness, dirt, and visible damage from the player." BREAK
                    CASE 18 description = "Set the player's health to zero." BREAK
                    CASE 19 description = "Keep the player's underwater air supply full." BREAK
                    CASE 20 description = "Keep the character's special ability charged." BREAK
                ENDSWITCH
                BREAK
            CASE 1
                SWITCH g_item
                    CASE 0 description = "Give every supported base-game and installed DLC weapon." BREAK
                    CASE 1 description = "Choose one weapon with Left/Right, then press A to give it." BREAK
                    CASE 2 description = "Keep the player's ammunition from running out." BREAK
                    CASE 3 description = "Refill ammunition for every weapon the player owns." BREAK
                    CASE 4 description = "Remove every weapon from the player." BREAK
                    CASE 5 description = "Make fired bullets create explosive impacts." BREAK
                    CASE 6 description = "Make fired bullets ignite their targets." BREAK
                    CASE 7 description = "Remove the weapon currently selected in the weapon wheel." BREAK
                    CASE 8 description = "Prevent the current magazine from being depleted." BREAK
                ENDSWITCH
                BREAK
            CASE 2
                SWITCH g_item
                    CASE 0 description = "Continuously clear the player's wanted level." BREAK
                    CASE 1 description = "Clear the current wanted level immediately." BREAK
                    CASE 2 description = "Choose a wanted level from one to five, then apply it." BREAK
                    CASE 3 description = "Make police ignore the player." BREAK
                    CASE 4 description = "Enable or disable police and emergency dispatch services." BREAK
                    CASE 5 description = "Enable or disable civilian reports to police." BREAK
                ENDSWITCH
                BREAK
            CASE 3
                SWITCH g_item
                    CASE 0 description = "Open the vehicle spawner and choose a vehicle to create." BREAK
                    CASE 1 description = "Enter the personal vehicle marked by the game." BREAK
                    CASE 2 description = "Skip entry and exit animations when entering or leaving vehicles." BREAK
                    CASE 3 description = "Apply the highest available upgrade to the occupied vehicle." BREAK
                    CASE 4 description = "Show the occupied vehicle's current speed." BREAK
                    CASE 5 description = "Choose MPH or KMPH for the speedometer." BREAK
                    CASE 6 description = "Open the LS Customs modification and paint editor." BREAK
                    CASE 7 description = "Make the occupied vehicle immune to damage." BREAK
                    CASE 8 description = "Repair damage to the occupied vehicle immediately." BREAK
                    CASE 9 description = "Repair the occupied vehicle continuously." BREAK
                    CASE 10 description = "Set the occupied vehicle upright on the ground." BREAK
                    CASE 11 description = "Destroy the occupied vehicle's engine." BREAK
                    CASE 12 description = "Lock or unlock the occupied vehicle's doors." BREAK
                    CASE 13 description = "Prevent ejection from crashes; X is still used to exit." BREAK
                    CASE 14 description = "Increase vehicle acceleration from stock through 200x." BREAK
                    CASE 15 description = "Hold the horn to apply a forward boost." BREAK
                    CASE 16 description = "Adjust tyre grip from reduced grip through high grip." BREAK
                    CASE 17 description = "Prevent tyres from bursting." BREAK
                    CASE 18 description = "Toggle the vehicle's turbo modification." BREAK
                    CASE 19 description = "Spawn the story train if needed and enter the driver seat." BREAK
                    CASE 20 description = "Bring the player's story-mode personal vehicle to the current location and enter it." BREAK
                ENDSWITCH
                BREAK
            CASE 4
                SWITCH g_item
                    CASE 0 description = "Choose a time of day and press A to apply it." BREAK
                    CASE 1 description = "Choose weather and press A to apply it persistently." BREAK
                    CASE 2 description = "Toggle night vision." BREAK
                    CASE 3 description = "Toggle thermal vision." BREAK
                    CASE 4 description = "Apply or clear the CCTV scanline filter." BREAK
                    CASE 5 description = "Start or stop the gameplay camera shake effect." BREAK
                    CASE 6 description = "Set the editable hour; Left/Right changes it immediately." BREAK
                    CASE 7 description = "Set the editable minute; Left/Right changes it immediately." BREAK
                    CASE 8 description = "Set the editable second; Left/Right changes it immediately." BREAK
                    CASE 9 description = "Freeze or resume the world clock." BREAK
                    CASE 10 description = "Choose a safe story-mode IPL preset." BREAK
                    CASE 11 description = "Request the selected IPL preset." BREAK
                    CASE 12 description = "Remove the selected IPL preset." BREAK
                    CASE 13 description = "Enter an IPL name with the Switch keyboard." BREAK
                    CASE 14 description = "Request the custom IPL name." BREAK
                    CASE 15 description = "Remove the custom IPL name." BREAK
                ENDSWITCH
                BREAK
            CASE 5
                SWITCH g_item
                    CASE 0 description = "Enable portable radio control while on foot." BREAK
                    CASE 1 description = "Tune the radio to the previous station." BREAK
                    CASE 2 description = "Tune the radio to the next station." BREAK
                ENDSWITCH
                BREAK
            CASE 6
                SWITCH g_item
                    CASE 0 description = "Teleport to the active map waypoint." BREAK
                    CASE 1 description = "Teleport to the nearest active objective marker." BREAK
                    CASE 2 description = "Automatically teleport when a new waypoint is placed." BREAK
                    CASE 3 description = "Teleport to the summit of Mount Chiliad." BREAK
                    CASE 4 description = "Teleport to Maze Bank Tower." BREAK
                    CASE 5 description = "Teleport to Los Santos International Airport." BREAK
                    CASE 6 description = "Teleport to the Vinewood Sign." BREAK
                    CASE 7 description = "Teleport to Fort Zancudo." BREAK
                    CASE 8 description = "Teleport to Grove Street." BREAK
                    CASE 9 description = "Teleport to Franklin's house." BREAK
                    CASE 10 description = "Teleport to Michael's house." BREAK
                    CASE 11 description = "Teleport to Trevor's trailer." BREAK
                    CASE 12 description = "Teleport to Lester's warehouse." BREAK
                    CASE 13 description = "Teleport to Simeon's dealership." BREAK
                    CASE 14 description = "Teleport to the hospital." BREAK
                    CASE 15 description = "Teleport to the police station." BREAK
                    CASE 16 description = "Teleport to an Ammu-Nation store." BREAK
                    CASE 17 description = "Teleport to Los Santos Customs." BREAK
                    CASE 18 description = "Load the North Yankton area and teleport there." BREAK
                    CASE 19 description = "Load the Cayo Perico area and teleport there." BREAK
                    CASE 20 description = "Teleport to Sandy Shores Airfield." BREAK
                    CASE 21 description = "Teleport to the IAA Building." BREAK
                    CASE 22 description = "Teleport to Mount Gordo." BREAK
                    CASE 23 description = "Enter the X coordinate for a custom teleport." BREAK
                    CASE 24 description = "Enter the Y coordinate for a custom teleport." BREAK
                    CASE 25 description = "Enter the Z coordinate for a custom teleport." BREAK
                    CASE 26 description = "Teleport the player or occupied vehicle to the entered coordinates." BREAK
                ENDSWITCH
                BREAK
            CASE 7
                SWITCH g_item
                    CASE 0 description = "Make nearby non-player characters fight each other." BREAK
                    CASE 1 description = "Make everyone ignore the player." BREAK
                    CASE 2 description = "Reduce ambient pedestrian and vehicle population." BREAK
                    CASE 3 description = "Hide the normal HUD." BREAK
                    CASE 4 description = "Hide the minimap and radar." BREAK
                    CASE 5 description = "Force the camera into first-person view." BREAK
                    CASE 6 description = "Remove nearby vehicles within the cleanup radius." BREAK
                    CASE 7 description = "Remove nearby peds and menu-spawned attackers." BREAK
                    CASE 8 description = "Prevent B from hanging up an active phone call." BREAK
                ENDSWITCH
                BREAK
            CASE 8
                SWITCH g_item
                    CASE 0 description = "Choose the menu accent color." BREAK
                    CASE 1 description = "Choose where custom death respawns place the player." BREAK
                    CASE 2 description = "Enable automatic respawn at the selected location." BREAK
                    CASE 3 description = "Move the menu horizontally." BREAK
                    CASE 4 description = "Move the menu vertically." BREAK
                ENDSWITCH
                BREAK
        ENDSWITCH
    ENDIF
    MENU_DESCRIPTION_TEXT(description)
ENDPROC

PROC DRAW_DESCRIPTION_PANEL()
    DRAW_RECT(g_menu_x - 0.015, 0.578 + g_menu_y, MENU_W - 0.012, 0.002, 100, 108, 118, 220)
    DRAW_RECT(g_menu_x - 0.015, 0.620 + g_menu_y, MENU_W - 0.012, 0.054, 8, 9, 12, 205)
    DRAW_SELECTED_DESCRIPTION()
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
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    IF state = 0
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 255, 100, 100, value)
    ELIF state = 1
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 95, 245, 150, value)
    ELSE
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 210, 230, 255, value)
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
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("NUMBER")
        ADD_TEXT_COMPONENT_INTEGER(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_FLOAT_OPTION(FLOAT y, STRING label, FLOAT value, BOOL selected)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        rr = g_accent_r
        gg = g_accent_g
        bb = g_accent_b
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_FLOAT(value, 2)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
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
    IF g_attacker_spawn_pending OR g_menu_attacker_count >= COUNT_OF(g_menu_attackers) EXIT ENDIF
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
        IF g_menu_attacker_count < 32
            g_menu_attackers[g_menu_attacker_count] = attacker
            g_menu_attacker_count = g_menu_attacker_count + 1
        ENDIF
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
    g_attacker_spawn_pending = FALSE
ENDPROC

PROC CLEAR_MENU_ATTACKERS()
    INT index = 0
    REPEAT g_menu_attacker_count index
        IF DOES_ENTITY_EXIST(g_menu_attackers[index])
            SET_ENTITY_AS_MISSION_ENTITY(g_menu_attackers[index], TRUE, TRUE)
            DELETE_PED(g_menu_attackers[index])
        ENDIF
    ENDREPEAT
    g_menu_attacker_count = 0
ENDPROC

PROC TELEPORT_PLAYER_WITH_VEHICLE(VECTOR destination)
    g_pending_teleport_destination = destination
    g_teleport_request_time = GET_GAME_TIMER()
    g_teleport_pending = TRUE
    REQUEST_COLLISION_AT_COORD(destination)
    NEW_LOAD_SCENE_START_SPHERE(destination, 250.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
ENDPROC

PROC FINISH_PENDING_TELEPORT()
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        SET_ENTITY_COORDS(GET_VEHICLE_PED_IS_IN(playerPed), g_pending_teleport_destination)
    ELSE
        SET_ENTITY_COORDS(playerPed, g_pending_teleport_destination)
    ENDIF
    REQUEST_COLLISION_AT_COORD(g_pending_teleport_destination)
    IF IS_NEW_LOAD_SCENE_ACTIVE()
        NEW_LOAD_SCENE_STOP()
    ENDIF
    g_teleport_pending = FALSE
ENDPROC

PROC PROCESS_PENDING_TELEPORT()
    IF NOT g_teleport_pending EXIT ENDIF
    REQUEST_COLLISION_AT_COORD(g_pending_teleport_destination)
    IF IS_NEW_LOAD_SCENE_LOADED() OR GET_GAME_TIMER() > g_teleport_request_time + 6000
        FINISH_PENDING_TELEPORT()
    ENDIF
ENDPROC

FUNC BOOL TELEPORT_TO_BLIP_TYPE(BLIP_SPRITE sprite)
    BLIP_INDEX blip = GET_CLOSEST_BLIP_INFO_ID(sprite)
    IF DOES_BLIP_EXIST(blip)
        TELEPORT_PLAYER_WITH_VEHICLE(GET_BLIP_COORDS(blip))
        RETURN TRUE
    ENDIF
    RETURN FALSE
ENDFUNC

PROC TELEPORT_TO_WAYPOINT()
    IF IS_WAYPOINT_ACTIVE()
        TELEPORT_TO_BLIP_TYPE(GET_WAYPOINT_BLIP_ENUM_ID())
    ENDIF
ENDPROC

PROC TELEPORT_TO_OBJECTIVE()
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_BLUE) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_YELLOW) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_GREEN) EXIT ENDIF
    TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_RED)
ENDPROC

PROC TELEPORT_TO_ENTERED_COORDS()
    TELEPORT_PLAYER_WITH_VEHICLE(<<g_teleport_x, g_teleport_y, g_teleport_z>>)
ENDPROC

PROC BRING_PERSONAL_VEHICLE()
    VEHICLE_INDEX vehicle = GET_PLAYERS_LAST_VEHICLE()
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    VECTOR playerPosition = GET_ENTITY_COORDS(PLAYER_PED_ID())
    SET_ENTITY_AS_MISSION_ENTITY(vehicle, TRUE, TRUE)
    SET_ENTITY_COORDS(vehicle, <<playerPosition.x, playerPosition.y, playerPosition.z + 1.0>>)
    SET_ENTITY_HEADING(vehicle, GET_ENTITY_HEADING(PLAYER_PED_ID()))
    SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), vehicle, VS_DRIVER)
ENDPROC

PROC CLEAR_PLAYER_DAMAGE_MARKS()
    PED_INDEX playerPed = PLAYER_PED_ID()
    CLEAR_PED_BLOOD_DAMAGE(playerPed)
    CLEAR_PED_WETNESS(playerPed)
    CLEAR_PED_ENV_DIRT(playerPed)
    RESET_PED_VISIBLE_DAMAGE(playerPed)
ENDPROC

PROC APPLY_UNLIMITED_OXYGEN()
    IF g_unlimited_oxygen
        SET_PED_MAX_TIME_UNDERWATER(PLAYER_PED_ID(), 2147483647)
    ELSE
        SET_PED_MAX_TIME_UNDERWATER(PLAYER_PED_ID(), -1.0)
    ENDIF
ENDPROC

PROC APPLY_UNLIMITED_ABILITY()
    IF g_unlimited_ability
        SPECIAL_ABILITY_CHARGE_ABSOLUTE(PLAYER_ID(), 200, TRUE, 0)
    ENDIF
ENDPROC

PROC PREPARE_NORTH_YANKTON()
    REQUEST_IPL("prologue01")
    REQUEST_IPL("prologue01c")
    REQUEST_IPL("prologue01d")
    REQUEST_IPL("prologue01e")
    REQUEST_IPL("prologue01f")
    REQUEST_IPL("prologue01g")
    REQUEST_IPL("prologue01h")
    REQUEST_IPL("prologue01i")
    REQUEST_IPL("prologue01j")
    REQUEST_IPL("prologue01k")
    REQUEST_IPL("prologue01z")
    REQUEST_IPL("prologue02")
    REQUEST_IPL("prologue03")
    REQUEST_IPL("prologue03b")
    REQUEST_IPL("prologue04")
    REQUEST_IPL("prologue04b")
    REQUEST_IPL("prologue05")
    REQUEST_IPL("prologue05b")
    REQUEST_IPL("prologue06")
    REQUEST_IPL("prologue06b")
    REQUEST_IPL("prologue06_int")
    REQUEST_IPL("prologue06_pannel")
    REQUEST_IPL("prologuerd")
    REQUEST_IPL("prologuerdb")
    SET_MINIMAP_IN_PROLOGUE(TRUE)
    NEW_LOAD_SCENE_START_SPHERE(<<5311.0, -5206.0, 83.0>>, 1200.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
ENDPROC

FUNC BOOL PREPARE_CAYO_PERICO()
    IF NOT IS_DLC_PRESENT(HASH("mpheist4")) RETURN FALSE ENDIF
    SET_ISLAND_ENABLED("HeistIsland", TRUE)
    SET_ALLOW_STREAM_HEIST_ISLAND_NODES(TRUE)
    SET_USE_ISLAND_MAP(TRUE)
    LOAD_GLOBAL_WATER_FILE(1)
    SET_DEEP_OCEAN_SCALER(0.0)
    NEW_LOAD_SCENE_START_SPHERE(<<5014.21, -5134.19, 2.5>>, 1400.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
    RETURN TRUE
ENDFUNC

PROC TELEPORT_TO_NORTH_YANKTON()
    PREPARE_NORTH_YANKTON()
    TELEPORT_PLAYER_WITH_VEHICLE(<<5311.0, -5206.0, 83.0>>)
ENDPROC

PROC TELEPORT_TO_CAYO_PERICO()
    IF PREPARE_CAYO_PERICO()
        TELEPORT_PLAYER_WITH_VEHICLE(<<5014.21, -5134.19, 2.5>>)
    ENDIF
ENDPROC

PROC PREPARE_TELEPORT_IPL(INT location)
    SWITCH location
        CASE 11
            REQUEST_IPL("TrevorsTrailer")
        BREAK
        CASE 14
            REQUEST_IPL("rc12b_hospitalinterior")
            REMOVE_IPL("rc12b_default")
        BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_IPL_PRESET(BOOL load)
    IF g_ipl_preset = 0
        IF load REQUEST_IPL("TrevorsTrailer") ELSE REMOVE_IPL("TrevorsTrailer") ENDIF
    ELIF g_ipl_preset = 1
        IF load REQUEST_IPL("FIBlobby") ELSE REMOVE_IPL("FIBlobby") ENDIF
    ELIF g_ipl_preset = 2
        IF load REQUEST_IPL("FruitBB") ELSE REMOVE_IPL("FruitBB") ENDIF
    ELIF g_ipl_preset = 3
        IF load REQUEST_IPL("post_hiest_unload") ELSE REMOVE_IPL("post_hiest_unload") ENDIF
    ELIF g_ipl_preset = 4
        IF load REQUEST_IPL("farmint") ELSE REMOVE_IPL("farmint") ENDIF
    ELIF g_ipl_preset = 5
        IF load REQUEST_IPL("facelobby") ELSE REMOVE_IPL("facelobby") ENDIF
    ELIF g_ipl_preset = 6
        IF load REQUEST_IPL("Coroner_Int_on") ELSE REMOVE_IPL("Coroner_Int_on") ENDIF
    ELIF g_ipl_preset = 7
        IF load REQUEST_IPL("bh1_47_joshhse_unload") ELSE REMOVE_IPL("bh1_47_joshhse_unload") ENDIF
    ELIF g_ipl_preset = 8
        IF load REQUEST_IPL("apa_v_mp_h_01_a") ELSE REMOVE_IPL("apa_v_mp_h_01_a") ENDIF
    ELIF g_ipl_preset = 9
        IF load REQUEST_IPL("chopshop") ELSE REMOVE_IPL("chopshop") ENDIF
    ELIF g_ipl_preset = 10
        IF load REQUEST_IPL("prologue01") ELSE REMOVE_IPL("prologue01") ENDIF
    ELIF g_ipl_preset = 11
        IF load REQUEST_IPL("prologue02") ELSE REMOVE_IPL("prologue02") ENDIF
    ELIF g_ipl_preset = 12
        IF load
            PREPARE_NORTH_YANKTON()
        ELSE
            REMOVE_IPL("prologue01")
            REMOVE_IPL("prologue01c")
            REMOVE_IPL("prologue01d")
            REMOVE_IPL("prologue01e")
            REMOVE_IPL("prologue01f")
            REMOVE_IPL("prologue01g")
            REMOVE_IPL("prologue01h")
            REMOVE_IPL("prologue01i")
            REMOVE_IPL("prologue01j")
            REMOVE_IPL("prologue01k")
            REMOVE_IPL("prologue01z")
            REMOVE_IPL("prologue02")
            REMOVE_IPL("prologue03")
            REMOVE_IPL("prologue03b")
            REMOVE_IPL("prologue04")
            REMOVE_IPL("prologue04b")
            REMOVE_IPL("prologue05")
            REMOVE_IPL("prologue05b")
            REMOVE_IPL("prologue06")
            REMOVE_IPL("prologue06b")
            REMOVE_IPL("prologue06_int")
            REMOVE_IPL("prologue06_pannel")
            REMOVE_IPL("prologuerd")
            REMOVE_IPL("prologuerdb")
            SET_MINIMAP_IN_PROLOGUE(FALSE)
        ENDIF
    ELIF g_ipl_preset = 13
        IF load
            PREPARE_CAYO_PERICO()
        ELSE
            SET_ISLAND_ENABLED("HeistIsland", FALSE)
            SET_ALLOW_STREAM_HEIST_ISLAND_NODES(FALSE)
            SET_USE_ISLAND_MAP(FALSE)
            LOAD_GLOBAL_WATER_FILE(0)
            RESET_DEEP_OCEAN_SCALER()
        ENDIF
    ELIF g_ipl_preset = 14
        IF load
            REQUEST_IPL("smboat")
            REQUEST_IPL("apa_smboat_lodlights")
            REQUEST_IPL("ba_sm_boat_window")
        ELSE
            REMOVE_IPL("smboat")
            REMOVE_IPL("apa_smboat_lodlights")
            REMOVE_IPL("ba_sm_boat_window")
        ENDIF
    ELIF g_ipl_preset = 15
        IF load
            REQUEST_IPL("hei_carrier_lodlights")
            REQUEST_IPL("hei_carrier")
            REQUEST_IPL("hei_carrier_int1")
            REQUEST_IPL("hei_carrier_int2")
            REQUEST_IPL("hei_carrier_int3")
            REQUEST_IPL("hei_carrier_int4")
            REQUEST_IPL("hei_carrier_int5")
            REQUEST_IPL("hei_carrier_int6")
        ELSE
            REMOVE_IPL("hei_carrier_lodlights")
            REMOVE_IPL("hei_carrier")
            REMOVE_IPL("hei_carrier_int1")
            REMOVE_IPL("hei_carrier_int2")
            REMOVE_IPL("hei_carrier_int3")
            REMOVE_IPL("hei_carrier_int4")
            REMOVE_IPL("hei_carrier_int5")
            REMOVE_IPL("hei_carrier_int6")
        ENDIF
    ELIF g_ipl_preset = 16
        IF load
            REQUEST_IPL("sunk_ship_fire")
            REQUEST_IPL("sunkcargoship")
            REMOVE_IPL("cargoship")
        ELSE
            REMOVE_IPL("sunk_ship_fire")
            REMOVE_IPL("sunkcargoship")
            REQUEST_IPL("cargoship")
        ENDIF
    ELIF g_ipl_preset = 17
        IF load
            REQUEST_IPL("rc12b_hospitalinterior")
            REMOVE_IPL("rc12b_default")
        ELSE
            REMOVE_IPL("rc12b_hospitalinterior")
            REQUEST_IPL("rc12b_default")
        ENDIF
    ELIF g_ipl_preset = 18
        IF load
            REQUEST_IPL("farm_burnt")
            REQUEST_IPL("farm_burnt_props")
        ELSE
            REMOVE_IPL("farm_burnt")
            REMOVE_IPL("farm_burnt_props")
        ENDIF
    ELIF g_ipl_preset = 19
        IF load
            REQUEST_IPL("facelobby")
            REQUEST_IPL("facelobbyfake")
        ELSE
            REMOVE_IPL("facelobby")
            REMOVE_IPL("facelobbyfake")
        ENDIF
    ELIF g_ipl_preset = 20
        IF load
            REQUEST_IPL("post_hiest_unload")
            REQUEST_IPL("jewel2fake")
            REQUEST_IPL("bh1_16_refurb")
        ELSE
            REMOVE_IPL("post_hiest_unload")
            REMOVE_IPL("jewel2fake")
            REMOVE_IPL("bh1_16_refurb")
        ENDIF
    ELIF g_ipl_preset = 21
        IF load
            REQUEST_IPL("coroner_int_on")
            REQUEST_IPL("coronertrash")
            REMOVE_IPL("coroner_int_off")
        ELSE
            REMOVE_IPL("coroner_int_on")
            REMOVE_IPL("coronertrash")
            REQUEST_IPL("coroner_int_off")
        ENDIF
    ENDIF
ENDPROC

PROC LOAD_CUSTOM_IPL()
    IF NOT IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name)
        REQUEST_IPL(g_custom_ipl_name)
    ENDIF
ENDPROC

PROC UNLOAD_CUSTOM_IPL()
    IF NOT IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name)
        REMOVE_IPL(g_custom_ipl_name)
    ENDIF
ENDPROC

PROC SPAWN_OR_ENTER_TRAIN()
    IF DOES_ENTITY_EXIST(g_menu_train)
        SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), g_menu_train, VS_DRIVER)
        EXIT
    ENDIF
    g_menu_train = CREATE_MISSION_TRAIN(0, <<489.2, -1858.2, 27.5>>, TRUE)
    IF DOES_ENTITY_EXIST(g_menu_train)
        SET_ENTITY_AS_MISSION_ENTITY(g_menu_train, TRUE, TRUE)
        SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), g_menu_train, VS_DRIVER)
    ENDIF
ENDPROC

FUNC INT PED_CHOICE_COUNT()
    RETURN 683
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_0(INT choice)
    SWITCH choice
        CASE 0 RETURN A_C_BOAR BREAK
        CASE 1 RETURN A_C_CAT_01 BREAK
        CASE 2 RETURN A_C_CHICKENHAWK BREAK
        CASE 3 RETURN A_C_CHIMP BREAK
        CASE 4 RETURN A_C_CHOP BREAK
        CASE 5 RETURN A_C_CORMORANT BREAK
        CASE 6 RETURN A_C_COW BREAK
        CASE 7 RETURN A_C_COYOTE BREAK
        CASE 8 RETURN A_C_CROW BREAK
        CASE 9 RETURN A_C_DEER BREAK
        CASE 10 RETURN A_C_DOLPHIN BREAK
        CASE 11 RETURN A_C_FISH BREAK
        CASE 12 RETURN A_C_HEN BREAK
        CASE 13 RETURN A_C_HUMPBACK BREAK
        CASE 14 RETURN A_C_HUSKY BREAK
        CASE 15 RETURN A_C_KILLERWHALE BREAK
        CASE 16 RETURN A_C_MTLION BREAK
        CASE 17 RETURN A_C_PIG BREAK
        CASE 18 RETURN A_C_PIGEON BREAK
        CASE 19 RETURN A_C_POODLE BREAK
        CASE 20 RETURN A_C_PUG BREAK
        CASE 21 RETURN A_C_RABBIT_01 BREAK
        CASE 22 RETURN A_C_RAT BREAK
        CASE 23 RETURN A_C_RETRIEVER BREAK
        CASE 24 RETURN A_C_RHESUS BREAK
        CASE 25 RETURN A_C_ROTTWEILER BREAK
        CASE 26 RETURN A_C_SEAGULL BREAK
        CASE 27 RETURN A_C_SHARKHAMMER BREAK
        CASE 28 RETURN A_C_SHARKTIGER BREAK
        CASE 29 RETURN A_C_SHEPHERD BREAK
        CASE 30 RETURN A_C_STINGRAY BREAK
        CASE 31 RETURN A_C_WESTY BREAK
        CASE 32 RETURN A_F_M_BEACH_01 BREAK
        CASE 33 RETURN A_F_M_BEVHILLS_01 BREAK
        CASE 34 RETURN A_F_M_BEVHILLS_02 BREAK
        CASE 35 RETURN A_F_M_BODYBUILD_01 BREAK
        CASE 36 RETURN A_F_M_BUSINESS_02 BREAK
        CASE 37 RETURN A_F_M_DOWNTOWN_01 BREAK
        CASE 38 RETURN A_F_M_EASTSA_01 BREAK
        CASE 39 RETURN A_F_M_EASTSA_02 BREAK
        CASE 40 RETURN A_F_M_FATBLA_01 BREAK
        CASE 41 RETURN A_F_M_FATCULT_01 BREAK
        CASE 42 RETURN A_F_M_FATWHITE_01 BREAK
        CASE 43 RETURN A_F_M_KTOWN_01 BREAK
        CASE 44 RETURN A_F_M_KTOWN_02 BREAK
        CASE 45 RETURN A_F_M_PROLHOST_01 BREAK
        CASE 46 RETURN A_F_M_SALTON_01 BREAK
        CASE 47 RETURN A_F_M_SKIDROW_01 BREAK
        CASE 48 RETURN A_F_M_SOUCENTMC_01 BREAK
        CASE 49 RETURN A_F_M_SOUCENT_01 BREAK
        CASE 50 RETURN A_F_M_SOUCENT_02 BREAK
        CASE 51 RETURN A_F_M_TOURIST_01 BREAK
        CASE 52 RETURN A_F_M_TRAMPBEAC_01 BREAK
        CASE 53 RETURN A_F_M_TRAMP_01 BREAK
        CASE 54 RETURN A_F_O_GENSTREET_01 BREAK
        CASE 55 RETURN A_F_O_INDIAN_01 BREAK
        CASE 56 RETURN A_F_O_KTOWN_01 BREAK
        CASE 57 RETURN A_F_O_SALTON_01 BREAK
        CASE 58 RETURN A_F_O_SOUCENT_01 BREAK
        CASE 59 RETURN A_F_O_SOUCENT_02 BREAK
        CASE 60 RETURN A_F_Y_BEACH_01 BREAK
        CASE 61 RETURN A_F_Y_BEVHILLS_01 BREAK
        CASE 62 RETURN A_F_Y_BEVHILLS_02 BREAK
        CASE 63 RETURN A_F_Y_BEVHILLS_03 BREAK
        CASE 64 RETURN A_F_Y_BEVHILLS_04 BREAK
        CASE 65 RETURN A_F_Y_BUSINESS_01 BREAK
        CASE 66 RETURN A_F_Y_BUSINESS_02 BREAK
        CASE 67 RETURN A_F_Y_BUSINESS_03 BREAK
        CASE 68 RETURN A_F_Y_BUSINESS_04 BREAK
        CASE 69 RETURN A_F_Y_EASTSA_01 BREAK
        CASE 70 RETURN A_F_Y_EASTSA_02 BREAK
        CASE 71 RETURN A_F_Y_EASTSA_03 BREAK
        CASE 72 RETURN A_F_Y_EPSILON_01 BREAK
        CASE 73 RETURN A_F_Y_FITNESS_01 BREAK
        CASE 74 RETURN A_F_Y_FITNESS_02 BREAK
        CASE 75 RETURN A_F_Y_GENHOT_01 BREAK
        CASE 76 RETURN A_F_Y_GOLFER_01 BREAK
        CASE 77 RETURN A_F_Y_HIKER_01 BREAK
        CASE 78 RETURN A_F_Y_HIPPIE_01 BREAK
        CASE 79 RETURN A_F_Y_HIPSTER_01 BREAK
        CASE 80 RETURN A_F_Y_HIPSTER_02 BREAK
        CASE 81 RETURN A_F_Y_HIPSTER_03 BREAK
        CASE 82 RETURN A_F_Y_HIPSTER_04 BREAK
        CASE 83 RETURN A_F_Y_INDIAN_01 BREAK
        CASE 84 RETURN A_F_Y_JUGGALO_01 BREAK
        CASE 85 RETURN A_F_Y_RUNNER_01 BREAK
        CASE 86 RETURN A_F_Y_RURMETH_01 BREAK
        CASE 87 RETURN A_F_Y_SCDRESSY_01 BREAK
        CASE 88 RETURN A_F_Y_SKATER_01 BREAK
        CASE 89 RETURN A_F_Y_SOUCENT_01 BREAK
        CASE 90 RETURN A_F_Y_SOUCENT_02 BREAK
        CASE 91 RETURN A_F_Y_SOUCENT_03 BREAK
        CASE 92 RETURN A_F_Y_TENNIS_01 BREAK
        CASE 93 RETURN A_F_Y_TOPLESS_01 BREAK
        CASE 94 RETURN A_F_Y_TOURIST_01 BREAK
        CASE 95 RETURN A_F_Y_TOURIST_02 BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_0(INT choice)
    SWITCH choice
        CASE 0 RETURN "A_C_BOAR" BREAK
        CASE 1 RETURN "A_C_CAT_01" BREAK
        CASE 2 RETURN "A_C_CHICKENHAWK" BREAK
        CASE 3 RETURN "A_C_CHIMP" BREAK
        CASE 4 RETURN "A_C_CHOP" BREAK
        CASE 5 RETURN "A_C_CORMORANT" BREAK
        CASE 6 RETURN "A_C_COW" BREAK
        CASE 7 RETURN "A_C_COYOTE" BREAK
        CASE 8 RETURN "A_C_CROW" BREAK
        CASE 9 RETURN "A_C_DEER" BREAK
        CASE 10 RETURN "A_C_DOLPHIN" BREAK
        CASE 11 RETURN "A_C_FISH" BREAK
        CASE 12 RETURN "A_C_HEN" BREAK
        CASE 13 RETURN "A_C_HUMPBACK" BREAK
        CASE 14 RETURN "A_C_HUSKY" BREAK
        CASE 15 RETURN "A_C_KILLERWHALE" BREAK
        CASE 16 RETURN "A_C_MTLION" BREAK
        CASE 17 RETURN "A_C_PIG" BREAK
        CASE 18 RETURN "A_C_PIGEON" BREAK
        CASE 19 RETURN "A_C_POODLE" BREAK
        CASE 20 RETURN "A_C_PUG" BREAK
        CASE 21 RETURN "A_C_RABBIT_01" BREAK
        CASE 22 RETURN "A_C_RAT" BREAK
        CASE 23 RETURN "A_C_RETRIEVER" BREAK
        CASE 24 RETURN "A_C_RHESUS" BREAK
        CASE 25 RETURN "A_C_ROTTWEILER" BREAK
        CASE 26 RETURN "A_C_SEAGULL" BREAK
        CASE 27 RETURN "A_C_SHARKHAMMER" BREAK
        CASE 28 RETURN "A_C_SHARKTIGER" BREAK
        CASE 29 RETURN "A_C_SHEPHERD" BREAK
        CASE 30 RETURN "A_C_STINGRAY" BREAK
        CASE 31 RETURN "A_C_WESTY" BREAK
        CASE 32 RETURN "A_F_M_BEACH_01" BREAK
        CASE 33 RETURN "A_F_M_BEVHILLS_01" BREAK
        CASE 34 RETURN "A_F_M_BEVHILLS_02" BREAK
        CASE 35 RETURN "A_F_M_BODYBUILD_01" BREAK
        CASE 36 RETURN "A_F_M_BUSINESS_02" BREAK
        CASE 37 RETURN "A_F_M_DOWNTOWN_01" BREAK
        CASE 38 RETURN "A_F_M_EASTSA_01" BREAK
        CASE 39 RETURN "A_F_M_EASTSA_02" BREAK
        CASE 40 RETURN "A_F_M_FATBLA_01" BREAK
        CASE 41 RETURN "A_F_M_FATCULT_01" BREAK
        CASE 42 RETURN "A_F_M_FATWHITE_01" BREAK
        CASE 43 RETURN "A_F_M_KTOWN_01" BREAK
        CASE 44 RETURN "A_F_M_KTOWN_02" BREAK
        CASE 45 RETURN "A_F_M_PROLHOST_01" BREAK
        CASE 46 RETURN "A_F_M_SALTON_01" BREAK
        CASE 47 RETURN "A_F_M_SKIDROW_01" BREAK
        CASE 48 RETURN "A_F_M_SOUCENTMC_01" BREAK
        CASE 49 RETURN "A_F_M_SOUCENT_01" BREAK
        CASE 50 RETURN "A_F_M_SOUCENT_02" BREAK
        CASE 51 RETURN "A_F_M_TOURIST_01" BREAK
        CASE 52 RETURN "A_F_M_TRAMPBEAC_01" BREAK
        CASE 53 RETURN "A_F_M_TRAMP_01" BREAK
        CASE 54 RETURN "A_F_O_GENSTREET_01" BREAK
        CASE 55 RETURN "A_F_O_INDIAN_01" BREAK
        CASE 56 RETURN "A_F_O_KTOWN_01" BREAK
        CASE 57 RETURN "A_F_O_SALTON_01" BREAK
        CASE 58 RETURN "A_F_O_SOUCENT_01" BREAK
        CASE 59 RETURN "A_F_O_SOUCENT_02" BREAK
        CASE 60 RETURN "A_F_Y_BEACH_01" BREAK
        CASE 61 RETURN "A_F_Y_BEVHILLS_01" BREAK
        CASE 62 RETURN "A_F_Y_BEVHILLS_02" BREAK
        CASE 63 RETURN "A_F_Y_BEVHILLS_03" BREAK
        CASE 64 RETURN "A_F_Y_BEVHILLS_04" BREAK
        CASE 65 RETURN "A_F_Y_BUSINESS_01" BREAK
        CASE 66 RETURN "A_F_Y_BUSINESS_02" BREAK
        CASE 67 RETURN "A_F_Y_BUSINESS_03" BREAK
        CASE 68 RETURN "A_F_Y_BUSINESS_04" BREAK
        CASE 69 RETURN "A_F_Y_EASTSA_01" BREAK
        CASE 70 RETURN "A_F_Y_EASTSA_02" BREAK
        CASE 71 RETURN "A_F_Y_EASTSA_03" BREAK
        CASE 72 RETURN "A_F_Y_EPSILON_01" BREAK
        CASE 73 RETURN "A_F_Y_FITNESS_01" BREAK
        CASE 74 RETURN "A_F_Y_FITNESS_02" BREAK
        CASE 75 RETURN "A_F_Y_GENHOT_01" BREAK
        CASE 76 RETURN "A_F_Y_GOLFER_01" BREAK
        CASE 77 RETURN "A_F_Y_HIKER_01" BREAK
        CASE 78 RETURN "A_F_Y_HIPPIE_01" BREAK
        CASE 79 RETURN "A_F_Y_HIPSTER_01" BREAK
        CASE 80 RETURN "A_F_Y_HIPSTER_02" BREAK
        CASE 81 RETURN "A_F_Y_HIPSTER_03" BREAK
        CASE 82 RETURN "A_F_Y_HIPSTER_04" BREAK
        CASE 83 RETURN "A_F_Y_INDIAN_01" BREAK
        CASE 84 RETURN "A_F_Y_JUGGALO_01" BREAK
        CASE 85 RETURN "A_F_Y_RUNNER_01" BREAK
        CASE 86 RETURN "A_F_Y_RURMETH_01" BREAK
        CASE 87 RETURN "A_F_Y_SCDRESSY_01" BREAK
        CASE 88 RETURN "A_F_Y_SKATER_01" BREAK
        CASE 89 RETURN "A_F_Y_SOUCENT_01" BREAK
        CASE 90 RETURN "A_F_Y_SOUCENT_02" BREAK
        CASE 91 RETURN "A_F_Y_SOUCENT_03" BREAK
        CASE 92 RETURN "A_F_Y_TENNIS_01" BREAK
        CASE 93 RETURN "A_F_Y_TOPLESS_01" BREAK
        CASE 94 RETURN "A_F_Y_TOURIST_01" BREAK
        CASE 95 RETURN "A_F_Y_TOURIST_02" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_1(INT choice)
    SWITCH choice
        CASE 0 RETURN A_F_Y_VINEWOOD_01 BREAK
        CASE 1 RETURN A_F_Y_VINEWOOD_02 BREAK
        CASE 2 RETURN A_F_Y_VINEWOOD_03 BREAK
        CASE 3 RETURN A_F_Y_VINEWOOD_04 BREAK
        CASE 4 RETURN A_F_Y_YOGA_01 BREAK
        CASE 5 RETURN A_M_M_ACULT_01 BREAK
        CASE 6 RETURN A_M_M_AFRIAMER_01 BREAK
        CASE 7 RETURN A_M_M_BEACH_01 BREAK
        CASE 8 RETURN A_M_M_BEACH_02 BREAK
        CASE 9 RETURN A_M_M_BEVHILLS_01 BREAK
        CASE 10 RETURN A_M_M_BEVHILLS_02 BREAK
        CASE 11 RETURN A_M_M_BUSINESS_01 BREAK
        CASE 12 RETURN A_M_M_EASTSA_01 BREAK
        CASE 13 RETURN A_M_M_EASTSA_02 BREAK
        CASE 14 RETURN A_M_M_FARMER_01 BREAK
        CASE 15 RETURN A_M_M_FATLATIN_01 BREAK
        CASE 16 RETURN A_M_M_GENFAT_01 BREAK
        CASE 17 RETURN A_M_M_GENFAT_02 BREAK
        CASE 18 RETURN A_M_M_GOLFER_01 BREAK
        CASE 19 RETURN A_M_M_HASJEW_01 BREAK
        CASE 20 RETURN A_M_M_HILLBILLY_01 BREAK
        CASE 21 RETURN A_M_M_HILLBILLY_02 BREAK
        CASE 22 RETURN A_M_M_INDIAN_01 BREAK
        CASE 23 RETURN A_M_M_KTOWN_01 BREAK
        CASE 24 RETURN A_M_M_MALIBU_01 BREAK
        CASE 25 RETURN A_M_M_MEXCNTRY_01 BREAK
        CASE 26 RETURN A_M_M_MEXLABOR_01 BREAK
        CASE 27 RETURN A_M_M_OG_BOSS_01 BREAK
        CASE 28 RETURN A_M_M_PAPARAZZI_01 BREAK
        CASE 29 RETURN A_M_M_POLYNESIAN_01 BREAK
        CASE 30 RETURN A_M_M_PROLHOST_01 BREAK
        CASE 31 RETURN A_M_M_RURMETH_01 BREAK
        CASE 32 RETURN A_M_M_SALTON_01 BREAK
        CASE 33 RETURN A_M_M_SALTON_02 BREAK
        CASE 34 RETURN A_M_M_SALTON_03 BREAK
        CASE 35 RETURN A_M_M_SALTON_04 BREAK
        CASE 36 RETURN A_M_M_SKATER_01 BREAK
        CASE 37 RETURN A_M_M_SKIDROW_01 BREAK
        CASE 38 RETURN A_M_M_SOCENLAT_01 BREAK
        CASE 39 RETURN A_M_M_SOUCENT_01 BREAK
        CASE 40 RETURN A_M_M_SOUCENT_02 BREAK
        CASE 41 RETURN A_M_M_SOUCENT_03 BREAK
        CASE 42 RETURN A_M_M_SOUCENT_04 BREAK
        CASE 43 RETURN A_M_M_STLAT_02 BREAK
        CASE 44 RETURN A_M_M_TENNIS_01 BREAK
        CASE 45 RETURN A_M_M_TOURIST_01 BREAK
        CASE 46 RETURN A_M_M_TRAMPBEAC_01 BREAK
        CASE 47 RETURN A_M_M_TRAMP_01 BREAK
        CASE 48 RETURN A_M_M_TRANVEST_01 BREAK
        CASE 49 RETURN A_M_M_TRANVEST_02 BREAK
        CASE 50 RETURN A_M_O_ACULT_01 BREAK
        CASE 51 RETURN A_M_O_ACULT_02 BREAK
        CASE 52 RETURN A_M_O_BEACH_01 BREAK
        CASE 53 RETURN A_M_O_GENSTREET_01 BREAK
        CASE 54 RETURN A_M_O_KTOWN_01 BREAK
        CASE 55 RETURN A_M_O_SALTON_01 BREAK
        CASE 56 RETURN A_M_O_SOUCENT_01 BREAK
        CASE 57 RETURN A_M_O_SOUCENT_02 BREAK
        CASE 58 RETURN A_M_O_SOUCENT_03 BREAK
        CASE 59 RETURN A_M_O_TRAMP_01 BREAK
        CASE 60 RETURN A_M_Y_ACULT_01 BREAK
        CASE 61 RETURN A_M_Y_ACULT_02 BREAK
        CASE 62 RETURN A_M_Y_BEACHVESP_01 BREAK
        CASE 63 RETURN A_M_Y_BEACHVESP_02 BREAK
        CASE 64 RETURN A_M_Y_BEACH_01 BREAK
        CASE 65 RETURN A_M_Y_BEACH_02 BREAK
        CASE 66 RETURN A_M_Y_BEACH_03 BREAK
        CASE 67 RETURN A_M_Y_BEVHILLS_01 BREAK
        CASE 68 RETURN A_M_Y_BEVHILLS_02 BREAK
        CASE 69 RETURN A_M_Y_BREAKDANCE_01 BREAK
        CASE 70 RETURN A_M_Y_BUSICAS_01 BREAK
        CASE 71 RETURN A_M_Y_BUSINESS_01 BREAK
        CASE 72 RETURN A_M_Y_BUSINESS_02 BREAK
        CASE 73 RETURN A_M_Y_BUSINESS_03 BREAK
        CASE 74 RETURN A_M_Y_CYCLIST_01 BREAK
        CASE 75 RETURN A_M_Y_DHILL_01 BREAK
        CASE 76 RETURN A_M_Y_DOWNTOWN_01 BREAK
        CASE 77 RETURN A_M_Y_EASTSA_01 BREAK
        CASE 78 RETURN A_M_Y_EASTSA_02 BREAK
        CASE 79 RETURN A_M_Y_EPSILON_01 BREAK
        CASE 80 RETURN A_M_Y_EPSILON_02 BREAK
        CASE 81 RETURN A_M_Y_GAY_01 BREAK
        CASE 82 RETURN A_M_Y_GAY_02 BREAK
        CASE 83 RETURN A_M_Y_GENSTREET_01 BREAK
        CASE 84 RETURN A_M_Y_GENSTREET_02 BREAK
        CASE 85 RETURN A_M_Y_GOLFER_01 BREAK
        CASE 86 RETURN A_M_Y_HASJEW_01 BREAK
        CASE 87 RETURN A_M_Y_HIKER_01 BREAK
        CASE 88 RETURN A_M_Y_HIPPY_01 BREAK
        CASE 89 RETURN A_M_Y_HIPSTER_01 BREAK
        CASE 90 RETURN A_M_Y_HIPSTER_02 BREAK
        CASE 91 RETURN A_M_Y_HIPSTER_03 BREAK
        CASE 92 RETURN A_M_Y_INDIAN_01 BREAK
        CASE 93 RETURN A_M_Y_JETSKI_01 BREAK
        CASE 94 RETURN A_M_Y_JUGGALO_01 BREAK
        CASE 95 RETURN A_M_Y_KTOWN_01 BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_1(INT choice)
    SWITCH choice
        CASE 0 RETURN "A_F_Y_VINEWOOD_01" BREAK
        CASE 1 RETURN "A_F_Y_VINEWOOD_02" BREAK
        CASE 2 RETURN "A_F_Y_VINEWOOD_03" BREAK
        CASE 3 RETURN "A_F_Y_VINEWOOD_04" BREAK
        CASE 4 RETURN "A_F_Y_YOGA_01" BREAK
        CASE 5 RETURN "A_M_M_ACULT_01" BREAK
        CASE 6 RETURN "A_M_M_AFRIAMER_01" BREAK
        CASE 7 RETURN "A_M_M_BEACH_01" BREAK
        CASE 8 RETURN "A_M_M_BEACH_02" BREAK
        CASE 9 RETURN "A_M_M_BEVHILLS_01" BREAK
        CASE 10 RETURN "A_M_M_BEVHILLS_02" BREAK
        CASE 11 RETURN "A_M_M_BUSINESS_01" BREAK
        CASE 12 RETURN "A_M_M_EASTSA_01" BREAK
        CASE 13 RETURN "A_M_M_EASTSA_02" BREAK
        CASE 14 RETURN "A_M_M_FARMER_01" BREAK
        CASE 15 RETURN "A_M_M_FATLATIN_01" BREAK
        CASE 16 RETURN "A_M_M_GENFAT_01" BREAK
        CASE 17 RETURN "A_M_M_GENFAT_02" BREAK
        CASE 18 RETURN "A_M_M_GOLFER_01" BREAK
        CASE 19 RETURN "A_M_M_HASJEW_01" BREAK
        CASE 20 RETURN "A_M_M_HILLBILLY_01" BREAK
        CASE 21 RETURN "A_M_M_HILLBILLY_02" BREAK
        CASE 22 RETURN "A_M_M_INDIAN_01" BREAK
        CASE 23 RETURN "A_M_M_KTOWN_01" BREAK
        CASE 24 RETURN "A_M_M_MALIBU_01" BREAK
        CASE 25 RETURN "A_M_M_MEXCNTRY_01" BREAK
        CASE 26 RETURN "A_M_M_MEXLABOR_01" BREAK
        CASE 27 RETURN "A_M_M_OG_BOSS_01" BREAK
        CASE 28 RETURN "A_M_M_PAPARAZZI_01" BREAK
        CASE 29 RETURN "A_M_M_POLYNESIAN_01" BREAK
        CASE 30 RETURN "A_M_M_PROLHOST_01" BREAK
        CASE 31 RETURN "A_M_M_RURMETH_01" BREAK
        CASE 32 RETURN "A_M_M_SALTON_01" BREAK
        CASE 33 RETURN "A_M_M_SALTON_02" BREAK
        CASE 34 RETURN "A_M_M_SALTON_03" BREAK
        CASE 35 RETURN "A_M_M_SALTON_04" BREAK
        CASE 36 RETURN "A_M_M_SKATER_01" BREAK
        CASE 37 RETURN "A_M_M_SKIDROW_01" BREAK
        CASE 38 RETURN "A_M_M_SOCENLAT_01" BREAK
        CASE 39 RETURN "A_M_M_SOUCENT_01" BREAK
        CASE 40 RETURN "A_M_M_SOUCENT_02" BREAK
        CASE 41 RETURN "A_M_M_SOUCENT_03" BREAK
        CASE 42 RETURN "A_M_M_SOUCENT_04" BREAK
        CASE 43 RETURN "A_M_M_STLAT_02" BREAK
        CASE 44 RETURN "A_M_M_TENNIS_01" BREAK
        CASE 45 RETURN "A_M_M_TOURIST_01" BREAK
        CASE 46 RETURN "A_M_M_TRAMPBEAC_01" BREAK
        CASE 47 RETURN "A_M_M_TRAMP_01" BREAK
        CASE 48 RETURN "A_M_M_TRANVEST_01" BREAK
        CASE 49 RETURN "A_M_M_TRANVEST_02" BREAK
        CASE 50 RETURN "A_M_O_ACULT_01" BREAK
        CASE 51 RETURN "A_M_O_ACULT_02" BREAK
        CASE 52 RETURN "A_M_O_BEACH_01" BREAK
        CASE 53 RETURN "A_M_O_GENSTREET_01" BREAK
        CASE 54 RETURN "A_M_O_KTOWN_01" BREAK
        CASE 55 RETURN "A_M_O_SALTON_01" BREAK
        CASE 56 RETURN "A_M_O_SOUCENT_01" BREAK
        CASE 57 RETURN "A_M_O_SOUCENT_02" BREAK
        CASE 58 RETURN "A_M_O_SOUCENT_03" BREAK
        CASE 59 RETURN "A_M_O_TRAMP_01" BREAK
        CASE 60 RETURN "A_M_Y_ACULT_01" BREAK
        CASE 61 RETURN "A_M_Y_ACULT_02" BREAK
        CASE 62 RETURN "A_M_Y_BEACHVESP_01" BREAK
        CASE 63 RETURN "A_M_Y_BEACHVESP_02" BREAK
        CASE 64 RETURN "A_M_Y_BEACH_01" BREAK
        CASE 65 RETURN "A_M_Y_BEACH_02" BREAK
        CASE 66 RETURN "A_M_Y_BEACH_03" BREAK
        CASE 67 RETURN "A_M_Y_BEVHILLS_01" BREAK
        CASE 68 RETURN "A_M_Y_BEVHILLS_02" BREAK
        CASE 69 RETURN "A_M_Y_BREAKDANCE_01" BREAK
        CASE 70 RETURN "A_M_Y_BUSICAS_01" BREAK
        CASE 71 RETURN "A_M_Y_BUSINESS_01" BREAK
        CASE 72 RETURN "A_M_Y_BUSINESS_02" BREAK
        CASE 73 RETURN "A_M_Y_BUSINESS_03" BREAK
        CASE 74 RETURN "A_M_Y_CYCLIST_01" BREAK
        CASE 75 RETURN "A_M_Y_DHILL_01" BREAK
        CASE 76 RETURN "A_M_Y_DOWNTOWN_01" BREAK
        CASE 77 RETURN "A_M_Y_EASTSA_01" BREAK
        CASE 78 RETURN "A_M_Y_EASTSA_02" BREAK
        CASE 79 RETURN "A_M_Y_EPSILON_01" BREAK
        CASE 80 RETURN "A_M_Y_EPSILON_02" BREAK
        CASE 81 RETURN "A_M_Y_GAY_01" BREAK
        CASE 82 RETURN "A_M_Y_GAY_02" BREAK
        CASE 83 RETURN "A_M_Y_GENSTREET_01" BREAK
        CASE 84 RETURN "A_M_Y_GENSTREET_02" BREAK
        CASE 85 RETURN "A_M_Y_GOLFER_01" BREAK
        CASE 86 RETURN "A_M_Y_HASJEW_01" BREAK
        CASE 87 RETURN "A_M_Y_HIKER_01" BREAK
        CASE 88 RETURN "A_M_Y_HIPPY_01" BREAK
        CASE 89 RETURN "A_M_Y_HIPSTER_01" BREAK
        CASE 90 RETURN "A_M_Y_HIPSTER_02" BREAK
        CASE 91 RETURN "A_M_Y_HIPSTER_03" BREAK
        CASE 92 RETURN "A_M_Y_INDIAN_01" BREAK
        CASE 93 RETURN "A_M_Y_JETSKI_01" BREAK
        CASE 94 RETURN "A_M_Y_JUGGALO_01" BREAK
        CASE 95 RETURN "A_M_Y_KTOWN_01" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_2(INT choice)
    SWITCH choice
        CASE 0 RETURN A_M_Y_KTOWN_02 BREAK
        CASE 1 RETURN A_M_Y_LATINO_01 BREAK
        CASE 2 RETURN A_M_Y_METHHEAD_01 BREAK
        CASE 3 RETURN A_M_Y_MEXTHUG_01 BREAK
        CASE 4 RETURN A_M_Y_MOTOX_01 BREAK
        CASE 5 RETURN A_M_Y_MOTOX_02 BREAK
        CASE 6 RETURN A_M_Y_MUSCLBEAC_01 BREAK
        CASE 7 RETURN A_M_Y_MUSCLBEAC_02 BREAK
        CASE 8 RETURN A_M_Y_POLYNESIAN_01 BREAK
        CASE 9 RETURN A_M_Y_ROADCYC_01 BREAK
        CASE 10 RETURN A_M_Y_RUNNER_01 BREAK
        CASE 11 RETURN A_M_Y_RUNNER_02 BREAK
        CASE 12 RETURN A_M_Y_SALTON_01 BREAK
        CASE 13 RETURN A_M_Y_SKATER_01 BREAK
        CASE 14 RETURN A_M_Y_SKATER_02 BREAK
        CASE 15 RETURN A_M_Y_SOUCENT_01 BREAK
        CASE 16 RETURN A_M_Y_SOUCENT_02 BREAK
        CASE 17 RETURN A_M_Y_SOUCENT_03 BREAK
        CASE 18 RETURN A_M_Y_SOUCENT_04 BREAK
        CASE 19 RETURN A_M_Y_STBLA_01 BREAK
        CASE 20 RETURN A_M_Y_STBLA_02 BREAK
        CASE 21 RETURN A_M_Y_STLAT_01 BREAK
        CASE 22 RETURN A_M_Y_STWHI_01 BREAK
        CASE 23 RETURN A_M_Y_STWHI_02 BREAK
        CASE 24 RETURN A_M_Y_SUNBATHE_01 BREAK
        CASE 25 RETURN A_M_Y_SURFER_01 BREAK
        CASE 26 RETURN A_M_Y_VINDOUCHE_01 BREAK
        CASE 27 RETURN A_M_Y_VINEWOOD_01 BREAK
        CASE 28 RETURN A_M_Y_VINEWOOD_02 BREAK
        CASE 29 RETURN A_M_Y_VINEWOOD_03 BREAK
        CASE 30 RETURN A_M_Y_VINEWOOD_04 BREAK
        CASE 31 RETURN A_M_Y_YOGA_01 BREAK
        CASE 32 RETURN CSB_ABIGAIL BREAK
        CASE 33 RETURN CSB_ANITA BREAK
        CASE 34 RETURN CSB_ANTON BREAK
        CASE 35 RETURN CSB_BALLASOG BREAK
        CASE 36 RETURN CSB_BRIDE BREAK
        CASE 37 RETURN CSB_BURGERDRUG BREAK
        CASE 38 RETURN CSB_CAR3GUY1 BREAK
        CASE 39 RETURN CSB_CAR3GUY2 BREAK
        CASE 40 RETURN CSB_CHEF BREAK
        CASE 41 RETURN CSB_CHIN_GOON BREAK
        CASE 42 RETURN CSB_CLETUS BREAK
        CASE 43 RETURN CSB_COP BREAK
        CASE 44 RETURN CSB_CUSTOMER BREAK
        CASE 45 RETURN CSB_DENISE_FRIEND BREAK
        CASE 46 RETURN CSB_FOS_REP BREAK
        CASE 47 RETURN CSB_G BREAK
        CASE 48 RETURN CSB_GROOM BREAK
        CASE 49 RETURN CSB_GROVE_STR_DLR BREAK
        CASE 50 RETURN CSB_HAO BREAK
        CASE 51 RETURN CSB_HUGH BREAK
        CASE 52 RETURN CSB_IMRAN BREAK
        CASE 53 RETURN CSB_JACKHOWITZER BREAK
        CASE 54 RETURN CSB_JANITOR BREAK
        CASE 55 RETURN CSB_MAUDE BREAK
        CASE 56 RETURN CSB_MWEATHER BREAK
        CASE 57 RETURN CSB_ORTEGA BREAK
        CASE 58 RETURN CSB_OSCAR BREAK
        CASE 59 RETURN CSB_PORNDUDES BREAK
        CASE 60 RETURN CSB_PROLOGUEDRIVER BREAK
        CASE 61 RETURN CSB_PROLSEC BREAK
        CASE 62 RETURN CSB_RAMP_GANG BREAK
        CASE 63 RETURN CSB_RAMP_HIC BREAK
        CASE 64 RETURN CSB_RAMP_HIPSTER BREAK
        CASE 65 RETURN CSB_RAMP_MARINE BREAK
        CASE 66 RETURN CSB_RAMP_MEX BREAK
        CASE 67 RETURN CSB_REPORTER BREAK
        CASE 68 RETURN CSB_ROCCOPELOSI BREAK
        CASE 69 RETURN CSB_SCREEN_WRITER BREAK
        CASE 70 RETURN CSB_STRIPPER_01 BREAK
        CASE 71 RETURN CSB_STRIPPER_02 BREAK
        CASE 72 RETURN CSB_TONYA BREAK
        CASE 73 RETURN CSB_TRAFFICWARDEN BREAK
        CASE 74 RETURN CS_AMANDATOWNLEY BREAK
        CASE 75 RETURN CS_ANDREAS BREAK
        CASE 76 RETURN CS_ASHLEY BREAK
        CASE 77 RETURN CS_BANKMAN BREAK
        CASE 78 RETURN CS_BARRY BREAK
        CASE 79 RETURN CS_BEVERLY BREAK
        CASE 80 RETURN CS_BRAD BREAK
        CASE 81 RETURN CS_BRADCADAVER BREAK
        CASE 82 RETURN CS_CARBUYER BREAK
        CASE 83 RETURN CS_CASEY BREAK
        CASE 84 RETURN CS_CHENGSR BREAK
        CASE 85 RETURN CS_CHRISFORMAGE BREAK
        CASE 86 RETURN CS_CLAY BREAK
        CASE 87 RETURN CS_DALE BREAK
        CASE 88 RETURN CS_DAVENORTON BREAK
        CASE 89 RETURN CS_DEBRA BREAK
        CASE 90 RETURN CS_DENISE BREAK
        CASE 91 RETURN CS_DEVIN BREAK
        CASE 92 RETURN CS_DOM BREAK
        CASE 93 RETURN CS_DREYFUSS BREAK
        CASE 94 RETURN CS_DRFRIEDLANDER BREAK
        CASE 95 RETURN CS_FABIEN BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_2(INT choice)
    SWITCH choice
        CASE 0 RETURN "A_M_Y_KTOWN_02" BREAK
        CASE 1 RETURN "A_M_Y_LATINO_01" BREAK
        CASE 2 RETURN "A_M_Y_METHHEAD_01" BREAK
        CASE 3 RETURN "A_M_Y_MEXTHUG_01" BREAK
        CASE 4 RETURN "A_M_Y_MOTOX_01" BREAK
        CASE 5 RETURN "A_M_Y_MOTOX_02" BREAK
        CASE 6 RETURN "A_M_Y_MUSCLBEAC_01" BREAK
        CASE 7 RETURN "A_M_Y_MUSCLBEAC_02" BREAK
        CASE 8 RETURN "A_M_Y_POLYNESIAN_01" BREAK
        CASE 9 RETURN "A_M_Y_ROADCYC_01" BREAK
        CASE 10 RETURN "A_M_Y_RUNNER_01" BREAK
        CASE 11 RETURN "A_M_Y_RUNNER_02" BREAK
        CASE 12 RETURN "A_M_Y_SALTON_01" BREAK
        CASE 13 RETURN "A_M_Y_SKATER_01" BREAK
        CASE 14 RETURN "A_M_Y_SKATER_02" BREAK
        CASE 15 RETURN "A_M_Y_SOUCENT_01" BREAK
        CASE 16 RETURN "A_M_Y_SOUCENT_02" BREAK
        CASE 17 RETURN "A_M_Y_SOUCENT_03" BREAK
        CASE 18 RETURN "A_M_Y_SOUCENT_04" BREAK
        CASE 19 RETURN "A_M_Y_STBLA_01" BREAK
        CASE 20 RETURN "A_M_Y_STBLA_02" BREAK
        CASE 21 RETURN "A_M_Y_STLAT_01" BREAK
        CASE 22 RETURN "A_M_Y_STWHI_01" BREAK
        CASE 23 RETURN "A_M_Y_STWHI_02" BREAK
        CASE 24 RETURN "A_M_Y_SUNBATHE_01" BREAK
        CASE 25 RETURN "A_M_Y_SURFER_01" BREAK
        CASE 26 RETURN "A_M_Y_VINDOUCHE_01" BREAK
        CASE 27 RETURN "A_M_Y_VINEWOOD_01" BREAK
        CASE 28 RETURN "A_M_Y_VINEWOOD_02" BREAK
        CASE 29 RETURN "A_M_Y_VINEWOOD_03" BREAK
        CASE 30 RETURN "A_M_Y_VINEWOOD_04" BREAK
        CASE 31 RETURN "A_M_Y_YOGA_01" BREAK
        CASE 32 RETURN "CSB_ABIGAIL" BREAK
        CASE 33 RETURN "CSB_ANITA" BREAK
        CASE 34 RETURN "CSB_ANTON" BREAK
        CASE 35 RETURN "CSB_BALLASOG" BREAK
        CASE 36 RETURN "CSB_BRIDE" BREAK
        CASE 37 RETURN "CSB_BURGERDRUG" BREAK
        CASE 38 RETURN "CSB_CAR3GUY1" BREAK
        CASE 39 RETURN "CSB_CAR3GUY2" BREAK
        CASE 40 RETURN "CSB_CHEF" BREAK
        CASE 41 RETURN "CSB_CHIN_GOON" BREAK
        CASE 42 RETURN "CSB_CLETUS" BREAK
        CASE 43 RETURN "CSB_COP" BREAK
        CASE 44 RETURN "CSB_CUSTOMER" BREAK
        CASE 45 RETURN "CSB_DENISE_FRIEND" BREAK
        CASE 46 RETURN "CSB_FOS_REP" BREAK
        CASE 47 RETURN "CSB_G" BREAK
        CASE 48 RETURN "CSB_GROOM" BREAK
        CASE 49 RETURN "CSB_GROVE_STR_DLR" BREAK
        CASE 50 RETURN "CSB_HAO" BREAK
        CASE 51 RETURN "CSB_HUGH" BREAK
        CASE 52 RETURN "CSB_IMRAN" BREAK
        CASE 53 RETURN "CSB_JACKHOWITZER" BREAK
        CASE 54 RETURN "CSB_JANITOR" BREAK
        CASE 55 RETURN "CSB_MAUDE" BREAK
        CASE 56 RETURN "CSB_MWEATHER" BREAK
        CASE 57 RETURN "CSB_ORTEGA" BREAK
        CASE 58 RETURN "CSB_OSCAR" BREAK
        CASE 59 RETURN "CSB_PORNDUDES" BREAK
        CASE 60 RETURN "CSB_PROLOGUEDRIVER" BREAK
        CASE 61 RETURN "CSB_PROLSEC" BREAK
        CASE 62 RETURN "CSB_RAMP_GANG" BREAK
        CASE 63 RETURN "CSB_RAMP_HIC" BREAK
        CASE 64 RETURN "CSB_RAMP_HIPSTER" BREAK
        CASE 65 RETURN "CSB_RAMP_MARINE" BREAK
        CASE 66 RETURN "CSB_RAMP_MEX" BREAK
        CASE 67 RETURN "CSB_REPORTER" BREAK
        CASE 68 RETURN "CSB_ROCCOPELOSI" BREAK
        CASE 69 RETURN "CSB_SCREEN_WRITER" BREAK
        CASE 70 RETURN "CSB_STRIPPER_01" BREAK
        CASE 71 RETURN "CSB_STRIPPER_02" BREAK
        CASE 72 RETURN "CSB_TONYA" BREAK
        CASE 73 RETURN "CSB_TRAFFICWARDEN" BREAK
        CASE 74 RETURN "CS_AMANDATOWNLEY" BREAK
        CASE 75 RETURN "CS_ANDREAS" BREAK
        CASE 76 RETURN "CS_ASHLEY" BREAK
        CASE 77 RETURN "CS_BANKMAN" BREAK
        CASE 78 RETURN "CS_BARRY" BREAK
        CASE 79 RETURN "CS_BEVERLY" BREAK
        CASE 80 RETURN "CS_BRAD" BREAK
        CASE 81 RETURN "CS_BRADCADAVER" BREAK
        CASE 82 RETURN "CS_CARBUYER" BREAK
        CASE 83 RETURN "CS_CASEY" BREAK
        CASE 84 RETURN "CS_CHENGSR" BREAK
        CASE 85 RETURN "CS_CHRISFORMAGE" BREAK
        CASE 86 RETURN "CS_CLAY" BREAK
        CASE 87 RETURN "CS_DALE" BREAK
        CASE 88 RETURN "CS_DAVENORTON" BREAK
        CASE 89 RETURN "CS_DEBRA" BREAK
        CASE 90 RETURN "CS_DENISE" BREAK
        CASE 91 RETURN "CS_DEVIN" BREAK
        CASE 92 RETURN "CS_DOM" BREAK
        CASE 93 RETURN "CS_DREYFUSS" BREAK
        CASE 94 RETURN "CS_DRFRIEDLANDER" BREAK
        CASE 95 RETURN "CS_FABIEN" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_3(INT choice)
    SWITCH choice
        CASE 0 RETURN CS_FBISUIT_01 BREAK
        CASE 1 RETURN CS_FLOYD BREAK
        CASE 2 RETURN CS_GUADALOPE BREAK
        CASE 3 RETURN CS_GURK BREAK
        CASE 4 RETURN CS_HUNTER BREAK
        CASE 5 RETURN CS_JANET BREAK
        CASE 6 RETURN CS_JEWELASS BREAK
        CASE 7 RETURN CS_JIMMYBOSTON BREAK
        CASE 8 RETURN CS_JIMMYDISANTO BREAK
        CASE 9 RETURN CS_JOEMINUTEMAN BREAK
        CASE 10 RETURN CS_JOHNNYKLEBITZ BREAK
        CASE 11 RETURN CS_JOSEF BREAK
        CASE 12 RETURN CS_JOSH BREAK
        CASE 13 RETURN CS_LAMARDAVIS BREAK
        CASE 14 RETURN CS_LAZLOW BREAK
        CASE 15 RETURN CS_LESTERCREST BREAK
        CASE 16 RETURN CS_LIFEINVAD_01 BREAK
        CASE 17 RETURN CS_MAGENTA BREAK
        CASE 18 RETURN CS_MANUEL BREAK
        CASE 19 RETURN CS_MARNIE BREAK
        CASE 20 RETURN CS_MARTINMADRAZO BREAK
        CASE 21 RETURN CS_MARYANN BREAK
        CASE 22 RETURN CS_MICHELLE BREAK
        CASE 23 RETURN CS_MILTON BREAK
        CASE 24 RETURN CS_MOLLY BREAK
        CASE 25 RETURN CS_MOVPREMF_01 BREAK
        CASE 26 RETURN CS_MOVPREMMALE BREAK
        CASE 27 RETURN CS_MRK BREAK
        CASE 28 RETURN CS_MRSPHILLIPS BREAK
        CASE 29 RETURN CS_MRS_THORNHILL BREAK
        CASE 30 RETURN CS_NATALIA BREAK
        CASE 31 RETURN CS_NERVOUSRON BREAK
        CASE 32 RETURN CS_NIGEL BREAK
        CASE 33 RETURN CS_OLD_MAN1A BREAK
        CASE 34 RETURN CS_OLD_MAN2 BREAK
        CASE 35 RETURN CS_OMEGA BREAK
        CASE 36 RETURN CS_ORLEANS BREAK
        CASE 37 RETURN CS_PAPER BREAK
        CASE 38 RETURN CS_PATRICIA BREAK
        CASE 39 RETURN CS_PRIEST BREAK
        CASE 40 RETURN CS_PROLSEC_02 BREAK
        CASE 41 RETURN CS_RUSSIANDRUNK BREAK
        CASE 42 RETURN CS_SIEMONYETARIAN BREAK
        CASE 43 RETURN CS_SOLOMON BREAK
        CASE 44 RETURN CS_STEVEHAINS BREAK
        CASE 45 RETURN CS_STRETCH BREAK
        CASE 46 RETURN CS_TANISHA BREAK
        CASE 47 RETURN CS_TAOCHENG BREAK
        CASE 48 RETURN CS_TAOSTRANSLATOR BREAK
        CASE 49 RETURN CS_TENNISCOACH BREAK
        CASE 50 RETURN CS_TERRY BREAK
        CASE 51 RETURN CS_TOM BREAK
        CASE 52 RETURN CS_TOMEPSILON BREAK
        CASE 53 RETURN CS_TRACYDISANTO BREAK
        CASE 54 RETURN CS_WADE BREAK
        CASE 55 RETURN CS_ZIMBOR BREAK
        CASE 56 RETURN G_F_Y_BALLAS_01 BREAK
        CASE 57 RETURN G_F_Y_FAMILIES_01 BREAK
        CASE 58 RETURN G_F_Y_LOST_01 BREAK
        CASE 59 RETURN G_F_Y_VAGOS_01 BREAK
        CASE 60 RETURN G_M_M_ARMBOSS_01 BREAK
        CASE 61 RETURN G_M_M_ARMGOON_01 BREAK
        CASE 62 RETURN G_M_M_ARMLIEUT_01 BREAK
        CASE 63 RETURN G_M_M_CHEMWORK_01 BREAK
        CASE 64 RETURN G_M_M_CHIBOSS_01 BREAK
        CASE 65 RETURN G_M_M_CHICOLD_01 BREAK
        CASE 66 RETURN G_M_M_CHIGOON_01 BREAK
        CASE 67 RETURN G_M_M_CHIGOON_02 BREAK
        CASE 68 RETURN G_M_M_KORBOSS_01 BREAK
        CASE 69 RETURN G_M_M_MEXBOSS_01 BREAK
        CASE 70 RETURN G_M_M_MEXBOSS_02 BREAK
        CASE 71 RETURN G_M_Y_ARMGOON_02 BREAK
        CASE 72 RETURN G_M_Y_AZTECA_01 BREAK
        CASE 73 RETURN G_M_Y_BALLAEAST_01 BREAK
        CASE 74 RETURN G_M_Y_BALLAORIG_01 BREAK
        CASE 75 RETURN G_M_Y_BALLASOUT_01 BREAK
        CASE 76 RETURN G_M_Y_FAMCA_01 BREAK
        CASE 77 RETURN G_M_Y_FAMDNF_01 BREAK
        CASE 78 RETURN G_M_Y_FAMFOR_01 BREAK
        CASE 79 RETURN G_M_Y_KOREAN_01 BREAK
        CASE 80 RETURN G_M_Y_KOREAN_02 BREAK
        CASE 81 RETURN G_M_Y_KORLIEUT_01 BREAK
        CASE 82 RETURN G_M_Y_LOST_01 BREAK
        CASE 83 RETURN G_M_Y_LOST_02 BREAK
        CASE 84 RETURN G_M_Y_LOST_03 BREAK
        CASE 85 RETURN G_M_Y_MEXGANG_01 BREAK
        CASE 86 RETURN G_M_Y_MEXGOON_01 BREAK
        CASE 87 RETURN G_M_Y_MEXGOON_02 BREAK
        CASE 88 RETURN G_M_Y_MEXGOON_03 BREAK
        CASE 89 RETURN G_M_Y_POLOGOON_01 BREAK
        CASE 90 RETURN G_M_Y_POLOGOON_02 BREAK
        CASE 91 RETURN G_M_Y_SALVABOSS_01 BREAK
        CASE 92 RETURN G_M_Y_SALVAGOON_01 BREAK
        CASE 93 RETURN G_M_Y_SALVAGOON_02 BREAK
        CASE 94 RETURN G_M_Y_SALVAGOON_03 BREAK
        CASE 95 RETURN G_M_Y_STRPUNK_01 BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_3(INT choice)
    SWITCH choice
        CASE 0 RETURN "CS_FBISUIT_01" BREAK
        CASE 1 RETURN "CS_FLOYD" BREAK
        CASE 2 RETURN "CS_GUADALOPE" BREAK
        CASE 3 RETURN "CS_GURK" BREAK
        CASE 4 RETURN "CS_HUNTER" BREAK
        CASE 5 RETURN "CS_JANET" BREAK
        CASE 6 RETURN "CS_JEWELASS" BREAK
        CASE 7 RETURN "CS_JIMMYBOSTON" BREAK
        CASE 8 RETURN "CS_JIMMYDISANTO" BREAK
        CASE 9 RETURN "CS_JOEMINUTEMAN" BREAK
        CASE 10 RETURN "CS_JOHNNYKLEBITZ" BREAK
        CASE 11 RETURN "CS_JOSEF" BREAK
        CASE 12 RETURN "CS_JOSH" BREAK
        CASE 13 RETURN "CS_LAMARDAVIS" BREAK
        CASE 14 RETURN "CS_LAZLOW" BREAK
        CASE 15 RETURN "CS_LESTERCREST" BREAK
        CASE 16 RETURN "CS_LIFEINVAD_01" BREAK
        CASE 17 RETURN "CS_MAGENTA" BREAK
        CASE 18 RETURN "CS_MANUEL" BREAK
        CASE 19 RETURN "CS_MARNIE" BREAK
        CASE 20 RETURN "CS_MARTINMADRAZO" BREAK
        CASE 21 RETURN "CS_MARYANN" BREAK
        CASE 22 RETURN "CS_MICHELLE" BREAK
        CASE 23 RETURN "CS_MILTON" BREAK
        CASE 24 RETURN "CS_MOLLY" BREAK
        CASE 25 RETURN "CS_MOVPREMF_01" BREAK
        CASE 26 RETURN "CS_MOVPREMMALE" BREAK
        CASE 27 RETURN "CS_MRK" BREAK
        CASE 28 RETURN "CS_MRSPHILLIPS" BREAK
        CASE 29 RETURN "CS_MRS_THORNHILL" BREAK
        CASE 30 RETURN "CS_NATALIA" BREAK
        CASE 31 RETURN "CS_NERVOUSRON" BREAK
        CASE 32 RETURN "CS_NIGEL" BREAK
        CASE 33 RETURN "CS_OLD_MAN1A" BREAK
        CASE 34 RETURN "CS_OLD_MAN2" BREAK
        CASE 35 RETURN "CS_OMEGA" BREAK
        CASE 36 RETURN "CS_ORLEANS" BREAK
        CASE 37 RETURN "CS_PAPER" BREAK
        CASE 38 RETURN "CS_PATRICIA" BREAK
        CASE 39 RETURN "CS_PRIEST" BREAK
        CASE 40 RETURN "CS_PROLSEC_02" BREAK
        CASE 41 RETURN "CS_RUSSIANDRUNK" BREAK
        CASE 42 RETURN "CS_SIEMONYETARIAN" BREAK
        CASE 43 RETURN "CS_SOLOMON" BREAK
        CASE 44 RETURN "CS_STEVEHAINS" BREAK
        CASE 45 RETURN "CS_STRETCH" BREAK
        CASE 46 RETURN "CS_TANISHA" BREAK
        CASE 47 RETURN "CS_TAOCHENG" BREAK
        CASE 48 RETURN "CS_TAOSTRANSLATOR" BREAK
        CASE 49 RETURN "CS_TENNISCOACH" BREAK
        CASE 50 RETURN "CS_TERRY" BREAK
        CASE 51 RETURN "CS_TOM" BREAK
        CASE 52 RETURN "CS_TOMEPSILON" BREAK
        CASE 53 RETURN "CS_TRACYDISANTO" BREAK
        CASE 54 RETURN "CS_WADE" BREAK
        CASE 55 RETURN "CS_ZIMBOR" BREAK
        CASE 56 RETURN "G_F_Y_BALLAS_01" BREAK
        CASE 57 RETURN "G_F_Y_FAMILIES_01" BREAK
        CASE 58 RETURN "G_F_Y_LOST_01" BREAK
        CASE 59 RETURN "G_F_Y_VAGOS_01" BREAK
        CASE 60 RETURN "G_M_M_ARMBOSS_01" BREAK
        CASE 61 RETURN "G_M_M_ARMGOON_01" BREAK
        CASE 62 RETURN "G_M_M_ARMLIEUT_01" BREAK
        CASE 63 RETURN "G_M_M_CHEMWORK_01" BREAK
        CASE 64 RETURN "G_M_M_CHIBOSS_01" BREAK
        CASE 65 RETURN "G_M_M_CHICOLD_01" BREAK
        CASE 66 RETURN "G_M_M_CHIGOON_01" BREAK
        CASE 67 RETURN "G_M_M_CHIGOON_02" BREAK
        CASE 68 RETURN "G_M_M_KORBOSS_01" BREAK
        CASE 69 RETURN "G_M_M_MEXBOSS_01" BREAK
        CASE 70 RETURN "G_M_M_MEXBOSS_02" BREAK
        CASE 71 RETURN "G_M_Y_ARMGOON_02" BREAK
        CASE 72 RETURN "G_M_Y_AZTECA_01" BREAK
        CASE 73 RETURN "G_M_Y_BALLAEAST_01" BREAK
        CASE 74 RETURN "G_M_Y_BALLAORIG_01" BREAK
        CASE 75 RETURN "G_M_Y_BALLASOUT_01" BREAK
        CASE 76 RETURN "G_M_Y_FAMCA_01" BREAK
        CASE 77 RETURN "G_M_Y_FAMDNF_01" BREAK
        CASE 78 RETURN "G_M_Y_FAMFOR_01" BREAK
        CASE 79 RETURN "G_M_Y_KOREAN_01" BREAK
        CASE 80 RETURN "G_M_Y_KOREAN_02" BREAK
        CASE 81 RETURN "G_M_Y_KORLIEUT_01" BREAK
        CASE 82 RETURN "G_M_Y_LOST_01" BREAK
        CASE 83 RETURN "G_M_Y_LOST_02" BREAK
        CASE 84 RETURN "G_M_Y_LOST_03" BREAK
        CASE 85 RETURN "G_M_Y_MEXGANG_01" BREAK
        CASE 86 RETURN "G_M_Y_MEXGOON_01" BREAK
        CASE 87 RETURN "G_M_Y_MEXGOON_02" BREAK
        CASE 88 RETURN "G_M_Y_MEXGOON_03" BREAK
        CASE 89 RETURN "G_M_Y_POLOGOON_01" BREAK
        CASE 90 RETURN "G_M_Y_POLOGOON_02" BREAK
        CASE 91 RETURN "G_M_Y_SALVABOSS_01" BREAK
        CASE 92 RETURN "G_M_Y_SALVAGOON_01" BREAK
        CASE 93 RETURN "G_M_Y_SALVAGOON_02" BREAK
        CASE 94 RETURN "G_M_Y_SALVAGOON_03" BREAK
        CASE 95 RETURN "G_M_Y_STRPUNK_01" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_4(INT choice)
    SWITCH choice
        CASE 0 RETURN G_M_Y_STRPUNK_02 BREAK
        CASE 1 RETURN HC_DRIVER BREAK
        CASE 2 RETURN HC_GUNMAN BREAK
        CASE 3 RETURN HC_HACKER BREAK
        CASE 4 RETURN IG_ABIGAIL BREAK
        CASE 5 RETURN IG_AMANDATOWNLEY BREAK
        CASE 6 RETURN IG_ANDREAS BREAK
        CASE 7 RETURN IG_ASHLEY BREAK
        CASE 8 RETURN IG_BALLASOG BREAK
        CASE 9 RETURN IG_BANKMAN BREAK
        CASE 10 RETURN IG_BARRY BREAK
        CASE 11 RETURN IG_BESTMEN BREAK
        CASE 12 RETURN IG_BEVERLY BREAK
        CASE 13 RETURN IG_BRAD BREAK
        CASE 14 RETURN IG_BRIDE BREAK
        CASE 15 RETURN IG_CAR3GUY1 BREAK
        CASE 16 RETURN IG_CAR3GUY2 BREAK
        CASE 17 RETURN IG_CASEY BREAK
        CASE 18 RETURN IG_CHEF BREAK
        CASE 19 RETURN IG_CHENGSR BREAK
        CASE 20 RETURN IG_CHRISFORMAGE BREAK
        CASE 21 RETURN IG_CLAY BREAK
        CASE 22 RETURN IG_CLAYPAIN BREAK
        CASE 23 RETURN IG_CLETUS BREAK
        CASE 24 RETURN IG_DALE BREAK
        CASE 25 RETURN IG_DAVENORTON BREAK
        CASE 26 RETURN IG_DENISE BREAK
        CASE 27 RETURN IG_DEVIN BREAK
        CASE 28 RETURN IG_DOM BREAK
        CASE 29 RETURN IG_DREYFUSS BREAK
        CASE 30 RETURN IG_DRFRIEDLANDER BREAK
        CASE 31 RETURN IG_FABIEN BREAK
        CASE 32 RETURN IG_FBISUIT_01 BREAK
        CASE 33 RETURN IG_FLOYD BREAK
        CASE 34 RETURN IG_GROOM BREAK
        CASE 35 RETURN IG_HAO BREAK
        CASE 36 RETURN IG_HUNTER BREAK
        CASE 37 RETURN IG_JANET BREAK
        CASE 38 RETURN IG_JAY_NORRIS BREAK
        CASE 39 RETURN IG_JEWELASS BREAK
        CASE 40 RETURN IG_JIMMYBOSTON BREAK
        CASE 41 RETURN IG_JIMMYDISANTO BREAK
        CASE 42 RETURN IG_JOEMINUTEMAN BREAK
        CASE 43 RETURN IG_JOHNNYKLEBITZ BREAK
        CASE 44 RETURN IG_JOSEF BREAK
        CASE 45 RETURN IG_JOSH BREAK
        CASE 46 RETURN IG_KERRYMCINTOSH BREAK
        CASE 47 RETURN IG_LAMARDAVIS BREAK
        CASE 48 RETURN IG_LAZLOW BREAK
        CASE 49 RETURN IG_LESTERCREST BREAK
        CASE 50 RETURN IG_LIFEINVAD_01 BREAK
        CASE 51 RETURN IG_LIFEINVAD_02 BREAK
        CASE 52 RETURN IG_MAGENTA BREAK
        CASE 53 RETURN IG_MANUEL BREAK
        CASE 54 RETURN IG_MARNIE BREAK
        CASE 55 RETURN IG_MARYANN BREAK
        CASE 56 RETURN IG_MAUDE BREAK
        CASE 57 RETURN IG_MICHELLE BREAK
        CASE 58 RETURN IG_MILTON BREAK
        CASE 59 RETURN IG_MOLLY BREAK
        CASE 60 RETURN IG_MRK BREAK
        CASE 61 RETURN IG_MRSPHILLIPS BREAK
        CASE 62 RETURN IG_MRS_THORNHILL BREAK
        CASE 63 RETURN IG_NATALIA BREAK
        CASE 64 RETURN IG_NERVOUSRON BREAK
        CASE 65 RETURN IG_NIGEL BREAK
        CASE 66 RETURN IG_OLD_MAN1A BREAK
        CASE 67 RETURN IG_OLD_MAN2 BREAK
        CASE 68 RETURN IG_OMEGA BREAK
        CASE 69 RETURN IG_ONEIL BREAK
        CASE 70 RETURN IG_ORLEANS BREAK
        CASE 71 RETURN IG_ORTEGA BREAK
        CASE 72 RETURN IG_PAPER BREAK
        CASE 73 RETURN IG_PATRICIA BREAK
        CASE 74 RETURN IG_PRIEST BREAK
        CASE 75 RETURN IG_PROLSEC_02 BREAK
        CASE 76 RETURN IG_RAMP_GANG BREAK
        CASE 77 RETURN IG_RAMP_HIC BREAK
        CASE 78 RETURN IG_RAMP_HIPSTER BREAK
        CASE 79 RETURN IG_RAMP_MEX BREAK
        CASE 80 RETURN IG_ROCCOPELOSI BREAK
        CASE 81 RETURN IG_RUSSIANDRUNK BREAK
        CASE 82 RETURN IG_SCREEN_WRITER BREAK
        CASE 83 RETURN IG_SIEMONYETARIAN BREAK
        CASE 84 RETURN IG_SOLOMON BREAK
        CASE 85 RETURN IG_STEVEHAINS BREAK
        CASE 86 RETURN IG_STRETCH BREAK
        CASE 87 RETURN IG_TALINA BREAK
        CASE 88 RETURN IG_TANISHA BREAK
        CASE 89 RETURN IG_TAOCHENG BREAK
        CASE 90 RETURN IG_TAOSTRANSLATOR BREAK
        CASE 91 RETURN IG_TENNISCOACH BREAK
        CASE 92 RETURN IG_TERRY BREAK
        CASE 93 RETURN IG_TOMEPSILON BREAK
        CASE 94 RETURN IG_TONYA BREAK
        CASE 95 RETURN IG_TRACYDISANTO BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_4(INT choice)
    SWITCH choice
        CASE 0 RETURN "G_M_Y_STRPUNK_02" BREAK
        CASE 1 RETURN "HC_DRIVER" BREAK
        CASE 2 RETURN "HC_GUNMAN" BREAK
        CASE 3 RETURN "HC_HACKER" BREAK
        CASE 4 RETURN "IG_ABIGAIL" BREAK
        CASE 5 RETURN "IG_AMANDATOWNLEY" BREAK
        CASE 6 RETURN "IG_ANDREAS" BREAK
        CASE 7 RETURN "IG_ASHLEY" BREAK
        CASE 8 RETURN "IG_BALLASOG" BREAK
        CASE 9 RETURN "IG_BANKMAN" BREAK
        CASE 10 RETURN "IG_BARRY" BREAK
        CASE 11 RETURN "IG_BESTMEN" BREAK
        CASE 12 RETURN "IG_BEVERLY" BREAK
        CASE 13 RETURN "IG_BRAD" BREAK
        CASE 14 RETURN "IG_BRIDE" BREAK
        CASE 15 RETURN "IG_CAR3GUY1" BREAK
        CASE 16 RETURN "IG_CAR3GUY2" BREAK
        CASE 17 RETURN "IG_CASEY" BREAK
        CASE 18 RETURN "IG_CHEF" BREAK
        CASE 19 RETURN "IG_CHENGSR" BREAK
        CASE 20 RETURN "IG_CHRISFORMAGE" BREAK
        CASE 21 RETURN "IG_CLAY" BREAK
        CASE 22 RETURN "IG_CLAYPAIN" BREAK
        CASE 23 RETURN "IG_CLETUS" BREAK
        CASE 24 RETURN "IG_DALE" BREAK
        CASE 25 RETURN "IG_DAVENORTON" BREAK
        CASE 26 RETURN "IG_DENISE" BREAK
        CASE 27 RETURN "IG_DEVIN" BREAK
        CASE 28 RETURN "IG_DOM" BREAK
        CASE 29 RETURN "IG_DREYFUSS" BREAK
        CASE 30 RETURN "IG_DRFRIEDLANDER" BREAK
        CASE 31 RETURN "IG_FABIEN" BREAK
        CASE 32 RETURN "IG_FBISUIT_01" BREAK
        CASE 33 RETURN "IG_FLOYD" BREAK
        CASE 34 RETURN "IG_GROOM" BREAK
        CASE 35 RETURN "IG_HAO" BREAK
        CASE 36 RETURN "IG_HUNTER" BREAK
        CASE 37 RETURN "IG_JANET" BREAK
        CASE 38 RETURN "IG_JAY_NORRIS" BREAK
        CASE 39 RETURN "IG_JEWELASS" BREAK
        CASE 40 RETURN "IG_JIMMYBOSTON" BREAK
        CASE 41 RETURN "IG_JIMMYDISANTO" BREAK
        CASE 42 RETURN "IG_JOEMINUTEMAN" BREAK
        CASE 43 RETURN "IG_JOHNNYKLEBITZ" BREAK
        CASE 44 RETURN "IG_JOSEF" BREAK
        CASE 45 RETURN "IG_JOSH" BREAK
        CASE 46 RETURN "IG_KERRYMCINTOSH" BREAK
        CASE 47 RETURN "IG_LAMARDAVIS" BREAK
        CASE 48 RETURN "IG_LAZLOW" BREAK
        CASE 49 RETURN "IG_LESTERCREST" BREAK
        CASE 50 RETURN "IG_LIFEINVAD_01" BREAK
        CASE 51 RETURN "IG_LIFEINVAD_02" BREAK
        CASE 52 RETURN "IG_MAGENTA" BREAK
        CASE 53 RETURN "IG_MANUEL" BREAK
        CASE 54 RETURN "IG_MARNIE" BREAK
        CASE 55 RETURN "IG_MARYANN" BREAK
        CASE 56 RETURN "IG_MAUDE" BREAK
        CASE 57 RETURN "IG_MICHELLE" BREAK
        CASE 58 RETURN "IG_MILTON" BREAK
        CASE 59 RETURN "IG_MOLLY" BREAK
        CASE 60 RETURN "IG_MRK" BREAK
        CASE 61 RETURN "IG_MRSPHILLIPS" BREAK
        CASE 62 RETURN "IG_MRS_THORNHILL" BREAK
        CASE 63 RETURN "IG_NATALIA" BREAK
        CASE 64 RETURN "IG_NERVOUSRON" BREAK
        CASE 65 RETURN "IG_NIGEL" BREAK
        CASE 66 RETURN "IG_OLD_MAN1A" BREAK
        CASE 67 RETURN "IG_OLD_MAN2" BREAK
        CASE 68 RETURN "IG_OMEGA" BREAK
        CASE 69 RETURN "IG_ONEIL" BREAK
        CASE 70 RETURN "IG_ORLEANS" BREAK
        CASE 71 RETURN "IG_ORTEGA" BREAK
        CASE 72 RETURN "IG_PAPER" BREAK
        CASE 73 RETURN "IG_PATRICIA" BREAK
        CASE 74 RETURN "IG_PRIEST" BREAK
        CASE 75 RETURN "IG_PROLSEC_02" BREAK
        CASE 76 RETURN "IG_RAMP_GANG" BREAK
        CASE 77 RETURN "IG_RAMP_HIC" BREAK
        CASE 78 RETURN "IG_RAMP_HIPSTER" BREAK
        CASE 79 RETURN "IG_RAMP_MEX" BREAK
        CASE 80 RETURN "IG_ROCCOPELOSI" BREAK
        CASE 81 RETURN "IG_RUSSIANDRUNK" BREAK
        CASE 82 RETURN "IG_SCREEN_WRITER" BREAK
        CASE 83 RETURN "IG_SIEMONYETARIAN" BREAK
        CASE 84 RETURN "IG_SOLOMON" BREAK
        CASE 85 RETURN "IG_STEVEHAINS" BREAK
        CASE 86 RETURN "IG_STRETCH" BREAK
        CASE 87 RETURN "IG_TALINA" BREAK
        CASE 88 RETURN "IG_TANISHA" BREAK
        CASE 89 RETURN "IG_TAOCHENG" BREAK
        CASE 90 RETURN "IG_TAOSTRANSLATOR" BREAK
        CASE 91 RETURN "IG_TENNISCOACH" BREAK
        CASE 92 RETURN "IG_TERRY" BREAK
        CASE 93 RETURN "IG_TOMEPSILON" BREAK
        CASE 94 RETURN "IG_TONYA" BREAK
        CASE 95 RETURN "IG_TRACYDISANTO" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_5(INT choice)
    SWITCH choice
        CASE 0 RETURN IG_TRAFFICWARDEN BREAK
        CASE 1 RETURN IG_TYLERDIX BREAK
        CASE 2 RETURN IG_WADE BREAK
        CASE 3 RETURN IG_ZIMBOR BREAK
        CASE 4 RETURN MP_F_DEADHOOKER BREAK
        CASE 5 RETURN MP_F_FREEMODE_01 BREAK
        CASE 6 RETURN MP_F_MISTY_01 BREAK
        CASE 7 RETURN MP_F_STRIPPERLITE BREAK
        CASE 8 RETURN MP_G_M_PROS_01 BREAK
        CASE 9 RETURN MP_HEADTARGETS BREAK
        CASE 10 RETURN MP_M_CLAUDE_01 BREAK
        CASE 11 RETURN MP_M_EXARMY_01 BREAK
        CASE 12 RETURN MP_M_FAMDD_01 BREAK
        CASE 13 RETURN MP_M_FIBSEC_01 BREAK
        CASE 14 RETURN MP_M_FREEMODE_01 BREAK
        CASE 15 RETURN MP_M_MARSTON_01 BREAK
        CASE 16 RETURN MP_M_NIKO_01 BREAK
        CASE 17 RETURN MP_M_SHOPKEEP_01 BREAK
        CASE 18 RETURN MP_S_M_ARMOURED_01 BREAK
        CASE 19 RETURN PLAYER_ONE BREAK
        CASE 20 RETURN PLAYER_TWO BREAK
        CASE 21 RETURN PLAYER_ZERO BREAK
        CASE 22 RETURN SLOD_HUMAN BREAK
        CASE 23 RETURN SLOD_LARGE_QUADPED BREAK
        CASE 24 RETURN SLOD_SMALL_QUADPED BREAK
        CASE 25 RETURN S_F_M_FEMBARBER BREAK
        CASE 26 RETURN S_F_M_MAID_01 BREAK
        CASE 27 RETURN S_F_M_SHOP_HIGH BREAK
        CASE 28 RETURN S_F_M_SWEATSHOP_01 BREAK
        CASE 29 RETURN S_F_Y_AIRHOSTESS_01 BREAK
        CASE 30 RETURN S_F_Y_BARTENDER_01 BREAK
        CASE 31 RETURN S_F_Y_BAYWATCH_01 BREAK
        CASE 32 RETURN S_F_Y_COP_01 BREAK
        CASE 33 RETURN S_F_Y_FACTORY_01 BREAK
        CASE 34 RETURN S_F_Y_HOOKER_01 BREAK
        CASE 35 RETURN S_F_Y_HOOKER_02 BREAK
        CASE 36 RETURN S_F_Y_HOOKER_03 BREAK
        CASE 37 RETURN S_F_Y_MIGRANT_01 BREAK
        CASE 38 RETURN S_F_Y_MOVPREM_01 BREAK
        CASE 39 RETURN S_F_Y_RANGER_01 BREAK
        CASE 40 RETURN S_F_Y_SCRUBS_01 BREAK
        CASE 41 RETURN S_F_Y_SHERIFF_01 BREAK
        CASE 42 RETURN S_F_Y_SHOP_LOW BREAK
        CASE 43 RETURN S_F_Y_SHOP_MID BREAK
        CASE 44 RETURN S_F_Y_STRIPPERLITE BREAK
        CASE 45 RETURN S_F_Y_STRIPPER_01 BREAK
        CASE 46 RETURN S_F_Y_STRIPPER_02 BREAK
        CASE 47 RETURN S_F_Y_SWEATSHOP_01 BREAK
        CASE 48 RETURN S_M_M_AMMUCOUNTRY BREAK
        CASE 49 RETURN S_M_M_ARMOURED_01 BREAK
        CASE 50 RETURN S_M_M_ARMOURED_02 BREAK
        CASE 51 RETURN S_M_M_AUTOSHOP_01 BREAK
        CASE 52 RETURN S_M_M_AUTOSHOP_02 BREAK
        CASE 53 RETURN S_M_M_BOUNCER_01 BREAK
        CASE 54 RETURN S_M_M_CHEMSEC_01 BREAK
        CASE 55 RETURN S_M_M_CIASEC_01 BREAK
        CASE 56 RETURN S_M_M_CNTRYBAR_01 BREAK
        CASE 57 RETURN S_M_M_DOCKWORK_01 BREAK
        CASE 58 RETURN S_M_M_DOCTOR_01 BREAK
        CASE 59 RETURN S_M_M_FIBOFFICE_01 BREAK
        CASE 60 RETURN S_M_M_FIBOFFICE_02 BREAK
        CASE 61 RETURN S_M_M_GAFFER_01 BREAK
        CASE 62 RETURN S_M_M_GARDENER_01 BREAK
        CASE 63 RETURN S_M_M_GENTRANSPORT BREAK
        CASE 64 RETURN S_M_M_HAIRDRESS_01 BREAK
        CASE 65 RETURN S_M_M_HIGHSEC_01 BREAK
        CASE 66 RETURN S_M_M_HIGHSEC_02 BREAK
        CASE 67 RETURN S_M_M_JANITOR BREAK
        CASE 68 RETURN S_M_M_LATHANDY_01 BREAK
        CASE 69 RETURN S_M_M_LIFEINVAD_01 BREAK
        CASE 70 RETURN S_M_M_LINECOOK BREAK
        CASE 71 RETURN S_M_M_LSMETRO_01 BREAK
        CASE 72 RETURN S_M_M_MARIACHI_01 BREAK
        CASE 73 RETURN S_M_M_MARINE_01 BREAK
        CASE 74 RETURN S_M_M_MARINE_02 BREAK
        CASE 75 RETURN S_M_M_MIGRANT_01 BREAK
        CASE 76 RETURN S_M_M_MOVALIEN_01 BREAK
        CASE 77 RETURN S_M_M_MOVPREM_01 BREAK
        CASE 78 RETURN S_M_M_MOVSPACE_01 BREAK
        CASE 79 RETURN S_M_M_PARAMEDIC_01 BREAK
        CASE 80 RETURN S_M_M_PILOT_01 BREAK
        CASE 81 RETURN S_M_M_PILOT_02 BREAK
        CASE 82 RETURN S_M_M_POSTAL_01 BREAK
        CASE 83 RETURN S_M_M_POSTAL_02 BREAK
        CASE 84 RETURN S_M_M_PRISGUARD_01 BREAK
        CASE 85 RETURN S_M_M_SCIENTIST_01 BREAK
        CASE 86 RETURN S_M_M_SECURITY_01 BREAK
        CASE 87 RETURN S_M_M_SNOWCOP_01 BREAK
        CASE 88 RETURN S_M_M_STRPERF_01 BREAK
        CASE 89 RETURN S_M_M_STRPREACH_01 BREAK
        CASE 90 RETURN S_M_M_STRVEND_01 BREAK
        CASE 91 RETURN S_M_M_TRUCKER_01 BREAK
        CASE 92 RETURN S_M_M_UPS_01 BREAK
        CASE 93 RETURN S_M_M_UPS_02 BREAK
        CASE 94 RETURN S_M_O_BUSKER_01 BREAK
        CASE 95 RETURN S_M_Y_AIRWORKER BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_5(INT choice)
    SWITCH choice
        CASE 0 RETURN "IG_TRAFFICWARDEN" BREAK
        CASE 1 RETURN "IG_TYLERDIX" BREAK
        CASE 2 RETURN "IG_WADE" BREAK
        CASE 3 RETURN "IG_ZIMBOR" BREAK
        CASE 4 RETURN "MP_F_DEADHOOKER" BREAK
        CASE 5 RETURN "MP_F_FREEMODE_01" BREAK
        CASE 6 RETURN "MP_F_MISTY_01" BREAK
        CASE 7 RETURN "MP_F_STRIPPERLITE" BREAK
        CASE 8 RETURN "MP_G_M_PROS_01" BREAK
        CASE 9 RETURN "MP_HEADTARGETS" BREAK
        CASE 10 RETURN "MP_M_CLAUDE_01" BREAK
        CASE 11 RETURN "MP_M_EXARMY_01" BREAK
        CASE 12 RETURN "MP_M_FAMDD_01" BREAK
        CASE 13 RETURN "MP_M_FIBSEC_01" BREAK
        CASE 14 RETURN "MP_M_FREEMODE_01" BREAK
        CASE 15 RETURN "MP_M_MARSTON_01" BREAK
        CASE 16 RETURN "MP_M_NIKO_01" BREAK
        CASE 17 RETURN "MP_M_SHOPKEEP_01" BREAK
        CASE 18 RETURN "MP_S_M_ARMOURED_01" BREAK
        CASE 19 RETURN "PLAYER_ONE" BREAK
        CASE 20 RETURN "PLAYER_TWO" BREAK
        CASE 21 RETURN "PLAYER_ZERO" BREAK
        CASE 22 RETURN "SLOD_HUMAN" BREAK
        CASE 23 RETURN "SLOD_LARGE_QUADPED" BREAK
        CASE 24 RETURN "SLOD_SMALL_QUADPED" BREAK
        CASE 25 RETURN "S_F_M_FEMBARBER" BREAK
        CASE 26 RETURN "S_F_M_MAID_01" BREAK
        CASE 27 RETURN "S_F_M_SHOP_HIGH" BREAK
        CASE 28 RETURN "S_F_M_SWEATSHOP_01" BREAK
        CASE 29 RETURN "S_F_Y_AIRHOSTESS_01" BREAK
        CASE 30 RETURN "S_F_Y_BARTENDER_01" BREAK
        CASE 31 RETURN "S_F_Y_BAYWATCH_01" BREAK
        CASE 32 RETURN "S_F_Y_COP_01" BREAK
        CASE 33 RETURN "S_F_Y_FACTORY_01" BREAK
        CASE 34 RETURN "S_F_Y_HOOKER_01" BREAK
        CASE 35 RETURN "S_F_Y_HOOKER_02" BREAK
        CASE 36 RETURN "S_F_Y_HOOKER_03" BREAK
        CASE 37 RETURN "S_F_Y_MIGRANT_01" BREAK
        CASE 38 RETURN "S_F_Y_MOVPREM_01" BREAK
        CASE 39 RETURN "S_F_Y_RANGER_01" BREAK
        CASE 40 RETURN "S_F_Y_SCRUBS_01" BREAK
        CASE 41 RETURN "S_F_Y_SHERIFF_01" BREAK
        CASE 42 RETURN "S_F_Y_SHOP_LOW" BREAK
        CASE 43 RETURN "S_F_Y_SHOP_MID" BREAK
        CASE 44 RETURN "S_F_Y_STRIPPERLITE" BREAK
        CASE 45 RETURN "S_F_Y_STRIPPER_01" BREAK
        CASE 46 RETURN "S_F_Y_STRIPPER_02" BREAK
        CASE 47 RETURN "S_F_Y_SWEATSHOP_01" BREAK
        CASE 48 RETURN "S_M_M_AMMUCOUNTRY" BREAK
        CASE 49 RETURN "S_M_M_ARMOURED_01" BREAK
        CASE 50 RETURN "S_M_M_ARMOURED_02" BREAK
        CASE 51 RETURN "S_M_M_AUTOSHOP_01" BREAK
        CASE 52 RETURN "S_M_M_AUTOSHOP_02" BREAK
        CASE 53 RETURN "S_M_M_BOUNCER_01" BREAK
        CASE 54 RETURN "S_M_M_CHEMSEC_01" BREAK
        CASE 55 RETURN "S_M_M_CIASEC_01" BREAK
        CASE 56 RETURN "S_M_M_CNTRYBAR_01" BREAK
        CASE 57 RETURN "S_M_M_DOCKWORK_01" BREAK
        CASE 58 RETURN "S_M_M_DOCTOR_01" BREAK
        CASE 59 RETURN "S_M_M_FIBOFFICE_01" BREAK
        CASE 60 RETURN "S_M_M_FIBOFFICE_02" BREAK
        CASE 61 RETURN "S_M_M_GAFFER_01" BREAK
        CASE 62 RETURN "S_M_M_GARDENER_01" BREAK
        CASE 63 RETURN "S_M_M_GENTRANSPORT" BREAK
        CASE 64 RETURN "S_M_M_HAIRDRESS_01" BREAK
        CASE 65 RETURN "S_M_M_HIGHSEC_01" BREAK
        CASE 66 RETURN "S_M_M_HIGHSEC_02" BREAK
        CASE 67 RETURN "S_M_M_JANITOR" BREAK
        CASE 68 RETURN "S_M_M_LATHANDY_01" BREAK
        CASE 69 RETURN "S_M_M_LIFEINVAD_01" BREAK
        CASE 70 RETURN "S_M_M_LINECOOK" BREAK
        CASE 71 RETURN "S_M_M_LSMETRO_01" BREAK
        CASE 72 RETURN "S_M_M_MARIACHI_01" BREAK
        CASE 73 RETURN "S_M_M_MARINE_01" BREAK
        CASE 74 RETURN "S_M_M_MARINE_02" BREAK
        CASE 75 RETURN "S_M_M_MIGRANT_01" BREAK
        CASE 76 RETURN "S_M_M_MOVALIEN_01" BREAK
        CASE 77 RETURN "S_M_M_MOVPREM_01" BREAK
        CASE 78 RETURN "S_M_M_MOVSPACE_01" BREAK
        CASE 79 RETURN "S_M_M_PARAMEDIC_01" BREAK
        CASE 80 RETURN "S_M_M_PILOT_01" BREAK
        CASE 81 RETURN "S_M_M_PILOT_02" BREAK
        CASE 82 RETURN "S_M_M_POSTAL_01" BREAK
        CASE 83 RETURN "S_M_M_POSTAL_02" BREAK
        CASE 84 RETURN "S_M_M_PRISGUARD_01" BREAK
        CASE 85 RETURN "S_M_M_SCIENTIST_01" BREAK
        CASE 86 RETURN "S_M_M_SECURITY_01" BREAK
        CASE 87 RETURN "S_M_M_SNOWCOP_01" BREAK
        CASE 88 RETURN "S_M_M_STRPERF_01" BREAK
        CASE 89 RETURN "S_M_M_STRPREACH_01" BREAK
        CASE 90 RETURN "S_M_M_STRVEND_01" BREAK
        CASE 91 RETURN "S_M_M_TRUCKER_01" BREAK
        CASE 92 RETURN "S_M_M_UPS_01" BREAK
        CASE 93 RETURN "S_M_M_UPS_02" BREAK
        CASE 94 RETURN "S_M_O_BUSKER_01" BREAK
        CASE 95 RETURN "S_M_Y_AIRWORKER" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_6(INT choice)
    SWITCH choice
        CASE 0 RETURN S_M_Y_AMMUCITY_01 BREAK
        CASE 1 RETURN S_M_Y_ARMYMECH_01 BREAK
        CASE 2 RETURN S_M_Y_AUTOPSY_01 BREAK
        CASE 3 RETURN S_M_Y_BARMAN_01 BREAK
        CASE 4 RETURN S_M_Y_BAYWATCH_01 BREAK
        CASE 5 RETURN S_M_Y_BLACKOPS_01 BREAK
        CASE 6 RETURN S_M_Y_BLACKOPS_02 BREAK
        CASE 7 RETURN S_M_Y_BUSBOY_01 BREAK
        CASE 8 RETURN S_M_Y_CHEF_01 BREAK
        CASE 9 RETURN S_M_Y_CLOWN_01 BREAK
        CASE 10 RETURN S_M_Y_CONSTRUCT_01 BREAK
        CASE 11 RETURN S_M_Y_CONSTRUCT_02 BREAK
        CASE 12 RETURN S_M_Y_COP_01 BREAK
        CASE 13 RETURN S_M_Y_DEALER_01 BREAK
        CASE 14 RETURN S_M_Y_DEVINSEC_01 BREAK
        CASE 15 RETURN S_M_Y_DOCKWORK_01 BREAK
        CASE 16 RETURN S_M_Y_DOORMAN_01 BREAK
        CASE 17 RETURN S_M_Y_DWSERVICE_01 BREAK
        CASE 18 RETURN S_M_Y_DWSERVICE_02 BREAK
        CASE 19 RETURN S_M_Y_FACTORY_01 BREAK
        CASE 20 RETURN S_M_Y_FIREMAN_01 BREAK
        CASE 21 RETURN S_M_Y_GARBAGE BREAK
        CASE 22 RETURN S_M_Y_GRIP_01 BREAK
        CASE 23 RETURN S_M_Y_HWAYCOP_01 BREAK
        CASE 24 RETURN S_M_Y_MARINE_01 BREAK
        CASE 25 RETURN S_M_Y_MARINE_02 BREAK
        CASE 26 RETURN S_M_Y_MARINE_03 BREAK
        CASE 27 RETURN S_M_Y_MIME BREAK
        CASE 28 RETURN S_M_Y_PESTCONT_01 BREAK
        CASE 29 RETURN S_M_Y_PILOT_01 BREAK
        CASE 30 RETURN S_M_Y_PRISMUSCL_01 BREAK
        CASE 31 RETURN S_M_Y_PRISONER_01 BREAK
        CASE 32 RETURN S_M_Y_RANGER_01 BREAK
        CASE 33 RETURN S_M_Y_ROBBER_01 BREAK
        CASE 34 RETURN S_M_Y_SHERIFF_01 BREAK
        CASE 35 RETURN S_M_Y_SHOP_MASK BREAK
        CASE 36 RETURN S_M_Y_STRVEND_01 BREAK
        CASE 37 RETURN S_M_Y_SWAT_01 BREAK
        CASE 38 RETURN S_M_Y_USCG_01 BREAK
        CASE 39 RETURN S_M_Y_VALET_01 BREAK
        CASE 40 RETURN S_M_Y_WAITER_01 BREAK
        CASE 41 RETURN S_M_Y_WINCLEAN_01 BREAK
        CASE 42 RETURN S_M_Y_XMECH_01 BREAK
        CASE 43 RETURN S_M_Y_XMECH_02 BREAK
        CASE 44 RETURN U_F_M_CORPSE_01 BREAK
        CASE 45 RETURN U_F_M_DROWNED_01 BREAK
        CASE 46 RETURN U_F_M_MIRANDA BREAK
        CASE 47 RETURN U_F_M_PROMOURN_01 BREAK
        CASE 48 RETURN U_F_O_MOVIESTAR BREAK
        CASE 49 RETURN U_F_O_PROLHOST_01 BREAK
        CASE 50 RETURN U_F_Y_BIKERCHIC BREAK
        CASE 51 RETURN U_F_Y_COMJANE BREAK
        CASE 52 RETURN U_F_Y_CORPSE_01 BREAK
        CASE 53 RETURN U_F_Y_CORPSE_02 BREAK
        CASE 54 RETURN U_F_Y_HOTPOSH_01 BREAK
        CASE 55 RETURN U_F_Y_JEWELASS_01 BREAK
        CASE 56 RETURN U_F_Y_MISTRESS BREAK
        CASE 57 RETURN U_F_Y_POPPYMICH BREAK
        CASE 58 RETURN U_F_Y_PRINCESS BREAK
        CASE 59 RETURN U_F_Y_SPYACTRESS BREAK
        CASE 60 RETURN U_M_M_ALDINAPOLI BREAK
        CASE 61 RETURN U_M_M_BANKMAN BREAK
        CASE 62 RETURN U_M_M_BIKEHIRE_01 BREAK
        CASE 63 RETURN U_M_M_FIBARCHITECT BREAK
        CASE 64 RETURN U_M_M_FILMDIRECTOR BREAK
        CASE 65 RETURN U_M_M_GLENSTANK_01 BREAK
        CASE 66 RETURN U_M_M_GRIFF_01 BREAK
        CASE 67 RETURN U_M_M_JESUS_01 BREAK
        CASE 68 RETURN U_M_M_JEWELSEC_01 BREAK
        CASE 69 RETURN U_M_M_JEWELTHIEF BREAK
        CASE 70 RETURN U_M_M_MARKFOST BREAK
        CASE 71 RETURN U_M_M_PARTYTARGET BREAK
        CASE 72 RETURN U_M_M_PROLSEC_01 BREAK
        CASE 73 RETURN U_M_M_PROMOURN_01 BREAK
        CASE 74 RETURN U_M_M_RIVALPAP BREAK
        CASE 75 RETURN U_M_M_SPYACTOR BREAK
        CASE 76 RETURN U_M_M_STREETART_01 BREAK
        CASE 77 RETURN U_M_M_WILLYFIST BREAK
        CASE 78 RETURN U_M_O_FILMNOIR BREAK
        CASE 79 RETURN U_M_O_FINGURU_01 BREAK
        CASE 80 RETURN U_M_O_TAPHILLBILLY BREAK
        CASE 81 RETURN U_M_O_TRAMP_01 BREAK
        CASE 82 RETURN U_M_Y_ABNER BREAK
        CASE 83 RETURN U_M_Y_ANTONB BREAK
        CASE 84 RETURN U_M_Y_BABYD BREAK
        CASE 85 RETURN U_M_Y_BAYGOR BREAK
        CASE 86 RETURN U_M_Y_BURGERDRUG_01 BREAK
        CASE 87 RETURN U_M_Y_CHIP BREAK
        CASE 88 RETURN U_M_Y_CYCLIST_01 BREAK
        CASE 89 RETURN U_M_Y_FIBMUGGER_01 BREAK
        CASE 90 RETURN U_M_Y_GUIDO_01 BREAK
        CASE 91 RETURN U_M_Y_GUNVEND_01 BREAK
        CASE 92 RETURN U_M_Y_HIPPIE_01 BREAK
        CASE 93 RETURN U_M_Y_IMPORAGE BREAK
        CASE 94 RETURN U_M_Y_JUSTIN BREAK
        CASE 95 RETURN U_M_Y_MANI BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_6(INT choice)
    SWITCH choice
        CASE 0 RETURN "S_M_Y_AMMUCITY_01" BREAK
        CASE 1 RETURN "S_M_Y_ARMYMECH_01" BREAK
        CASE 2 RETURN "S_M_Y_AUTOPSY_01" BREAK
        CASE 3 RETURN "S_M_Y_BARMAN_01" BREAK
        CASE 4 RETURN "S_M_Y_BAYWATCH_01" BREAK
        CASE 5 RETURN "S_M_Y_BLACKOPS_01" BREAK
        CASE 6 RETURN "S_M_Y_BLACKOPS_02" BREAK
        CASE 7 RETURN "S_M_Y_BUSBOY_01" BREAK
        CASE 8 RETURN "S_M_Y_CHEF_01" BREAK
        CASE 9 RETURN "S_M_Y_CLOWN_01" BREAK
        CASE 10 RETURN "S_M_Y_CONSTRUCT_01" BREAK
        CASE 11 RETURN "S_M_Y_CONSTRUCT_02" BREAK
        CASE 12 RETURN "S_M_Y_COP_01" BREAK
        CASE 13 RETURN "S_M_Y_DEALER_01" BREAK
        CASE 14 RETURN "S_M_Y_DEVINSEC_01" BREAK
        CASE 15 RETURN "S_M_Y_DOCKWORK_01" BREAK
        CASE 16 RETURN "S_M_Y_DOORMAN_01" BREAK
        CASE 17 RETURN "S_M_Y_DWSERVICE_01" BREAK
        CASE 18 RETURN "S_M_Y_DWSERVICE_02" BREAK
        CASE 19 RETURN "S_M_Y_FACTORY_01" BREAK
        CASE 20 RETURN "S_M_Y_FIREMAN_01" BREAK
        CASE 21 RETURN "S_M_Y_GARBAGE" BREAK
        CASE 22 RETURN "S_M_Y_GRIP_01" BREAK
        CASE 23 RETURN "S_M_Y_HWAYCOP_01" BREAK
        CASE 24 RETURN "S_M_Y_MARINE_01" BREAK
        CASE 25 RETURN "S_M_Y_MARINE_02" BREAK
        CASE 26 RETURN "S_M_Y_MARINE_03" BREAK
        CASE 27 RETURN "S_M_Y_MIME" BREAK
        CASE 28 RETURN "S_M_Y_PESTCONT_01" BREAK
        CASE 29 RETURN "S_M_Y_PILOT_01" BREAK
        CASE 30 RETURN "S_M_Y_PRISMUSCL_01" BREAK
        CASE 31 RETURN "S_M_Y_PRISONER_01" BREAK
        CASE 32 RETURN "S_M_Y_RANGER_01" BREAK
        CASE 33 RETURN "S_M_Y_ROBBER_01" BREAK
        CASE 34 RETURN "S_M_Y_SHERIFF_01" BREAK
        CASE 35 RETURN "S_M_Y_SHOP_MASK" BREAK
        CASE 36 RETURN "S_M_Y_STRVEND_01" BREAK
        CASE 37 RETURN "S_M_Y_SWAT_01" BREAK
        CASE 38 RETURN "S_M_Y_USCG_01" BREAK
        CASE 39 RETURN "S_M_Y_VALET_01" BREAK
        CASE 40 RETURN "S_M_Y_WAITER_01" BREAK
        CASE 41 RETURN "S_M_Y_WINCLEAN_01" BREAK
        CASE 42 RETURN "S_M_Y_XMECH_01" BREAK
        CASE 43 RETURN "S_M_Y_XMECH_02" BREAK
        CASE 44 RETURN "U_F_M_CORPSE_01" BREAK
        CASE 45 RETURN "U_F_M_DROWNED_01" BREAK
        CASE 46 RETURN "U_F_M_MIRANDA" BREAK
        CASE 47 RETURN "U_F_M_PROMOURN_01" BREAK
        CASE 48 RETURN "U_F_O_MOVIESTAR" BREAK
        CASE 49 RETURN "U_F_O_PROLHOST_01" BREAK
        CASE 50 RETURN "U_F_Y_BIKERCHIC" BREAK
        CASE 51 RETURN "U_F_Y_COMJANE" BREAK
        CASE 52 RETURN "U_F_Y_CORPSE_01" BREAK
        CASE 53 RETURN "U_F_Y_CORPSE_02" BREAK
        CASE 54 RETURN "U_F_Y_HOTPOSH_01" BREAK
        CASE 55 RETURN "U_F_Y_JEWELASS_01" BREAK
        CASE 56 RETURN "U_F_Y_MISTRESS" BREAK
        CASE 57 RETURN "U_F_Y_POPPYMICH" BREAK
        CASE 58 RETURN "U_F_Y_PRINCESS" BREAK
        CASE 59 RETURN "U_F_Y_SPYACTRESS" BREAK
        CASE 60 RETURN "U_M_M_ALDINAPOLI" BREAK
        CASE 61 RETURN "U_M_M_BANKMAN" BREAK
        CASE 62 RETURN "U_M_M_BIKEHIRE_01" BREAK
        CASE 63 RETURN "U_M_M_FIBARCHITECT" BREAK
        CASE 64 RETURN "U_M_M_FILMDIRECTOR" BREAK
        CASE 65 RETURN "U_M_M_GLENSTANK_01" BREAK
        CASE 66 RETURN "U_M_M_GRIFF_01" BREAK
        CASE 67 RETURN "U_M_M_JESUS_01" BREAK
        CASE 68 RETURN "U_M_M_JEWELSEC_01" BREAK
        CASE 69 RETURN "U_M_M_JEWELTHIEF" BREAK
        CASE 70 RETURN "U_M_M_MARKFOST" BREAK
        CASE 71 RETURN "U_M_M_PARTYTARGET" BREAK
        CASE 72 RETURN "U_M_M_PROLSEC_01" BREAK
        CASE 73 RETURN "U_M_M_PROMOURN_01" BREAK
        CASE 74 RETURN "U_M_M_RIVALPAP" BREAK
        CASE 75 RETURN "U_M_M_SPYACTOR" BREAK
        CASE 76 RETURN "U_M_M_STREETART_01" BREAK
        CASE 77 RETURN "U_M_M_WILLYFIST" BREAK
        CASE 78 RETURN "U_M_O_FILMNOIR" BREAK
        CASE 79 RETURN "U_M_O_FINGURU_01" BREAK
        CASE 80 RETURN "U_M_O_TAPHILLBILLY" BREAK
        CASE 81 RETURN "U_M_O_TRAMP_01" BREAK
        CASE 82 RETURN "U_M_Y_ABNER" BREAK
        CASE 83 RETURN "U_M_Y_ANTONB" BREAK
        CASE 84 RETURN "U_M_Y_BABYD" BREAK
        CASE 85 RETURN "U_M_Y_BAYGOR" BREAK
        CASE 86 RETURN "U_M_Y_BURGERDRUG_01" BREAK
        CASE 87 RETURN "U_M_Y_CHIP" BREAK
        CASE 88 RETURN "U_M_Y_CYCLIST_01" BREAK
        CASE 89 RETURN "U_M_Y_FIBMUGGER_01" BREAK
        CASE 90 RETURN "U_M_Y_GUIDO_01" BREAK
        CASE 91 RETURN "U_M_Y_GUNVEND_01" BREAK
        CASE 92 RETURN "U_M_Y_HIPPIE_01" BREAK
        CASE 93 RETURN "U_M_Y_IMPORAGE" BREAK
        CASE 94 RETURN "U_M_Y_JUSTIN" BREAK
        CASE 95 RETURN "U_M_Y_MANI" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_PAGE_7(INT choice)
    SWITCH choice
        CASE 0 RETURN U_M_Y_MILITARYBUM BREAK
        CASE 1 RETURN U_M_Y_PAPARAZZI BREAK
        CASE 2 RETURN U_M_Y_PARTY_01 BREAK
        CASE 3 RETURN U_M_Y_POGO_01 BREAK
        CASE 4 RETURN U_M_Y_PRISONER_01 BREAK
        CASE 5 RETURN U_M_Y_PROLDRIVER_01 BREAK
        CASE 6 RETURN U_M_Y_RSRANGER_01 BREAK
        CASE 7 RETURN U_M_Y_SBIKE BREAK
        CASE 8 RETURN U_M_Y_STAGGRM_01 BREAK
        CASE 9 RETURN U_M_Y_TATTOO_01 BREAK
        CASE 10 RETURN U_M_Y_ZOMBIE_01 BREAK
    ENDSWITCH
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_PAGE_7(INT choice)
    SWITCH choice
        CASE 0 RETURN "U_M_Y_MILITARYBUM" BREAK
        CASE 1 RETURN "U_M_Y_PAPARAZZI" BREAK
        CASE 2 RETURN "U_M_Y_PARTY_01" BREAK
        CASE 3 RETURN "U_M_Y_POGO_01" BREAK
        CASE 4 RETURN "U_M_Y_PRISONER_01" BREAK
        CASE 5 RETURN "U_M_Y_PROLDRIVER_01" BREAK
        CASE 6 RETURN "U_M_Y_RSRANGER_01" BREAK
        CASE 7 RETURN "U_M_Y_SBIKE" BREAK
        CASE 8 RETURN "U_M_Y_STAGGRM_01" BREAK
        CASE 9 RETURN "U_M_Y_TATTOO_01" BREAK
        CASE 10 RETURN "U_M_Y_ZOMBIE_01" BREAK
    ENDSWITCH
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC MODEL_NAMES PED_MODEL_FOR_CHOICE(INT choice)
    IF choice < 0 OR choice >= PED_CHOICE_COUNT() RETURN PLAYER_ZERO ENDIF
    IF choice < 96 RETURN PED_MODEL_PAGE_0(choice - 0) ENDIF
    IF choice < 192 RETURN PED_MODEL_PAGE_1(choice - 96) ENDIF
    IF choice < 288 RETURN PED_MODEL_PAGE_2(choice - 192) ENDIF
    IF choice < 384 RETURN PED_MODEL_PAGE_3(choice - 288) ENDIF
    IF choice < 480 RETURN PED_MODEL_PAGE_4(choice - 384) ENDIF
    IF choice < 576 RETURN PED_MODEL_PAGE_5(choice - 480) ENDIF
    IF choice < 672 RETURN PED_MODEL_PAGE_6(choice - 576) ENDIF
    IF choice < 768 RETURN PED_MODEL_PAGE_7(choice - 672) ENDIF
    RETURN PLAYER_ZERO
ENDFUNC

FUNC STRING PED_NAME_FOR_CHOICE(INT choice)
    IF choice < 0 OR choice >= PED_CHOICE_COUNT() RETURN "UNKNOWN_PED" ENDIF
    IF choice < 96 RETURN PED_NAME_PAGE_0(choice - 0) ENDIF
    IF choice < 192 RETURN PED_NAME_PAGE_1(choice - 96) ENDIF
    IF choice < 288 RETURN PED_NAME_PAGE_2(choice - 192) ENDIF
    IF choice < 384 RETURN PED_NAME_PAGE_3(choice - 288) ENDIF
    IF choice < 480 RETURN PED_NAME_PAGE_4(choice - 384) ENDIF
    IF choice < 576 RETURN PED_NAME_PAGE_5(choice - 480) ENDIF
    IF choice < 672 RETURN PED_NAME_PAGE_6(choice - 576) ENDIF
    IF choice < 768 RETURN PED_NAME_PAGE_7(choice - 672) ENDIF
    RETURN "UNKNOWN_PED"
ENDFUNC

FUNC INT FIND_PED_CHOICE_BY_NAME(STRING modelName)
    INT wantedHash = GET_HASH_KEY(modelName)
    INT choice = 0
    WHILE choice < PED_CHOICE_COUNT()
        IF GET_HASH_KEY(PED_NAME_FOR_CHOICE(choice)) = wantedHash RETURN choice ENDIF
        choice = choice + 1
    ENDWHILE
    RETURN -1
ENDFUNC

PROC SAVE_ACTIVE_CHARACTER_PED()
    MODEL_NAMES currentModel = GET_ENTITY_MODEL(PLAYER_PED_ID())
    IF g_character_slot = 0 g_franklin_ped = currentModel ENDIF
    IF g_character_slot = 1 g_michael_ped = currentModel ENDIF
    IF g_character_slot = 2 g_trevor_ped = currentModel ENDIF
ENDPROC

FUNC MODEL_NAMES SAVED_CHARACTER_PED(INT slot)
    IF slot = 0 RETURN g_franklin_ped ENDIF
    IF slot = 1 RETURN g_michael_ped ENDIF
    RETURN g_trevor_ped
ENDFUNC

FUNC INT PED_CHOICE_FOR_MODEL(MODEL_NAMES model)
    INT choice = 0
    WHILE choice < PED_CHOICE_COUNT()
        IF PED_MODEL_FOR_CHOICE(choice) = model RETURN choice ENDIF
        choice = choice + 1
    ENDWHILE
    RETURN 0
ENDFUNC

PROC REQUEST_PED_CHANGE(MODEL_NAMES model)
    IF g_ped_change_pending OR IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model) EXIT ENDIF
    REQUEST_MODEL(model)
    g_pending_ped_model = model
    g_ped_change_pending = TRUE
    g_ped_request_time = GET_GAME_TIMER()
ENDPROC

PROC FINISH_PED_CHANGE()
    IF HAS_MODEL_LOADED(g_pending_ped_model)
        SET_PLAYER_MODEL(PLAYER_ID(), g_pending_ped_model)
        SET_PED_DEFAULT_COMPONENT_VARIATION(PLAYER_PED_ID())
        SAVE_ACTIVE_CHARACTER_PED()
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_ped_model)
    g_ped_change_pending = FALSE
ENDPROC

PROC APPLY_CHARACTER_PROFILE(INT slot)
    g_character_slot = slot
    REQUEST_PED_CHANGE(SAVED_CHARACTER_PED(slot))
ENDPROC

PROC ADJUST_PED_SELECTOR(INT direction)
    INT nextSlot = 0
    IF g_item = 1
        nextSlot = g_character_slot + direction
        IF nextSlot < 0 nextSlot = 2 ENDIF
        IF nextSlot > 2 nextSlot = 0 ENDIF
        SAVE_ACTIVE_CHARACTER_PED()
        APPLY_CHARACTER_PROFILE(nextSlot)
    ENDIF
ENDPROC

PROC DRAW_CHARACTER_PROFILE(FLOAT y, BOOL selected)
    IF g_character_slot = 0 DRAW_OPTION(y, "Character Profile:", "< Franklin >", selected, 3) ENDIF
    IF g_character_slot = 1 DRAW_OPTION(y, "Character Profile:", "< Michael >", selected, 3) ENDIF
    IF g_character_slot = 2 DRAW_OPTION(y, "Character Profile:", "< Trevor >", selected, 3) ENDIF
ENDPROC

PROC DRAW_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PED CHANGER")
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_ped_search_not_found
                DRAW_OPTION(y, "PED Search", "Not Found", g_item = index, 0)
            ELIF g_ped_search_has_value
                DRAW_OPTION(y, "PED Search", g_ped_search_value, g_item = index, 1)
            ELSE
                DRAW_OPTION(y, "PED Search", "TYPE NAME", g_item = index, 2)
            ENDIF
        ELIF index = 1
            DRAW_CHARACTER_PROFILE(y, g_item = index)
        ELSE
            DRAW_OPTION(y, "PED:", PED_NAME_FOR_CHOICE(index - 2), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC ADJUST_OUTFIT_SLOT(INT direction)
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT current = 0
    INT count = 0
    INT next = 0
    INT texture = 0
    IF g_item < NUM_PED_COMPONENTS
        PED_COMPONENT component = INT_TO_ENUM(PED_COMPONENT, g_item)
        current = GET_PED_DRAWABLE_VARIATION(playerPed, component)
        count = GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, component)
        IF count <= 0 EXIT ENDIF
        next = current + direction
        IF next < 0 next = count - 1 ENDIF
        IF next >= count next = 0 ENDIF
        texture = GET_PED_TEXTURE_VARIATION(playerPed, component)
        IF texture >= GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, component, next) texture = 0 ENDIF
        SET_PED_COMPONENT_VARIATION(playerPed, component, next, texture)
    ELSE
        PED_PROP_POSITION prop = INT_TO_ENUM(PED_PROP_POSITION, g_item - NUM_PED_COMPONENTS)
        current = GET_PED_PROP_INDEX(playerPed, prop)
        count = GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(playerPed, prop)
        IF count <= 0 EXIT ENDIF
        next = current + direction
        IF next < -1 next = count - 1 ENDIF
        IF next >= count next = -1 ENDIF
        IF next = -1
            CLEAR_PED_PROP(playerPed, prop)
        ELSE
            texture = GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(playerPed, prop, next)
            SET_PED_PROP_INDEX(playerPed, prop, next, 0)
        ENDIF
    ENDIF
ENDPROC

PROC ADJUST_OUTFIT_TEXTURE()
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT drawable = 0
    INT texture = 0
    INT textureCount = 0
    IF g_item < NUM_PED_COMPONENTS
        PED_COMPONENT component = INT_TO_ENUM(PED_COMPONENT, g_item)
        drawable = GET_PED_DRAWABLE_VARIATION(playerPed, component)
        texture = GET_PED_TEXTURE_VARIATION(playerPed, component)
        textureCount = GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, component, drawable)
        IF textureCount <= 0 EXIT ENDIF
        texture = texture + 1
        IF texture >= textureCount texture = 0 ENDIF
        SET_PED_COMPONENT_VARIATION(playerPed, component, drawable, texture)
    ELSE
        PED_PROP_POSITION prop = INT_TO_ENUM(PED_PROP_POSITION, g_item - NUM_PED_COMPONENTS)
        drawable = GET_PED_PROP_INDEX(playerPed, prop)
        IF drawable < 0 EXIT ENDIF
        texture = GET_PED_PROP_TEXTURE_INDEX(playerPed, prop)
        textureCount = GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(playerPed, prop, drawable)
        IF textureCount <= 0 EXIT ENDIF
        texture = texture + 1
        IF texture >= textureCount texture = 0 ENDIF
        SET_PED_PROP_INDEX(playerPed, prop, drawable, texture)
    ENDIF
ENDPROC

PROC DRAW_OUTFIT_ROW(INT index, FLOAT y)
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT current = 0
    STRING label = "Outfit item"
    IF index = 0 label = "Head" ENDIF
    IF index = 1 label = "Beard / Mask" ENDIF
    IF index = 2 label = "Hair" ENDIF
    IF index = 3 label = "Torso" ENDIF
    IF index = 4 label = "Legs / Pants" ENDIF
    IF index = 5 label = "Hands / Gloves" ENDIF
    IF index = 6 label = "Shoes" ENDIF
    IF index = 7 label = "Teeth" ENDIF
    IF index = 8 label = "Undershirt" ENDIF
    IF index = 9 label = "Body Armour" ENDIF
    IF index = 10 label = "Decal" ENDIF
    IF index = 11 label = "Jacket / Top" ENDIF
    IF index = 12 label = "Hat" ENDIF
    IF index = 13 label = "Glasses" ENDIF
    IF index = 14 label = "Ears" ENDIF
    IF index = 15 label = "Prop 3" ENDIF
    IF index = 16 label = "Prop 4" ENDIF
    IF index = 17 label = "Prop 5" ENDIF
    IF index = 18 label = "Watch" ENDIF
    IF index = 19 label = "Bracelet" ENDIF
    IF index = 20 label = "Prop 8" ENDIF
    IF index < NUM_PED_COMPONENTS
        current = GET_PED_DRAWABLE_VARIATION(playerPed, INT_TO_ENUM(PED_COMPONENT, index))
        DRAW_NUMBER_OPTION(y, label, current, g_item = index)
    ELSE
        current = GET_PED_PROP_INDEX(playerPed, INT_TO_ENUM(PED_PROP_POSITION, index - NUM_PED_COMPONENTS))
        DRAW_NUMBER_OPTION(y, label, current, g_item = index)
    ENDIF
ENDPROC

PROC DRAW_OUTFIT_PAGE()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 21
        DRAW_OUTFIT_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
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
        CASE 26 RETURN ENUM_TO_INT(MOD_WING_L) BREAK
        CASE 27 RETURN ENUM_TO_INT(MOD_WING_R) BREAK
        CASE 28 RETURN ENUM_TO_INT(MOD_REAR_WHEELS) BREAK
        CASE 29 RETURN ENUM_TO_INT(MOD_KNOB) BREAK
        CASE 30 RETURN ENUM_TO_INT(MOD_PLAQUE) BREAK
        CASE 31 RETURN ENUM_TO_INT(MOD_ICE) BREAK
        CASE 32 RETURN ENUM_TO_INT(MOD_TRUNK) BREAK
        CASE 33 RETURN ENUM_TO_INT(MOD_HYDRO) BREAK
        CASE 34 RETURN ENUM_TO_INT(MOD_ENGINEBAY1) BREAK
        CASE 35 RETURN ENUM_TO_INT(MOD_ENGINEBAY2) BREAK
        CASE 36 RETURN ENUM_TO_INT(MOD_ENGINEBAY3) BREAK
        CASE 37 RETURN ENUM_TO_INT(MOD_CHASSIS2) BREAK
        CASE 38 RETURN ENUM_TO_INT(MOD_CHASSIS3) BREAK
        CASE 39 RETURN ENUM_TO_INT(MOD_CHASSIS4) BREAK
        CASE 40 RETURN ENUM_TO_INT(MOD_CHASSIS5) BREAK
        CASE 41 RETURN ENUM_TO_INT(MOD_DOOR_L) BREAK
        CASE 42 RETURN ENUM_TO_INT(MOD_DOOR_R) BREAK
    ENDSWITCH
    RETURN ENUM_TO_INT(MOD_SPOILER)
ENDFUNC

PROC APPLY_LSC_MOD()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available <= 0
        g_lsc_mod_choice = -1
        EXIT
    ENDIF
    IF g_lsc_mod_choice < 0
        REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    ELSE
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()), g_lsc_mod_choice)
    ENDIF
ENDPROC

PROC SYNC_LSC_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    g_lsc_mod_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
ENDPROC

PROC ADJUST_LSC_MOD(INT direction)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available <= 0
        g_lsc_mod_choice = -1
        EXIT
    ENDIF
    g_lsc_mod_choice = g_lsc_mod_choice + direction
    IF g_lsc_mod_choice < -1 g_lsc_mod_choice = available - 1 ENDIF
    IF g_lsc_mod_choice >= available g_lsc_mod_choice = -1 ENDIF
    APPLY_LSC_MOD()
ENDPROC

FUNC INT LSC_COLOUR_ID(INT choice)
    SWITCH choice
        CASE 0 RETURN 0 BREAK
        CASE 1 RETURN 1 BREAK
        CASE 2 RETURN 3 BREAK
        CASE 3 RETURN 5 BREAK
        CASE 4 RETURN 12 BREAK
        CASE 5 RETURN 27 BREAK
        CASE 6 RETURN 28 BREAK
        CASE 7 RETURN 36 BREAK
        CASE 8 RETURN 38 BREAK
        CASE 9 RETURN 49 BREAK
        CASE 10 RETURN 53 BREAK
        CASE 11 RETURN 57 BREAK
        CASE 12 RETURN 64 BREAK
        CASE 13 RETURN 71 BREAK
        CASE 14 RETURN 88 BREAK
        CASE 15 RETURN 89 BREAK
        CASE 16 RETURN 92 BREAK
        CASE 17 RETURN 111 BREAK
        CASE 18 RETURN 120 BREAK
        CASE 19 RETURN 134 BREAK
        CASE 20 RETURN 135 BREAK
        CASE 21 RETURN 141 BREAK
        CASE 22 RETURN 143 BREAK
        CASE 23 RETURN 145 BREAK
        CASE 24 RETURN 151 BREAK
        CASE 25 RETURN 158 BREAK
        CASE 26 RETURN 160 BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

FUNC INT LSC_CHOICE_FOR_COLOUR(INT colour)
    SWITCH colour
        CASE 0 RETURN 0 BREAK
        CASE 1 RETURN 1 BREAK
        CASE 3 RETURN 2 BREAK
        CASE 5 RETURN 3 BREAK
        CASE 12 RETURN 4 BREAK
        CASE 27 RETURN 5 BREAK
        CASE 28 RETURN 6 BREAK
        CASE 36 RETURN 7 BREAK
        CASE 38 RETURN 8 BREAK
        CASE 49 RETURN 9 BREAK
        CASE 53 RETURN 10 BREAK
        CASE 57 RETURN 11 BREAK
        CASE 64 RETURN 12 BREAK
        CASE 71 RETURN 13 BREAK
        CASE 88 RETURN 14 BREAK
        CASE 89 RETURN 15 BREAK
        CASE 92 RETURN 16 BREAK
        CASE 111 RETURN 17 BREAK
        CASE 120 RETURN 18 BREAK
        CASE 134 RETURN 19 BREAK
        CASE 135 RETURN 20 BREAK
        CASE 141 RETURN 21 BREAK
        CASE 143 RETURN 22 BREAK
        CASE 145 RETURN 23 BREAK
        CASE 151 RETURN 24 BREAK
        CASE 158 RETURN 25 BREAK
        CASE 160 RETURN 26 BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

PROC SYNC_LSC_VEHICLE_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT primary = 0
    INT secondary = 0
    INT pearlescent = 0
    INT wheelColour = 0
    INT neonR = 0
    INT neonG = 0
    INT neonB = 0
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    GET_VEHICLE_COLOURS(vehicle, primary, secondary)
    GET_VEHICLE_EXTRA_COLOURS(vehicle, pearlescent, wheelColour)
    g_lsc_primary_colour = LSC_CHOICE_FOR_COLOUR(primary)
    g_lsc_secondary_colour = LSC_CHOICE_FOR_COLOUR(secondary)
    g_lsc_pearlescent_colour = LSC_CHOICE_FOR_COLOUR(pearlescent)
    g_lsc_wheel_colour = LSC_CHOICE_FOR_COLOUR(wheelColour)
    g_lsc_wheel_type = ENUM_TO_INT(GET_VEHICLE_WHEEL_TYPE(vehicle))
    g_lsc_turbo = IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_TURBO)
    g_lsc_xenon = IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_XENON_LIGHTS)
    g_lsc_xenon_colour = GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
    IF g_lsc_xenon_colour < 0 OR g_lsc_xenon_colour > 12 g_lsc_xenon_colour = 0 ENDIF
    g_lsc_neon = GET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT) OR GET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK) OR GET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT) OR GET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT)
    GET_VEHICLE_NEON_COLOUR(vehicle, neonR, neonG, neonB)
    IF neonR = 255 AND neonG = 255 AND neonB = 255 g_lsc_neon_colour = 0 ENDIF
    IF neonR = 0 AND neonG = 0 AND neonB = 255 g_lsc_neon_colour = 1 ENDIF
    IF neonR = 0 AND neonG = 150 AND neonB = 255 g_lsc_neon_colour = 2 ENDIF
    IF neonR = 50 AND neonG = 255 AND neonB = 155 g_lsc_neon_colour = 3 ENDIF
    IF neonR = 0 AND neonG = 255 AND neonB = 0 g_lsc_neon_colour = 4 ENDIF
    IF neonR = 255 AND neonG = 255 AND neonB = 0 g_lsc_neon_colour = 5 ENDIF
    IF neonR = 255 AND neonG = 200 AND neonB = 0 g_lsc_neon_colour = 6 ENDIF
    IF neonR = 255 AND neonG = 100 AND neonB = 0 g_lsc_neon_colour = 7 ENDIF
    IF neonR = 255 AND neonG = 0 AND neonB = 0 g_lsc_neon_colour = 8 ENDIF
    IF neonR = 255 AND neonG = 50 AND neonB = 100 g_lsc_neon_colour = 9 ENDIF
    IF neonR = 255 AND neonG = 0 AND neonB = 255 g_lsc_neon_colour = 10 ENDIF
    IF neonR = 160 AND neonG = 0 AND neonB = 255 g_lsc_neon_colour = 11 ENDIF
    IF neonR = 15 AND neonG = 3 AND neonB = 255 g_lsc_neon_colour = 12 ENDIF
    SYNC_LSC_SLOT()
    g_lsc_vehicle = vehicle
ENDPROC

PROC APPLY_LSC_PAINT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_COLOURS(vehicle, LSC_COLOUR_ID(g_lsc_primary_colour), LSC_COLOUR_ID(g_lsc_secondary_colour))
    SET_VEHICLE_EXTRA_COLOURS(vehicle, LSC_COLOUR_ID(g_lsc_pearlescent_colour), LSC_COLOUR_ID(g_lsc_wheel_colour))
ENDPROC

PROC DRAW_LSC_COLOUR_SELECTOR(FLOAT y, STRING label, INT choice, BOOL selected)
    SWITCH choice
        CASE 0 DRAW_OPTION(y, label, "< Black >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, label, "< Graphite >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, label, "< Silver >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, label, "< Blue Silver >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, label, "< Navy Blue >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, label, "< Red >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, label, "< Torino Red >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, label, "< Orange >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, label, "< Yellow >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, label, "< Dark Green >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, label, "< Green >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, label, "< Dark Blue >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, label, "< Light Blue >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, label, "< Purple >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, label, "< Gold >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, label, "< Brown >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, label, "< Cream >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, label, "< White >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, label, "< Chrome >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, label, "< Pink >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, label, "< Salmon >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, label, "< Matte Black >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, label, "< Matte Grey >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, label, "< Matte Red >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, label, "< Matte Green >", selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, label, "< Matte Blue >", selected, 3) BREAK
        CASE 26 DRAW_OPTION(y, label, "< Matte Yellow >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_MOD_SELECTOR(FLOAT y, BOOL selected)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available <= 0
        DRAW_OPTION(y, "Selected Variant", "NOT AVAILABLE", selected, 0)
    ELIF g_lsc_mod_choice < 0
        DRAW_OPTION(y, "Selected Variant", "< Stock >", selected, 3)
    ELSE
        DRAW_NUMBER_OPTION(y, "Selected Variant", g_lsc_mod_choice + 1, selected)
    ENDIF
ENDPROC

PROC DRAW_LSC_VARIANT_COUNT(FLOAT y, BOOL selected)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available <= 0 DRAW_OPTION(y, "Available Variants", "< None >", selected, 0)
    ELIF available = 1 DRAW_OPTION(y, "Available Variants", "< 1 >", selected, 3)
    ELIF available = 2 DRAW_OPTION(y, "Available Variants", "< 2 >", selected, 3)
    ELIF available = 3 DRAW_OPTION(y, "Available Variants", "< 3 >", selected, 3)
    ELIF available = 4 DRAW_OPTION(y, "Available Variants", "< 4 >", selected, 3)
    ELIF available = 5 DRAW_OPTION(y, "Available Variants", "< 5 >", selected, 3)
    ELIF available = 6 DRAW_OPTION(y, "Available Variants", "< 6 >", selected, 3)
    ELIF available = 7 DRAW_OPTION(y, "Available Variants", "< 7 >", selected, 3)
    ELIF available = 8 DRAW_OPTION(y, "Available Variants", "< 8 >", selected, 3)
    ELIF available = 9 DRAW_OPTION(y, "Available Variants", "< 9 >", selected, 3)
    ELIF available = 10 DRAW_OPTION(y, "Available Variants", "< 10 >", selected, 3)
    ELIF available = 11 DRAW_OPTION(y, "Available Variants", "< 11 >", selected, 3)
    ELIF available = 12 DRAW_OPTION(y, "Available Variants", "< 12 >", selected, 3)
    ELIF available = 13 DRAW_OPTION(y, "Available Variants", "< 13 >", selected, 3)
    ELIF available = 14 DRAW_OPTION(y, "Available Variants", "< 14 >", selected, 3)
    ELIF available = 15 DRAW_OPTION(y, "Available Variants", "< 15 >", selected, 3)
    ELSE DRAW_OPTION(y, "Available Variants", "< 16+ >", selected, 3)
    ENDIF
ENDPROC

PROC DRAW_LSC_LIGHT_SELECTOR(FLOAT y, STRING label, INT choice, BOOL selected)
    SWITCH choice
        CASE 0 DRAW_OPTION(y, label, "< White >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, label, "< Blue >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, label, "< Electric Blue >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, label, "< Mint Green >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, label, "< Lime Green >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, label, "< Yellow >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, label, "< Gold >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, label, "< Orange >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, label, "< Red >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, label, "< Pink >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, label, "< Hot Pink >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, label, "< Purple >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, label, "< Blacklight >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_LSC_MAX_TO_VEHICLE(VEHICLE_INDEX vehicle)
    INT slot = 0
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    WHILE slot <= ENUM_TO_INT(MOD_LIVERY)
        IF slot < ENUM_TO_INT(MOD_TOGGLE_NITROUS) OR slot > ENUM_TO_INT(MOD_TOGGLE_XENON_LIGHTS)
            INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
            IF available > 0 SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), available - 1) ENDIF
        ENDIF
        slot = slot + 1
    ENDWHILE
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TURBO, TRUE)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_XENON_LIGHTS, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, TRUE)
ENDPROC

PROC APPLY_LSC_MAX()
    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    SYNC_LSC_VEHICLE_STATE()
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
        CASE 26 DRAW_OPTION(y, "Mod Slot:", "< Left Wing >", selected, 3) BREAK
        CASE 27 DRAW_OPTION(y, "Mod Slot:", "< Right Wing >", selected, 3) BREAK
        CASE 28 DRAW_OPTION(y, "Mod Slot:", "< Rear Wheels >", selected, 3) BREAK
        CASE 29 DRAW_OPTION(y, "Mod Slot:", "< Interior Knob >", selected, 3) BREAK
        CASE 30 DRAW_OPTION(y, "Mod Slot:", "< Interior Plaque >", selected, 3) BREAK
        CASE 31 DRAW_OPTION(y, "Mod Slot:", "< Ice / Speakers >", selected, 3) BREAK
        CASE 32 DRAW_OPTION(y, "Mod Slot:", "< Trunk >", selected, 3) BREAK
        CASE 33 DRAW_OPTION(y, "Mod Slot:", "< Hydraulics >", selected, 3) BREAK
        CASE 34 DRAW_OPTION(y, "Mod Slot:", "< Engine Bay 1 >", selected, 3) BREAK
        CASE 35 DRAW_OPTION(y, "Mod Slot:", "< Engine Bay 2 >", selected, 3) BREAK
        CASE 36 DRAW_OPTION(y, "Mod Slot:", "< Engine Bay 3 >", selected, 3) BREAK
        CASE 37 DRAW_OPTION(y, "Mod Slot:", "< Chassis 2 >", selected, 3) BREAK
        CASE 38 DRAW_OPTION(y, "Mod Slot:", "< Chassis 3 >", selected, 3) BREAK
        CASE 39 DRAW_OPTION(y, "Mod Slot:", "< Chassis 4 >", selected, 3) BREAK
        CASE 40 DRAW_OPTION(y, "Mod Slot:", "< Chassis 5 >", selected, 3) BREAK
        CASE 41 DRAW_OPTION(y, "Mod Slot:", "< Left Door >", selected, 3) BREAK
        CASE 42 DRAW_OPTION(y, "Mod Slot:", "< Right Door >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_SCROLL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 15
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        SWITCH index
            CASE 0 DRAW_OPTION(y, "Max All Available Mods", "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_LSC_MOD_SELECTOR(y, g_item = index) BREAK
            CASE 3 DRAW_LSC_VARIANT_COUNT(y, g_item = index) BREAK
            CASE 4 DRAW_LSC_COLOUR_SELECTOR(y, "Primary Paint", g_lsc_primary_colour, g_item = index) BREAK
            CASE 5 DRAW_LSC_COLOUR_SELECTOR(y, "Secondary Paint", g_lsc_secondary_colour, g_item = index) BREAK
            CASE 6 DRAW_LSC_COLOUR_SELECTOR(y, "Pearlescent Paint", g_lsc_pearlescent_colour, g_item = index) BREAK
            CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, "Wheel Colour", g_lsc_wheel_colour, g_item = index) BREAK
            CASE 8 DRAW_OPTION(y, "Wheel Type", "< cycle >", g_item = index, 3) BREAK
            CASE 9 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 10 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon Lights", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 11 DRAW_LSC_LIGHT_SELECTOR(y, "Xenon Colour", g_lsc_xenon_colour, g_item = index) BREAK
            CASE 12 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon Kit", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 13 DRAW_LSC_LIGHT_SELECTOR(y, "Neon Colour", g_lsc_neon_colour, g_item = index) BREAK
            CASE 14 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
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
    IF g_tab = 0 AND g_outfit_open RETURN 21 ENDIF
    IF g_tab = 0 AND g_ped_open RETURN PED_CHOICE_COUNT() + 2 ENDIF
    IF g_tab = 3 AND g_spawner_open RETURN 11 ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN 1 ENDIF
        RETURN 15
    ENDIF
    SWITCH g_tab
        CASE 0 RETURN 21 BREAK
        CASE 1 RETURN 9 BREAK
        CASE 2 RETURN 6 BREAK
        CASE 3 RETURN 21 BREAK
        CASE 4 RETURN 16 BREAK
        CASE 5 RETURN 3 BREAK
        CASE 6 RETURN 27 BREAK
        CASE 7 RETURN 9 BREAK
        CASE 8 RETURN 5 BREAK
    ENDSWITCH
    RETURN 1
ENDFUNC

FUNC INT ACTIVE_ITEM_COUNT()
    IF g_home RETURN 9 ENDIF
    RETURN ITEM_COUNT()
ENDFUNC

PROC UPDATE_SCROLL()
    INT activeCount = ACTIVE_ITEM_COUNT()
    INT maxScroll = activeCount - 8
    IF activeCount < 1
        g_item = 0
        g_scroll = 0
        EXIT
    ENDIF
    IF maxScroll < 0 maxScroll = 0 ENDIF
    IF g_item < 0 g_item = 0 ENDIF
    IF g_item >= activeCount g_item = activeCount - 1 ENDIF
    IF g_scroll < 0 g_scroll = 0 ENDIF
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
    ELIF g_outfit_open
        g_outfit_item = g_item
        g_outfit_scroll = g_scroll
    ELIF g_lsc_open
        g_lsc_item = g_item
        g_lsc_scroll = g_scroll
    ELIF g_ped_open
        g_ped_item = g_item
        g_ped_scroll = g_scroll
    ELSE
        g_page_item[g_tab] = g_item
        g_page_scroll[g_tab] = g_scroll
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
    DRAW_RECT(g_menu_x - 0.015, 0.403 + g_menu_y, MENU_W, 0.505, 8, 9, 12, 220)
    DRAW_RECT(g_menu_x - 0.015, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x - 0.015, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.074, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.08, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
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
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
ENDPROC

PROC APPLY_TIME_CHOICE()
    SWITCH g_time_choice
        CASE 0 SET_CLOCK_TIME(6, 0, 0) BREAK
        CASE 1 SET_CLOCK_TIME(12, 0, 0) BREAK
        CASE 2 SET_CLOCK_TIME(18, 0, 0) BREAK
        CASE 3 SET_CLOCK_TIME(0, 0, 0) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_EDITABLE_TIME()
    SET_CLOCK_TIME(g_time_hour, g_time_minute, g_time_second)
ENDPROC

PROC APPLY_WEATHER_CHOICE()
    SWITCH g_weather_choice
        CASE 0 SET_WEATHER_TYPE_NOW_PERSIST("EXTRASUNNY") BREAK
        CASE 1 SET_WEATHER_TYPE_NOW_PERSIST("CLEAR") BREAK
        CASE 2 SET_WEATHER_TYPE_NOW_PERSIST("CLOUDS") BREAK
        CASE 3 SET_WEATHER_TYPE_NOW_PERSIST("OVERCAST") BREAK
        CASE 4 SET_WEATHER_TYPE_NOW_PERSIST("RAIN") BREAK
        CASE 5 SET_WEATHER_TYPE_NOW_PERSIST("THUNDER") BREAK
        CASE 6 SET_WEATHER_TYPE_NOW_PERSIST("CLEARING") BREAK
        CASE 7 SET_WEATHER_TYPE_NOW_PERSIST("SMOG") BREAK
        CASE 8 SET_WEATHER_TYPE_NOW_PERSIST("FOGGY") BREAK
        CASE 9 SET_WEATHER_TYPE_NOW_PERSIST("XMAS") BREAK
        CASE 10 SET_WEATHER_TYPE_NOW_PERSIST("SNOW") BREAK
        CASE 11 SET_WEATHER_TYPE_NOW_PERSIST("SNOWLIGHT") BREAK
        CASE 12 SET_WEATHER_TYPE_NOW_PERSIST("BLIZZARD") BREAK
        CASE 13 SET_WEATHER_TYPE_NOW_PERSIST("HALLOWEEN") BREAK
        CASE 14 SET_WEATHER_TYPE_NOW_PERSIST("NEUTRAL") BREAK
        CASE 15 SET_WEATHER_TYPE_NOW_PERSIST("RAIN_HALLOWEEN") BREAK
        CASE 16 SET_WEATHER_TYPE_NOW_PERSIST("SNOW_HALLOWEEN") BREAK
    ENDSWITCH
ENDPROC

PROC DISABLE_PORTABLE_RADIO()
    g_mobile_radio = FALSE
    SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(FALSE)
    SET_MOBILE_PHONE_RADIO_STATE(FALSE)
    SET_USER_RADIO_CONTROL_ENABLED(FALSE)
ENDPROC

PROC START_VEHICLE_MODEL_SPAWN(MODEL_NAMES model)
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model) EXIT ENDIF
    g_pending_vehicle_model = model
    g_spawn_remaining = 1
    g_active_spawn_count = 1
    g_spawn_index = 0
    g_spawn_warp_index = -1
    IF g_spawn_teleport_into_vehicle g_spawn_warp_index = 0 ENDIF
    g_spawn_heading = GET_ENTITY_HEADING(PLAYER_PED_ID())
    REQUEST_MODEL(g_pending_vehicle_model)
    g_vehicle_spawn_pending = TRUE
    g_vehicle_spawn_request_time = GET_GAME_TIMER()
ENDPROC

PROC OPEN_MENU_KEYBOARD(INT target)
    g_keyboard_target = target
    g_keyboard_active = TRUE
    IF target = 3
        g_ped_search_not_found = FALSE
        g_ped_search_has_value = FALSE
    ENDIF
    IF target = 3
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 32)
    ELIF target = 4
        g_vehicle_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "VEHICLE MODEL", "TYPE MODEL NAME", "", "", "", "", 32)
    ELIF target = 8
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "CUSTOM IPL", "TYPE IPL NAME", "", "", "", "", 64)
    ELSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "ENTER VALUE", "NUMBERS ONLY", "", "", "", "", 10)
    ENDIF
ENDPROC

FUNC BOOL PARSE_FLOAT_COORDINATE(STRING value, FLOAT &result)
    INT length = GET_LENGTH_OF_LITERAL_STRING(value)
    INT index = 0
    INT digit = 0
    BOOL negative = FALSE
    BOOL afterPoint = FALSE
    FLOAT decimalFactor = 0.1
    STRING character
    IF length <= 0 RETURN FALSE ENDIF
    result = 0.0
    WHILE index < length
        character = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(value, index, index + 1)
        IF STRING_TO_INT(character, digit)
            IF afterPoint
                result = result + (TO_FLOAT(digit) * decimalFactor)
                decimalFactor = decimalFactor * 0.1
            ELSE
                result = (result * 10.0) + TO_FLOAT(digit)
            ENDIF
        ELIF ARE_STRINGS_EQUAL(character, "-") AND index = 0
            negative = TRUE
        ELIF ARE_STRINGS_EQUAL(character, ".") AND NOT afterPoint
            afterPoint = TRUE
        ELSE
            RETURN FALSE
        ENDIF
        index = index + 1
    ENDWHILE
    IF negative result = result * -1.0 ENDIF
    RETURN TRUE
ENDFUNC

PROC PROCESS_MENU_KEYBOARD()
    OSK_STATUS status = UPDATE_ONSCREEN_KEYBOARD()
    IF status = OSK_SUCCESS
        INT parsed = 0
        INT foundChoice = -1
        FLOAT parsedCoordinate = 0.0
        STRING result = GET_ONSCREEN_KEYBOARD_RESULT()
        IF g_keyboard_target = 3
            foundChoice = FIND_PED_CHOICE_BY_NAME(result)
            IF foundChoice >= 0
                g_ped_search_not_found = FALSE
                g_ped_search_has_value = TRUE
                g_ped_search_value = result
                g_ped_choice = foundChoice
                g_item = foundChoice + 2
                SAVE_ACTIVE_CHARACTER_PED()
                REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(foundChoice))
            ELSE
                g_ped_search_not_found = TRUE
                g_ped_search_has_value = FALSE
                g_ped_search_value = result
            ENDIF
        ELIF g_keyboard_target = 4
            MODEL_NAMES model = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
            g_vehicle_search_value = result
            IF IS_MODEL_IN_CDIMAGE(model) AND IS_MODEL_VALID(model) AND (IS_THIS_MODEL_A_CAR(model) OR IS_THIS_MODEL_A_BIKE(model) OR IS_THIS_MODEL_A_PLANE(model) OR IS_THIS_MODEL_A_HELI(model) OR IS_THIS_MODEL_A_BOAT(model))
                g_vehicle_search_not_found = FALSE
                g_vehicle_search_has_value = TRUE
                START_VEHICLE_MODEL_SPAWN(model)
            ELSE
                g_vehicle_search_not_found = TRUE
                g_vehicle_search_has_value = FALSE
            ENDIF
        ELIF g_keyboard_target = 8
            g_custom_ipl_name = result
        ELIF g_keyboard_target >= 5 AND g_keyboard_target <= 7
            IF PARSE_FLOAT_COORDINATE(result, parsedCoordinate)
                IF g_keyboard_target = 5 g_teleport_x = parsedCoordinate ENDIF
                IF g_keyboard_target = 6 g_teleport_y = parsedCoordinate ENDIF
                IF g_keyboard_target = 7 g_teleport_z = parsedCoordinate ENDIF
            ENDIF
        ELIF STRING_TO_INT(result, parsed)
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
    g_last_spawned_vehicle = NULL
ENDPROC

PROC FORGET_CUSTOM_CAR(VEHICLE_INDEX vehicle)
    INT readIndex = 0
    INT writeIndex = 0
    REPEAT g_spawned_custom_vehicle_count readIndex
        IF g_spawned_custom_vehicles[readIndex] != vehicle
            g_spawned_custom_vehicles[writeIndex] = g_spawned_custom_vehicles[readIndex]
            writeIndex = writeIndex + 1
        ENDIF
    ENDREPEAT
    g_spawned_custom_vehicle_count = writeIndex
ENDPROC

PROC DELETE_PREVIOUS_CUSTOM_CAR()
    IF DOES_ENTITY_EXIST(g_last_spawned_vehicle)
        // Remove the handle before deletion. Entity handles can be reused;

        FORGET_CUSTOM_CAR(g_last_spawned_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_last_spawned_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_last_spawned_vehicle)
    ENDIF
    g_last_spawned_vehicle = NULL
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
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PISTOL50)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNSPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_VINTAGEPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_REVOLVER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNSPISTOL_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_REVOLVER_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_ASSAULTSMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATPDW)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MACHINEPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MINISMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_GUSENBERG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SPECIALCARBINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BULLPUPRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMPACTRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_ASSAULTRIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_CARBINERIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SPECIALCARBINE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATMG_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BULLPUPSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DBSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_AUTOSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PUMPSHOTGUN_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYSNIPER_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANRIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HOMINGLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMPACTLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAILGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FIREWORK)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MUSKET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PROXMINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PIPEBOMB)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNOWBALL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FLAREGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BOTTLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DAGGER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_KNUCKLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MACHETE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SWITCHBLADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BATTLEAXE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HATCHET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_POOLCUE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_WRENCH)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYCARBINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYMINIGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DOUBLEACTION)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_STONE_HATCHET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_CERAMICPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HAZARDCAN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_NAVYREVOLVER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_GADGETPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MILITARYRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_EMPLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FERTILIZERCAN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_STUNGUNG_MP)
ENDPROC

PROC GIVE_ALL_MENU_WEAPONS(PED_INDEX ped)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_COMBATPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_APPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PISTOL50, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNSPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_VINTAGEPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_REVOLVER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNSPISTOL_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_REVOLVER_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MICROSMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_ASSAULTSMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATPDW, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MACHINEPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MINISMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_GUSENBERG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ASSAULTRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_CARBINERIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ADVANCEDRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SPECIALCARBINE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BULLPUPRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMPACTRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_ASSAULTRIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_CARBINERIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SPECIALCARBINE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_COMBATMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATMG_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PUMPSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SAWNOFFSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ASSAULTSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BULLPUPSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DBSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_AUTOSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PUMPSHOTGUN_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SNIPERRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_HEAVYSNIPER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYSNIPER_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANRIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GRENADELAUNCHER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_RPG, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MINIGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HOMINGLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMPACTLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAILGUN, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FIREWORK, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MUSKET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GRENADE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SMOKEGRENADE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_BZGAS, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_STICKYBOMB, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MOLOTOV, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PROXMINE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PIPEBOMB, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNOWBALL, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FLAREGUN, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_STUNGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_FIREEXTINGUISHER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PETROLCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_KNIFE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_NIGHTSTICK, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_HAMMER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_BAT, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_CROWBAR, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GOLFCLUB, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BOTTLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DAGGER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_KNUCKLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MACHETE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SWITCHBLADE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BATTLEAXE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HATCHET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_POOLCUE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_WRENCH, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYCARBINE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYMINIGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DOUBLEACTION, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_STONE_HATCHET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_CERAMICPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HAZARDCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_NAVYREVOLVER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_GADGETPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MILITARYRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_EMPLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FERTILIZERCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_STUNGUNG_MP, 9999, TRUE)
ENDPROC

FUNC INT MENU_WEAPON_COUNT()
    RETURN 93
ENDFUNC

FUNC WEAPON_TYPE MENU_WEAPON_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN WEAPONTYPE_PISTOL BREAK
        CASE 1 RETURN WEAPONTYPE_COMBATPISTOL BREAK
        CASE 2 RETURN WEAPONTYPE_APPISTOL BREAK
        CASE 3 RETURN WEAPONTYPE_DLC_PISTOL50 BREAK
        CASE 4 RETURN WEAPONTYPE_DLC_SNSPISTOL BREAK
        CASE 5 RETURN WEAPONTYPE_DLC_HEAVYPISTOL BREAK
        CASE 6 RETURN WEAPONTYPE_DLC_VINTAGEPISTOL BREAK
        CASE 7 RETURN WEAPONTYPE_DLC_MARKSMANPISTOL BREAK
        CASE 8 RETURN WEAPONTYPE_DLC_REVOLVER BREAK
        CASE 9 RETURN WEAPONTYPE_DLC_SNSPISTOL_MK2 BREAK
        CASE 10 RETURN WEAPONTYPE_DLC_REVOLVER_MK2 BREAK
        CASE 11 RETURN WEAPONTYPE_MICROSMG BREAK
        CASE 12 RETURN WEAPONTYPE_SMG BREAK
        CASE 13 RETURN WEAPONTYPE_DLC_ASSAULTSMG BREAK
        CASE 14 RETURN WEAPONTYPE_DLC_COMBATPDW BREAK
        CASE 15 RETURN WEAPONTYPE_DLC_MACHINEPISTOL BREAK
        CASE 16 RETURN WEAPONTYPE_DLC_MINISMG BREAK
        CASE 17 RETURN WEAPONTYPE_DLC_GUSENBERG BREAK
        CASE 18 RETURN WEAPONTYPE_ASSAULTRIFLE BREAK
        CASE 19 RETURN WEAPONTYPE_CARBINERIFLE BREAK
        CASE 20 RETURN WEAPONTYPE_ADVANCEDRIFLE BREAK
        CASE 21 RETURN WEAPONTYPE_DLC_SPECIALCARBINE BREAK
        CASE 22 RETURN WEAPONTYPE_DLC_BULLPUPRIFLE BREAK
        CASE 23 RETURN WEAPONTYPE_DLC_COMPACTRIFLE BREAK
        CASE 24 RETURN WEAPONTYPE_DLC_ASSAULTRIFLE_MK2 BREAK
        CASE 25 RETURN WEAPONTYPE_DLC_CARBINERIFLE_MK2 BREAK
        CASE 26 RETURN WEAPONTYPE_DLC_SPECIALCARBINE_MK2 BREAK
        CASE 27 RETURN WEAPONTYPE_MG BREAK
        CASE 28 RETURN WEAPONTYPE_COMBATMG BREAK
        CASE 29 RETURN WEAPONTYPE_DLC_COMBATMG_MK2 BREAK
        CASE 30 RETURN WEAPONTYPE_PUMPSHOTGUN BREAK
        CASE 31 RETURN WEAPONTYPE_SAWNOFFSHOTGUN BREAK
        CASE 32 RETURN WEAPONTYPE_ASSAULTSHOTGUN BREAK
        CASE 33 RETURN WEAPONTYPE_DLC_BULLPUPSHOTGUN BREAK
        CASE 34 RETURN WEAPONTYPE_DLC_HEAVYSHOTGUN BREAK
        CASE 35 RETURN WEAPONTYPE_DLC_DBSHOTGUN BREAK
        CASE 36 RETURN WEAPONTYPE_DLC_AUTOSHOTGUN BREAK
        CASE 37 RETURN WEAPONTYPE_DLC_PUMPSHOTGUN_MK2 BREAK
        CASE 38 RETURN WEAPONTYPE_SNIPERRIFLE BREAK
        CASE 39 RETURN WEAPONTYPE_HEAVYSNIPER BREAK
        CASE 40 RETURN WEAPONTYPE_DLC_MARKSMANRIFLE BREAK
        CASE 41 RETURN WEAPONTYPE_DLC_HEAVYSNIPER_MK2 BREAK
        CASE 42 RETURN WEAPONTYPE_DLC_MARKSMANRIFLE_MK2 BREAK
        CASE 43 RETURN WEAPONTYPE_GRENADELAUNCHER BREAK
        CASE 44 RETURN WEAPONTYPE_RPG BREAK
        CASE 45 RETURN WEAPONTYPE_MINIGUN BREAK
        CASE 46 RETURN WEAPONTYPE_DLC_HOMINGLAUNCHER BREAK
        CASE 47 RETURN WEAPONTYPE_DLC_COMPACTLAUNCHER BREAK
        CASE 48 RETURN WEAPONTYPE_DLC_RAILGUN BREAK
        CASE 49 RETURN WEAPONTYPE_DLC_FIREWORK BREAK
        CASE 50 RETURN WEAPONTYPE_DLC_MUSKET BREAK
        CASE 51 RETURN WEAPONTYPE_GRENADE BREAK
        CASE 52 RETURN WEAPONTYPE_SMOKEGRENADE BREAK
        CASE 53 RETURN WEAPONTYPE_BZGAS BREAK
        CASE 54 RETURN WEAPONTYPE_STICKYBOMB BREAK
        CASE 55 RETURN WEAPONTYPE_MOLOTOV BREAK
        CASE 56 RETURN WEAPONTYPE_DLC_PROXMINE BREAK
        CASE 57 RETURN WEAPONTYPE_DLC_PIPEBOMB BREAK
        CASE 58 RETURN WEAPONTYPE_DLC_SNOWBALL BREAK
        CASE 59 RETURN WEAPONTYPE_DLC_FLAREGUN BREAK
        CASE 60 RETURN WEAPONTYPE_STUNGUN BREAK
        CASE 61 RETURN WEAPONTYPE_FIREEXTINGUISHER BREAK
        CASE 62 RETURN WEAPONTYPE_PETROLCAN BREAK
        CASE 63 RETURN WEAPONTYPE_KNIFE BREAK
        CASE 64 RETURN WEAPONTYPE_NIGHTSTICK BREAK
        CASE 65 RETURN WEAPONTYPE_HAMMER BREAK
        CASE 66 RETURN WEAPONTYPE_BAT BREAK
        CASE 67 RETURN WEAPONTYPE_CROWBAR BREAK
        CASE 68 RETURN WEAPONTYPE_GOLFCLUB BREAK
        CASE 69 RETURN WEAPONTYPE_DLC_BOTTLE BREAK
        CASE 70 RETURN WEAPONTYPE_DLC_DAGGER BREAK
        CASE 71 RETURN WEAPONTYPE_DLC_KNUCKLE BREAK
        CASE 72 RETURN WEAPONTYPE_DLC_MACHETE BREAK
        CASE 73 RETURN WEAPONTYPE_DLC_SWITCHBLADE BREAK
        CASE 74 RETURN WEAPONTYPE_DLC_BATTLEAXE BREAK
        CASE 75 RETURN WEAPONTYPE_DLC_HATCHET BREAK
        CASE 76 RETURN WEAPONTYPE_DLC_POOLCUE BREAK
        CASE 77 RETURN WEAPONTYPE_DLC_WRENCH BREAK
        CASE 78 RETURN WEAPONTYPE_DLC_RAYPISTOL BREAK
        CASE 79 RETURN WEAPONTYPE_DLC_RAYCARBINE BREAK
        CASE 80 RETURN WEAPONTYPE_DLC_RAYMINIGUN BREAK
        CASE 81 RETURN WEAPONTYPE_DLC_DOUBLEACTION BREAK
        CASE 82 RETURN WEAPONTYPE_DLC_STONE_HATCHET BREAK
        CASE 83 RETURN WEAPONTYPE_DLC_CERAMICPISTOL BREAK
        CASE 84 RETURN WEAPONTYPE_DLC_HAZARDCAN BREAK
        CASE 85 RETURN WEAPONTYPE_DLC_NAVYREVOLVER BREAK
        CASE 86 RETURN WEAPONTYPE_DLC_GADGETPISTOL BREAK
        CASE 87 RETURN WEAPONTYPE_DLC_MILITARYRIFLE BREAK
        CASE 88 RETURN WEAPONTYPE_DLC_COMBATSHOTGUN BREAK
        CASE 89 RETURN WEAPONTYPE_DLC_HEAVYRIFLE BREAK
        CASE 90 RETURN WEAPONTYPE_DLC_EMPLAUNCHER BREAK
        CASE 91 RETURN WEAPONTYPE_DLC_FERTILIZERCAN BREAK
        CASE 92 RETURN WEAPONTYPE_DLC_STUNGUNG_MP BREAK
    ENDSWITCH
    RETURN WEAPONTYPE_PISTOL
ENDFUNC

FUNC INT MENU_WEAPON_AMMO_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN 9999 BREAK
        CASE 1 RETURN 9999 BREAK
        CASE 2 RETURN 9999 BREAK
        CASE 3 RETURN 9999 BREAK
        CASE 4 RETURN 9999 BREAK
        CASE 5 RETURN 9999 BREAK
        CASE 6 RETURN 9999 BREAK
        CASE 7 RETURN 9999 BREAK
        CASE 8 RETURN 9999 BREAK
        CASE 9 RETURN 9999 BREAK
        CASE 10 RETURN 9999 BREAK
        CASE 11 RETURN 9999 BREAK
        CASE 12 RETURN 9999 BREAK
        CASE 13 RETURN 9999 BREAK
        CASE 14 RETURN 9999 BREAK
        CASE 15 RETURN 9999 BREAK
        CASE 16 RETURN 9999 BREAK
        CASE 17 RETURN 9999 BREAK
        CASE 18 RETURN 9999 BREAK
        CASE 19 RETURN 9999 BREAK
        CASE 20 RETURN 9999 BREAK
        CASE 21 RETURN 9999 BREAK
        CASE 22 RETURN 9999 BREAK
        CASE 23 RETURN 9999 BREAK
        CASE 24 RETURN 9999 BREAK
        CASE 25 RETURN 9999 BREAK
        CASE 26 RETURN 9999 BREAK
        CASE 27 RETURN 9999 BREAK
        CASE 28 RETURN 9999 BREAK
        CASE 29 RETURN 9999 BREAK
        CASE 30 RETURN 9999 BREAK
        CASE 31 RETURN 9999 BREAK
        CASE 32 RETURN 9999 BREAK
        CASE 33 RETURN 9999 BREAK
        CASE 34 RETURN 9999 BREAK
        CASE 35 RETURN 9999 BREAK
        CASE 36 RETURN 9999 BREAK
        CASE 37 RETURN 9999 BREAK
        CASE 38 RETURN 9999 BREAK
        CASE 39 RETURN 9999 BREAK
        CASE 40 RETURN 9999 BREAK
        CASE 41 RETURN 9999 BREAK
        CASE 42 RETURN 9999 BREAK
        CASE 43 RETURN 9999 BREAK
        CASE 44 RETURN 25 BREAK
        CASE 45 RETURN 9999 BREAK
        CASE 46 RETURN 25 BREAK
        CASE 47 RETURN 25 BREAK
        CASE 48 RETURN 25 BREAK
        CASE 49 RETURN 25 BREAK
        CASE 50 RETURN 9999 BREAK
        CASE 51 RETURN 25 BREAK
        CASE 52 RETURN 25 BREAK
        CASE 53 RETURN 25 BREAK
        CASE 54 RETURN 25 BREAK
        CASE 55 RETURN 25 BREAK
        CASE 56 RETURN 25 BREAK
        CASE 57 RETURN 25 BREAK
        CASE 58 RETURN 25 BREAK
        CASE 59 RETURN 25 BREAK
        CASE 60 RETURN 9999 BREAK
        CASE 61 RETURN 9999 BREAK
        CASE 62 RETURN 9999 BREAK
        CASE 63 RETURN 9999 BREAK
        CASE 64 RETURN 9999 BREAK
        CASE 65 RETURN 9999 BREAK
        CASE 66 RETURN 9999 BREAK
        CASE 67 RETURN 9999 BREAK
        CASE 68 RETURN 9999 BREAK
        CASE 69 RETURN 9999 BREAK
        CASE 70 RETURN 9999 BREAK
        CASE 71 RETURN 9999 BREAK
        CASE 72 RETURN 9999 BREAK
        CASE 73 RETURN 9999 BREAK
        CASE 74 RETURN 9999 BREAK
        CASE 75 RETURN 9999 BREAK
        CASE 76 RETURN 9999 BREAK
        CASE 77 RETURN 9999 BREAK
        CASE 78 RETURN 9999 BREAK
        CASE 79 RETURN 9999 BREAK
        CASE 80 RETURN 9999 BREAK
        CASE 81 RETURN 9999 BREAK
        CASE 82 RETURN 9999 BREAK
        CASE 83 RETURN 9999 BREAK
        CASE 84 RETURN 9999 BREAK
        CASE 85 RETURN 9999 BREAK
        CASE 86 RETURN 9999 BREAK
        CASE 87 RETURN 9999 BREAK
        CASE 88 RETURN 9999 BREAK
        CASE 89 RETURN 9999 BREAK
        CASE 90 RETURN 25 BREAK
        CASE 91 RETURN 9999 BREAK
        CASE 92 RETURN 9999 BREAK
    ENDSWITCH
    RETURN 9999
ENDFUNC

FUNC STRING MENU_WEAPON_NAME_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN "Pistol" BREAK
        CASE 1 RETURN "Combat Pistol" BREAK
        CASE 2 RETURN "AP Pistol" BREAK
        CASE 3 RETURN "Pistol .50" BREAK
        CASE 4 RETURN "SNS Pistol" BREAK
        CASE 5 RETURN "Heavy Pistol" BREAK
        CASE 6 RETURN "Vintage Pistol" BREAK
        CASE 7 RETURN "Marksman Pistol" BREAK
        CASE 8 RETURN "Heavy Revolver" BREAK
        CASE 9 RETURN "SNS Pistol Mk II" BREAK
        CASE 10 RETURN "Heavy Revolver Mk II" BREAK
        CASE 11 RETURN "Micro SMG" BREAK
        CASE 12 RETURN "SMG" BREAK
        CASE 13 RETURN "Assault SMG" BREAK
        CASE 14 RETURN "Combat PDW" BREAK
        CASE 15 RETURN "Machine Pistol" BREAK
        CASE 16 RETURN "Mini SMG" BREAK
        CASE 17 RETURN "Gusenberg Sweeper" BREAK
        CASE 18 RETURN "Assault Rifle" BREAK
        CASE 19 RETURN "Carbine Rifle" BREAK
        CASE 20 RETURN "Advanced Rifle" BREAK
        CASE 21 RETURN "Special Carbine" BREAK
        CASE 22 RETURN "Bullpup Rifle" BREAK
        CASE 23 RETURN "Compact Rifle" BREAK
        CASE 24 RETURN "Assault Rifle Mk II" BREAK
        CASE 25 RETURN "Carbine Rifle Mk II" BREAK
        CASE 26 RETURN "Special Carbine Mk II" BREAK
        CASE 27 RETURN "Machine Gun" BREAK
        CASE 28 RETURN "Combat MG" BREAK
        CASE 29 RETURN "Combat MG Mk II" BREAK
        CASE 30 RETURN "Pump Shotgun" BREAK
        CASE 31 RETURN "Sawed-Off Shotgun" BREAK
        CASE 32 RETURN "Assault Shotgun" BREAK
        CASE 33 RETURN "Bullpup Shotgun" BREAK
        CASE 34 RETURN "Heavy Shotgun" BREAK
        CASE 35 RETURN "Double Barrel Shotgun" BREAK
        CASE 36 RETURN "Sweeper Shotgun" BREAK
        CASE 37 RETURN "Pump Shotgun Mk II" BREAK
        CASE 38 RETURN "Sniper Rifle" BREAK
        CASE 39 RETURN "Heavy Sniper" BREAK
        CASE 40 RETURN "Marksman Rifle" BREAK
        CASE 41 RETURN "Heavy Sniper Mk II" BREAK
        CASE 42 RETURN "Marksman Rifle Mk II" BREAK
        CASE 43 RETURN "Grenade Launcher" BREAK
        CASE 44 RETURN "RPG" BREAK
        CASE 45 RETURN "Minigun" BREAK
        CASE 46 RETURN "Homing Launcher" BREAK
        CASE 47 RETURN "Compact Grenade Launcher" BREAK
        CASE 48 RETURN "Railgun" BREAK
        CASE 49 RETURN "Firework Launcher" BREAK
        CASE 50 RETURN "Musket" BREAK
        CASE 51 RETURN "Grenade" BREAK
        CASE 52 RETURN "Tear Gas" BREAK
        CASE 53 RETURN "BZ Gas" BREAK
        CASE 54 RETURN "Sticky Bomb" BREAK
        CASE 55 RETURN "Molotov" BREAK
        CASE 56 RETURN "Proximity Mine" BREAK
        CASE 57 RETURN "Pipe Bomb" BREAK
        CASE 58 RETURN "Snowball" BREAK
        CASE 59 RETURN "Flare Gun" BREAK
        CASE 60 RETURN "Stun Gun" BREAK
        CASE 61 RETURN "Fire Extinguisher" BREAK
        CASE 62 RETURN "Jerry Can" BREAK
        CASE 63 RETURN "Knife" BREAK
        CASE 64 RETURN "Nightstick" BREAK
        CASE 65 RETURN "Hammer" BREAK
        CASE 66 RETURN "Baseball Bat" BREAK
        CASE 67 RETURN "Crowbar" BREAK
        CASE 68 RETURN "Golf Club" BREAK
        CASE 69 RETURN "BOTTLE" BREAK
        CASE 70 RETURN "DAGGER" BREAK
        CASE 71 RETURN "Knuckle Duster" BREAK
        CASE 72 RETURN "MACHETE" BREAK
        CASE 73 RETURN "Switchblade" BREAK
        CASE 74 RETURN "Battle Axe" BREAK
        CASE 75 RETURN "HATCHET" BREAK
        CASE 76 RETURN "Pool Cue" BREAK
        CASE 77 RETURN "WRENCH" BREAK
        CASE 78 RETURN "Up-n-Atomizer" BREAK
        CASE 79 RETURN "Unholy Hellbringer" BREAK
        CASE 80 RETURN "Widowmaker" BREAK
        CASE 81 RETURN "Double Action Revolver" BREAK
        CASE 82 RETURN "Stone Hatchet" BREAK
        CASE 83 RETURN "Ceramic Pistol" BREAK
        CASE 84 RETURN "Hazardous Jerry Can" BREAK
        CASE 85 RETURN "Navy Revolver" BREAK
        CASE 86 RETURN "Perico Pistol" BREAK
        CASE 87 RETURN "Military Rifle" BREAK
        CASE 88 RETURN "Combat Shotgun" BREAK
        CASE 89 RETURN "Heavy Rifle" BREAK
        CASE 90 RETURN "Compact EMP Launcher" BREAK
        CASE 91 RETURN "Fertilizer Can" BREAK
        CASE 92 RETURN "Stun Gun MP" BREAK
    ENDSWITCH
    RETURN "Pistol"
ENDFUNC

PROC DRAW_MENU_WEAPON_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Give Weapon:", MENU_WEAPON_NAME_FOR_CHOICE(g_weapon_choice), selected, 3)
ENDPROC

PROC GIVE_SELECTED_MENU_WEAPON(PED_INDEX ped)
    IF g_weapon_choice < 0 OR g_weapon_choice >= MENU_WEAPON_COUNT() EXIT ENDIF
    GIVE_DELAYED_WEAPON_TO_PED(ped, MENU_WEAPON_FOR_CHOICE(g_weapon_choice), MENU_WEAPON_AMMO_FOR_CHOICE(g_weapon_choice), TRUE)
ENDPROC


PROC WARP_INTO_LAST_PLAYER_VEHICLE()
    VEHICLE_INDEX vehicle = GET_PLAYERS_LAST_VEHICLE()
    IF DOES_ENTITY_EXIST(vehicle) AND NOT IS_ENTITY_DEAD(vehicle)
        SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), vehicle, VS_DRIVER)
    ENDIF
ENDPROC


PROC PROCESS_QUICK_VEHICLE_ENTRY_EXIT()
    PED_INDEX playerPed = PLAYER_PED_ID()

    IF NOT g_vehicle_quick_entry_exit OR g_open EXIT ENDIF
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_CONTEXT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_ENTER) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_VEH_EXIT) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_CONTEXT) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_ENTER) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_VEH_EXIT)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER, TRUE)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_EXIT, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CONTEXT, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_ENTER, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_EXIT, TRUE)
        IF IS_PED_IN_ANY_VEHICLE(playerPed)
            CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
            TASK_LEAVE_ANY_VEHICLE(playerPed, 0, ECF_WARP_PED | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP)
        ELSE
            VEHICLE_INDEX nearbyVehicle = GET_CLOSEST_VEHICLE(GET_ENTITY_COORDS(playerPed), 7.5, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_LAW_ENFORCER_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_MISSION_VEHICLES)
            IF DOES_ENTITY_EXIST(nearbyVehicle)
                SET_PED_INTO_VEHICLE(playerPed, nearbyVehicle, VS_DRIVER)
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC PROCESS_HORN_BOOST()
    VEHICLE_INDEX vehicle
    VECTOR velocity = <<0.0, 0.0, 0.0>>
    IF NOT g_vehicle_horn_boost OR NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        g_horn_boost_speed = 10.0
        EXIT
    ENDIF
    vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_VEH_HORN)
        g_horn_boost_speed = GET_ENTITY_SPEED(vehicle)
        IF g_horn_boost_speed < 10.0 g_horn_boost_speed = 10.0 ENDIF
    ENDIF
    IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_HORN)
        IF g_horn_boost_speed < 65.0 g_horn_boost_speed = g_horn_boost_speed + 0.30 ENDIF
        velocity = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, <<0.0, g_horn_boost_speed, 0.0>>) - GET_ENTITY_COORDS(vehicle)
        SET_ENTITY_VELOCITY(vehicle, velocity)
    ELIF IS_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_VEH_HORN)
        g_horn_boost_speed = 10.0
    ENDIF
ENDPROC

PROC PROCESS_PHONE_HANGUP_BLOCK()
    IF NOT g_block_phone_hangup OR g_open EXIT ENDIF
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_CELLPHONE_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_CANCEL, TRUE)
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
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SCREENSHOT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_HIDEHUD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_MARKER_DELETE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CLIP_DELETE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PAUSE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_REWIND, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FFWD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_NEWMARKER, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_STARTPOINT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_ENDPOINT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_ADVANCE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_BACK, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOOLS, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_RESTART, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CYCLEMARKERLEFT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CYCLEMARKERRIGHT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FOVINCREASE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FOVDECREASE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLETIME, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLETIPS, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PREVIEW, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLE_TIMELINE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_PICKUP_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_PLACE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CTRL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PREVIEW_AUDIO, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SNAPMATIC_PHOTO, TRUE)



    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_JUMP, TRUE)
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

FUNC BOOL DLC_CATEGORY_MATCH(INT category, INT index)
    INT total = GET_NUM_DLC_VEHICLES()
    MODEL_NAMES model
    IF index < 0 OR index >= total RETURN FALSE ENDIF
    model = GET_DLC_VEHICLE_MODEL(index)
    IF category = 3 RETURN IS_THIS_MODEL_A_CAR(model) ENDIF
    IF category = 4 RETURN IS_THIS_MODEL_A_BIKE(model) ENDIF
    IF category = 5 RETURN IS_THIS_MODEL_A_PLANE(model) OR IS_THIS_MODEL_A_HELI(model) ENDIF
    IF category = 6 RETURN IS_THIS_MODEL_A_BOAT(model) ENDIF
    RETURN FALSE
ENDFUNC

FUNC INT FIND_FIRST_DLC_FOR_CATEGORY(INT category)
    INT index = 0
    INT total = GET_NUM_DLC_VEHICLES()
    WHILE index < total
        IF DLC_CATEGORY_MATCH(category, index) RETURN index ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

PROC ADJUST_VEHICLE_SPAWN_CHOICE(INT direction)
    INT first = 0
    INT last = 18
    INT candidate = 0
    INT attempts = 0
    IF g_vehicle_spawn_category = 1
        first = 19
        last = 23
    ENDIF
    IF g_vehicle_spawn_category = 2
        first = 24
        last = 27
    ENDIF
    IF g_vehicle_spawn_category = 7
        first = 72
        last = 88
    ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() <= 0 EXIT ENDIF
        IF g_dlc_vehicle_index < 0 OR NOT DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index)
            g_dlc_vehicle_index = FIND_FIRST_DLC_FOR_CATEGORY(g_vehicle_spawn_category)
        ENDIF
        IF g_dlc_vehicle_index < 0 EXIT ENDIF
        candidate = g_dlc_vehicle_index + direction
        WHILE attempts < 512
            IF candidate < 0 candidate = GET_NUM_DLC_VEHICLES() - 1 ENDIF
            IF candidate >= GET_NUM_DLC_VEHICLES() candidate = 0 ENDIF
            IF DLC_CATEGORY_MATCH(g_vehicle_spawn_category, candidate)
                g_dlc_vehicle_index = candidate
                EXIT
            ENDIF
            candidate = candidate + direction
            attempts = attempts + 1
        ENDWHILE
        EXIT
    ENDIF
    g_vehicle_spawn_choice = g_vehicle_spawn_choice + direction
    IF g_vehicle_spawn_choice < first g_vehicle_spawn_choice = last ENDIF
    IF g_vehicle_spawn_choice > last g_vehicle_spawn_choice = first ENDIF
ENDPROC

FUNC BOOL IS_SELECTOR_ACTIVE()
    IF g_tab = 0 AND g_outfit_open RETURN TRUE ENDIF
    IF g_tab = 0 AND g_ped_open AND g_item = 1 RETURN TRUE ENDIF
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1 OR g_item = 2 OR g_item = 3 OR g_item = 5 OR g_item = 6 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0
        IF g_item = 11 OR g_item = 12 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 4
        IF g_item = 0 OR g_item = 1 OR g_item = 6 OR g_item = 7 OR g_item = 8 OR g_item = 10 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 2 AND g_item = 2 RETURN TRUE ENDIF
    IF g_tab = 1 AND g_item = 1 RETURN TRUE ENDIF
    IF g_tab = 3 AND g_item = 5 AND NOT g_lsc_open RETURN TRUE ENDIF
    IF g_tab = 3 AND NOT g_lsc_open AND (g_item = 14 OR g_item = 16) RETURN TRUE ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF g_item = 1 OR g_item = 2 OR g_item = 4 OR g_item = 5 OR g_item = 6 OR g_item = 7 OR g_item = 8 OR g_item = 11 OR g_item = 13 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 8
        IF g_item = 0 OR g_item = 1 OR g_item = 3 OR g_item = 4 RETURN TRUE ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

PROC ADJUST_SELECTOR(INT direction)
    IF g_tab = 0 AND g_outfit_open
        ADJUST_OUTFIT_SLOT(direction)
        EXIT
    ENDIF
    IF g_tab = 0 AND g_ped_open
        ADJUST_PED_SELECTOR(direction)
        EXIT
    ENDIF
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1
            g_vehicle_spawn_category = g_vehicle_spawn_category + direction
            IF g_vehicle_spawn_category < 0 g_vehicle_spawn_category = 7 ENDIF
            IF g_vehicle_spawn_category > 7 g_vehicle_spawn_category = 0 ENDIF
            IF g_vehicle_spawn_category = 0 g_vehicle_spawn_choice = 0 ENDIF
            IF g_vehicle_spawn_category = 1 g_vehicle_spawn_choice = 19 ENDIF
            IF g_vehicle_spawn_category = 2 g_vehicle_spawn_choice = 24 ENDIF
            IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
                g_dlc_vehicle_index = FIND_FIRST_DLC_FOR_CATEGORY(g_vehicle_spawn_category)
            ENDIF
            IF g_vehicle_spawn_category = 7 g_vehicle_spawn_choice = 72 ENDIF
        ELIF g_item = 2
            ADJUST_VEHICLE_SPAWN_CHOICE(direction)
        ELIF g_item = 3
            g_spawn_count = g_spawn_count + direction
            IF g_spawn_count < 1 g_spawn_count = 500 ENDIF
            IF g_spawn_count > 500 g_spawn_count = 1 ENDIF
        ELIF g_item = 5
            g_spawn_alignment = 1 - g_spawn_alignment
        ELIF g_item = 6
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
            IF g_weather_choice < 0 g_weather_choice = 16 ENDIF
            IF g_weather_choice > 16 g_weather_choice = 0 ENDIF
        ENDIF
        IF g_item = 6
            g_time_hour = g_time_hour + direction
            IF g_time_hour < 0 g_time_hour = 23 ENDIF
            IF g_time_hour > 23 g_time_hour = 0 ENDIF
            APPLY_EDITABLE_TIME()
        ENDIF
        IF g_item = 7
            g_time_minute = g_time_minute + direction
            IF g_time_minute < 0 g_time_minute = 59 ENDIF
            IF g_time_minute > 59 g_time_minute = 0 ENDIF
            APPLY_EDITABLE_TIME()
        ENDIF
        IF g_item = 8
            g_time_second = g_time_second + direction
            IF g_time_second < 0 g_time_second = 59 ENDIF
            IF g_time_second > 59 g_time_second = 0 ENDIF
            APPLY_EDITABLE_TIME()
        ENDIF
        IF g_item = 10
            g_ipl_preset = g_ipl_preset + direction
            IF g_ipl_preset < 0 g_ipl_preset = 21 ENDIF
            IF g_ipl_preset > 21 g_ipl_preset = 0 ENDIF
        ENDIF
    ENDIF
    IF g_tab = 2 AND g_item = 2
        g_wanted_level_choice = g_wanted_level_choice + direction
        IF g_wanted_level_choice < 1 g_wanted_level_choice = 5 ENDIF
        IF g_wanted_level_choice > 5 g_wanted_level_choice = 1 ENDIF
    ENDIF
    IF g_tab = 1 AND g_item = 1
        g_weapon_choice = g_weapon_choice + direction
        IF g_weapon_choice < 0 g_weapon_choice = MENU_WEAPON_COUNT() - 1 ENDIF
        IF g_weapon_choice >= MENU_WEAPON_COUNT() g_weapon_choice = 0 ENDIF
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 1
        g_lsc_slot_choice = g_lsc_slot_choice + direction
        IF g_lsc_slot_choice < 0 g_lsc_slot_choice = 42 ENDIF
        IF g_lsc_slot_choice > 42 g_lsc_slot_choice = 0 ENDIF
        SYNC_LSC_SLOT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 2
        ADJUST_LSC_MOD(direction)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 4
        g_lsc_primary_colour = g_lsc_primary_colour + direction
        IF g_lsc_primary_colour < 0 g_lsc_primary_colour = 26 ENDIF
        IF g_lsc_primary_colour > 26 g_lsc_primary_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 5
        g_lsc_secondary_colour = g_lsc_secondary_colour + direction
        IF g_lsc_secondary_colour < 0 g_lsc_secondary_colour = 26 ENDIF
        IF g_lsc_secondary_colour > 26 g_lsc_secondary_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 8
        g_lsc_wheel_type = g_lsc_wheel_type + direction
        IF g_lsc_wheel_type < 0 g_lsc_wheel_type = 9 ENDIF
        IF g_lsc_wheel_type > 9 g_lsc_wheel_type = 0 ENDIF
        SET_VEHICLE_WHEEL_TYPE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 11
        g_lsc_xenon_colour = g_lsc_xenon_colour + direction
        IF g_lsc_xenon_colour < 0 g_lsc_xenon_colour = 12 ENDIF
        IF g_lsc_xenon_colour > 12 g_lsc_xenon_colour = 0 ENDIF
        SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_xenon_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 13
        g_lsc_neon_colour = g_lsc_neon_colour + direction
        IF g_lsc_neon_colour < 0 g_lsc_neon_colour = 12 ENDIF
        IF g_lsc_neon_colour > 12 g_lsc_neon_colour = 0 ENDIF
        SET_VEHICLE_NEON_INDEX_COLOUR(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_neon_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 6
        g_lsc_pearlescent_colour = g_lsc_pearlescent_colour + direction
        IF g_lsc_pearlescent_colour < 0 g_lsc_pearlescent_colour = 26 ENDIF
        IF g_lsc_pearlescent_colour > 26 g_lsc_pearlescent_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 7
        g_lsc_wheel_colour = g_lsc_wheel_colour + direction
        IF g_lsc_wheel_colour < 0 g_lsc_wheel_colour = 26 ENDIF
        IF g_lsc_wheel_colour > 26 g_lsc_wheel_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND NOT g_lsc_open AND g_item = 5
        g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
    ENDIF
    IF g_tab = 3 AND NOT g_spawner_open AND NOT g_lsc_open AND g_item = 14
        g_vehicle_acceleration_level = g_vehicle_acceleration_level + direction
        IF g_vehicle_acceleration_level < 0 g_vehicle_acceleration_level = 12 ENDIF
        IF g_vehicle_acceleration_level > 12 g_vehicle_acceleration_level = 0 ENDIF
    ENDIF
    IF g_tab = 3 AND NOT g_spawner_open AND NOT g_lsc_open AND g_item = 16
        g_vehicle_grip_level = g_vehicle_grip_level + direction
        IF g_vehicle_grip_level < -4 g_vehicle_grip_level = 8 ENDIF
        IF g_vehicle_grip_level > 8 g_vehicle_grip_level = -4 ENDIF
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
            IF g_respawn_location_choice < 0 g_respawn_location_choice = 22 ENDIF
            IF g_respawn_location_choice > 22 g_respawn_location_choice = 0 ENDIF
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
        CASE 0 DRAW_OPTION(y, "Weather:", "< Extra Sunny >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Weather:", "< Clear >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Weather:", "< Clouds >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Weather:", "< Overcast >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Weather:", "< Rain >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Weather:", "< Thunder >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Weather:", "< Clearing >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Weather:", "< Smog >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Weather:", "< Foggy >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Weather:", "< XMAS >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Weather:", "< Snow >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Weather:", "< Snowlight >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Weather:", "< Blizzard >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Weather:", "< Halloween >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Weather:", "< Neutral >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Weather:", "< Rain Halloween >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Weather:", "< Snow Halloween >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_IPL_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_ipl_preset
        CASE 0 DRAW_OPTION(y, "IPL Preset:", "< Trevor's Trailer >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "IPL Preset:", "< FIB Lobby >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "IPL Preset:", "< Fruit BB >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "IPL Preset:", "< Heist Interior >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "IPL Preset:", "< Farm Interior >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "IPL Preset:", "< Face Lobby >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "IPL Preset:", "< Coroner >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "IPL Preset:", "< Josh's House >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "IPL Preset:", "< Apartment >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "IPL Preset:", "< Chop Shop >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "IPL Preset:", "< Prologue 1 >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "IPL Preset:", "< Prologue 2 >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "IPL Preset:", "< North Yankton >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "IPL Preset:", "< Cayo Perico >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "IPL Preset:", "< Dignity Party Yacht >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "IPL Preset:", "< Aircraft Carrier >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "IPL Preset:", "< Sunken Cargo Ship >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, "IPL Preset:", "< Pillbox Hospital >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, "IPL Preset:", "< O'Neil Farm Destroyed >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "IPL Preset:", "< LifeInvader Interior >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "IPL Preset:", "< Jewelry Store Interior >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "IPL Preset:", "< Coroner Morgue Interior >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WORLD_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_TIME_SELECTOR(y, g_item = index) BREAK
        CASE 1 DRAW_WEATHER_SELECTOR(y, g_item = index) BREAK
        CASE 2 IF g_night_vision DRAW_OPTION(y, "Night Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Night Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_thermal_vision DRAW_OPTION(y, "Thermal Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Thermal Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_motion_blur DRAW_OPTION(y, "CCTV Filter", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "CCTV Filter", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_camera_shake DRAW_OPTION(y, "Camera Shake", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Camera Shake", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 DRAW_NUMBER_OPTION(y, "Hour", g_time_hour, g_item = index) BREAK
        CASE 7 DRAW_NUMBER_OPTION(y, "Minute", g_time_minute, g_item = index) BREAK
        CASE 8 DRAW_NUMBER_OPTION(y, "Second", g_time_second, g_item = index) BREAK
        CASE 9 IF g_pause_time DRAW_OPTION(y, "Freeze / Pause Time", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Freeze / Pause Time", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 DRAW_IPL_SELECTOR(y, g_item = index) BREAK
        CASE 11 DRAW_OPTION(y, "Load IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 12 DRAW_OPTION(y, "Unload IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 13
            IF IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name) DRAW_OPTION(y, "Custom IPL Name", "TYPE NAME", g_item = index, 3)
            ELSE DRAW_OPTION(y, "Custom IPL Name", g_custom_ipl_name, g_item = index, 3) ENDIF
        BREAK
        CASE 14 DRAW_OPTION(y, "Load Custom IPL", "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, "Unload Custom IPL", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WANTED_LEVEL_SELECTOR(FLOAT y, BOOL selected)
    IF g_wanted_level_choice = 1 DRAW_OPTION(y, "Wanted Level", "< 1 Star >", selected, 3) ENDIF
    IF g_wanted_level_choice = 2 DRAW_OPTION(y, "Wanted Level", "< 2 Stars >", selected, 3) ENDIF
    IF g_wanted_level_choice = 3 DRAW_OPTION(y, "Wanted Level", "< 3 Stars >", selected, 3) ENDIF
    IF g_wanted_level_choice = 4 DRAW_OPTION(y, "Wanted Level", "< 4 Stars >", selected, 3) ENDIF
    IF g_wanted_level_choice = 5 DRAW_OPTION(y, "Wanted Level", "< 5 Stars >", selected, 3) ENDIF
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
        CASE 1 DRAW_OPTION(y, "Respawn location:", "< Franklin's House >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Respawn location:", "< Michael's House >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Respawn location:", "< Trevor's Trailer >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Respawn location:", "< Hospital >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Respawn location:", "< Simeon's Dealership >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Respawn location:", "< Ammu-Nation >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Respawn location:", "< Police station >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Respawn location:", "< Los Santos Customs >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Respawn location:", "< LS Airport >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Respawn location:", "< Maze Bank Tower >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Respawn location:", "< Grove Street >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Respawn location:", "< North Yankton >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Respawn location:", "< Cayo Perico >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Respawn location:", "< Fort Zancudo >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Respawn location:", "< Vinewood Sign >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Respawn location:", "< Mount Chiliad >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, "Respawn location:", "< Sandy Shores Airfield >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, "Respawn location:", "< IAA Building >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Respawn location:", "< Mount Gordo >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Respawn location:", "< Del Perro Pier >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "Respawn location:", "< Paleto Bay >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Respawn location:", "< Humane Labs >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_CATEGORY_SELECTOR(FLOAT y, BOOL selected)
    IF g_vehicle_spawn_category = 0 DRAW_OPTION(y, "Vehicle Type:", "< Cars >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 1 DRAW_OPTION(y, "Vehicle Type:", "< Bikes >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 2 DRAW_OPTION(y, "Vehicle Type:", "< Aircraft >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 3 DRAW_OPTION(y, "Vehicle Type:", "< DLC Cars >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 4 DRAW_OPTION(y, "Vehicle Type:", "< DLC Bikes >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 5 DRAW_OPTION(y, "Vehicle Type:", "< DLC Aircrafts >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 6 DRAW_OPTION(y, "Vehicle Type:", "< DLC Watercraft >", selected, 3) ENDIF
    IF g_vehicle_spawn_category = 7 DRAW_OPTION(y, "Vehicle Type:", "< Boats >", selected, 3) ENDIF
ENDPROC

PROC DRAW_VEHICLE_SPAWN_SELECTOR(FLOAT y, BOOL selected)
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() > 0 AND g_dlc_vehicle_index >= 0 AND DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index)
            MODEL_NAMES dlcModel = GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
            STRING dlcName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(dlcModel)
            DRAW_OPTION(y, "DLC Vehicle:", dlcName, selected, 3)
        ELSE
            DRAW_OPTION(y, "DLC Vehicle:", "NO MATCHING VEHICLES", selected, 0)
        ENDIF
        EXIT
    ENDIF
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
        CASE 18 DRAW_OPTION(y, "Vehicle:", "< Transport Bus >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Vehicle:", "< Bati 801 >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Vehicle:", "< PCJ-600 >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "Vehicle:", "< Akuma >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Vehicle:", "< Sanchez >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, "Vehicle:", "< Faggio >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, "Vehicle:", "< Buzzard >", selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, "Vehicle:", "< Duster >", selected, 3) BREAK
        CASE 26 DRAW_OPTION(y, "Vehicle:", "< Cargobob >", selected, 3) BREAK
        CASE 27 DRAW_OPTION(y, "Vehicle:", "< P-996 Lazer >", selected, 3) BREAK
        CASE 28 DRAW_OPTION(y, "Vehicle:", "< Blazer Custom >", selected, 3) BREAK
        CASE 29 DRAW_OPTION(y, "Vehicle:", "< Chimera >", selected, 3) BREAK
        CASE 30 DRAW_OPTION(y, "Vehicle:", "< Daemon Custom >", selected, 3) BREAK
        CASE 31 DRAW_OPTION(y, "Vehicle:", "< Defiler >", selected, 3) BREAK
        CASE 32 DRAW_OPTION(y, "Vehicle:", "< Esskey >", selected, 3) BREAK
        CASE 33 DRAW_OPTION(y, "Vehicle:", "< Faggio 3 >", selected, 3) BREAK
        CASE 34 DRAW_OPTION(y, "Vehicle:", "< Hakuchou Drag >", selected, 3) BREAK
        CASE 35 DRAW_OPTION(y, "Vehicle:", "< Manchez >", selected, 3) BREAK
        CASE 36 DRAW_OPTION(y, "Vehicle:", "< Nightblade >", selected, 3) BREAK
        CASE 37 DRAW_OPTION(y, "Vehicle:", "< Raptor >", selected, 3) BREAK
        CASE 38 DRAW_OPTION(y, "Vehicle:", "< Rat Bike >", selected, 3) BREAK
        CASE 39 DRAW_OPTION(y, "Vehicle:", "< Sanctus >", selected, 3) BREAK
        CASE 40 DRAW_OPTION(y, "Vehicle:", "< Shotaro >", selected, 3) BREAK
        CASE 41 DRAW_OPTION(y, "Vehicle:", "< Tornado Custom >", selected, 3) BREAK
        CASE 42 DRAW_OPTION(y, "Vehicle:", "< Vortex >", selected, 3) BREAK
        CASE 43 DRAW_OPTION(y, "Vehicle:", "< Wolfsbane >", selected, 3) BREAK
        CASE 44 DRAW_OPTION(y, "Vehicle:", "< Youga Classic >", selected, 3) BREAK
        CASE 45 DRAW_OPTION(y, "Vehicle:", "< Zombie A >", selected, 3) BREAK
        CASE 46 DRAW_OPTION(y, "Vehicle:", "< Zombie B >", selected, 3) BREAK
        CASE 47 DRAW_OPTION(y, "Vehicle:", "< Jester Racecar >", selected, 3) BREAK
        CASE 48 DRAW_OPTION(y, "Vehicle:", "< Massacro Racecar >", selected, 3) BREAK
        CASE 49 DRAW_OPTION(y, "Vehicle:", "< Rat Loader Custom >", selected, 3) BREAK
        CASE 50 DRAW_OPTION(y, "Vehicle:", "< Slamvan Custom >", selected, 3) BREAK
        CASE 51 DRAW_OPTION(y, "Vehicle:", "< Barracks Custom >", selected, 3) BREAK
        CASE 52 DRAW_OPTION(y, "Vehicle:", "< Boxville Armoured >", selected, 3) BREAK
        CASE 53 DRAW_OPTION(y, "Vehicle:", "< Casco >", selected, 3) BREAK
        CASE 54 DRAW_OPTION(y, "Vehicle:", "< Dinghy >", selected, 3) BREAK
        CASE 55 DRAW_OPTION(y, "Vehicle:", "< Enduro >", selected, 3) BREAK
        CASE 56 DRAW_OPTION(y, "Vehicle:", "< GBurrito >", selected, 3) BREAK
        CASE 57 DRAW_OPTION(y, "Vehicle:", "< Guardian >", selected, 3) BREAK
        CASE 58 DRAW_OPTION(y, "Vehicle:", "< Hydra >", selected, 3) BREAK
        CASE 59 DRAW_OPTION(y, "Vehicle:", "< Insurgent >", selected, 3) BREAK
        CASE 60 DRAW_OPTION(y, "Vehicle:", "< Insurgent Pick-Up >", selected, 3) BREAK
        CASE 61 DRAW_OPTION(y, "Vehicle:", "< Kuruma >", selected, 3) BREAK
        CASE 62 DRAW_OPTION(y, "Vehicle:", "< Kuruma Armoured >", selected, 3) BREAK
        CASE 63 DRAW_OPTION(y, "Vehicle:", "< Lectro >", selected, 3) BREAK
        CASE 64 DRAW_OPTION(y, "Vehicle:", "< Mule Custom >", selected, 3) BREAK
        CASE 65 DRAW_OPTION(y, "Vehicle:", "< Savage >", selected, 3) BREAK
        CASE 66 DRAW_OPTION(y, "Vehicle:", "< Slamvan >", selected, 3) BREAK
        CASE 67 DRAW_OPTION(y, "Vehicle:", "< Tanker >", selected, 3) BREAK
        CASE 68 DRAW_OPTION(y, "Vehicle:", "< Technical >", selected, 3) BREAK
        CASE 69 DRAW_OPTION(y, "Vehicle:", "< Trashmaster >", selected, 3) BREAK
        CASE 70 DRAW_OPTION(y, "Vehicle:", "< Valkyrie >", selected, 3) BREAK
        CASE 71 DRAW_OPTION(y, "Vehicle:", "< Velum >", selected, 3) BREAK
        CASE 72 DRAW_OPTION(y, "Vehicle:", "< Dinghy >", selected, 3) BREAK
        CASE 73 DRAW_OPTION(y, "Vehicle:", "< Dinghy 2 >", selected, 3) BREAK
        CASE 74 DRAW_OPTION(y, "Vehicle:", "< Dinghy 3 >", selected, 3) BREAK
        CASE 75 DRAW_OPTION(y, "Vehicle:", "< Jetmax >", selected, 3) BREAK
        CASE 76 DRAW_OPTION(y, "Vehicle:", "< Marquis >", selected, 3) BREAK
        CASE 77 DRAW_OPTION(y, "Vehicle:", "< Seashark / Jetski >", selected, 3) BREAK
        CASE 78 DRAW_OPTION(y, "Vehicle:", "< Seashark Lifeguard >", selected, 3) BREAK
        CASE 79 DRAW_OPTION(y, "Vehicle:", "< Seashark Custom >", selected, 3) BREAK
        CASE 80 DRAW_OPTION(y, "Vehicle:", "< Speeder >", selected, 3) BREAK
        CASE 81 DRAW_OPTION(y, "Vehicle:", "< Speeder 2 >", selected, 3) BREAK
        CASE 82 DRAW_OPTION(y, "Vehicle:", "< Squalo >", selected, 3) BREAK
        CASE 83 DRAW_OPTION(y, "Vehicle:", "< Submersible >", selected, 3) BREAK
        CASE 84 DRAW_OPTION(y, "Vehicle:", "< Suntrap >", selected, 3) BREAK
        CASE 85 DRAW_OPTION(y, "Vehicle:", "< Toro >", selected, 3) BREAK
        CASE 86 DRAW_OPTION(y, "Vehicle:", "< Toro 2 >", selected, 3) BREAK
        CASE 87 DRAW_OPTION(y, "Vehicle:", "< Tropic >", selected, 3) BREAK
        CASE 88 DRAW_OPTION(y, "Vehicle:", "< Tug >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_SELECTED_VEHICLE_SPAWN()
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() <= 0 EXIT ENDIF
        IF g_dlc_vehicle_index < 0 OR NOT DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index) EXIT ENDIF
        g_pending_vehicle_model = GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
    ELSE
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
        CASE 18 g_pending_vehicle_model = AIRBUS BREAK
        CASE 19 g_pending_vehicle_model = BATI BREAK
        CASE 20 g_pending_vehicle_model = PCJ BREAK
        CASE 21 g_pending_vehicle_model = AKUMA BREAK
        CASE 22 g_pending_vehicle_model = SANCHEZ BREAK
        CASE 23 g_pending_vehicle_model = FAGGIO BREAK
        CASE 24 g_pending_vehicle_model = BUZZARD BREAK
        CASE 25 g_pending_vehicle_model = DUSTER BREAK
        CASE 26 g_pending_vehicle_model = CARGOBOB BREAK
        CASE 27 g_pending_vehicle_model = LAZER BREAK
        CASE 28 g_pending_vehicle_model = BLAZER4 BREAK
        CASE 29 g_pending_vehicle_model = CHIMERA BREAK
        CASE 30 g_pending_vehicle_model = DAEMON2 BREAK
        CASE 31 g_pending_vehicle_model = DEFILER BREAK
        CASE 32 g_pending_vehicle_model = ESSKEY BREAK
        CASE 33 g_pending_vehicle_model = FAGGIO3 BREAK
        CASE 34 g_pending_vehicle_model = HAKUCHOU2 BREAK
        CASE 35 g_pending_vehicle_model = MANCHEZ BREAK
        CASE 36 g_pending_vehicle_model = NIGHTBLADE BREAK
        CASE 37 g_pending_vehicle_model = RAPTOR BREAK
        CASE 38 g_pending_vehicle_model = RATBIKE BREAK
        CASE 39 g_pending_vehicle_model = SANCTUS BREAK
        CASE 40 g_pending_vehicle_model = SHOTARO BREAK
        CASE 41 g_pending_vehicle_model = TORNADO6 BREAK
        CASE 42 g_pending_vehicle_model = VORTEX BREAK
        CASE 43 g_pending_vehicle_model = WOLFSBANE BREAK
        CASE 44 g_pending_vehicle_model = YOUGA2 BREAK
        CASE 45 g_pending_vehicle_model = ZOMBIEA BREAK
        CASE 46 g_pending_vehicle_model = ZOMBIEB BREAK
        CASE 47 g_pending_vehicle_model = JESTER2 BREAK
        CASE 48 g_pending_vehicle_model = MASSACRO2 BREAK
        CASE 49 g_pending_vehicle_model = RATLOADER2 BREAK
        CASE 50 g_pending_vehicle_model = SLAMVAN BREAK
        CASE 51 g_pending_vehicle_model = BARRACKS3 BREAK
        CASE 52 g_pending_vehicle_model = BOXVILLE4 BREAK
        CASE 53 g_pending_vehicle_model = CASCO BREAK
        CASE 54 g_pending_vehicle_model = DINGHY3 BREAK
        CASE 55 g_pending_vehicle_model = ENDURO BREAK
        CASE 56 g_pending_vehicle_model = GBURRITO2 BREAK
        CASE 57 g_pending_vehicle_model = GUARDIAN BREAK
        CASE 58 g_pending_vehicle_model = HYDRA BREAK
        CASE 59 g_pending_vehicle_model = INSURGENT BREAK
        CASE 60 g_pending_vehicle_model = INSURGENT2 BREAK
        CASE 61 g_pending_vehicle_model = KURUMA BREAK
        CASE 62 g_pending_vehicle_model = KURUMA2 BREAK
        CASE 63 g_pending_vehicle_model = LECTRO BREAK
        CASE 64 g_pending_vehicle_model = MULE3 BREAK
        CASE 65 g_pending_vehicle_model = SAVAGE BREAK
        CASE 66 g_pending_vehicle_model = SLAMVAN2 BREAK
        CASE 67 g_pending_vehicle_model = TANKER2 BREAK
        CASE 68 g_pending_vehicle_model = TECHNICAL BREAK
        CASE 69 g_pending_vehicle_model = TRASH2 BREAK
        CASE 70 g_pending_vehicle_model = VALKYRIE BREAK
        CASE 71 g_pending_vehicle_model = VELUM2 BREAK
        CASE 72 g_pending_vehicle_model = DINGHY BREAK
        CASE 73 g_pending_vehicle_model = DINGHY2 BREAK
        CASE 74 g_pending_vehicle_model = DINGHY3 BREAK
        CASE 75 g_pending_vehicle_model = JETMAX BREAK
        CASE 76 g_pending_vehicle_model = MARQUIS BREAK
        CASE 77 g_pending_vehicle_model = SEASHARK BREAK
        CASE 78 g_pending_vehicle_model = SEASHARK2 BREAK
        CASE 79 g_pending_vehicle_model = SEASHARK3 BREAK
        CASE 80 g_pending_vehicle_model = SPEEDER BREAK
        CASE 81 g_pending_vehicle_model = SPEEDER2 BREAK
        CASE 82 g_pending_vehicle_model = SQUALO BREAK
        CASE 83 g_pending_vehicle_model = SUBMERSIBLE BREAK
        CASE 84 g_pending_vehicle_model = SUNTRAP BREAK
        CASE 85 g_pending_vehicle_model = TORO BREAK
        CASE 86 g_pending_vehicle_model = TORO2 BREAK
        CASE 87 g_pending_vehicle_model = TROPIC BREAK
        CASE 88 g_pending_vehicle_model = TUG BREAK
    ENDSWITCH
    ENDIF
    IF IS_MODEL_IN_CDIMAGE(g_pending_vehicle_model)
        IF g_spawn_count < 1 g_spawn_count = 1 ENDIF
        IF g_spawn_count > 500 g_spawn_count = 500 ENDIF
        g_spawn_remaining = g_spawn_count
        g_active_spawn_count = g_spawn_count
        g_spawn_index = 0
        g_spawn_warp_index = -1
        IF g_spawn_teleport_into_vehicle
            IF g_active_spawn_count = 1
                g_spawn_warp_index = 0
            ELSE
                g_spawn_warp_index = GET_RANDOM_INT_IN_RANGE(0, g_active_spawn_count)
            ENDIF
        ENDIF
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
    FLOAT offsetY = 4.0

    IF g_active_spawn_count <= 1
        offsetX = 0.0
        offsetY = 2.50
    ELIF g_spawn_alignment = 0
        column = g_spawn_index - ((g_spawn_index / 10) * 10)
        row = g_spawn_index / 10
        offsetX = (TO_FLOAT(column) - 4.5) * 4.2
        offsetY = 4.0 + (TO_FLOAT(row) * 5.5)
    ELSE
        column = g_spawn_index - ((g_spawn_index / 5) * 5)
        row = g_spawn_index / 5
        offsetX = (TO_FLOAT(column) - 2.0) * 5.5
        offsetY = 4.0 + (TO_FLOAT(row) * 4.2)
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
        IF g_spawn_index = g_spawn_warp_index
            SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), spawnedVehicle, VS_DRIVER)
        ENDIF
    ENDIF
    g_spawn_index = g_spawn_index + 1
    g_spawn_remaining = g_spawn_remaining - 1
    IF g_spawn_remaining <= 0
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
        g_vehicle_spawn_pending = FALSE
        g_active_spawn_count = 0
        g_spawn_warp_index = -1
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
        CASE 12 TELEPORT_TO_NORTH_YANKTON() BREAK
        CASE 13 TELEPORT_TO_CAYO_PERICO() BREAK
        CASE 14 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-2047.4, 3132.1, 32.8>>) BREAK
        CASE 15 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<711.7, 1198.8, 348.5>>) BREAK
        CASE 16 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<501.7, 5604.4, 797.9>>) BREAK
        CASE 17 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<1692.0, 3291.0, 41.0>>) BREAK
        CASE 18 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-438.0, 1076.0, 327.0>>) BREAK
        CASE 19 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1170.0, 4927.0, 224.0>>) BREAK
        CASE 20 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1604.5, -1072.5, 13.0>>) BREAK
        CASE 21 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-112.3, 6463.2, 31.0>>) BREAK
        CASE 22 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<3615.2, 3740.6, 28.7>>) BREAK
    ENDSWITCH
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
    MODEL_NAMES currentPlayerModel
    IF g_outfit_open
        ADJUST_OUTFIT_TEXTURE()
        EXIT
    ENDIF
    IF g_ped_open
        IF g_item = 0
            OPEN_MENU_KEYBOARD(3)
        ELIF g_item > 1
            SAVE_ACTIVE_CHARACTER_PED()
            g_ped_choice = g_item - 2
            REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(g_ped_choice))
        ENDIF
        EXIT
    ENDIF
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
                CASE 14 g_infinite_parachute = NOT g_infinite_parachute BREAK
                CASE 15
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_outfit_open = TRUE
                    g_item = g_outfit_item
                    g_scroll = g_outfit_scroll
                BREAK
                CASE 16
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    currentPlayerModel = GET_ENTITY_MODEL(playerPed)
                    IF currentPlayerModel = PLAYER_ONE g_character_slot = 1 ENDIF
                    IF currentPlayerModel = PLAYER_TWO g_character_slot = 2 ENDIF
                    IF currentPlayerModel != PLAYER_ONE AND currentPlayerModel != PLAYER_TWO AND currentPlayerModel != PLAYER_ZERO g_character_slot = 0 ENDIF
                    g_ped_choice = PED_CHOICE_FOR_MODEL(currentPlayerModel)
                    g_ped_open = TRUE
                    g_item = g_ped_item
                    g_scroll = g_ped_scroll
                BREAK
                CASE 17 CLEAR_PLAYER_DAMAGE_MARKS() BREAK
                CASE 18 SET_ENTITY_HEALTH(playerPed, 0) BREAK
                CASE 19
                    g_unlimited_oxygen = NOT g_unlimited_oxygen
                    APPLY_UNLIMITED_OXYGEN()
                BREAK
                CASE 20
                    g_unlimited_ability = NOT g_unlimited_ability
                    APPLY_UNLIMITED_ABILITY()
                BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH g_item
                CASE 0
                    GIVE_ALL_MENU_WEAPONS(playerPed)
                BREAK
                CASE 1
                    GIVE_SELECTED_MENU_WEAPON(playerPed)
                BREAK
                CASE 2
                    g_infinite_ammo = NOT g_infinite_ammo
                    SET_PED_INFINITE_AMMO(playerPed, g_infinite_ammo, WEAPONTYPE_INVALID)
                BREAK
                CASE 3
                    REFILL_ALL_OWNED_WEAPONS(playerPed)
                BREAK
                CASE 4
                    REMOVE_ALL_PED_WEAPONS(playerPed)
                BREAK
                CASE 5
                    g_explosive_ammo = NOT g_explosive_ammo
                BREAK
                CASE 6
                    g_fire_ammo = NOT g_fire_ammo
                BREAK
                CASE 7
                    REMOVE_WEAPON_FROM_PED(playerPed, GET_SELECTED_PED_WEAPON(playerPed))
                BREAK
                CASE 8
                    g_infinite_clip = NOT g_infinite_clip
                    SET_PED_INFINITE_AMMO_CLIP(playerPed, g_infinite_clip)
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
                    SET_PLAYER_WANTED_LEVEL(PLAYER_ID(), g_wanted_level_choice)
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
                    CASE 2 START_ONE_SELECTED_VEHICLE_SPAWN() BREAK
                    CASE 3 OPEN_MENU_KEYBOARD(1) BREAK
                    CASE 4 g_spawn_maxed = NOT g_spawn_maxed BREAK
                    CASE 7 g_delete_previous_spawned_vehicle = NOT g_delete_previous_spawned_vehicle BREAK
                    CASE 8 DELETE_ALL_CUSTOM_CARS() BREAK
                    CASE 9 g_spawn_teleport_into_vehicle = NOT g_spawn_teleport_into_vehicle BREAK
                    CASE 10 OPEN_MENU_KEYBOARD(4) BREAK
                ENDSWITCH
            ELIF g_lsc_open
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    SWITCH g_item
                        CASE 0 APPLY_LSC_MAX() BREAK
                        CASE 2 APPLY_LSC_MOD() BREAK
                        CASE 9
                            g_lsc_turbo = NOT g_lsc_turbo
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_lsc_turbo)
                        BREAK
                        CASE 10
                            g_lsc_xenon = NOT g_lsc_xenon
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_XENON_LIGHTS, g_lsc_xenon)
                        BREAK
                        CASE 12
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
                        CASE 14
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
            ELIF g_item = 6
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_lsc_open = TRUE
                g_lsc_mod_choice = -1
                IF IS_PED_IN_ANY_VEHICLE(playerPed) SYNC_LSC_VEHICLE_STATE() ENDIF
                g_item = g_lsc_item
                g_scroll = g_lsc_scroll
            ELIF g_item = 1
                WARP_INTO_LAST_PLAYER_VEHICLE()
            ELIF g_item = 2
                g_vehicle_quick_entry_exit = NOT g_vehicle_quick_entry_exit
            ELIF g_item = 3
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(playerPed))
                ENDIF
            ELIF g_item = 4
                g_vehicle_speedometer = NOT g_vehicle_speedometer
            ELIF g_item = 5
                g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
            ELIF g_item = 19
                SPAWN_OR_ENTER_TRAIN()
            ELIF g_item = 20
                BRING_PERSONAL_VEHICLE()
            ELIF g_item > 6 AND g_item < 19 AND IS_PED_IN_ANY_VEHICLE(playerPed)
                playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                SWITCH g_item
                    CASE 7
                        g_vehicle_god = NOT g_vehicle_god
                        SET_ENTITY_INVINCIBLE(playerVehicle, g_vehicle_god)
                    BREAK
                    CASE 8
                        SET_VEHICLE_FIXED(playerVehicle)
                        SET_VEHICLE_ENGINE_HEALTH(playerVehicle, 1000.0)
                    BREAK
                    CASE 9
                        g_vehicle_auto_repair = NOT g_vehicle_auto_repair
                    BREAK
                    CASE 10 SET_VEHICLE_ON_GROUND_PROPERLY(playerVehicle) BREAK
                    CASE 11 SET_VEHICLE_ENGINE_HEALTH(playerVehicle, -4000.0) BREAK
                    CASE 12
                        g_doors_locked = NOT g_doors_locked
                        IF g_doors_locked
                            SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_LOCKED)
                        ELSE
                            SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_UNLOCKED)
                        ENDIF
                    BREAK
                    CASE 13
                        g_seatbelt = NOT g_seatbelt
                        IF g_seatbelt
                            SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_NEVER)
                            SET_PED_CAN_BE_DRAGGED_OUT(playerPed, FALSE)
                            SET_PED_CAN_RAGDOLL(playerPed, FALSE)
                            SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(playerPed, FALSE)
                            SET_PED_CONFIG_FLAG(playerPed, PCF_WillFlyThroughWindscreen, FALSE)
                        ELSE
                            SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_DEFAULT)
                            SET_PED_CAN_BE_DRAGGED_OUT(playerPed, TRUE)
                            IF NOT g_no_ragdoll SET_PED_CAN_RAGDOLL(playerPed, TRUE) ENDIF
                            SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(playerPed, TRUE)
                            SET_PED_CONFIG_FLAG(playerPed, PCF_WillFlyThroughWindscreen, TRUE)
                        ENDIF
                    BREAK
                    CASE 14 BREAK
                    CASE 15 g_vehicle_horn_boost = NOT g_vehicle_horn_boost BREAK
                    CASE 16 BREAK
                    CASE 17 g_vehicle_bulletproof_tyres = NOT g_vehicle_bulletproof_tyres BREAK
                    CASE 18
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
                CASE 6 APPLY_EDITABLE_TIME() BREAK
                CASE 7 APPLY_EDITABLE_TIME() BREAK
                CASE 8 APPLY_EDITABLE_TIME() BREAK
                CASE 9
                    g_pause_time = NOT g_pause_time
                    PAUSE_CLOCK(g_pause_time)
                BREAK
                CASE 11 APPLY_IPL_PRESET(TRUE) BREAK
                CASE 12 APPLY_IPL_PRESET(FALSE) BREAK
                CASE 13 OPEN_MENU_KEYBOARD(8) BREAK
                CASE 14 LOAD_CUSTOM_IPL() BREAK
                CASE 15 UNLOAD_CUSTOM_IPL() BREAK
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
                CASE 0 TELEPORT_TO_WAYPOINT() BREAK
                CASE 1 TELEPORT_TO_OBJECTIVE() BREAK
                CASE 2 g_auto_waypoint = NOT g_auto_waypoint BREAK
                CASE 3 TELEPORT_PLAYER_WITH_VEHICLE(<<501.7, 5604.4, 797.9>>) BREAK
                CASE 4 TELEPORT_PLAYER_WITH_VEHICLE(<<-75.0, -818.9, 326.2>>) BREAK
                CASE 5 TELEPORT_PLAYER_WITH_VEHICLE(<<-1034.6, -2733.6, 20.2>>) BREAK
                CASE 6 TELEPORT_PLAYER_WITH_VEHICLE(<<711.7, 1198.8, 348.5>>) BREAK
                CASE 7 TELEPORT_PLAYER_WITH_VEHICLE(<<-2047.4, 3132.1, 32.8>>) BREAK
                CASE 8 TELEPORT_PLAYER_WITH_VEHICLE(<<102.9, -1939.7, 20.8>>) BREAK
                CASE 9 TELEPORT_PLAYER_WITH_VEHICLE(<<-14.4, -1438.0, 31.1>>) BREAK
                CASE 10 TELEPORT_PLAYER_WITH_VEHICLE(<<-852.4, 160.0, 65.6>>) BREAK
                CASE 11
                    PREPARE_TELEPORT_IPL(11)
                    TELEPORT_PLAYER_WITH_VEHICLE(<<1975.5, 3819.6, 33.4>>)
                BREAK
                CASE 12 TELEPORT_PLAYER_WITH_VEHICLE(<<1274.8, -1710.0, 54.8>>) BREAK
                CASE 13 TELEPORT_PLAYER_WITH_VEHICLE(<<-47.1, -1112.3, 26.4>>) BREAK
                CASE 14
                    PREPARE_TELEPORT_IPL(14)
                    TELEPORT_PLAYER_WITH_VEHICLE(<<-449.7, -340.7, 34.5>>)
                BREAK
                CASE 15 TELEPORT_PLAYER_WITH_VEHICLE(<<425.1, -979.5, 30.7>>) BREAK
                CASE 16 TELEPORT_PLAYER_WITH_VEHICLE(<<-662.1, -948.5, 21.5>>) BREAK
                CASE 17 TELEPORT_PLAYER_WITH_VEHICLE(<<-365.4, -131.4, 37.9>>) BREAK
                CASE 18 TELEPORT_TO_NORTH_YANKTON() BREAK
                CASE 19 TELEPORT_TO_CAYO_PERICO() BREAK
                CASE 20 TELEPORT_PLAYER_WITH_VEHICLE(<<1692.0, 3291.0, 41.0>>) BREAK
                CASE 21 TELEPORT_PLAYER_WITH_VEHICLE(<<-438.0, 1076.0, 327.0>>) BREAK
                CASE 22 TELEPORT_PLAYER_WITH_VEHICLE(<<-1170.0, 4927.0, 224.0>>) BREAK
                CASE 23 OPEN_MENU_KEYBOARD(5) BREAK
                CASE 24 OPEN_MENU_KEYBOARD(6) BREAK
                CASE 25 OPEN_MENU_KEYBOARD(7) BREAK
                CASE 26 TELEPORT_TO_ENTERED_COORDS() BREAK
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
                CASE 7
                    CLEAR_AREA_OF_PEDS(GET_ENTITY_COORDS(playerPed), 50.0)
                    CLEAR_MENU_ATTACKERS()
                BREAK
                CASE 8 g_block_phone_hangup = NOT g_block_phone_hangup BREAK
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
        CASE 14 IF g_infinite_parachute DRAW_OPTION(y, "Infinite Parachute", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Infinite Parachute", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 DRAW_OPTION(y, "Outfit Customization", "OPEN", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, "PED Changer", "OPEN", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, "Clear Damage / Blood", "APPLY", g_item = index, 2) BREAK
        CASE 18 DRAW_OPTION(y, "Suicide", "APPLY", g_item = index, 0) BREAK
        CASE 19 IF g_unlimited_oxygen DRAW_OPTION(y, "Unlimited Oxygen", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Oxygen", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 20 IF g_unlimited_ability DRAW_OPTION(y, "Unlimited Ability", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Ability", "OFF", g_item = index, 0) ENDIF BREAK
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
    ELIF level = 9
        DRAW_OPTION(y, label, "< 20x >", selected, 3)
    ELIF level = 10
        DRAW_OPTION(y, label, "< 50x >", selected, 3)
    ELIF level = 11
        DRAW_OPTION(y, label, "< 100x >", selected, 3)
    ELSE
        DRAW_OPTION(y, label, "< 200x >", selected, 3)
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
    IF level = 10 RETURN 50.0 ENDIF
    IF level = 11 RETURN 100.0 ENDIF
    IF level = 12 RETURN 200.0 ENDIF
    RETURN 0.0
ENDFUNC

FUNC FLOAT TRAIN_ACCELERATION_SPEED(INT level)
    FLOAT speed = VEHICLE_MULTIPLIER_VALUE(level) * 15.0
    IF speed > 120.0 RETURN 120.0 ENDIF
    IF speed < 15.0 RETURN 15.0 ENDIF
    RETURN speed
ENDFUNC

FUNC FLOAT VEHICLE_GRIP_VALUE(INT level)
    IF level = -4 RETURN 0.15 ENDIF
    IF level = -3 RETURN 0.30 ENDIF
    IF level = -2 RETURN 0.50 ENDIF
    IF level = -1 RETURN 0.75 ENDIF
    IF level = 1 RETURN 1.10 ENDIF
    IF level = 2 RETURN 1.25 ENDIF
    IF level = 3 RETURN 1.40 ENDIF
    IF level = 4 RETURN 1.60 ENDIF
    IF level = 5 RETURN 1.80 ENDIF
    IF level = 6 RETURN 2.00 ENDIF
    IF level = 7 RETURN 2.25 ENDIF
    IF level = 8 RETURN 2.50 ENDIF
    RETURN -1.0
ENDFUNC

PROC DRAW_VEHICLE_GRIP_SELECTOR(FLOAT y, BOOL selected)
    IF g_vehicle_grip_level = -4 DRAW_OPTION(y, "Grip Strength", "< -85% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -3 DRAW_OPTION(y, "Grip Strength", "< -70% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -2 DRAW_OPTION(y, "Grip Strength", "< -50% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -1 DRAW_OPTION(y, "Grip Strength", "< -25% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 0 DRAW_OPTION(y, "Grip Strength", "< OFF >", selected, 0) ENDIF
    IF g_vehicle_grip_level = 1 DRAW_OPTION(y, "Grip Strength", "< +10% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 2 DRAW_OPTION(y, "Grip Strength", "< +25% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 3 DRAW_OPTION(y, "Grip Strength", "< +40% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 4 DRAW_OPTION(y, "Grip Strength", "< +60% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 5 DRAW_OPTION(y, "Grip Strength", "< +80% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 6 DRAW_OPTION(y, "Grip Strength", "< +100% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 7 DRAW_OPTION(y, "Grip Strength", "< +125% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 8 DRAW_OPTION(y, "Grip Strength", "< +150% >", selected, 3) ENDIF
ENDPROC

PROC DRAW_VEHICLE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Vehicle Spawner", "OPEN", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Enter Personal Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 2 IF g_vehicle_quick_entry_exit DRAW_OPTION(y, "Instant Enter / Exit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Instant Enter / Exit", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_OPTION(y, "Max Vehicle Upgrades", "APPLY", g_item = index, 2) BREAK
        CASE 4 IF g_vehicle_speedometer DRAW_OPTION(y, "Speedometer", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Speedometer", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_vehicle_speed_unit = 0 DRAW_OPTION(y, "Speed Unit", "< MPH >", g_item = index, 3) ELSE DRAW_OPTION(y, "Speed Unit", "< KMPH >", g_item = index, 3) ENDIF BREAK
        CASE 6 DRAW_OPTION(y, "LS Customs", "OPEN", g_item = index, 2) BREAK
        CASE 7 IF g_vehicle_god DRAW_OPTION(y, "Vehicle God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Vehicle God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_OPTION(y, "Repair Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_vehicle_auto_repair DRAW_OPTION(y, "Auto Repair Vehicle", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Repair Vehicle", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 DRAW_OPTION(y, "Flip Vehicle upright", "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, "Destroy Engine", "APPLY", g_item = index, 2) BREAK
        CASE 12 IF g_doors_locked DRAW_OPTION(y, "Lock Doors", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Lock Doors", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 IF g_seatbelt DRAW_OPTION(y, "Always Seatbelt", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Seatbelt", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14 DRAW_VEHICLE_MULTIPLIER(y, "Acceleration Boost", g_vehicle_acceleration_level, g_item = index) BREAK
        CASE 15 IF g_vehicle_horn_boost DRAW_OPTION(y, "Horn Boost", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Horn Boost", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 DRAW_VEHICLE_GRIP_SELECTOR(y, g_item = index) BREAK
        CASE 17 IF g_vehicle_bulletproof_tyres DRAW_OPTION(y, "Bulletproof Tyres", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Bulletproof Tyres", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 18 IF g_vehicle_turbo DRAW_OPTION(y, "Turbo Mod", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo Mod", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 19 DRAW_OPTION(y, "Spawn / Enter Train", "APPLY", g_item = index, 2) BREAK
        CASE 20 DRAW_OPTION(y, "Bring Personal Vehicle", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Spawn Selected Vehicle(s)", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_VEHICLE_CATEGORY_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_VEHICLE_SPAWN_SELECTOR(y, g_item = index) BREAK
        CASE 3 DRAW_NUMBER_OPTION(y, "Spawn Count", g_spawn_count, g_item = index) BREAK
        CASE 4 IF g_spawn_maxed DRAW_OPTION(y, "Max Available Upgrades", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Max Available Upgrades", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_spawn_alignment = 0 DRAW_OPTION(y, "Alignment", "< Door to Door >", g_item = index, 3) ELSE DRAW_OPTION(y, "Alignment", "< Bumper to Bumper >", g_item = index, 3) ENDIF BREAK
        CASE 6
            IF g_spawn_facing = 0 DRAW_OPTION(y, "Facing", "< Forward >", g_item = index, 3)
            ELIF g_spawn_facing = 1 DRAW_OPTION(y, "Facing", "< Right >", g_item = index, 3)
            ELIF g_spawn_facing = 2 DRAW_OPTION(y, "Facing", "< Backward >", g_item = index, 3)
            ELSE DRAW_OPTION(y, "Facing", "< Left >", g_item = index, 3) ENDIF
        BREAK
        CASE 7 IF g_delete_previous_spawned_vehicle DRAW_OPTION(y, "Auto Delete Previous Car", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Delete Previous Car", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_OPTION(y, "Delete All Custom Cars", "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_spawn_teleport_into_vehicle DRAW_OPTION(y, "TP in Spawned Vehicle", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "TP in Spawned Vehicle", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10
            IF g_vehicle_search_not_found
                DRAW_OPTION(y, "Spawn by Model Name", "NOT FOUND", g_item = index, 0)
            ELIF g_vehicle_search_has_value
                DRAW_OPTION(y, "Spawn by Model Name", g_vehicle_search_value, g_item = index, 3)
            ELSE
                DRAW_OPTION(y, "Spawn by Model Name", "TYPE MODEL", g_item = index, 3)
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SPAWNER")
    INT index = g_spawner_scroll
    INT row = 0
    WHILE row < 8 AND index < 11
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
        CASE 8 IF g_block_phone_hangup DRAW_OPTION(y, "Block B Phone Hangup", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Block B Phone Hangup", "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TELEPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Teleport to Waypoint", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Teleport to Objective", "APPLY", g_item = index, 2) BREAK
        CASE 2 IF g_auto_waypoint DRAW_OPTION(y, "Auto Teleport Waypoint", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Teleport Waypoint", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_OPTION(y, "Mount Chiliad", ">", g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Maze Bank Tower", ">", g_item = index, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Los Santos Airport", ">", g_item = index, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Vinewood Sign", ">", g_item = index, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Fort Zancudo", ">", g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Grove Street", ">", g_item = index, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Franklin's House", ">", g_item = index, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Michael's House", ">", g_item = index, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Trevor's Trailer", ">", g_item = index, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Lester's Warehouse", ">", g_item = index, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Simeon's Dealership", ">", g_item = index, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Hospital", ">", g_item = index, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Police Station", ">", g_item = index, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Ammu-Nation", ">", g_item = index, 3) BREAK
        CASE 17 DRAW_OPTION(y, "Los Santos Customs", ">", g_item = index, 3) BREAK
        CASE 18 DRAW_OPTION(y, "North Yankton", ">", g_item = index, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Cayo Perico", ">", g_item = index, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Sandy Shores Airfield", ">", g_item = index, 3) BREAK
        CASE 21 DRAW_OPTION(y, "IAA Building", ">", g_item = index, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Mount Gordo", ">", g_item = index, 3) BREAK
        CASE 23 DRAW_FLOAT_OPTION(y, "Coordinate X", g_teleport_x, g_item = index) BREAK
        CASE 24 DRAW_FLOAT_OPTION(y, "Coordinate Y", g_teleport_y, g_item = index) BREAK
        CASE 25 DRAW_FLOAT_OPTION(y, "Coordinate Z", g_teleport_z, g_item = index) BREAK
        CASE 26 DRAW_OPTION(y, "Teleport to Coordinates", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Max All Available Mods", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_LSC_MOD_SELECTOR(y, g_item = index) BREAK
        CASE 3 DRAW_LSC_VARIANT_COUNT(y, g_item = index) BREAK
        CASE 4 DRAW_LSC_COLOUR_SELECTOR(y, "Primary Paint", g_lsc_primary_colour, g_item = index) BREAK
        CASE 5 DRAW_LSC_COLOUR_SELECTOR(y, "Secondary Paint", g_lsc_secondary_colour, g_item = index) BREAK
        CASE 6 DRAW_LSC_COLOUR_SELECTOR(y, "Pearlescent Paint", g_lsc_pearlescent_colour, g_item = index) BREAK
        CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, "Wheel Colour", g_lsc_wheel_colour, g_item = index) BREAK
        CASE 8 DRAW_OPTION(y, "Wheel Type", "< cycle >", g_item = index, 3) BREAK
        CASE 9 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon Lights", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 DRAW_LSC_LIGHT_SELECTOR(y, "Xenon Colour", g_lsc_xenon_colour, g_item = index) BREAK
        CASE 12 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon Kit", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 DRAW_LSC_LIGHT_SELECTOR(y, "Neon Colour", g_lsc_neon_colour, g_item = index) BREAK
        CASE 14 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
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

PROC DRAW_WORLD_PAGE()
    INT worldIndex = g_scroll
    INT worldRow = 0
    WHILE worldRow < 8 AND worldIndex < 16
        DRAW_WORLD_ROW(worldIndex, 0.268 + (TO_FLOAT(worldRow) * ROW_H))
        worldIndex = worldIndex + 1
        worldRow = worldRow + 1
    ENDWHILE
ENDPROC

PROC DRAW_WEAPON_PAGE()
    INT weaponIndex = g_scroll
    INT weaponRow = 0
    WHILE weaponRow < 8 AND weaponIndex < 9
        FLOAT y = 0.268 + (TO_FLOAT(weaponRow) * ROW_H)
        IF weaponIndex = 0 DRAW_OPTION(y, "Give All Weapons", "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 1 DRAW_MENU_WEAPON_SELECTOR(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 2
            IF g_infinite_ammo DRAW_OPTION(y, "Infinite Ammo", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Infinite Ammo", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 3 DRAW_OPTION(y, "Refill All Ammo", "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 4 DRAW_OPTION(y, "Remove All Weapons", "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 5
            IF g_explosive_ammo DRAW_OPTION(y, "Explosive Bullets", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Explosive Bullets", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 6
            IF g_fire_ammo DRAW_OPTION(y, "Flaming Bullets", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Flaming Bullets", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 7 DRAW_OPTION(y, "Remove Current Weapon", "APPLY", g_item = weaponIndex, 0) ENDIF
        IF weaponIndex = 8
            IF g_infinite_clip DRAW_OPTION(y, "Infinite Clip", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Infinite Clip", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        weaponIndex = weaponIndex + 1
        weaponRow = weaponRow + 1
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
    DRAW_RECT(g_menu_x - 0.015, 0.403 + g_menu_y, MENU_W, 0.505, 8, 9, 12, 220)
    DRAW_RECT(g_menu_x - 0.015, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x - 0.015, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.074, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.08, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    SWITCH g_tab
        CASE 0
            IF g_outfit_open
                DRAW_OUTFIT_PAGE()
            ELIF g_ped_open
                DRAW_PED_PAGE()
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PLAYER SETTINGS")
                DRAW_SCROLLING_ROWS(21, 0)
            ENDIF
        BREAK
        CASE 1
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WEAPON SETTINGS")
            DRAW_WEAPON_PAGE()
        BREAK
        CASE 2
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WANTED LEVEL SETTINGS")
            IF g_never_wanted DRAW_OPTION(0.268, "Never Wanted", "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, "Never Wanted", "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, "Clear Wanted Level", "APPLY", g_item = 1, 2)
            DRAW_WANTED_LEVEL_SELECTOR(0.344, g_item = 2)
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
            DRAW_SCROLLING_ROWS(21, 1)
            ENDIF
        BREAK
        CASE 4
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WORLD AND WEATHER")
            DRAW_WORLD_PAGE()
        BREAK
        CASE 5
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PORTABLE RADIO")
            IF g_mobile_radio DRAW_OPTION(0.268, "Portable Radio", "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, "Portable Radio", "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, "Previous Station", "APPLY", g_item = 1, 2)
            DRAW_OPTION(0.344, "Next Station", "APPLY", g_item = 2, 2)
        BREAK
        CASE 6
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "TELEPORT LOCATIONS")
            DRAW_SCROLLING_ROWS(27, 3)
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
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
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

        IF g_god SET_PLAYER_INVINCIBLE(PLAYER_ID(), TRUE) ENDIF
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
        IF g_unlimited_oxygen APPLY_UNLIMITED_OXYGEN() ENDIF
        IF g_unlimited_ability APPLY_UNLIMITED_ABILITY() ENDIF
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
        PROCESS_PENDING_TELEPORT()
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
                        TELEPORT_PLAYER_WITH_VEHICLE(waypointPosition)
                    ENDIF
                ENDIF
            ELSE
                g_auto_waypoint_seen = FALSE
            ENDIF
        ELSE
            g_auto_waypoint_seen = FALSE
        ENDIF
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
        IF g_player_in_vehicle
            VEHICLE_INDEX currentVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
            FLOAT currentVehicleSpeed = GET_ENTITY_SPEED(currentVehicle)
            IF g_vehicle_auto_repair SET_VEHICLE_FIXED(currentVehicle) ENDIF
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
        PROCESS_PHONE_HANGUP_BLOCK()
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
                ELIF g_outfit_open
                    g_outfit_item = g_item
                    g_outfit_scroll = g_scroll
                    g_outfit_open = FALSE
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
