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

PROC DRAW_MENU_VERSION_TAG()
    MENU_TEXT_RIGHT(g_menu_x + 0.105, 0.198, 0.270, 255, 255, 255, "v0.9.2")
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


FUNC INT DESCRIPTION_WRAPPED_LINES(STRING value)
    INT textLength = GET_LENGTH_OF_LITERAL_STRING(value)
    IF textLength <= 51 RETURN 1 ENDIF
    IF textLength <= 92 RETURN 2 ENDIF
    IF textLength <= 133 RETURN 3 ENDIF
    IF textLength <= 174 RETURN 4 ENDIF
    RETURN 5
ENDFUNC

FUNC FLOAT DESCRIPTION_PANEL_HEIGHT(STRING value)
    INT lines = DESCRIPTION_WRAPPED_LINES(value)
    IF lines <= 1 RETURN 0.034 ENDIF
    IF lines = 2 RETURN 0.054 ENDIF
    IF lines = 3 RETURN 0.078 ENDIF
    IF lines = 4 RETURN 0.102 ENDIF
    RETURN 0.126
ENDFUNC


PROC SELECTED_DESCRIPTION_TEXT()
    IF g_home
        SWITCH g_item
            CASE 0 g_selected_description = "Player abilities, appearance, and character tools." BREAK
            CASE 1 g_selected_description = "Give, refill, and modify your weapons and ammunition." BREAK
            CASE 2 g_selected_description = "Control wanted level, police behavior, and dispatch." BREAK
            CASE 3 g_selected_description = "Spawn, enter, repair, and customize vehicles." BREAK
            CASE 4 g_selected_description = "Change time, weather, vision, and camera effects." BREAK
            CASE 5 g_selected_description = "Teleport to map targets and fixed locations." BREAK
            CASE 6 g_selected_description = "World population, NPC, HUD, and phone options." BREAK
            CASE 7 g_selected_description = "Menu colors, position, and custom respawn behavior." BREAK
        ENDSWITCH
    ELIF g_outfit_open
        g_selected_description = "Cycle the selected clothing slot with Left/Right; press A to change its texture."
    ELIF g_radio_open
        SWITCH g_item
            CASE 0 g_selected_description = "Enable portable radio control while on foot." BREAK
            CASE 1 g_selected_description = "Tune the radio to the previous station." BREAK
            CASE 2 g_selected_description = "Tune the radio to the next station." BREAK
        ENDSWITCH
    ELIF g_bodyguard_open
        SWITCH g_item
            CASE 0 g_selected_description = "Spawn one armed bodyguard next to the player." BREAK
            CASE 1 g_selected_description = "Choose the model used for spawned bodyguards." BREAK
            CASE 2 g_selected_description = "Choose the weapon given to spawned bodyguards." BREAK
            CASE 3 g_selected_description = "Choose how bodyguards position around the player." BREAK
            CASE 4 g_selected_description = "Make every bodyguard follow the player in formation." BREAK
            CASE 5 g_selected_description = "Show or hide bodyguard map blips for new guards." BREAK
            CASE 6 g_selected_description = "Make every spawned bodyguard invincible." BREAK
            CASE 7 g_selected_description = "Remove every spawned bodyguard." BREAK
        ENDSWITCH
    ELIF g_attacker_open
        SWITCH g_item
            CASE 0 g_selected_description = "Spawn an armed hostile attacker nearby." BREAK
            CASE 1 g_selected_description = "Choose the model used for spawned attackers." BREAK
            CASE 2 g_selected_description = "Choose the weapon given to spawned attackers." BREAK
            CASE 3 g_selected_description = "ON: attackers fight everyone nearby. OFF: they only attack the player." BREAK
            CASE 4 g_selected_description = "Make every spawned attacker invincible." BREAK
            CASE 5 g_selected_description = "Remove every spawned attacker." BREAK
        ENDSWITCH
    ELIF g_neon_anim_open
        IF g_neon_mode = 3
            SWITCH g_item
                CASE 0 g_selected_description = "Choose the neon animation mode. Left/Right applies it at once." BREAK
                CASE 1 g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes. Forward only." BREAK
                CASE 2 g_selected_description = "Smooth fades or Hard snaps. RGB Cycle only." BREAK
            ENDSWITCH
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = "Choose the neon animation mode. Left/Right applies it at once." BREAK
                CASE 1 g_selected_description = "Cycle the underglow base colour, like LSC. Non-RGB effects use it." BREAK
                CASE 2 g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes. Forward only." BREAK
            ENDSWITCH
        ENDIF
    ELIF g_ped_open
        IF g_item = 0 g_selected_description = "Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!" ENDIF
        IF g_item = 1 g_selected_description = "Apply a random validated PED model to the player." ENDIF
        IF g_item = 2 g_selected_description = "Switch between Franklin, Michael, and Trevor saved PED profiles." ENDIF
        IF g_item >= 3 g_selected_description = "Apply the selected PED model to the player." ENDIF
    ELIF g_statman_open
        SWITCH g_item
            CASE 0 g_selected_description = "Set every stat to 100 for the active character." BREAK
            CASE 1 g_selected_description = "Stamina for the active character. Left/Right adjusts by 5." BREAK
            CASE 2 g_selected_description = "Strength for the active character. Left/Right adjusts by 5." BREAK
            CASE 3 g_selected_description = "Lung capacity for the active character. Left/Right adjusts by 5." BREAK
            CASE 4 g_selected_description = "Flying skill for the active character. Left/Right adjusts by 5." BREAK
            CASE 5 g_selected_description = "Shooting skill for the active character. Left/Right adjusts by 5." BREAK
            CASE 6 g_selected_description = "Stealth skill for the active character. Left/Right adjusts by 5." BREAK
            CASE 7 g_selected_description = "Driving skill for the active character. Left/Right adjusts by 5." BREAK
            CASE 8 g_selected_description = "Special ability for the active character. Left/Right adjusts by 5." BREAK
        ENDSWITCH
    ELIF g_spawner_open
        SWITCH g_item
            CASE 0 g_selected_description = "Spawn the selected vehicle, using the configured count and layout." BREAK
            CASE 1 g_selected_description = "Choose a base-game, DLC, aircraft, bike, watercraft, or misc list." BREAK
            CASE 2 g_selected_description = "Choose the model to spawn; DLC entries follow the installed content." BREAK
            CASE 3 g_selected_description = "Set how many copies to create at once; DPAD Left/Right changes the count by intervals of 1; 500 Max" BREAK
            CASE 4 g_selected_description = "Apply the highest available upgrade to every spawned vehicle." BREAK
            CASE 5 g_selected_description = "Choose door-to-door or bumper-to-bumper formation." BREAK
            CASE 6 g_selected_description = "Choose the heading of spawned vehicles relative to the player." BREAK
            CASE 7 g_selected_description = "Automatically remove the previous custom vehicle when spawning." BREAK
            CASE 8 g_selected_description = "Delete every vehicle created by this menu." BREAK
            CASE 9 g_selected_description = "Enter a spawned vehicle automatically after it is created." BREAK
            CASE 10 g_selected_description = "Find a vehicle by model name. Extremely case sensitive. ALWAYS USE CAPS!" BREAK
        ENDSWITCH
    ELIF g_neon_anim_open
        IF g_neon_mode = 3
            SWITCH g_item
                CASE 0 g_selected_description = "Choose the neon animation mode. Left/Right applies it at once." BREAK
                CASE 1 g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes. Forward only." BREAK
                CASE 2 g_selected_description = "Smooth fades or Hard snaps. RGB Cycle only." BREAK
            ENDSWITCH
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = "Choose the neon animation mode. Left/Right applies it at once." BREAK
                CASE 1 g_selected_description = "Cycle the underglow base colour, like LSC. Non-RGB effects use it." BREAK
                CASE 2 g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes. Forward only." BREAK
            ENDSWITCH
        ENDIF
    ELIF g_lsc_open
        SWITCH g_item
            CASE 0 g_selected_description = "Apply the best available upgrade in every supported mod slot." BREAK
            CASE 1 g_selected_description = "Remove every modification and restore factory stock." BREAK
            CASE 2 g_selected_description = "Select the vehicle modification slot shown by the rows below." BREAK
            CASE 3 g_selected_description = "Cycle and apply the available variant for the selected slot." BREAK
            CASE 4 g_selected_description = "Shows how many variants the current slot provides." BREAK
            CASE 5 g_selected_description = "Set the primary paint color." BREAK
            CASE 6 g_selected_description = "Set the secondary paint color." BREAK
            CASE 7 g_selected_description = "Set the pearlescent paint color." BREAK
            CASE 8 g_selected_description = "Set the wheel paint color." BREAK
            CASE 9 g_selected_description = "Change the vehicle wheel family." BREAK
            CASE 10 g_selected_description = "Toggle the turbo modification." BREAK
            CASE 11 g_selected_description = "Toggle xenon headlights." BREAK
            CASE 12 g_selected_description = "Choose the xenon headlight color." BREAK
            CASE 13 g_selected_description = "Toggle all four neon tubes." BREAK
            CASE 14 g_selected_description = "Choose the neon light color." BREAK
            CASE 15 g_selected_description = "Choose the window tint level." BREAK
            CASE 16 g_selected_description = "Type a custom plate (8 chars max) with the keyboard." BREAK
            CASE 17 g_selected_description = "Write the entered plate text to the occupied vehicle." BREAK
            CASE 18 g_selected_description = "Remove the currently selected slot's modification." BREAK
        ENDSWITCH
    ELSE
        SWITCH g_tab
            CASE 0
                SWITCH g_item
                    CASE 0 g_selected_description = "Open the portable radio submenu." BREAK
                    CASE 1 g_selected_description = "Make the player immune to damage." BREAK
                    CASE 2 g_selected_description = "Restore health and armor to full." BREAK
                    CASE 3 g_selected_description = "Hide the player model from the world." BREAK
                    CASE 4 g_selected_description = "Open the searchable PED model selector." BREAK
                    CASE 5 g_selected_description = "Open the clothing and apparel editor." BREAK
                    CASE 6 g_selected_description = "Open the character stat editor." BREAK
                    CASE 7 g_selected_description = "Open the bodyguard management submenu." BREAK
                    CASE 8 g_selected_description = "Open the attacker management submenu." BREAK
                    CASE 9 g_selected_description = "Stick moves, Y up, B down. No entry while on." BREAK
                    CASE 10 g_selected_description = "Invisible first-person fly. Y up, B down" BREAK
                    CASE 11 g_selected_description = "Keep the player's underwater air supply full." BREAK
                    CASE 12 g_selected_description = "Keep the character's special ability charged." BREAK
                    CASE 13 g_selected_description = "Increase running speed." BREAK
                    CASE 14 g_selected_description = "Increase swimming speed." BREAK
                    CASE 15 g_selected_description = "Allow the player to jump higher." BREAK
                    CASE 16 g_selected_description = "Prevent the player from ragdolling." BREAK
                    CASE 17 g_selected_description = "Keep a parachute available whenever needed." BREAK
                    CASE 18 g_selected_description = "DPAD Left/Right adjusts by $10,000. A opens keyboard entry." BREAK
                    CASE 19 g_selected_description = "Apply the selected cash amount to the active character." BREAK
                    CASE 20 g_selected_description = "Make melee impacts explosive." BREAK
                    CASE 21 g_selected_description = "Launch peds, vehicles and loose props with melee hits." BREAK
                    CASE 22 g_selected_description = "Apply the drunk movement style." BREAK
                    CASE 23 g_selected_description = "Remove blood, wetness, dirt, and visible damage from the player." BREAK
                    CASE 24 g_selected_description = "Set the player's health to zero." BREAK
                ENDSWITCH
                BREAK
            CASE 1
                IF g_weapon_upgrades_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Refill ammunition for the weapon currently in hand." BREAK
                        CASE 1 g_selected_description = "Give or remove the best magazine available for this weapon." BREAK
                        CASE 2 g_selected_description = "Give or remove the flashlight for this weapon." BREAK
                        CASE 3 g_selected_description = "Give or remove the suppressor for this weapon." BREAK
                        CASE 4 g_selected_description = "Give or remove the grip for this weapon." BREAK
                        CASE 5 g_selected_description = "Give or remove the scope for this weapon." BREAK
                        CASE 6 g_selected_description = "Change the weapon tint color with Left/Right." BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                        CASE 0 g_selected_description = "Give every supported base-game and installed DLC weapon." BREAK
                        CASE 1 g_selected_description = "Choose one weapon with Left/Right, then press A to give it." BREAK
                        CASE 2 g_selected_description = "Keep the player's ammunition from running out." BREAK
                        CASE 3 g_selected_description = "Prevent the current magazine from being depleted." BREAK
                        CASE 4 g_selected_description = "Refill ammunition for every weapon the player owns." BREAK
                        CASE 5 g_selected_description = "Open upgrades for the weapon currently in hand." BREAK
                        CASE 6 g_selected_description = "Make fired bullets create explosive impacts." BREAK
                        CASE 7 g_selected_description = "Remove the weapon currently selected in the weapon wheel." BREAK
                        CASE 8 g_selected_description = "Remove every weapon from the player." BREAK
                    ENDSWITCH
                ENDIF
                BREAK
            CASE 2
                SWITCH g_item
                    CASE 0 g_selected_description = "Continuously clear the player's wanted level." BREAK
                    CASE 1 g_selected_description = "Clear the current wanted level immediately." BREAK
                    CASE 2 g_selected_description = "Choose a wanted level from one to five, then apply it." BREAK
                    CASE 3 g_selected_description = "Make police ignore the player." BREAK
                    CASE 4 g_selected_description = "Enable or disable police and emergency dispatch services." BREAK
                    CASE 5 g_selected_description = "Enable or disable civilian reports to police." BREAK
                ENDSWITCH
                BREAK
            CASE 3
                SWITCH g_item
                    CASE 0 g_selected_description = "Open the vehicle spawner and choose a vehicle to create." BREAK
                    CASE 1 g_selected_description = "Open the LS Customs modification and paint editor." BREAK
                    CASE 2 g_selected_description = "Open the neon animation submenu. Requires a vehicle." BREAK
                    CASE 3 g_selected_description = "Make the occupied vehicle immune to damage." BREAK
                    CASE 4 g_selected_description = "Repair damage to the occupied vehicle immediately." BREAK
                    CASE 5 g_selected_description = "Apply the highest available upgrade to the occupied vehicle." BREAK
                    CASE 6 g_selected_description = "Automatically max upgrades on every vehicle entered." BREAK
                    CASE 7 g_selected_description = "Increase vehicle acceleration from stock through 200x." BREAK
                    CASE 8 g_selected_description = "Adjust tyre grip from reduced grip through high grip." BREAK
                    CASE 9 g_selected_description = "Keep the tow hook attached no matter the impacts." BREAK
                    CASE 10 g_selected_description = "Toggle the vehicle's turbo modification." BREAK
                    CASE 11 g_selected_description = "Prevent tyres from bursting." BREAK
                    CASE 12 g_selected_description = "Set the occupied vehicle upright on the ground." BREAK
                    CASE 13 g_selected_description = "Skip entry and exit animations when entering or leaving vehicles." BREAK
                    CASE 14 g_selected_description = "Enter the personal vehicle marked by the game." BREAK
                    CASE 15 g_selected_description = "Bring the player's story-mode personal vehicle to the current location and enter it." BREAK
                    CASE 16 g_selected_description = "Hold the horn to apply a forward boost." BREAK
                    CASE 17 g_selected_description = "Repair the occupied vehicle continuously." BREAK
                    CASE 18 g_selected_description = "Open the rear cargo/ramp doors on the occupied plane." BREAK
                    CASE 19 g_selected_description = "Lock or unlock the occupied vehicle's doors." BREAK
                    CASE 20 g_selected_description = "Prevent ejection from crashes; X is still used to exit." BREAK
                    CASE 21 g_selected_description = "Destroy the occupied vehicle's engine." BREAK
                    CASE 22 g_selected_description = "Show the occupied vehicle's current speed." BREAK
                    CASE 23 g_selected_description = "Choose MPH or KMPH for the speedometer." BREAK
                ENDSWITCH
                BREAK
            CASE 4
                IF g_timeweather_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Choose a time of day and press A to apply it." BREAK
                        CASE 1 g_selected_description = "Set the editable hour; Left/Right changes it immediately." BREAK
                        CASE 2 g_selected_description = "Set the editable minute; Left/Right changes it immediately." BREAK
                        CASE 3 g_selected_description = "Set the editable second; Left/Right changes it immediately." BREAK
                        CASE 4 g_selected_description = "Freeze or resume the world clock." BREAK
                        CASE 5 g_selected_description = "Choose weather and press A to apply it persistently." BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                    CASE 0 g_selected_description = "Open the time and weather controls." BREAK
                    CASE 1 g_selected_description = "Toggle night vision." BREAK
                    CASE 2 g_selected_description = "Toggle thermal vision." BREAK
                    CASE 3 g_selected_description = "Choose a safe story-mode IPL preset." BREAK
                    CASE 4 g_selected_description = "Request the selected IPL preset." BREAK
                    CASE 5 g_selected_description = "Remove the selected IPL preset." BREAK
                    CASE 6 g_selected_description = "Enter an IPL name with the Switch keyboard." BREAK
                    CASE 7 g_selected_description = "Request the custom IPL name." BREAK
                    CASE 8 g_selected_description = "Remove the custom IPL name." BREAK
                    CASE 9 g_selected_description = "Apply or clear the CCTV scanline filter." BREAK
                    CASE 10 g_selected_description = "Start or stop the gameplay camera shake effect." BREAK
                    ENDSWITCH
                ENDIF
                BREAK
            CASE 5
                IF g_tp_stores_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Teleport inside Gas Store 1." BREAK
                        CASE 1 g_selected_description = "Teleport inside Gas Store 2." BREAK
                        CASE 2 g_selected_description = "Teleport inside Gas Store 3." BREAK
                        CASE 3 g_selected_description = "Teleport inside Gas Store 4." BREAK
                        CASE 4 g_selected_description = "Teleport inside Gas Store 5." BREAK
                        CASE 5 g_selected_description = "Teleport inside Liquor Store 1." BREAK
                        CASE 6 g_selected_description = "Teleport inside Liquor Store 2." BREAK
                        CASE 7 g_selected_description = "Teleport inside Liquor Store 3." BREAK
                        CASE 8 g_selected_description = "Teleport inside Liquor Store 4." BREAK
                        CASE 9 g_selected_description = "Teleport inside Liquor Store 5." BREAK
                        CASE 10 g_selected_description = "Teleport inside Market 1." BREAK
                        CASE 11 g_selected_description = "Teleport inside Market 2." BREAK
                        CASE 12 g_selected_description = "Teleport inside Market 3." BREAK
                        CASE 13 g_selected_description = "Teleport inside Market 4." BREAK
                        CASE 14 g_selected_description = "Teleport inside Market 5." BREAK
                        CASE 15 g_selected_description = "Teleport inside Market 6." BREAK
                        CASE 16 g_selected_description = "Teleport inside Market 7." BREAK
                        CASE 17 g_selected_description = "Teleport inside Market 8." BREAK
                        CASE 18 g_selected_description = "Teleport inside Market 9." BREAK
                    ENDSWITCH
                ELIF g_tp_locs_open
                    SWITCH g_item
                    CASE 0 g_selected_description = "Teleport to the summit of Mount Chiliad." BREAK
                    CASE 1 g_selected_description = "Teleport to Maze Bank Tower." BREAK
                    CASE 2 g_selected_description = "Teleport to Los Santos International Airport." BREAK
                    CASE 3 g_selected_description = "Teleport to the Vinewood Sign." BREAK
                    CASE 4 g_selected_description = "Teleport to Fort Zancudo." BREAK
                    CASE 5 g_selected_description = "Teleport to Grove Street." BREAK
                    CASE 6 g_selected_description = "Teleport to Franklin's house." BREAK
                    CASE 7 g_selected_description = "Teleport to Michael's house." BREAK
                    CASE 8 g_selected_description = "Teleport to Trevor's trailer." BREAK
                    CASE 9 g_selected_description = "Teleport to Lester's warehouse." BREAK
                    CASE 10 g_selected_description = "Teleport to Simeon's dealership." BREAK
                    CASE 11 g_selected_description = "Teleport to the hospital." BREAK
                    CASE 12 g_selected_description = "Teleport to the police station." BREAK
                    CASE 13 g_selected_description = "Teleport to an Ammu-Nation store." BREAK
                    CASE 14 g_selected_description = "Teleport to Los Santos Customs." BREAK
                    CASE 15 g_selected_description = "Load the North Yankton area and teleport there." BREAK
                    CASE 16 g_selected_description = "Load the Cayo Perico area and teleport there." BREAK
                    CASE 17 g_selected_description = "Teleport to Sandy Shores Airfield." BREAK
                    CASE 18 g_selected_description = "Teleport to the IAA Building." BREAK
                    CASE 19 g_selected_description = "Teleport to Mount Gordo." BREAK
                    CASE 20 g_selected_description = "Teleport to Diamond Casino." BREAK
                    CASE 21 g_selected_description = "Teleport to Humane Labs." BREAK
                    CASE 22 g_selected_description = "Teleport to Bolingbroke Prison." BREAK
                    CASE 23 g_selected_description = "Teleport to Paleto Bay." BREAK
                    CASE 24 g_selected_description = "Teleport to Cayo Airstrip." BREAK
                    CASE 25 g_selected_description = "Teleport to Cayo Main Dock." BREAK
                    CASE 26 g_selected_description = "Teleport to Cayo North Dock." BREAK
                    CASE 27 g_selected_description = "Teleport to Cayo Mansion." BREAK
                    CASE 28 g_selected_description = "Teleport to Cayo Beach Party." BREAK
                    CASE 29 g_selected_description = "Teleport to Cayo Control Tower." BREAK
                    CASE 30 g_selected_description = "Teleport to Salvage Yard." BREAK
                    CASE 31 g_selected_description = "Teleport to Darnell Bros. Chop Shop." BREAK
                    CASE 32 g_selected_description = "Teleport to Gunrunning Bunker." BREAK
                    CASE 33 g_selected_description = "Teleport to Doomsday Facility." BREAK
                    CASE 34 g_selected_description = "Teleport to Dignity Party Yacht." BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                    CASE 0 g_selected_description = "Teleport to the active map waypoint." BREAK
                    CASE 1 g_selected_description = "Automatically teleport when a new waypoint is placed." BREAK
                    CASE 2 g_selected_description = "Open the robbable convenience store list." BREAK
                    CASE 3 g_selected_description = "Teleport to the nearest active objective marker." BREAK
                    CASE 4 g_selected_description = "Auto-teleport to the objective after cutscenes." BREAK
                    CASE 5 g_selected_description = "Open the fixed locations list." BREAK
                    CASE 6 g_selected_description = "Move one step forward from the current position. Moves the vehicle too when driving." BREAK
                    CASE 7 g_selected_description = "Move one step backward from the current position. Moves the vehicle too when driving." BREAK
                    CASE 8 g_selected_description = "Move one step up from the current position. Moves the vehicle too when driving." BREAK
                    CASE 9 g_selected_description = "Move one step down from the current position. Moves the vehicle too when driving." BREAK
                    CASE 10 g_selected_description = "Enter the X coordinate for a custom teleport." BREAK
                    CASE 11 g_selected_description = "Enter the Y coordinate for a custom teleport." BREAK
                    CASE 12 g_selected_description = "Enter the Z coordinate for a custom teleport." BREAK
                    CASE 13 g_selected_description = "Teleport the player or occupied vehicle to the entered coordinates." BREAK
                ENDSWITCH
                ENDIF
                BREAK
            CASE 6
                SWITCH g_item
                    CASE 0 g_selected_description = "Automatically skip story cutscenes while enabled." BREAK
                    CASE 1 g_selected_description = "Reload the current interior to fix invisible assets." BREAK
                    CASE 2 g_selected_description = "Make nearby non-player characters fight each other." BREAK
                    CASE 3 g_selected_description = "Make everyone ignore the player." BREAK
                    CASE 4 g_selected_description = "Reduce ambient pedestrian and vehicle population." BREAK
                    CASE 5 g_selected_description = "Left/Right sets NPC spawn density. 1x is default." BREAK
                    CASE 6 g_selected_description = "NPC traffic acceleration, same multipliers as player boost." BREAK
                    CASE 7 g_selected_description = "Remove nearby vehicles within the cleanup radius." BREAK
                    CASE 8 g_selected_description = "Remove nearby peds and menu-spawned attackers." BREAK
                    CASE 9 g_selected_description = "Explode every vehicle within 1500m. Skips yours." BREAK
                    CASE 10 g_selected_description = "Force the camera into first-person view." BREAK
                    CASE 11 g_selected_description = "Hide the normal HUD." BREAK
                    CASE 12 g_selected_description = "Hide the minimap and radar." BREAK
                ENDSWITCH
                BREAK
            CASE 7
                SWITCH g_item
                    CASE 0 g_selected_description = "Choose the menu accent color." BREAK
                    CASE 1
                        IF g_accent_choice = 14
                            g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes."
                        ELSE
                            g_selected_description = "Choose where custom death respawns place the player."
                        ENDIF
                    BREAK
                    CASE 2
                        IF g_accent_choice = 14
                            g_selected_description = "Choose where custom death respawns place the player."
                        ELSE
                            g_selected_description = "Enable automatic respawn at the selected location."
                        ENDIF
                    BREAK
                    CASE 3
                        IF g_accent_choice = 14
                            g_selected_description = "Enable automatic respawn at the selected location."
                        ELSE
                            g_selected_description = "Move the menu horizontally."
                        ENDIF
                    BREAK
                    CASE 4
                        IF g_accent_choice = 14
                            g_selected_description = "Move the menu horizontally."
                        ELSE
                            g_selected_description = "Move the menu vertically."
                        ENDIF
                    BREAK
                    CASE 5
                        IF g_accent_choice = 14
                            g_selected_description = "Move the menu vertically."
                        ELSE
                            g_selected_description = "Choose the button combo that opens the menu."
                        ENDIF
                    BREAK
                    CASE 6 g_selected_description = "Choose the button combo that opens the menu." BREAK
                ENDSWITCH
                BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_SELECTED_DESCRIPTION()
    SELECTED_DESCRIPTION_TEXT()
    MENU_DESCRIPTION_TEXT(g_selected_description)
ENDPROC

FUNC FLOAT SELECTED_DESCRIPTION_PANEL_HEIGHT()
    SELECTED_DESCRIPTION_TEXT()
    RETURN DESCRIPTION_PANEL_HEIGHT(g_selected_description)
ENDFUNC

PROC DRAW_DESCRIPTION_PANEL()

    FLOAT panelHeight = SELECTED_DESCRIPTION_PANEL_HEIGHT()
    DRAW_RECT(g_menu_x - 0.015, 0.578 + g_menu_y, MENU_W - 0.012, 0.002, 100, 108, 118, 220)
    DRAW_RECT(g_menu_x - 0.015, 0.593 + (panelHeight / 2.0) + g_menu_y, MENU_W - 0.012, panelHeight, 8, 9, 12, 205)
    DRAW_SELECTED_DESCRIPTION()
ENDPROC


FUNC FLOAT DESCRIPTION_PANEL_EXTRA_HEIGHT()
    FLOAT extraHeight = SELECTED_DESCRIPTION_PANEL_HEIGHT() - 0.054
    IF extraHeight < -0.020 extraHeight = -0.020 ENDIF
    RETURN extraHeight
ENDFUNC

PROC DRAW_MENU_BACKDROP()
    FLOAT extraHeight = DESCRIPTION_PANEL_EXTRA_HEIGHT()
    DRAW_RECT(g_menu_x - 0.015, 0.403 + (extraHeight / 2.0) + g_menu_y, MENU_W, 0.505 + extraHeight, 8, 9, 12, 220)
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
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
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
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
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
