FUNC INT LSC_KIT_COUNT(VEHICLE_INDEX vehicle)
    INT kits = GET_NUM_MOD_KITS(vehicle)
    IF kits <= 0 RETURN 1 ENDIF
    RETURN kits
ENDFUNC

FUNC INT LSC_ACTIVE_KIT(VEHICLE_INDEX vehicle)
    INT kits = LSC_KIT_COUNT(vehicle)
    INT choice = g_lsc_kit_choice
    IF choice < 0 choice = GET_VEHICLE_MOD_KIT(vehicle) ENDIF
    IF choice < 0 choice = 0 ENDIF
    IF choice >= kits choice = kits - 1 ENDIF
    RETURN choice
ENDFUNC

PROC LSC_USE_KIT(VEHICLE_INDEX vehicle)
    SET_VEHICLE_MOD_KIT(vehicle, LSC_ACTIVE_KIT(vehicle))
ENDPROC

FUNC INT LSC_KIT_FOR_SLOT(VEHICLE_INDEX vehicle, INT slot)
    INT preferred = LSC_ACTIVE_KIT(vehicle)
    INT kits = LSC_KIT_COUNT(vehicle)
    SET_VEHICLE_MOD_KIT(vehicle, preferred)
    IF kits <= 1 RETURN preferred ENDIF
    IF GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot)) > 0 RETURN preferred ENDIF
    INT k = 0
    WHILE k < kits
        IF k != preferred
            SET_VEHICLE_MOD_KIT(vehicle, k)
            IF GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot)) > 0 RETURN k ENDIF
        ENDIF
        k = k + 1
    ENDWHILE
    SET_VEHICLE_MOD_KIT(vehicle, preferred)
    RETURN preferred
ENDFUNC

FUNC STRING LSC_KIT_TYPE_LABEL(VEHICLE_INDEX vehicle)
    MOD_KIT_TYPE kitType = GET_VEHICLE_MOD_KIT_TYPE(vehicle)
    IF kitType = MKT_SPORT RETURN "Sport" ENDIF
    IF kitType = MKT_SUV RETURN "SUV" ENDIF
    IF kitType = MKT_SPECIAL RETURN "Special" ENDIF
    RETURN "Standard"
ENDFUNC

FUNC STRING LSC_KIT_INDEX_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT active = LSC_ACTIVE_KIT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) + 1
    IF active = 1 RETURN "< Kit 1 >" ENDIF
    IF active = 2 RETURN "< Kit 2 >" ENDIF
    IF active = 3 RETURN "< Kit 3 >" ENDIF
    IF active = 4 RETURN "< Kit 4 >" ENDIF
    RETURN "< Kit 5+ >"
ENDFUNC

FUNC STRING LSC_KIT_COUNT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT kits = LSC_KIT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF kits <= 1 RETURN "< Stock Kit Only >" ENDIF
    IF kits = 2 RETURN "< 2 Kits >" ENDIF
    IF kits = 3 RETURN "< 3 Kits >" ENDIF
    RETURN "< 4+ Kits >"
ENDFUNC

FUNC STRING LSC_KIT_TYPE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    RETURN LSC_KIT_TYPE_LABEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

FUNC MODEL_NAMES BENNYS_CUSTOM_MODEL(INT index)
    SWITCH index
        CASE 0 RETURN BUCCANEER2 BREAK
        CASE 1 RETURN CHINO2 BREAK
        CASE 2 RETURN FACTION2 BREAK
        CASE 3 RETURN FACTION3 BREAK
        CASE 4 RETURN MINIVAN2 BREAK
        CASE 5 RETURN MOONBEAM2 BREAK
        CASE 6 RETURN PRIMO2 BREAK
        CASE 7 RETURN SABREGT2 BREAK
        CASE 8 RETURN SLAMVAN3 BREAK
        CASE 9 RETURN TORNADO5 BREAK
        CASE 10 RETURN VIRGO2 BREAK
        CASE 11 RETURN VOODOO BREAK
    ENDSWITCH
    RETURN ADDER
ENDFUNC

FUNC MODEL_NAMES BENNYS_STOCK_MODEL(INT index)
    SWITCH index
        CASE 0 RETURN BUCCANEER BREAK
        CASE 1 RETURN CHINO BREAK
        CASE 2 RETURN FACTION BREAK
        CASE 3 RETURN FACTION BREAK
        CASE 4 RETURN MINIVAN BREAK
        CASE 5 RETURN MOONBEAM BREAK
        CASE 6 RETURN PRIMO BREAK
        CASE 7 RETURN SABREGT BREAK
        CASE 8 RETURN SLAMVAN BREAK
        CASE 9 RETURN TORNADO BREAK
        CASE 10 RETURN VIRGO3 BREAK
        CASE 11 RETURN VOODOO2 BREAK
    ENDSWITCH
    RETURN ADDER
ENDFUNC

FUNC INT BENNYS_PAIR_FOR_MODEL(MODEL_NAMES model)
    INT index = 0
    WHILE index < BENNYS_MENU_ROWS
        IF BENNYS_STOCK_MODEL(index) = model
            IF index = 3 RETURN 2 ENDIF
            RETURN index
        ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

FUNC INT BENNYS_CUSTOM_PAIR_FOR_MODEL(MODEL_NAMES model)
    INT index = 0
    WHILE index < BENNYS_MENU_ROWS
        IF BENNYS_CUSTOM_MODEL(index) = model RETURN index ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

FUNC MODEL_NAMES LSC_PLAYER_VEHICLE_MODEL()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN ADDER ENDIF
    RETURN GET_ENTITY_MODEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

FUNC STRING VEHICLE_MODEL_NAME_TEXT(MODEL_NAMES model)
    IF NOT IS_MODEL_IN_CDIMAGE(model) RETURN "< Not In This Build >" ENDIF
    IF NOT IS_MODEL_VALID(model) RETURN "< Model Invalid >" ENDIF
    STRING modelName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)
    IF IS_STRING_NULL_OR_EMPTY(modelName) RETURN "< Unnamed >" ENDIF
    RETURN modelName
ENDFUNC

FUNC BOOL HYDRO_SUPPORTED(VEHICLE_INDEX vehicle)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN FALSE ENDIF
    RETURN GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) > 0
ENDFUNC

FUNC BOOL PLAYER_CAR_HAS_HYDRO()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN FALSE ENDIF
    RETURN HYDRO_SUPPORTED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

FUNC STRING LOWRIDER_SUPPORT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF PLAYER_CAR_HAS_HYDRO() RETURN "< Custom - Supported >" ENDIF
    IF BENNYS_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN "< Stock - Convert First >" ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN "< Custom - No Hydro >" ENDIF
    RETURN "< No Lowrider Kit >"
ENDFUNC

FUNC STRING BENNYS_VARIANT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    MODEL_NAMES current = LSC_PLAYER_VEHICLE_MODEL()
    INT pair = BENNYS_PAIR_FOR_MODEL(current)
    IF pair >= 0 RETURN VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(pair)) ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(current) >= 0 RETURN "< Already Custom >" ENDIF
    RETURN "< None For This Car >"
ENDFUNC

FUNC STRING BENNYS_BASE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT pair = BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL())
    IF pair >= 0 RETURN VEHICLE_MODEL_NAME_TEXT(BENNYS_STOCK_MODEL(pair)) ENDIF
    RETURN "< Stock Car Already >"
ENDFUNC

FUNC STRING CONVERT_STATUS_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF g_convert_pending RETURN "< Working... >" ENDIF
    IF g_convert_feedback != 0 AND GET_GAME_TIMER() < g_convert_feedback_until
        IF g_convert_feedback = 1 RETURN "< Converted >" ENDIF
        IF g_convert_feedback = 2 RETURN "< No Variant For This Car >" ENDIF
        IF g_convert_feedback = 3 RETURN "< Not In This Build >" ENDIF
        IF g_convert_feedback = 4 RETURN "< Conversion Failed >" ENDIF
        IF g_convert_feedback = 5 RETURN "< Timed Out >" ENDIF
    ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN "< Already Custom >" ENDIF
    IF BENNYS_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN "< Ready >" ENDIF
    RETURN "< No Variant >"
ENDFUNC

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
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    IF available <= 0
        g_lsc_mod_choice = -1
        EXIT
    ENDIF
    IF g_lsc_mod_choice >= available g_lsc_mod_choice = available - 1 ENDIF
    IF g_lsc_mod_choice < 0
        REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    ELSE
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), g_lsc_mod_choice)
    ENDIF
ENDPROC

PROC SYNC_LSC_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    g_lsc_mod_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
ENDPROC

PROC ADJUST_LSC_MOD(INT direction)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
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
    INT windowTint = 0
    INT trimColour = 0
    INT metalColour = 0
    g_lsc_kit_choice = LSC_ACTIVE_KIT(vehicle)
    LSC_USE_KIT(vehicle)
    IF g_lsc_vehicle != vehicle g_hydro_hold = FALSE ENDIF
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
    windowTint = GET_VEHICLE_WINDOW_TINT(vehicle)
    IF windowTint < 0 OR windowTint > 6 windowTint = 0 ENDIF
    g_lsc_window_tint = windowTint
    g_lsc_livery = GET_VEHICLE_LIVERY(vehicle)
    IF g_lsc_livery < 0 OR g_lsc_livery >= GET_VEHICLE_LIVERY_COUNT(vehicle) g_lsc_livery = -1 ENDIF
    GET_VEHICLE_EXTRA_COLOUR_5(vehicle, trimColour)
    GET_VEHICLE_EXTRA_COLOUR_6(vehicle, metalColour)
    IF trimColour < 0 trimColour = 0 ENDIF
    IF metalColour < 0 metalColour = 0 ENDIF
    g_lsc_trim_colour = trimColour
    g_lsc_metal_colour = metalColour
    g_lsc_extra_exists = FALSE
    g_lsc_extra_on = FALSE
    g_hydro_enabled = IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_HYDRAULICS)
    g_hydro_level = GET_VEHICLE_MOD(vehicle, MOD_HYDRO)
    IF g_hydro_level < 0 OR g_hydro_level >= GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) g_hydro_level = -1 ENDIF
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

PROC DRAW_LSC_WINDOW_TINT_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_lsc_window_tint
        CASE 0 DRAW_OPTION(y, "Window Tint", "< Stock >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Window Tint", "< Limo >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Window Tint", "< Light Smoke >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Window Tint", "< Dark Smoke >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Window Tint", "< Pure Black >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Window Tint", "< Green >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Window Tint", "< Light Green >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_PLATE_ROW(FLOAT y, BOOL selected)
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, "Plate Text", "NO VEHICLE", selected, 0)
        EXIT
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(g_plate_value)
        DRAW_OPTION(y, "Plate Text", GET_VEHICLE_NUMBER_PLATE_TEXT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())), selected, 3)
    ELSE
        DRAW_OPTION(y, "Plate Text", g_plate_value, selected, 3)
    ENDIF
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

