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

PROC DRAW_WORLD_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Time & Weather", "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_night_vision DRAW_OPTION(y, "Night Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Night Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 IF g_thermal_vision DRAW_OPTION(y, "Thermal Vision", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Thermal Vision", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_IPL_SELECTOR(y, g_item = index) BREAK
        CASE 4 DRAW_OPTION(y, "Load IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Unload IPL Preset", "APPLY", g_item = index, 2) BREAK
        CASE 6
            IF IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name) DRAW_OPTION(y, "Custom IPL Name", "TYPE NAME", g_item = index, 3)
            ELSE DRAW_OPTION(y, "Custom IPL Name", g_custom_ipl_name, g_item = index, 3) ENDIF
        BREAK
        CASE 7 DRAW_OPTION(y, "Load Custom IPL", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Unload Custom IPL", "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_motion_blur DRAW_OPTION(y, "CCTV Filter", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "CCTV Filter", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_camera_shake DRAW_OPTION(y, "Camera Shake", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Camera Shake", "OFF", g_item = index, 0) ENDIF BREAK
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
    IF g_keyboard_active EXIT ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP)
        MOVE_MENU_CURSOR(-1)
        PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
        g_next_up_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP) AND now >= g_next_up_repeat
        MOVE_MENU_CURSOR(-1)
        PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
        g_next_up_repeat = now + 70
    ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
        MOVE_MENU_CURSOR(1)
        PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
        g_next_down_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN) AND now >= g_next_down_repeat
        MOVE_MENU_CURSOR(1)
        PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
        g_next_down_repeat = now + 70
    ENDIF

    IF NOT g_home AND IS_SELECTOR_ACTIVE()
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
            ADJUST_SELECTOR(-1)
            PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
            g_next_left_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT) AND now >= g_next_left_repeat
            ADJUST_SELECTOR(-1)
            PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
            g_next_left_repeat = now + 70
        ENDIF
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
            ADJUST_SELECTOR(1)
            PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
            g_next_right_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT) AND now >= g_next_right_repeat
            ADJUST_SELECTOR(1)
            PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
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
    IF g_statman_open
        IF g_item = 0
            MAX_ALL_STATS()
            g_stat_stamina = 100
            g_stat_strength = 100
            g_stat_lung = 100
            g_stat_flying = 100
            g_stat_shooting = 100
            g_stat_stealth = 100
            g_stat_driving = 100
            g_stat_wheelie = 100
        ENDIF
        EXIT
    ENDIF
    IF g_bodyguard_open
        SWITCH g_item
            CASE 0 START_BODYGUARD_SPAWN() BREAK
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
        SWITCH g_item
            CASE 0 START_ATTACKER_SPAWN() BREAK
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
    IF g_neon_anim_open
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
                    g_statman_open = TRUE
                    LOAD_STAT_MANAGER()
                    g_item = g_statman_item
                    g_scroll = g_statman_scroll
                BREAK
                CASE 7
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_bodyguard_open = TRUE
                    g_item = g_bodyguard_item
                    g_scroll = g_bodyguard_scroll
                BREAK
                CASE 8
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_attacker_open = TRUE
                    g_item = g_attacker_item
                    g_scroll = g_attacker_scroll
                BREAK
                CASE 9 SET_PLAYER_NOCLIP_ENABLED(NOT g_player_noclip) BREAK
                CASE 10 SET_PLAYER_FREECAM_ENABLED(NOT g_player_freecam) BREAK
                CASE 11
                    g_unlimited_oxygen = NOT g_unlimited_oxygen
                    APPLY_UNLIMITED_OXYGEN()
                BREAK
                CASE 12
                    g_unlimited_ability = NOT g_unlimited_ability
                    APPLY_UNLIMITED_ABILITY()
                BREAK
                CASE 13
                    g_fast_run = NOT g_fast_run
                BREAK
                CASE 14
                    g_fast_swim = NOT g_fast_swim
                BREAK
                CASE 15
                    g_super_jump = NOT g_super_jump
                BREAK
                CASE 16
                    g_no_ragdoll = NOT g_no_ragdoll
                    SET_PED_CAN_RAGDOLL(playerPed, NOT g_no_ragdoll)
                BREAK
                CASE 17 g_infinite_parachute = NOT g_infinite_parachute BREAK
                CASE 18 OPEN_MENU_KEYBOARD(2) BREAK
                CASE 19
                    SWITCH GET_ENTITY_MODEL(playerPed)
                        CASE PLAYER_ZERO STAT_SET_INT(SP0_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_ONE STAT_SET_INT(SP1_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_TWO STAT_SET_INT(SP2_TOTAL_CASH, g_cash_amount) BREAK
                    ENDSWITCH
                BREAK
                CASE 20
                    g_explosive_melee = NOT g_explosive_melee
                BREAK
                CASE 21
                    g_super_punch = NOT g_super_punch
                    g_super_punch_time = 0
                BREAK
                CASE 22
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
                CASE 23 CLEAR_PLAYER_DAMAGE_MARKS() BREAK
                CASE 24 SET_ENTITY_HEALTH(playerPed, 0) BREAK
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
                        CASE 1 APPLY_LSC_STOCK() BREAK
                        CASE 3 APPLY_LSC_MOD() BREAK
                        CASE 10
                            g_lsc_turbo = NOT g_lsc_turbo
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_lsc_turbo)
                        BREAK
                        CASE 11
                            g_lsc_xenon = NOT g_lsc_xenon
                            SET_VEHICLE_MOD_KIT(playerVehicle, 0)
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
                            IF g_lsc_wheel_type > 9 g_lsc_wheel_type = 0 ENDIF
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
            ELIF g_item = 6
                g_vehicle_always_max = NOT g_vehicle_always_max
            ELIF g_item = 13
                g_vehicle_quick_entry_exit = NOT g_vehicle_quick_entry_exit
                IF g_open
                    IF IS_PED_IN_ANY_VEHICLE(playerPed)
                        CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
                        TASK_LEAVE_ANY_VEHICLE(playerPed, 0, ECF_WARP_PED | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP)
                    ELSE
                        PROCESS_QUICK_VEHICLE_ENTRY_EXIT_FROM_MENU(playerPed)
                    ENDIF
                ENDIF
            ELIF g_item = 13
                WARP_INTO_LAST_PLAYER_VEHICLE()
            ELIF g_item = 5
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(playerPed))
                ENDIF
            ELIF g_item = 22
                g_vehicle_speedometer = NOT g_vehicle_speedometer
            ELIF g_item = 23
                g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
            ELIF g_item = 15
                BRING_PERSONAL_VEHICLE()
            ELIF g_item = 16
                g_vehicle_horn_boost = NOT g_vehicle_horn_boost
            ELIF g_item = 17
                g_vehicle_auto_repair = NOT g_vehicle_auto_repair
            ELIF g_item = 18
                OPEN_PLANE_CARGO_DOORS()
            ELIF g_item = 19
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    g_doors_locked = NOT g_doors_locked
                    IF g_doors_locked
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_LOCKED)
                    ELSE
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_UNLOCKED)
                    ENDIF
                ENDIF
            ELIF g_item = 20
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
            ELIF g_item = 21
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    SET_VEHICLE_ENGINE_HEALTH(GET_VEHICLE_PED_IS_IN(playerPed), -4000.0)
                ENDIF
            ELIF IS_PED_IN_ANY_VEHICLE(playerPed)
                playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                SWITCH g_item
                    CASE 3
                        g_vehicle_god = NOT g_vehicle_god
                        APPLY_VEHICLE_GOD_STATE(playerVehicle, g_vehicle_god)
                    BREAK
                    CASE 4
                        SET_VEHICLE_FIXED(playerVehicle)
                        SET_VEHICLE_ENGINE_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_PETROL_TANK_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_BODY_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_UNDRIVEABLE(playerVehicle, FALSE)
                    BREAK
                    CASE 12 SET_VEHICLE_ON_GROUND_PROPERLY(playerVehicle) BREAK
                    CASE 7 BREAK
                    CASE 8 BREAK
                    CASE 9
                        g_godmode_tow_hook = NOT g_godmode_tow_hook
                        IF NOT g_godmode_tow_hook
                            g_tow_hook_vehicle = NULL
                            g_tow_hook_towed = NULL
                        ENDIF
                    BREAK
                    CASE 11 g_vehicle_bulletproof_tyres = NOT g_vehicle_bulletproof_tyres BREAK
                    CASE 10
                        g_vehicle_turbo = NOT g_vehicle_turbo
                        SET_VEHICLE_MOD_KIT(playerVehicle, 0)
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
                CASE 9
                    g_motion_blur = NOT g_motion_blur
                    IF g_motion_blur
                        SET_TIMECYCLE_MODIFIER("scanline_cam_cheap")
                    ELSE
                        CLEAR_TIMECYCLE_MODIFIER()
                    ENDIF
                BREAK
                CASE 10
                    g_camera_shake = NOT g_camera_shake
                    IF g_camera_shake
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.5)
                    ELSE
                        STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                    ENDIF
                BREAK
                CASE 4 APPLY_IPL_PRESET(TRUE) BREAK
                CASE 5 APPLY_IPL_PRESET(FALSE) BREAK
                CASE 6 OPEN_MENU_KEYBOARD(8) BREAK
                CASE 7 LOAD_CUSTOM_IPL() BREAK
                CASE 8 UNLOAD_CUSTOM_IPL() BREAK
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
                CASE 15
                    PREPARE_TELEPORT_IPL(14)
                    TELEPORT_PLAYER_WITH_VEHICLE(<<-449.7, -340.7, 34.5>>)
                BREAK
                CASE 16 TELEPORT_PLAYER_FAST(<<425.1, -979.5, 30.7>>) BREAK
                CASE 17 TELEPORT_PLAYER_FAST(<<-662.1, -948.5, 21.5>>) BREAK
                CASE 18 TELEPORT_PLAYER_FAST(<<-365.4, -131.4, 37.9>>) BREAK
                CASE 19 TELEPORT_TO_NORTH_YANKTON() BREAK
                CASE 20 TELEPORT_TO_CAYO_PERICO() BREAK
                CASE 21 TELEPORT_PLAYER_FAST(<<1692.0, 3291.0, 41.0>>) BREAK
                CASE 22 TELEPORT_PLAYER_FAST(<<-438.0, 1076.0, 327.0>>) BREAK
                CASE 23 TELEPORT_PLAYER_FAST(<<-1170.0, 4927.0, 224.0>>) BREAK
                CASE 24 TELEPORT_PLAYER_FAST(<<1110.0, 220.0, -49.0>>) BREAK
                CASE 25 TELEPORT_PLAYER_FAST(<<3615.2, 3744.7, 28.7>>) BREAK
                CASE 26 TELEPORT_PLAYER_FAST(<<1690.0, 2565.0, 45.6>>) BREAK
                CASE 27 TELEPORT_PLAYER_FAST(<<-119.0, 6455.0, 31.4>>) BREAK
                CASE 28
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4439.0, -4458.0, 4.2>>) ENDIF
                BREAK
                CASE 29
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4964.0, -5164.0, 0.2>>) ENDIF
                BREAK
                CASE 30
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<5040.0, -5784.0, 17.8>>) ENDIF
                BREAK
                CASE 31
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4990.0, -5710.0, 19.9>>) ENDIF
                BREAK
                CASE 32
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4902.0, -4929.0, 3.3>>) ENDIF
                BREAK
                CASE 33
                    IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4441.0, -4440.0, 8.2>>) ENDIF
                BREAK
                CASE 34 TELEPORT_PLAYER_FAST(<<-424.2, -1685.8, 19.0>>) BREAK
                CASE 35 TELEPORT_PLAYER_FAST(<<-81.1, -1395.3, 29.3>>) BREAK
                CASE 36
                    PREPARE_TELEPORT_IPL(40)
                    TELEPORT_PLAYER_WITH_VEHICLE(<<848.7, 3004.0, 45.6>>)
                BREAK
                CASE 37 TELEPORT_PLAYER_FAST(<<-1163.2, -2866.0, 13.9>>) BREAK
                CASE 38
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
                    CASE 6 NUDGE_PLAYER_BY_OFFSET(<<0.0, -1.0, 0.0>>) BREAK
                    CASE 7 NUDGE_PLAYER_BY_OFFSET(<<0.0, 1.0, 0.0>>) BREAK
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
                CASE 7 CLEAR_AREA_OF_VEHICLES(GET_ENTITY_COORDS(playerPed), 50.0) BREAK
                CASE 8
                    CLEAR_AREA_OF_PEDS(GET_ENTITY_COORDS(playerPed), 50.0)
                    CLEAR_MENU_ATTACKERS()
                BREAK
                CASE 9 EXPLODE_ALL_NEARBY_VEHICLES() BREAK
                CASE 10
                    g_first_person = NOT g_first_person
                    IF NOT g_first_person g_player_freecam = FALSE ENDIF
                BREAK
                CASE 11 g_hud_hidden = NOT g_hud_hidden BREAK
                CASE 12 g_radar_hidden = NOT g_radar_hidden BREAK
            ENDSWITCH
        BREAK
        CASE 7
            SWITCH g_item
                CASE 2 g_respawn_at_death = NOT g_respawn_at_death BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
