FUNC MODEL_NAMES SPOONER_CATALOG_MODEL(INT index)
    SWITCH index
        CASE 0  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_work05"))
        CASE 1  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
        CASE 2  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_01"))
        CASE 3  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_02"))
        CASE 4  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_03"))
        CASE 5  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01a"))
        CASE 6  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_exp_01a"))
        CASE 7  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_boxpile_07d"))
        CASE 8  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_01a"))
        CASE 9  RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_fire"))
        CASE 10 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fnclink_02gate1"))
        CASE 11 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_sec_barrier_ld_01a"))
        CASE 12 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_crate_01"))
        CASE 13 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_worklight_03b"))
        CASE 14 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gazebo_02"))
        CASE 15 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_air_lights_02a"))
        CASE 16 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_flatramp"))
        CASE 17 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_alien_egg_01"))
        CASE 18 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_conslift_base"))
        CASE 19 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_soda_01"))
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL(INT index)
    SWITCH index
        CASE 0  RETURN "< Work Barrier >"
        CASE 1  RETURN "< Traffic Cone >"
        CASE 2  RETURN "< Stunt Ramp S >"
        CASE 3  RETURN "< Stunt Ramp M >"
        CASE 4  RETURN "< Stunt Ramp L >"
        CASE 5  RETURN "< Cargo Container >"
        CASE 6  RETURN "< Explosive Barrel >"
        CASE 7  RETURN "< Wooden Crate Pile >"
        CASE 8  RETURN "< Park Bench >"
        CASE 9  RETURN "< Campfire >"
        CASE 10 RETURN "< Chainlink Gate >"
        CASE 11 RETURN "< Security Boom >"
        CASE 12 RETURN "< Military Crate >"
        CASE 13 RETURN "< Floodlight Stand >"
        CASE 14 RETURN "< Gazebo Tent >"
        CASE 15 RETURN "< Runway Light >"
        CASE 16 RETURN "< Skate Ramp >"
        CASE 17 RETURN "< Alien Egg >"
        CASE 18 RETURN "< Lift Base >"
        CASE 19 RETURN "< Soda Machine >"
    ENDSWITCH
    RETURN "< Work Barrier >"
ENDFUNC

PROC COMPACT_SPOONER_POOL()
    INT writeIdx = 0
    INT readIdx = 0
    WHILE readIdx < g_spooner_object_count
        IF DOES_ENTITY_EXIST(g_spooner_objects[readIdx])
            IF writeIdx != readIdx
                g_spooner_objects[writeIdx]       = g_spooner_objects[readIdx]
                g_spooner_obj_fwd[writeIdx]       = g_spooner_obj_fwd[readIdx]
                g_spooner_obj_side[writeIdx]      = g_spooner_obj_side[readIdx]
                g_spooner_obj_height[writeIdx]    = g_spooner_obj_height[readIdx]
                g_spooner_obj_heading[writeIdx]   = g_spooner_obj_heading[readIdx]
                g_spooner_obj_frozen[writeIdx]    = g_spooner_obj_frozen[readIdx]
                g_spooner_obj_collision[writeIdx] = g_spooner_obj_collision[readIdx]
                g_spooner_obj_attached[writeIdx]  = g_spooner_obj_attached[readIdx]
                g_spooner_obj_bone[writeIdx]      = g_spooner_obj_bone[readIdx]
                g_spooner_obj_att_x[writeIdx]     = g_spooner_obj_att_x[readIdx]
                g_spooner_obj_att_y[writeIdx]     = g_spooner_obj_att_y[readIdx]
                g_spooner_obj_att_z[writeIdx]     = g_spooner_obj_att_z[readIdx]
                g_spooner_obj_att_pitch[writeIdx] = g_spooner_obj_att_pitch[readIdx]
                g_spooner_obj_att_roll[writeIdx]  = g_spooner_obj_att_roll[readIdx]
                g_spooner_obj_att_yaw[writeIdx]   = g_spooner_obj_att_yaw[readIdx]
            ENDIF
            writeIdx = writeIdx + 1
        ENDIF
        readIdx = readIdx + 1
    ENDWHILE
    WHILE writeIdx < g_spooner_object_count
        g_spooner_objects[writeIdx] = NULL
        writeIdx = writeIdx + 1
    ENDWHILE
    g_spooner_object_count = writeIdx
    IF g_spooner_selected_index >= g_spooner_object_count
        g_spooner_selected_index = g_spooner_object_count - 1
    ENDIF
    IF g_spooner_selected_index < 0
        g_spooner_selected_index = 0
    ENDIF
