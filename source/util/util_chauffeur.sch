FUNC MODEL_NAMES CHAUFFEUR_VEHICLE_MODEL(INT choice)
    SWITCH choice
        CASE 0 RETURN GRANGER BREAK
        CASE 1 RETURN CAVALCADE BREAK
        CASE 2 RETURN CAVALCADE2 BREAK
        CASE 3 RETURN BALLER2 BREAK
        CASE 4 RETURN PATRIOT BREAK
        CASE 5 RETURN ROCOTO BREAK
        CASE 6 RETURN SEMINOLE BREAK
        CASE 7 RETURN LANDSTALKER BREAK
        CASE 8 RETURN DUBSTA BREAK
        CASE 9 RETURN STRETCH BREAK
        CASE 10 RETURN SCHAFTER2 BREAK
        CASE 11 RETURN WASHINGTON BREAK
        CASE 12 RETURN FELON BREAK
        CASE 13 RETURN ORACLE BREAK
    ENDSWITCH
    RETURN GRANGER
ENDFUNC

FUNC STRING CHAUFFEUR_VEHICLE_NAME(INT choice)
    SWITCH choice
        CASE 0 RETURN "Granger" BREAK
        CASE 1 RETURN "Cavalcade" BREAK
        CASE 2 RETURN "Cavalcade 2" BREAK
        CASE 3 RETURN "Baller 2" BREAK
        CASE 4 RETURN "Patriot" BREAK
        CASE 5 RETURN "Rocoto" BREAK
        CASE 6 RETURN "Seminole" BREAK
        CASE 7 RETURN "Landstalker" BREAK
        CASE 8 RETURN "Dubsta" BREAK
        CASE 9 RETURN "Stretch Limo" BREAK
        CASE 10 RETURN "Schafter 2" BREAK
        CASE 11 RETURN "Washington" BREAK
        CASE 12 RETURN "Felon" BREAK
        CASE 13 RETURN "Oracle" BREAK
    ENDSWITCH
    RETURN "Granger"
ENDFUNC

FUNC INT CHAUFFEUR_VEHICLE_CHOICE_FOR_MODEL(MODEL_NAMES model)
    INT choice = 0
    WHILE choice < CHAUFFEUR_VEHICLE_COUNT
        IF CHAUFFEUR_VEHICLE_MODEL(choice) = model RETURN choice ENDIF
        choice = choice + 1
    ENDWHILE
    RETURN -1
ENDFUNC

PROC REFRESH_CHAUFFEUR_DRIVING_MODE()
    IF g_chauffeur_style = 1
        g_chauffeur_driving_mode = DF_SwerveAroundAllCars|DF_StopForPeds|DF_ChangeLanesAroundObstructions|DF_StopForCars|DF_ForceJoinInRoadDirection|DF_SteerAroundObjects|DF_UseSwitchedOffNodes|DF_UseShortCutLinks|DF_AvoidRestrictedAreas|DF_UseWanderFallbackInsteadOfStraightLine
        EXIT
    ENDIF
    IF g_chauffeur_ignore_lights
        g_chauffeur_driving_mode = DF_SteerAroundStationaryCars|DF_StopForPeds|DF_ChangeLanesAroundObstructions|DF_StopForCars|DF_ForceJoinInRoadDirection|DF_SteerAroundObjects|DF_UseSwitchedOffNodes|DF_AvoidRestrictedAreas|DF_UseWanderFallbackInsteadOfStraightLine
    ELSE
        g_chauffeur_driving_mode = DF_SteerAroundStationaryCars|DF_StopForPeds|DF_StopAtLights|DF_ChangeLanesAroundObstructions|DF_StopForCars|DF_ForceJoinInRoadDirection|DF_SteerAroundObjects|DF_UseSwitchedOffNodes|DF_AvoidRestrictedAreas|DF_UseWanderFallbackInsteadOfStraightLine
    ENDIF
ENDPROC

FUNC FLOAT CHAUFFEUR_CRUISE_SPEED()
    IF g_chauffeur_style = 1 RETURN CHAUFFEUR_SPEED_RUSHED ENDIF
    RETURN CHAUFFEUR_SPEED_NORMAL
ENDFUNC

FUNC BOOL CHAUFFEUR_DRIVER_ALIVE()
    IF NOT DOES_ENTITY_EXIST(g_chauffeur_driver) RETURN FALSE ENDIF
    IF IS_ENTITY_DEAD(g_chauffeur_driver) RETURN FALSE ENDIF
    IF IS_PED_INJURED(g_chauffeur_driver) RETURN FALSE ENDIF
    RETURN TRUE
ENDFUNC

FUNC BOOL CHAUFFEUR_VEHICLE_ALIVE()
    IF NOT DOES_ENTITY_EXIST(g_chauffeur_vehicle) RETURN FALSE ENDIF
    IF IS_ENTITY_DEAD(g_chauffeur_vehicle) RETURN FALSE ENDIF
    RETURN TRUE
ENDFUNC

FUNC BOOL CHAUFFEUR_DRIVER_HAS_TASK(SCRIPT_TASK_NAME task)
    IF NOT CHAUFFEUR_DRIVER_ALIVE() RETURN FALSE ENDIF
    IF GET_SCRIPT_TASK_STATUS(g_chauffeur_driver, task) = PERFORMING_TASK RETURN TRUE ENDIF
    IF GET_SCRIPT_TASK_STATUS(g_chauffeur_driver, task) = WAITING_TO_START_TASK RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

PROC ISSUE_CHAUFFEUR_DRIVE_TASK()
    IF NOT CHAUFFEUR_VEHICLE_ALIVE() EXIT ENDIF
    IF NOT CHAUFFEUR_DRIVER_ALIVE() EXIT ENDIF
    IF GET_PED_IN_VEHICLE_SEAT(g_chauffeur_vehicle, VS_DRIVER) != g_chauffeur_driver EXIT ENDIF
    IF IS_WAYPOINT_ACTIVE()
        BLIP_INDEX waypointBlip = GET_FIRST_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID())
        IF waypointBlip != NULL
            VECTOR waypointPosition = GET_BLIP_COORDS(waypointBlip)
            TASK_VEHICLE_DRIVE_TO_COORD(g_chauffeur_driver, g_chauffeur_vehicle, waypointPosition, CHAUFFEUR_CRUISE_SPEED(), DRIVINGSTYLE_NORMAL, GET_ENTITY_MODEL(g_chauffeur_vehicle), g_chauffeur_driving_mode, CHAUFFEUR_TARGET_RADIUS, CHAUFFEUR_TARGET_RADIUS)
            EXIT
        ENDIF
    ENDIF
    TASK_VEHICLE_DRIVE_WANDER(g_chauffeur_driver, g_chauffeur_vehicle, CHAUFFEUR_CRUISE_SPEED(), g_chauffeur_driving_mode)
ENDPROC

PROC APPLY_CHAUFFEUR_EXTRAS()
    IF CHAUFFEUR_DRIVER_ALIVE() SET_ENTITY_INVINCIBLE(g_chauffeur_driver, g_chauffeur_god) ENDIF
    IF CHAUFFEUR_VEHICLE_ALIVE()
        SET_VEHICLE_TYRES_CAN_BURST(g_chauffeur_vehicle, NOT g_chauffeur_bulletproof_tyres)
    ENDIF
ENDPROC

PROC APPLY_CHAUFFEUR_ARMED_STATE()
    IF NOT CHAUFFEUR_DRIVER_ALIVE() EXIT ENDIF
    IF g_chauffeur_armed
        WEAPON_TYPE weapon = MENU_WEAPON_FOR_CHOICE(g_chauffeur_weapon_choice)
        GIVE_WEAPON_TO_PED(g_chauffeur_driver, weapon, 9999, TRUE, TRUE)
        SET_PED_RELATIONSHIP_GROUP_HASH(g_chauffeur_driver, RELGROUPHASH_PLAYER)
        SET_PED_FLEE_ATTRIBUTES(g_chauffeur_driver, FA_NEVER_FLEE, TRUE)
        SET_PED_COMBAT_ABILITY(g_chauffeur_driver, CAL_PROFESSIONAL)
        SET_PED_COMBAT_ATTRIBUTES(g_chauffeur_driver, CA_ALWAYS_FIGHT, TRUE)
        SET_PED_CAN_BE_DRAGGED_OUT(g_chauffeur_driver, FALSE)
    ELSE
        REMOVE_ALL_PED_WEAPONS(g_chauffeur_driver, FALSE)
        g_chauffeur_armed_target = NULL
    ENDIF
ENDPROC

PROC PROCESS_CHAUFFEUR_ARMED()
    IF NOT g_chauffeur_armed EXIT ENDIF
    IF NOT CHAUFFEUR_DRIVER_ALIVE() EXIT ENDIF
    IF NOT CHAUFFEUR_VEHICLE_ALIVE() EXIT ENDIF
    IF NOT IS_PED_IN_VEHICLE(g_chauffeur_driver, g_chauffeur_vehicle) EXIT ENDIF
    PED_INDEX target
    VECTOR centre = GET_ENTITY_COORDS(g_chauffeur_vehicle)
    IF GET_CLOSEST_PED(centre, CHAUFFEUR_ARMED_RANGE, TRUE, TRUE, target, FALSE, FALSE)
        IF target != NULL
            IF target = g_chauffeur_armed_target EXIT ENDIF
            IF IS_PED_INJURED(target) EXIT ENDIF
            IF IS_PED_IN_VEHICLE(target, g_chauffeur_vehicle) EXIT ENDIF
            g_chauffeur_armed_target = target
            TASK_VEHICLE_SHOOT_AT_PED(g_chauffeur_driver, target)
        ENDIF
    ELSE
        g_chauffeur_armed_target = NULL
    ENDIF
ENDPROC

PROC CLEAR_CHAUFFEUR()
    IF DOES_ENTITY_EXIST(g_chauffeur_driver)
        IF NOT IS_ENTITY_DEAD(g_chauffeur_driver)
            SET_PED_KEEP_TASK(g_chauffeur_driver, FALSE)
        ENDIF
        DELETE_PED(g_chauffeur_driver)
    ENDIF
    g_chauffeur_driver = NULL
    IF DOES_ENTITY_EXIST(g_chauffeur_vehicle) DELETE_VEHICLE(g_chauffeur_vehicle) ENDIF
    g_chauffeur_vehicle = NULL
    g_chauffeur_player_was_in = FALSE
    g_chauffeur_armed_target = NULL
ENDPROC

PROC START_CHAUFFEUR_SPAWN()
    IF g_chauffeur_spawn_pending EXIT ENDIF
    IF g_chauffeur_ped_search_is_custom
        g_pending_chauffeur_ped_model = g_chauffeur_ped_model
    ELSE
        g_pending_chauffeur_ped_model = PED_MODEL_FOR_CHOICE(g_chauffeur_ped_choice)
    ENDIF
    g_pending_chauffeur_vehicle_model = CHAUFFEUR_VEHICLE_MODEL(g_chauffeur_vehicle_choice)
    IF NOT IS_MODEL_IN_CDIMAGE(g_pending_chauffeur_ped_model) OR NOT IS_MODEL_VALID(g_pending_chauffeur_ped_model) EXIT ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(g_pending_chauffeur_vehicle_model) OR NOT IS_MODEL_VALID(g_pending_chauffeur_vehicle_model) EXIT ENDIF
    CLEAR_CHAUFFEUR()
    REFRESH_CHAUFFEUR_DRIVING_MODE()
    REQUEST_MODEL(g_pending_chauffeur_ped_model)
    REQUEST_MODEL(g_pending_chauffeur_vehicle_model)
    g_chauffeur_spawn_pending = TRUE
    g_chauffeur_request_time = GET_GAME_TIMER()
ENDPROC

PROC FINISH_CHAUFFEUR_SPAWN()
    PED_INDEX driver
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 3.5, 0.0>>)
    FLOAT spawnHeading = GET_ENTITY_HEADING(PLAYER_PED_ID())
    VEHICLE_INDEX car = CREATE_VEHICLE(g_pending_chauffeur_vehicle_model, spawnPosition, spawnHeading, FALSE)
    IF NOT DOES_ENTITY_EXIST(car)
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_ped_model)
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_vehicle_model)
        g_chauffeur_spawn_pending = FALSE
        EXIT
    ENDIF
    SET_ENTITY_AS_MISSION_ENTITY(car, TRUE, TRUE)
    SET_VEHICLE_ON_GROUND_PROPERLY(car)
    SET_VEHICLE_COLOURS(car, 0, 0)
    SET_VEHICLE_DIRT_LEVEL(car, 0.0)
    driver = CREATE_PED(PEDTYPE_CIVMALE, g_pending_chauffeur_ped_model, spawnPosition, spawnHeading, FALSE, TRUE)
    IF DOES_ENTITY_EXIST(driver)
        SET_ENTITY_AS_MISSION_ENTITY(driver, TRUE, TRUE)
        SET_PED_INTO_VEHICLE(driver, car, VS_DRIVER)
        SET_DRIVER_ABILITY(driver, 0.5)
        SET_DRIVER_AGGRESSIVENESS(driver, 0.5)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, FALSE)
        SET_PED_KEEP_TASK(driver, TRUE)
        SET_PED_RELATIONSHIP_GROUP_HASH(driver, RELGROUPHASH_PLAYER)
        SET_PED_FLEE_ATTRIBUTES(driver, FA_NEVER_FLEE, TRUE)
        SET_PED_COMBAT_ABILITY(driver, CAL_PROFESSIONAL)
        SET_PED_CAN_BE_DRAGGED_OUT(driver, FALSE)
        SET_ENTITY_INVINCIBLE(driver, g_chauffeur_god)
        g_chauffeur_driver = driver
    ENDIF
    g_chauffeur_vehicle = car
    SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), car, VS_FRONT_RIGHT)
    g_chauffeur_player_was_in = TRUE
    APPLY_CHAUFFEUR_EXTRAS()
    APPLY_CHAUFFEUR_ARMED_STATE()
    ISSUE_CHAUFFEUR_DRIVE_TASK()
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_ped_model)
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_vehicle_model)
    g_chauffeur_spawn_pending = FALSE