ENDPROC

FUNC INT PAGE_COUNT()
    RETURN 8
ENDFUNC

PROC DRAW_PLAYER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Portable Radio", "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_god DRAW_OPTION(y, "God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, "Heal + Armour", "APPLY", g_item = index, 2) BREAK
        CASE 3 IF g_invisible DRAW_OPTION(y, "Invisible Player", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Invisible Player", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 DRAW_OPTION(y, "PED Changer", "OPEN", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Outfit Customization", "OPEN", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Stat Manager", "OPEN", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Bodyguards", "OPEN", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Attacker", "OPEN", g_item = index, 2) BREAK
        CASE 9 IF g_player_noclip DRAW_OPTION(y, "Player No-Clip", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Player No-Clip", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_player_freecam DRAW_OPTION(y, "Free Cam", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Free Cam", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_unlimited_oxygen DRAW_OPTION(y, "Unlimited Oxygen", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Oxygen", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_unlimited_ability DRAW_OPTION(y, "Unlimited Ability", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Unlimited Ability", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 IF g_fast_run DRAW_OPTION(y, "Fast Run", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Run", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14 IF g_fast_swim DRAW_OPTION(y, "Fast Swim", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Fast Swim", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 IF g_super_jump DRAW_OPTION(y, "Super Jump", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Super Jump", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 IF g_no_ragdoll DRAW_OPTION(y, "Disable Ragdoll", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Disable Ragdoll", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 IF g_infinite_parachute DRAW_OPTION(y, "Infinite Parachute", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Infinite Parachute", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 18 DRAW_NUMBER_OPTION(y, "Cash Balance", g_cash_amount, g_item = index) BREAK
        CASE 19 DRAW_OPTION(y, "Apply Cash Balance", "APPLY", g_item = index, 2) BREAK
        CASE 20 IF g_explosive_melee DRAW_OPTION(y, "Explosive Melee", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Explosive Melee", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 IF g_super_punch DRAW_OPTION(y, "Super Punch", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Super Punch", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 22 IF g_drunk DRAW_OPTION(y, "Drunk Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Drunk Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 23 DRAW_OPTION(y, "Clear Damage / Blood", "APPLY", g_item = index, 2) BREAK
        CASE 24 DRAW_OPTION(y, "Suicide", "APPLY", g_item = index, 0) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_STAT_LEVEL_ROW(FLOAT y, STRING label, INT value, BOOL selected)
    IF value <= 0
        DRAW_OPTION(y, label, "< 0 >", selected, 3)
    ELIF value < 100
        DRAW_NUMBER_OPTION(y, label, value, selected)
    ELSE
        DRAW_OPTION(y, label, "< MAX >", selected, 3)
    ENDIF
ENDPROC

PROC DRAW_STATMAN_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Max All Stats", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_STAT_LEVEL_ROW(y, "Stamina", g_stat_stamina, g_item = index) BREAK
        CASE 2 DRAW_STAT_LEVEL_ROW(y, "Strength", g_stat_strength, g_item = index) BREAK
        CASE 3 DRAW_STAT_LEVEL_ROW(y, "Lung Capacity", g_stat_lung, g_item = index) BREAK
        CASE 4 DRAW_STAT_LEVEL_ROW(y, "Flying", g_stat_flying, g_item = index) BREAK
        CASE 5 DRAW_STAT_LEVEL_ROW(y, "Shooting", g_stat_shooting, g_item = index) BREAK
        CASE 6 DRAW_STAT_LEVEL_ROW(y, "Stealth", g_stat_stealth, g_item = index) BREAK
        CASE 7 DRAW_STAT_LEVEL_ROW(y, "Driving", g_stat_driving, g_item = index) BREAK
        CASE 8 DRAW_STAT_LEVEL_ROW(y, "Special", g_stat_wheelie, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_STATMAN_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "STAT MANAGER")
    DRAW_MENU_VERSION_TAG()
    INT index = g_statman_scroll
    INT row = 0
    WHILE row < 8 AND index < 9
        DRAW_STATMAN_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
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
    SWITCH g_bodyguard_model_choice
        CASE 0 DRAW_OPTION(y, "Guard Model:", "< Michael >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Guard Model:", "< Franklin >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Guard Model:", "< Trevor >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Guard Model:", "< Random >", selected, 3) BREAK
    ENDSWITCH
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

PROC DRAW_VEHICLE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Vehicle Spawner", "OPEN", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "LS Customs", "OPEN", g_item = index, 2) BREAK
        CASE 2 DRAW_NEON_ANIM_ENTRY(y, g_item = index) BREAK
        CASE 3 IF g_vehicle_god DRAW_OPTION(y, "Vehicle God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Vehicle God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 DRAW_OPTION(y, "Repair Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Max Vehicle Upgrades", "APPLY", g_item = index, 2) BREAK
        CASE 6 IF g_vehicle_always_max DRAW_OPTION(y, "Always Max Upgrades", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Max Upgrades", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7 DRAW_VEHICLE_MULTIPLIER(y, "Acceleration Boost", g_vehicle_acceleration_level, g_item = index) BREAK
        CASE 8 DRAW_VEHICLE_GRIP_SELECTOR(y, g_item = index) BREAK
        CASE 9 IF g_godmode_tow_hook DRAW_OPTION(y, "God Mode Tow-Hook", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode Tow-Hook", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_vehicle_turbo DRAW_OPTION(y, "Turbo Mod", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo Mod", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_vehicle_bulletproof_tyres DRAW_OPTION(y, "Bulletproof Tyres", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Bulletproof Tyres", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 DRAW_OPTION(y, "Flip Vehicle upright", "APPLY", g_item = index, 2) BREAK
        CASE 13 IF g_vehicle_quick_entry_exit DRAW_OPTION(y, "Instant Enter / Exit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Instant Enter / Exit", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14 DRAW_OPTION(y, "Enter Personal Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, "Bring Personal Vehicle", "APPLY", g_item = index, 2) BREAK
        CASE 16 IF g_vehicle_horn_boost DRAW_OPTION(y, "Horn Boost", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Horn Boost", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 IF g_vehicle_auto_repair DRAW_OPTION(y, "Auto Repair Vehicle", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Repair Vehicle", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 18 DRAW_OPTION(y, "Open Plane Cargo / Backdoor", "APPLY", g_item = index, 2) BREAK
        CASE 19 IF g_doors_locked DRAW_OPTION(y, "Lock Doors", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Lock Doors", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 20 IF g_seatbelt DRAW_OPTION(y, "Always Seatbelt", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Always Seatbelt", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 DRAW_OPTION(y, "Destroy Engine", "APPLY", g_item = index, 2) BREAK
        CASE 22 IF g_vehicle_speedometer DRAW_OPTION(y, "Speedometer", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Speedometer", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 23 IF g_vehicle_speed_unit = 0 DRAW_OPTION(y, "Speed Unit", "< MPH >", g_item = index, 3) ELSE DRAW_OPTION(y, "Speed Unit", "< KMPH >", g_item = index, 3) ENDIF BREAK
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
        CASE 6 DRAW_VEHICLE_MULTIPLIER(y, "NPC Vehicle Speed", g_npc_vehicle_speed_level, g_item = index) BREAK
        CASE 7 DRAW_OPTION(y, "Clear Nearby Vehicles", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Clear Nearby Peds", "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Explode All Vehicles", "APPLY", g_item = index, 2) BREAK
        CASE 10 IF g_first_person DRAW_OPTION(y, "Force First Person", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Force First Person", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_hud_hidden DRAW_OPTION(y, "Hide HUD", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide HUD", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_radar_hidden DRAW_OPTION(y, "Hide Radar", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hide Radar", "OFF", g_item = index, 0) ENDIF BREAK
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
        CASE 14 DRAW_LSC_WINDOW_TINT_SELECTOR(y, g_item = index) BREAK
        CASE 15 DRAW_LSC_PLATE_ROW(y, g_item = index) BREAK
        CASE 16 DRAW_OPTION(y, "Apply Plate Text", "APPLY", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
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
    WHILE worldRow < 8 AND worldIndex < 11
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
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.076, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.082, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    SWITCH g_tab
        CASE 0
            IF g_outfit_open
                DRAW_OUTFIT_PAGE()
            ELIF g_radio_open
                DRAW_RADIO_PAGE()
            ELIF g_bodyguard_open
                DRAW_BODYGUARD_PAGE()
            ELIF g_attacker_open
                DRAW_ATTACKER_PAGE()
            ELIF g_ped_open
                DRAW_PED_PAGE()
            ELIF g_statman_open
                DRAW_STATMAN_PAGE()
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PLAYER SETTINGS")
                DRAW_MENU_VERSION_TAG()
                DRAW_SCROLLING_ROWS(25, 0)
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
            IF g_spawner_open
                DRAW_SPAWNER_PAGE()
            ELIF g_neon_anim_open
                DRAW_NEON_ANIM_PAGE()
            ELIF g_lsc_open
                DRAW_LSC_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SETTINGS")
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(25, 1)
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
            DRAW_SCROLLING_ROWS(13, 2)
        BREAK
        CASE 7
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "MENU SETTINGS")
            DRAW_MENU_VERSION_TAG()
            DRAW_ACCENT_SELECTOR(0.268, g_item = 0)
            IF g_accent_choice = 14
                DRAW_ACCENT_RGB_SPEED_SELECTOR(0.306, g_item = 1)
                DRAW_RESPAWN_SELECTOR(0.344, g_item = 2)
                IF g_respawn_at_death DRAW_OPTION(0.382, "Enable Custom Respawn", "ON", g_item = 3, 1) ELSE DRAW_OPTION(0.382, "Enable Custom Respawn", "OFF", g_item = 3, 0) ENDIF
                DRAW_MENU_X_SELECTOR(0.420, g_item = 4)
                DRAW_MENU_Y_SELECTOR(0.458, g_item = 5)
                DRAW_MENU_COMBO_SELECTOR(0.496, g_item = 6)
            ELSE
                DRAW_RESPAWN_SELECTOR(0.306, g_item = 1)
                IF g_respawn_at_death DRAW_OPTION(0.344, "Enable Custom Respawn", "ON", g_item = 2, 1) ELSE DRAW_OPTION(0.344, "Enable Custom Respawn", "OFF", g_item = 2, 0) ENDIF
                DRAW_MENU_X_SELECTOR(0.382, g_item = 3)
                DRAW_MENU_Y_SELECTOR(0.420, g_item = 4)
                DRAW_MENU_COMBO_SELECTOR(0.458, g_item = 5)
            ENDIF
        BREAK
    ENDSWITCH
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
ENDPROC
