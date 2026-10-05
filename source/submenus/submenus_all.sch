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
        CASE 22 DRAW_OPTION(y, "IPL Preset:", "< Cayo Perico Damaged >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, "IPL Preset:", "< Casino Door >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, "IPL Preset:", "< Gunrunning Bunker >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIME_SCALE_SELECTOR(FLOAT y, BOOL selected)
    IF g_time_scale_level = 0 DRAW_OPTION(y, "Time Scale:", "< 0x >", selected, 0) ENDIF
    IF g_time_scale_level = 1 DRAW_OPTION(y, "Time Scale:", "< 0.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 2 DRAW_OPTION(y, "Time Scale:", "< 0.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 3 DRAW_OPTION(y, "Time Scale:", "< 0.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 4 DRAW_OPTION(y, "Time Scale:", "< 1x >", selected, 3) ENDIF
    IF g_time_scale_level = 5 DRAW_OPTION(y, "Time Scale:", "< 1.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 6 DRAW_OPTION(y, "Time Scale:", "< 1.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 7 DRAW_OPTION(y, "Time Scale:", "< 1.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 8 DRAW_OPTION(y, "Time Scale:", "< 2x >", selected, 3) ENDIF
    IF g_time_scale_level = 9 DRAW_OPTION(y, "Time Scale:", "< 2.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 10 DRAW_OPTION(y, "Time Scale:", "< 2.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 11 DRAW_OPTION(y, "Time Scale:", "< 2.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 12 DRAW_OPTION(y, "Time Scale:", "< 3x >", selected, 3) ENDIF
    IF g_time_scale_level = 13 DRAW_OPTION(y, "Time Scale:", "< 3.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 14 DRAW_OPTION(y, "Time Scale:", "< 3.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 15 DRAW_OPTION(y, "Time Scale:", "< 3.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 16 DRAW_OPTION(y, "Time Scale:", "< 4x >", selected, 3) ENDIF
    IF g_time_scale_level = 17 DRAW_OPTION(y, "Time Scale:", "< 4.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 18 DRAW_OPTION(y, "Time Scale:", "< 4.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 19 DRAW_OPTION(y, "Time Scale:", "< 4.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 20 DRAW_OPTION(y, "Time Scale:", "< 5x >", selected, 3) ENDIF
    IF g_time_scale_level = 21 DRAW_OPTION(y, "Time Scale:", "< 5.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 22 DRAW_OPTION(y, "Time Scale:", "< 5.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 23 DRAW_OPTION(y, "Time Scale:", "< 5.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 24 DRAW_OPTION(y, "Time Scale:", "< 6x >", selected, 3) ENDIF
    IF g_time_scale_level = 25 DRAW_OPTION(y, "Time Scale:", "< 6.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 26 DRAW_OPTION(y, "Time Scale:", "< 6.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 27 DRAW_OPTION(y, "Time Scale:", "< 6.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 28 DRAW_OPTION(y, "Time Scale:", "< 7x >", selected, 3) ENDIF
    IF g_time_scale_level = 29 DRAW_OPTION(y, "Time Scale:", "< 7.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 30 DRAW_OPTION(y, "Time Scale:", "< 7.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 31 DRAW_OPTION(y, "Time Scale:", "< 7.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 32 DRAW_OPTION(y, "Time Scale:", "< 8x >", selected, 3) ENDIF
    IF g_time_scale_level = 33 DRAW_OPTION(y, "Time Scale:", "< 8.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 34 DRAW_OPTION(y, "Time Scale:", "< 8.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 35 DRAW_OPTION(y, "Time Scale:", "< 8.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 36 DRAW_OPTION(y, "Time Scale:", "< 9x >", selected, 3) ENDIF
    IF g_time_scale_level = 37 DRAW_OPTION(y, "Time Scale:", "< 9.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 38 DRAW_OPTION(y, "Time Scale:", "< 9.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 39 DRAW_OPTION(y, "Time Scale:", "< 9.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 40 DRAW_OPTION(y, "Time Scale:", "< 10x >", selected, 3) ENDIF
ENDPROC

PROC DRAW_GRAVITY_SELECTOR(FLOAT y, BOOL selected)
    IF g_gravity_choice = 0 DRAW_OPTION(y, "Gravity:", "< Earth >", selected, 3) ENDIF
    IF g_gravity_choice = 1 DRAW_OPTION(y, "Gravity:", "< Moon >", selected, 3) ENDIF
    IF g_gravity_choice = 2 DRAW_OPTION(y, "Gravity:", "< Low >", selected, 3) ENDIF
    IF g_gravity_choice = 3 DRAW_OPTION(y, "Gravity:", "< Zero G >", selected, 3) ENDIF
ENDPROC

PROC DRAW_WORLD_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Time & Weather", "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_night_vision DRAW_OPTION(y, "Night Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Night Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 IF g_thermal_vision DRAW_OPTION(y, "Thermal Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Thermal Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_IPL_SELECTOR(y, g_item = index) BREAK
        CASE 4 DRAW_TIME_SCALE_SELECTOR(y, g_item = index) BREAK
        CASE 5 DRAW_GRAVITY_SELECTOR(y, g_item = index) BREAK
        CASE 6 DRAW_OPTION(y, "Load IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Unload IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 8
            IF IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name) DRAW_OPTION(y, "Custom IPL Name", "TYPE NAME", g_item = index, 3)
            ELSE DRAW_OPTION(y, "Custom IPL Name", g_custom_ipl_name, g_item = index, 3) ENDIF
        BREAK
        CASE 9 DRAW_OPTION(y, "Load Custom IPL", "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, "Unload Custom IPL", "APPLY", g_item = index, 2) BREAK
        CASE 11 IF g_motion_blur DRAW_OPTION(y, "CCTV Filter", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "CCTV Filter", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_camera_shake DRAW_OPTION(y, "Camera Shake", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Camera Shake", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13
            IF g_door_scan_active
                DRAW_OPTION(y, "Open Closest Door", "Searching...", g_item = index, 2)
            ELIF g_door_feedback_until > GET_GAME_TIMER()
                IF g_door_feedback = 2 DRAW_OPTION(y, "Open Closest Door", "Opened!", g_item = index, 1)
                ELIF g_door_feedback = 3 DRAW_OPTION(y, "Open Closest Door", "Won't Open", g_item = index, 0)
                ELSE DRAW_OPTION(y, "Open Closest Door", "No Doors", g_item = index, 0) ENDIF
            ELSE
                DRAW_OPTION(y, "Open Closest Door", "< Apply >", g_item = index, 2)
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIMEWEATHER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_TIME_SELECTOR(y, g_item = index) BREAK
        CASE 1 DRAW_NUMBER_OPTION(y, "Hour", g_time_hour, g_item = index) BREAK
        CASE 2 DRAW_NUMBER_OPTION(y, "Minute", g_time_minute, g_item = index) BREAK
        CASE 3 DRAW_NUMBER_OPTION(y, "Second", g_time_second, g_item = index) BREAK
        CASE 4 IF g_pause_time DRAW_OPTION(y, "Freeze / Pause Time", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Freeze / Pause Time", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_WEATHER_SELECTOR(y, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIMEWEATHER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "TIME & WEATHER")
    DRAW_MENU_VERSION_TAG()
    INT index = g_timeweather_scroll
    INT row = 0
    WHILE row < 8 AND index < 6
        DRAW_TIMEWEATHER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
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
        CASE 0 DRAW_OPTION(y, "Accent Colour:", "< Blue >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Accent Colour:", "< Crimson >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Accent Colour:", "< Gold >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Accent Colour:", "< Purple >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Accent Colour:", "< Emerald >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Accent Colour:", "< Cyan >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Accent Colour:", "< Orange >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Accent Colour:", "< Pink >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Accent Colour:", "< Slate >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Accent Colour:", "< Lime >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Accent Colour:", "< White >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Accent Colour:", "< Burnt Orange >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Accent Colour:", "< Charcoal >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Accent Colour:", "< Sky Blue >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Accent Colour:", "< RGB >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_MENU_X_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Menu Adjustment:", "< X >", selected, 3)
ENDPROC

PROC DRAW_MENU_Y_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Menu Adjustment:", "< Y >", selected, 3)
ENDPROC

PROC DRAW_RESPAWN_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_respawn_location_choice
        CASE 0 DRAW_OPTION(y, "Respawn Location:", "< Last death >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Respawn Location:", "< Franklin's House >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Respawn Location:", "< Michael's House >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Respawn Location:", "< Trevor's Trailer >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Respawn Location:", "< Hospital >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Respawn Location:", "< Simeon's Dealership >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Respawn Location:", "< Ammu-Nation >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Respawn Location:", "< Police station >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Respawn Location:", "< Los Santos Customs >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Respawn Location:", "< LS Airport >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, "Respawn Location:", "< Maze Bank Tower >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Respawn Location:", "< Grove Street >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Respawn Location:", "< North Yankton >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Respawn Location:", "< Cayo Perico >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Respawn Location:", "< Fort Zancudo >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, "Respawn Location:", "< Vinewood Sign >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, "Respawn Location:", "< Mount Chiliad >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, "Respawn Location:", "< Sandy Shores Airfield >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, "Respawn Location:", "< IAA Building >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, "Respawn Location:", "< Mount Gordo >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, "Respawn Location:", "< Del Perro Pier >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, "Respawn Location:", "< Paleto Bay >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, "Respawn Location:", "< Humane Labs >", selected, 3) BREAK
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
    IF g_vehicle_spawn_category = 8 DRAW_OPTION(y, "Vehicle Type:", "< Miscellaneous >", selected, 3) ENDIF
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
    SYNC_VEHICLE_PREVIEW_MODEL()
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
        CASE 89 DRAW_OPTION(y, "Vehicle:", "< Avarus >", selected, 3) BREAK
        CASE 90 DRAW_OPTION(y, "Vehicle:", "< Banshee >", selected, 3) BREAK
        CASE 91 DRAW_OPTION(y, "Vehicle:", "< Bullet >", selected, 3) BREAK
        CASE 92 DRAW_OPTION(y, "Vehicle:", "< Coquette >", selected, 3) BREAK
        CASE 93 DRAW_OPTION(y, "Vehicle:", "< Phoenix >", selected, 3) BREAK
        CASE 94 DRAW_OPTION(y, "Vehicle:", "< Surano >", selected, 3) BREAK
        CASE 95 DRAW_OPTION(y, "Vehicle:", "< Vacca >", selected, 3) BREAK
        CASE 96 DRAW_OPTION(y, "Vehicle:", "< Stinger >", selected, 3) BREAK
        CASE 97 DRAW_OPTION(y, "Vehicle:", "< Exemplar >", selected, 3) BREAK
        CASE 98 DRAW_OPTION(y, "Vehicle:", "< Jackal >", selected, 3) BREAK
        CASE 99 DRAW_OPTION(y, "Vehicle:", "< Oracle >", selected, 3) BREAK
        CASE 100 DRAW_OPTION(y, "Vehicle:", "< Felon >", selected, 3) BREAK
        CASE 101 DRAW_OPTION(y, "Vehicle:", "< Schafter 2 >", selected, 3) BREAK
        CASE 102 DRAW_OPTION(y, "Vehicle:", "< Tailgater >", selected, 3) BREAK
        CASE 103 DRAW_OPTION(y, "Vehicle:", "< Washington >", selected, 3) BREAK
        CASE 104 DRAW_OPTION(y, "Vehicle:", "< Cognoscenti >", selected, 3) BREAK
        CASE 105 DRAW_OPTION(y, "Vehicle:", "< Baller 2 >", selected, 3) BREAK
        CASE 106 DRAW_OPTION(y, "Vehicle:", "< Cavalcade >", selected, 3) BREAK
        CASE 107 DRAW_OPTION(y, "Vehicle:", "< Dubsta >", selected, 3) BREAK
        CASE 108 DRAW_OPTION(y, "Vehicle:", "< FQ 2 >", selected, 3) BREAK
        CASE 109 DRAW_OPTION(y, "Vehicle:", "< Patriot >", selected, 3) BREAK
        CASE 110 DRAW_OPTION(y, "Vehicle:", "< Huntley S >", selected, 3) BREAK
        CASE 111 DRAW_OPTION(y, "Vehicle:", "< Rocoto >", selected, 3) BREAK
        CASE 112 DRAW_OPTION(y, "Vehicle:", "< Seminole >", selected, 3) BREAK
        CASE 113 DRAW_OPTION(y, "Vehicle:", "< Landstalker >", selected, 3) BREAK
        CASE 114 DRAW_OPTION(y, "Vehicle:", "< Bison >", selected, 3) BREAK
        CASE 115 DRAW_OPTION(y, "Vehicle:", "< Bobcat XL >", selected, 3) BREAK
        CASE 116 DRAW_OPTION(y, "Vehicle:", "< Sadler >", selected, 3) BREAK
        CASE 117 DRAW_OPTION(y, "Vehicle:", "< Primo >", selected, 3) BREAK
        CASE 118 DRAW_OPTION(y, "Vehicle:", "< Granger 2 >", selected, 3) BREAK
        CASE 119 DRAW_OPTION(y, "Vehicle:", "< Blazer >", selected, 3) BREAK
        CASE 120 DRAW_OPTION(y, "Vehicle:", "< Sanchez 2 >", selected, 3) BREAK
        CASE 121 DRAW_OPTION(y, "Vehicle:", "< Bagger >", selected, 3) BREAK
        CASE 122 DRAW_OPTION(y, "Vehicle:", "< Daemon >", selected, 3) BREAK
        CASE 123 DRAW_OPTION(y, "Vehicle:", "< Hexer >", selected, 3) BREAK
        CASE 124 DRAW_OPTION(y, "Vehicle:", "< Nemesis >", selected, 3) BREAK
        CASE 125 DRAW_OPTION(y, "Vehicle:", "< Ruffian >", selected, 3) BREAK
        CASE 126 DRAW_OPTION(y, "Vehicle:", "< Vader >", selected, 3) BREAK
        CASE 127 DRAW_OPTION(y, "Vehicle:", "< Thrust >", selected, 3) BREAK
        CASE 128 DRAW_OPTION(y, "Vehicle:", "< Vindicator >", selected, 3) BREAK
        CASE 129 DRAW_OPTION(y, "Vehicle:", "< Rhino Tank >", selected, 3) BREAK
        CASE 130 DRAW_OPTION(y, "Vehicle:", "< Bulldozer >", selected, 3) BREAK
        CASE 131 DRAW_OPTION(y, "Vehicle:", "< Forklift >", selected, 3) BREAK
        CASE 132 DRAW_OPTION(y, "Vehicle:", "< Mixer >", selected, 3) BREAK
        CASE 133 DRAW_OPTION(y, "Vehicle:", "< Hauler >", selected, 3) BREAK
        CASE 134 DRAW_OPTION(y, "Vehicle:", "< Packer >", selected, 3) BREAK
        CASE 135 DRAW_OPTION(y, "Vehicle:", "< Fire Truck >", selected, 3) BREAK
        CASE 136 DRAW_OPTION(y, "Vehicle:", "< Taxi >", selected, 3) BREAK
        CASE 137 DRAW_OPTION(y, "Vehicle:", "< Police Cruiser >", selected, 3) BREAK
        CASE 138 DRAW_OPTION(y, "Vehicle:", "< Sheriff SUV >", selected, 3) BREAK
        CASE 139 DRAW_OPTION(y, "Vehicle:", "< Bus >", selected, 3) BREAK
        CASE 140 DRAW_OPTION(y, "Vehicle:", "< Ambulance >", selected, 3) BREAK
        CASE 141 DRAW_OPTION(y, "Vehicle:", "< Tow Truck >", selected, 3) BREAK
        CASE 142 DRAW_OPTION(y, "Vehicle:", "< Trashmaster >", selected, 3) BREAK
        CASE 143 DRAW_OPTION(y, "Vehicle:", "< Dock Tug >", selected, 3) BREAK
        CASE 144 DRAW_OPTION(y, "Vehicle:", "< Tractor >", selected, 3) BREAK
        CASE 145 DRAW_OPTION(y, "Vehicle:", "< Maverick >", selected, 3) BREAK
        CASE 146 DRAW_OPTION(y, "Vehicle:", "< Frogger >", selected, 3) BREAK
        CASE 147 DRAW_OPTION(y, "Vehicle:", "< Shamal >", selected, 3) BREAK
        CASE 148 DRAW_OPTION(y, "Vehicle:", "< Mammatus >", selected, 3) BREAK
        CASE 149 DRAW_OPTION(y, "Vehicle:", "< Dodo >", selected, 3) BREAK
        CASE 150 DRAW_OPTION(y, "Vehicle:", "< Mallard Stunt >", selected, 3) BREAK
        CASE 151 DRAW_OPTION(y, "Vehicle:", "< Predator Boat >", selected, 3) BREAK
        CASE 152 DRAW_OPTION(y, "Vehicle:", "< Feltzer 3 >", selected, 3) BREAK
        CASE 153 DRAW_OPTION(y, "Vehicle:", "< Osiris >", selected, 3) BREAK
        CASE 154 DRAW_OPTION(y, "Vehicle:", "< Brawler >", selected, 3) BREAK
        CASE 155 DRAW_OPTION(y, "Vehicle:", "< T20 >", selected, 3) BREAK
        CASE 156 DRAW_OPTION(y, "Vehicle:", "< Moonbeam >", selected, 3) BREAK
        CASE 157 DRAW_OPTION(y, "Vehicle:", "< Voodoo >", selected, 3) BREAK
        CASE 158 DRAW_OPTION(y, "Vehicle:", "< Sabre GT >", selected, 3) BREAK
        CASE 159 DRAW_OPTION(y, "Vehicle:", "< Slamvan 3 >", selected, 3) BREAK
        CASE 160 DRAW_OPTION(y, "Vehicle:", "< Brickade >", selected, 3) BREAK
        CASE 161 DRAW_OPTION(y, "Vehicle:", "< Freecrawler >", selected, 3) BREAK
        CASE 162 DRAW_OPTION(y, "Vehicle:", "< Menacer >", selected, 3) BREAK
        CASE 163 DRAW_OPTION(y, "Vehicle:", "< Scramjet >", selected, 3) BREAK
        CASE 164 DRAW_OPTION(y, "Vehicle:", "< Terrorbyte >", selected, 3) BREAK
        CASE 165 DRAW_OPTION(y, "Vehicle:", "< Oppressor 2 >", selected, 3) BREAK
        CASE 166 DRAW_OPTION(y, "Vehicle:", "< Caracara >", selected, 3) BREAK
        CASE 167 DRAW_OPTION(y, "Vehicle:", "< Hotring Sabre >", selected, 3) BREAK
        CASE 168 DRAW_OPTION(y, "Vehicle:", "< Sea Sparrow >", selected, 3) BREAK
        CASE 169 DRAW_OPTION(y, "Vehicle:", "< Tampa Weaponized >", selected, 3) BREAK
        CASE 170 DRAW_OPTION(y, "Vehicle:", "< Formula >", selected, 3) BREAK
        CASE 171 DRAW_OPTION(y, "Vehicle:", "< Outlaw >", selected, 3) BREAK
        CASE 172 DRAW_OPTION(y, "Vehicle:", "< Zhaba >", selected, 3) BREAK
        CASE 173 DRAW_OPTION(y, "Vehicle:", "< Kosatka Sub >", selected, 3) BREAK
        CASE 174 DRAW_OPTION(y, "Vehicle:", "< Toreador >", selected, 3) BREAK
        CASE 175 DRAW_OPTION(y, "Vehicle:", "< RC Bandito >", selected, 3) BREAK
        CASE 176 DRAW_OPTION(y, "Vehicle:", "< Astron >", selected, 3) BREAK
        CASE 177 DRAW_OPTION(y, "Vehicle:", "< Champion >", selected, 3) BREAK
        CASE 178 DRAW_OPTION(y, "Vehicle:", "< Sultan Classic >", selected, 3) BREAK
        CASE 179 DRAW_OPTION(y, "Vehicle:", "< Vagrant >", selected, 3) BREAK
        CASE 180 DRAW_OPTION(y, "Vehicle:", "< Clique >", selected, 3) BREAK
        CASE 181 DRAW_OPTION(y, "Vehicle:", "< Deviant >", selected, 3) BREAK
        CASE 182 DRAW_OPTION(y, "Vehicle:", "< Schlagen GT >", selected, 3) BREAK
        CASE 183 DRAW_OPTION(y, "Vehicle:", "< Itali GTO >", selected, 3) BREAK
        CASE 184 DRAW_OPTION(y, "Vehicle:", "< Toros >", selected, 3) BREAK
        CASE 185 DRAW_OPTION(y, "Vehicle:", "< Vamos >", selected, 3) BREAK
        CASE 186 DRAW_OPTION(y, "Vehicle:", "< JB 700W >", selected, 3) BREAK
        CASE 187 DRAW_OPTION(y, "Vehicle:", "< Trailer Large >", selected, 3) BREAK
        CASE 188 DRAW_OPTION(y, "Vehicle:", "< Trailer 4 >", selected, 3) BREAK
        CASE 189 DRAW_OPTION(y, "Vehicle:", "< Trailer Small 2 >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_SELECTED_VEHICLE_SPAWN()
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() <= 0 EXIT ENDIF
        IF g_dlc_vehicle_index < 0 OR NOT DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index) EXIT ENDIF
        g_pending_vehicle_model = GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
    ELSE
    IF g_vehicle_spawn_choice >= 89
        g_pending_vehicle_model = MISC_VEHICLE_MODEL(g_vehicle_spawn_choice)
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
        CASE 54 g_pending_vehicle_model = DINGHY BREAK
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
        offsetX = (TO_FLOAT(column) - 4.5) * 6.5
        offsetY = 4.0 + (TO_FLOAT(row) * 6.5)
    ELSE
        column = g_spawn_index - ((g_spawn_index / 5) * 5)
        row = g_spawn_index / 5
        offsetX = (TO_FLOAT(column) - 2.0) * 6.5
        offsetY = 4.0 + (TO_FLOAT(row) * 6.5)
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
        IF g_spawn_index = g_spawn_warp_index AND NOT NOCLIP_VEHICLE_ENTRY_BLOCKED()
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
    BOOL jumpToTop = FALSE
    IF g_keyboard_active EXIT ENDIF
    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_LOOK_BEHIND) jumpToTop = TRUE ENDIF
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_RS) jumpToTop = TRUE ENDIF
    IF jumpToTop
        g_item = 0
        g_scroll = 0
        SAVE_NAVIGATION_STATE()
        MENU_PLAY_SOUND("NAV_UP_DOWN")
    ENDIF
    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP)
        MOVE_MENU_CURSOR(-1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_up_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP) AND now >= g_next_up_repeat
        MOVE_MENU_CURSOR(-1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_up_repeat = now + 70
    ENDIF
    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
        MOVE_MENU_CURSOR(1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_down_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN) AND now >= g_next_down_repeat
        MOVE_MENU_CURSOR(1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_down_repeat = now + 70
    ENDIF
    IF NOT g_home AND IS_SELECTOR_ACTIVE()
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
            ADJUST_SELECTOR(-1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_left_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT) AND now >= g_next_left_repeat
            ADJUST_SELECTOR(-1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_left_repeat = now + 70
        ENDIF
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
            ADJUST_SELECTOR(1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_right_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT) AND now >= g_next_right_repeat
            ADJUST_SELECTOR(1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
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
    IF g_radio_open
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
        EXIT
    ENDIF
    IF g_ped_open
        IF g_item = 0
            OPEN_MENU_KEYBOARD(3)
        ELIF g_item = 1
            APPLY_RANDOM_PED()
        ELIF g_item > 2
            SAVE_ACTIVE_CHARACTER_PED()
            g_ped_choice = g_item - 3
            g_ped_search_not_found = FALSE
            g_ped_search_has_value = TRUE
            g_ped_search_is_custom = FALSE
            g_ped_search_value = PED_NAME_FOR_CHOICE(g_ped_choice)
            REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(g_ped_choice))
        ENDIF
        EXIT
    ENDIF
    IF g_bodyguard_open
        IF g_guard_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(10)
            ELIF g_item = 1
                APPLY_RANDOM_GUARD_PED()
            ELIF g_item > 1
                g_guard_ped_choice = g_item - 2
                g_guard_ped_name = PED_NAME_FOR_CHOICE(g_guard_ped_choice)
                g_guard_ped_search_is_custom = FALSE
                g_guard_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        SWITCH g_item
            CASE 0 START_BODYGUARD_SPAWN() BREAK
            CASE 1
                g_bodyguard_item = g_item
                g_bodyguard_scroll = g_scroll
                g_guard_ped_open = TRUE
                g_item = g_guard_ped_item
                g_scroll = g_guard_ped_scroll
            BREAK
            CASE 4
                g_bodyguard_follow = NOT g_bodyguard_follow
                APPLY_BODYGUARD_FOLLOW_STATE()
            BREAK
            CASE 5
                g_bodyguard_blips = NOT g_bodyguard_blips
            BREAK
            CASE 6
                g_bodyguard_god = NOT g_bodyguard_god
                APPLY_BODYGUARD_GOD_STATE()
            BREAK
            CASE 7 CLEAR_BODYGUARDS() BREAK
        ENDSWITCH
        IF g_item = 3 APPLY_BODYGUARD_FORMATION() ENDIF
        EXIT
    ENDIF
    IF g_attacker_open
        IF g_attacker_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(11)
            ELIF g_item = 1
                APPLY_RANDOM_ATTACKER_PED()
            ELIF g_item > 1
                g_attacker_ped_choice = g_item - 2
                g_attacker_ped_name = PED_NAME_FOR_CHOICE(g_attacker_ped_choice)
                g_attacker_ped_search_is_custom = FALSE
                g_attacker_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        SWITCH g_item
            CASE 0 START_ATTACKER_SPAWN() BREAK
            CASE 1
                g_attacker_item = g_item
                g_attacker_scroll = g_scroll
                g_attacker_ped_open = TRUE
                g_item = g_attacker_ped_item
                g_scroll = g_attacker_ped_scroll
            BREAK
            CASE 3
                g_attacker_rage = NOT g_attacker_rage
                APPLY_ATTACKER_RAGE_STATE()
            BREAK
            CASE 4
                g_attacker_god = NOT g_attacker_god
                APPLY_ATTACKER_GOD_STATE()
            BREAK
            CASE 5 CLEAR_MENU_ATTACKERS() BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF g_chauffeur_open
        IF g_chauffeur_armed_open
            IF g_item = 0
                g_chauffeur_armed = NOT g_chauffeur_armed
                APPLY_CHAUFFEUR_ARMED_STATE()
            ELIF g_item > 0
                g_chauffeur_weapon_choice = g_item - 1
                IF g_chauffeur_weapon_choice >= MENU_WEAPON_COUNT() g_chauffeur_weapon_choice = 0 ENDIF
                APPLY_CHAUFFEUR_ARMED_STATE()
            ENDIF
            EXIT
        ENDIF
        IF g_chauffeur_vehicle_open
            IF g_item < CHAUFFEUR_VEHICLE_COUNT g_chauffeur_vehicle_choice = g_item ENDIF
            EXIT
        ENDIF
        IF g_chauffeur_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(13)
            ELIF g_item = 1
                APPLY_RANDOM_CHAUFFEUR_PED()
            ELIF g_item > 1
                g_chauffeur_ped_choice = g_item - 2
                g_chauffeur_ped_name = PED_NAME_FOR_CHOICE(g_chauffeur_ped_choice)
                g_chauffeur_ped_search_is_custom = FALSE
                g_chauffeur_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        SWITCH g_item
            CASE 0 START_CHAUFFEUR_SPAWN() BREAK
            CASE 1
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_ped_open = TRUE
                g_item = g_chauffeur_ped_item
                g_scroll = g_chauffeur_ped_scroll
            BREAK
            CASE 2
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_vehicle_open = TRUE
                g_item = g_chauffeur_vehicle_item
                g_scroll = g_chauffeur_vehicle_scroll
            BREAK
            CASE 4
                g_chauffeur_ignore_lights = NOT g_chauffeur_ignore_lights
                REFRESH_CHAUFFEUR_DRIVING_MODE()
                ISSUE_CHAUFFEUR_DRIVE_TASK()
            BREAK
            CASE 5
                g_chauffeur_god = NOT g_chauffeur_god
                APPLY_CHAUFFEUR_EXTRAS()
            BREAK
            CASE 6
                g_chauffeur_bulletproof_tyres = NOT g_chauffeur_bulletproof_tyres
                APPLY_CHAUFFEUR_EXTRAS()
            BREAK
            CASE 7
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_armed_open = TRUE
                g_item = g_chauffeur_armed_item
                g_scroll = g_chauffeur_armed_scroll
            BREAK
            CASE 8 g_chauffeur_auto_step = NOT g_chauffeur_auto_step BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF g_neon_anim_open
        EXIT
    ENDIF
    IF g_vehicle_control_open
        IF NOT IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
        SWITCH g_item
            CASE 2 APPLY_VEHICLE_SELECTED_WINDOW(TRUE) BREAK
            CASE 3 APPLY_VEHICLE_SELECTED_WINDOW(FALSE) BREAK
            CASE 4 APPLY_VEHICLE_ENGINE_TOGGLE() BREAK
            CASE 5
                g_vehicle_hazards = NOT g_vehicle_hazards
                g_vehicle_hazards_tick = 0
                APPLY_VEHICLE_HAZARDS_STATE()
            BREAK
            CASE 6 APPLY_VEHICLE_SEAT_SWITCH() BREAK
            CASE 8 APPLY_VEHICLE_WASH() BREAK
        ENDSWITCH
        EXIT
    ENDIF
    SWITCH g_tab
        CASE 0
            SWITCH g_item
                CASE 0
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_radio_open = TRUE
                    g_item = g_radio_item
                    g_scroll = g_radio_scroll
                BREAK
                CASE 1
                    g_god = NOT g_god
                    SET_PLAYER_INVINCIBLE(PLAYER_ID(), g_god)
                BREAK
                CASE 2
                    SET_ENTITY_HEALTH(playerPed, GET_ENTITY_MAX_HEALTH(playerPed))
                    SET_PED_ARMOUR(playerPed, 100)
                BREAK
                CASE 3
                    g_invisible = NOT g_invisible
                    SET_ENTITY_VISIBLE(playerPed, NOT g_invisible)
                    IF NOT g_invisible g_player_freecam = FALSE ENDIF
                BREAK
                CASE 4
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    currentPlayerModel = GET_ENTITY_MODEL(playerPed)
                    g_character_slot = SLOT_FOR_MODEL(currentPlayerModel)
                    g_ped_choice = PED_CHOICE_FOR_MODEL(currentPlayerModel)
                    g_ped_open = TRUE
                    g_item = g_ped_item
                    g_scroll = g_ped_scroll
                BREAK
                CASE 5
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_outfit_open = TRUE
                    g_item = g_outfit_item
                    g_scroll = g_outfit_scroll
                BREAK
                CASE 6
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_bodyguard_open = TRUE
                    g_item = g_bodyguard_item
                    g_scroll = g_bodyguard_scroll
                BREAK
                CASE 7
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_attacker_open = TRUE
                    g_item = g_attacker_item
                    g_scroll = g_attacker_scroll
                BREAK
                CASE 8 SET_PLAYER_NOCLIP_ENABLED(NOT g_player_noclip) BREAK
                CASE 9 SET_PLAYER_FREECAM_ENABLED(NOT g_player_freecam) BREAK
                CASE 10
                    g_unlimited_oxygen = NOT g_unlimited_oxygen
                    APPLY_UNLIMITED_OXYGEN()
                BREAK
                CASE 11
                    g_unlimited_ability = NOT g_unlimited_ability
                    APPLY_UNLIMITED_ABILITY()
                BREAK
                CASE 12
                    g_fast_run = NOT g_fast_run
                BREAK
                CASE 13
                    g_fast_swim = NOT g_fast_swim
                BREAK
                CASE 14
                    g_super_jump = NOT g_super_jump
                BREAK
                CASE 15
                    g_no_ragdoll = NOT g_no_ragdoll
                    SET_PED_CAN_RAGDOLL(playerPed, NOT g_no_ragdoll)
                BREAK
                CASE 16 g_infinite_parachute = NOT g_infinite_parachute BREAK
                CASE 17 OPEN_MENU_KEYBOARD(2) BREAK
                CASE 18
                    SWITCH GET_ENTITY_MODEL(playerPed)
                        CASE PLAYER_ZERO STAT_SET_INT(SP0_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_ONE STAT_SET_INT(SP1_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_TWO STAT_SET_INT(SP2_TOTAL_CASH, g_cash_amount) BREAK
                    ENDSWITCH
                BREAK
                CASE 19
                    g_explosive_melee = NOT g_explosive_melee
                BREAK
                CASE 20
                    g_super_punch = NOT g_super_punch
                    g_super_punch_time = 0
                BREAK
                CASE 21
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
                CASE 22 CLEAR_PLAYER_DAMAGE_MARKS() BREAK
                CASE 23 SET_ENTITY_HEALTH(playerPed, 0) BREAK
                CASE 24
                    g_auto_save = NOT g_auto_save
                    g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000)
                BREAK
                CASE 25 OPEN_MENU_KEYBOARD(12) BREAK
            ENDSWITCH
        BREAK
        CASE 1
            IF g_weapon_upgrades_open
                SWITCH g_item
                    CASE 0 REFILL_CURRENT_HELD_WEAPON() BREAK
                    CASE 1 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_MAG_COMPONENT()) BREAK
                    CASE 2 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_FLASHLIGHT_COMPONENT()) BREAK
                    CASE 3 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_SUPPRESSOR_COMPONENT()) BREAK
                    CASE 4 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_GRIP_COMPONENT()) BREAK
                    CASE 5 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_SCOPE_COMPONENT()) BREAK
                ENDSWITCH
            ELSE
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
                        g_infinite_clip = NOT g_infinite_clip
                        SET_PED_INFINITE_AMMO_CLIP(playerPed, g_infinite_clip)
                    BREAK
                    CASE 4
                        REFILL_ALL_OWNED_WEAPONS(playerPed)
                    BREAK
                    CASE 5
                        IF HELD_WEAPON_EDITABLE()
                            g_page_item[1] = g_item
                            g_page_scroll[1] = g_scroll
                            g_weapon_upgrades_open = TRUE
                            g_item = g_weapon_upgrades_item
                            g_scroll = g_weapon_upgrades_scroll
                        ENDIF
                    BREAK
                    CASE 6
                        g_explosive_ammo = NOT g_explosive_ammo
                    BREAK
                    CASE 7
                        REMOVE_WEAPON_FROM_PED(playerPed, GET_SELECTED_PED_WEAPON(playerPed))
                    BREAK
                    CASE 8
                        REMOVE_ALL_PED_WEAPONS(playerPed)
                    BREAK
                ENDSWITCH
            ENDIF
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
                    APPLY_DISPATCH_SERVICES_STATE()
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
            ELIF g_hydro_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELIF NOT PLAYER_CAR_HAS_HYDRO() AND g_item != 16 AND g_item != 17
                    g_hydro_soft = g_wheeltyre_soft_suspension
                ELSE
                SWITCH g_item
                    CASE 0
                        g_hydro_enabled = NOT g_hydro_enabled
                        APPLY_HYDRO_KIT_STATE()
                    BREAK
                    CASE 2
                        g_hydro_control = NOT g_hydro_control
                        APPLY_HYDRO_CONTROL()
                    BREAK
                    CASE 4 APPLY_HYDRO_PRESET() BREAK
                    CASE 5 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 6 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 7 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 8 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 9 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 14 APPLY_HYDRO_WHEEL() BREAK
                    CASE 15
                        g_hydro_hold = NOT g_hydro_hold
                        IF g_hydro_hold
                            g_hydro_hold_preset = g_hydro_preset
                            g_hydro_hold_tick = 0
                            MAINTAIN_HYDRO_HOLD()
                        ENDIF
                    BREAK
                    CASE 16
                        g_hydro_soft = NOT g_hydro_soft
                        APPLY_HYDRO_SOFTNESS()
                    BREAK
                    CASE 17 RESET_HYDRAULICS() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_interior_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 0 APPLY_INTERIOR_FILL() BREAK
                    CASE 3 APPLY_INTERIOR_SLOT() BREAK
                    CASE 7
                        APPLY_INTERIOR_COLOURS()
                    BREAK
                    CASE 8
                        APPLY_INTERIOR_COLOURS()
                    BREAK
                    CASE 10 RESET_INTERIOR_SLOTS() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_wheeltyre_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 3 APPLY_WHEEL_FAMILY() BREAK
                    CASE 4 APPLY_WHEEL_VARIATION() BREAK
                    CASE 7 APPLY_WHEEL_TYRE_SMOKE() BREAK
                    CASE 8 APPLY_TYRES_CAN_BURST() BREAK
                    CASE 9 APPLY_SOFT_SUSPENSION() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_lsc_extras_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 3 APPLY_LIVERY() BREAK
                    CASE 7 APPLY_EXTRA_TOGGLE() BREAK
                    CASE 8 APPLY_ALL_EXTRAS(TRUE) BREAK
                    CASE 9 APPLY_ALL_EXTRAS(FALSE) BREAK
                ENDSWITCH
                ENDIF
            ELIF g_bennys_open
                APPLY_BENNYS_SPAWN()
            ELIF g_support_open
                g_support_item = g_item
            ELIF g_lsc_open
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    SWITCH g_item
                        CASE 0 APPLY_LSC_MAX() BREAK
                        CASE 1 APPLY_LSC_STOCK() BREAK
                        CASE 3 APPLY_LSC_MOD() BREAK
                        CASE 10
                            g_lsc_turbo = NOT g_lsc_turbo
                            LSC_USE_KIT(playerVehicle)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_lsc_turbo)
                        BREAK
                        CASE 11
                            g_lsc_xenon = NOT g_lsc_xenon
                            LSC_USE_KIT(playerVehicle)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_XENON_LIGHTS, g_lsc_xenon)
                        BREAK
                        CASE 13
                            g_lsc_neon = NOT g_lsc_neon
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_FRONT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_BACK, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_LEFT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_RIGHT, g_lsc_neon)
                        BREAK
                        CASE 9
                            g_lsc_wheel_type = g_lsc_wheel_type + 1
                            IF g_lsc_wheel_type >= WHEEL_FAMILY_COUNT g_lsc_wheel_type = 0 ENDIF
                            SET_VEHICLE_WHEEL_TYPE(playerVehicle, INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
                        BREAK
                        CASE 16 OPEN_MENU_KEYBOARD(9) BREAK
                        CASE 17
                            IF NOT IS_STRING_NULL_OR_EMPTY(g_plate_value)
                                SET_VEHICLE_NUMBER_PLATE_TEXT(playerVehicle, g_plate_value)
                                g_plate_value = GET_VEHICLE_NUMBER_PLATE_TEXT(playerVehicle)
                            ENDIF
                        BREAK
                        CASE 18
                            LSC_KIT_FOR_SLOT(playerVehicle, LSC_SLOT())
                            REMOVE_VEHICLE_MOD(playerVehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
                            g_lsc_mod_choice = -1
                        BREAK
                        CASE 19
                            g_lsc_kit_choice = LSC_ACTIVE_KIT(playerVehicle) + 1
                            IF g_lsc_kit_choice >= LSC_KIT_COUNT(playerVehicle) g_lsc_kit_choice = 0 ENDIF
                            LSC_USE_KIT(playerVehicle)
                            SYNC_LSC_VEHICLE_STATE()
                        BREAK
                        CASE 22
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_hydro_open = TRUE
                            g_item = g_hydro_item
                            g_scroll = g_hydro_scroll
                        BREAK
                        CASE 23
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_interior_open = TRUE
                            SYNC_INTERIOR_SLOT()
                            g_item = g_interior_item
                            g_scroll = g_interior_scroll
                        BREAK
                        CASE 24
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_wheeltyre_open = TRUE
                            SYNC_WHEELTYRE_STATE()
                            g_item = g_wheeltyre_item
                            g_scroll = g_wheeltyre_scroll
                        BREAK
                        CASE 25
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_lsc_extras_open = TRUE
                            REFRESH_EXTRA_PROBE()
                            g_item = g_lsc_extras_item
                            g_scroll = g_lsc_extras_scroll
                        BREAK
                        CASE 26
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_bennys_open = TRUE
                            g_item = g_bennys_item
                            g_scroll = g_bennys_scroll
                        BREAK
                        CASE 27 START_VEHICLE_CONVERSION() BREAK
                        CASE 28
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_support_open = TRUE
                            g_item = g_support_item
                            g_scroll = g_support_scroll
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
            ELIF g_item = 1
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_lsc_open = TRUE
                g_lsc_mod_choice = -1
                IF IS_PED_IN_ANY_VEHICLE(playerPed) SYNC_LSC_VEHICLE_STATE() ENDIF
                g_item = g_lsc_item
                g_scroll = g_lsc_scroll
            ELIF g_item = 2
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_page_item[3] = g_item
                    g_page_scroll[3] = g_scroll
                    g_neon_anim_open = TRUE
                    g_item = g_neon_anim_item
                    g_scroll = g_neon_anim_scroll
                ENDIF
            ELIF g_item = 3
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_page_item[3] = g_item
                    g_page_scroll[3] = g_scroll
                    g_vehicle_control_open = TRUE
                    SYNC_VEHICLE_DIRT_SLIDER()
                    g_item = g_vehicle_control_item
                    g_scroll = g_vehicle_control_scroll
                ENDIF
            ELIF g_item = 7
                g_vehicle_always_max = NOT g_vehicle_always_max
            ELIF g_item = 14
                g_vehicle_quick_entry_exit = NOT g_vehicle_quick_entry_exit
            ELIF g_item = 15
                WARP_INTO_LAST_PLAYER_VEHICLE()
            ELIF g_item = 6
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(playerPed))
                ENDIF
            ELIF g_item = 23
                g_vehicle_speedometer = NOT g_vehicle_speedometer
            ELIF g_item = 24
                g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
            ELIF g_item = 25
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_chauffeur_open = TRUE
                g_item = g_chauffeur_item
                g_scroll = g_chauffeur_scroll
            ELIF g_item = 16
                BRING_PERSONAL_VEHICLE()
            ELIF g_item = 17
                g_vehicle_horn_boost = NOT g_vehicle_horn_boost
            ELIF g_item = 18
                g_vehicle_auto_repair = NOT g_vehicle_auto_repair
            ELIF g_item = 19
                OPEN_PLANE_CARGO_DOORS()
            ELIF g_item = 20
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    g_doors_locked = NOT g_doors_locked
                    IF g_doors_locked
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_LOCKED)
                    ELSE
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_UNLOCKED)
                    ENDIF
                ENDIF
            ELIF g_item = 21
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
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
                ENDIF
            ELIF g_item = 22
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    SET_VEHICLE_ENGINE_HEALTH(GET_VEHICLE_PED_IS_IN(playerPed), -4000.0)
                ENDIF
            ELIF IS_PED_IN_ANY_VEHICLE(playerPed)
                playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                SWITCH g_item
                    CASE 4
                        g_vehicle_god = NOT g_vehicle_god
                        APPLY_VEHICLE_GOD_STATE(playerVehicle, g_vehicle_god)
                    BREAK
                    CASE 5
                        SET_VEHICLE_FIXED(playerVehicle)
                        SET_VEHICLE_ENGINE_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_PETROL_TANK_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_BODY_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_UNDRIVEABLE(playerVehicle, FALSE)
                    BREAK
                    CASE 13 SET_VEHICLE_ON_GROUND_PROPERLY(playerVehicle) BREAK
                    CASE 8 BREAK
                    CASE 9 BREAK
                    CASE 10
                        g_godmode_tow_hook = NOT g_godmode_tow_hook
                        IF NOT g_godmode_tow_hook
                            g_tow_hook_vehicle = NULL
                            g_tow_hook_towed = NULL
                        ENDIF
                    BREAK
                    CASE 12 g_vehicle_bulletproof_tyres = NOT g_vehicle_bulletproof_tyres BREAK
                    CASE 11
                        g_vehicle_turbo = NOT g_vehicle_turbo
                        LSC_USE_KIT(playerVehicle)
                        TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_vehicle_turbo)
                    BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 4
            IF g_timeweather_open
                SWITCH g_item
                    CASE 0 APPLY_TIME_CHOICE() BREAK
                    CASE 1 APPLY_EDITABLE_TIME() BREAK
                    CASE 2 APPLY_EDITABLE_TIME() BREAK
                    CASE 3 APPLY_EDITABLE_TIME() BREAK
                    CASE 4
                        g_pause_time = NOT g_pause_time
                        PAUSE_CLOCK(g_pause_time)
                    BREAK
                    CASE 5 APPLY_WEATHER_CHOICE() BREAK
                ENDSWITCH
            ELSE
            SWITCH g_item
                CASE 0
                    g_page_item[4] = g_item
                    g_page_scroll[4] = g_scroll
                    g_timeweather_open = TRUE
                    g_item = g_timeweather_item
                    g_scroll = g_timeweather_scroll
                BREAK
                CASE 1
                    g_night_vision = NOT g_night_vision
                    SET_NIGHTVISION(g_night_vision)
                BREAK
                CASE 2
                    g_thermal_vision = NOT g_thermal_vision
                    SET_SEETHROUGH(g_thermal_vision)
                BREAK
                CASE 4 APPLY_TIME_SCALE() BREAK
                CASE 5 APPLY_GRAVITY_CHOICE() BREAK
                CASE 11
                    g_motion_blur = NOT g_motion_blur
                    IF g_motion_blur
                        SET_TIMECYCLE_MODIFIER("scanline_cam_cheap")
                    ELSE
                        CLEAR_TIMECYCLE_MODIFIER()
                    ENDIF
                BREAK
                CASE 12
                    g_camera_shake = NOT g_camera_shake
                    IF g_camera_shake
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.5)
                    ELSE
                        STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                    ENDIF
                BREAK
                CASE 6 APPLY_IPL_PRESET(TRUE) BREAK
                CASE 7 APPLY_IPL_PRESET(FALSE) BREAK
                CASE 8 OPEN_MENU_KEYBOARD(8) BREAK
                CASE 9 LOAD_CUSTOM_IPL() BREAK
                CASE 10 UNLOAD_CUSTOM_IPL() BREAK
                CASE 13 START_DOOR_SCAN() BREAK
            ENDSWITCH
            ENDIF
        BREAK
        CASE 5
            IF g_tp_stores_open
                SWITCH g_item
                    CASE 0 TELEPORT_PLAYER_FAST(<<-711.82, -915.91, 18.24>>) BREAK
                    CASE 1 TELEPORT_PLAYER_FAST(<<-52.72, -1756.17, 28.44>>) BREAK
                    CASE 2 TELEPORT_PLAYER_FAST(<<1159.44, -325.67, 68.23>>) BREAK
                    CASE 3 TELEPORT_PLAYER_FAST(<<1699.43, 4928.64, 41.09>>) BREAK
                    CASE 4 TELEPORT_PLAYER_FAST(<<-1822.93, 788.95, 137.21>>) BREAK
                    CASE 5 TELEPORT_PLAYER_FAST(<<1166.43, 2703.53, 37.16>>) BREAK
                    CASE 6 TELEPORT_PLAYER_FAST(<<-2973.41, 390.69, 14.04>>) BREAK
                    CASE 7 TELEPORT_PLAYER_FAST(<<-1225.86, -903.58, 11.33>>) BREAK
                    CASE 8 TELEPORT_PLAYER_FAST(<<1140.66, -981.08, 45.42>>) BREAK
                    CASE 9 TELEPORT_PLAYER_FAST(<<-1490.28, -382.85, 39.16>>) BREAK
                    CASE 10 TELEPORT_PLAYER_FAST(<<-3240.72, 1004.51, 11.85>>) BREAK
                    CASE 11 TELEPORT_PLAYER_FAST(<<-3039.25, 589.38, 6.93>>) BREAK
                    CASE 12 TELEPORT_PLAYER_FAST(<<544.43, 2672.06, 41.17>>) BREAK
                    CASE 13 TELEPORT_PLAYER_FAST(<<2558.75, 385.60, 107.64>>) BREAK
                    CASE 14 TELEPORT_PLAYER_FAST(<<2681.51, 3282.76, 54.26>>) BREAK
                    CASE 15 TELEPORT_PLAYER_FAST(<<1731.15, 6411.63, 34.04>>) BREAK
                    CASE 16 TELEPORT_PLAYER_FAST(<<1964.93, 3741.21, 31.36>>) BREAK
                    CASE 17 TELEPORT_PLAYER_FAST(<<29.07, -1348.77, 28.51>>) BREAK
                    CASE 18 TELEPORT_PLAYER_FAST(<<376.85, 323.98, 102.58>>) BREAK
                ENDSWITCH
            ELIF g_tp_locs_open
                SWITCH g_item
                    CASE 0 TELEPORT_PLAYER_FAST(<<501.7, 5604.4, 797.9>>) BREAK
                    CASE 1 TELEPORT_PLAYER_FAST(<<-75.0, -818.9, 326.2>>) BREAK
                    CASE 2 TELEPORT_PLAYER_FAST(<<-1034.6, -2733.6, 20.2>>) BREAK
                    CASE 3 TELEPORT_PLAYER_FAST(<<711.7, 1198.8, 348.5>>) BREAK
                    CASE 4 TELEPORT_PLAYER_FAST(<<-2047.4, 3132.1, 32.8>>) BREAK
                    CASE 5 TELEPORT_PLAYER_FAST(<<102.9, -1939.7, 20.8>>) BREAK
                    CASE 6 TELEPORT_PLAYER_FAST(<<-14.4, -1438.0, 31.1>>) BREAK
                    CASE 7 TELEPORT_PLAYER_FAST(<<-852.4, 160.0, 65.6>>) BREAK
                    CASE 8
                        PREPARE_TELEPORT_IPL(11)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<1975.5, 3819.6, 33.4>>)
                    BREAK
                    CASE 9 TELEPORT_PLAYER_FAST(<<1274.8, -1710.0, 54.8>>) BREAK
                    CASE 10 TELEPORT_PLAYER_FAST(<<-47.1, -1112.3, 26.4>>) BREAK
                    CASE 11
                        PREPARE_TELEPORT_IPL(14)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<-449.7, -340.7, 34.5>>)
                    BREAK
                    CASE 12 TELEPORT_PLAYER_FAST(<<425.1, -979.5, 30.7>>) BREAK
                    CASE 13 TELEPORT_PLAYER_FAST(<<-662.1, -948.5, 21.5>>) BREAK
                    CASE 14 TELEPORT_PLAYER_FAST(<<-365.4, -131.4, 37.9>>) BREAK
                    CASE 15 TELEPORT_TO_NORTH_YANKTON() BREAK
                    CASE 16 TELEPORT_TO_CAYO_PERICO() BREAK
                    CASE 17 TELEPORT_PLAYER_FAST(<<1692.0, 3291.0, 41.0>>) BREAK
                    CASE 18 TELEPORT_PLAYER_FAST(<<-438.0, 1076.0, 327.0>>) BREAK
                    CASE 19 TELEPORT_PLAYER_FAST(<<-1170.0, 4927.0, 224.0>>) BREAK
                    CASE 20
                        PREPARE_TELEPORT_IPL(28)
                        TELEPORT_PLAYER_FAST(<<1110.0, 220.0, -49.0>>)
                    BREAK
                    CASE 21 TELEPORT_PLAYER_FAST(<<3615.2, 3744.7, 28.7>>) BREAK
                    CASE 22 TELEPORT_PLAYER_FAST(<<1690.0, 2565.0, 45.6>>) BREAK
                    CASE 23 TELEPORT_PLAYER_FAST(<<-119.0, 6455.0, 31.4>>) BREAK
                    CASE 24
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4439.0, -4458.0, 4.2>>) ENDIF
                    BREAK
                    CASE 25
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4964.0, -5164.0, 0.2>>) ENDIF
                    BREAK
                    CASE 26
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<5040.0, -5784.0, 17.8>>) ENDIF
                    BREAK
                    CASE 27
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4990.0, -5710.0, 19.9>>) ENDIF
                    BREAK
                    CASE 28
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4902.0, -4929.0, 3.3>>) ENDIF
                    BREAK
                    CASE 29
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4441.0, -4440.0, 8.2>>) ENDIF
                    BREAK
                    CASE 30 TELEPORT_PLAYER_FAST(<<-424.2, -1685.8, 19.0>>) BREAK
                    CASE 31 TELEPORT_PLAYER_FAST(<<-81.1, -1395.3, 29.3>>) BREAK
                    CASE 32
                        PREPARE_TELEPORT_IPL(40)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<848.7, 3004.0, 45.6>>)
                    BREAK
                    CASE 33 TELEPORT_PLAYER_FAST(<<-1163.2, -2866.0, 13.9>>) BREAK
                    CASE 34
                        PREPARE_TELEPORT_IPL(42)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<-2023.0, -1038.0, 5.0>>)
                    BREAK
                ENDSWITCH
            ELSE
                SWITCH g_item
                    CASE 0 TELEPORT_TO_WAYPOINT() BREAK
                    CASE 1 g_auto_waypoint = NOT g_auto_waypoint BREAK
                    CASE 2
                        g_page_item[5] = g_item
                        g_page_scroll[5] = g_scroll
                        g_tp_stores_open = TRUE
                        g_item = g_tp_stores_item
                        g_scroll = g_tp_stores_scroll
                    BREAK
                    CASE 3 TELEPORT_TO_OBJECTIVE() BREAK
                    CASE 4
                        g_auto_objective = NOT g_auto_objective
                        IF NOT g_auto_objective
                            g_auto_objective_was_in_cutscene = FALSE
                            g_auto_objective_pending = FALSE
                        ENDIF
                    BREAK
                    CASE 5
                        g_page_item[5] = g_item
                        g_page_scroll[5] = g_scroll
                        g_tp_locs_open = TRUE
                        g_item = g_tp_locs_item
                        g_scroll = g_tp_locs_scroll
                    BREAK
                    CASE 6 NUDGE_PLAYER_BY_OFFSET(<<0.0, 1.0, 0.0>>) BREAK
                    CASE 7 NUDGE_PLAYER_BY_OFFSET(<<0.0, -1.0, 0.0>>) BREAK
                    CASE 8 NUDGE_PLAYER_BY_OFFSET(<<0.0, 0.0, 1.0>>) BREAK
                    CASE 9 NUDGE_PLAYER_BY_OFFSET(<<0.0, 0.0, -1.0>>) BREAK
                    CASE 10 OPEN_MENU_KEYBOARD(5) BREAK
                    CASE 11 OPEN_MENU_KEYBOARD(6) BREAK
                    CASE 12 OPEN_MENU_KEYBOARD(7) BREAK
                    CASE 13 TELEPORT_TO_ENTERED_COORDS() BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 6
            SWITCH g_item
                CASE 0 g_skip_cutscenes = NOT g_skip_cutscenes BREAK
                CASE 1 REFRESH_STREAMED_ASSETS() BREAK
                CASE 2
                    g_npc_brawl = NOT g_npc_brawl
                    IF g_npc_brawl
                        g_everyone_ignores = FALSE
                        TASK_NEARBY_NPCS_TO_BRAWL()
                        g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
                    ELSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 3
                    g_everyone_ignores = NOT g_everyone_ignores
                    IF g_everyone_ignores AND g_npc_brawl
                        g_npc_brawl = FALSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 4 g_low_population = NOT g_low_population BREAK
                CASE 6
                    CLEAR_AREA_OF_VEHICLES(GET_ENTITY_COORDS(playerPed), 50.0)
                    PRUNE_SPAWNED_VEHICLE_TRACKING()
                BREAK
                CASE 7
                    CLEAR_AREA_OF_PEDS(GET_ENTITY_COORDS(playerPed), 50.0)
                    CLEAR_MENU_ATTACKERS()
                    PRUNE_MENU_PED_TRACKING()
                    CLEAR_STRIPPER_PEDS()
                BREAK
                CASE 8 EXPLODE_ALL_NEARBY_VEHICLES() BREAK
                CASE 9
                    g_first_person = NOT g_first_person
                    IF NOT g_first_person g_player_freecam = FALSE ENDIF
                BREAK
                CASE 10 g_hud_hidden = NOT g_hud_hidden BREAK
                CASE 11 g_radar_hidden = NOT g_radar_hidden BREAK
                CASE 12 START_STRIPPER_SPAWN() BREAK
            ENDSWITCH
        BREAK
        CASE 7
            IF g_spooner_open
                SWITCH g_item
                    CASE 0 QUEUE_SPOONER_OBJECT_SPAWN(SPOONER_CATALOG_MODEL(g_spooner_catalog_index)) BREAK
                    CASE 1 OPEN_MENU_KEYBOARD(14) BREAK
                    CASE 2 QUEUE_SPOONER_OBJECT_SPAWN(SPOONER_CATALOG_MODEL(g_spooner_catalog_index)) BREAK
                    CASE 3 APPLY_SPOONER_OFFSET_TO_SELECTED() BREAK
                    CASE 4
                        g_spooner_forward_offset = 2.50
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 5
                        g_spooner_side_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 6
                        g_spooner_height_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 7
                        g_spooner_heading_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 8 TOGGLE_SPOONER_FREEZE_POSITION() BREAK
                    CASE 9 TOGGLE_SPOONER_COLLISION() BREAK
                    CASE 10 SET_PLAYER_FREECAM_ENABLED(NOT g_player_freecam) BREAK
                    CASE 11 SNAP_SPOONER_OBJECT_TO_GROUND() BREAK
                    CASE 12 APPLY_SPOONER_ATTACHMENT(TRUE) BREAK
                    CASE 13
                        g_spooner_attach_x = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 14
                        g_spooner_attach_y = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 15
                        g_spooner_attach_z = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 16
                        g_spooner_rot_axis = g_spooner_rot_axis + 1
                        IF g_spooner_rot_axis > 2 g_spooner_rot_axis = 0 ENDIF
                    BREAK
                    CASE 17 APPLY_SPOONER_ATTACHMENT(FALSE) BREAK
                    CASE 18 DELETE_SPOONER_LAST_OBJECT() BREAK
                    CASE 19 CLEAR_ALL_SPOONER_OBJECTS() BREAK
                ENDSWITCH
            ELIF g_nsc_loader_open
                IF g_item = 0
                    SCAN_CUSTOM_NSC_DIRECTORY()
                ELIF g_item = 1
                    OPEN_MENU_KEYBOARD(15)
                ELIF g_item = 2
                    g_nsc_stack_choice = g_nsc_stack_choice + 1
                    IF g_nsc_stack_choice > 2 g_nsc_stack_choice = 0 ENDIF
                ELIF g_item = 3
                    STOP_ALL_CUSTOM_NSC_SCRIPTS()
                ELSE
                    IF g_nsc_discovered_count > 0
                        TRIGGER_LOAD_OR_RELOAD_CUSTOM_NSC(g_item - NSC_LOADER_HEADER_ROWS)
                    ELSE
                        SCAN_CUSTOM_NSC_DIRECTORY()
                    ENDIF
                ENDIF
            ELIF g_persist_open
                PERSIST_HANDLE_ROW(g_item)
            ELSE
                IF g_item = 0
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_spooner_open = TRUE
                    g_item = g_spooner_item
                    g_scroll = g_spooner_scroll
                    SYNC_SPOONER_UI_FROM_SELECTED()
                ELIF g_item = 1
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_nsc_loader_open = TRUE
                    ENSURE_CUSTOM_NSC_INITIAL_SCAN()
                    IF g_nsc_loader_item > NSC_LOADER_TOTAL_ROWS() - 1 g_nsc_loader_item = NSC_LOADER_TOTAL_ROWS() - 1 ENDIF
                    IF g_nsc_loader_item < 0 g_nsc_loader_item = 0 ENDIF
                    g_item = g_nsc_loader_item
                    g_scroll = g_nsc_loader_scroll
                ELIF (g_item = 8 AND g_accent_choice != 14) OR (g_item = 9 AND g_accent_choice = 14)
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_persist_open = TRUE
                    g_item = g_persist_item
                    g_scroll = g_persist_scroll
                ELIF (g_item = 4 AND g_accent_choice != 14) OR (g_item = 5 AND g_accent_choice = 14)
                    g_respawn_at_death = NOT g_respawn_at_death
                ENDIF
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_PLAYER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Portable Radio", "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_god DRAW_OPTION(y, "God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, "Heal + Armour", "APPLY", g_item = index, 2) BREAK
        CASE 3 IF g_invisible DRAW_OPTION(y, "Invisible Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Invisible Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 DRAW_OPTION(y, "PED Changer", "OPEN", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Outfit Customization", "OPEN", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Bodyguards", "OPEN", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Attacker", "OPEN", g_item = index, 2) BREAK
        CASE 8 IF g_player_noclip DRAW_OPTION(y, "Player No-Clip", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Player No-Clip", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 9 IF g_player_freecam DRAW_OPTION(y, "Free Cam", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Free Cam", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_unlimited_oxygen DRAW_OPTION(y, "Unlimited Oxygen", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Oxygen", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_unlimited_ability DRAW_OPTION(y, "Unlimited Ability", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Ability", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_fast_run DRAW_OPTION(y, "Fast Run", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Run", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 IF g_fast_swim DRAW_OPTION(y, "Fast Swim", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Swim", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14 IF g_super_jump DRAW_OPTION(y, "Super Jump", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Super Jump", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 IF g_no_ragdoll DRAW_OPTION(y, "Disable Ragdoll", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Disable Ragdoll", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 IF g_infinite_parachute DRAW_OPTION(y, "Infinite Parachute", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Infinite Parachute", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 DRAW_NUMBER_OPTION(y, "Cash Balance", g_cash_amount, g_item = index) BREAK
        CASE 18 DRAW_OPTION(y, "Apply Cash Balance", "APPLY", g_item = index, 2) BREAK
        CASE 19 IF g_explosive_melee DRAW_OPTION(y, "Explosive Melee", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Explosive Melee", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 20 IF g_super_punch DRAW_OPTION(y, "Super Punch", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Super Punch", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 IF g_drunk DRAW_OPTION(y, "Drunk Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Drunk Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 22 DRAW_OPTION(y, "Clear Damage / Blood", "APPLY", g_item = index, 2) BREAK
        CASE 23 DRAW_OPTION(y, "Suicide", "APPLY", g_item = index, 0) BREAK
        CASE 24 IF g_auto_save DRAW_OPTION(y, "Auto Save", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Save", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 25 DRAW_NUMBER_OPTION(y, "Auto Save Interval", g_auto_save_interval, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_NPC_DENSITY_SELECTOR(FLOAT y, BOOL selected)
    IF g_npc_density_choice = 0 DRAW_OPTION(y, "NPC Density:", "< 0.25x >", selected, 3) ENDIF
    IF g_npc_density_choice = 1 DRAW_OPTION(y, "NPC Density:", "< 0.5x >", selected, 3) ENDIF
    IF g_npc_density_choice = 2 DRAW_OPTION(y, "NPC Density:", "< 1x >", selected, 3) ENDIF
    IF g_npc_density_choice = 3 DRAW_OPTION(y, "NPC Density:", "< 2x >", selected, 3) ENDIF
    IF g_npc_density_choice = 4 DRAW_OPTION(y, "NPC Density:", "< 4x >", selected, 3) ENDIF
ENDPROC

PROC DRAW_MENU_COMBO_SELECTOR(FLOAT y, BOOL selected)
    IF g_menu_combo = 0 DRAW_OPTION(y, "Menu Combo:", "< LB + Down >", selected, 3) ENDIF
    IF g_menu_combo = 1 DRAW_OPTION(y, "Menu Combo:", "< RB + Y >", selected, 3) ENDIF
    IF g_menu_combo = 2 DRAW_OPTION(y, "Menu Combo:", "< LB + Y >", selected, 3) ENDIF
ENDPROC

PROC DRAW_BODYGUARD_MODEL_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Bodyguard PED:", g_guard_ped_name, selected, 2)
ENDPROC

PROC DRAW_BODYGUARD_WEAPON_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_bodyguard_weapon_choice
        CASE 0 DRAW_OPTION(y, "Guard Weapon:", "< Pistol >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Guard Weapon:", "< SMG >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Guard Weapon:", "< Rifle >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Guard Weapon:", "< Shotgun >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Guard Weapon:", "< MG >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BODYGUARD_FORMATION_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_bodyguard_formation_choice
        CASE 0 DRAW_OPTION(y, "Formation:", "< Circle >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Formation:", "< Line >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Formation:", "< Wedge >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BODYGUARD_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Spawn Bodyguard", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_BODYGUARD_MODEL_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_BODYGUARD_WEAPON_SELECTOR(y, g_item = index) BREAK
        CASE 3 DRAW_BODYGUARD_FORMATION_SELECTOR(y, g_item = index) BREAK
        CASE 4 IF g_bodyguard_follow DRAW_OPTION(y, "Follow Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Follow Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_bodyguard_blips DRAW_OPTION(y, "Guard Blips", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Guard Blips", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 IF g_bodyguard_god DRAW_OPTION(y, "God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 DRAW_OPTION(y, "Dismiss All Guards", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BODYGUARD_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "BODYGUARDS")
    DRAW_MENU_VERSION_TAG()
    INT index = g_bodyguard_scroll
    INT row = 0
    WHILE row < 8 AND index < 8
        DRAW_BODYGUARD_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_GUARD_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "BODYGUARD PED")
    DRAW_MENU_VERSION_TAG()
    INT index = g_guard_ped_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_guard_ped_search_not_found
                DRAW_OPTION(y, "PED Search", "NOT FOUND", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, "PED Search", g_guard_ped_name, g_item = index, 2)
            ENDIF
        ELIF index = 1
            DRAW_OPTION(y, "Random PED", "APPLY", g_item = index, 2)
        ELSE
            DRAW_OPTION(y, "PED:", PED_NAME_FOR_CHOICE(index - 2), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_ATTACKER_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "ATTACKER PED")
    DRAW_MENU_VERSION_TAG()
    INT index = g_attacker_ped_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_attacker_ped_search_not_found
                DRAW_OPTION(y, "PED Search", "NOT FOUND", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, "PED Search", g_attacker_ped_name, g_item = index, 2)
            ENDIF
        ELIF index = 1
            DRAW_OPTION(y, "Random PED", "APPLY", g_item = index, 2)
        ELSE
            DRAW_OPTION(y, "PED:", PED_NAME_FOR_CHOICE(index - 2), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_RADIO_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_mobile_radio DRAW_OPTION(y, "Portable Radio", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Portable Radio", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, "Previous Station", "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Next Station", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_RADIO_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PORTABLE RADIO")
    DRAW_MENU_VERSION_TAG()
    INT index = g_radio_scroll
    INT row = 0
    WHILE row < 8 AND index < 3
        DRAW_RADIO_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
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

PROC DRAW_NEON_MODE_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_neon_mode
        CASE 0 DRAW_OPTION(y, "Neon Animation:", "< Off >", selected, 0) BREAK
        CASE 1 DRAW_OPTION(y, "Neon Animation:", "< Flashing >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Neon Animation:", "< Fade >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Neon Animation:", "< RGB Cycle >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Neon Animation:", "< Spin >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Neon Animation:", "< Slide >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Neon Animation:", "< Colour Shift >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_NEON_TRANSITION_SELECTOR(FLOAT y, BOOL selected)
    IF g_neon_transition = 0 DRAW_OPTION(y, "Transition Smoothness:", "< Smooth >", selected, 3) ELSE DRAW_OPTION(y, "Transition Smoothness:", "< Hard >", selected, 3) ENDIF
ENDPROC

PROC DRAW_SPEED_LEVEL_OPTION(FLOAT y, STRING label, INT level, BOOL selected)
    IF level <= 0
        DRAW_OPTION(y, label, "< Stopped >", selected, 0)
    ELIF level = 1
        DRAW_OPTION(y, label, "< 0.25x >", selected, 3)
    ELIF level = 2
        DRAW_OPTION(y, label, "< 0.50x >", selected, 3)
    ELIF level = 3
        DRAW_OPTION(y, label, "< 0.75x >", selected, 3)
    ELIF level = 4
        DRAW_OPTION(y, label, "< 1.00x >", selected, 3)
    ELIF level = 5
        DRAW_OPTION(y, label, "< 1.25x >", selected, 3)
    ELIF level = 6
        DRAW_OPTION(y, label, "< 1.50x >", selected, 3)
    ELIF level = 7
        DRAW_OPTION(y, label, "< 1.75x >", selected, 3)
    ELIF level = 8
        DRAW_OPTION(y, label, "< 2.00x >", selected, 3)
    ELIF level = 9
        DRAW_OPTION(y, label, "< 2.25x >", selected, 3)
    ELIF level = 10
        DRAW_OPTION(y, label, "< 2.50x >", selected, 3)
    ELIF level = 11
        DRAW_OPTION(y, label, "< 2.75x >", selected, 3)
    ELIF level = 12
        DRAW_OPTION(y, label, "< 3.00x >", selected, 3)
    ELIF level = 13
        DRAW_OPTION(y, label, "< 3.25x >", selected, 3)
    ELIF level = 14
        DRAW_OPTION(y, label, "< 3.50x >", selected, 3)
    ELIF level = 15
        DRAW_OPTION(y, label, "< 3.75x >", selected, 3)
    ELIF level = 16
        DRAW_OPTION(y, label, "< 4.00x >", selected, 3)
    ELIF level = 17
        DRAW_OPTION(y, label, "< 4.25x >", selected, 3)
    ELIF level = 18
        DRAW_OPTION(y, label, "< 4.50x >", selected, 3)
    ELIF level = 19
        DRAW_OPTION(y, label, "< 4.75x >", selected, 3)
    ELIF level = 20
        DRAW_OPTION(y, label, "< 5.00x >", selected, 3)
    ELIF level = 21
        DRAW_OPTION(y, label, "< 5.25x >", selected, 3)
    ELIF level = 22
        DRAW_OPTION(y, label, "< 5.50x >", selected, 3)
    ELIF level = 23
        DRAW_OPTION(y, label, "< 5.75x >", selected, 3)
    ELIF level = 24
        DRAW_OPTION(y, label, "< 6.00x >", selected, 3)
    ELIF level = 25
        DRAW_OPTION(y, label, "< 6.25x >", selected, 3)
    ELIF level = 26
        DRAW_OPTION(y, label, "< 6.50x >", selected, 3)
    ELIF level = 27
        DRAW_OPTION(y, label, "< 6.75x >", selected, 3)
    ELIF level = 28
        DRAW_OPTION(y, label, "< 7.00x >", selected, 3)
    ELIF level = 29
        DRAW_OPTION(y, label, "< 7.25x >", selected, 3)
    ELIF level = 30
        DRAW_OPTION(y, label, "< 7.50x >", selected, 3)
    ELIF level = 31
        DRAW_OPTION(y, label, "< 7.75x >", selected, 3)
    ELIF level = 32
        DRAW_OPTION(y, label, "< 8.00x >", selected, 3)
    ELIF level = 33
        DRAW_OPTION(y, label, "< 8.25x >", selected, 3)
    ELIF level = 34
        DRAW_OPTION(y, label, "< 8.50x >", selected, 3)
    ELIF level = 35
        DRAW_OPTION(y, label, "< 8.75x >", selected, 3)
    ELIF level = 36
        DRAW_OPTION(y, label, "< 9.00x >", selected, 3)
    ELIF level = 37
        DRAW_OPTION(y, label, "< 9.25x >", selected, 3)
    ELIF level = 38
        DRAW_OPTION(y, label, "< 9.50x >", selected, 3)
    ELIF level = 39
        DRAW_OPTION(y, label, "< 9.75x >", selected, 3)
    ELSE
        DRAW_OPTION(y, label, "< 10.00x >", selected, 3)
    ENDIF
ENDPROC

PROC DRAW_NEON_SPEED_SELECTOR(FLOAT y, BOOL selected)
    DRAW_SPEED_LEVEL_OPTION(y, "Neon Speed", g_neon_speed_index, selected)
ENDPROC

PROC DRAW_ACCENT_RGB_SPEED_SELECTOR(FLOAT y, BOOL selected)
    DRAW_SPEED_LEVEL_OPTION(y, "Transition Speed", g_accent_rgb_speed_index, selected)
ENDPROC

PROC DRAW_NEON_ANIM_ENTRY(FLOAT y, BOOL selected)
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, "Neon Animation", "No Vehicle", selected, 0)
    ELSE
        DRAW_OPTION(y, "Neon Animation", "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_NEON_ANIM_ROW(INT index, FLOAT y)
    IF g_neon_mode = 3
        SWITCH index
            CASE 0 DRAW_NEON_MODE_SELECTOR(y, g_item = index) BREAK
            CASE 1 DRAW_NEON_SPEED_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_NEON_TRANSITION_SELECTOR(y, g_item = index) BREAK
        ENDSWITCH
    ELSE
        SWITCH index
            CASE 0 DRAW_NEON_MODE_SELECTOR(y, g_item = index) BREAK
            CASE 1 DRAW_LSC_LIGHT_SELECTOR(y, "Underglow Colour", g_lsc_neon_colour, g_item = index) BREAK
            CASE 2 DRAW_NEON_SPEED_SELECTOR(y, g_item = index) BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_NEON_ANIM_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "NEON ANIMATION")
    DRAW_MENU_VERSION_TAG()
    INT index = g_neon_anim_scroll
    INT row = 0
    INT total = 3
    WHILE row < 8 AND index < total
        DRAW_NEON_ANIM_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_VEHICLE_CONTROL_ENTRY(FLOAT y, BOOL selected)
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, "Vehicle Control", "No Vehicle", selected, 0)
    ELSE
        DRAW_OPTION(y, "Vehicle Control", "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_VEHICLE_CONTROL_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0
            IF g_vehicle_window_action = 0 DRAW_OPTION(y, "Windows", "< All Down >", g_item = index, 3) ELSE DRAW_OPTION(y, "Windows", "< All Up >", g_item = index, 3) ENDIF
        BREAK
        CASE 1
            IF g_vehicle_window_choice = 0 DRAW_OPTION(y, "Window", "< Front Left >", g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 1 DRAW_OPTION(y, "Window", "< Front Right >", g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 2 DRAW_OPTION(y, "Window", "< Rear Left >", g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 3 DRAW_OPTION(y, "Window", "< Rear Right >", g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 4 DRAW_OPTION(y, "Window", "< Middle Left >", g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 5 DRAW_OPTION(y, "Window", "< Middle Right >", g_item = index, 3) ENDIF
        BREAK
        CASE 2 DRAW_OPTION(y, "Roll Selected Down", "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Roll Selected Up", "APPLY", g_item = index, 2) BREAK
        CASE 4
            IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
                IF GET_IS_VEHICLE_ENGINE_RUNNING(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) DRAW_OPTION(y, "Engine", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Engine", "OFF", g_item = index, 0) ENDIF
            ELSE
                DRAW_OPTION(y, "Engine", "No Vehicle", g_item = index, 0)
            ENDIF
        BREAK
        CASE 5
            IF g_vehicle_hazards DRAW_OPTION(y, "Hazard Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hazard Lights", "OFF", g_item = index, 0) ENDIF
        BREAK
        CASE 6
            IF g_vehicle_seat_choice = 0 DRAW_OPTION(y, "Switch Seat", "< Driver >", g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 1 DRAW_OPTION(y, "Switch Seat", "< Front Right >", g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 2 DRAW_OPTION(y, "Switch Seat", "< Back Left >", g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 3 DRAW_OPTION(y, "Switch Seat", "< Back Right >", g_item = index, 3) ENDIF
        BREAK
        CASE 7 DRAW_OPTION(y, "Dirt Level", DIRT_LEVEL_VALUE_LABEL(g_vehicle_dirt_level), g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Wash Vehicle", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_CONTROL_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE CONTROL")
    DRAW_MENU_VERSION_TAG()
    INT index = g_vehicle_control_scroll
    INT row = 0
    INT total = 9
    WHILE row < 8 AND index < total
        DRAW_VEHICLE_CONTROL_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_VEHICLE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Vehicle Spawner", "OPEN", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "LS Customs", "OPEN", g_item = index, 2) BREAK
        CASE 2 DRAW_NEON_ANIM_ENTRY(y, g_item = index) BREAK
        CASE 3 DRAW_VEHICLE_CONTROL_ENTRY(y, g_item = index) BREAK
        CASE 4 IF g_vehicle_god DRAW_OPTION(y, "Vehicle God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Vehicle God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_OPTION(y, "Repair Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Max Vehicle Upgrades", "APPLY", g_item = index, 2) BREAK
        CASE 7 IF g_vehicle_always_max DRAW_OPTION(y, "Always Max Upgrades", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Max Upgrades", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_VEHICLE_MULTIPLIER(y, "Acceleration Boost", g_vehicle_acceleration_level, g_item = index) BREAK
        CASE 9 DRAW_VEHICLE_GRIP_SELECTOR(y, g_item = index) BREAK
        CASE 10 IF g_godmode_tow_hook DRAW_OPTION(y, "God Mode Tow-Hook", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode Tow-Hook", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_vehicle_turbo DRAW_OPTION(y, "Turbo Mod", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo Mod", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_vehicle_bulletproof_tyres DRAW_OPTION(y, "Bulletproof Tyres", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Bulletproof Tyres", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 DRAW_OPTION(y, "Flip Vehicle upright", "APPLY", g_item = index, 2) BREAK
        CASE 14 IF g_vehicle_quick_entry_exit DRAW_OPTION(y, "Instant Enter / Exit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Instant Enter / Exit", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 DRAW_OPTION(y, "Enter Personal Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, "Bring Personal Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 17 IF g_vehicle_horn_boost DRAW_OPTION(y, "Horn Boost", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Horn Boost", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 18 IF g_vehicle_auto_repair DRAW_OPTION(y, "Auto Repair Vehicle", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Repair Vehicle", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 19 DRAW_OPTION(y, "Open Plane Cargo / Backdoor", "APPLY", g_item = index, 2) BREAK
        CASE 20 IF g_doors_locked DRAW_OPTION(y, "Lock Doors", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Lock Doors", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 IF g_seatbelt DRAW_OPTION(y, "Always Seatbelt", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Seatbelt", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 22 DRAW_OPTION(y, "Destroy Engine", "APPLY", g_item = index, 2) BREAK
        CASE 23 IF g_vehicle_speedometer DRAW_OPTION(y, "Speedometer", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Speedometer", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 24 IF g_vehicle_speed_unit = 0 DRAW_OPTION(y, "Speed Unit", "< MPH >", g_item = index, 3) ELSE DRAW_OPTION(y, "Speed Unit", "< KMPH >", g_item = index, 3) ENDIF BREAK
        CASE 25 DRAW_CHAUFFEUR_ENTRY(y, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_VEHICLE_SEARCH(FLOAT y, BOOL selected)
    IF g_vehicle_search_not_found
        DRAW_OPTION(y, "Spawn by Model Name", "NOT FOUND", selected, 0)
    ELIF g_vehicle_search_has_value
        DRAW_OPTION(y, "Spawn by Model Name", g_vehicle_search_value, selected, 3)
    ELSE
        DRAW_OPTION(y, "Spawn by Model Name", CURRENT_VEHICLE_SEARCH_LABEL(), selected, 3)
    ENDIF
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
            DRAW_SPAWNER_VEHICLE_SEARCH(y, g_item = index)
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SPAWNER")
    DRAW_MENU_VERSION_TAG()
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
        CASE 0 IF g_skip_cutscenes DRAW_OPTION(y, "Skip Cutscenes", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Skip Cutscenes", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, "Refresh Interior", "APPLY", g_item = index, 2) BREAK
        CASE 2 IF g_npc_brawl DRAW_OPTION(y, "Nearby NPC Brawl", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Nearby NPC Brawl", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_everyone_ignores DRAW_OPTION(y, "Everyone Ignores Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Everyone Ignores Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_low_population DRAW_OPTION(y, "Low Population", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Low Population", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_NPC_DENSITY_SELECTOR(y, g_item = index) BREAK
        CASE 6 DRAW_OPTION(y, "Clear Nearby Vehicles", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Clear Nearby Peds", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Explode All Vehicles", "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_first_person DRAW_OPTION(y, "Force First Person", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Force First Person", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_hud_hidden DRAW_OPTION(y, "Hide HUD", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide HUD", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_radar_hidden DRAW_OPTION(y, "Hide Radar", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide Radar", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 DRAW_STRIPPER_SELECTOR(y, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TELEPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Teleport to Waypoint", "APPLY", g_item = index, 2) BREAK
        CASE 1 IF g_auto_waypoint DRAW_OPTION(y, "Auto Teleport Waypoint", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Teleport Waypoint", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, "Robbable Stores", "OPEN", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Teleport to Objective", "APPLY", g_item = index, 2) BREAK
        CASE 4 IF g_auto_objective DRAW_OPTION(y, "Auto Teleport Objective", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Teleport Objective", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_OPTION(y, "Locations", "OPEN", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Nudge Forward", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Nudge Backward", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Nudge Up", "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Nudge Down", "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_FLOAT_OPTION(y, "Coordinate X", g_teleport_x, g_item = index) BREAK
        CASE 11 DRAW_FLOAT_OPTION(y, "Coordinate Y", g_teleport_y, g_item = index) BREAK
        CASE 12 DRAW_FLOAT_OPTION(y, "Coordinate Z", g_teleport_z, g_item = index) BREAK
        CASE 13 DRAW_OPTION(y, "Teleport to Coordinates", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_STORE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Teleport To Gas Store 1", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Teleport To Gas Store 2", "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Teleport To Gas Store 3", "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Teleport To Gas Store 4", "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Teleport To Gas Store 5", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Teleport To Liquor Store 1", "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Teleport To Liquor Store 2", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Teleport To Liquor Store 3", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Teleport To Liquor Store 4", "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Teleport To Liquor Store 5", "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, "Teleport To Market 1", "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, "Teleport To Market 2", "APPLY", g_item = index, 2) BREAK
        CASE 12 DRAW_OPTION(y, "Teleport To Market 3", "APPLY", g_item = index, 2) BREAK
        CASE 13 DRAW_OPTION(y, "Teleport To Market 4", "APPLY", g_item = index, 2) BREAK
        CASE 14 DRAW_OPTION(y, "Teleport To Market 5", "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, "Teleport To Market 6", "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, "Teleport To Market 7", "APPLY", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, "Teleport To Market 8", "APPLY", g_item = index, 2) BREAK
        CASE 18 DRAW_OPTION(y, "Teleport To Market 9", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_STORES_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "ROBBABLE STORES")
    DRAW_MENU_VERSION_TAG()
    INT index = g_tp_stores_scroll
    INT row = 0
    WHILE row < 8 AND index < 19
        DRAW_TP_STORE_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_TP_LOCATION_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Mount Chiliad", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Maze Bank Tower", "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Los Santos Airport", "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Vinewood Sign", "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Fort Zancudo", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Grove Street", "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Franklin's House", "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Michael's House", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Trevor's Trailer", "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Lester's Warehouse", "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, "Simeon's Dealership", "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, "Hospital", "APPLY", g_item = index, 2) BREAK
        CASE 12 DRAW_OPTION(y, "Police Station", "APPLY", g_item = index, 2) BREAK
        CASE 13 DRAW_OPTION(y, "Ammu-Nation", "APPLY", g_item = index, 2) BREAK
        CASE 14 DRAW_OPTION(y, "Los Santos Customs", "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, "North Yankton", "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, "Cayo Perico", "APPLY", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, "Sandy Shores Airfield", "APPLY", g_item = index, 2) BREAK
        CASE 18 DRAW_OPTION(y, "IAA Building", "APPLY", g_item = index, 2) BREAK
        CASE 19 DRAW_OPTION(y, "Mount Gordo", "APPLY", g_item = index, 2) BREAK
        CASE 20 DRAW_OPTION(y, "Diamond Casino", "APPLY", g_item = index, 2) BREAK
        CASE 21 DRAW_OPTION(y, "Humane Labs", "APPLY", g_item = index, 2) BREAK
        CASE 22 DRAW_OPTION(y, "Bolingbroke Prison", "APPLY", g_item = index, 2) BREAK
        CASE 23 DRAW_OPTION(y, "Paleto Bay", "APPLY", g_item = index, 2) BREAK
        CASE 24 DRAW_OPTION(y, "Cayo Airstrip", "APPLY", g_item = index, 2) BREAK
        CASE 25 DRAW_OPTION(y, "Cayo Main Dock", "APPLY", g_item = index, 2) BREAK
        CASE 26 DRAW_OPTION(y, "Cayo North Dock", "APPLY", g_item = index, 2) BREAK
        CASE 27 DRAW_OPTION(y, "Cayo Mansion", "APPLY", g_item = index, 2) BREAK
        CASE 28 DRAW_OPTION(y, "Cayo Beach Party", "APPLY", g_item = index, 2) BREAK
        CASE 29 DRAW_OPTION(y, "Cayo Control Tower", "APPLY", g_item = index, 2) BREAK
        CASE 30 DRAW_OPTION(y, "Salvage Yard", "APPLY", g_item = index, 2) BREAK
        CASE 31 DRAW_OPTION(y, "Darnell Bros. Chop Shop", "APPLY", g_item = index, 2) BREAK
        CASE 32 DRAW_OPTION(y, "Gunrunning Bunker", "APPLY", g_item = index, 2) BREAK
        CASE 33 DRAW_OPTION(y, "Doomsday Facility", "APPLY", g_item = index, 2) BREAK
        CASE 34 DRAW_OPTION(y, "Dignity Party Yacht", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_LOCATIONS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "LOCATIONS")
    DRAW_MENU_VERSION_TAG()
    INT index = g_tp_locs_scroll
    INT row = 0
    WHILE row < 8 AND index < 35
        DRAW_TP_LOCATION_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
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
    WHILE worldRow < 8 AND worldIndex < 14
        DRAW_WORLD_ROW(worldIndex, 0.268 + (TO_FLOAT(worldRow) * ROW_H))
        worldIndex = worldIndex + 1
        worldRow = worldRow + 1
    ENDWHILE
ENDPROC

PROC DRAW_WEAPON_PAGE()
    IF g_weapon_upgrades_open
        DRAW_WEAPON_UPGRADES_PAGE()
        EXIT
    ENDIF
    INT weaponIndex = g_scroll
    INT weaponRow = 0
    WHILE weaponRow < 8 AND weaponIndex < 9
        FLOAT y = 0.268 + (TO_FLOAT(weaponRow) * ROW_H)
        IF weaponIndex = 0 DRAW_OPTION(y, "Give All Weapons", "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 1 DRAW_MENU_WEAPON_SELECTOR(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 2
            IF g_infinite_ammo DRAW_OPTION(y, "Infinite Ammo", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Infinite Ammo", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 3
            IF g_infinite_clip DRAW_OPTION(y, "Infinite Clip", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Infinite Clip", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 4 DRAW_OPTION(y, "Refill All Ammo", "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 5 DRAW_WEAPON_UPGRADES_ENTRY(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 6
            IF g_explosive_ammo DRAW_OPTION(y, "Explosive Bullets", "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, "Explosive Bullets", "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 7 DRAW_OPTION(y, "Remove Current Weapon", "APPLY", g_item = weaponIndex, 0) ENDIF
        IF weaponIndex = 8 DRAW_OPTION(y, "Remove All Weapons", "APPLY", g_item = weaponIndex, 2) ENDIF
        weaponIndex = weaponIndex + 1
        weaponRow = weaponRow + 1
    ENDWHILE
ENDPROC

PROC DRAW_SPOONER_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Prop Catalog", SPOONER_CATALOG_LABEL(g_spooner_catalog_index), selected, -1) BREAK
        CASE 1 DRAW_OPTION(y, "Custom Model / Hash", SPOONER_CUSTOM_INPUT_LABEL(), selected, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Spawn Selected Prop", SPOONER_SPAWN_STATUS_LABEL(), selected, 2) BREAK
        CASE 3 DRAW_SPOONER_SELECTED_OBJECT_ROW(y, selected) BREAK
        CASE 4 DRAW_SPOONER_METRE_OPTION(y, "Forward Offset", g_spooner_forward_offset, selected) BREAK
        CASE 5 DRAW_SPOONER_METRE_OPTION(y, "Side Offset", g_spooner_side_offset, selected) BREAK
        CASE 6 DRAW_SPOONER_METRE_OPTION(y, "Height Offset", g_spooner_height_offset, selected) BREAK
        CASE 7 DRAW_SPOONER_DEGREE_OPTION(y, "Heading Rotation", "", g_spooner_heading_offset, selected) BREAK
        CASE 8
            IF g_spooner_freeze_pos
                DRAW_OPTION(y, "Freeze Position", "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, "Freeze Position", "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 9
            IF g_spooner_collision
                DRAW_OPTION(y, "Object Collision", "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, "Object Collision", "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 10
            IF g_player_freecam
                DRAW_OPTION(y, "Free Cam", "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, "Free Cam", "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 11 DRAW_OPTION(y, "Snap to Ground", "APPLY", selected, 2) BREAK
        CASE 12 DRAW_OPTION(y, "Attach Target Bone", SPOONER_BONE_CHOICE_LABEL(g_spooner_bone_choice), selected, -1) BREAK
        CASE 13 DRAW_SPOONER_METRE_OPTION(y, "Attach Offset X", g_spooner_attach_x, selected) BREAK
        CASE 14 DRAW_SPOONER_METRE_OPTION(y, "Attach Offset Y", g_spooner_attach_y, selected) BREAK
        CASE 15 DRAW_SPOONER_METRE_OPTION(y, "Attach Offset Z", g_spooner_attach_z, selected) BREAK
        CASE 16 DRAW_SPOONER_ROT_AXIS_ROW(y, selected) BREAK
        CASE 17 DRAW_OPTION(y, "Attach Selected to Player", SPOONER_ATTACH_ACTION_LABEL(), selected, SPOONER_ATTACH_ACTION_STATE()) BREAK
        CASE 18
            IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 4
                DRAW_OPTION(y, "Delete Last Object", "DELETED", selected, 1)
            ELSE
                DRAW_OPTION(y, "Delete Last Object", "APPLY", selected, 0)
            ENDIF
        BREAK
        CASE 19
            IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 5
                DRAW_OPTION(y, "Clear All Spawned Objects", "CLEARED", selected, 1)
            ELSE
                DRAW_OPTION(y, "Clear All Spawned Objects", "APPLY", selected, 0)
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPOONER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "OBJECT SPOONER")
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < SPOONER_MENU_ROWS
        DRAW_SPOONER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_NSC_LOADER_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    TEXT_LABEL_63 rowBadge = ""
    IF index = 0
        rowBadge = FORMAT_NSC_RESCAN_BADGE()
        DRAW_OPTION(y, "Rescan Script Directory", rowBadge, selected, 2)
        EXIT
    ENDIF
    IF index = 1
        rowBadge = FORMAT_NSC_PROBE_BADGE()
        DRAW_OPTION(y, "Probe / Add Custom .nsc", rowBadge, selected, 2)
        EXIT
    ENDIF
    IF index = 2
        DRAW_OPTION(y, "VM Stack Size", NSC_STACK_LABEL_FROM_CHOICE(g_nsc_stack_choice), selected, -1)
        EXIT
    ENDIF
    IF index = 3
        rowBadge = FORMAT_NSC_STOP_ALL_BADGE()
        DRAW_OPTION(y, "Stop All Custom Scripts", rowBadge, selected, 0)
        EXIT
    ENDIF
    INT slot = index - NSC_LOADER_HEADER_ROWS
    INT badgeState = 2
    TEXT_LABEL_63 rowLabel = FORMAT_CUSTOM_NSC_ROW_LABEL(slot)
    rowBadge = FORMAT_CUSTOM_NSC_ROW_BADGE(slot, badgeState)
    DRAW_OPTION(y, rowLabel, rowBadge, selected, badgeState)
ENDPROC

PROC DRAW_NSC_LOADER_PAGE()
    ENSURE_CUSTOM_NSC_INITIAL_SCAN()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CUSTOM NSC LOADER")
    DRAW_MENU_VERSION_TAG()
    INT totalRows = NSC_LOADER_TOTAL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_NSC_LOADER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_MENU_SETTINGS_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    IF index = 0
        DRAW_OPTION(y, "Object Spooner", "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 1
        DRAW_OPTION(y, "Custom NSC Loader", "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 2
        DRAW_ACCENT_SELECTOR(y, selected)
        EXIT
    ENDIF
    IF g_accent_choice = 14
        SWITCH index
            CASE 3 DRAW_ACCENT_RGB_SPEED_SELECTOR(y, selected) BREAK
            CASE 4 DRAW_RESPAWN_SELECTOR(y, selected) BREAK
            CASE 5
                IF g_respawn_at_death DRAW_OPTION(y, "Enable Custom Respawn", "ON", selected, 1) ELSE DRAW_OPTION(y, "Enable Custom Respawn", "OFF", selected, 0) ENDIF
            BREAK
            CASE 6 DRAW_MENU_X_SELECTOR(y, selected) BREAK
            CASE 7 DRAW_MENU_Y_SELECTOR(y, selected) BREAK
            CASE 8 DRAW_MENU_COMBO_SELECTOR(y, selected) BREAK
            CASE 9 DRAW_OPTION(y, "Persistent Settings", "OPEN", selected, 2) BREAK
        ENDSWITCH
    ELSE
        SWITCH index
            CASE 3 DRAW_RESPAWN_SELECTOR(y, selected) BREAK
            CASE 4
                IF g_respawn_at_death DRAW_OPTION(y, "Enable Custom Respawn", "ON", selected, 1) ELSE DRAW_OPTION(y, "Enable Custom Respawn", "OFF", selected, 0) ENDIF
            BREAK
            CASE 5 DRAW_MENU_X_SELECTOR(y, selected) BREAK
            CASE 6 DRAW_MENU_Y_SELECTOR(y, selected) BREAK
            CASE 7 DRAW_MENU_COMBO_SELECTOR(y, selected) BREAK
            CASE 8 DRAW_OPTION(y, "Persistent Settings", "OPEN", selected, 2) BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_MENU_SETTINGS_PAGE()
    INT totalRows = 9
    IF g_accent_choice = 14 totalRows = 10 ENDIF
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_MENU_SETTINGS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
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
    DRAW_MENU_BACKDROP()
    DRAW_RECT(g_menu_x - 0.015, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x - 0.015, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.079, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.085, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    SWITCH g_tab
        CASE 0
            IF g_outfit_open
                DRAW_OUTFIT_PAGE()
            ELIF g_radio_open
                DRAW_RADIO_PAGE()
            ELIF g_bodyguard_open
                IF g_guard_ped_open
                    DRAW_GUARD_PED_PAGE()
                ELSE
                    DRAW_BODYGUARD_PAGE()
                ENDIF
            ELIF g_attacker_open
                IF g_attacker_ped_open
                    DRAW_ATTACKER_PED_PAGE()
                ELSE
                    DRAW_ATTACKER_PAGE()
                ENDIF
            ELIF g_ped_open
                DRAW_PED_PAGE()
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PLAYER SETTINGS")
                DRAW_MENU_VERSION_TAG()
                DRAW_SCROLLING_ROWS(ITEM_COUNT(), 0)
            ENDIF
        BREAK
        CASE 1
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WEAPON SETTINGS")
            DRAW_MENU_VERSION_TAG()
            DRAW_WEAPON_PAGE()
        BREAK
        CASE 2
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WANTED LEVEL SETTINGS")
            DRAW_MENU_VERSION_TAG()
            IF g_never_wanted DRAW_OPTION(0.268, "Never Wanted", "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, "Never Wanted", "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, "Clear Wanted Level", "APPLY", g_item = 1, 2)
            DRAW_WANTED_LEVEL_SELECTOR(0.344, g_item = 2)
            IF g_ignore_police DRAW_OPTION(0.382, "Police Ignore Player", "ON", g_item = 3, 1) ELSE DRAW_OPTION(0.382, "Police Ignore Player", "OFF", g_item = 3, 0) ENDIF
            IF g_dispatch DRAW_OPTION(0.420, "Dispatch Services", "ON", g_item = 4, 1) ELSE DRAW_OPTION(0.420, "Dispatch Services", "OFF", g_item = 4, 0) ENDIF
            IF g_civilian_reports DRAW_OPTION(0.458, "Civilian Reports", "ON", g_item = 5, 1) ELSE DRAW_OPTION(0.458, "Civilian Reports", "OFF", g_item = 5, 0) ENDIF
        BREAK
        CASE 3
            IF g_chauffeur_open
                IF g_chauffeur_armed_open
                    DRAW_CHAUFFEUR_ARMED_PAGE()
                ELIF g_chauffeur_vehicle_open
                    DRAW_CHAUFFEUR_VEHICLE_PAGE()
                ELIF g_chauffeur_ped_open
                    DRAW_CHAUFFEUR_PED_PAGE()
                ELSE
                    DRAW_CHAUFFEUR_PAGE()
                ENDIF
            ELIF g_spawner_open
                DRAW_SPAWNER_PAGE()
            ELIF g_neon_anim_open
                DRAW_NEON_ANIM_PAGE()
            ELIF g_vehicle_control_open
                DRAW_VEHICLE_CONTROL_PAGE()
            ELIF g_hydro_open
                DRAW_HYDRO_PAGE()
            ELIF g_interior_open
                DRAW_INTERIOR_PAGE()
            ELIF g_wheeltyre_open
                DRAW_WHEELTYRE_PAGE()
            ELIF g_lsc_extras_open
                DRAW_LSC_EXTRAS_PAGE()
            ELIF g_bennys_open
                DRAW_BENNYS_PAGE()
            ELIF g_support_open
                DRAW_SUPPORT_PAGE()
            ELIF g_lsc_open
                DRAW_LSC_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SETTINGS")
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(26, 1)
            ENDIF
        BREAK
        CASE 4
            IF g_timeweather_open
                DRAW_TIMEWEATHER_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WORLD AND WEATHER")
            DRAW_MENU_VERSION_TAG()
            DRAW_WORLD_PAGE()
            ENDIF
        BREAK
        CASE 5
            IF g_tp_stores_open
                DRAW_TP_STORES_PAGE()
            ELIF g_tp_locs_open
                DRAW_TP_LOCATIONS_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "TELEPORT LOCATIONS")
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(14, 3)
            ENDIF
        BREAK
        CASE 6
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "MISC AND NPC")
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(MISC_MENU_ROWS, 2)
        BREAK
        CASE 7
            IF g_spooner_open
                DRAW_SPOONER_PAGE()
            ELIF g_nsc_loader_open
                DRAW_NSC_LOADER_PAGE()
            ELIF g_persist_open
                DRAW_PERSIST_PAGE()
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "MENU SETTINGS")
                DRAW_MENU_VERSION_TAG()
                DRAW_MENU_SETTINGS_PAGE()
            ENDIF
        BREAK
    ENDSWITCH
    DRAW_PAGE_COUNTER()
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
ENDPROC