PROC APPLY_VEHICLE_GOD_STATE(VEHICLE_INDEX vehicle, BOOL enabled)
    IF enabled
        SET_ENTITY_INVINCIBLE(vehicle, TRUE)
        SET_ENTITY_PROOFS(vehicle, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
        SET_VEHICLE_STRONG(vehicle, TRUE)
        SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, FALSE)
        SET_VEHICLE_CAN_BREAK(vehicle, FALSE)
        SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, FALSE)
        SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
    ELSE
        SET_ENTITY_INVINCIBLE(vehicle, FALSE)
        SET_ENTITY_PROOFS(vehicle, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
        SET_VEHICLE_STRONG(vehicle, FALSE)
        SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, TRUE)
        SET_VEHICLE_CAN_BREAK(vehicle, TRUE)
        SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, TRUE)
    ENDIF
ENDPROC

PROC MAINTAIN_VEHICLE_GOD_STATE(VEHICLE_INDEX vehicle)
    IF NOT g_vehicle_god EXIT ENDIF
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    SET_ENTITY_INVINCIBLE(vehicle, TRUE)
    SET_ENTITY_PROOFS(vehicle, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
    SET_VEHICLE_STRONG(vehicle, TRUE)
    SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, FALSE)
    SET_VEHICLE_CAN_BREAK(vehicle, FALSE)
    SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, FALSE)
    SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
ENDPROC

PROC APPLY_LSC_MAX_TO_VEHICLE(VEHICLE_INDEX vehicle)
    INT slot = 0
    LSC_USE_KIT(vehicle)
    WHILE slot <= ENUM_TO_INT(MOD_LIVERY)
        IF slot < ENUM_TO_INT(MOD_TOGGLE_NITROUS) OR slot > ENUM_TO_INT(MOD_TOGGLE_XENON_LIGHTS)
            INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
            IF available > 0 SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), available - 1) ENDIF
        ENDIF
        slot = slot + 1
    ENDWHILE
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TURBO, TRUE)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_XENON_LIGHTS, TRUE)
    SET_VEHICLE_WINDOW_TINT(vehicle, 1)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, TRUE)
ENDPROC

PROC APPLY_LSC_MAX()
    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    SYNC_LSC_VEHICLE_STATE()
ENDPROC

PROC APPLY_LSC_STOCK_TO_VEHICLE(VEHICLE_INDEX vehicle)
    INT slot = 0
    LSC_USE_KIT(vehicle)
    WHILE slot <= ENUM_TO_INT(MOD_LIVERY)
        IF slot < ENUM_TO_INT(MOD_TOGGLE_NITROUS) OR slot > ENUM_TO_INT(MOD_TOGGLE_XENON_LIGHTS)
            REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
        ENDIF
        slot = slot + 1
    ENDWHILE
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TURBO, FALSE)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_XENON_LIGHTS, FALSE)
    SET_VEHICLE_COLOURS(vehicle, 0, 0)
    SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0)
    SET_VEHICLE_WINDOW_TINT(vehicle, 0)
    SET_VEHICLE_WHEEL_TYPE(vehicle, INT_TO_ENUM(MOD_WHEEL_TYPE, 0))
    SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 0)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, FALSE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, FALSE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, FALSE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, FALSE)
ENDPROC

PROC APPLY_LSC_STOCK()
    APPLY_LSC_STOCK_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
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

FUNC STRING WHEEL_FAMILY_LABEL(INT family)
    SWITCH family
        CASE 0 RETURN "< Sport >" BREAK
        CASE 1 RETURN "< Muscle >" BREAK
        CASE 2 RETURN "< Lowrider >" BREAK
        CASE 3 RETURN "< SUV >" BREAK
        CASE 4 RETURN "< Offroad >" BREAK
        CASE 5 RETURN "< Tuner >" BREAK
        CASE 6 RETURN "< Bike >" BREAK
        CASE 7 RETURN "< Hi-End >" BREAK
        CASE 8 RETURN "< Supermod 1 >" BREAK
        CASE 9 RETURN "< Supermod 2 >" BREAK
        CASE 10 RETURN "< Supermod 3 >" BREAK
        CASE 11 RETURN "< Supermod 4 >" BREAK
        CASE 12 RETURN "< Supermod 5 >" BREAK
    ENDSWITCH
    RETURN "< Sport >"
ENDFUNC

PROC DRAW_LSC_SCROLL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < LSC_MENU_ROWS
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        SWITCH index
            CASE 0 DRAW_OPTION(y, "Max All Available Mods", "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_OPTION(y, "Return To Stock", "APPLY", g_item = index, 2) BREAK
            CASE 2 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
            CASE 3 DRAW_LSC_MOD_SELECTOR(y, g_item = index) BREAK
            CASE 4 DRAW_LSC_VARIANT_COUNT(y, g_item = index) BREAK
            CASE 5 DRAW_LSC_COLOUR_SELECTOR(y, "Primary Paint", g_lsc_primary_colour, g_item = index) BREAK
            CASE 6 DRAW_LSC_COLOUR_SELECTOR(y, "Secondary Paint", g_lsc_secondary_colour, g_item = index) BREAK
            CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, "Pearlescent Paint", g_lsc_pearlescent_colour, g_item = index) BREAK
            CASE 8 DRAW_LSC_COLOUR_SELECTOR(y, "Wheel Colour", g_lsc_wheel_colour, g_item = index) BREAK
            CASE 9 DRAW_OPTION(y, "Wheel Type", WHEEL_FAMILY_LABEL(g_lsc_wheel_type), g_item = index, 3) BREAK
            CASE 10 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 11 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon Lights", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 12 DRAW_LSC_LIGHT_SELECTOR(y, "Xenon Colour", g_lsc_xenon_colour, g_item = index) BREAK
            CASE 13 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon Kit", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 14 DRAW_LSC_LIGHT_SELECTOR(y, "Neon Colour", g_lsc_neon_colour, g_item = index) BREAK
            CASE 15 DRAW_LSC_WINDOW_TINT_SELECTOR(y, g_item = index) BREAK
            CASE 16 DRAW_LSC_PLATE_ROW(y, g_item = index) BREAK
            CASE 17 DRAW_OPTION(y, "Apply Plate Text", "APPLY", g_item = index, 2) BREAK
            CASE 18 DRAW_OPTION(y, "Clear Selected Slot", "APPLY", g_item = index, 2) BREAK
            CASE 19 DRAW_OPTION(y, "Mod Kit", LSC_KIT_INDEX_TEXT(), g_item = index, 3) BREAK
            CASE 20 DRAW_OPTION(y, "Mod Kit Type", LSC_KIT_TYPE_TEXT(), g_item = index, 2) BREAK
            CASE 21 DRAW_OPTION(y, "Mod Kit Count", LSC_KIT_COUNT_TEXT(), g_item = index, 2) BREAK
            CASE 22 DRAW_OPTION(y, "Hydraulics & Bounce", "OPEN", g_item = index, 2) BREAK
            CASE 23 DRAW_OPTION(y, "Lowrider Interior", "OPEN", g_item = index, 2) BREAK
            CASE 24 DRAW_OPTION(y, "Wheels & Tyres", "OPEN", g_item = index, 2) BREAK
            CASE 25 DRAW_OPTION(y, "Extras & Livery", "OPEN", g_item = index, 2) BREAK
            CASE 26 DRAW_OPTION(y, "Bennys & Lowriders", "OPEN", g_item = index, 2) BREAK
            CASE 27 DRAW_OPTION(y, "Convert To Custom", CONVERT_STATUS_TEXT(), g_item = index, 2) BREAK
            CASE 28 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, "Vehicle Support Check", LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, "Vehicle Support Check", LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
        ENDSWITCH
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_LSC_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "LS CUSTOMS")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Vehicle Upgrades", "NO VEHICLE", g_item = 0, 0)
    ELSE
        DRAW_LSC_SCROLL_ROWS()
    ENDIF
ENDPROC

FUNC MODEL_NAMES MISC_VEHICLE_MODEL(INT index)
    SWITCH index
        CASE 89 RETURN AVARUS BREAK
        CASE 90 RETURN BANSHEE BREAK
        CASE 91 RETURN BULLET BREAK
        CASE 92 RETURN COQUETTE BREAK
        CASE 93 RETURN PHOENIX BREAK
        CASE 94 RETURN SURANO BREAK
        CASE 95 RETURN VACCA BREAK
        CASE 96 RETURN STINGER BREAK
        CASE 97 RETURN EXEMPLAR BREAK
        CASE 98 RETURN JACKAL BREAK
        CASE 99 RETURN ORACLE BREAK
        CASE 100 RETURN FELON BREAK
        CASE 101 RETURN SCHAFTER2 BREAK
        CASE 102 RETURN TAILGATER BREAK
        CASE 103 RETURN WASHINGTON BREAK
        CASE 104 RETURN COGNOSCENTI BREAK
        CASE 105 RETURN BALLER2 BREAK
        CASE 106 RETURN CAVALCADE BREAK
        CASE 107 RETURN DUBSTA BREAK
        CASE 108 RETURN FQ2 BREAK
        CASE 109 RETURN PATRIOT BREAK
        CASE 110 RETURN HUNTLEY BREAK
        CASE 111 RETURN ROCOTO BREAK
        CASE 112 RETURN SEMINOLE BREAK
        CASE 113 RETURN LANDSTALKER BREAK
        CASE 114 RETURN BISON BREAK
        CASE 115 RETURN BOBCATXL BREAK
        CASE 116 RETURN SADLER BREAK
        CASE 117 RETURN PRIMO BREAK
        CASE 118 RETURN GRANGER2 BREAK
        CASE 119 RETURN BLAZER BREAK
        CASE 120 RETURN SANCHEZ2 BREAK
        CASE 121 RETURN BAGGER BREAK
        CASE 122 RETURN DAEMON BREAK
        CASE 123 RETURN HEXER BREAK
        CASE 124 RETURN NEMESIS BREAK
        CASE 125 RETURN RUFFIAN BREAK
        CASE 126 RETURN VADER BREAK
        CASE 127 RETURN THRUST BREAK
        CASE 128 RETURN VINDICATOR BREAK
        CASE 129 RETURN RHINO BREAK
        CASE 130 RETURN BULLDOZER BREAK
        CASE 131 RETURN FORKLIFT BREAK
        CASE 132 RETURN MIXER BREAK
        CASE 133 RETURN HAULER BREAK
        CASE 134 RETURN PACKER BREAK
        CASE 135 RETURN FIRETRUK BREAK
        CASE 136 RETURN TAXI BREAK
        CASE 137 RETURN POLICE BREAK
        CASE 138 RETURN SHERIFF BREAK
        CASE 139 RETURN BUS BREAK
        CASE 140 RETURN AMBULANCE BREAK
        CASE 141 RETURN TOWTRUCK BREAK
        CASE 142 RETURN TRASH BREAK
        CASE 143 RETURN DOCKTUG BREAK
        CASE 144 RETURN TRACTOR2 BREAK
        CASE 145 RETURN MAVERICK BREAK
        CASE 146 RETURN FROGGER BREAK
        CASE 147 RETURN SHAMAL BREAK
        CASE 148 RETURN MAMMATUS BREAK
        CASE 149 RETURN DODO BREAK
        CASE 150 RETURN STUNT BREAK
        CASE 151 RETURN PREDATOR BREAK
        CASE 152 RETURN FELTZER3 BREAK
        CASE 153 RETURN OSIRIS BREAK
        CASE 154 RETURN BRAWLER BREAK
        CASE 155 RETURN T20 BREAK
        CASE 156 RETURN MOONBEAM BREAK
        CASE 157 RETURN VOODOO BREAK
        CASE 158 RETURN SABREGT2 BREAK
        CASE 159 RETURN SLAMVAN3 BREAK
        CASE 160 RETURN BRICKADE BREAK
        CASE 161 RETURN FREECRAWLER BREAK
        CASE 162 RETURN MENACER BREAK
        CASE 163 RETURN SCRAMJET BREAK
        CASE 164 RETURN TERBYTE BREAK
        CASE 165 RETURN OPPRESSOR2 BREAK
        CASE 166 RETURN CARACARA BREAK
        CASE 167 RETURN HOTRING BREAK
        CASE 168 RETURN SEASPARROW BREAK
        CASE 169 RETURN TAMPA3 BREAK
        CASE 170 RETURN FORMULA BREAK
        CASE 171 RETURN OUTLAW BREAK
        CASE 172 RETURN ZHABA BREAK
        CASE 173 RETURN KOSATKA BREAK
        CASE 174 RETURN TOREADOR BREAK
        CASE 175 RETURN RCBANDITO BREAK
        CASE 176 RETURN ASTRON BREAK
        CASE 177 RETURN CHAMPION BREAK
        CASE 178 RETURN SULTAN2 BREAK
        CASE 179 RETURN VAGRANT BREAK
        CASE 180 RETURN CLIQUE BREAK
        CASE 181 RETURN DEVIANT BREAK
        CASE 182 RETURN SCHLAGEN BREAK
        CASE 183 RETURN ITALIGTO BREAK
        CASE 184 RETURN TOROS BREAK
        CASE 185 RETURN VAMOS BREAK
        CASE 186 RETURN JB7002 BREAK
        CASE 187 RETURN TRAILERLARGE BREAK
        CASE 188 RETURN TRAILERS4 BREAK
        CASE 189 RETURN TRAILERSMALL2 BREAK
    ENDSWITCH
    RETURN ADDER
ENDFUNC

FUNC MODEL_NAMES CURRENT_SPAWNER_MODEL()
    IF g_vehicle_spawn_choice >= 89 RETURN MISC_VEHICLE_MODEL(g_vehicle_spawn_choice) ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() > 0 AND g_dlc_vehicle_index >= 0
            RETURN GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
        ENDIF
        RETURN ADDER
    ENDIF
    SWITCH g_vehicle_spawn_choice
        CASE 0 RETURN ADDER BREAK
        CASE 1 RETURN BUFFALO BREAK
        CASE 2 RETURN CHEETAH BREAK
        CASE 3 RETURN COMET2 BREAK
        CASE 4 RETURN ENTITYXF BREAK
        CASE 5 RETURN INFERNUS BREAK
        CASE 6 RETURN SULTAN BREAK
        CASE 7 RETURN RAPIDGT BREAK
        CASE 8 RETURN CARBONIZZARE BREAK
        CASE 9 RETURN FELTZER2 BREAK
        CASE 10 RETURN NINEF BREAK
        CASE 11 RETURN DOMINATOR BREAK
        CASE 12 RETURN GAUNTLET BREAK
        CASE 13 RETURN ELEGY2 BREAK
        CASE 14 RETURN BALLER BREAK
        CASE 15 RETURN GRANGER BREAK
        CASE 16 RETURN SANDKING BREAK
        CASE 17 RETURN MESA BREAK
        CASE 18 RETURN AIRBUS BREAK
        CASE 19 RETURN BATI BREAK
        CASE 20 RETURN PCJ BREAK
        CASE 21 RETURN AKUMA BREAK
        CASE 22 RETURN SANCHEZ BREAK
        CASE 23 RETURN FAGGIO BREAK
        CASE 24 RETURN BUZZARD BREAK
        CASE 25 RETURN DUSTER BREAK
        CASE 26 RETURN CARGOBOB BREAK
        CASE 27 RETURN LAZER BREAK
        CASE 28 RETURN BLAZER4 BREAK
        CASE 29 RETURN CHIMERA BREAK
        CASE 30 RETURN DAEMON2 BREAK
        CASE 31 RETURN DEFILER BREAK
        CASE 32 RETURN ESSKEY BREAK
        CASE 33 RETURN FAGGIO3 BREAK
        CASE 34 RETURN HAKUCHOU2 BREAK
        CASE 35 RETURN MANCHEZ BREAK
        CASE 36 RETURN NIGHTBLADE BREAK
        CASE 37 RETURN RAPTOR BREAK
        CASE 38 RETURN RATBIKE BREAK
        CASE 39 RETURN SANCTUS BREAK
        CASE 40 RETURN SHOTARO BREAK
        CASE 41 RETURN TORNADO6 BREAK
        CASE 42 RETURN VORTEX BREAK
        CASE 43 RETURN WOLFSBANE BREAK
        CASE 44 RETURN YOUGA2 BREAK
        CASE 45 RETURN ZOMBIEA BREAK
        CASE 46 RETURN ZOMBIEB BREAK
        CASE 47 RETURN JESTER2 BREAK
        CASE 48 RETURN MASSACRO2 BREAK
        CASE 49 RETURN RATLOADER2 BREAK
        CASE 50 RETURN SLAMVAN BREAK
        CASE 51 RETURN BARRACKS3 BREAK
        CASE 52 RETURN BOXVILLE4 BREAK
        CASE 53 RETURN CASCO BREAK
        CASE 54 RETURN DINGHY BREAK
        CASE 55 RETURN ENDURO BREAK
        CASE 56 RETURN GBURRITO2 BREAK
        CASE 57 RETURN GUARDIAN BREAK
        CASE 58 RETURN HYDRA BREAK
        CASE 59 RETURN INSURGENT BREAK
        CASE 60 RETURN INSURGENT2 BREAK
        CASE 61 RETURN KURUMA BREAK
        CASE 62 RETURN KURUMA2 BREAK
        CASE 63 RETURN LECTRO BREAK
        CASE 64 RETURN MULE3 BREAK
        CASE 65 RETURN SAVAGE BREAK
        CASE 66 RETURN SLAMVAN2 BREAK
        CASE 67 RETURN TANKER2 BREAK
        CASE 68 RETURN TECHNICAL BREAK
        CASE 69 RETURN TRASH2 BREAK
        CASE 70 RETURN VALKYRIE BREAK
        CASE 71 RETURN VELUM2 BREAK
        CASE 72 RETURN DINGHY BREAK
        CASE 73 RETURN DINGHY2 BREAK
        CASE 74 RETURN DINGHY3 BREAK
        CASE 75 RETURN JETMAX BREAK
        CASE 76 RETURN MARQUIS BREAK
        CASE 77 RETURN SEASHARK BREAK
        CASE 78 RETURN SEASHARK2 BREAK
        CASE 79 RETURN SEASHARK3 BREAK
        CASE 80 RETURN SPEEDER BREAK
        CASE 81 RETURN SPEEDER2 BREAK
        CASE 82 RETURN SQUALO BREAK
        CASE 83 RETURN SUBMERSIBLE BREAK
        CASE 84 RETURN SUNTRAP BREAK
        CASE 85 RETURN TORO BREAK
        CASE 86 RETURN TORO2 BREAK
        CASE 87 RETURN TROPIC BREAK
        CASE 88 RETURN TUG BREAK
    ENDSWITCH
    RETURN ADDER
ENDFUNC

PROC CLEANUP_VEHICLE_PREVIEW()
    IF DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_vehicle_preview_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_vehicle_preview_vehicle)
    ENDIF
    g_vehicle_preview_vehicle = NULL
ENDPROC

PROC SYNC_VEHICLE_PREVIEW_MODEL()
    MODEL_NAMES wantedModel = CURRENT_SPAWNER_MODEL()
    IF wantedModel != g_vehicle_preview_model
        CLEANUP_VEHICLE_PREVIEW()
        g_vehicle_preview_model = wantedModel
    ENDIF
ENDPROC

PROC PROCESS_VEHICLE_PREVIEW()
    VECTOR previewPosition = <<0.0, 0.0, 0.0>>
    FLOAT previewHeading = 0.0
    IF NOT g_vehicle_preview_enabled EXIT ENDIF
    IF NOT g_spawner_open
        CLEANUP_VEHICLE_PREVIEW()
        EXIT
    ENDIF
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        CLEANUP_VEHICLE_PREVIEW()
        EXIT
    ENDIF
    SYNC_VEHICLE_PREVIEW_MODEL()
    IF NOT IS_MODEL_IN_CDIMAGE(g_vehicle_preview_model) OR NOT IS_MODEL_VALID(g_vehicle_preview_model) EXIT ENDIF
    IF NOT DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
        IF NOT HAS_MODEL_LOADED(g_vehicle_preview_model)
            REQUEST_MODEL(g_vehicle_preview_model)
            g_vehicle_preview_request_time = GET_GAME_TIMER()
            EXIT
        ENDIF
        previewPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.5>>)
        previewHeading = GET_ENTITY_HEADING(PLAYER_PED_ID()) + 90.0
        g_vehicle_preview_vehicle = CREATE_VEHICLE(g_vehicle_preview_model, previewPosition, previewHeading, FALSE)
        IF DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
            FREEZE_ENTITY_POSITION(g_vehicle_preview_vehicle, TRUE)
            SET_ENTITY_COLLISION(g_vehicle_preview_vehicle, FALSE, FALSE)
            SET_ENTITY_CAN_BE_DAMAGED(g_vehicle_preview_vehicle, FALSE)
            SET_ENTITY_PROOFS(g_vehicle_preview_vehicle, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
            SET_ENTITY_ALPHA(g_vehicle_preview_vehicle, 200, FALSE)
            SET_VEHICLE_DOORS_LOCKED(g_vehicle_preview_vehicle, VEHICLELOCK_LOCKED)
        ENDIF
        SET_MODEL_AS_NO_LONGER_NEEDED(g_vehicle_preview_model)
        EXIT
    ENDIF
    IF GET_GAME_TIMER() > g_vehicle_preview_request_time + 8000
        SET_MODEL_AS_NO_LONGER_NEEDED(g_vehicle_preview_model)
    ENDIF
    previewPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.5>>)
    previewHeading = GET_ENTITY_HEADING(PLAYER_PED_ID()) + 90.0
    SET_ENTITY_COORDS(g_vehicle_preview_vehicle, previewPosition, TRUE, TRUE, TRUE, TRUE)
    SET_ENTITY_HEADING(g_vehicle_preview_vehicle, previewHeading)
ENDPROC

PROC START_VEHICLE_MODEL_SPAWN(MODEL_NAMES model)
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model) EXIT ENDIF
    CLEANUP_VEHICLE_PREVIEW()
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

PROC PROCESS_QUICK_VEHICLE_ENTRY_EXIT_FROM_MENU(PED_INDEX playerPed)
    IF NOCLIP_VEHICLE_ENTRY_BLOCKED() EXIT ENDIF
    VEHICLE_INDEX menuNearbyVehicle = GET_CLOSEST_VEHICLE(GET_ENTITY_COORDS(playerPed), 7.5, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_LAW_ENFORCER_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_MISSION_VEHICLES)
    IF DOES_ENTITY_EXIST(menuNearbyVehicle)
        SET_PED_INTO_VEHICLE(playerPed, menuNearbyVehicle, VS_DRIVER)
    ENDIF
ENDPROC

PROC OPEN_MENU_KEYBOARD(INT target)
    IF g_keyboard_active EXIT ENDIF
    g_keyboard_target = target
    g_keyboard_active = TRUE
    IF target = 3
        g_ped_search_not_found = FALSE
    ENDIF
    IF target = 3
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 64)
    ELIF target = 10
        g_guard_ped_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 64)
    ELIF target = 11
        g_attacker_ped_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 64)
    ELIF target = 13
        g_chauffeur_ped_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 64)
    ELIF target = 4
        g_vehicle_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "VEHICLE MODEL", "TYPE MODEL NAME", "", "", "", "", 64)
    ELIF target = 8
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "CUSTOM IPL", "TYPE IPL NAME", "", "", "", "", 64)
    ELIF target = 9
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "LICENSE PLATE", "8 CHARACTERS MAX", "", "", "", "", 8)
    ELIF target = 14
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PROP MODEL", "TYPE MODEL NAME OR HASH", "", "", "", "", 64)
    ELIF target = 15
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "CUSTOM NSC", "TYPE .NSC FILE NAME", "", "", "", "", 64)
    ELSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "ENTER VALUE", "NUMBERS ONLY", "", "", "", "", 16)
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
    IF status = OSK_PENDING EXIT ENDIF
    IF status = OSK_SUCCESS
        INT parsed = 0
        INT foundChoice = -1
        FLOAT parsedCoordinate = 0.0
        STRING result = GET_ONSCREEN_KEYBOARD_RESULT()
        IF IS_STRING_NULL_OR_EMPTY(result)
            g_keyboard_active = FALSE
            EXIT
        ENDIF
        IF g_keyboard_target = 3
            foundChoice = FIND_PED_CHOICE_BY_NAME(result)
            IF foundChoice >= 0
                g_ped_search_not_found = FALSE
                g_ped_search_has_value = TRUE
                g_ped_search_is_custom = FALSE
                g_ped_search_value = result
                g_ped_choice = foundChoice
                g_item = foundChoice + 3
                SAVE_ACTIVE_CHARACTER_PED()
                REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(foundChoice))
                IF NOT g_ped_change_pending
                    g_ped_search_not_found = TRUE
                    g_ped_search_has_value = FALSE
                ENDIF
            ELSE
                MODEL_NAMES customPedModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
                IF IS_MODEL_IN_CDIMAGE(customPedModel) AND IS_MODEL_VALID(customPedModel)
                    g_ped_search_not_found = FALSE
                    g_ped_search_has_value = TRUE
                    g_ped_search_is_custom = TRUE
                    g_ped_search_value = result
                    g_current_ped_label = result
                    g_current_ped_label_model = customPedModel
                    SAVE_ACTIVE_CHARACTER_PED()
                    REQUEST_PED_CHANGE(customPedModel)
                    IF NOT g_ped_change_pending
                        g_ped_search_not_found = TRUE
                        g_ped_search_has_value = FALSE
                        g_ped_search_is_custom = FALSE
                    ENDIF
                ELSE
                    g_ped_search_not_found = TRUE
                    g_ped_search_has_value = FALSE
                    g_ped_search_is_custom = FALSE
                    g_ped_search_value = result
                ENDIF
            ENDIF
        ELIF g_keyboard_target = 10
            g_guard_ped_choice = FIND_PED_CHOICE_BY_NAME(result)
            IF g_guard_ped_choice >= 0
                g_guard_ped_name = PED_NAME_FOR_CHOICE(g_guard_ped_choice)
                g_guard_ped_search_is_custom = FALSE
                g_guard_ped_search_not_found = FALSE
            ELSE
                MODEL_NAMES customGuardModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
                IF IS_MODEL_IN_CDIMAGE(customGuardModel) AND IS_MODEL_VALID(customGuardModel)
                    g_guard_ped_name = result
                    g_guard_ped_model = customGuardModel
                    g_guard_ped_search_is_custom = TRUE
                    g_guard_ped_search_not_found = FALSE
                ELSE
                    g_guard_ped_search_is_custom = FALSE
                    g_guard_ped_search_not_found = TRUE
                ENDIF
            ENDIF
        ELIF g_keyboard_target = 11
            g_attacker_ped_choice = FIND_PED_CHOICE_BY_NAME(result)
            IF g_attacker_ped_choice >= 0
                g_attacker_ped_name = PED_NAME_FOR_CHOICE(g_attacker_ped_choice)
                g_attacker_ped_search_is_custom = FALSE
                g_attacker_ped_search_not_found = FALSE
            ELSE
                MODEL_NAMES customAttackerModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
                IF IS_MODEL_IN_CDIMAGE(customAttackerModel) AND IS_MODEL_VALID(customAttackerModel)
                    g_attacker_ped_name = result
                    g_attacker_ped_model = customAttackerModel
                    g_attacker_ped_search_is_custom = TRUE
                    g_attacker_ped_search_not_found = FALSE
                ELSE
                    g_attacker_ped_search_is_custom = FALSE
                    g_attacker_ped_search_not_found = TRUE
                ENDIF
            ENDIF
        ELIF g_keyboard_target = 13
            g_chauffeur_ped_choice = FIND_PED_CHOICE_BY_NAME(result)
            IF g_chauffeur_ped_choice >= 0
                g_chauffeur_ped_name = PED_NAME_FOR_CHOICE(g_chauffeur_ped_choice)
                g_chauffeur_ped_search_is_custom = FALSE
                g_chauffeur_ped_search_not_found = FALSE
            ELSE
                MODEL_NAMES customChauffeurModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
                IF IS_MODEL_IN_CDIMAGE(customChauffeurModel) AND IS_MODEL_VALID(customChauffeurModel)
                    g_chauffeur_ped_name = result
                    g_chauffeur_ped_model = customChauffeurModel
                    g_chauffeur_ped_search_is_custom = TRUE
                    g_chauffeur_ped_search_not_found = FALSE
                ELSE
                    g_chauffeur_ped_search_is_custom = FALSE
                    g_chauffeur_ped_search_not_found = TRUE
                ENDIF
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
        ELIF g_keyboard_target = 9
            g_plate_value = result
        ELIF g_keyboard_target = 14
            g_spooner_custom_model_input = result
            MODEL_NAMES spoonerModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
            IF STRING_TO_INT(result, parsed)
                spoonerModel = INT_TO_ENUM(MODEL_NAMES, parsed)
            ENDIF
            QUEUE_SPOONER_OBJECT_SPAWN(spoonerModel)
        ELIF g_keyboard_target = 15
            PROBE_CUSTOM_NSC_FROM_KEYBOARD(result)
        ELIF g_keyboard_target >= 5 AND g_keyboard_target <= 7
            IF PARSE_FLOAT_COORDINATE(result, parsedCoordinate)
                IF g_keyboard_target = 5 g_teleport_x = parsedCoordinate ENDIF
                IF g_keyboard_target = 6 g_teleport_y = parsedCoordinate ENDIF
                IF g_keyboard_target = 7 g_teleport_z = parsedCoordinate ENDIF
            ENDIF
        ELIF g_keyboard_target = 12
            IF STRING_TO_INT(result, parsed)
                IF parsed < 0 parsed = 0 ENDIF
                IF parsed > 120 parsed = 120 ENDIF
                g_auto_save_interval = parsed
                IF g_auto_save g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000) ENDIF
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

PROC PRUNE_SPAWNED_VEHICLE_TRACKING()
    INT readIndex = 0
    INT writeIndex = 0
    REPEAT g_spawned_custom_vehicle_count readIndex
        IF DOES_ENTITY_EXIST(g_spawned_custom_vehicles[readIndex])
            g_spawned_custom_vehicles[writeIndex] = g_spawned_custom_vehicles[readIndex]
            writeIndex = writeIndex + 1
        ENDIF
    ENDREPEAT
    g_spawned_custom_vehicle_count = writeIndex
    IF NOT DOES_ENTITY_EXIST(g_last_spawned_vehicle)
        g_last_spawned_vehicle = NULL
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
        FORGET_CUSTOM_CAR(g_last_spawned_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_last_spawned_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_last_spawned_vehicle)
    ENDIF
    g_last_spawned_vehicle = NULL
ENDPROC

PROC COPY_LSC_APPEARANCE(VEHICLE_INDEX sourceVehicle, VEHICLE_INDEX targetVehicle)
    INT primary = 0
    INT secondary = 0
    INT pearlescent = 0
    INT wheelColour = 0
    GET_VEHICLE_COLOURS(sourceVehicle, primary, secondary)
    GET_VEHICLE_EXTRA_COLOURS(sourceVehicle, pearlescent, wheelColour)
    SET_VEHICLE_COLOURS(targetVehicle, primary, secondary)
    SET_VEHICLE_EXTRA_COLOURS(targetVehicle, pearlescent, wheelColour)
    SET_VEHICLE_WHEEL_TYPE(targetVehicle, GET_VEHICLE_WHEEL_TYPE(sourceVehicle))
ENDPROC

PROC SET_CONVERT_FEEDBACK(INT result)
    g_convert_feedback = result
    g_convert_feedback_until = GET_GAME_TIMER() + CONVERT_FEEDBACK_MS
ENDPROC

PROC CANCEL_VEHICLE_CONVERSION(INT result)
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
    g_convert_pending = FALSE
    g_convert_pair = -1
    g_convert_source_vehicle = NULL
    SET_CONVERT_FEEDBACK(result)
ENDPROC

PROC START_VEHICLE_CONVERSION()
    IF g_convert_pending EXIT ENDIF
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX source = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(source) EXIT ENDIF
    INT pair = BENNYS_PAIR_FOR_MODEL(GET_ENTITY_MODEL(source))
    IF pair < 0
        SET_CONVERT_FEEDBACK(2)
        EXIT
    ENDIF
    MODEL_NAMES target = BENNYS_CUSTOM_MODEL(pair)
    IF NOT IS_MODEL_IN_CDIMAGE(target) OR NOT IS_MODEL_VALID(target)
        SET_CONVERT_FEEDBACK(3)
        EXIT
    ENDIF
    g_convert_source_vehicle = source
    g_convert_pair = pair
    g_pending_vehicle_model = target
    g_convert_request_time = GET_GAME_TIMER()
    REQUEST_MODEL(target)
    g_convert_pending = TRUE
ENDPROC

PROC FINISH_VEHICLE_CONVERSION()
    IF NOT g_convert_pending EXIT ENDIF
    IF g_convert_pair < 0
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF
    VEHICLE_INDEX source = g_convert_source_vehicle
    IF NOT DOES_ENTITY_EXIST(source) OR GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()) != source
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(source, <<0.0, 2.50, 1.0>>)
    FLOAT spawnHeading = GET_ENTITY_HEADING(source)
    VEHICLE_INDEX converted = CREATE_VEHICLE(BENNYS_CUSTOM_MODEL(g_convert_pair), spawnPosition, spawnHeading, FALSE)
    IF NOT DOES_ENTITY_EXIST(converted)
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF
    COPY_LSC_APPEARANCE(source, converted)
    SET_VEHICLE_ON_GROUND_PROPERLY(converted)
    IF g_spawned_custom_vehicle_count < 500
        g_spawned_custom_vehicles[g_spawned_custom_vehicle_count] = converted
        g_spawned_custom_vehicle_count = g_spawned_custom_vehicle_count + 1
    ENDIF
    g_last_spawned_vehicle = converted
    SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), converted, VS_DRIVER)
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
    g_convert_pending = FALSE
    g_convert_pair = -1
    g_convert_source_vehicle = NULL
    FORGET_CUSTOM_CAR(source)
    IF DOES_ENTITY_EXIST(source)
        SET_ENTITY_AS_MISSION_ENTITY(source, TRUE, TRUE)
        DELETE_VEHICLE(source)
    ENDIF
    SYNC_LSC_VEHICLE_STATE()
    SET_CONVERT_FEEDBACK(1)
ENDPROC

FUNC FLOAT HYDRO_HEIGHT_VALUE(INT level)
    IF level < 0 level = 0 ENDIF
    IF level >= HYDRO_HEIGHT_LEVELS level = HYDRO_HEIGHT_LEVELS - 1 ENDIF
    RETURN TO_FLOAT(level) * 0.05
ENDFUNC

PROC HYDRO_SET_ALL(FLOAT factor)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, factor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, factor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, factor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, factor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, factor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, factor)
ENDPROC

PROC HYDRO_SET_AXLE(FLOAT frontFactor, FLOAT rearFactor)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, frontFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, frontFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, rearFactor)
ENDPROC

PROC HYDRO_SET_SIDE(FLOAT leftFactor, FLOAT rightFactor)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, rightFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, rightFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, rightFactor)
ENDPROC

PROC APPLY_HYDRO_HEIGHTS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    FLOAT front = HYDRO_HEIGHT_VALUE(g_hydro_front_height)
    FLOAT rear = HYDRO_HEIGHT_VALUE(g_hydro_rear_height)
    FLOAT midLeft = HYDRO_HEIGHT_VALUE(g_hydro_left_height)
    FLOAT midRight = HYDRO_HEIGHT_VALUE(g_hydro_right_height)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, front)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, front)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, rear)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, rear)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, midLeft)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, midRight)
ENDPROC

PROC APPLY_HYDRO_PRESET()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    SWITCH g_hydro_preset
        CASE 0
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
        BREAK
        CASE 1
            HYDRO_SET_ALL(0.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_LOCK_DOWN)
        BREAK
        CASE 2
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_LOCK_UP)
        BREAK
        CASE 3
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_BOUNCE)
        BREAK
        CASE 4
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
        BREAK
        CASE 5 HYDRO_SET_AXLE(1.0, 0.0) BREAK
        CASE 6 HYDRO_SET_AXLE(0.0, 1.0) BREAK
        CASE 7 HYDRO_SET_SIDE(1.0, 0.0) BREAK
        CASE 8 HYDRO_SET_SIDE(0.0, 1.0) BREAK
    ENDSWITCH
    g_hydro_hold_preset = g_hydro_preset
ENDPROC

FUNC STRING HYDRO_PRESET_LABEL(INT preset)
    SWITCH preset
        CASE 0 RETURN "< Stock Height >" BREAK
        CASE 1 RETURN "< Slammed >" BREAK
        CASE 2 RETURN "< Max High >" BREAK
        CASE 3 RETURN "< Bouncy >" BREAK
        CASE 4 RETURN "< Free >" BREAK
        CASE 5 RETURN "< Front Up >" BREAK
        CASE 6 RETURN "< Rear Up >" BREAK
        CASE 7 RETURN "< Lean Left >" BREAK
        CASE 8 RETURN "< Lean Right >" BREAK
    ENDSWITCH
    RETURN "< Stock Height >"
ENDFUNC

PROC APPLY_HYDRO_KIT_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT HYDRO_SUPPORTED(vehicle)
        g_hydro_enabled = FALSE
        EXIT
    ENDIF
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_HYDRAULICS, g_hydro_enabled)
    SET_CAN_USE_HYDRAULICS(vehicle, g_hydro_enabled)
ENDPROC

PROC APPLY_HYDRO_LEVEL()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT slot = ENUM_TO_INT(MOD_HYDRO)
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO)
    IF available <= 0
        g_hydro_level = -1
        EXIT
    ENDIF
    IF g_hydro_level >= available g_hydro_level = available - 1 ENDIF
    IF g_hydro_level < 0
        REMOVE_VEHICLE_MOD(vehicle, MOD_HYDRO)
    ELSE
        SET_VEHICLE_MOD(vehicle, MOD_HYDRO, g_hydro_level)
    ENDIF
ENDPROC

PROC APPLY_HYDRO_CONTROL()
    SET_HYDRAULICS_CONTROL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_hydro_control)
ENDPROC

PROC APPLY_HYDRO_SOFTNESS()
    SET_REDUCED_SUSPENSION_FORCE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_hydro_soft)
    g_wheeltyre_soft_suspension = g_hydro_soft
ENDPROC

PROC APPLY_HYDRO_WHEEL()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    FLOAT amount = HYDRO_HEIGHT_VALUE(g_hydro_wheel_height)
    FLOAT speed = TO_FLOAT(g_hydro_raise_speed + 1) * 0.1
    IF speed < 0.1 speed = 0.1 ENDIF
    IF speed > 2.0 speed = 2.0 ENDIF
    SET_HYDRAULIC_WHEEL_STATE(vehicle, INT_TO_ENUM(SC_WHEEL_LIST, g_hydro_wheel), INT_TO_ENUM(WHEEL_HYDRAULIC_SCRIPT_STATE, g_hydro_wheel_state), amount, speed)
ENDPROC

PROC RESET_HYDRAULICS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    HYDRO_SET_ALL(1.0)
    SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
    SET_HYDRAULICS_CONTROL(vehicle, FALSE)
    SET_REDUCED_SUSPENSION_FORCE(vehicle, FALSE)
    SET_CAN_USE_HYDRAULICS(vehicle, FALSE)
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_HYDRAULICS, FALSE)
    LSC_KIT_FOR_SLOT(vehicle, ENUM_TO_INT(MOD_HYDRO))
    IF GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) > 0 REMOVE_VEHICLE_MOD(vehicle, MOD_HYDRO) ENDIF
    g_hydro_enabled = FALSE
    g_hydro_hold = FALSE
    g_hydro_preset = 0
    g_hydro_hold_preset = 0
    g_hydro_control = FALSE
    g_hydro_level = -1
    g_hydro_wheel = 0
    g_hydro_wheel_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_wheel_state = 0
    g_hydro_raise_speed = 4
    g_hydro_soft = FALSE
    g_wheeltyre_soft_suspension = FALSE
    g_hydro_front_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_rear_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_left_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_right_height = HYDRO_HEIGHT_LEVELS - 1
ENDPROC

PROC MAINTAIN_HYDRO_HOLD()
    IF NOT g_hydro_hold EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        g_hydro_hold = FALSE
        EXIT
    ENDIF
    IF GET_GAME_TIMER() < g_hydro_hold_tick + HYDRO_HOLD_TICK_MS EXIT ENDIF
    g_hydro_hold_tick = GET_GAME_TIMER()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    SET_CAN_USE_HYDRAULICS(vehicle, TRUE)
    SWITCH g_hydro_hold_preset
        CASE 0
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
        BREAK
        CASE 1
            HYDRO_SET_ALL(0.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_LOCK_DOWN)
        BREAK
        CASE 2
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_LOCK_UP)
        BREAK
        CASE 3
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_BOUNCE)
        BREAK
        CASE 4
            HYDRO_SET_ALL(1.0)
            SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
        BREAK
        CASE 5 HYDRO_SET_AXLE(1.0, 0.0) BREAK
        CASE 6 HYDRO_SET_AXLE(0.0, 1.0) BREAK
        CASE 7 HYDRO_SET_SIDE(1.0, 0.0) BREAK
        CASE 8 HYDRO_SET_SIDE(0.0, 1.0) BREAK
    ENDSWITCH
ENDPROC

FUNC STRING HYDRO_WHEEL_STATE_LABEL(INT state)
    IF state = 1 RETURN "< Locked >" ENDIF
    IF state = 2 RETURN "< Bounce >" ENDIF
    RETURN "< Free >"
ENDFUNC

FUNC STRING HYDRO_WHEEL_LABEL(INT wheel)
    SWITCH wheel
        CASE 1 RETURN "< Front Right >" BREAK
        CASE 2 RETURN "< Mid Left >" BREAK
        CASE 3 RETURN "< Mid Right >" BREAK
        CASE 4 RETURN "< Rear Left >" BREAK
        CASE 5 RETURN "< Rear Right >" BREAK
    ENDSWITCH
    RETURN "< Front Left >"
ENDFUNC

FUNC STRING HYDRO_LEVEL_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF GET_NUM_VEHICLE_MODS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_HYDRO) <= 0 RETURN "< None on this car >" ENDIF
    IF g_hydro_level < 0 RETURN "< Stock >" ENDIF
    IF g_hydro_level = 0 RETURN "< Level 1 >" ENDIF
    IF g_hydro_level = 1 RETURN "< Level 2 >" ENDIF
    IF g_hydro_level = 2 RETURN "< Level 3 >" ENDIF
    IF g_hydro_level = 3 RETURN "< Level 4 >" ENDIF
    IF g_hydro_level = 4 RETURN "< Level 5 >" ENDIF
    IF g_hydro_level = 5 RETURN "< Level 6 >" ENDIF
    RETURN "< Level 7+ >"
ENDFUNC

FUNC STRING HYDRO_HEIGHT_TEXT(INT level)
    IF level < 0 level = 0 ENDIF
    IF level >= HYDRO_HEIGHT_LEVELS level = HYDRO_HEIGHT_LEVELS - 1 ENDIF
    IF level = 0 RETURN "< 0% >" ENDIF
    IF level = 1 RETURN "< 5% >" ENDIF
    IF level = 2 RETURN "< 10% >" ENDIF
    IF level = 3 RETURN "< 15% >" ENDIF
    IF level = 4 RETURN "< 20% >" ENDIF
    IF level = 5 RETURN "< 25% >" ENDIF
    IF level = 6 RETURN "< 30% >" ENDIF
    IF level = 7 RETURN "< 35% >" ENDIF
    IF level = 8 RETURN "< 40% >" ENDIF
    IF level = 9 RETURN "< 45% >" ENDIF
    IF level = 10 RETURN "< 50% >" ENDIF
    IF level = 11 RETURN "< 55% >" ENDIF
    IF level = 12 RETURN "< 60% >" ENDIF
    IF level = 13 RETURN "< 65% >" ENDIF
    IF level = 14 RETURN "< 70% >" ENDIF
    IF level = 15 RETURN "< 75% >" ENDIF
    IF level = 16 RETURN "< 80% >" ENDIF
    IF level = 17 RETURN "< 85% >" ENDIF
    IF level = 18 RETURN "< 90% >" ENDIF
    IF level = 19 RETURN "< 95% >" ENDIF
    RETURN "< 100% >"
ENDFUNC

FUNC STRING HYDRO_SPEED_TEXT(INT level)
    IF level < 0 level = 0 ENDIF
    IF level > 19 level = 19 ENDIF
    IF level = 0 RETURN "< 0.1x >" ENDIF
    IF level = 1 RETURN "< 0.2x >" ENDIF
    IF level = 2 RETURN "< 0.3x >" ENDIF
    IF level = 3 RETURN "< 0.4x >" ENDIF
    IF level = 4 RETURN "< 0.5x >" ENDIF
    IF level = 5 RETURN "< 0.6x >" ENDIF
    IF level = 6 RETURN "< 0.7x >" ENDIF
    IF level = 7 RETURN "< 0.8x >" ENDIF
    IF level = 8 RETURN "< 0.9x >" ENDIF
    IF level = 9 RETURN "< 1.0x >" ENDIF
    IF level = 10 RETURN "< 1.1x >" ENDIF
    IF level = 11 RETURN "< 1.2x >" ENDIF
    IF level = 12 RETURN "< 1.3x >" ENDIF
    IF level = 13 RETURN "< 1.4x >" ENDIF
    IF level = 14 RETURN "< 1.5x >" ENDIF
    IF level = 15 RETURN "< 1.6x >" ENDIF
    IF level = 16 RETURN "< 1.7x >" ENDIF
    IF level = 17 RETURN "< 1.8x >" ENDIF
    IF level = 18 RETURN "< 1.9x >" ENDIF
    RETURN "< 2.0x >"
ENDFUNC

PROC DRAW_HYDRO_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0
            IF NOT PLAYER_CAR_HAS_HYDRO()
                DRAW_OPTION(y, "Hydraulics Kit", "< Not Supported >", g_item = index, 0)
            ELIF g_hydro_enabled
                DRAW_OPTION(y, "Hydraulics Kit", "ON", g_item = index, 1)
            ELSE
                DRAW_OPTION(y, "Hydraulics Kit", "OFF", g_item = index, 0)
            ENDIF
        BREAK
        CASE 1 DRAW_OPTION(y, "Hydraulic Level", HYDRO_LEVEL_TEXT(), g_item = index, 3) BREAK
        CASE 2 IF g_hydro_control DRAW_OPTION(y, "Player Control", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Player Control", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_OPTION(y, "Stance Preset", HYDRO_PRESET_LABEL(g_hydro_preset), g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Apply Stance Preset", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Front Axle Height", HYDRO_HEIGHT_TEXT(g_hydro_front_height), g_item = index, 3) BREAK
        CASE 6 DRAW_OPTION(y, "Rear Axle Height", HYDRO_HEIGHT_TEXT(g_hydro_rear_height), g_item = index, 3) BREAK
        CASE 7 DRAW_OPTION(y, "Mid Left Height", HYDRO_HEIGHT_TEXT(g_hydro_left_height), g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, "Mid Right Height", HYDRO_HEIGHT_TEXT(g_hydro_right_height), g_item = index, 3) BREAK
        CASE 9 DRAW_OPTION(y, "Apply All Heights", "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, "Single Wheel", HYDRO_WHEEL_LABEL(g_hydro_wheel), g_item = index, 3) BREAK
        CASE 11 DRAW_OPTION(y, "Wheel Height", HYDRO_HEIGHT_TEXT(g_hydro_wheel_height), g_item = index, 3) BREAK
        CASE 12 DRAW_OPTION(y, "Wheel State", HYDRO_WHEEL_STATE_LABEL(g_hydro_wheel_state), g_item = index, 3) BREAK
        CASE 13 DRAW_OPTION(y, "Wheel Raise Speed", HYDRO_SPEED_TEXT(g_hydro_raise_speed), g_item = index, 3) BREAK
        CASE 14 DRAW_OPTION(y, "Apply To Wheel", "APPLY", g_item = index, 2) BREAK
        CASE 15 IF g_hydro_hold DRAW_OPTION(y, "Hold Stance", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Hold Stance", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 IF g_hydro_soft DRAW_OPTION(y, "Stance Softness", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Stance Softness", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 DRAW_OPTION(y, "Reset Hydraulics", "APPLY", g_item = index, 2) BREAK
        CASE 18 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, "Lowrider Support", LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, "Lowrider Support", LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_HYDRO_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "HYDRAULICS")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Hydraulics", "NO VEHICLE", g_item = 0, 0)
        EXIT
    ENDIF
    INT index = g_hydro_scroll
    INT row = 0
    WHILE row < 8 AND index < HYDRO_MENU_ROWS
        DRAW_HYDRO_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC INT INTERIOR_SLOT_FOR_INDEX(INT index)
    SWITCH index
        CASE 1 RETURN ENUM_TO_INT(MOD_INTERIOR2) BREAK
        CASE 2 RETURN ENUM_TO_INT(MOD_INTERIOR3) BREAK
        CASE 3 RETURN ENUM_TO_INT(MOD_INTERIOR4) BREAK
        CASE 4 RETURN ENUM_TO_INT(MOD_INTERIOR5) BREAK
        CASE 5 RETURN ENUM_TO_INT(MOD_SEATS) BREAK
        CASE 6 RETURN ENUM_TO_INT(MOD_STEERING) BREAK
        CASE 7 RETURN ENUM_TO_INT(MOD_KNOB) BREAK
        CASE 8 RETURN ENUM_TO_INT(MOD_PLAQUE) BREAK
        CASE 9 RETURN ENUM_TO_INT(MOD_ICE) BREAK
        CASE 10 RETURN ENUM_TO_INT(MOD_TRUNK) BREAK
        CASE 11 RETURN ENUM_TO_INT(MOD_ENGINEBAY1) BREAK
        CASE 12 RETURN ENUM_TO_INT(MOD_ENGINEBAY2) BREAK
        CASE 13 RETURN ENUM_TO_INT(MOD_ENGINEBAY3) BREAK
        CASE 14 RETURN ENUM_TO_INT(MOD_CHASSIS2) BREAK
        CASE 15 RETURN ENUM_TO_INT(MOD_CHASSIS3) BREAK
        CASE 16 RETURN ENUM_TO_INT(MOD_CHASSIS4) BREAK
        CASE 17 RETURN ENUM_TO_INT(MOD_CHASSIS5) BREAK
        CASE 18 RETURN ENUM_TO_INT(MOD_DOOR_L) BREAK
        CASE 19 RETURN ENUM_TO_INT(MOD_DOOR_R) BREAK
        CASE 20 RETURN ENUM_TO_INT(MOD_PLTHOLDER) BREAK
        CASE 21 RETURN ENUM_TO_INT(MOD_PLTVANITY) BREAK
    ENDSWITCH
    RETURN ENUM_TO_INT(MOD_INTERIOR1)
ENDFUNC

FUNC INT INTERIOR_SLOT()
    RETURN INTERIOR_SLOT_FOR_INDEX(g_interior_slot)
ENDFUNC

FUNC STRING INTERIOR_SLOT_LABEL(INT index)
    SWITCH index
        CASE 1 RETURN "< Interior 2 >" BREAK
        CASE 2 RETURN "< Interior 3 >" BREAK
        CASE 3 RETURN "< Interior 4 >" BREAK
        CASE 4 RETURN "< Interior 5 >" BREAK
        CASE 5 RETURN "< Seats >" BREAK
        CASE 6 RETURN "< Steering Wheel >" BREAK
        CASE 7 RETURN "< Knob >" BREAK
        CASE 8 RETURN "< Plaque >" BREAK
        CASE 9 RETURN "< ICE / Speakers >" BREAK
        CASE 10 RETURN "< Trunk >" BREAK
        CASE 11 RETURN "< Engine Bay 1 >" BREAK
        CASE 12 RETURN "< Engine Bay 2 >" BREAK
        CASE 13 RETURN "< Engine Bay 3 >" BREAK
        CASE 14 RETURN "< Chassis 2 >" BREAK
        CASE 15 RETURN "< Chassis 3 >" BREAK
        CASE 16 RETURN "< Chassis 4 >" BREAK
        CASE 17 RETURN "< Chassis 5 >" BREAK
        CASE 18 RETURN "< Left Door >" BREAK
        CASE 19 RETURN "< Right Door >" BREAK
        CASE 20 RETURN "< Plate Holder >" BREAK
        CASE 21 RETURN "< Vanity Plate >" BREAK
    ENDSWITCH
    RETURN "< Interior 1 >"
ENDFUNC

FUNC INT INTERIOR_AVAILABLE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN 0 ENDIF
    RETURN GET_NUM_VEHICLE_MODS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
ENDFUNC

FUNC INT LOWRIDER_SLOT_COUNT(VEHICLE_INDEX vehicle)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN 0 ENDIF
    INT count = 0
    INT index = 0
    WHILE index < INTERIOR_SLOT_COUNT
        IF GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT_FOR_INDEX(index))) > 0
            count = count + 1
        ENDIF
        index = index + 1
    ENDWHILE
    RETURN count
ENDFUNC

FUNC STRING LOWRIDER_SLOT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT slots = LOWRIDER_SLOT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF slots <= 0 RETURN "< None On This Car >" ENDIF
    IF slots = 1 RETURN "< 1 of 22 >" ENDIF
    IF slots = 2 RETURN "< 2 of 22 >" ENDIF
    IF slots = 3 RETURN "< 3 of 22 >" ENDIF
    IF slots = 4 RETURN "< 4 of 22 >" ENDIF
    IF slots = 5 RETURN "< 5 of 22 >" ENDIF
    IF slots = 6 RETURN "< 6 of 22 >" ENDIF
    IF slots = 7 RETURN "< 7 of 22 >" ENDIF
    IF slots = 8 RETURN "< 8 of 22 >" ENDIF
    IF slots = 9 RETURN "< 9 of 22 >" ENDIF
    IF slots = 10 RETURN "< 10 of 22 >" ENDIF
    IF slots = 11 RETURN "< 11 of 22 >" ENDIF
    IF slots = 12 RETURN "< 12 of 22 >" ENDIF
    IF slots = 13 RETURN "< 13 of 22 >" ENDIF
    IF slots = 14 RETURN "< 14 of 22 >" ENDIF
    IF slots = 15 RETURN "< 15 of 22 >" ENDIF
    IF slots = 16 RETURN "< 16 of 22 >" ENDIF
    IF slots = 17 RETURN "< 17 of 22 >" ENDIF
    IF slots = 18 RETURN "< 18 of 22 >" ENDIF
    IF slots = 19 RETURN "< 19 of 22 >" ENDIF
    IF slots = 20 RETURN "< 20 of 22 >" ENDIF
    IF slots = 21 RETURN "< 21 of 22 >" ENDIF
    RETURN "< All 22 Slots >"
ENDFUNC

FUNC STRING INTERIOR_AVAILABLE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT available = INTERIOR_AVAILABLE()
    IF available <= 0 RETURN "< None on this kit >" ENDIF
    IF available = 1 RETURN "< 1 variant >" ENDIF
    IF available = 2 RETURN "< 2 variants >" ENDIF
    IF available = 3 RETURN "< 3 variants >" ENDIF
    IF available = 4 RETURN "< 4 variants >" ENDIF
    IF available = 5 RETURN "< 5 variants >" ENDIF
    IF available = 6 RETURN "< 6 variants >" ENDIF
    IF available = 7 RETURN "< 7 variants >" ENDIF
    IF available = 8 RETURN "< 8 variants >" ENDIF
    IF available = 9 RETURN "< 9 variants >" ENDIF
    IF available = 10 RETURN "< 10 variants >" ENDIF
    RETURN "< 10+ variants >"
ENDFUNC

FUNC STRING INTERIOR_SLOT_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    STRING slotName = GET_MOD_SLOT_NAME(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
    IF IS_STRING_NULL_OR_EMPTY(slotName) RETURN "< unnamed slot >" ENDIF
    RETURN slotName
ENDFUNC

FUNC STRING INTERIOR_VARIANT_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    INT available = INTERIOR_AVAILABLE()
    IF available <= 0 RETURN "< none on this kit >" ENDIF
    IF g_interior_choice < 0 RETURN "< Stock >" ENDIF
    INT choice = g_interior_choice
    IF choice >= available choice = available - 1 ENDIF
    STRING variantName = GET_MOD_TEXT_LABEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()), choice)
    IF IS_STRING_NULL_OR_EMPTY(variantName) RETURN "< unnamed variant >" ENDIF
    RETURN variantName
ENDFUNC

FUNC STRING INTERIOR_VARIANT_TEXT()
    IF INTERIOR_AVAILABLE() <= 0 RETURN "< None >" ENDIF
    IF g_interior_choice < 0 RETURN "< Stock >" ENDIF
    IF g_interior_choice = 0 RETURN "< 1 >" ENDIF
    IF g_interior_choice = 1 RETURN "< 2 >" ENDIF
    IF g_interior_choice = 2 RETURN "< 3 >" ENDIF
    IF g_interior_choice = 3 RETURN "< 4 >" ENDIF
    IF g_interior_choice = 4 RETURN "< 5 >" ENDIF
    IF g_interior_choice = 5 RETURN "< 6 >" ENDIF
    IF g_interior_choice = 6 RETURN "< 7 >" ENDIF
    IF g_interior_choice = 7 RETURN "< 8 >" ENDIF
    IF g_interior_choice = 8 RETURN "< 9 >" ENDIF
    IF g_interior_choice = 9 RETURN "< 10 >" ENDIF
    RETURN "< 10+ >"
ENDFUNC

FUNC STRING INTERIOR_FILL_TEXT()
    IF g_interior_fill_index = 0 RETURN "< 1 >" ENDIF
    IF g_interior_fill_index = 1 RETURN "< 2 >" ENDIF
    IF g_interior_fill_index = 2 RETURN "< 3 >" ENDIF
    IF g_interior_fill_index = 3 RETURN "< 4 >" ENDIF
    IF g_interior_fill_index = 4 RETURN "< 5 >" ENDIF
    IF g_interior_fill_index = 5 RETURN "< 6 >" ENDIF
    IF g_interior_fill_index = 6 RETURN "< 7 >" ENDIF
    IF g_interior_fill_index = 7 RETURN "< 8 >" ENDIF
    IF g_interior_fill_index = 8 RETURN "< 9 >" ENDIF
    RETURN "< 10 >"
ENDFUNC

FUNC STRING INTERIOR_STREAMED_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF HAVE_VEHICLE_MODS_STREAMED_IN(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) RETURN "< Yes >" ENDIF
    RETURN "< Not yet >"
ENDFUNC

PROC APPLY_INTERIOR_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT slot = INTERIOR_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    IF available <= 0
        g_interior_choice = -1
        EXIT
    ENDIF
    IF g_interior_choice >= available g_interior_choice = available - 1 ENDIF
    IF g_interior_choice < 0
        REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    ELSE
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), g_interior_choice)
    ENDIF
ENDPROC

PROC SYNC_INTERIOR_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    g_interior_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
    IF g_interior_choice >= INTERIOR_AVAILABLE() g_interior_choice = -1 ENDIF
ENDPROC

PROC APPLY_INTERIOR_FILL()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT index = 0
    REPEAT INTERIOR_SLOT_COUNT index
        INT slot = INTERIOR_SLOT_FOR_INDEX(index)
        LSC_KIT_FOR_SLOT(vehicle, slot)
        INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
        IF available > 0
            INT choice = g_interior_fill_index
            IF choice >= available choice = available - 1 ENDIF
            SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), choice)
        ENDIF
    ENDREPEAT
ENDPROC

PROC RESET_INTERIOR_SLOTS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT index = 0
    REPEAT INTERIOR_SLOT_COUNT index
        INT slot = INTERIOR_SLOT_FOR_INDEX(index)
        LSC_KIT_FOR_SLOT(vehicle, slot)
        REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    ENDREPEAT
    g_interior_choice = -1
ENDPROC

PROC APPLY_INTERIOR_COLOURS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_EXTRA_COLOUR_5(vehicle, LSC_COLOUR_ID(g_lsc_trim_colour))
    SET_VEHICLE_EXTRA_COLOUR_6(vehicle, LSC_COLOUR_ID(g_lsc_metal_colour))
ENDPROC

PROC DRAW_INTERIOR_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Apply To Every Slot", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, "Fill Variant", INTERIOR_FILL_TEXT(), g_item = index, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Slot", INTERIOR_SLOT_LABEL(g_interior_slot), g_item = index, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Variant", INTERIOR_VARIANT_TEXT(), g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, "Available", INTERIOR_AVAILABLE_TEXT(), g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Slot Name", INTERIOR_SLOT_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Variant Name", INTERIOR_VARIANT_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, "Trim Colour", g_lsc_trim_colour, g_item = index) BREAK
        CASE 8 DRAW_LSC_COLOUR_SELECTOR(y, "Metal Colour", g_lsc_metal_colour, g_item = index) BREAK
        CASE 9 DRAW_OPTION(y, "Mods Streamed", INTERIOR_STREAMED_TEXT(), g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, "Reset Interior", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_INTERIOR_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "LOWRIDER INTERIOR")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Lowrider Interior", "NO VEHICLE", g_item = 0, 0)
        EXIT
    ENDIF
    INT index = g_interior_scroll
    INT row = 0
    WHILE row < 8 AND index < INTERIOR_MENU_ROWS
        DRAW_INTERIOR_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC INT WHEEL_SLOT_TYPE()
    IF g_wheeltyre_rear_slot RETURN ENUM_TO_INT(MOD_REAR_WHEELS) ENDIF
    RETURN ENUM_TO_INT(MOD_WHEELS)
ENDFUNC

FUNC STRING WHEEL_SLOT_LABEL()
    IF g_wheeltyre_rear_slot RETURN "< Rear Wheel >" ENDIF
    RETURN "< Front / All >"
ENDFUNC

FUNC STRING WHEEL_VARIATION_TEXT()
    IF g_wheeltyre_variation = 1 RETURN "< Variant B >" ENDIF
    RETURN "< Variant A >"
ENDFUNC

FUNC STRING WHEEL_VARIATION_STATE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT variation = GET_VEHICLE_MOD_VARIATION(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, WHEEL_SLOT_TYPE()))
    IF variation = 1 RETURN "< Variant B fitted >" ENDIF
    RETURN "< Variant A fitted >"
ENDFUNC

FUNC STRING WHEEL_TYRE_SMOKE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF IS_TOGGLE_MOD_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_TOGGLE_TYRE_SMOKE) RETURN "< Fitted >" ENDIF
    RETURN "< Not fitted >"
ENDFUNC

PROC APPLY_WHEEL_FAMILY()
    SET_VEHICLE_WHEEL_TYPE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
ENDPROC

PROC APPLY_WHEEL_VARIATION()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT slot = WHEEL_SLOT_TYPE()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    IF available <= 0 EXIT ENDIF
    INT current = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    IF current < 0 current = 0 ENDIF
    IF current >= available current = available - 1 ENDIF
    IF g_wheeltyre_variation = 1
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), current, TRUE)
    ELSE
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), current, FALSE)
    ENDIF
ENDPROC

PROC APPLY_WHEEL_TYRE_SMOKE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TYRE_SMOKE, g_wheeltyre_smoke)
ENDPROC

PROC APPLY_TYRES_CAN_BURST()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_TYRES_CAN_BURST(vehicle, g_wheeltyre_can_burst)
    IF g_wheeltyre_can_burst
        g_vehicle_bulletproof_tyres = FALSE
        g_bulletproof_tyres_applied = FALSE
    ENDIF
