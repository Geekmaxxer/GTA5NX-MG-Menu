PROC ADJUST_OUTFIT_SLOT(INT direction)
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT current = 0
    INT count = 0
    INT next = 0
    INT texture = 0
    IF g_item < NUM_PED_COMPONENTS
        PED_COMPONENT component = INT_TO_ENUM(PED_COMPONENT, g_item)
        current = GET_PED_DRAWABLE_VARIATION(playerPed, component)
        count = GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, component)
        IF count <= 0 EXIT ENDIF
        next = current + direction
        IF next < 0 next = count - 1 ENDIF
        IF next >= count next = 0 ENDIF
        texture = GET_PED_TEXTURE_VARIATION(playerPed, component)
        IF texture >= GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, component, next) texture = 0 ENDIF
        SET_PED_COMPONENT_VARIATION(playerPed, component, next, texture)
    ELSE
        PED_PROP_POSITION prop = INT_TO_ENUM(PED_PROP_POSITION, g_item - NUM_PED_COMPONENTS)
        current = GET_PED_PROP_INDEX(playerPed, prop)
        count = GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(playerPed, prop)
        IF count <= 0 EXIT ENDIF
        next = current + direction
        IF next < -1 next = count - 1 ENDIF
        IF next >= count next = -1 ENDIF
        IF next = -1
            CLEAR_PED_PROP(playerPed, prop)
        ELSE
            texture = GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(playerPed, prop, next)
            SET_PED_PROP_INDEX(playerPed, prop, next, 0)
        ENDIF
    ENDIF
ENDPROC

PROC ADJUST_OUTFIT_TEXTURE()
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT drawable = 0
    INT texture = 0
    INT textureCount = 0
    IF g_item < NUM_PED_COMPONENTS
        PED_COMPONENT component = INT_TO_ENUM(PED_COMPONENT, g_item)
        drawable = GET_PED_DRAWABLE_VARIATION(playerPed, component)
        texture = GET_PED_TEXTURE_VARIATION(playerPed, component)
        textureCount = GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, component, drawable)
        IF textureCount <= 0 EXIT ENDIF
        texture = texture + 1
        IF texture >= textureCount texture = 0 ENDIF
        SET_PED_COMPONENT_VARIATION(playerPed, component, drawable, texture)
    ELSE
        PED_PROP_POSITION prop = INT_TO_ENUM(PED_PROP_POSITION, g_item - NUM_PED_COMPONENTS)
        drawable = GET_PED_PROP_INDEX(playerPed, prop)
        IF drawable < 0 EXIT ENDIF
        texture = GET_PED_PROP_TEXTURE_INDEX(playerPed, prop)
        textureCount = GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(playerPed, prop, drawable)
        IF textureCount <= 0 EXIT ENDIF
        texture = texture + 1
        IF texture >= textureCount texture = 0 ENDIF
        SET_PED_PROP_INDEX(playerPed, prop, drawable, texture)
    ENDIF
ENDPROC

PROC DRAW_OUTFIT_ROW(INT index, FLOAT y)
    PED_INDEX playerPed = PLAYER_PED_ID()
    INT current = 0
    INT variantCount = 0
    STRING label = "Outfit item"
    IF index = 0 label = "Head" ENDIF
    IF index = 1 label = "Beard / Mask" ENDIF
    IF index = 2 label = "Hair" ENDIF
    IF index = 3 label = "Torso" ENDIF
    IF index = 4 label = "Legs / Pants" ENDIF
    IF index = 5 label = "Hands / Gloves" ENDIF
    IF index = 6 label = "Shoes" ENDIF
    IF index = 7 label = "Teeth" ENDIF
    IF index = 8 label = "Undershirt" ENDIF
    IF index = 9 label = "Body Armour" ENDIF
    IF index = 10 label = "Decal" ENDIF
    IF index = 11 label = "Jacket / Top" ENDIF
    IF index = 12 label = "Hat" ENDIF
    IF index = 13 label = "Glasses" ENDIF
    IF index = 14 label = "Ears" ENDIF
    IF index = 15 label = "Mouth" ENDIF
    IF index = 16 label = "Left Hand" ENDIF
    IF index = 17 label = "Right Hand" ENDIF
    IF index = 18 label = "Watch" ENDIF
    IF index = 19 label = "Bracelet" ENDIF
    IF index = 20 label = "Hip" ENDIF
    IF index < NUM_PED_COMPONENTS
        current = GET_PED_DRAWABLE_VARIATION(playerPed, INT_TO_ENUM(PED_COMPONENT, index))
        variantCount = GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, INT_TO_ENUM(PED_COMPONENT, index))
        IF variantCount <= 0
            DRAW_OPTION(y, label, "N/A", g_item = index, 0)
        ELSE
            DRAW_NUMBER_OPTION(y, label, current, g_item = index)
        ENDIF
    ELSE
        current = GET_PED_PROP_INDEX(playerPed, INT_TO_ENUM(PED_PROP_POSITION, index - NUM_PED_COMPONENTS))
        variantCount = GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(playerPed, INT_TO_ENUM(PED_PROP_POSITION, index - NUM_PED_COMPONENTS))
        IF current < 0
            IF variantCount <= 0
                DRAW_OPTION(y, label, "N/A", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, label, "NONE", g_item = index, 0)
            ENDIF
        ELSE
            DRAW_NUMBER_OPTION(y, label, current, g_item = index)
        ENDIF
    ENDIF
ENDPROC

PROC DRAW_OUTFIT_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "OUTFIT")
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 21
        DRAW_OUTFIT_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC
