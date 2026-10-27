//|=======================================================================================|
//|  util_saved_vehicles.sch - Complete Vehicle Saving & Modification Persistence.        |
//|  Powered by ScriptHookV-NX (subsdk5) direct SD card storage.                          |
//|=======================================================================================|

// Maps characters to integer codes (1..75) for SD persistence
FUNC INT SAVED_VEH_CHAR_TO_CODE(STRING ch)
    IF IS_STRING_NULL_OR_EMPTY(ch) RETURN 0 ENDIF
    IF ARE_STRINGS_EQUAL(ch, " ") RETURN 1 ENDIF
    IF ARE_STRINGS_EQUAL(ch, "A") RETURN 2 ELIF ARE_STRINGS_EQUAL(ch, "B") RETURN 3
    ELIF ARE_STRINGS_EQUAL(ch, "C") RETURN 4 ELIF ARE_STRINGS_EQUAL(ch, "D") RETURN 5
    ELIF ARE_STRINGS_EQUAL(ch, "E") RETURN 6 ELIF ARE_STRINGS_EQUAL(ch, "F") RETURN 7
    ELIF ARE_STRINGS_EQUAL(ch, "G") RETURN 8 ELIF ARE_STRINGS_EQUAL(ch, "H") RETURN 9
    ELIF ARE_STRINGS_EQUAL(ch, "I") RETURN 10 ELIF ARE_STRINGS_EQUAL(ch, "J") RETURN 11
    ELIF ARE_STRINGS_EQUAL(ch, "K") RETURN 12 ELIF ARE_STRINGS_EQUAL(ch, "L") RETURN 13
    ELIF ARE_STRINGS_EQUAL(ch, "M") RETURN 14 ELIF ARE_STRINGS_EQUAL(ch, "N") RETURN 15
    ELIF ARE_STRINGS_EQUAL(ch, "O") RETURN 16 ELIF ARE_STRINGS_EQUAL(ch, "P") RETURN 17
    ELIF ARE_STRINGS_EQUAL(ch, "Q") RETURN 18 ELIF ARE_STRINGS_EQUAL(ch, "R") RETURN 19
    ELIF ARE_STRINGS_EQUAL(ch, "S") RETURN 20 ELIF ARE_STRINGS_EQUAL(ch, "T") RETURN 21
    ELIF ARE_STRINGS_EQUAL(ch, "U") RETURN 22 ELIF ARE_STRINGS_EQUAL(ch, "V") RETURN 23
    ELIF ARE_STRINGS_EQUAL(ch, "W") RETURN 24 ELIF ARE_STRINGS_EQUAL(ch, "X") RETURN 25
    ELIF ARE_STRINGS_EQUAL(ch, "Y") RETURN 26 ELIF ARE_STRINGS_EQUAL(ch, "Z") RETURN 27 ENDIF
    IF ARE_STRINGS_EQUAL(ch, "a") RETURN 28 ELIF ARE_STRINGS_EQUAL(ch, "b") RETURN 29
    ELIF ARE_STRINGS_EQUAL(ch, "c") RETURN 30 ELIF ARE_STRINGS_EQUAL(ch, "d") RETURN 31
    ELIF ARE_STRINGS_EQUAL(ch, "e") RETURN 32 ELIF ARE_STRINGS_EQUAL(ch, "f") RETURN 33
    ELIF ARE_STRINGS_EQUAL(ch, "g") RETURN 34 ELIF ARE_STRINGS_EQUAL(ch, "h") RETURN 35
    ELIF ARE_STRINGS_EQUAL(ch, "i") RETURN 36 ELIF ARE_STRINGS_EQUAL(ch, "j") RETURN 37
    ELIF ARE_STRINGS_EQUAL(ch, "k") RETURN 38 ELIF ARE_STRINGS_EQUAL(ch, "l") RETURN 39
    ELIF ARE_STRINGS_EQUAL(ch, "m") RETURN 40 ELIF ARE_STRINGS_EQUAL(ch, "n") RETURN 41
    ELIF ARE_STRINGS_EQUAL(ch, "o") RETURN 42 ELIF ARE_STRINGS_EQUAL(ch, "p") RETURN 43
    ELIF ARE_STRINGS_EQUAL(ch, "q") RETURN 44 ELIF ARE_STRINGS_EQUAL(ch, "r") RETURN 45
    ELIF ARE_STRINGS_EQUAL(ch, "s") RETURN 46 ELIF ARE_STRINGS_EQUAL(ch, "t") RETURN 47
    ELIF ARE_STRINGS_EQUAL(ch, "u") RETURN 48 ELIF ARE_STRINGS_EQUAL(ch, "v") RETURN 49
    ELIF ARE_STRINGS_EQUAL(ch, "w") RETURN 50 ELIF ARE_STRINGS_EQUAL(ch, "x") RETURN 51
    ELIF ARE_STRINGS_EQUAL(ch, "y") RETURN 52 ELIF ARE_STRINGS_EQUAL(ch, "z") RETURN 53 ENDIF
    IF ARE_STRINGS_EQUAL(ch, "0") RETURN 54 ELIF ARE_STRINGS_EQUAL(ch, "1") RETURN 55
    ELIF ARE_STRINGS_EQUAL(ch, "2") RETURN 56 ELIF ARE_STRINGS_EQUAL(ch, "3") RETURN 57
    ELIF ARE_STRINGS_EQUAL(ch, "4") RETURN 58 ELIF ARE_STRINGS_EQUAL(ch, "5") RETURN 59
    ELIF ARE_STRINGS_EQUAL(ch, "6") RETURN 60 ELIF ARE_STRINGS_EQUAL(ch, "7") RETURN 61
    ELIF ARE_STRINGS_EQUAL(ch, "8") RETURN 62 ELIF ARE_STRINGS_EQUAL(ch, "9") RETURN 63 ENDIF
    IF ARE_STRINGS_EQUAL(ch, "-") RETURN 64 ELIF ARE_STRINGS_EQUAL(ch, "_") RETURN 65
    ELIF ARE_STRINGS_EQUAL(ch, ".") RETURN 66 ELIF ARE_STRINGS_EQUAL(ch, "!") RETURN 67
    ELIF ARE_STRINGS_EQUAL(ch, "#") RETURN 68 ELIF ARE_STRINGS_EQUAL(ch, "/") RETURN 69
    ELIF ARE_STRINGS_EQUAL(ch, "+") RETURN 70 ELIF ARE_STRINGS_EQUAL(ch, ":") RETURN 71
    ELIF ARE_STRINGS_EQUAL(ch, "(") RETURN 72 ELIF ARE_STRINGS_EQUAL(ch, ")") RETURN 73 ENDIF
    RETURN 0
ENDFUNC

// Maps integer codes (1..75) back to character strings
FUNC STRING SAVED_VEH_CODE_TO_CHAR(INT code)
    SWITCH code
        CASE 1 RETURN " " BREAK
        CASE 2 RETURN "A" BREAK
        CASE 3 RETURN "B" BREAK
        CASE 4 RETURN "C" BREAK
        CASE 5 RETURN "D" BREAK
        CASE 6 RETURN "E" BREAK
        CASE 7 RETURN "F" BREAK
        CASE 8 RETURN "G" BREAK
        CASE 9 RETURN "H" BREAK
        CASE 10 RETURN "I" BREAK
        CASE 11 RETURN "J" BREAK
        CASE 12 RETURN "K" BREAK
        CASE 13 RETURN "L" BREAK
        CASE 14 RETURN "M" BREAK
        CASE 15 RETURN "N" BREAK
        CASE 16 RETURN "O" BREAK
        CASE 17 RETURN "P" BREAK
        CASE 18 RETURN "Q" BREAK
        CASE 19 RETURN "R" BREAK
        CASE 20 RETURN "S" BREAK
        CASE 21 RETURN "T" BREAK
        CASE 22 RETURN "U" BREAK
        CASE 23 RETURN "V" BREAK
        CASE 24 RETURN "W" BREAK
        CASE 25 RETURN "X" BREAK
        CASE 26 RETURN "Y" BREAK
        CASE 27 RETURN "Z" BREAK
        CASE 28 RETURN "a" BREAK
        CASE 29 RETURN "b" BREAK
        CASE 30 RETURN "c" BREAK
        CASE 31 RETURN "d" BREAK
        CASE 32 RETURN "e" BREAK
        CASE 33 RETURN "f" BREAK
        CASE 34 RETURN "g" BREAK
        CASE 35 RETURN "h" BREAK
        CASE 36 RETURN "i" BREAK
        CASE 37 RETURN "j" BREAK
        CASE 38 RETURN "k" BREAK
        CASE 39 RETURN "l" BREAK
        CASE 40 RETURN "m" BREAK
        CASE 41 RETURN "n" BREAK
        CASE 42 RETURN "o" BREAK
        CASE 43 RETURN "p" BREAK
        CASE 44 RETURN "q" BREAK
        CASE 45 RETURN "r" BREAK
        CASE 46 RETURN "s" BREAK
        CASE 47 RETURN "t" BREAK
        CASE 48 RETURN "u" BREAK
        CASE 49 RETURN "v" BREAK
        CASE 50 RETURN "w" BREAK
        CASE 51 RETURN "x" BREAK
        CASE 52 RETURN "y" BREAK
        CASE 53 RETURN "z" BREAK
        CASE 54 RETURN "0" BREAK
        CASE 55 RETURN "1" BREAK
        CASE 56 RETURN "2" BREAK
        CASE 57 RETURN "3" BREAK
        CASE 58 RETURN "4" BREAK
        CASE 59 RETURN "5" BREAK
        CASE 60 RETURN "6" BREAK
        CASE 61 RETURN "7" BREAK
        CASE 62 RETURN "8" BREAK
        CASE 63 RETURN "9" BREAK
        CASE 64 RETURN "-" BREAK
        CASE 65 RETURN "_" BREAK
        CASE 66 RETURN "." BREAK
        CASE 67 RETURN "!" BREAK
        CASE 68 RETURN "#" BREAK
        CASE 69 RETURN "/" BREAK
        CASE 70 RETURN "+" BREAK
        CASE 71 RETURN ":" BREAK
        CASE 72 RETURN "(" BREAK
        CASE 73 RETURN ")" BREAK
    ENDSWITCH
    RETURN ""
ENDFUNC

// Captures all attributes and modifications of current vehicle into staging variables
FUNC BOOL CAPTURE_CURRENT_VEHICLE_TO_STAGING()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        RETURN FALSE
    ENDIF
    VEHICLE_INDEX veh = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF veh = NULL OR NOT DOES_ENTITY_EXIST(veh)
        RETURN FALSE
    ENDIF

    g_save_stage_model = ENUM_TO_INT(GET_ENTITY_MODEL(veh))
    STRING modelGxt = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(INT_TO_ENUM(MODEL_NAMES, g_save_stage_model))
    IF NOT IS_STRING_NULL_OR_EMPTY(modelGxt)
        g_save_stage_display_name = GET_FILENAME_FOR_AUDIO_CONVERSATION(modelGxt)
    ELSE
        g_save_stage_display_name = "Custom Vehicle"
    ENDIF

    GET_VEHICLE_COLOURS(veh, g_save_stage_primary, g_save_stage_secondary)
    GET_VEHICLE_EXTRA_COLOURS(veh, g_save_stage_pearlescent, g_save_stage_wheel_colour)
    g_save_stage_xenon = GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(veh)
    g_save_stage_window_tint = GET_VEHICLE_WINDOW_TINT(veh)
    g_save_stage_wheel_type = ENUM_TO_INT(GET_VEHICLE_WHEEL_TYPE(veh))
    g_save_stage_custom_tyres = 0
    IF GET_VEHICLE_MOD_VARIATION(veh, MOD_WHEELS) != 0
        g_save_stage_custom_tyres = 1
    ENDIF
    g_save_stage_plate_style = GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh)
    g_save_stage_plate_text = GET_VEHICLE_NUMBER_PLATE_TEXT(veh)
    g_save_stage_livery = GET_VEHICLE_LIVERY(veh)
    g_save_stage_roof_state = ENUM_TO_INT(GET_CONVERTIBLE_ROOF_STATE(veh))

    g_save_stage_has_cust_prim = GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(veh)
    IF g_save_stage_has_cust_prim
        GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, g_save_stage_cust_prim_r, g_save_stage_cust_prim_g, g_save_stage_cust_prim_b)
    ENDIF
    g_save_stage_has_cust_sec = GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(veh)
    IF g_save_stage_has_cust_sec
        GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, g_save_stage_cust_sec_r, g_save_stage_cust_sec_g, g_save_stage_cust_sec_b)
    ENDIF

    g_save_stage_neon_enabled = 0
    IF GET_VEHICLE_NEON_ENABLED(veh, NEON_LEFT) g_save_stage_neon_enabled = g_save_stage_neon_enabled + 1 ENDIF
    IF GET_VEHICLE_NEON_ENABLED(veh, NEON_RIGHT) g_save_stage_neon_enabled = g_save_stage_neon_enabled + 2 ENDIF
    IF GET_VEHICLE_NEON_ENABLED(veh, NEON_FRONT) g_save_stage_neon_enabled = g_save_stage_neon_enabled + 4 ENDIF
    IF GET_VEHICLE_NEON_ENABLED(veh, NEON_BACK) g_save_stage_neon_enabled = g_save_stage_neon_enabled + 8 ENDIF
    GET_VEHICLE_NEON_COLOUR(veh, g_save_stage_neon_r, g_save_stage_neon_g, g_save_stage_neon_b)
    GET_VEHICLE_TYRE_SMOKE_COLOR(veh, g_save_stage_smoke_r, g_save_stage_smoke_g, g_save_stage_smoke_b)

    g_save_stage_turbo = IS_TOGGLE_MOD_ON(veh, MOD_TOGGLE_TURBO)
    g_save_stage_xenon_toggle = IS_TOGGLE_MOD_ON(veh, MOD_TOGGLE_XENON_LIGHTS)
    g_save_stage_smoke_toggle = IS_TOGGLE_MOD_ON(veh, MOD_TOGGLE_TYRE_SMOKE)
    g_save_stage_hydro_toggle = IS_TOGGLE_MOD_ON(veh, MOD_TOGGLE_HYDRAULICS)

    g_save_stage_extras = 0
    INT ex = 1
    WHILE ex <= 14
        IF DOES_EXTRA_EXIST(veh, ex)
            IF IS_VEHICLE_EXTRA_TURNED_ON(veh, ex)
                SET_BIT(g_save_stage_extras, ex)
            ENDIF
        ENDIF
        ex = ex + 1
    ENDWHILE

    SET_VEHICLE_MOD_KIT(veh, 0)
    INT m = 0
    WHILE m < 50
        g_save_stage_mods[m] = GET_VEHICLE_MOD(veh, INT_TO_ENUM(MOD_TYPE, m))
        m = m + 1
    ENDWHILE

    RETURN TRUE
ENDFUNC

// Applies a saved vehicle's complete modification profile to a newly spawned vehicle
PROC APPLY_SAVED_VEHICLE_CONFIG(VEHICLE_INDEX veh, INT slot)
    IF slot < 0 OR slot >= g_saved_vehicles_count OR veh = NULL OR NOT DOES_ENTITY_EXIST(veh)
        EXIT
    ENDIF

    SET_VEHICLE_COLOURS(veh, g_saved_veh_primary[slot], g_saved_veh_secondary[slot])
    SET_VEHICLE_EXTRA_COLOURS(veh, g_saved_veh_pearlescent[slot], g_saved_veh_wheel_colour[slot])
    SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(veh, g_saved_veh_xenon[slot])
    SET_VEHICLE_WINDOW_TINT(veh, g_saved_veh_window_tint[slot])
    SET_VEHICLE_WHEEL_TYPE(veh, INT_TO_ENUM(MOD_WHEEL_TYPE, g_saved_veh_wheel_type[slot]))
    SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, g_saved_veh_plate_style[slot])
    IF NOT IS_STRING_NULL_OR_EMPTY(g_saved_veh_plate_text[slot])
        SET_VEHICLE_NUMBER_PLATE_TEXT(veh, g_saved_veh_plate_text[slot])
    ENDIF
    SET_VEHICLE_LIVERY(veh, g_saved_veh_livery[slot])

    IF g_saved_veh_has_cust_prim[slot]
        SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, g_saved_veh_cust_prim_r[slot], g_saved_veh_cust_prim_g[slot], g_saved_veh_cust_prim_b[slot])
    ENDIF
    IF g_saved_veh_has_cust_sec[slot]
        SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, g_saved_veh_cust_sec_r[slot], g_saved_veh_cust_sec_g[slot], g_saved_veh_cust_sec_b[slot])
    ENDIF

    INT neonFlags = g_saved_veh_neon_enabled[slot]
    SET_VEHICLE_NEON_ENABLED(veh, NEON_LEFT, (neonFlags & 1) != 0)
    SET_VEHICLE_NEON_ENABLED(veh, NEON_RIGHT, (neonFlags & 2) != 0)
    SET_VEHICLE_NEON_ENABLED(veh, NEON_FRONT, (neonFlags & 4) != 0)
    SET_VEHICLE_NEON_ENABLED(veh, NEON_BACK, (neonFlags & 8) != 0)
    SET_VEHICLE_NEON_COLOUR(veh, g_saved_veh_neon_r[slot], g_saved_veh_neon_g[slot], g_saved_veh_neon_b[slot])
    SET_VEHICLE_TYRE_SMOKE_COLOR(veh, g_saved_veh_smoke_r[slot], g_saved_veh_smoke_g[slot], g_saved_veh_smoke_b[slot])

    SET_VEHICLE_MOD_KIT(veh, 0)
    TOGGLE_VEHICLE_MOD(veh, MOD_TOGGLE_TURBO, g_saved_veh_turbo[slot])
    TOGGLE_VEHICLE_MOD(veh, MOD_TOGGLE_XENON_LIGHTS, g_saved_veh_xenon_toggle[slot])
    TOGGLE_VEHICLE_MOD(veh, MOD_TOGGLE_TYRE_SMOKE, g_saved_veh_smoke_toggle[slot])
    TOGGLE_VEHICLE_MOD(veh, MOD_TOGGLE_HYDRAULICS, g_saved_veh_hydro_toggle[slot])
    SET_CAN_USE_HYDRAULICS(veh, g_saved_veh_hydro_toggle[slot])

    INT exMask = g_saved_veh_extras[slot]
    INT ex = 1
    WHILE ex <= 14
        IF DOES_EXTRA_EXIST(veh, ex)
            IF IS_BIT_SET(exMask, ex)
                SET_VEHICLE_EXTRA(veh, ex, FALSE)
            ELSE
                SET_VEHICLE_EXTRA(veh, ex, TRUE)
            ENDIF
        ENDIF
        ex = ex + 1
    ENDWHILE

    INT m = 0
    INT baseModIdx = slot * 50
    WHILE m < 50
        INT modVal = g_saved_veh_mods[baseModIdx + m]
        IF modVal >= 0
            IF m = 23 AND g_saved_veh_custom_tyres[slot] = 1
                SET_VEHICLE_MOD(veh, INT_TO_ENUM(MOD_TYPE, m), modVal, TRUE)
            ELSE
                SET_VEHICLE_MOD(veh, INT_TO_ENUM(MOD_TYPE, m), modVal, FALSE)
            ENDIF
        ENDIF
        m = m + 1
    ENDWHILE

    INT rState = g_saved_veh_roof_state[slot]
    IF rState = 0 OR rState = 2
        LOWER_CONVERTIBLE_ROOF(veh, TRUE)
    ELIF rState = 1 OR rState = 3
        RAISE_CONVERTIBLE_ROOF(veh, TRUE)
    ENDIF
ENDPROC

// Computes 32-bit checksum across payload words in g_persist_veh_sd_data
FUNC INT PERSIST_COMPUTE_VEH_SD_CHECKSUM()
    INT sum = 0
    INT i = 4
    WHILE i < PERSIST_VEH_BUFFER_WORDS
        sum = sum + g_persist_veh_sd_data[i]
        i = i + 1
    ENDWHILE
    IF sum < 0 sum = -sum ENDIF
    RETURN sum
ENDFUNC

// Serializes live saved vehicles into g_persist_veh_sd_data buffer
PROC PERSIST_PACK_VEHICLES_TO_BUFFER()
    INT i = 0
    WHILE i < PERSIST_VEH_BUFFER_WORDS
        g_persist_veh_sd_data[i] = 0
        i = i + 1
    ENDWHILE

    g_persist_veh_sd_data[0] = PERSIST_VEH_MAGIC
    g_persist_veh_sd_data[1] = PERSIST_VEH_VERSION
    g_persist_veh_sd_data[2] = g_saved_vehicles_count
    g_persist_veh_sd_data[3] = 0

    INT v = 0
    WHILE v < g_saved_vehicles_count
        INT base = 20 + (v * PERSIST_VEH_WORDS_PER_RECORD)
        g_persist_veh_sd_data[base + 0] = g_saved_veh_model_hashes[v]

        INT nameLen = GET_LENGTH_OF_LITERAL_STRING(g_saved_veh_names[v])
        INT ci = 0
        WHILE ci < 24
            IF ci < nameLen
                STRING ch = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(g_saved_veh_names[v], ci, ci + 1)
                g_persist_veh_sd_data[base + 1 + ci] = SAVED_VEH_CHAR_TO_CODE(ch)
            ELSE
                g_persist_veh_sd_data[base + 1 + ci] = 0
            ENDIF
            ci = ci + 1
        ENDWHILE

        INT dispLen = GET_LENGTH_OF_LITERAL_STRING(g_saved_veh_display_names[v])
        ci = 0
        WHILE ci < 12
            IF ci < dispLen
                STRING dch = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(g_saved_veh_display_names[v], ci, ci + 1)
                g_persist_veh_sd_data[base + 25 + ci] = SAVED_VEH_CHAR_TO_CODE(dch)
            ELSE
                g_persist_veh_sd_data[base + 25 + ci] = 0
            ENDIF
            ci = ci + 1
        ENDWHILE

        INT plateLen = GET_LENGTH_OF_LITERAL_STRING(g_saved_veh_plate_text[v])
        ci = 0
        WHILE ci < 8
            IF ci < plateLen
                STRING pch = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(g_saved_veh_plate_text[v], ci, ci + 1)
                g_persist_veh_sd_data[base + 37 + ci] = SAVED_VEH_CHAR_TO_CODE(pch)
            ELSE
                g_persist_veh_sd_data[base + 37 + ci] = 0
            ENDIF
            ci = ci + 1
        ENDWHILE

        g_persist_veh_sd_data[base + 45] = g_saved_veh_primary[v]
        g_persist_veh_sd_data[base + 46] = g_saved_veh_secondary[v]
        g_persist_veh_sd_data[base + 47] = g_saved_veh_pearlescent[v]
        g_persist_veh_sd_data[base + 48] = g_saved_veh_wheel_colour[v]
        g_persist_veh_sd_data[base + 49] = g_saved_veh_xenon[v]
        g_persist_veh_sd_data[base + 50] = g_saved_veh_window_tint[v]
        g_persist_veh_sd_data[base + 51] = g_saved_veh_wheel_type[v]
        g_persist_veh_sd_data[base + 52] = g_saved_veh_custom_tyres[v]
        g_persist_veh_sd_data[base + 53] = g_saved_veh_plate_style[v]
        g_persist_veh_sd_data[base + 54] = g_saved_veh_livery[v]
        g_persist_veh_sd_data[base + 55] = g_saved_veh_roof_state[v]

        IF g_saved_veh_has_cust_prim[v] g_persist_veh_sd_data[base + 56] = 1 ELSE g_persist_veh_sd_data[base + 56] = 0 ENDIF
        g_persist_veh_sd_data[base + 57] = g_saved_veh_cust_prim_r[v]
        g_persist_veh_sd_data[base + 58] = g_saved_veh_cust_prim_g[v]
        g_persist_veh_sd_data[base + 59] = g_saved_veh_cust_prim_b[v]

        IF g_saved_veh_has_cust_sec[v] g_persist_veh_sd_data[base + 60] = 1 ELSE g_persist_veh_sd_data[base + 60] = 0 ENDIF
        g_persist_veh_sd_data[base + 61] = g_saved_veh_cust_sec_r[v]
        g_persist_veh_sd_data[base + 62] = g_saved_veh_cust_sec_g[v]
        g_persist_veh_sd_data[base + 63] = g_saved_veh_cust_sec_b[v]

        g_persist_veh_sd_data[base + 64] = g_saved_veh_neon_enabled[v]
        g_persist_veh_sd_data[base + 65] = g_saved_veh_neon_r[v]
        g_persist_veh_sd_data[base + 66] = g_saved_veh_neon_g[v]
        g_persist_veh_sd_data[base + 67] = g_saved_veh_neon_b[v]
        g_persist_veh_sd_data[base + 68] = g_saved_veh_smoke_r[v]
        g_persist_veh_sd_data[base + 69] = g_saved_veh_smoke_g[v]
        g_persist_veh_sd_data[base + 70] = g_saved_veh_smoke_b[v]

        IF g_saved_veh_turbo[v] g_persist_veh_sd_data[base + 71] = 1 ELSE g_persist_veh_sd_data[base + 71] = 0 ENDIF
        IF g_saved_veh_xenon_toggle[v] g_persist_veh_sd_data[base + 72] = 1 ELSE g_persist_veh_sd_data[base + 72] = 0 ENDIF
        IF g_saved_veh_smoke_toggle[v] g_persist_veh_sd_data[base + 73] = 1 ELSE g_persist_veh_sd_data[base + 73] = 0 ENDIF
        IF g_saved_veh_hydro_toggle[v] g_persist_veh_sd_data[base + 74] = 1 ELSE g_persist_veh_sd_data[base + 74] = 0 ENDIF
        g_persist_veh_sd_data[base + 75] = g_saved_veh_extras[v]

        INT m = 0
        INT baseModIdx = v * 50
        WHILE m < 50
            g_persist_veh_sd_data[base + 76 + m] = g_saved_veh_mods[baseModIdx + m]
            m = m + 1
        ENDWHILE

        v = v + 1
    ENDWHILE

    g_persist_veh_sd_data[3] = PERSIST_COMPUTE_VEH_SD_CHECKSUM()
ENDPROC

// Unpacks g_persist_veh_sd_data buffer into live saved vehicle arrays
PROC PERSIST_UNPACK_VEHICLES_FROM_BUFFER()
    INT count = g_persist_veh_sd_data[2]
    IF count < 0 count = 0 ENDIF
    IF count > MAX_SAVED_VEHICLES count = MAX_SAVED_VEHICLES ENDIF
    g_saved_vehicles_count = count

    INT v = 0
    WHILE v < count
        INT base = 20 + (v * PERSIST_VEH_WORDS_PER_RECORD)
        g_saved_veh_model_hashes[v] = g_persist_veh_sd_data[base + 0]

        TEXT_LABEL_31 vName = ""
        INT ci = 0
        WHILE ci < 24
            INT cCode = g_persist_veh_sd_data[base + 1 + ci]
            IF cCode > 0
                vName += SAVED_VEH_CODE_TO_CHAR(cCode)
            ENDIF
            ci = ci + 1
        ENDWHILE
        IF IS_STRING_NULL_OR_EMPTY(vName) vName = "Saved Car" ENDIF
        g_saved_veh_names[v] = vName

        TEXT_LABEL_31 dName = ""
        ci = 0
        WHILE ci < 12
            INT dCode = g_persist_veh_sd_data[base + 25 + ci]
            IF dCode > 0
                dName += SAVED_VEH_CODE_TO_CHAR(dCode)
            ENDIF
            ci = ci + 1
        ENDWHILE
        g_saved_veh_display_names[v] = dName

        TEXT_LABEL_15 pText = ""
        ci = 0
        WHILE ci < 8
            INT pCode = g_persist_veh_sd_data[base + 37 + ci]
            IF pCode > 0
                pText += SAVED_VEH_CODE_TO_CHAR(pCode)
            ENDIF
            ci = ci + 1
        ENDWHILE
        g_saved_veh_plate_text[v] = pText

        g_saved_veh_primary[v] = g_persist_veh_sd_data[base + 45]
        g_saved_veh_secondary[v] = g_persist_veh_sd_data[base + 46]
        g_saved_veh_pearlescent[v] = g_persist_veh_sd_data[base + 47]
        g_saved_veh_wheel_colour[v] = g_persist_veh_sd_data[base + 48]
        g_saved_veh_xenon[v] = g_persist_veh_sd_data[base + 49]
        g_saved_veh_window_tint[v] = g_persist_veh_sd_data[base + 50]
        g_saved_veh_wheel_type[v] = g_persist_veh_sd_data[base + 51]
        g_saved_veh_custom_tyres[v] = g_persist_veh_sd_data[base + 52]
        g_saved_veh_plate_style[v] = g_persist_veh_sd_data[base + 53]
        g_saved_veh_livery[v] = g_persist_veh_sd_data[base + 54]
        g_saved_veh_roof_state[v] = g_persist_veh_sd_data[base + 55]

        g_saved_veh_has_cust_prim[v] = (g_persist_veh_sd_data[base + 56] = 1)
        g_saved_veh_cust_prim_r[v] = g_persist_veh_sd_data[base + 57]
        g_saved_veh_cust_prim_g[v] = g_persist_veh_sd_data[base + 58]
        g_saved_veh_cust_prim_b[v] = g_persist_veh_sd_data[base + 59]

        g_saved_veh_has_cust_sec[v] = (g_persist_veh_sd_data[base + 60] = 1)
        g_saved_veh_cust_sec_r[v] = g_persist_veh_sd_data[base + 61]
        g_saved_veh_cust_sec_g[v] = g_persist_veh_sd_data[base + 62]
        g_saved_veh_cust_sec_b[v] = g_persist_veh_sd_data[base + 63]

        g_saved_veh_neon_enabled[v] = g_persist_veh_sd_data[base + 64]
        g_saved_veh_neon_r[v] = g_persist_veh_sd_data[base + 65]
        g_saved_veh_neon_g[v] = g_persist_veh_sd_data[base + 66]
        g_saved_veh_neon_b[v] = g_persist_veh_sd_data[base + 67]
        g_saved_veh_smoke_r[v] = g_persist_veh_sd_data[base + 68]
        g_saved_veh_smoke_g[v] = g_persist_veh_sd_data[base + 69]
        g_saved_veh_smoke_b[v] = g_persist_veh_sd_data[base + 70]

        g_saved_veh_turbo[v] = (g_persist_veh_sd_data[base + 71] = 1)
        g_saved_veh_xenon_toggle[v] = (g_persist_veh_sd_data[base + 72] = 1)
        g_saved_veh_smoke_toggle[v] = (g_persist_veh_sd_data[base + 73] = 1)
        g_saved_veh_hydro_toggle[v] = (g_persist_veh_sd_data[base + 74] = 1)
        g_saved_veh_extras[v] = g_persist_veh_sd_data[base + 75]

        INT m = 0
        INT baseModIdx = v * 50
        WHILE m < 50
            g_saved_veh_mods[baseModIdx + m] = g_persist_veh_sd_data[base + 76 + m]
            m = m + 1
        ENDWHILE

        v = v + 1
    ENDWHILE
ENDPROC

// Saves the current saved vehicles array to SD card file (megatard-vehicles-*.bin)
PROC PERSIST_SAVE_SAVED_VEHICLES()
    PERSIST_PACK_VEHICLES_TO_BUFFER()
    MEGASAVE(g_persist_veh_sd_data[0], PERSIST_VEH_BUFFER_WORDS, 2)
ENDPROC

// Loads saved vehicles from SD card file upon boot
FUNC BOOL PERSIST_LOAD_SAVED_VEHICLES()
    INT wordsRead = MEGALOAD(g_persist_veh_sd_data[0], PERSIST_VEH_BUFFER_WORDS, 2)
    IF wordsRead < 20
        RETURN FALSE
    ENDIF
    IF g_persist_veh_sd_data[0] != PERSIST_VEH_MAGIC OR g_persist_veh_sd_data[1] != PERSIST_VEH_VERSION
        RETURN FALSE
    ENDIF
    IF g_persist_veh_sd_data[3] != PERSIST_COMPUTE_VEH_SD_CHECKSUM()
        RETURN FALSE
    ENDIF
    PERSIST_UNPACK_VEHICLES_FROM_BUFFER()
    RETURN TRUE
ENDFUNC

// Commits the staged vehicle configuration with the user-provided name
PROC COMMIT_STAGED_VEHICLE_WITH_NAME(STRING name)
    IF g_saved_vehicles_count >= MAX_SAVED_VEHICLES
        EXIT
    ENDIF

    TEXT_LABEL_31 finalName = name
    IF IS_STRING_NULL_OR_EMPTY(finalName)
        finalName = g_save_stage_display_name
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(finalName)
        finalName = "Custom Vehicle"
    ENDIF

    INT v = g_saved_vehicles_count
    g_saved_veh_names[v] = finalName
    g_saved_veh_display_names[v] = g_save_stage_display_name
    g_saved_veh_model_hashes[v] = g_save_stage_model
    g_saved_veh_primary[v] = g_save_stage_primary
    g_saved_veh_secondary[v] = g_save_stage_secondary
    g_saved_veh_pearlescent[v] = g_save_stage_pearlescent
    g_saved_veh_wheel_colour[v] = g_save_stage_wheel_colour
    g_saved_veh_xenon[v] = g_save_stage_xenon
    g_saved_veh_window_tint[v] = g_save_stage_window_tint
    g_saved_veh_wheel_type[v] = g_save_stage_wheel_type
    g_saved_veh_custom_tyres[v] = g_save_stage_custom_tyres
    g_saved_veh_plate_style[v] = g_save_stage_plate_style
    g_saved_veh_plate_text[v] = g_save_stage_plate_text
    g_saved_veh_livery[v] = g_save_stage_livery
    g_saved_veh_roof_state[v] = g_save_stage_roof_state

    g_saved_veh_has_cust_prim[v] = g_save_stage_has_cust_prim
    g_saved_veh_cust_prim_r[v] = g_save_stage_cust_prim_r
    g_saved_veh_cust_prim_g[v] = g_save_stage_cust_prim_g
    g_saved_veh_cust_prim_b[v] = g_save_stage_cust_prim_b

    g_saved_veh_has_cust_sec[v] = g_save_stage_has_cust_sec
    g_saved_veh_cust_sec_r[v] = g_save_stage_cust_sec_r
    g_saved_veh_cust_sec_g[v] = g_save_stage_cust_sec_g
    g_saved_veh_cust_sec_b[v] = g_save_stage_cust_sec_b

    g_saved_veh_neon_enabled[v] = g_save_stage_neon_enabled
    g_saved_veh_neon_r[v] = g_save_stage_neon_r
    g_saved_veh_neon_g[v] = g_save_stage_neon_g
    g_saved_veh_neon_b[v] = g_save_stage_neon_b
    g_saved_veh_smoke_r[v] = g_save_stage_smoke_r
    g_saved_veh_smoke_g[v] = g_save_stage_smoke_g
    g_saved_veh_smoke_b[v] = g_save_stage_smoke_b

    g_saved_veh_turbo[v] = g_save_stage_turbo
    g_saved_veh_xenon_toggle[v] = g_save_stage_xenon_toggle
    g_saved_veh_smoke_toggle[v] = g_save_stage_smoke_toggle
    g_saved_veh_hydro_toggle[v] = g_save_stage_hydro_toggle
    g_saved_veh_extras[v] = g_save_stage_extras

    INT m = 0
    INT baseModIdx = v * 50
    WHILE m < 50
        g_saved_veh_mods[baseModIdx + m] = g_save_stage_mods[m]
        m = m + 1
    ENDWHILE

    g_saved_vehicles_count = g_saved_vehicles_count + 1
    g_saved_veh_feedback = 2
    g_saved_veh_feedback_until = GET_GAME_TIMER() + 2500

    PERSIST_SAVE_SAVED_VEHICLES()
ENDPROC

// Deletes a saved vehicle at targetSlot and shifts subsequent entries down
PROC DELETE_SAVED_VEHICLE(INT targetSlot)
    IF targetSlot < 0 OR targetSlot >= g_saved_vehicles_count
        EXIT
    ENDIF

    INT v = targetSlot
    WHILE v < g_saved_vehicles_count - 1
        INT nextV = v + 1
        g_saved_veh_names[v] = g_saved_veh_names[nextV]
        g_saved_veh_display_names[v] = g_saved_veh_display_names[nextV]
        g_saved_veh_model_hashes[v] = g_saved_veh_model_hashes[nextV]
        g_saved_veh_primary[v] = g_saved_veh_primary[nextV]
        g_saved_veh_secondary[v] = g_saved_veh_secondary[nextV]
        g_saved_veh_pearlescent[v] = g_saved_veh_pearlescent[nextV]
        g_saved_veh_wheel_colour[v] = g_saved_veh_wheel_colour[nextV]
        g_saved_veh_xenon[v] = g_saved_veh_xenon[nextV]
        g_saved_veh_window_tint[v] = g_saved_veh_window_tint[nextV]
        g_saved_veh_wheel_type[v] = g_saved_veh_wheel_type[nextV]
        g_saved_veh_custom_tyres[v] = g_saved_veh_custom_tyres[nextV]
        g_saved_veh_plate_style[v] = g_saved_veh_plate_style[nextV]
        g_saved_veh_plate_text[v] = g_saved_veh_plate_text[nextV]
        g_saved_veh_livery[v] = g_saved_veh_livery[nextV]
        g_saved_veh_roof_state[v] = g_saved_veh_roof_state[nextV]

        g_saved_veh_has_cust_prim[v] = g_saved_veh_has_cust_prim[nextV]
        g_saved_veh_cust_prim_r[v] = g_saved_veh_cust_prim_r[nextV]
        g_saved_veh_cust_prim_g[v] = g_saved_veh_cust_prim_g[nextV]
        g_saved_veh_cust_prim_b[v] = g_saved_veh_cust_prim_b[nextV]

        g_saved_veh_has_cust_sec[v] = g_saved_veh_has_cust_sec[nextV]
        g_saved_veh_cust_sec_r[v] = g_saved_veh_cust_sec_r[nextV]
        g_saved_veh_cust_sec_g[v] = g_saved_veh_cust_sec_g[nextV]
        g_saved_veh_cust_sec_b[v] = g_saved_veh_cust_sec_b[nextV]

        g_saved_veh_neon_enabled[v] = g_saved_veh_neon_enabled[nextV]
        g_saved_veh_neon_r[v] = g_saved_veh_neon_r[nextV]
        g_saved_veh_neon_g[v] = g_saved_veh_neon_g[nextV]
        g_saved_veh_neon_b[v] = g_saved_veh_neon_b[nextV]
        g_saved_veh_smoke_r[v] = g_saved_veh_smoke_r[nextV]
        g_saved_veh_smoke_g[v] = g_saved_veh_smoke_g[nextV]
        g_saved_veh_smoke_b[v] = g_saved_veh_smoke_b[nextV]

        g_saved_veh_turbo[v] = g_saved_veh_turbo[nextV]
        g_saved_veh_xenon_toggle[v] = g_saved_veh_xenon_toggle[nextV]
        g_saved_veh_smoke_toggle[v] = g_saved_veh_smoke_toggle[nextV]
        g_saved_veh_hydro_toggle[v] = g_saved_veh_hydro_toggle[nextV]
        g_saved_veh_extras[v] = g_saved_veh_extras[nextV]

        INT m = 0
        INT curModIdx = v * 50
        INT nextModIdx = nextV * 50
        WHILE m < 50
            g_saved_veh_mods[curModIdx + m] = g_saved_veh_mods[nextModIdx + m]
            m = m + 1
        ENDWHILE

        v = v + 1
    ENDWHILE

    g_saved_vehicles_count = g_saved_vehicles_count - 1

    IF g_saved_veh_selected_index = targetSlot
        g_saved_veh_selected_index = -1
    ELIF g_saved_veh_selected_index > targetSlot
        g_saved_veh_selected_index = g_saved_veh_selected_index - 1
    ENDIF

    PERSIST_SAVE_SAVED_VEHICLES()
ENDPROC

// Returns total selectable rows in Saved Vehicles submenu
FUNC INT SAVED_VEHICLES_TOTAL_ROWS()
    IF g_saved_vehicles_count > 0
        RETURN 1 + g_saved_vehicles_count
    ENDIF
    RETURN 2
ENDFUNC

// Draws a row in the Saved Vehicles submenu
PROC DRAW_SAVED_VEHICLES_ROW(INT index, FLOAT y)
    IF index = 0
        STRING saveLabel = TR("Save Vehicle", "Guardar vehículo", "保存载具", "Fahrzeug speichern", "車両を保存", "Сохранить ТС", "Salvar Veículo", "Sauvegarder véhicule")
        IF g_saved_veh_feedback = 1 AND GET_GAME_TIMER() < g_saved_veh_feedback_until
            DRAW_OPTION(y, saveLabel, TR("No Vehicle", "Sin vehículo", "不在载具内", "Kein Fahrzeug", "車両なし", "Нет транспорта", "Sem Veículo", "Aucun véhicule"), g_item = 0, 0)
        ELIF g_saved_veh_feedback = 2 AND GET_GAME_TIMER() < g_saved_veh_feedback_until
            DRAW_OPTION(y, saveLabel, TR("Saved!", "¡Guardado!", "已保存！", "Gespeichert!", "保存完了！", "Сохранено!", "Salvo!", "Sauvegardé !"), g_item = 0, 1)
        ELSE
            DRAW_OPTION(y, saveLabel, "APPLY", g_item = 0, 2)
        ENDIF
        EXIT
    ENDIF

    IF g_saved_vehicles_count <= 0
        DRAW_OPTION(y, TR("< No Saved Vehicles >", "< Sin vehículos guardados >", "< 暂无已保存载具 >", "< Keine gespeicherten Fahrzeuge >", "< 保存済み車両なし >", "< Нет сохраненных ТС >", "< Nenhum Veículo Salvo >", "< Aucun véhicule sauvegardé >"), "", g_item = index, 0)
        EXIT
    ENDIF

    INT vehSlot = index - 1
    IF vehSlot >= 0 AND vehSlot < g_saved_vehicles_count
        TEXT_LABEL_31 label = g_saved_veh_names[vehSlot]
        IF vehSlot = g_saved_veh_selected_index
            DRAW_OPTION(y, label, TR("SELECTED", "SELECCIONADO", "已选定", "AUSGEWÄHLT", "選択中", "ВЫБРАНО", "SELECIONADO", "SÉLECTIONNÉ"), g_item = index, 1)
        ELSE
            DRAW_OPTION(y, label, TR("SELECT", "SELECCIONAR", "选择", "WÄHLEN", "選択", "ВЫБРАТЬ", "SELECIONAR", "SÉLECTIONNER"), g_item = index, 2)
        ENDIF
    ENDIF
ENDPROC

// Draws the main Saved Vehicles submenu page
PROC DRAW_SAVED_VEHICLES_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("SAVED VEHICLES", "VEHÍCULOS GUARDADOS", "已保存载具", "GESPEICHERTE FAHRZEUGE", "保存済み車両", "СОХРАНЕННЫЕ ТС", "VEÍCULOS SALVOS", "VÉHICULES SAUVEGARDÉS"))
    DRAW_MENU_VERSION_TAG()
    INT totalRows = SAVED_VEHICLES_TOTAL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_SAVED_VEHICLES_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

// Draws the "Are you sure?" delete confirmation page
PROC DRAW_SAVED_VEH_CONFIRM_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("CONFIRM DELETE", "CONFIRMAR BORRADO", "确认删除", "LÖSCHEN BESTÄTIGEN", "削除の確認", "ПОДТВЕРДИТЕ УДАЛЕНИЕ", "CONFIRMAR EXCLUSÃO", "CONFIRMER SUPPRESSION"))
    DRAW_MENU_VERSION_TAG()

    FLOAT yPrompt = 0.230
    MENU_TEXT(g_menu_x - 0.130, yPrompt, 0.230, 255, 200, 60, TR("Delete this saved vehicle?", "¿Eliminar este vehículo guardado?", "确定删除此已保存载具？", "Dieses gespeicherte Fahrzeug löschen?", "この保存済み車両を削除しますか？", "Удалить этот сохраненный транспорт?", "Excluir este veículo salvo?", "Supprimer ce véhicule sauvegardé ?"))

    FLOAT y0 = 0.268
    FLOAT y1 = y0 + ROW_H

    DRAW_OPTION(y0, TR("No (Cancel)", "No (Cancelar)", "否（取消）", "Nein (Abbrechen)", "いいえ（キャンセル）", "Нет (Отмена)", "Não (Cancelar)", "Non (Annuler)"), "BACK", g_item = 0, 2)
    DRAW_OPTION(y1, TR("Yes (Delete)", "Sí (Eliminar)", "是（确认删除）", "Ja (Löschen)", "はい（削除）", "Да (Удалить)", "Sim (Excluir)", "Oui (Supprimer)"), "DELETE", g_item = 1, 0)
ENDPROC
