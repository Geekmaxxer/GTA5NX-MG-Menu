PROC TELEPORT_PLAYER_WITH_VEHICLE(VECTOR destination)
    g_pending_teleport_destination = destination
    g_teleport_request_time = GET_GAME_TIMER()
    g_teleport_pending = TRUE
    REQUEST_COLLISION_AT_COORD(destination)
    NEW_LOAD_SCENE_START_SPHERE(destination, 250.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
ENDPROC


PROC TELEPORT_PLAYER_FAST(VECTOR destination)
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        SET_ENTITY_COORDS(GET_VEHICLE_PED_IS_IN(playerPed), destination, TRUE, TRUE, TRUE, TRUE)
    ELSE
        SET_ENTITY_COORDS(playerPed, destination, TRUE, TRUE, TRUE, TRUE)
    ENDIF
    REQUEST_COLLISION_AT_COORD(destination)
ENDPROC

PROC FINISH_PENDING_TELEPORT()
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        SET_ENTITY_COORDS(GET_VEHICLE_PED_IS_IN(playerPed), g_pending_teleport_destination, TRUE, TRUE, TRUE, TRUE)
    ELSE
        SET_ENTITY_COORDS(playerPed, g_pending_teleport_destination, TRUE, TRUE, TRUE, TRUE)
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
        TELEPORT_PLAYER_FAST(GET_BLIP_COORDS(blip))
        RETURN TRUE
    ENDIF
    RETURN FALSE
ENDFUNC

PROC TELEPORT_TO_WAYPOINT()
    IF IS_WAYPOINT_ACTIVE()
        TELEPORT_TO_BLIP_TYPE(GET_WAYPOINT_BLIP_ENUM_ID())
    ENDIF
ENDPROC

FUNC BOOL TELEPORT_TO_GPS_ROUTE_BLIP()
    BLIP_INDEX blip = GET_FIRST_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID())
    INT guard = 0
    WHILE DOES_BLIP_EXIST(blip) AND guard < 128
        IF DOES_BLIP_HAVE_GPS_ROUTE(blip)
            TELEPORT_PLAYER_FAST(GET_BLIP_COORDS(blip))
            RETURN TRUE
        ENDIF
        blip = GET_NEXT_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID())
        guard = guard + 1
    ENDWHILE
    RETURN FALSE
ENDFUNC

FUNC BOOL TELEPORT_TO_ANY_OBJECTIVE_BLIP()
    VECTOR playerPosition = GET_ENTITY_COORDS(PLAYER_PED_ID())
    VECTOR blipPosition = <<0.0, 0.0, 0.0>>
    VECTOR bestPosition = <<0.0, 0.0, 0.0>>
    VECTOR delta = <<0.0, 0.0, 0.0>>
    FLOAT bestDistance = 0.0
    FLOAT distance = 0.0
    BOOL found = FALSE
    BLIP_SPRITE sprite = RADAR_TRACE_OBJECTIVE
    BLIP_INDEX blip = GET_CLOSEST_BLIP_INFO_ID(RADAR_TRACE_OBJECTIVE)
    INT scanned = 0
    WHILE scanned < 512
        sprite = INT_TO_ENUM(BLIP_SPRITE, scanned)
        IF sprite = GET_WAYPOINT_BLIP_ENUM_ID()
            scanned = scanned + 1
        ELSE
            blip = GET_CLOSEST_BLIP_INFO_ID(sprite)
            IF DOES_BLIP_EXIST(blip)
                IF DOES_BLIP_HAVE_GPS_ROUTE(blip)
                    TELEPORT_PLAYER_FAST(GET_BLIP_COORDS(blip))
                    RETURN TRUE
                ENDIF
                blipPosition = GET_BLIP_COORDS(blip)
                delta = blipPosition - playerPosition
                distance = SQRT((delta.x * delta.x) + (delta.y * delta.y) + (delta.z * delta.z))
                IF NOT found OR distance < bestDistance
                    found = TRUE
                    bestDistance = distance
                    bestPosition = blipPosition
                ENDIF
            ENDIF
            scanned = scanned + 1
        ENDIF
    ENDWHILE
    IF found
        TELEPORT_PLAYER_FAST(bestPosition)
        RETURN TRUE
    ENDIF
    RETURN FALSE
ENDFUNC

PROC TELEPORT_TO_OBJECTIVE()
    IF TELEPORT_TO_ANY_OBJECTIVE_BLIP() EXIT ENDIF
    IF TELEPORT_TO_GPS_ROUTE_BLIP() EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_BLUE) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_YELLOW) EXIT ENDIF
    IF TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_GREEN) EXIT ENDIF
    TELEPORT_TO_BLIP_TYPE(RADAR_TRACE_OBJECTIVE_RED)
