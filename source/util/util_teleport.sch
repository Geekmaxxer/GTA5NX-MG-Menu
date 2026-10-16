// Sweeps collision downward to find solid ground and ensure the player entity
// does not drop through unstreamed world geometry into the void.
FUNC BOOL PROBE_GROUND_Z(VECTOR target, FLOAT &outGroundZ)
    VECTOR probe = target
    FLOAT zResult = 0.0
    FLOAT currentZ = 950.0

    // 1. If target has a known 3D elevation (interior, store, mountain, etc.), probe locally first
    IF target.z > 1.0 OR target.z < -1.0
        probe.z = target.z + 1.0
        IF GET_GROUND_Z_FOR_3D_COORD(probe, zResult)
            outGroundZ = zResult
            RETURN TRUE
        ENDIF
        probe.z = target.z + 3.0
        IF GET_GROUND_Z_FOR_3D_COORD(probe, zResult)
            outGroundZ = zResult
            RETURN TRUE
        ENDIF
        probe.z = target.z + 8.0
        IF GET_GROUND_Z_FOR_3D_COORD(probe, zResult)
            outGroundZ = zResult
            RETURN TRUE
        ENDIF
        probe.z = target.z + 0.3
        IF GET_GROUND_Z_FOR_3D_COORD(probe, zResult)
            outGroundZ = zResult
            RETURN TRUE
        ENDIF
    ENDIF

    // 2. Vertical elevation sweep (from high peaks down to sea level and tunnels)
    WHILE currentZ >= -30.0
        probe.z = currentZ
        IF GET_GROUND_Z_FOR_3D_COORD(probe, zResult)
            outGroundZ = zResult
            RETURN TRUE
        ENDIF
        IF currentZ > 200.0
            currentZ = currentZ - 100.0
        ELIF currentZ > 20.0
            currentZ = currentZ - 40.0
        ELSE
            currentZ = currentZ - 20.0
        ENDIF
    ENDWHILE

    RETURN FALSE
ENDFUNC

PROC WARP_PLAYER_TO_COORD(VECTOR target)
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX playerVeh = NULL
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        playerVeh = GET_VEHICLE_PED_IS_IN(playerPed)
        SET_ENTITY_LOAD_COLLISION_FLAG(playerVeh, TRUE)
        SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(playerVeh, TRUE)
        SET_ENTITY_COORDS(playerVeh, target, TRUE, TRUE, TRUE, TRUE)
        SET_VEHICLE_ON_GROUND_PROPERLY(playerVeh)
    ELSE
        SET_ENTITY_LOAD_COLLISION_FLAG(playerPed, TRUE)
        SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(playerPed, TRUE)
        SET_ENTITY_COORDS(playerPed, target, TRUE, TRUE, TRUE, TRUE)
    ENDIF
    REQUEST_COLLISION_AT_COORD(target)
ENDPROC