ENDPROC

PROC SYNC_SPOONER_UI_FROM_SELECTED()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    g_spooner_forward_offset = g_spooner_obj_fwd[idx]
    g_spooner_side_offset    = g_spooner_obj_side[idx]
    g_spooner_height_offset  = g_spooner_obj_height[idx]
    g_spooner_heading_offset = g_spooner_obj_heading[idx]
    g_spooner_freeze_pos     = g_spooner_obj_frozen[idx]
    g_spooner_collision      = g_spooner_obj_collision[idx]
    g_spooner_bone_choice    = g_spooner_obj_bone[idx]
    g_spooner_attach_x       = g_spooner_obj_att_x[idx]
    g_spooner_attach_y       = g_spooner_obj_att_y[idx]
    g_spooner_attach_z       = g_spooner_obj_att_z[idx]
    g_spooner_attach_pitch   = g_spooner_obj_att_pitch[idx]
    g_spooner_attach_roll    = g_spooner_obj_att_roll[idx]
    g_spooner_attach_yaw     = g_spooner_obj_att_yaw[idx]
ENDPROC

PROC QUEUE_SPOONER_OBJECT_SPAWN(MODEL_NAMES model)
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count >= SPOONER_MAX_OBJECTS
        g_spooner_feedback_code = 3
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
        EXIT
    ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model)
        g_spooner_feedback_code = 2
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
        EXIT
    ENDIF
    IF g_spooner_spawn_pending AND g_spooner_pending_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
    ENDIF
    REQUEST_MODEL(model)
    g_spooner_pending_model = model
    g_spooner_spawn_start_ms = GET_GAME_TIMER()
    g_spooner_spawn_pending = TRUE
ENDPROC

PROC APPLY_SPOONER_OFFSET_TO_SELECTED()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF
    g_spooner_obj_fwd[idx]     = g_spooner_forward_offset
    g_spooner_obj_side[idx]    = g_spooner_side_offset
    g_spooner_obj_height[idx]  = g_spooner_height_offset
    g_spooner_obj_heading[idx] = g_spooner_heading_offset
    IF IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
        g_spooner_obj_attached[idx] = FALSE
    ENDIF
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR targetPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<g_spooner_side_offset, g_spooner_forward_offset, g_spooner_height_offset>>)
    FLOAT targetHeading = GET_ENTITY_HEADING(playerPed) + g_spooner_heading_offset
    WHILE targetHeading >= 360.0
        targetHeading = targetHeading - 360.0
    ENDWHILE
    WHILE targetHeading < 0.0
        targetHeading = targetHeading + 360.0
    ENDWHILE
    SET_ENTITY_COORDS_NO_OFFSET(obj, targetPos, FALSE, FALSE, TRUE)
    SET_ENTITY_HEADING(obj, targetHeading)
    FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
    SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
ENDPROC

PROC PROCESS_SPOONER_SPAWN_QUEUE()
    IF NOT g_spooner_spawn_pending EXIT ENDIF
    IF HAS_MODEL_LOADED(g_spooner_pending_model)
        COMPACT_SPOONER_POOL()
        IF g_spooner_object_count < SPOONER_MAX_OBJECTS
            PED_INDEX playerPed = PLAYER_PED_ID()
            VECTOR spawnPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<g_spooner_side_offset, g_spooner_forward_offset, g_spooner_height_offset>>)
            FLOAT spawnHeading = GET_ENTITY_HEADING(playerPed) + g_spooner_heading_offset
            WHILE spawnHeading >= 360.0
                spawnHeading = spawnHeading - 360.0
            ENDWHILE
            WHILE spawnHeading < 0.0
                spawnHeading = spawnHeading + 360.0
            ENDWHILE
            OBJECT_INDEX newObj = CREATE_OBJECT_NO_OFFSET(g_spooner_pending_model, spawnPos, FALSE, TRUE, FALSE)
            IF DOES_ENTITY_EXIST(newObj)
                SET_ENTITY_AS_MISSION_ENTITY(newObj, TRUE, TRUE)
                SET_ENTITY_HEADING(newObj, spawnHeading)
                SET_ENTITY_DYNAMIC(newObj, NOT g_spooner_freeze_pos)
                FREEZE_ENTITY_POSITION(newObj, g_spooner_freeze_pos)
                SET_ENTITY_COLLISION(newObj, g_spooner_collision, FALSE)
                INT slot = g_spooner_object_count
                g_spooner_objects[slot]       = newObj
                g_spooner_obj_fwd[slot]       = g_spooner_forward_offset
                g_spooner_obj_side[slot]      = g_spooner_side_offset
                g_spooner_obj_height[slot]    = g_spooner_height_offset
                g_spooner_obj_heading[slot]   = g_spooner_heading_offset
                g_spooner_obj_frozen[slot]    = g_spooner_freeze_pos
                g_spooner_obj_collision[slot] = g_spooner_collision
                g_spooner_obj_attached[slot]  = FALSE
                g_spooner_obj_bone[slot]      = g_spooner_bone_choice
                g_spooner_obj_att_x[slot]     = g_spooner_attach_x
                g_spooner_obj_att_y[slot]     = g_spooner_attach_y
                g_spooner_obj_att_z[slot]     = g_spooner_attach_z
                g_spooner_obj_att_pitch[slot] = g_spooner_attach_pitch
                g_spooner_obj_att_roll[slot]  = g_spooner_attach_roll
                g_spooner_obj_att_yaw[slot]   = g_spooner_attach_yaw
                g_spooner_object_count = g_spooner_object_count + 1
                g_spooner_selected_index = slot
                g_spooner_feedback_code = 1
                g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
            ENDIF
        ENDIF
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
    ELIF (GET_GAME_TIMER() - g_spooner_spawn_start_ms) > 8000
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
        g_spooner_feedback_code = 2
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
    ENDIF
ENDPROC

PROC TOGGLE_SPOONER_FREEZE_POSITION()
    g_spooner_freeze_pos = NOT g_spooner_freeze_pos
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF DOES_ENTITY_EXIST(obj)
        g_spooner_obj_frozen[idx] = g_spooner_freeze_pos
        SET_ENTITY_DYNAMIC(obj, NOT g_spooner_freeze_pos)
        FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
        IF NOT g_spooner_freeze_pos
            SET_ACTIVATE_OBJECT_PHYSICS_AS_SOON_AS_IT_IS_UNFROZEN(obj, TRUE)
        ENDIF
    ENDIF
ENDPROC

PROC TOGGLE_SPOONER_COLLISION()
    g_spooner_collision = NOT g_spooner_collision
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF DOES_ENTITY_EXIST(obj)
        g_spooner_obj_collision[idx] = g_spooner_collision
        SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
    ENDIF
ENDPROC

PROC SNAP_SPOONER_OBJECT_TO_GROUND()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF
    IF IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
        g_spooner_obj_attached[idx] = FALSE
    ENDIF
    IF NOT PLACE_OBJECT_ON_GROUND_PROPERLY(obj)
        VECTOR pos = GET_ENTITY_COORDS(obj)
        FLOAT groundZ = pos.z
        IF GET_GROUND_Z_FOR_3D_COORD(<<pos.x, pos.y, pos.z + 50.0>>, groundZ)
            SET_ENTITY_COORDS_NO_OFFSET(obj, <<pos.x, pos.y, groundZ>>, FALSE, FALSE, TRUE)
        ENDIF
    ENDIF
    VECTOR finalPos = GET_ENTITY_COORDS(obj)
    VECTOR playerPos = GET_ENTITY_COORDS(PLAYER_PED_ID())
    g_spooner_height_offset = finalPos.z - playerPos.z
    g_spooner_obj_height[idx] = g_spooner_height_offset
    FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
ENDPROC

FUNC PED_BONETAG SPOONER_BONE_TAG_FROM_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN BONETAG_PELVIS
        CASE 1 RETURN BONETAG_SPINE3
        CASE 2 RETURN BONETAG_HEAD
        CASE 3 RETURN BONETAG_PH_R_HAND
        CASE 4 RETURN BONETAG_PH_L_HAND
        CASE 5 RETURN BONETAG_R_FOOT
        CASE 6 RETURN BONETAG_L_FOOT
        CASE 7 RETURN BONETAG_NECK
        CASE 8 RETURN BONETAG_ROOT
    ENDSWITCH
    RETURN BONETAG_PELVIS
ENDFUNC

FUNC STRING SPOONER_BONE_CHOICE_LABEL(INT choice)
    SWITCH choice
        CASE 0 RETURN "< Pelvis (11816) >"
        CASE 1 RETURN "< Spine 3 (24818) >"
        CASE 2 RETURN "< Head (31086) >"
        CASE 3 RETURN "< Right Hand (28422) >"
        CASE 4 RETURN "< Left Hand (60309) >"
        CASE 5 RETURN "< Right Foot (52301) >"
        CASE 6 RETURN "< Left Foot (14201) >"
        CASE 7 RETURN "< Neck (39317) >"
        CASE 8 RETURN "< Skeleton Root (0) >"
        CASE 9 RETURN "< Player Vehicle >"
    ENDSWITCH
    RETURN "< Pelvis (11816) >"
ENDFUNC

PROC APPLY_SPOONER_ATTACHMENT(BOOL forceAttach)
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF
    g_spooner_obj_bone[idx]      = g_spooner_bone_choice
    g_spooner_obj_att_x[idx]     = g_spooner_attach_x
    g_spooner_obj_att_y[idx]     = g_spooner_attach_y
    g_spooner_obj_att_z[idx]     = g_spooner_attach_z
    g_spooner_obj_att_pitch[idx] = g_spooner_attach_pitch
    g_spooner_obj_att_roll[idx]  = g_spooner_attach_roll
    g_spooner_obj_att_yaw[idx]   = g_spooner_attach_yaw
    IF NOT forceAttach AND IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
        g_spooner_obj_attached[idx] = FALSE
        FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
        SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
        EXIT
    ENDIF
    PED_INDEX playerPed = PLAYER_PED_ID()
    ENTITY_INDEX targetEntity = playerPed
    INT boneIndex = 0
    IF g_spooner_bone_choice = 9 AND IS_PED_IN_ANY_VEHICLE(playerPed)
        targetEntity = GET_VEHICLE_PED_IS_IN(playerPed)
        boneIndex = 0
    ELSE
        boneIndex = GET_PED_BONE_INDEX(playerPed, SPOONER_BONE_TAG_FROM_CHOICE(g_spooner_bone_choice))
    ENDIF
    ATTACH_ENTITY_TO_ENTITY(obj, targetEntity, boneIndex, <<g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z>>, <<g_spooner_attach_pitch, g_spooner_attach_roll, g_spooner_attach_yaw>>, FALSE, FALSE, g_spooner_collision, TRUE, EULER_YXZ, TRUE)
    g_spooner_obj_attached[idx] = TRUE
ENDPROC

PROC DELETE_SPOONER_LAST_OBJECT()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT lastIdx = g_spooner_object_count - 1
    OBJECT_INDEX obj = g_spooner_objects[lastIdx]
    IF DOES_ENTITY_EXIST(obj)
        IF IS_ENTITY_ATTACHED(obj)
            DETACH_ENTITY(obj, FALSE, FALSE)
        ENDIF
        SET_ENTITY_AS_MISSION_ENTITY(obj, TRUE, TRUE)
        DELETE_OBJECT(obj)
    ENDIF
    g_spooner_objects[lastIdx] = NULL
    g_spooner_object_count = lastIdx
    IF g_spooner_selected_index >= g_spooner_object_count
        g_spooner_selected_index = g_spooner_object_count - 1
    ENDIF
    IF g_spooner_selected_index < 0
        g_spooner_selected_index = 0
    ENDIF
    SYNC_SPOONER_UI_FROM_SELECTED()
    g_spooner_feedback_code = 4
    g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
ENDPROC

PROC CLEAR_ALL_SPOONER_OBJECTS()
    INT i = g_spooner_object_count - 1
    WHILE i >= 0
        OBJECT_INDEX obj = g_spooner_objects[i]
        IF DOES_ENTITY_EXIST(obj)
            IF IS_ENTITY_ATTACHED(obj)
                DETACH_ENTITY(obj, FALSE, FALSE)
            ENDIF
            SET_ENTITY_AS_MISSION_ENTITY(obj, TRUE, TRUE)
            DELETE_OBJECT(obj)
        ENDIF
        g_spooner_objects[i] = NULL
        i = i - 1
    ENDWHILE
    g_spooner_object_count = 0
    g_spooner_selected_index = 0
    IF g_spooner_spawn_pending AND g_spooner_pending_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
    ENDIF
    g_spooner_feedback_code = 5
    g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
ENDPROC

FUNC STRING SPOONER_SPAWN_STATUS_LABEL()
    IF g_spooner_spawn_pending
        RETURN "LOADING"
    ENDIF
    IF GET_GAME_TIMER() < g_spooner_feedback_until
        IF g_spooner_feedback_code = 1 RETURN "SPAWNED" ENDIF
        IF g_spooner_feedback_code = 2 RETURN "INVALID" ENDIF
        IF g_spooner_feedback_code = 3 RETURN "POOL FULL" ENDIF
    ENDIF
    RETURN "APPLY"
ENDFUNC

FUNC STRING SPOONER_CUSTOM_INPUT_LABEL()
    IF g_spooner_spawn_pending
        RETURN "LOADING"
    ENDIF
    IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 2
        RETURN "NOT FOUND"
    ENDIF
    IF NOT IS_STRING_NULL_OR_EMPTY(g_spooner_custom_model_input)
        RETURN "INPUT"
    ENDIF
    RETURN "INPUT"
ENDFUNC

FUNC STRING SPOONER_ATTACH_ACTION_LABEL()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0
        RETURN "NO OBJECT"
    ENDIF
    IF IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
        RETURN "ATTACHED"
    ENDIF
    RETURN "DETACHED"
ENDFUNC

FUNC INT SPOONER_ATTACH_ACTION_STATE()
    IF g_spooner_object_count <= 0
        RETURN -1
    ENDIF
    IF IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
        RETURN 1
    ENDIF
    RETURN 0
ENDFUNC

PROC DRAW_SPOONER_SELECTED_OBJECT_ROW(FLOAT y, BOOL selected)
    COMPACT_SPOONER_POOL()
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        rr = g_accent_r
        gg = g_accent_g
        bb = g_accent_b
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, "Selected Object")
    TEXT_LABEL_63 valText = "< None (0/"
    IF g_spooner_object_count > 0
        valText = "< #"
        valText += (g_spooner_selected_index + 1)
        valText += " / "
        valText += g_spooner_object_count
        valText += " >"
    ELSE
        valText += SPOONER_MAX_OBJECTS
        valText += ") >"
    ENDIF
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_SPOONER_METRE_OPTION(FLOAT y, STRING label, FLOAT value, BOOL selected)
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
    INT totalCenti = ROUND(value * 100.0)
    BOOL isNeg = FALSE
    IF totalCenti < 0
        isNeg = TRUE
        totalCenti = 0 - totalCenti
    ENDIF
    INT wholeMetres = totalCenti / 100
    INT fracCenti = totalCenti - (wholeMetres * 100)
    TEXT_LABEL_63 valText = "< "
    IF isNeg
        valText += "-"
    ENDIF
    valText += wholeMetres
    valText += "."
    IF fracCenti < 10
        valText += "0"
    ENDIF
    valText += fracCenti
    valText += "m >"
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_SPOONER_DEGREE_OPTION(FLOAT y, STRING label, STRING prefix, FLOAT degrees, BOOL selected)
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
    INT degInt = ROUND(degrees)
    TEXT_LABEL_63 valText = "< "
    IF NOT IS_STRING_NULL_OR_EMPTY(prefix)
        valText += prefix
        valText += ": "
    ENDIF
    valText += degInt
    valText += " deg >"
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_SPOONER_ROT_AXIS_ROW(FLOAT y, BOOL selected)
    IF g_spooner_rot_axis = 0
        DRAW_SPOONER_DEGREE_OPTION(y, "Attach Rotation", "Pitch", g_spooner_attach_pitch, selected)
    ELIF g_spooner_rot_axis = 1
        DRAW_SPOONER_DEGREE_OPTION(y, "Attach Rotation", "Roll", g_spooner_attach_roll, selected)
    ELSE
        DRAW_SPOONER_DEGREE_OPTION(y, "Attach Rotation", "Yaw", g_spooner_attach_yaw, selected)
    ENDIF
ENDPROC
