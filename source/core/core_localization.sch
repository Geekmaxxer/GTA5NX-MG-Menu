//|=======================================================================================|
//|  core_localization.sch - 6-Language Localization Engine for MEGATARD Menu
//|=======================================================================================|
//  0 = English
//  1 = Spanish
//  2 = German
//  3 = Russian
//  4 = Portuguese
//  5 = French

FUNC STRING TR(STRING en, STRING es, STRING zh, STRING de, STRING ja, STRING ru, STRING pt, STRING fr)
    zh = ja
    ja = zh
    SWITCH g_menu_language
        CASE 1 RETURN es
        CASE 2 RETURN de
        CASE 3 RETURN ru
        CASE 4 RETURN pt
        CASE 5 RETURN fr
    ENDSWITCH
    RETURN en
ENDFUNC

FUNC STRING TR_VALUE_TOKEN(STRING value)
    IF g_menu_language = 0 RETURN value ENDIF
    IF ARE_STRINGS_EQUAL(value, "ON")
        RETURN TR("ON", "SÍ", "开启", "EIN", "オン", "ВКЛ", "LIGADO", "OUI")
    ELIF ARE_STRINGS_EQUAL(value, "OFF")
        RETURN TR("OFF", "NO", "关闭", "AUS", "オフ", "ВЫКЛ", "DESLIGADO", "NON")
    ELIF ARE_STRINGS_EQUAL(value, "APPLY")
        RETURN TR("APPLY", "APLICAR", "应用", "ANWENDEN", "適用", "ПРИМЕНИТЬ", "APLICAR", "APPLIQUER")
    ELIF ARE_STRINGS_EQUAL(value, "OPEN")
        RETURN TR("OPEN", "ABRIR", "打开", "ÖFFNEN", "開く", "ОТКРЫТЬ", "ABRIR", "OUVRIR")
    ELIF ARE_STRINGS_EQUAL(value, "SELECTED")
        RETURN TR("SELECTED", "SELECCIONADO", "已选择", "AUSGEWÄHLT", "選択中", "ВЫБРАНО", "SELECIONADO", "SÉLECTIONNÉ")
    ELIF ARE_STRINGS_EQUAL(value, "< Loading >")
        RETURN TR("< Loading >", "< Cargando >", "< 加载中 >", "< Lädt >", "< 読込中 >", "< Загрузка >", "< Carregando >", "< Chargement >")
    ELIF ARE_STRINGS_EQUAL(value, "< Stopped >")
        RETURN TR("< Stopped >", "< Detenido >", "< 已停止 >", "< Gestoppt >", "< 停止 >", "< Остановлено >", "< Parado >", "< Arrêté >")
    ELIF ARE_STRINGS_EQUAL(value, "< Default >")
        RETURN TR("< Default >", "< Por defecto >", "< 默认 >", "< Standard >", "< デフォルト >", "< По умолч. >", "< Padrão >", "< Par défaut >")
    ELIF ARE_STRINGS_EQUAL(value, "< None >")
        RETURN TR("< None >", "< Ninguno >", "< 无 >", "< Keine >", "< なし >", "< Нет >", "< Nenhum >", "< Aucun >")
    ELIF ARE_STRINGS_EQUAL(value, "< Stock >")
        RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Série >")
    ELIF ARE_STRINGS_EQUAL(value, "< OFF >")
        RETURN TR("< OFF >", "< NO >", "< 关闭 >", "< AUS >", "< オフ >", "< ВЫКЛ >", "< DESLIGADO >", "< NON >")
    ELIF ARE_STRINGS_EQUAL(value, "< Empty >")
        RETURN TR("< Empty >", "< Vacío >", "< 空 >", "< Leer >", "< 空 >", "< Пусто >", "< Vazio >", "< Vide >")
    ELIF ARE_STRINGS_EQUAL(value, "NOT FOUND")
        RETURN TR("NOT FOUND", "NO ENCONTRADO", "未找到", "NICHT GEFUNDEN", "見つかりません", "НЕ НАЙДЕНО", "NÃO ENCONTRADO", "INTROUVABLE")
    ELIF ARE_STRINGS_EQUAL(value, "TYPE MODEL")
        RETURN TR("TYPE MODEL", "ESCRIBIR MODELO", "输入模型", "MODELL EINGEBEN", "モデル入力", "ВВЕДИТЕ МОДЕЛЬ", "DIGITAR MODELO", "ENTRER MODÈLE")
    ELIF ARE_STRINGS_EQUAL(value, "No Vehicle")
        RETURN TR("No Vehicle", "Sin vehículo", "无载具", "Kein Fahrzeug", "車両なし", "Нет транспорта", "Sem veículo", "Aucun véhicule")
    ELIF ARE_STRINGS_EQUAL(value, "NO VEHICLE")
        RETURN TR("NO VEHICLE", "SIN VEHÍCULO", "无载具", "KEIN FAHRZEUG", "車両なし", "НЕТ ТРАНСПОРТА", "SEM VEÍCULO", "AUCUN VÉHICULE")
    ELIF ARE_STRINGS_EQUAL(value, "REMOVE")
        RETURN TR("REMOVE", "QUITAR", "移除", "ENTFERNEN", "解除", "УДАЛИТЬ", "REMOVER", "RETIRER")
    ELIF ARE_STRINGS_EQUAL(value, "DELETED")
        RETURN TR("DELETED", "ELIMINADO", "已删除", "GELÖSCHT", "削除済", "УДАЛЕНО", "EXCLUÍDO", "SUPPRIMÉ")
    ELIF ARE_STRINGS_EQUAL(value, "CLEARED")
        RETURN TR("CLEARED", "LIMPIADO", "已清除", "GELEERT", "消去済", "ОЧИЩЕНО", "LIMPO", "EFFACÉ")
    ENDIF
    RETURN value
ENDFUNC