PROC START_TELEPORT(VECTOR destination)
    VECTOR target = destination
    FLOAT groundZ = 0.0

    // Cancel any prior pending teleport cleanly
    IF g_teleport_pending
        IF IS_NEW_LOAD_SCENE_ACTIVE()
            NEW_LOAD_SCENE_STOP()
        ENDIF
        CLEAR_FOCUS()
        g_teleport_pending = FALSE
    ENDIF

    REQUEST_COLLISION_AT_COORD(target)

    // Check if collision is ALREADY in memory right now!
    IF PROBE_GROUND_Z(target, groundZ)
        IF target.z >= -1.0 AND target.z <= 1.0
            target.z = groundZ + 1.0
        ELIF groundZ > target.z - 2.0 AND groundZ < target.z + 5.0
            target.z = groundZ + 1.0
        ENDIF
        WARP_PLAYER_TO_COORD(target)
        EXIT
    ENDIF

    // Collision is NOT loaded yet. Hold entity safely at origin and stream target in background!
    g_pending_teleport_destination = destination
    g_teleport_request_time = GET_GAME_TIMER()
    g_teleport_pending = TRUE
    SET_FOCUS_POS_AND_VEL(destination, <<0.0, 0.0, 0.0>>)
    LOAD_SCENE(destination)
    IF IS_NEW_LOAD_SCENE_ACTIVE()
        NEW_LOAD_SCENE_STOP()
    ENDIF
    NEW_LOAD_SCENE_START_SPHERE(destination, 200.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
ENDPROC

PROC TELEPORT_PLAYER_FAST(VECTOR destination)
    START_TELEPORT(destination)
ENDPROC

PROC TELEPORT_PLAYER_WITH_VEHICLE(VECTOR destination)
    START_TELEPORT(destination)
ENDPROC

PROC FINISH_PENDING_TELEPORT()
    FLOAT groundZ = 0.0
    VECTOR target = g_pending_teleport_destination
    IF PROBE_GROUND_Z(target, groundZ)
        IF target.z >= -1.0 AND target.z <= 1.0
            target.z = groundZ + 1.0
        ELIF groundZ > target.z - 2.0 AND groundZ < target.z + 5.0
            target.z = groundZ + 1.0
        ENDIF
    ENDIF
    WARP_PLAYER_TO_COORD(target)
    IF IS_NEW_LOAD_SCENE_ACTIVE()
        NEW_LOAD_SCENE_STOP()
    ENDIF
    CLEAR_FOCUS()
    g_teleport_pending = FALSE
ENDPROC

PROC PROCESS_PENDING_TELEPORT()
    IF NOT g_teleport_pending EXIT ENDIF

    IF IS_ENTITY_DEAD(PLAYER_PED_ID())
        IF IS_NEW_LOAD_SCENE_ACTIVE()
            NEW_LOAD_SCENE_STOP()
        ENDIF
        CLEAR_FOCUS()
        g_teleport_pending = FALSE
        EXIT
    ENDIF

    FLOAT groundZ = 0.0
    VECTOR target = g_pending_teleport_destination

    // Keep collision and focus requested
    REQUEST_COLLISION_AT_COORD(target)
    SET_FOCUS_POS_AND_VEL(target, <<0.0, 0.0, 0.0>>)

    // Check if collision has streamed in and ground is confirmed
    IF PROBE_GROUND_Z(target, groundZ)
        IF target.z >= -1.0 AND target.z <= 1.0
            target.z = groundZ + 1.0
        ELIF groundZ > target.z - 2.0 AND groundZ < target.z + 5.0
            target.z = groundZ + 1.0
        ENDIF
        WARP_PLAYER_TO_COORD(target)
        IF IS_NEW_LOAD_SCENE_ACTIVE()
            NEW_LOAD_SCENE_STOP()
        ENDIF
        CLEAR_FOCUS()
        g_teleport_pending = FALSE
        EXIT
    ENDIF

    // Safety timeout: 3500ms max (e.g. open ocean water where no ground collision exists)
    IF GET_GAME_TIMER() > g_teleport_request_time + 3500 OR IS_NEW_LOAD_SCENE_LOADED()
        WARP_PLAYER_TO_COORD(target)
        IF IS_NEW_LOAD_SCENE_ACTIVE()
            NEW_LOAD_SCENE_STOP()
        ENDIF
        CLEAR_FOCUS()
        g_teleport_pending = FALSE
    ENDIF
ENDPROC

FUNC BOOL TELEPORT_TO_BLIP_TYPE(BLIP_SPRITE sprite)
    BLIP_INDEX blip = GET_CLOSEST_BLIP_INFO_ID(sprite)
    IF DOES_BLIP_EXIST(blip)
        // Objective blips are often GPS-only and need not currently appear
        // on the minimap.  Requiring IS_BLIP_ON_MINIMAP blocked those targets.
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

// Mission objective blips use strand/heist/mission sprites the 5-sprite
// sweep never matches, and carry no GPS route until the player waypoints
// them by hand. Walk the sprite enum by index instead: SanScript passes an
// enum-typed value where BLIP_SPRITE is expected, but rejects raw INT, so
// the scan cursor is stepped with INT_TO_ENUM the same way the outfit and
// vehicle code steps PED_COMPONENT and MOD_TYPE.
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

// One-shot per cutscene end: latch while a cutscene is active, then arm a
// single delayed TELEPORT_TO_OBJECTIVE ~1.5s after control returns so the
// new objective blip has spawned. Never runs the 512-entry scan per-frame.
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
        // Move only the vehicle. Warping the seated ped as well pulls it out
        // of its seat, and the game then despawns the vehicle it was bound to
        // (that is what deleted the car on the nudge actions). Same rule as
        // TELEPORT_PLAYER_FAST / FINISH_PENDING_TELEPORT above: either the
        // vehicle or the ped, never both.
        SET_ENTITY_COORDS(occupied, basePosition + worldOffset, TRUE, TRUE, TRUE, TRUE)
    ELSE
        SET_ENTITY_COORDS(playerPed, basePosition + worldOffset, TRUE, TRUE, TRUE, TRUE)
    ENDIF
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
    // Engine clears disables every frame, so this held lock releases the
    // instant No-Clip/Free Cam turns off. FRONTEND_CONTROL enter is never
    // touched, so menu A/select navigation keeps working.
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
    // Cargo planes (Titan/Cargo Plane) use the large rear ramp tuning plus
    // the boot door; bomb-bay planes (Volatol/B-11/etc) use bomb bay doors.
    // Previous build only opened boot + invalid slots 6/7 (SC_MAX_DOORS is
    // 6, so those were no-ops) and never touched the ramp or bomb bays.
    SET_VEHICLE_USES_LARGE_REAR_RAMP(vehicle, TRUE)
    OPEN_BOMB_BAY_DOORS(vehicle)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_BOOT, FALSE, TRUE)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_REAR_LEFT, FALSE, TRUE)
    SET_VEHICLE_DOOR_OPEN(vehicle, SC_DOOR_REAR_RIGHT, FALSE, TRUE)
ENDPROC
