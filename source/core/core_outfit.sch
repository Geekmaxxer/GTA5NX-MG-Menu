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
    STRING label = TR("Outfit item", "Prenda", "服装部位", "Outfit-Teil", "衣装項目", "Элемент одежды", "Item do traje", "Élément de tenue")
    IF index = 0 label = TR("Head", "Cabeza", "头部", "Kopf", "頭", "Голова", "Cabeça", "Tête") ENDIF
    IF index = 1 label = TR("Beard / Mask", "Barba / Máscara", "胡须 / 面具", "Bart / Maske", "髭 / マスク", "Борода / Маска", "Barba / Máscara", "Barbe / Masque") ENDIF
    IF index = 2 label = TR("Hair", "Pelo", "发型", "Haare", "髪", "Волосы", "Cabelo", "Cheveux") ENDIF
    IF index = 3 label = TR("Torso", "Torso", "躯干", "Oberkörper", "胴体", "Торс", "Torso", "Torse") ENDIF
    IF index = 4 label = TR("Legs / Pants", "Piernas / Pantalones", "腿部 / 裤子", "Beine / Hose", "脚 / ズボン", "Ноги / Штаны", "Pernas / Calças", "Jambes / Pantalon") ENDIF
    IF index = 5 label = TR("Hands / Gloves", "Manos / Guantes", "手部 / 手套", "Hände / Handschuhe", "手 / 手袋", "Руки / Перчатки", "Mãos / Luvas", "Mains / Gants") ENDIF
    IF index = 6 label = TR("Shoes", "Zapatos", "鞋子", "Schuhe", "靴", "Обувь", "Sapatos", "Chaussures") ENDIF
    IF index = 7 label = TR("Teeth", "Dientes", "牙齿", "Zähne", "歯", "Зубы", "Dentes", "Dents") ENDIF
    IF index = 8 label = TR("Undershirt", "Camiseta interior", "内衬", "Unterhemd", "肌着", "Майка", "Camisa interna", "Sous-vêtement") ENDIF
    IF index = 9 label = TR("Body Armour", "Chaleco antibalas", "防弹衣", "Schutzweste", "ボディアーマー", "Бронежилет", "Colete balístico", "Gilet pare-balles") ENDIF
    IF index = 10 label = TR("Decal", "Calcomanía", "贴花", "Abzeichen", "デカール", "Декаль", "Decalque", "Décalcomanie") ENDIF
    IF index = 11 label = TR("Jacket / Top", "Chaqueta / Parte superior", "夹克 / 上衣", "Jacke / Oberteil", "ジャケット / トップス", "Куртка / Верх", "Jaqueta / Parte superior", "Veste / Haut") ENDIF
    IF index = 12 label = TR("Hat", "Sombrero", "帽子", "Hut", "帽子", "Головной убор", "Chapéu", "Chapeau") ENDIF
    IF index = 13 label = TR("Glasses", "Gafas", "眼镜", "Brille", "メガネ", "Очки", "Óculos", "Lunettes") ENDIF
    IF index = 14 label = TR("Ears", "Orejas", "耳饰", "Ohren", "耳", "Уши", "Orelhas", "Oreilles") ENDIF
    IF index = 15 label = TR("Mouth", "Boca", "嘴部", "Mund", "口", "Рот", "Boca", "Bouche") ENDIF
    IF index = 16 label = TR("Left Hand", "Mano izquierda", "左手", "Linke Hand", "左手", "Левая рука", "Mão esquerda", "Main gauche") ENDIF
    IF index = 17 label = TR("Right Hand", "Mano derecha", "右手", "Rechte Hand", "右手", "Правая рука", "Mão direita", "Main droite") ENDIF
    IF index = 18 label = TR("Watch", "Reloj", "手表", "Uhr", "腕時計", "Часы", "Relógio", "Montre") ENDIF
    IF index = 19 label = TR("Bracelet", "Pulsera", "手链", "Armband", "ブレスレット", "Браслет", "Pulseira", "Bracelet") ENDIF
    IF index = 20 label = TR("Hip", "Cadera", "腰部", "Hüfte", "腰", "Бедро", "Quadril", "Hanche") ENDIF
    IF index < NUM_PED_COMPONENTS
        current = GET_PED_DRAWABLE_VARIATION(playerPed, INT_TO_ENUM(PED_COMPONENT, index))
        variantCount = GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, INT_TO_ENUM(PED_COMPONENT, index))
        IF variantCount <= 0
            DRAW_OPTION(y, label, TR("N/A", "N/D", "无", "N/V", "なし", "Н/Д", "N/D", "N/D"), g_item = index, 0)
        ELSE
            DRAW_NUMBER_OPTION(y, label, current, g_item = index)
        ENDIF
    ELSE
        current = GET_PED_PROP_INDEX(playerPed, INT_TO_ENUM(PED_PROP_POSITION, index - NUM_PED_COMPONENTS))
        variantCount = GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(playerPed, INT_TO_ENUM(PED_PROP_POSITION, index - NUM_PED_COMPONENTS))
        IF current < 0
            IF variantCount <= 0
                DRAW_OPTION(y, label, TR("N/A", "N/D", "无", "N/V", "なし", "Н/Д", "N/D", "N/D"), g_item = index, 0)
            ELSE
                DRAW_OPTION(y, label, TR("NONE", "NINGUNO", "无", "KEINE", "なし", "НЕТ", "NENHUM", "AUCUN"), g_item = index, 0)
            ENDIF
        ELSE
            DRAW_NUMBER_OPTION(y, label, current, g_item = index)
        ENDIF
    ENDIF
ENDPROC

PROC DRAW_OUTFIT_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("OUTFIT", "ATUENDO", "服装", "OUTFIT", "衣装", "ОДЕЖДА", "TRAJE", "TENUE"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < 21
        DRAW_OUTFIT_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC
