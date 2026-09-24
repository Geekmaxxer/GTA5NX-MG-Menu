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
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    IF available <= 0
        g_lsc_mod_choice = -1
        EXIT
    ENDIF
    IF g_lsc_mod_choice < 0
        REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
    ELSE
        SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()), g_lsc_mod_choice)
    ENDIF
ENDPROC

PROC SYNC_LSC_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    g_lsc_mod_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
ENDPROC

PROC ADJUST_LSC_MOD(INT direction)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_MOD_KIT(vehicle, 0)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
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
    SET_VEHICLE_MOD_KIT(vehicle, 0)
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
    SET_VEHICLE_MOD_KIT(vehicle, 0)

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
    SET_VEHICLE_MOD_KIT(vehicle, 0)

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

PROC DRAW_LSC_SCROLL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 19
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
            CASE 9 DRAW_OPTION(y, "Wheel Type", "< cycle >", g_item = index, 3) BREAK
            CASE 10 IF g_lsc_turbo DRAW_OPTION(y, "Turbo", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Turbo", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 11 IF g_lsc_xenon DRAW_OPTION(y, "Xenon Lights", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Xenon Lights", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 12 DRAW_LSC_LIGHT_SELECTOR(y, "Xenon Colour", g_lsc_xenon_colour, g_item = index) BREAK
            CASE 13 IF g_lsc_neon DRAW_OPTION(y, "Neon Kit", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Neon Kit", "OFF", g_item = index, 0) ENDIF BREAK
            CASE 14 DRAW_LSC_LIGHT_SELECTOR(y, "Neon Colour", g_lsc_neon_colour, g_item = index) BREAK
            CASE 15 DRAW_LSC_WINDOW_TINT_SELECTOR(y, g_item = index) BREAK
            CASE 16 DRAW_LSC_PLATE_ROW(y, g_item = index) BREAK
            CASE 17 DRAW_OPTION(y, "Apply Plate Text", "APPLY", g_item = index, 2) BREAK
            CASE 18 DRAW_OPTION(y, "Restore Stock Slot", "APPLY", g_item = index, 2) BREAK
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
        CASE 54 RETURN DINGHY3 BREAK
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
    g_keyboard_target = target
    g_keyboard_active = TRUE
    IF target = 3
        g_ped_search_not_found = FALSE
    ENDIF
    IF target = 3
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "PED MODEL", "TYPE MODEL NAME", "", "", "", "", 32)
    ELIF target = 4
        g_vehicle_search_not_found = FALSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "VEHICLE MODEL", "TYPE MODEL NAME", "", "", "", "", 32)
    ELIF target = 8
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "CUSTOM IPL", "TYPE IPL NAME", "", "", "", "", 64)
    ELIF target = 9
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "LICENSE PLATE", "8 CHARACTERS MAX", "", "", "", "", 8)
    ELSE
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "ENTER VALUE", "NUMBERS ONLY", "", "", "", "", 10)
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
    IF status = OSK_SUCCESS
        INT parsed = 0
        INT foundChoice = -1
        FLOAT parsedCoordinate = 0.0
        STRING result = GET_ONSCREEN_KEYBOARD_RESULT()
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
                ELSE
                    g_ped_search_not_found = TRUE
                    g_ped_search_has_value = FALSE
                    g_ped_search_is_custom = FALSE
                    g_ped_search_value = result
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
        ELIF g_keyboard_target >= 5 AND g_keyboard_target <= 7
            IF PARSE_FLOAT_COORDINATE(result, parsedCoordinate)
                IF g_keyboard_target = 5 g_teleport_x = parsedCoordinate ENDIF
                IF g_keyboard_target = 6 g_teleport_y = parsedCoordinate ENDIF
                IF g_keyboard_target = 7 g_teleport_z = parsedCoordinate ENDIF
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
