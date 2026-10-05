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
    MENU_TEXT_RIGHT(g_menu_x + 0.105, 0.198, 0.270, 255, 255, 255, g_menu_version)
ENDPROC

PROC MENU_PLAY_SOUND(STRING soundName)
    g_prof_sound_t0 = GET_GAME_TIMER()
    PLAY_SOUND_FRONTEND(-1, soundName, "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
    g_prof_t1 = GET_GAME_TIMER() - g_prof_sound_t0
    g_prof_sound_count = g_prof_sound_count + 1
    IF g_prof_t1 > g_prof_worst_sound
        g_prof_worst_sound = g_prof_t1
    ENDIF
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
        IF g_guard_ped_open
            IF g_item = 0 g_selected_description = "Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!" ENDIF
            IF g_item = 1 g_selected_description = "Pick a random validated PED model for bodyguards." ENDIF
            IF g_item > 1 g_selected_description = "Use the selected PED model for spawned bodyguards." ENDIF
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = "Spawn one armed bodyguard next to the player." BREAK
                CASE 1 g_selected_description = "Open the bodyguard PED list; shows the current model." BREAK
                CASE 2 g_selected_description = "Choose the weapon given to spawned bodyguards." BREAK
                CASE 3 g_selected_description = "Choose how bodyguards position around the player." BREAK
                CASE 4 g_selected_description = "Make every bodyguard follow the player in formation." BREAK
                CASE 5 g_selected_description = "Show or hide bodyguard map blips for new guards." BREAK
                CASE 6 g_selected_description = "Make every spawned bodyguard invincible." BREAK
                CASE 7 g_selected_description = "Remove every spawned bodyguard." BREAK
            ENDSWITCH
        ENDIF
    ELIF g_attacker_open
        IF g_attacker_ped_open
            IF g_item = 0 g_selected_description = "Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!" ENDIF
            IF g_item = 1 g_selected_description = "Pick a random validated PED model for attackers." ENDIF
            IF g_item > 1 g_selected_description = "Use the selected PED model for spawned attackers." ENDIF
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = "Spawn an armed hostile attacker nearby." BREAK
                CASE 1 g_selected_description = "Open the attacker PED list; shows the current model." BREAK
                CASE 2 g_selected_description = "Choose the weapon given to spawned attackers." BREAK
                CASE 3 g_selected_description = "ON: attackers fight everyone nearby. OFF: they only attack the player." BREAK
                CASE 4 g_selected_description = "Make every spawned attacker invincible." BREAK
                CASE 5 g_selected_description = "Remove every spawned attacker." BREAK
            ENDSWITCH
        ENDIF
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
    ELIF g_lsc_open AND NOT g_hydro_open AND NOT g_interior_open AND NOT g_wheeltyre_open AND NOT g_lsc_extras_open AND NOT g_bennys_open AND NOT g_support_open
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
            CASE 19 g_selected_description = "Choose which of the car's mod kits the menu writes to. Lowrider interiors and hydraulics live in an add-on kit, not the stock one. Left/Right switches kit and re-reads every row." BREAK
            CASE 20 g_selected_description = "Type of the active mod kit, as the game reports it." BREAK
            CASE 21 g_selected_description = "How many mod kits this car carries. 'Stock Kit Only' means the lowrider slots do not exist on it." BREAK
            CASE 22 g_selected_description = "Open the hydraulics submenu: stance presets, per-axle heights, single-wheel control and Hold Stance." BREAK
            CASE 23 g_selected_description = "Open the lowrider interior submenu: interiors, seats, steering, dash, trunk and engine bay, with the game's own slot and variant names." BREAK
            CASE 24 g_selected_description = "Open the wheels and tyres submenu: wheel family, front/rear variation, tyre smoke and reduced suspension force." BREAK
            CASE 25 g_selected_description = "Open the extras and livery submenu: liveries by name, plus the car's 12 extras (roof racks, light bars and similar)." BREAK
            CASE 26 g_selected_description = "Spawn a car that can take a lowrider kit. These are Rockstar's own conversion targets, and the only cars hydraulics and the lowrider interiors work on. A row only offers a car this build really ships." BREAK
            CASE 27 g_selected_description = "Convert the car you are sitting in into its Benny's custom variant, keeping the paint and wheels. This is what makes hydraulics and the lowrider interiors usable: a stock car has no hydraulic data in any kit. Refused if this car has no verified variant." BREAK
            CASE 28 g_selected_description = "Why nothing here works: shows whether this car carries a lowrider kit, whether it can take hydraulics, how many lowrider slots it has, and whether this build ships its custom variant. Read-only." BREAK
        ENDSWITCH
    ELIF g_hydro_open
        SWITCH g_item
            CASE 0 g_selected_description = "Fit or remove the hydraulic kit itself, and allow the car to use it." BREAK
            CASE 1 g_selected_description = "Choose the hydraulic pump level. 'None on this car' means it has no hydraulic kit at all." BREAK
            CASE 2 g_selected_description = "Let the player raise and lower the car with the game's own hydraulics controls." BREAK
            CASE 3 g_selected_description = "Choose a stance: Stock, Slammed, Max High, Bouncy, Free, Front Up, Rear Up, Lean Left, Lean Right. Applies as you move it." BREAK
            CASE 4 g_selected_description = "Apply the chosen stance preset again." BREAK
            CASE 5 g_selected_description = "How high the front pair rides, 0-100%. Applies as you move it." BREAK
            CASE 6 g_selected_description = "How high the rear pair rides, 0-100%. Applies as you move it." BREAK
            CASE 7 g_selected_description = "How high the mid-left wheel rides. Only six-wheel cars have a mid pair." BREAK
            CASE 8 g_selected_description = "How high the mid-right wheel rides. Only six-wheel cars have a mid pair." BREAK
            CASE 9 g_selected_description = "Apply all four height sliders to the car at once." BREAK
            CASE 10 g_selected_description = "Pick which single wheel the next four rows control." BREAK
            CASE 11 g_selected_description = "How high the selected wheel rides, 0-100%. Applies as you move it." BREAK
            CASE 12 g_selected_description = "Whether the selected wheel is Free, Locked or set to Bounce." BREAK
            CASE 13 g_selected_description = "How fast the selected wheel travels, 0.1x to 2.0x." BREAK
            CASE 14 g_selected_description = "Send the selected wheel's height, state and speed to the car." BREAK
            CASE 15 g_selected_description = "Keep re-applying the chosen stance so the car cannot settle out of it. Turns itself off when you leave the car." BREAK
            CASE 16 g_selected_description = "Soften the suspension so the car can sit lower - the game's own stance flag." BREAK
            CASE 17 g_selected_description = "Put every hydraulic value back to stock and stop the car using hydraulics." BREAK
            CASE 18 g_selected_description = "Whether this car can take hydraulics at all. A plain car has no hydraulic data in any mod kit, so every row above it is a no-op until it is converted at Benny's - see Convert To Custom on the LS Customs page." BREAK
        ENDSWITCH
    ELIF g_interior_open
        SWITCH g_item
            CASE 0 g_selected_description = "Apply the fill variant to every lowrider slot this car has. Slots it does not have are skipped." BREAK
            CASE 1 g_selected_description = "Which variant index the fill row writes." BREAK
            CASE 2 g_selected_description = "Choose the lowrider slot to edit." BREAK
            CASE 3 g_selected_description = "Choose the variant for this slot. 'None on this kit' means the active kit has none." BREAK
            CASE 4 g_selected_description = "How many variants the active kit offers for this slot. Zero was why these slots did nothing before v0.9.9." BREAK
            CASE 5 g_selected_description = "The game's own name for this slot." BREAK
            CASE 6 g_selected_description = "The game's own name for the selected variant." BREAK
            CASE 7 g_selected_description = "Interior trim colour, from the carcols palette." BREAK
            CASE 8 g_selected_description = "Interior metal colour, from the carcols palette." BREAK
            CASE 9 g_selected_description = "Whether the game has streamed in this car's modification parts yet. 'Not yet' means a slot can read as empty or take a write that does nothing." BREAK
            CASE 10 g_selected_description = "Remove every lowrider modification on this car." BREAK
        ENDSWITCH
    ELIF g_wheeltyre_open
        SWITCH g_item
            CASE 0 g_selected_description = "Choose the wheel family: Sport through Supermod 5." BREAK
            CASE 1 g_selected_description = "Variant A or B of the wheel design. Applied by the row below." BREAK
            CASE 2 g_selected_description = "Target the front/all wheels or the bike rear wheel." BREAK
            CASE 3 g_selected_description = "Apply the chosen wheel family." BREAK
            CASE 4 g_selected_description = "Apply the chosen variation to the current wheel design." BREAK
            CASE 5 g_selected_description = "Which variation the car's wheel slot currently has fitted." BREAK
            CASE 6 g_selected_description = "Whether the car has the tyre smoke modification fitted." BREAK
            CASE 7 g_selected_description = "Fit or remove the tyre smoke modification." BREAK
            CASE 8 g_selected_description = "ON lets tyres burst normally; OFF makes them unburstable." BREAK
            CASE 9 g_selected_description = "Soften the suspension so the car can sit lower - the game's own stance flag." BREAK
        ENDSWITCH
    ELIF g_lsc_extras_open
        SWITCH g_item
            CASE 0 g_selected_description = "Choose a livery. '< Stock >' removes it. Applies as you move it." BREAK
            CASE 1 g_selected_description = "How many liveries this car offers." BREAK
            CASE 2 g_selected_description = "The game's own name for the selected livery." BREAK
            CASE 3 g_selected_description = "Apply the chosen livery again." BREAK
            CASE 4 g_selected_description = "Choose one of the car's 12 extras, such as roof racks, light bars and spoiler variants." BREAK
            CASE 5 g_selected_description = "Whether this car actually carries the selected extra." BREAK
            CASE 6 g_selected_description = "Whether the selected extra is currently on or off." BREAK
            CASE 7 g_selected_description = "Turn the selected extra on or off." BREAK
            CASE 8 g_selected_description = "Fit every extra this car carries." BREAK
            CASE 9 g_selected_description = "Remove every extra this car carries." BREAK
        ENDSWITCH
    ELIF g_bennys_open
        g_selected_description = "Spawn this car. These Benny's variants are the only cars hydraulics and the lowrider interiors work on. Each row is checked against this build, so a car it does not ship is marked Absent and cannot be spawned."
    ELIF g_support_open
        g_selected_description = "Live readback for the car you are in: whether it carries a lowrider mod kit, whether it can take hydraulics, how many of the 22 lowrider slots exist on it, and whether this build ships its Benny's variant. Nothing on this page changes the car."
    ELIF g_chauffeur_open
        IF g_chauffeur_armed_open
            IF g_item = 0 g_selected_description = "Arm the driver. He will shoot at hostile peds near the car." ENDIF
            IF g_item > 0 g_selected_description = "Give the driver this weapon. One-handed guns fire properly from the driver's seat." ENDIF
        ELIF g_chauffeur_vehicle_open
            g_selected_description = "Choose the chauffeur's car. Every one is spawned black. Takes effect on the next spawn."
        ELIF g_chauffeur_ped_open
            IF g_item = 0 g_selected_description = "Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!" ENDIF
            IF g_item = 1 g_selected_description = "Pick a random validated PED model for the chauffeur." ENDIF
            IF g_item > 1 g_selected_description = "Use the selected PED model for the chauffeur." ENDIF
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = "Spawn the chauffeur car and sit the player in the passenger seat. Press again to replace it." BREAK
                CASE 1 g_selected_description = "Open the chauffeur PED list; shows the current driver model." BREAK
                CASE 2 g_selected_description = "Open the chauffeur vehicle list; shows the current car." BREAK
                CASE 3 g_selected_description = "Normal obeys traffic; Rushed uses the game's hurried taxi driving mode." BREAK
                CASE 4 g_selected_description = "Let the chauffeur drive through red lights. Only affects Normal, which is the mode that stops at them." BREAK
                CASE 5 g_selected_description = "Make the chauffeur invincible. The car is not affected." BREAK
                CASE 6 g_selected_description = "Stop the chauffeur car's tyres from bursting." BREAK
                CASE 7 g_selected_description = "Arm the chauffeur and choose his weapon; opens the armed driver page." BREAK
                CASE 8 g_selected_description = "The chauffeur gets out when the player does, and gets back in when the player returns." BREAK
            ENDSWITCH
        ENDIF
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
                    CASE 6 g_selected_description = "Open the bodyguard management submenu." BREAK
                    CASE 7 g_selected_description = "Open the attacker management submenu." BREAK
                    CASE 8 g_selected_description = "Stick moves, Y up, B down. No entry while on." BREAK
                    CASE 9 g_selected_description = "Invisible first-person fly. Y up, B down" BREAK
                    CASE 10 g_selected_description = "Keep the player's underwater air supply full." BREAK
                    CASE 11 g_selected_description = "Keep the character's special ability charged." BREAK
                    CASE 12 g_selected_description = "Increase running speed." BREAK
                    CASE 13 g_selected_description = "Increase swimming speed." BREAK
                    CASE 14 g_selected_description = "Allow the player to jump higher." BREAK
                    CASE 15 g_selected_description = "Prevent the player from ragdolling." BREAK
                    CASE 16 g_selected_description = "Keep a parachute available whenever needed." BREAK
                    CASE 17 g_selected_description = "DPAD Left/Right adjusts by $10,000. A opens keyboard entry." BREAK
                    CASE 18 g_selected_description = "Apply the selected cash amount to the active character." BREAK
                    CASE 19 g_selected_description = "Make melee impacts explosive." BREAK
                    CASE 20 g_selected_description = "Launch peds, vehicles and loose props with melee hits." BREAK
                    CASE 21 g_selected_description = "Apply the drunk movement style." BREAK
                    CASE 22 g_selected_description = "Remove blood, wetness, dirt, and visible damage from the player." BREAK
                    CASE 23 g_selected_description = "Set the player's health to zero." BREAK
                    CASE 24 g_selected_description = "Silently autosave on a timer while you play. Respects the game's own autosave setting and never fires mid-mission or in a cutscene." BREAK
                    CASE 25 g_selected_description = "Minutes between autosaves. Left/Right changes it by 1; A opens the keyboard. 0 stops the periodic save." BREAK
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
                IF g_vehicle_control_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Roll every window down, or raise the rollable windows back up." BREAK
                        CASE 1 g_selected_description = "Choose which window the roll commands below act on." BREAK
                        CASE 2 g_selected_description = "Roll the selected window down." BREAK
                        CASE 3 g_selected_description = "Roll the selected window back up." BREAK
                        CASE 4 g_selected_description = "Turn the occupied vehicle's engine on or off." BREAK
                        CASE 5 g_selected_description = "Toggle the hazard lights on both sides of the vehicle." BREAK
                        CASE 6 g_selected_description = "Move the player into the chosen seat." BREAK
                        CASE 7 g_selected_description = "Set how dirty the vehicle is, from clean to filthy." BREAK
                        CASE 8 g_selected_description = "Wash the occupied vehicle back to a clean finish." BREAK
                    ENDSWITCH
                ELSE
                SWITCH g_item
                    CASE 0 g_selected_description = "Open the vehicle spawner and choose a vehicle to create." BREAK
                    CASE 1 g_selected_description = "Open the LS Customs modification and paint editor." BREAK
                    CASE 2 g_selected_description = "Open the neon animation submenu. Requires a vehicle." BREAK
                    CASE 3 g_selected_description = "Open the vehicle control submenu. Requires a vehicle." BREAK
                    CASE 4 g_selected_description = "Make the occupied vehicle immune to damage." BREAK
                    CASE 5 g_selected_description = "Repair damage to the occupied vehicle immediately." BREAK
                    CASE 6 g_selected_description = "Apply the highest available upgrade to the occupied vehicle." BREAK
                    CASE 7 g_selected_description = "Automatically max upgrades on every vehicle entered." BREAK
                    CASE 8 g_selected_description = "Increase vehicle acceleration from stock through 200x." BREAK
                    CASE 9 g_selected_description = "Adjust tyre grip from reduced grip through high grip." BREAK
                    CASE 10 g_selected_description = "Keep the tow hook attached no matter the impacts." BREAK
                    CASE 11 g_selected_description = "Toggle the vehicle's turbo modification." BREAK
                    CASE 12 g_selected_description = "Prevent tyres from bursting." BREAK
                    CASE 13 g_selected_description = "Set the occupied vehicle upright on the ground." BREAK
                    CASE 14 g_selected_description = "Skip entry and exit animations when entering or leaving vehicles." BREAK
                    CASE 15 g_selected_description = "Enter the personal vehicle marked by the game." BREAK
                    CASE 16 g_selected_description = "Bring the player's story-mode personal vehicle to the current location and enter it." BREAK
                    CASE 17 g_selected_description = "Hold the horn to apply a forward boost." BREAK
                    CASE 18 g_selected_description = "Repair the occupied vehicle continuously." BREAK
                    CASE 19 g_selected_description = "Open the rear cargo/ramp doors on the occupied plane." BREAK
                    CASE 20 g_selected_description = "Lock or unlock the occupied vehicle's doors." BREAK
                    CASE 21 g_selected_description = "Prevent ejection from crashes; X is still used to exit." BREAK
                    CASE 22 g_selected_description = "Destroy the occupied vehicle's engine." BREAK
                    CASE 23 g_selected_description = "Show the occupied vehicle's current speed." BREAK
                    CASE 24 g_selected_description = "Choose MPH or KMPH for the speedometer." BREAK
                    CASE 25 g_selected_description = "Hire a driver: spawns a black car with a chauffeur and drives you to your waypoint." BREAK
                ENDSWITCH
                ENDIF
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
                    CASE 4 g_selected_description = "Slow down or speed up the whole simulation. 1x default." BREAK
                    CASE 5 g_selected_description = "Set global gravity. Earth default." BREAK
                    CASE 6 g_selected_description = "Request the selected IPL preset." BREAK
                    CASE 7 g_selected_description = "Remove the selected IPL preset." BREAK
                    CASE 8 g_selected_description = "Enter an IPL name with the Switch keyboard." BREAK
                    CASE 9 g_selected_description = "Request the custom IPL name." BREAK
                    CASE 10 g_selected_description = "Remove the custom IPL name." BREAK
                    CASE 11 g_selected_description = "Apply or clear the CCTV scanline filter." BREAK
                    CASE 12 g_selected_description = "Start or stop the gameplay camera shake effect." BREAK
                    CASE 13 g_selected_description = "Unlock and open the closest door, gate or garage in range." BREAK
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
                    CASE 6 g_selected_description = "Remove nearby vehicles within the cleanup radius." BREAK
                    CASE 7 g_selected_description = "Remove nearby peds and menu-spawned attackers." BREAK
                    CASE 8 g_selected_description = "Explode every vehicle within 1500m. Skips yours." BREAK
                    CASE 9 g_selected_description = "Force the camera into first-person view." BREAK
                    CASE 10 g_selected_description = "Hide the normal HUD." BREAK
                    CASE 11 g_selected_description = "Hide the minimap and radar." BREAK
                    CASE 12 g_selected_description = "Left/Right picks one of four stripper models, A spawns her 3m in front. Keeps at most 8, replacing the oldest. Clear Nearby Peds removes them." BREAK
                ENDSWITCH
                BREAK
            CASE 7
                IF g_spooner_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Left/Right cycles curated world props. Press A to spawn the selected prop at the player offset." BREAK
                        CASE 1 g_selected_description = "Enter any prop model name or hash via the keyboard and spawn it into the world." BREAK
                        CASE 2 g_selected_description = "Request the selected catalog prop into memory and instantiate it at the current offset." BREAK
                        CASE 3 g_selected_description = "Cycle through actively spawned Spooner objects. Press A to snap the selected object to your current offset." BREAK
                        CASE 4 g_selected_description = "Adjust forward/backward placement relative to the player matrix (-50m to +50m). Press A to reset to 2.50m." BREAK
                        CASE 5 g_selected_description = "Adjust left/right placement relative to the player matrix (-50m to +50m). Press A to reset to 0.00m." BREAK
                        CASE 6 g_selected_description = "Adjust vertical height relative to the player matrix (-50m to +50m). Press A to reset to 0.00m." BREAK
                        CASE 7 g_selected_description = "Adjust heading rotation relative to the player's facing angle (0 to 355 deg). Press A to reset to 0 deg." BREAK
                        CASE 8 g_selected_description = "Anchor the selected object in mid-air so it defies gravity and world physics." BREAK
                        CASE 9 g_selected_description = "Toggle physical model collision boundaries on or off for the selected object." BREAK
                        CASE 10 g_selected_description = "Decouple the game camera into free-roaming flight mode for easier construction viewing." BREAK
                        CASE 11 g_selected_description = "Query terrain collision height and snap the selected object cleanly onto the ground surface." BREAK
                        CASE 12 g_selected_description = "Select the target player skeleton bone (or player vehicle) for entity attachment." BREAK
                        CASE 13 g_selected_description = "Adjust relative X attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m." BREAK
                        CASE 14 g_selected_description = "Adjust relative Y attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m." BREAK
                        CASE 15 g_selected_description = "Adjust relative Z attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m." BREAK
                        CASE 16 g_selected_description = "Left/Right adjusts the active rotation offset (-180 to 180 deg). Press A to cycle Pitch, Roll, and Yaw." BREAK
                        CASE 17 g_selected_description = "Pin the selected object to the chosen player skeleton bone using the relative offsets, or detach it." BREAK
                        CASE 18 g_selected_description = "Safely remove the most recently spawned object from the world pool and free its tracking slot." BREAK
                        CASE 19 g_selected_description = "Delete all spawned Spooner objects from the active world pool to prevent Switch memory leaks." BREAK
                    ENDSWITCH
                ELIF g_nsc_loader_open
                    IF g_item = 0
                        g_selected_description = "Scan script_rel.rpf for custom .nsc scripts while ignoring the 1,026 stock scripts and ragemenu.nsc."
                    ELIF g_item = 1
                        g_selected_description = "Type a custom .nsc filename to probe in script_rel.rpf and add it to the dynamic loader list."
                    ELIF g_item = 2
                        g_selected_description = "Select the RAGE VM stack size allocated when launching or reloading a custom .nsc script."
                    ELIF g_item = 3
                        g_selected_description = "Terminate all running custom .nsc script threads and release their bytecode handles."
                    ELSE
                        IF g_nsc_discovered_count <= 0
                            g_selected_description = "No custom .nsc files detected yet. Drop a custom .nsc into script_rel.rpf and press Rescan or Probe."
                        ELSE
                            g_selected_description = "Press A to inject this custom .nsc script, or press A while ACTIVE to terminate, unload, and hot-reload it."
                        ENDIF
                    ENDIF
                ELIF g_persist_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "Restore menu settings automatically on the next launch." BREAK
                        CASE 1 g_selected_description = "Write the current settings into the game save now." BREAK
                        CASE 2 g_selected_description = "Erase the stored settings so the next launch uses the menu defaults." BREAK
                        CASE 3 g_selected_description = "Write and read back test values in the storage containers, then report the result. Safe: it never touches your settings." BREAK
                        CASE 4 g_selected_description = "Result of the last storage self-test." BREAK
                        CASE 5 g_selected_description = "Also ask the game to save once a change is stored, so the settings reach the save file." BREAK
                        CASE 6 g_selected_description = "What the last launch found in storage." BREAK
                        CASE 7 g_selected_description = "Whether the stored data still matches its checksum." BREAK
                        CASE 8 g_selected_description = "Storage containers this build does not expose. Should be 0." BREAK
                        CASE 9 g_selected_description = "Writes the engine accepted during the last flush. A small number is normal: only settings that actually changed are written." BREAK
                        CASE 10 g_selected_description = "Writes the engine rejected during the last flush. Should be 0." BREAK
                        CASE 11 g_selected_description = "Boot load attempts used before giving up." BREAK
                        CASE 12 g_selected_description = "Storage checks that passed during the last self-test. A full pass is 39." BREAK
                        CASE 13 g_selected_description = "Storage checks that failed during the last self-test. Should be 0." BREAK
                        CASE 14 g_selected_description = "Longest gap between two menu frames, in ms. This is the pause the player actually feels." BREAK
                        CASE 15 g_selected_description = "Longest time this script spent inside one frame, in ms. Compare with Worst Frame MS." BREAK
                        CASE 16 g_selected_description = "Longest time spent in the persistence step of the frame loop, in ms." BREAK
                        CASE 17 g_selected_description = "Longest single settings write burst, in ms. Reset, change one setting, read this." BREAK
                        CASE 18 g_selected_description = "Longest menu sound call, in ms." BREAK
                        CASE 19 g_selected_description = "Longest single A-press apply, in ms." BREAK
                        CASE 20 g_selected_description = "Longest menu draw pass, in ms." BREAK
                        CASE 21 g_selected_description = "Tab x100 + row of the slowest apply above, so the row itself can be identified." BREAK
                        CASE 22 g_selected_description = "Settings write bursts since the last reset, including the empty ones." BREAK
                        CASE 23 g_selected_description = "Menu sounds played since the last reset." BREAK
                        CASE 24 g_selected_description = "Clear every probe reading so the next single action can be measured on its own." BREAK
                    ENDSWITCH
                ELSE
                SWITCH g_item
                    CASE 0 g_selected_description = "Spawn, position, freeze, attach, and manage live-session world objects." BREAK
                    CASE 1 g_selected_description = "Dynamically scan, inject, and hot-reload custom Switch .nsc scripts." BREAK
                    CASE 2 g_selected_description = "Choose the menu accent color." BREAK
                    CASE 3
                        IF g_accent_choice = 14
                            g_selected_description = "Speed 0.25x to 10.00x. Stopped freezes."
                        ELSE
                            g_selected_description = "Choose where custom death respawns place the player."
                        ENDIF
                    BREAK
                    CASE 4
                        IF g_accent_choice = 14
                            g_selected_description = "Choose where custom death respawns place the player."
                        ELSE
                            g_selected_description = "Enable automatic respawn at the selected location."
                        ENDIF
                    BREAK
                    CASE 5
                        IF g_accent_choice = 14
                            g_selected_description = "Enable automatic respawn at the selected location."
                        ELSE
                            g_selected_description = "Move the menu horizontally."
                        ENDIF
                    BREAK
                    CASE 6
                        IF g_accent_choice = 14
                            g_selected_description = "Move the menu horizontally."
                        ELSE
                            g_selected_description = "Move the menu vertically."
                        ENDIF
                    BREAK
                    CASE 7
                        IF g_accent_choice = 14
                            g_selected_description = "Move the menu vertically."
                        ELSE
                            g_selected_description = "Choose the button combo that opens the menu."
                        ENDIF
                    BREAK
                    CASE 8
                        IF g_accent_choice = 14
                            g_selected_description = "Choose the button combo that opens the menu."
                        ELSE
                            g_selected_description = "Remember menu settings across launches, and check the storage that holds them."
                        ENDIF
                    BREAK
                    CASE 9 g_selected_description = "Remember menu settings across launches, and check the storage that holds them." BREAK
                ENDSWITCH
                ENDIF
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

PROC DRAW_AUTO_SAVE_TIMER()
    INT remainingMs = 0
    INT totalSeconds = 0
    INT hours = 0
    INT minutes = 0
    INT seconds = 0
    TEXT_LABEL_63 timerText = ""
    IF NOT g_auto_save EXIT ENDIF
    IF g_auto_save_interval <= 0 EXIT ENDIF
    IF IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() EXIT ENDIF
    IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN() EXIT ENDIF
    remainingMs = g_next_auto_save_time - GET_GAME_TIMER()
    IF remainingMs < 0 remainingMs = 0 ENDIF
    totalSeconds = remainingMs / 1000
    hours = totalSeconds / 3600
    minutes = (totalSeconds / 60) - (hours * 60)
    seconds = totalSeconds - (hours * 3600) - (minutes * 60)
    IF hours < 10 timerText += "0" ENDIF
    timerText += hours
    timerText += ":"
    IF minutes < 10 timerText += "0" ENDIF
    timerText += minutes
    timerText += ":"
    IF seconds < 10 timerText += "0" ENDIF
    timerText += seconds
    SET_TEXT_RENDER_ID(1)
    SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(TRUE)
    SET_SCRIPT_GFX_DRAW_ORDER(GFX_ORDER_BEFORE_HUD_PRIORITY_LOW)
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(255, 255, 255, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("Auto Saving in:")
    END_TEXT_COMMAND_DISPLAY_TEXT(AUTO_SAVE_TIMER_X, AUTO_SAVE_TIMER_Y)
    SET_TEXT_SCALE(0.400, 0.400)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(timerText)
    END_TEXT_COMMAND_DISPLAY_TEXT(AUTO_SAVE_TIMER_X, AUTO_SAVE_TIMER_Y + 0.024)
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
    VEHICLE_INDEX speedVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    STRING speedVehicleName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(GET_ENTITY_MODEL(speedVehicle))
    SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
    SET_TEXT_SCALE(0.55, 0.55)
    SET_TEXT_OUTLINE()
    SET_TEXT_WRAP(0.0, 0.905)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(speedVehicleName)
        END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.686)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
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