ENDPROC

PROC PROCESS_CHAUFFEUR_AUTO_STEP()
    IF NOT g_chauffeur_auto_step EXIT ENDIF
    IF NOT CHAUFFEUR_DRIVER_ALIVE() EXIT ENDIF
    IF NOT CHAUFFEUR_VEHICLE_ALIVE() EXIT ENDIF
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF IS_PED_IN_VEHICLE(playerPed, g_chauffeur_vehicle)
        g_chauffeur_player_was_in = TRUE
        IF NOT IS_PED_IN_VEHICLE(g_chauffeur_driver, g_chauffeur_vehicle) AND NOT IS_PED_GETTING_INTO_A_VEHICLE(g_chauffeur_driver)
            TASK_ENTER_VEHICLE(g_chauffeur_driver, g_chauffeur_vehicle)
        ENDIF
    ELSE
        IF g_chauffeur_player_was_in
            g_chauffeur_player_was_in = FALSE
            IF IS_PED_IN_VEHICLE(g_chauffeur_driver, g_chauffeur_vehicle)
                TASK_LEAVE_VEHICLE(g_chauffeur_driver, g_chauffeur_vehicle)
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC PROCESS_CHAUFFEUR()
    IF g_chauffeur_spawn_pending
        IF HAS_MODEL_LOADED(g_pending_chauffeur_ped_model) AND HAS_MODEL_LOADED(g_pending_chauffeur_vehicle_model)
            FINISH_CHAUFFEUR_SPAWN()
        ELIF GET_GAME_TIMER() > g_chauffeur_request_time + CHAUFFEUR_REQUEST_TIMEOUT_MS
            SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_ped_model)
            SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_chauffeur_vehicle_model)
            g_chauffeur_spawn_pending = FALSE
        ENDIF
        EXIT
    ENDIF
    IF NOT DOES_ENTITY_EXIST(g_chauffeur_vehicle) EXIT ENDIF
    IF NOT CHAUFFEUR_VEHICLE_ALIVE() OR NOT CHAUFFEUR_DRIVER_ALIVE()
        CLEAR_CHAUFFEUR()
        EXIT
    ENDIF
    IF GET_GAME_TIMER() >= g_chauffeur_tick
        g_chauffeur_tick = GET_GAME_TIMER() + CHAUFFEUR_TICK_MS
        APPLY_CHAUFFEUR_EXTRAS()
        PROCESS_CHAUFFEUR_ARMED()
        IF NOT CHAUFFEUR_DRIVER_HAS_TASK(SCRIPT_TASK_VEHICLE_DRIVE_TO_COORD) AND NOT CHAUFFEUR_DRIVER_HAS_TASK(SCRIPT_TASK_VEHICLE_DRIVE_WANDER) AND NOT CHAUFFEUR_DRIVER_HAS_TASK(SCRIPT_TASK_VEHICLE_TEMP_ACTION)
            ISSUE_CHAUFFEUR_DRIVE_TASK()
        ENDIF
    ENDIF
    PROCESS_CHAUFFEUR_AUTO_STEP()
ENDPROC

PROC APPLY_RANDOM_CHAUFFEUR_PED()
    INT attempts = 0
    INT choice = 0
    WHILE attempts < 8
        choice = GET_RANDOM_INT_IN_RANGE(0, PED_CHOICE_COUNT())
        IF IS_MODEL_IN_CDIMAGE(PED_MODEL_FOR_CHOICE(choice)) AND IS_MODEL_VALID(PED_MODEL_FOR_CHOICE(choice))
            g_chauffeur_ped_choice = choice
            g_chauffeur_ped_name = PED_NAME_FOR_CHOICE(choice)
            g_chauffeur_ped_search_is_custom = FALSE
            g_chauffeur_ped_search_not_found = FALSE
            EXIT
        ENDIF
        attempts = attempts + 1
    ENDWHILE
ENDPROC

PROC DRAW_CHAUFFEUR_ENTRY(FLOAT y, BOOL selected)
    IF DOES_ENTITY_EXIST(g_chauffeur_vehicle)
        DRAW_OPTION(y, "Chauffeur", "ACTIVE", selected, 1)
    ELSE
        DRAW_OPTION(y, "Chauffeur", "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_CHAUFFEUR_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Spawn Car & TP In", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Driver PED:", g_chauffeur_ped_name, g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Vehicle:", CHAUFFEUR_VEHICLE_NAME(g_chauffeur_vehicle_choice), g_item = index, 2) BREAK
        CASE 3
            IF g_chauffeur_style = 0 DRAW_OPTION(y, "Driving Style", "< Normal >", g_item = index, 3) ELSE DRAW_OPTION(y, "Driving Style", "< Rushed >", g_item = index, 3) ENDIF
        BREAK
        CASE 4 IF g_chauffeur_ignore_lights DRAW_OPTION(y, "Ignore Traffic Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Ignore Traffic Lights", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_chauffeur_god DRAW_OPTION(y, "Driver God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Driver God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 IF g_chauffeur_bulletproof_tyres DRAW_OPTION(y, "Bulletproof Tires", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Bulletproof Tires", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 7
            IF g_chauffeur_armed DRAW_OPTION(y, "Armed Driver:", MENU_WEAPON_NAME_FOR_CHOICE(g_chauffeur_weapon_choice), g_item = index, 1) ELSE DRAW_OPTION(y, "Armed Driver:", "OFF", g_item = index, 0) ENDIF
        BREAK
        CASE 8 IF g_chauffeur_auto_step DRAW_OPTION(y, "Auto Step-Out / In", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Auto Step-Out / In", "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_CHAUFFEUR_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CHAUFFEUR")
    DRAW_MENU_VERSION_TAG()
    INT index = g_chauffeur_scroll
    INT row = 0
    WHILE row < 8 AND index < CHAUFFEUR_MENU_ROWS
        DRAW_CHAUFFEUR_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_CHAUFFEUR_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CHAUFFEUR PED")
    DRAW_MENU_VERSION_TAG()
    INT index = g_chauffeur_ped_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_chauffeur_ped_search_not_found
                DRAW_OPTION(y, "PED Search", "NOT FOUND", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, "PED Search", g_chauffeur_ped_name, g_item = index, 2)
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

PROC DRAW_CHAUFFEUR_VEHICLE_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CHAUFFEUR VEHICLE")
    DRAW_MENU_VERSION_TAG()
    INT index = g_chauffeur_vehicle_scroll
    INT row = 0
    WHILE row < 8 AND index < CHAUFFEUR_VEHICLE_COUNT
        DRAW_OPTION(0.268 + (TO_FLOAT(row) * ROW_H), "Vehicle:", CHAUFFEUR_VEHICLE_NAME(index), g_item = index, 2)
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_CHAUFFEUR_ARMED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "ARMED DRIVER")
    DRAW_MENU_VERSION_TAG()
    INT index = g_chauffeur_armed_scroll
    INT row = 0
    WHILE row < 8 AND index < MENU_WEAPON_COUNT() + 1
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_chauffeur_armed DRAW_OPTION(y, "Armed Driver", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Armed Driver", "OFF", g_item = index, 0) ENDIF
        ELSE
            DRAW_OPTION(y, "Weapon:", MENU_WEAPON_NAME_FOR_CHOICE(index - 1), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC INIT_CHAUFFEUR_DEFAULTS()
    g_chauffeur_ped_choice = FIND_PED_CHOICE_BY_NAME("S_M_M_BOUNCER_01")
    IF g_chauffeur_ped_choice < 0 g_chauffeur_ped_choice = 0 ENDIF
    g_chauffeur_ped_name = PED_NAME_FOR_CHOICE(g_chauffeur_ped_choice)
    g_chauffeur_ped_model = PED_MODEL_FOR_CHOICE(g_chauffeur_ped_choice)
    g_chauffeur_ped_search_is_custom = FALSE
    g_chauffeur_vehicle_choice = CHAUFFEUR_VEHICLE_CHOICE_FOR_MODEL(GRANGER)
    IF g_chauffeur_vehicle_choice < 0 g_chauffeur_vehicle_choice = 0 ENDIF
    REFRESH_CHAUFFEUR_DRIVING_MODE()
ENDPROC