ENDPROC


PROC PROCESS_AUTO_OBJECTIVE_TELEPORT()
    IF NOT g_auto_objective
        g_auto_objective_was_in_cutscene = FALSE
        g_auto_objective_pending = FALSE
        EXIT
    ENDIF
    IF IS_CUTSCENE_PLAYING() OR IS_CUTSCENE_ACTIVE()
        g_auto_objective_was_in_cutscene = TRUE
        g_auto_objective_pending = FALSE
        EXIT
    ENDIF
    IF g_auto_objective_was_in_cutscene AND NOT g_auto_objective_pending
        g_auto_objective_was_in_cutscene = FALSE
        g_auto_objective_pending = TRUE
        g_auto_objective_tp_time = GET_GAME_TIMER() + 1500
        EXIT
    ENDIF
    IF g_auto_objective_pending AND GET_GAME_TIMER() >= g_auto_objective_tp_time
        g_auto_objective_pending = FALSE
        TELEPORT_TO_OBJECTIVE()
    ENDIF
ENDPROC

PROC TELEPORT_TO_ENTERED_COORDS()
    TELEPORT_PLAYER_FAST(<<g_teleport_x, g_teleport_y, g_teleport_z>>)
ENDPROC

PROC NUDGE_PLAYER_BY_OFFSET(VECTOR offset)
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR basePosition = GET_ENTITY_COORDS(playerPed)
    VECTOR heading = <<0.0, 1.0, 0.0>>
    VECTOR worldOffset = <<0.0, 0.0, 0.0>>
    VEHICLE_INDEX occupied = NULL
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        occupied = GET_VEHICLE_PED_IS_IN(playerPed)
        basePosition = GET_ENTITY_COORDS(occupied)
        heading = GET_ENTITY_FORWARD_VECTOR(occupied)
    ELSE
        heading = GET_ENTITY_FORWARD_VECTOR(playerPed)
    ENDIF
    worldOffset = <<offset.y * heading.x - offset.x * heading.y, offset.y * heading.y + offset.x * heading.x, offset.z>>
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        SET_ENTITY_COORDS(occupied, basePosition + worldOffset, TRUE, TRUE, TRUE, TRUE)
    ENDIF
    SET_ENTITY_COORDS(playerPed, basePosition + worldOffset, TRUE, TRUE, TRUE, TRUE)
    REQUEST_COLLISION_AT_COORD(basePosition + worldOffset)
ENDPROC

PROC REFRESH_STREAMED_ASSETS()
    REFRESH_INTERIOR(GET_INTERIOR_AT_COORDS(GET_ENTITY_COORDS(PLAYER_PED_ID())))
ENDPROC

PROC PROCESS_SKIP_CUTSCENES()
    IF NOT g_skip_cutscenes EXIT ENDIF
    IF IS_CUTSCENE_PLAYING() OR IS_CUTSCENE_ACTIVE()
        STOP_CUTSCENE_IMMEDIATELY()
    ENDIF
ENDPROC

FUNC BOOL NOCLIP_VEHICLE_ENTRY_BLOCKED()
    IF g_player_noclip OR g_player_freecam RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

PROC PROCESS_NOCLIP_VEHICLE_LOCK()
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF NOT NOCLIP_VEHICLE_ENTRY_BLOCKED() EXIT ENDIF
    IF IS_ENTITY_DEAD(playerPed) EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
ENDPROC

PROC BRING_PERSONAL_VEHICLE()
    VEHICLE_INDEX vehicle = GET_PLAYERS_LAST_VEHICLE()
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    IF NOCLIP_VEHICLE_ENTRY_BLOCKED() EXIT ENDIF
    SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), vehicle, VS_DRIVER)
ENDPROC

PROC OPEN_PLANE_CARGO_DOORS()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX vehicle = NULL
    IF NOT IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
    vehicle = GET_VEHICLE_PED_IS_IN(playerPed)
    IF NOT IS_THIS_MODEL_A_PLANE(GET_ENTITY_MODEL(vehicle)) EXIT ENDIF

    SET_VEHICLE_USES_LARGE_REAR_RAMP(vehicle, TRUE)
    OPEN_BOMB_BAY_DOORS(vehicle)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_BOOT, FALSE, TRUE)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_REAR_LEFT, FALSE, TRUE)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_REAR_RIGHT, FALSE, TRUE)
ENDPROC