ENDPROC

PROC APPLY_SOFT_SUSPENSION()
    SET_REDUCED_SUSPENSION_FORCE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_wheeltyre_soft_suspension)
    g_hydro_soft = g_wheeltyre_soft_suspension
ENDPROC

PROC SYNC_WHEELTYRE_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    IF IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_TYRE_SMOKE)
        g_wheeltyre_smoke = TRUE
    ELSE
        g_wheeltyre_smoke = FALSE
    ENDIF
    IF g_vehicle_bulletproof_tyres g_wheeltyre_can_burst = FALSE ENDIF
    g_wheeltyre_soft_suspension = g_hydro_soft
ENDPROC

PROC DRAW_WHEELTYRE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Wheel Family", WHEEL_FAMILY_LABEL(g_lsc_wheel_type), g_item = index, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Wheel Variation", WHEEL_VARIATION_TEXT(), g_item = index, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Wheel Slot", WHEEL_SLOT_LABEL(), g_item = index, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Apply Wheel Family", "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Apply Wheel Variation", "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Fitted Variation", WHEEL_VARIATION_STATE_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Smoke Fitted", WHEEL_TYRE_SMOKE_TEXT(), g_item = index, 2) BREAK
        CASE 7 IF g_wheeltyre_smoke DRAW_OPTION(y, "Tyre Smoke", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Tyre Smoke", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 IF g_wheeltyre_can_burst DRAW_OPTION(y, "Tyres Can Burst", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Tyres Can Burst", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 9 IF g_wheeltyre_soft_suspension DRAW_OPTION(y, "Soft Suspension", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Soft Suspension", "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WHEELTYRE_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "WHEELS AND TYRES")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Wheels & Tyres", "NO VEHICLE", g_item = 0, 0)
        EXIT
    ENDIF
    INT index = g_wheeltyre_scroll
    INT row = 0
    WHILE row < 8 AND index < WHEELTYRE_MENU_ROWS
        DRAW_WHEELTYRE_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC STRING LIVERY_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT count = GET_VEHICLE_LIVERY_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF count <= 0 RETURN "< No liveries >" ENDIF
    IF g_lsc_livery < 0 RETURN "< Stock >" ENDIF
    IF g_lsc_livery = 0 RETURN "< Livery 1 >" ENDIF
    IF g_lsc_livery = 1 RETURN "< Livery 2 >" ENDIF
    IF g_lsc_livery = 2 RETURN "< Livery 3 >" ENDIF
    IF g_lsc_livery = 3 RETURN "< Livery 4 >" ENDIF
    IF g_lsc_livery = 4 RETURN "< Livery 5 >" ENDIF
    IF g_lsc_livery = 5 RETURN "< Livery 6 >" ENDIF
    IF g_lsc_livery = 6 RETURN "< Livery 7 >" ENDIF
    IF g_lsc_livery = 7 RETURN "< Livery 8 >" ENDIF
    RETURN "< Livery 9+ >"
ENDFUNC

FUNC STRING LIVERY_COUNT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    INT count = GET_VEHICLE_LIVERY_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF count <= 0 RETURN "< None on this car >" ENDIF
    IF count = 1 RETURN "< 1 livery >" ENDIF
    IF count = 2 RETURN "< 2 liveries >" ENDIF
    IF count = 3 RETURN "< 3 liveries >" ENDIF
    IF count = 4 RETURN "< 4 liveries >" ENDIF
    IF count = 5 RETURN "< 5 liveries >" ENDIF
    IF count = 6 RETURN "< 6 liveries >" ENDIF
    IF count = 7 RETURN "< 7 liveries >" ENDIF
    IF count = 8 RETURN "< 8 liveries >" ENDIF
    RETURN "< 9+ liveries >"
ENDFUNC

FUNC STRING LIVERY_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    IF g_lsc_livery < 0 RETURN "< Stock >" ENDIF
    STRING liveryName = GET_LIVERY_NAME(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_livery)
    IF IS_STRING_NULL_OR_EMPTY(liveryName) RETURN "< unnamed livery >" ENDIF
    RETURN liveryName
ENDFUNC

FUNC STRING EXTRA_SLOT_TEXT()
    IF g_lsc_extra = 0 RETURN "< Extra 1 >" ENDIF
    IF g_lsc_extra = 1 RETURN "< Extra 2 >" ENDIF
    IF g_lsc_extra = 2 RETURN "< Extra 3 >" ENDIF
    IF g_lsc_extra = 3 RETURN "< Extra 4 >" ENDIF
    IF g_lsc_extra = 4 RETURN "< Extra 5 >" ENDIF
    IF g_lsc_extra = 5 RETURN "< Extra 6 >" ENDIF
    IF g_lsc_extra = 6 RETURN "< Extra 7 >" ENDIF
    IF g_lsc_extra = 7 RETURN "< Extra 8 >" ENDIF
    IF g_lsc_extra = 8 RETURN "< Extra 9 >" ENDIF
    IF g_lsc_extra = 9 RETURN "< Extra 10 >" ENDIF
    IF g_lsc_extra = 10 RETURN "< Extra 11 >" ENDIF
    RETURN "< Extra 12 >"
ENDFUNC

FUNC STRING EXTRA_FITTED_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF DOES_EXTRA_EXIST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN "< Fitted >" ENDIF
    RETURN "< Not on this car >"
ENDFUNC

FUNC STRING EXTRA_STATE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF NOT DOES_EXTRA_EXIST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN "< Unavailable >" ENDIF
    IF IS_VEHICLE_EXTRA_TURNED_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN "< On >" ENDIF
    RETURN "< Off >"
ENDFUNC

PROC REFRESH_EXTRA_PROBE()
    g_lsc_extra_exists = FALSE
    g_lsc_extra_on = FALSE
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF DOES_EXTRA_EXIST(vehicle, g_lsc_extra + 1)
        g_lsc_extra_exists = TRUE
        g_lsc_extra_on = IS_VEHICLE_EXTRA_TURNED_ON(vehicle, g_lsc_extra + 1)
    ENDIF
ENDPROC

PROC APPLY_EXTRA_TOGGLE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    REFRESH_EXTRA_PROBE()
    IF NOT g_lsc_extra_exists EXIT ENDIF
    SET_VEHICLE_EXTRA(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1, g_lsc_extra_on)
    REFRESH_EXTRA_PROBE()
ENDPROC

PROC APPLY_ALL_EXTRAS(BOOL turnOn)
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT extra = 1
    WHILE extra <= 12
        IF DOES_EXTRA_EXIST(vehicle, extra)
            SET_VEHICLE_EXTRA(vehicle, extra, NOT turnOn)
        ENDIF
        extra = extra + 1
    ENDWHILE
    REFRESH_EXTRA_PROBE()
ENDPROC

PROC APPLY_LIVERY()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    INT count = GET_VEHICLE_LIVERY_COUNT(vehicle)
    IF count <= 0
        g_lsc_livery = -1
        EXIT
    ENDIF
    IF g_lsc_livery >= count g_lsc_livery = -1 ENDIF
    SET_VEHICLE_LIVERY(vehicle, g_lsc_livery)
ENDPROC

PROC DRAW_LSC_EXTRAS_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Livery", LIVERY_TEXT(), g_item = index, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Livery Count", LIVERY_COUNT_TEXT(), g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Livery Name", LIVERY_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "Apply Livery", "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Extra Slot", EXTRA_SLOT_TEXT(), g_item = index, 3) BREAK
        CASE 5 DRAW_OPTION(y, "Extra Fitted", EXTRA_FITTED_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Extra State", EXTRA_STATE_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Toggle This Extra", "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Fit All Extras", "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Remove All Extras", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_EXTRAS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "EXTRAS AND LIVERY")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Extras & Livery", "NO VEHICLE", g_item = 0, 0)
        EXIT
    ENDIF
    INT index = g_lsc_extras_scroll
    INT row = 0
    WHILE row < 8 AND index < LSC_EXTRAS_MENU_ROWS
        DRAW_LSC_EXTRAS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC STRING BENNYS_ROW_TEXT(INT index)
    IF NOT IS_MODEL_IN_CDIMAGE(BENNYS_CUSTOM_MODEL(index)) RETURN "< Absent >" ENDIF
    IF NOT IS_MODEL_VALID(BENNYS_CUSTOM_MODEL(index)) RETURN "< Unavailable >" ENDIF
    RETURN "SPAWN"
ENDFUNC

PROC APPLY_BENNYS_SPAWN()
    INT index = g_item
    IF index < 0 OR index >= BENNYS_MENU_ROWS EXIT ENDIF
    MODEL_NAMES model = BENNYS_CUSTOM_MODEL(index)
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model) EXIT ENDIF
    START_VEHICLE_MODEL_SPAWN(model)
ENDPROC

PROC DRAW_BENNYS_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(0)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(1)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(2)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(3)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(4)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(5)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(6)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(7)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(8)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(9)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(10)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(11)), BENNYS_ROW_TEXT(index), g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BENNYS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "BENNYS AND LOWRIDERS")
    DRAW_MENU_VERSION_TAG()
    INT index = g_bennys_scroll
    INT row = 0
    WHILE row < 8 AND index < BENNYS_MENU_ROWS
        DRAW_BENNYS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC STRING HYDRO_FITTED_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF IS_TOGGLE_MOD_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_TOGGLE_HYDRAULICS) RETURN "< Fitted >" ENDIF
    RETURN "< Not Fitted >"
ENDFUNC

FUNC STRING HYDRO_READY_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "< No Vehicle >" ENDIF
    IF PLAYER_CAR_HAS_HYDRO() RETURN "< Yes - Kit Fits >" ENDIF
    RETURN "< No - Needs Custom >"
ENDFUNC

PROC DRAW_SUPPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, "Lowrider Support", LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, "Lowrider Support", LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, "Hydraulics Ready", HYDRO_READY_TEXT(), g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Hydraulics Fitted", HYDRO_FITTED_TEXT(), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, "This Car", VEHICLE_MODEL_NAME_TEXT(LSC_PLAYER_VEHICLE_MODEL()), g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Custom Variant", BENNYS_VARIANT_TEXT(), g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, "Built From", BENNYS_BASE_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, "Mod Kits", LSC_KIT_COUNT_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Active Kit", LSC_KIT_INDEX_TEXT(), g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, "Kit Type", LSC_KIT_TYPE_TEXT(), g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, "Lowrider Slots", LOWRIDER_SLOT_TEXT(), g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SUPPORT_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "VEHICLE SUPPORT")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, "Vehicle Support", "NO VEHICLE", g_item = 0, 0)
        EXIT
    ENDIF
    INT index = g_support_scroll
    INT row = 0
    WHILE row < 8 AND index < SUPPORTCHECK_MENU_ROWS
        DRAW_SUPPORT_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC
