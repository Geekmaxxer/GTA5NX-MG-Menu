// ---------------------------------------------------------------------------
// LS Customs mod-kit plumbing (v0.9.9).
//
// Every LSC write path used to force SET_VEHICLE_MOD_KIT(vehicle, 0).  Kit 0 is
// the *stock* kit - the same normalisation the game's own scripts apply to a
// stock car (FMMC_header.sch does exactly SET_VEHICLE_MOD_KIT(veh, 0) before
// reading stock mods).  A car that carries an add-on kit (the lowrider/Bennys
// kits that hold MOD_INTERIOR1-5, MOD_HYDRO, MOD_CHASSIS2-5, MOD_TRUNK,
// MOD_ENGINEBAY1-3, MOD_DOOR_L/R) reports GET_NUM_VEHICLE_MODS == 0 for those
// slots on kit 0, which is why the interior/hydraulics rows could never do
// anything.  The fix is to read the car's own kit instead of asserting 0, and to
// let the player pick a kit explicitly on the new "Mod Kit" row.
//
// GET_VEHICLE_MOD_KIT returns the active kit index; GET_NUM_MOD_KITS how many
// the car has.  Both are clamped because a car with no mod data may report 0
// kits (or a negative active index) and SET_VEHICLE_MOD_KIT must never be given
// an out-of-range value.
// ---------------------------------------------------------------------------

// How many mod kits this vehicle has.  Returns 1 for a car that reports none,
// so an explicit kit index of 0 always remains valid.
FUNC INT LSC_KIT_COUNT(VEHICLE_INDEX vehicle)
    INT kits = GET_NUM_MOD_KITS(vehicle)
    IF kits <= 0 RETURN 1 ENDIF
    RETURN kits
ENDFUNC

// The kit index every LSC write should use for this vehicle: the player's
// explicit choice when it is in range, otherwise the car's own active kit,
// clamped to [0, kits-1].  g_lsc_kit_choice = -1 means "follow the car".
FUNC INT LSC_ACTIVE_KIT(VEHICLE_INDEX vehicle)
    INT kits = LSC_KIT_COUNT(vehicle)
    INT choice = g_lsc_kit_choice
    IF choice < 0 choice = GET_VEHICLE_MOD_KIT(vehicle) ENDIF
    IF choice < 0 choice = 0 ENDIF
    IF choice >= kits choice = kits - 1 ENDIF
    RETURN choice
ENDFUNC

// One place that activates the LSC kit, so the literal 0 can never creep back in.
PROC LSC_USE_KIT(VEHICLE_INDEX vehicle)
    SET_VEHICLE_MOD_KIT(vehicle, LSC_ACTIVE_KIT(vehicle))
ENDPROC

// The kit a *write* for this slot should land in.
//
// This is the second half of the interiors fix.  It starts from the player's kit
// choice and, only when that kit has no variants for the requested slot and the
// car actually has more than one kit, searches for the first kit that does.  So
// the lowrider slots work on any car without the player having to hunt for the
// right kit number, while a single-kit car keeps exactly the old behaviour.
//
// If no kit has the slot, the preferred kit is restored so the car is left
// exactly as it was found, and the caller then sees GET_NUM_VEHICLE_MODS == 0
// (its existing "NOT AVAILABLE" path).
//
// APPLY PATHS ONLY.  This calls SET_VEHICLE_MOD_KIT, so it must never be reached
// from a draw proc - that would switch the car's kit every single frame.
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

// Kit type label for the "Mod Kit" row (MOD_KIT_TYPE, commands_vehicle.sch).
FUNC STRING LSC_KIT_TYPE_LABEL(VEHICLE_INDEX vehicle)
    MOD_KIT_TYPE kitType = GET_VEHICLE_MOD_KIT_TYPE(vehicle)
    IF kitType = MKT_SPORT RETURN TR("Sport", "Deportivo", "运动", "Sport", "スポーツ", "Спорт", "Esportivo", "Sport") ENDIF
    IF kitType = MKT_SUV RETURN "SUV" ENDIF
    IF kitType = MKT_SPECIAL RETURN TR("Special", "Especial", "特殊", "Spezial", "スペシャル", "Особый", "Especial", "Spécial") ENDIF
    RETURN TR("Standard", "Estándar", "标准", "Standard", "標準", "Стандарт", "Padrão", "Standard")
ENDFUNC

// "Mod Kit" row value: the active kit index only.
//
// This compiler cannot append to a STRING and cannot return a TEXT_LABEL_63
// (only TEXT_LABEL_63 supports +=, and it does not convert to STRING on RETURN),
// so every composed row value in this file is a literal table - the same approach
// DIRT_LEVEL_VALUE_LABEL and DRAW_LSC_VARIANT_COUNT already use.  The kit *type*
// and *count* get their own rows below so no information is lost.
FUNC STRING LSC_KIT_INDEX_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT active = LSC_ACTIVE_KIT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) + 1
    IF active = 1 RETURN "< Kit 1 >" ENDIF
    IF active = 2 RETURN "< Kit 2 >" ENDIF
    IF active = 3 RETURN "< Kit 3 >" ENDIF
    IF active = 4 RETURN "< Kit 4 >" ENDIF
    RETURN "< Kit 5+ >"
ENDFUNC

// How many mod kits the car carries.  "Stock Kit Only" is the important case:
// on such a car the lowrider slots genuinely do not exist, which is what the
// interior page's "None on this car" rows then report.
FUNC STRING LSC_KIT_COUNT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT kits = LSC_KIT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF kits <= 1 RETURN TR("< Stock Kit Only >", "< Solo kit de serie >", "< 仅原厂套件 >", "< Nur Serien-Kit >", "< 純正キットのみ >", "< Только сток-кит >", "< Apenas Kit Original >", "< Kit d'origine seul >") ENDIF
    IF kits = 2 RETURN "< 2 Kits >" ENDIF
    IF kits = 3 RETURN "< 3 Kits >" ENDIF
    RETURN "< 4+ Kits >"
ENDFUNC

FUNC STRING LSC_KIT_TYPE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    RETURN LSC_KIT_TYPE_LABEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

// ===========================================================================
// Bennys / lowrider capability (v0.9.9)
//
// WHY THIS EXISTS
//
// The Hydraulics and Lowrider Interior pages could never work on the cars a
// player naturally picks, and no row said why.  A car carries hydraulic mod data
// only if it is a "supermod" build of a base car - what Rockstar sells at
// Benny's.  On the plain car every hydraulics native is a silent no-op:
// TOGGLE_VEHICLE_MOD(MOD_TOGGLE_HYDRAULICS) writes a flag the car has no mod
// for, SET_CAN_USE_HYDRAULICS only sets a gate, and the stance rows write raise
// factors to wheels that have no hydraulic suspension.  Fixing the *kit* (the
// LSC_KIT_* work above) is necessary but not sufficient: a stock model has no
// hydraulic data in ANY kit.
//
// WHERE THE DATA COMES FROM
//
// Not a wiki and not a guess.  These tables are Rockstar's own, read out of this
// port's shipped dev tree (X:\gta5\script\dev_ng), so every identifier is
// guaranteed to be declared in this build too:
//
//   shared\include\public\vehicle_public.sch
//     GET_VEHICLE_SUPERMOD_MODEL()        stock  -> custom
//     GET_SUPERMOOD_VEHICLE_BASE_MODEL()  custom -> stock
//     IS_VEHICLE_A_SUPERMOD_MODEL(eModel, SUPERMOD_FLAG_HAS_HYDRAULICS)
//
// That last function is Rockstar's own answer to "which cars have hydraulics",
// and it corrects three things a name-based guess gets wrong - which is exactly
// why the names were read instead of assumed:
//
//   * VOODOO is the CUSTOM and VOODOO2 is the plain stock car.  The "2" suffix
//     convention is inverted for this one model.
//   * The custom Tornado is TORNADO5, not TORNADO2.
//   * The custom Virgo's base car is VIRGO3 (Virgo Classic), not VIRGO.
//
// Rockstar gates several of these (SABREGT2, TORNADO5, VIRGO2, MINIVAN2,
// SLAMVAN3, FACTION3) behind lowrider2 tunables, so whether this port ships them
// is answered at runtime by IS_MODEL_IN_CDIMAGE - every Bennys row is
// availability-checked rather than assumed.
//
// Nothing below claims a car HAS hydraulics.  HYDRO_SUPPORTED() asks the car
// itself (MOD_HYDRO variant count), the same probe Rockstar's hydraulics code
// uses.
// ===========================================================================

// The verified custom variants.  Index order is shared with BENNYS_STOCK_MODEL.
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

// Stock counterpart of each custom variant, same index.  Rockstar's
// GET_SUPERMOOD_VEHICLE_BASE_MODEL() is the authority; FACTION2 and FACTION3
// share FACTION because the Donk is a body variant of the same base car.
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

// Which custom variant does this *stock* car convert to?  -1 = no verified
// conversion, so Convert To Custom refuses instead of inventing a pairing.
FUNC INT BENNYS_PAIR_FOR_MODEL(MODEL_NAMES model)
    INT index = 0
    WHILE index < BENNYS_MENU_ROWS
        IF BENNYS_STOCK_MODEL(index) = model
            // Index 3 is the Faction Custom Donk, a body variant of the same
            // base car, so the plain conversion always lands on the standard
            // Faction Custom (index 2).
            IF index = 3 RETURN 2 ENDIF
            RETURN index
        ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

// Is this model already one of the custom variants?  Stops a car being
// converted onto itself.
FUNC INT BENNYS_CUSTOM_PAIR_FOR_MODEL(MODEL_NAMES model)
    INT index = 0
    WHILE index < BENNYS_MENU_ROWS
        IF BENNYS_CUSTOM_MODEL(index) = model RETURN index ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

// Model of the car the player is sitting in.  Callers check
// IS_PED_IN_ANY_VEHICLE first; ADDER is only an unused fallback.
FUNC MODEL_NAMES LSC_PLAYER_VEHICLE_MODEL()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN ADDER ENDIF
    RETURN GET_ENTITY_MODEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

// Live display name for any model, with an explicit answer rather than a row
// that renders empty.  IS_MODEL_IN_CDIMAGE is the same check the ped search
// already applies to typed-in model names.
FUNC STRING VEHICLE_MODEL_NAME_TEXT(MODEL_NAMES model)
    IF NOT IS_MODEL_IN_CDIMAGE(model) RETURN TR("< Not In This Build >", "< No en esta versión >", "< 此版本不包含 >", "< Nicht in diesem Build >", "< このビルドに無し >", "< Нет в этой сборке >", "< Ausente Nesta Build >", "< Absent de cette version >") ENDIF
    IF NOT IS_MODEL_VALID(model) RETURN TR("< Model Invalid >", "< Modelo inválido >", "< 模型无效 >", "< Modell ungültig >", "< 無効なモデル >", "< Неверная модель >", "< Modelo Inválido >", "< Modèle invalide >") ENDIF
    STRING modelName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)
    IF IS_STRING_NULL_OR_EMPTY(modelName) RETURN TR("< Unnamed >", "< Sin nombre >", "< 未命名 >", "< Unbenannt >", "< 名称なし >", "< Без имени >", "< Sem Nome >", "< Sans nom >") ENDIF
    RETURN modelName
ENDFUNC

// The definitive "can this car carry hydraulics" test, and the one Rockstar's
// own hydraulics code uses: MOD_HYDRO has variants only on a car built for them.
// A stock model reports 0 on every kit, which is exactly why the stance rows did
// nothing on one.
FUNC BOOL HYDRO_SUPPORTED(VEHICLE_INDEX vehicle)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN FALSE ENDIF
    RETURN GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) > 0
ENDFUNC

FUNC BOOL PLAYER_CAR_HAS_HYDRO()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN FALSE ENDIF
    RETURN HYDRO_SUPPORTED(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
ENDFUNC

// One-line answer to "why can I not fit hydraulics here", used by the Support
// Check page and by the Hydraulics page's own status row.
FUNC STRING LOWRIDER_SUPPORT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF PLAYER_CAR_HAS_HYDRO() RETURN TR("< Custom - Supported >", "< Custom - Compatible >", "< 改装版 - 支持 >", "< Custom - Unterstützt >", "< カスタム - 対応 >", "< Кастом - Поддерживается >", "< Custom - Compatível >", "< Custom - Compatible >") ENDIF
    IF BENNYS_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN TR("< Stock - Convert First >", "< De serie - Convertir antes >", "< 原厂 - 请先改装 >", "< Serie - Zuerst umbauen >", "< 純正 - 要カスタム変換 >", "< Сток - Сначала конверт. >", "< Original - Converter Antes >", "< Origine - Convertir d'abord >") ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN TR("< Custom - No Hydro >", "< Custom - Sin hidráulica >", "< 改装版 - 无液压 >", "< Custom - Keine Hydraulik >", "< カスタム - ハイドロ無し >", "< Кастом - Без гидравлики >", "< Custom - Sem Hidráulica >", "< Custom - Sans hydraulique >") ENDIF
    RETURN TR("< No Lowrider Kit >", "< Sin kit lowrider >", "< 无低底盘套件 >", "< Kein Lowrider-Kit >", "< ローライダーキット無し >", "< Нет лоурайдер-кита >", "< Sem Kit Lowrider >", "< Aucun kit lowrider >")
ENDFUNC

// What the custom variant of the current car is, if it has one.
FUNC STRING BENNYS_VARIANT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    MODEL_NAMES current = LSC_PLAYER_VEHICLE_MODEL()
    INT pair = BENNYS_PAIR_FOR_MODEL(current)
    IF pair >= 0 RETURN VEHICLE_MODEL_NAME_TEXT(BENNYS_CUSTOM_MODEL(pair)) ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(current) >= 0 RETURN TR("< Already Custom >", "< Ya es Custom >", "< 已是改装版 >", "< Bereits Custom >", "< カスタム済 >", "< Уже кастом >", "< Já é Custom >", "< Déjà Custom >") ENDIF
    RETURN TR("< None For This Car >", "< Ninguno para este coche >", "< 此车无改装版 >", "< Keins für dieses Auto >", "< この車両には無し >", "< Нет для этого авто >", "< Nenhum Para Este Carro >", "< Aucun pour cette voiture >")
ENDFUNC

// The stock car a current custom variant was built from.
FUNC STRING BENNYS_BASE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT pair = BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL())
    IF pair >= 0 RETURN VEHICLE_MODEL_NAME_TEXT(BENNYS_STOCK_MODEL(pair)) ENDIF
    RETURN TR("< Stock Car Already >", "< Ya es de serie >", "< 已是原厂车 >", "< Bereits Serienfahrzeug >", "< 既に純正車両 >", "< Уже стоковое авто >", "< Já é Carro Original >", "< Déjà d'origine >")
ENDFUNC

// Value of the "Convert To Custom" row.  A result outranks the preview for
// CONVERT_FEEDBACK_MS so the reason a press did nothing is actually visible -
// which is the whole point of this row existing next to the hydraulics rows.
FUNC STRING CONVERT_STATUS_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF g_convert_pending RETURN TR("< Working... >", "< Procesando... >", "< 处理中... >", "< Arbeitet... >", "< 処理中... >", "< Обработка... >", "< Processando... >", "< En cours... >") ENDIF
    IF g_convert_feedback != 0 AND GET_GAME_TIMER() < g_convert_feedback_until
        IF g_convert_feedback = 1 RETURN TR("< Converted >", "< Convertido >", "< 已转换 >", "< Umgebaut >", "< 変換完了 >", "< Конвертировано >", "< Convertido >", "< Converti >") ENDIF
        IF g_convert_feedback = 2 RETURN TR("< No Variant For This Car >", "< Sin variante para este coche >", "< 此车无改装型 >", "< Keine Variante für dieses Auto >", "< 対応カスタム無し >", "< Нет варианта для авто >", "< Sem Variante Para Este Carro >", "< Aucune variante >") ENDIF
        IF g_convert_feedback = 3 RETURN TR("< Not In This Build >", "< No en esta versión >", "< 此版本不包含 >", "< Nicht in diesem Build >", "< このビルドに無し >", "< Нет в этой сборке >", "< Ausente Nesta Build >", "< Absent de cette version >") ENDIF
        IF g_convert_feedback = 4 RETURN TR("< Conversion Failed >", "< Falló la conversión >", "< 转换失败 >", "< Umbau fehlgeschlagen >", "< 変換失敗 >", "< Ошибка конвертации >", "< Falha na Conversão >", "< Échec de conversion >") ENDIF
        IF g_convert_feedback = 5 RETURN TR("< Timed Out >", "< Tiempo agotado >", "< 超时 >", "< Zeitüberschreitung >", "< タイムアウト >", "< Тайм-аут >", "< Tempo Esgotado >", "< Délai dépassé >") ENDIF
    ENDIF
    IF BENNYS_CUSTOM_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN TR("< Already Custom >", "< Ya es Custom >", "< 已是改装版 >", "< Bereits Custom >", "< カスタム済 >", "< Уже кастом >", "< Já é Custom >", "< Déjà Custom >") ENDIF
    IF BENNYS_PAIR_FOR_MODEL(LSC_PLAYER_VEHICLE_MODEL()) >= 0 RETURN TR("< Ready >", "< Listo >", "< 就绪 >", "< Bereit >", "< 準備完了 >", "< Готово >", "< Pronto >", "< Prêt >") ENDIF
    RETURN TR("< No Variant >", "< Sin variante >", "< 无改装型 >", "< Keine Variante >", "< バリアント無し >", "< Нет варианта >", "< Sem Variante >", "< Aucune variante >")
ENDFUNC

FUNC STRING LSC_RESOLVE_LABEL(STRING gxtLabel)
    IF IS_STRING_NULL_OR_EMPTY(gxtLabel) RETURN "" ENDIF
    STRING resolved = GET_FILENAME_FOR_AUDIO_CONVERSATION(gxtLabel)
    IF IS_STRING_NULL_OR_EMPTY(resolved) OR ARE_STRINGS_EQUAL(resolved, "NULL")
        RETURN gxtLabel
    ENDIF
    RETURN resolved
ENDFUNC

FUNC INT LSC_SLOT_FOR_CHOICE(INT choice)
    SWITCH choice
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

FUNC INT LSC_SLOT()
    RETURN LSC_SLOT_FOR_CHOICE(g_lsc_slot_choice)
ENDFUNC

FUNC BOOL LSC_SLOT_AVAILABLE(VEHICLE_INDEX vehicle, INT choice)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN FALSE ENDIF
    INT slot = LSC_SLOT_FOR_CHOICE(choice)
    LSC_KIT_FOR_SLOT(vehicle, slot)
    IF GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot)) > 0 RETURN TRUE ENDIF
    IF GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot)) >= 0 RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

FUNC BOOL LSC_HAS_ANY_CUSTOMIZABLE_SLOTS(VEHICLE_INDEX vehicle)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN FALSE ENDIF
    INT i = 0
    WHILE i < 43
        IF LSC_SLOT_AVAILABLE(vehicle, i) RETURN TRUE ENDIF
        i = i + 1
    ENDWHILE
    RETURN FALSE
ENDFUNC

FUNC INT LSC_NEXT_VALID_SLOT(VEHICLE_INDEX vehicle, INT currentChoice, INT direction)
    IF NOT DOES_ENTITY_EXIST(vehicle) RETURN currentChoice ENDIF
    IF NOT LSC_HAS_ANY_CUSTOMIZABLE_SLOTS(vehicle) RETURN currentChoice ENDIF
    INT nextChoice = currentChoice
    INT attempts = 0
    WHILE attempts < 43
        nextChoice = nextChoice + direction
        IF nextChoice < 0 nextChoice = 42 ENDIF
        IF nextChoice > 42 nextChoice = 0 ENDIF
        IF LSC_SLOT_AVAILABLE(vehicle, nextChoice)
            RETURN nextChoice
        ENDIF
        attempts = attempts + 1
    ENDWHILE
    RETURN currentChoice
ENDFUNC

PROC APPLY_LSC_MOD()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    INT slot = LSC_SLOT()
    // Land the write in the kit that actually holds this slot.
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
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    g_lsc_mod_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
ENDPROC

PROC ADJUST_LSC_MOD(INT direction)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
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
    // Resolve and follow the car's own mod kit.  Asserting kit 0 here is what hid
    // every lowrider slot: the interiors/hydraulics/chassis of a car with an
    // add-on kit live in that kit, and on kit 0 GET_NUM_VEHICLE_MODS reports 0
    // for them.  The "Mod Kit" row lets the player override this explicitly.
    g_lsc_kit_choice = LSC_ACTIVE_KIT(vehicle)
    LSC_USE_KIT(vehicle)
    // Hold Stance belongs to one car: entering a different one must not carry the
    // re-assert over to it.
    IF g_lsc_vehicle != vehicle g_hydro_hold = FALSE ENDIF
    GET_VEHICLE_COLOURS(vehicle, primary, secondary)
    GET_VEHICLE_EXTRA_COLOURS(vehicle, pearlescent, wheelColour)
    g_lsc_primary_colour = LSC_CHOICE_FOR_COLOUR(primary)
    g_lsc_secondary_colour = LSC_CHOICE_FOR_COLOUR(secondary)
    g_lsc_pearlescent_colour = LSC_CHOICE_FOR_COLOUR(pearlescent)
    g_lsc_wheel_colour = LSC_CHOICE_FOR_COLOUR(wheelColour)
    g_lsc_wheel_type = ENUM_TO_INT(GET_VEHICLE_WHEEL_TYPE(vehicle))
    IF g_lsc_wheel_type < 0 OR g_lsc_wheel_type >= WHEEL_FAMILY_COUNT g_lsc_wheel_type = 0 ENDIF
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
    SWITCH GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle)
        CASE 3 g_lsc_plate_style = 0 BREAK
        CASE 0 g_lsc_plate_style = 1 BREAK
        CASE 4 g_lsc_plate_style = 2 BREAK
        CASE 2 g_lsc_plate_style = 3 BREAK
        CASE 1 g_lsc_plate_style = 4 BREAK
        CASE 5 g_lsc_plate_style = 5 BREAK
        CASE 6 g_lsc_plate_style = 6 BREAK
        CASE 12 g_lsc_plate_style = 7 BREAK
        CASE 7 g_lsc_plate_style = 8 BREAK
        CASE 8 g_lsc_plate_style = 9 BREAK
        CASE 9 g_lsc_plate_style = 10 BREAK
        CASE 10 g_lsc_plate_style = 11 BREAK
        CASE 11 g_lsc_plate_style = 12 BREAK
        DEFAULT g_lsc_plate_style = 1 BREAK
    ENDSWITCH
    // Lowrider / extras state.  Read after the kit is resolved above because
    // livery, trim (extra colour 5) and metal (extra colour 6) are per-kit
    // values - the SDK's own param note for colour 5/6 says they "should be
    // taken from the list in carcols.dat".
    g_lsc_livery = GET_VEHICLE_LIVERY(vehicle)
    IF g_lsc_livery < 0 OR g_lsc_livery >= GET_VEHICLE_LIVERY_COUNT(vehicle) g_lsc_livery = -1 ENDIF
    GET_VEHICLE_EXTRA_COLOUR_5(vehicle, trimColour)
    GET_VEHICLE_EXTRA_COLOUR_6(vehicle, metalColour)
    g_lsc_trim_colour = LSC_CHOICE_FOR_COLOUR(trimColour)
    g_lsc_metal_colour = LSC_CHOICE_FOR_COLOUR(metalColour)
    // The extras probe result belongs to whatever car was there before; clear it
    // so the toggle path cannot act on the previous vehicle's extra state.
    g_lsc_extra_exists = FALSE
    g_lsc_extra_on = FALSE
    // Hydraulics: read what the car already has so the page opens on the
    // vehicle's real state instead of the menu's last used values.
    g_hydro_enabled = IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_HYDRAULICS)
    g_hydro_level = GET_VEHICLE_MOD(vehicle, MOD_HYDRO)
    IF g_hydro_level < 0 OR g_hydro_level >= GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) g_hydro_level = -1 ENDIF
    IF LSC_HAS_ANY_CUSTOMIZABLE_SLOTS(vehicle)
        IF NOT LSC_SLOT_AVAILABLE(vehicle, g_lsc_slot_choice)
            g_lsc_slot_choice = LSC_NEXT_VALID_SLOT(vehicle, g_lsc_slot_choice, 1)
        ENDIF
    ENDIF
    SYNC_LSC_SLOT()
    g_lsc_vehicle = vehicle
ENDPROC

FUNC INT LSC_PLATE_STYLE_TO_ENGINE_INDEX(INT choice)
    SWITCH choice
        CASE 0 RETURN 3 BREAK
        CASE 1 RETURN 0 BREAK
        CASE 2 RETURN 4 BREAK
        CASE 3 RETURN 2 BREAK
        CASE 4 RETURN 1 BREAK
        CASE 5 RETURN 5 BREAK
        CASE 6 RETURN 6 BREAK
        CASE 7 RETURN 12 BREAK
        CASE 8 RETURN 7 BREAK
        CASE 9 RETURN 8 BREAK
        CASE 10 RETURN 9 BREAK
        CASE 11 RETURN 10 BREAK
        CASE 12 RETURN 11 BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

PROC APPLY_LSC_PLATE_STYLE(VEHICLE_INDEX vehicle)
    INT engineIdx = LSC_PLATE_STYLE_TO_ENGINE_INDEX(g_lsc_plate_style)
    IF DOES_ENTITY_EXIST(vehicle)
        IF engineIdx >= 0 AND engineIdx < GET_NUMBER_OF_VEHICLE_NUMBER_PLATES()
            SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, engineIdx)
        ENDIF
    ENDIF
ENDPROC

PROC DRAW_LSC_PLATE_STYLE_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("License Plate Style", "Estilo de matrícula", "车牌样式", "Kennzeichen-Stil", "ナンバープレート様式", "Стиль номерного знака", "Estilo de Placa", "Style de plaque")
    SWITCH g_lsc_plate_style
        CASE 0 DRAW_OPTION(y, lbl, TR("< Blue on White 1 >", "< Azul sobre blanco 1 >", "< 白底蓝字 1 >", "< Blau auf Weiß 1 >", "< 白地に青 1 >", "< Синий на белом 1 >", "< Azul no Branco 1 >", "< Bleu sur blanc 1 >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Blue on White 2 >", "< Azul sobre blanco 2 >", "< 白底蓝字 2 >", "< Blau auf Weiß 2 >", "< 白地に青 2 >", "< Синий на белом 2 >", "< Azul no Branco 2 >", "< Bleu sur blanc 2 >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Blue on White 3 >", "< Azul sobre blanco 3 >", "< 白底蓝字 3 >", "< Blau auf Weiß 3 >", "< 白地に青 3 >", "< Синий на белом 3 >", "< Azul no Branco 3 >", "< Bleu sur blanc 3 >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Yellow on Blue >", "< Amarillo sobre azul >", "< 蓝底黄字 >", "< Gelb auf Blau >", "< 青地に黄 >", "< Жёлтый на синем >", "< Amarelo no Azul >", "< Jaune sur bleu >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Yellow on Black >", "< Amarillo sobre negro >", "< 黑底黄字 >", "< Gelb auf Schwarz >", "< 黒地に黄 >", "< Жёлтый на чёрном >", "< Amarelo no Preto >", "< Jaune sur noir >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, "< North Yankton >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, "< eCola >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, lbl, "< Sprunk >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, lbl, "< Las Venturas >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, lbl, "< Liberty City >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, lbl, "< LS Car Meet >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, lbl, "< LS Panic >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, lbl, "< LS Pounders >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_LSC_PAINT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_COLOURS(vehicle, LSC_COLOUR_ID(g_lsc_primary_colour), LSC_COLOUR_ID(g_lsc_secondary_colour))
    SET_VEHICLE_EXTRA_COLOURS(vehicle, LSC_COLOUR_ID(g_lsc_pearlescent_colour), LSC_COLOUR_ID(g_lsc_wheel_colour))
ENDPROC

PROC DRAW_LSC_COLOUR_SELECTOR(FLOAT y, STRING label, INT choice, BOOL selected)
    SWITCH choice
        CASE 0 DRAW_OPTION(y, label, TR("< Black >", "< Negro >", "< 黑色 >", "< Schwarz >", "< ブラック >", "< Чёрный >", "< Preto >", "< Noir >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, label, TR("< Graphite >", "< Grafito >", "< 石墨黑 >", "< Graphit >", "< グラファイト >", "< Графит >", "< Grafite >", "< Graphite >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, label, TR("< Silver >", "< Plata >", "< 银色 >", "< Silber >", "< シルバー >", "< Серебристый >", "< Prata >", "< Argent >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, label, TR("< Blue Silver >", "< Plata azulado >", "< 蓝银色 >", "< Blausilber >", "< ブルーシルバー >", "< Сине-серебристый >", "< Prata Azulado >", "< Argent bleuté >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, label, TR("< Navy Blue >", "< Azul marino >", "< 海军蓝 >", "< Marineblau >", "< ネイビーブルー >", "< Тёмно-синий >", "< Azul-marinho >", "< Bleu marine >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, label, TR("< Red >", "< Rojo >", "< 红色 >", "< Rot >", "< レッド >", "< Красный >", "< Vermelho >", "< Rouge >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, label, TR("< Torino Red >", "< Rojo Torino >", "< 都灵红 >", "< Torinorot >", "< トリノレッド >", "< Туринский красный >", "< Vermelho Torino >", "< Rouge Torino >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, label, TR("< Orange >", "< Naranja >", "< 橙色 >", "< Orange >", "< オレンジ >", "< Оранжевый >", "< Laranja >", "< Orange >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, label, TR("< Yellow >", "< Amarillo >", "< 黄色 >", "< Gelb >", "< イエロー >", "< Жёлтый >", "< Amarelo >", "< Jaune >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, label, TR("< Dark Green >", "< Verde oscuro >", "< 深绿色 >", "< Dunkelgrün >", "< ダークグリーン >", "< Тёмно-зелёный >", "< Verde Escuro >", "< Vert foncé >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, label, TR("< Green >", "< Verde >", "< 绿色 >", "< Grün >", "< グリーン >", "< Зелёный >", "< Verde >", "< Vert >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, label, TR("< Dark Blue >", "< Azul oscuro >", "< 深蓝色 >", "< Dunkelblau >", "< ダークブルー >", "< Тёмно-синий >", "< Azul Escuro >", "< Bleu foncé >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, label, TR("< Light Blue >", "< Azul claro >", "< 浅蓝色 >", "< Hellblau >", "< ライトブルー >", "< Голубой >", "< Azul Claro >", "< Bleu clair >"), selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, label, TR("< Purple >", "< Morado >", "< 紫色 >", "< Lila >", "< パープル >", "< Фиолетовый >", "< Roxo >", "< Violet >"), selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, label, TR("< Gold >", "< Oro >", "< 金色 >", "< Gold >", "< ゴールド >", "< Золотой >", "< Ouro >", "< Or >"), selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, label, TR("< Brown >", "< Marrón >", "< 棕色 >", "< Braun >", "< ブラウン >", "< Коричневый >", "< Marrom >", "< Marron >"), selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, label, TR("< Cream >", "< Crema >", "< 奶油色 >", "< Creme >", "< クリーム >", "< Кремовый >", "< Creme >", "< Crème >"), selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, label, TR("< White >", "< Blanco >", "< 白色 >", "< Weiß >", "< ホワイト >", "< Белый >", "< Branco >", "< Blanc >"), selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, label, TR("< Chrome >", "< Cromado >", "< 铬合金 >", "< Chrom >", "< クローム >", "< Хром >", "< Cromado >", "< Chrome >"), selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, label, TR("< Pink >", "< Rosa >", "< 粉色 >", "< Pink >", "< ピンク >", "< Розовый >", "< Rosa >", "< Rose >"), selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, label, TR("< Salmon >", "< Salmón >", "< 鲑鱼粉 >", "< Lachs >", "< サーモン >", "< Лососёвый >", "< Salmão >", "< Saumon >"), selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, label, TR("< Matte Black >", "< Negro mate >", "< 哑光黑 >", "< Mattschwarz >", "< マットブラック >", "< Матовый чёрный >", "< Preto Fosco >", "< Noir mat >"), selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, label, TR("< Matte Grey >", "< Gris mate >", "< 哑光灰 >", "< Mattgrau >", "< マットグレー >", "< Матовый серый >", "< Cinza Fosco >", "< Gris mat >"), selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, label, TR("< Matte Red >", "< Rojo mate >", "< 哑光红 >", "< Mattrot >", "< マットレッド >", "< Матовый красный >", "< Vermelho Fosco >", "< Rouge mat >"), selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, label, TR("< Matte Green >", "< Verde mate >", "< 哑光绿 >", "< Mattgrün >", "< マットグリーン >", "< Матовый зелёный >", "< Verde Fosco >", "< Vert mat >"), selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, label, TR("< Matte Blue >", "< Azul mate >", "< 哑光蓝 >", "< Mattblau >", "< マットブルー >", "< Матовый синий >", "< Azul Fosco >", "< Bleu mat >"), selected, 3) BREAK
        CASE 26 DRAW_OPTION(y, label, TR("< Matte Yellow >", "< Amarillo mate >", "< 哑光黄 >", "< Mattgelb >", "< マットイエロー >", "< Матовый жёлтый >", "< Amarelo Fosco >", "< Jaune mat >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_WINDOW_TINT_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Window Tint", "Tinte de ventanillas", "车窗色调", "Scheibentönung", "ウィンドウスモーク", "Тонировка стёкол", "Película dos Vidros", "Teinte des vitres")
    SWITCH g_lsc_window_tint
        CASE 0 DRAW_OPTION(y, lbl, "< Stock >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Limo >", "< Limusina >", "< 豪华黑 >", "< Limousine >", "< リムジン >", "< Лимузин >", "< Limousine >", "< Limousine >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Light Smoke >", "< Ahumado claro >", "< 浅色烟熏 >", "< Hell getönt >", "< ライトスモーク >", "< Слабое затемнение >", "< Fumê Claro >", "< Fumé clair >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Dark Smoke >", "< Ahumado oscuro >", "< 深色烟熏 >", "< Dunkel getönt >", "< ダークスモーク >", "< Сильное затемнение >", "< Fumê Escuro >", "< Fumé foncé >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Pure Black >", "< Negro puro >", "< 纯黑 >", "< Tiefschwarz >", "< ピュアブラック >", "< Чисто чёрный >", "< Preto Puro >", "< Noir pur >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Green >", "< Verde >", "< 绿色 >", "< Grün >", "< グリーン >", "< Зелёный >", "< Verde >", "< Vert >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Light Green >", "< Verde claro >", "< 浅绿色 >", "< Hellgrün >", "< ライトグリーン >", "< Светло-зелёный >", "< Verde Claro >", "< Vert clair >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_PLATE_ROW(FLOAT y, BOOL selected)
    STRING lbl = TR("Plate Text", "Texto de matrícula", "车牌文字", "Kennzeichentext", "ナンバー文字列", "Текст номера", "Texto da Placa", "Texte de plaque")
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, lbl, "NO VEHICLE", selected, 0)
        EXIT
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(g_plate_value)
        DRAW_OPTION(y, lbl, GET_VEHICLE_NUMBER_PLATE_TEXT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())), selected, 3)
    ELSE
        DRAW_OPTION(y, lbl, g_plate_value, selected, 3)
    ENDIF
ENDPROC

PROC DRAW_LSC_MOD_SELECTOR(FLOAT y, BOOL selected)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(vehicle)
        DRAW_OPTION(y, TR("Selected Variant", "Variante seleccionada", "所选款式", "Gewählte Variante", "選択中のバリエーション", "Выбранный вариант", "Variante Selecionada", "Variante choisie"), TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >"), selected, 0)
        EXIT
    ENDIF
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    STRING lbl = TR("Selected Variant", "Variante seleccionada", "所选款式", "Gewählte Variante", "選択中のバリエーション", "Выбранный вариант", "Variante Selecionada", "Variante choisie")
    IF available <= 0
        DRAW_OPTION(y, lbl, TR("NOT AVAILABLE", "NO DISPONIBLE", "不可用", "NICHT VERFÜGBAR", "利用不可", "НЕДОСТУПНО", "INDISPONÍVEL", "INDISPONIBLE"), selected, 0)
    ELIF g_lsc_mod_choice < 0
        TEXT_LABEL_63 valStock = "< "
        valStock += TR("Stock", "De serie", "原厂", "Serie", "純正", "Сток", "Original", "Origine")
        valStock += " (0/"
        valStock += available
        valStock += ") >"
        DRAW_OPTION(y, lbl, valStock, selected, 3)
    ELSE
        STRING modName = ""
        STRING gxtMod = GET_MOD_TEXT_LABEL(vehicle, INT_TO_ENUM(MOD_TYPE, slot), g_lsc_mod_choice)
        IF NOT IS_STRING_NULL_OR_EMPTY(gxtMod) AND NOT ARE_STRINGS_EQUAL(gxtMod, "NULL")
            modName = LSC_RESOLVE_LABEL(gxtMod)
        ENDIF
        TEXT_LABEL_63 valMod = "< "
        IF NOT IS_STRING_NULL_OR_EMPTY(modName) AND NOT ARE_STRINGS_EQUAL(modName, "NULL")
            valMod += modName
        ELSE
            IF g_lsc_slot_choice >= 9 AND g_lsc_slot_choice <= 14
                valMod += TR("Level ", "Nivel ", "等级 ", "Stufe ", "レベル ", "Уровень ", "Nível ", "Niveau ")
            ELSE
                valMod += TR("Part ", "Pieza ", "零件 ", "Teil ", "パーツ ", "Деталь ", "Peça ", "Partie ")
            ENDIF
            INT partNum = g_lsc_mod_choice + 1
            valMod += partNum
        ENDIF
        valMod += " ("
        INT curIdx = g_lsc_mod_choice + 1
        valMod += curIdx
        valMod += "/"
        valMod += available
        valMod += ") >"
        DRAW_OPTION(y, lbl, valMod, selected, 3)
    ENDIF
ENDPROC

PROC DRAW_LSC_VARIANT_COUNT(FLOAT y, BOOL selected)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(vehicle)
        DRAW_OPTION(y, TR("Available Variants", "Variantes disponibles", "可用款式数", "Verfügbare Varianten", "利用可能バリエーション", "Доступные варианты", "Variantes Disponíveis", "Variantes disponibles"), "< None >", selected, 0)
        EXIT
    ENDIF
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    STRING lbl = TR("Available Variants", "Variantes disponibles", "可用款式数", "Verfügbare Varianten", "利用可能バリエーション", "Доступные варианты", "Variantes Disponíveis", "Variantes disponibles")
    IF available <= 0
        DRAW_OPTION(y, lbl, "< None >", selected, 0)
    ELIF available = 1
        DRAW_OPTION(y, lbl, TR("< 1 Variant >", "< 1 variante >", "< 1 款 >", "< 1 Variante >", "< 1バリエーション >", "< 1 вариант >", "< 1 Variante >", "< 1 variante >"), selected, 3)
    ELSE
        TEXT_LABEL_63 countText = "< "
        countText += available
        countText += " "
        countText += TR("Variants", "Variantes", "款", "Varianten", "バリエーション", "вариантов", "Variantes", "variantes")
        countText += " >"
        DRAW_OPTION(y, lbl, countText, selected, 3)
    ENDIF
ENDPROC

PROC DRAW_LSC_LIGHT_SELECTOR(FLOAT y, STRING label, INT choice, BOOL selected)
    SWITCH choice
        CASE 0 DRAW_OPTION(y, label, TR("< White >", "< Blanco >", "< 白色 >", "< Weiß >", "< ホワイト >", "< Белый >", "< Branco >", "< Blanc >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, label, TR("< Blue >", "< Azul >", "< 蓝色 >", "< Blau >", "< ブルー >", "< Синий >", "< Azul >", "< Bleu >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, label, TR("< Electric Blue >", "< Azul eléctrico >", "< 电光蓝 >", "< Elektrischblau >", "< エレクトリックブルー >", "< Электрик >", "< Azul Elétrico >", "< Bleu électrique >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, label, TR("< Mint Green >", "< Verde menta >", "< 薄荷绿 >", "< Mintgrün >", "< ミントグリーン >", "< Мятно-зелёный >", "< Verde Menta >", "< Vert menthe >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, label, TR("< Lime Green >", "< Verde lima >", "< 酸橙绿 >", "< Limettengrün >", "< ライムグリーン >", "< Лаймовый >", "< Verde Limão >", "< Vert citron >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, label, TR("< Yellow >", "< Amarillo >", "< 黄色 >", "< Gelb >", "< イエロー >", "< Жёлтый >", "< Amarelo >", "< Jaune >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, label, TR("< Gold >", "< Oro >", "< 金色 >", "< Gold >", "< ゴールド >", "< Золотой >", "< Ouro >", "< Or >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, label, TR("< Orange >", "< Naranja >", "< 橙色 >", "< Orange >", "< オレンジ >", "< Оранжевый >", "< Laranja >", "< Orange >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, label, TR("< Red >", "< Rojo >", "< 红色 >", "< Rot >", "< レッド >", "< Красный >", "< Vermelho >", "< Rouge >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, label, TR("< Pink >", "< Rosa >", "< 粉色 >", "< Pink >", "< ピンク >", "< Розовый >", "< Rosa >", "< Rose >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, label, TR("< Hot Pink >", "< Rosa intenso >", "< 艳粉 >", "< Knallpink >", "< ホットピンク >", "< Ярко-розовый >", "< Rosa Choque >", "< Rose vif >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, label, TR("< Purple >", "< Morado >", "< 紫色 >", "< Lila >", "< パープル >", "< Фиолетовый >", "< Roxo >", "< Violet >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, label, TR("< Blacklight >", "< Luz negra >", "< 紫光灯 >", "< Schwarzlicht >", "< ブラックライト >", "< Ультрафиолет >", "< Luz Negra >", "< Lumière noire >"), selected, 3) BREAK
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
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    INT kits = LSC_KIT_COUNT(vehicle)
    INT k = 0
    WHILE k < kits
        SET_VEHICLE_MOD_KIT(vehicle, k)
        INT slot = 0
        WHILE slot <= ENUM_TO_INT(MOD_DOOR_R)
            IF slot < ENUM_TO_INT(MOD_TOGGLE_NITROUS) OR slot > ENUM_TO_INT(MOD_TOGGLE_XENON_LIGHTS)
                INT available = GET_NUM_VEHICLE_MODS(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
                IF available > 0 SET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot), available - 1) ENDIF
            ENDIF
            slot = slot + 1
        ENDWHILE
        k = k + 1
    ENDWHILE
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_TURBO, TRUE)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_XENON_LIGHTS, TRUE)
    SET_VEHICLE_WINDOW_TINT(vehicle, 1)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, TRUE)
    SYNC_LSC_SLOT()
ENDPROC

PROC APPLY_LSC_MAX()
    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    SYNC_LSC_VEHICLE_STATE()
ENDPROC

PROC APPLY_LSC_STOCK_TO_VEHICLE(VEHICLE_INDEX vehicle)
    IF NOT DOES_ENTITY_EXIST(vehicle) EXIT ENDIF
    INT kits = LSC_KIT_COUNT(vehicle)
    INT k = 0
    WHILE k < kits
        SET_VEHICLE_MOD_KIT(vehicle, k)
        INT slot = 0
        WHILE slot <= ENUM_TO_INT(MOD_DOOR_R)
            IF slot < ENUM_TO_INT(MOD_TOGGLE_NITROUS) OR slot > ENUM_TO_INT(MOD_TOGGLE_XENON_LIGHTS)
                REMOVE_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
            ENDIF
            slot = slot + 1
        ENDWHILE
        k = k + 1
    ENDWHILE
    LSC_USE_KIT(vehicle)
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
    SYNC_LSC_SLOT()
ENDPROC

PROC APPLY_LSC_STOCK()
    APPLY_LSC_STOCK_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    SYNC_LSC_VEHICLE_STATE()
ENDPROC

FUNC STRING LSC_DEFAULT_SLOT_NAME(INT choice)
    SWITCH choice
        CASE 0 RETURN TR("Spoiler", "Alerón", "尾翼", "Spoiler", "スポイラー", "Спойлер", "Aerofólio", "Aileron") BREAK
        CASE 1 RETURN TR("Front bumper", "Parachoques del.", "前保险杠", "Frontstoßstange", "フロントバンパー", "Передний бампер", "Para-choque Diant.", "Pare-chocs avant") BREAK
        CASE 2 RETURN TR("Rear bumper", "Parachoques tras.", "后保险杠", "Heckstoßstange", "リアバンパー", "Задний бампер", "Para-choque Tras.", "Pare-chocs arrière") BREAK
        CASE 3 RETURN TR("Side skirts", "Faldones", "侧裙", "Seitenschweller", "サイドスカート", "Боковые юбки", "Saias Laterais", "Bas de caisse") BREAK
        CASE 4 RETURN TR("Exhaust", "Escape", "排气管", "Auspuff", "マフラー", "Выхлоп", "Escapamento", "Échappement") BREAK
        CASE 5 RETURN TR("Chassis", "Chasis", "底盘/防滚架", "Fahrgestell", "シャーシ", "Каркас", "Chassi", "Châssis") BREAK
        CASE 6 RETURN TR("Grille", "Parrilla", "格栅", "Kühlergrill", "グリル", "Решётка радиатора", "Grade", "Calandre") BREAK
        CASE 7 RETURN TR("Hood", "Capó", "引擎盖", "Motorhaube", "ボンネット", "Капот", "Capô", "Capot") BREAK
        CASE 8 RETURN TR("Roof", "Techo", "车顶", "Dach", "ルーフ", "Крыша", "Teto", "Toit") BREAK
        CASE 9 RETURN TR("Engine", "Motor", "引擎", "Motor", "エンジン", "Двигатель", "Motor", "Moteur") BREAK
        CASE 10 RETURN TR("Brakes", "Frenos", "刹车", "Bremsen", "ブレーキ", "Тормоза", "Freios", "Freins") BREAK
        CASE 11 RETURN TR("Transmission", "Transmisión", "变速箱", "Getriebe", "トランスミッション", "Трансмиссия", "Transmissão", "Transmission") BREAK
        CASE 12 RETURN TR("Horn", "Bocina", "喇叭", "Hupe", "クラクション", "Клаксон", "Buzina", "Klaxon") BREAK
        CASE 13 RETURN TR("Suspension", "Suspensión", "悬挂", "Federung", "サスペンション", "Подвеска", "Suspensão", "Suspension") BREAK
        CASE 14 RETURN TR("Armor", "Blindaje", "装甲", "Panzerung", "アーマー", "Броня", "Blindagem", "Blindage") BREAK
        CASE 15 RETURN TR("Wheels", "Ruedas", "车轮", "Räder", "ホイール", "Колёса", "Rodas", "Roues") BREAK
        CASE 16 RETURN TR("Plate Holder", "Portamatrículas", "车牌架", "Kennzeichenhalter", "プレートホルダー", "Рамка номера", "Suporte de Placa", "Support de plaque") BREAK
        CASE 17 RETURN TR("Vanity Plate", "Matrícula decorativa", "装饰车牌", "Zierkennzeichen", "バニティプレート", "Декор. номер", "Placa Decorativa", "Plaque décorative") BREAK
        CASE 18 RETURN TR("Interior 1", "Interior 1", "内饰 1", "Innenraum 1", "内装 1", "Салон 1", "Interior 1", "Intérieur 1") BREAK
        CASE 19 RETURN TR("Interior 2", "Interior 2", "内饰 2", "Innenraum 2", "内装 2", "Салон 2", "Interior 2", "Intérieur 2") BREAK
        CASE 20 RETURN TR("Interior 3", "Interior 3", "内饰 3", "Innenraum 3", "内装 3", "Салон 3", "Interior 3", "Intérieur 3") BREAK
        CASE 21 RETURN TR("Interior 4", "Interior 4", "内饰 4", "Innenraum 4", "内装 4", "Салон 4", "Interior 4", "Intérieur 4") BREAK
        CASE 22 RETURN TR("Interior 5", "Interior 5", "内饰 5", "Innenraum 5", "内装 5", "Салон 5", "Interior 5", "Intérieur 5") BREAK
        CASE 23 RETURN TR("Seats", "Asientos", "座椅", "Sitze", "シート", "Сиденья", "Bancos", "Sièges") BREAK
        CASE 24 RETURN TR("Steering Wheel", "Volante", "方向盘", "Lenkrad", "ステアリング", "Руль", "Volante", "Volant") BREAK
        CASE 25 RETURN TR("Livery", "Cubierta", "涂装", "Design", "ペイントジョブ", "Раскраска", "Estampa", "Motif") BREAK
        CASE 26 RETURN TR("Left Wing", "Guardabarros izq.", "左翼子板", "Linker Kotflügel", "左フェンダー", "Левое крыло", "Para-lama Esq.", "Aile gauche") BREAK
        CASE 27 RETURN TR("Right Wing", "Guardabarros der.", "右翼子板", "Rechter Kotflügel", "右フェンダー", "Правое крыло", "Para-lama Dir.", "Aile droite") BREAK
        CASE 28 RETURN TR("Rear Wheels", "Ruedas traseras", "后轮", "Hinterräder", "リアホイール", "Задние колёса", "Rodas Traseiras", "Roues arrière") BREAK
        CASE 29 RETURN TR("Interior Knob", "Pomo de cambios", "排挡头", "Schaltknauf", "シフトノブ", "Ручка КПП", "Manopla de Câmbio", "Pommeau de levier") BREAK
        CASE 30 RETURN TR("Interior Plaque", "Placa interior", "车内铭牌", "Innenplakette", "プラーク", "Табличка в салоне", "Placa Interna", "Plaque intérieure") BREAK
        CASE 31 RETURN TR("Ice / Speakers", "Altavoces", "音响喇叭", "Lautsprecher", "スピーカー", "Аудиосистема", "Alto-falantes", "Haut-parleurs") BREAK
        CASE 32 RETURN TR("Trunk", "Maletero", "后备箱", "Kofferraum", "トランク", "Багажник", "Porta-malas", "Coffre") BREAK
        CASE 33 RETURN TR("Hydraulics", "Hidráulica", "液压系统", "Hydraulik", "ハイドロ", "Гидравлика", "Hidráulica", "Hydraulique") BREAK
        CASE 34 RETURN TR("Engine Bay 1", "Vano motor 1", "引擎舱 1", "Motorraum 1", "エンジンルーム 1", "Моторный отсек 1", "Cofre do Motor 1", "Compartiment moteur 1") BREAK
        CASE 35 RETURN TR("Engine Bay 2", "Vano motor 2", "引擎舱 2", "Motorraum 2", "エンジンルーム 2", "Моторный отсек 2", "Cofre do Motor 2", "Compartiment moteur 2") BREAK
        CASE 36 RETURN TR("Engine Bay 3", "Vano motor 3", "引擎舱 3", "Motorraum 3", "エンジンルーム 3", "Моторный отсек 3", "Cofre do Motor 3", "Compartiment moteur 3") BREAK
        CASE 37 RETURN TR("Chassis 2", "Chasis 2", "底盘 2", "Fahrgestell 2", "シャーシ 2", "Шасси 2", "Chassi 2", "Châssis 2") BREAK
        CASE 38 RETURN TR("Chassis 3", "Chasis 3", "底盘 3", "Fahrgestell 3", "シャーシ 3", "Шасси 3", "Chassi 3", "Châssis 3") BREAK
        CASE 39 RETURN TR("Chassis 4", "Chasis 4", "底盘 4", "Fahrgestell 4", "シャーシ 4", "Шасси 4", "Chassi 4", "Châssis 4") BREAK
        CASE 40 RETURN TR("Chassis 5", "Chasis 5", "底盘 5", "Fahrgestell 5", "シャーシ 5", "Шасси 5", "Chassi 5", "Châssis 5") BREAK
        CASE 41 RETURN TR("Left Door", "Puerta izquierda", "左车门", "Linke Tür", "左ドア", "Левая дверь", "Porta Esquerda", "Porte gauche") BREAK
        CASE 42 RETURN TR("Right Door", "Puerta derecha", "右车门", "Rechte Tür", "右ドア", "Правая дверь", "Porta Direita", "Porte droite") BREAK
    ENDSWITCH
    RETURN TR("Mod Slot", "Ranura de mod", "改装槽位", "Mod-Slot", "改造スロット", "Слот модификации", "Slot de Mod", "Emplacement mod")
ENDFUNC

PROC DRAW_LSC_SLOT_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Mod Slot:", "Ranura de mod:", "改装槽位:", "Mod-Slot:", "改造スロット:", "Слот модификации:", "Slot de Mod:", "Emplacement mod:")
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(vehicle)
        DRAW_OPTION(y, lbl, TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >"), selected, 0)
        EXIT
    ENDIF
    IF NOT LSC_HAS_ANY_CUSTOMIZABLE_SLOTS(vehicle)
        DRAW_OPTION(y, lbl, TR("< None >", "< Ninguno >", "< 无 >", "< Keine >", "< なし >", "< Нет >", "< Nenhum >", "< Aucun >"), selected, 0)
        EXIT
    ENDIF
    INT slot = LSC_SLOT()
    LSC_KIT_FOR_SLOT(vehicle, slot)
    STRING slotName = ""
    STRING gxtSlot = GET_MOD_SLOT_NAME(vehicle, INT_TO_ENUM(MOD_TYPE, slot))
    IF NOT IS_STRING_NULL_OR_EMPTY(gxtSlot) AND NOT ARE_STRINGS_EQUAL(gxtSlot, "NULL")
        slotName = LSC_RESOLVE_LABEL(gxtSlot)
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(slotName) OR ARE_STRINGS_EQUAL(slotName, "NULL")
        slotName = LSC_DEFAULT_SLOT_NAME(g_lsc_slot_choice)
    ENDIF
    TEXT_LABEL_63 slotDisplay = "< "
    slotDisplay += slotName
    slotDisplay += " >"
    DRAW_OPTION(y, lbl, slotDisplay, selected, 3)
ENDPROC

// Wheel family label, shared by the main LS Customs "Wheel Type" row and the
// Wheels & Tyres page's "Wheel Family" row.  It is declared up here, above the
// LS Customs page draw code, because this compiler requires every name to be
// declared before it is used and the LS Customs row comes first in this file.
// 0-12 is the full MOD_WHEEL_TYPE range.
FUNC STRING WHEEL_FAMILY_LABEL(INT family)
    SWITCH family
        CASE 0 RETURN TR("< Sport >", "< Deportivo >", "< 运动跑车 >", "< Sport >", "< スポーツ >", "< Спорт >", "< Esportivo >", "< Sport >") BREAK
        CASE 1 RETURN TR("< Muscle >", "< Muscle >", "< 肌肉车 >", "< Muscle >", "< マッスル >", "< Маслкар >", "< Muscle >", "< Muscle >") BREAK
        CASE 2 RETURN TR("< Lowrider >", "< Lowrider >", "< 低底盘车 >", "< Lowrider >", "< ローライダー >", "< Лоурайдер >", "< Lowrider >", "< Lowrider >") BREAK
        CASE 3 RETURN "< SUV >" BREAK
        CASE 4 RETURN TR("< Offroad >", "< Todoterreno >", "< 越野车 >", "< Offroad >", "< オフロード >", "< Внедорожник >", "< Off-road >", "< Tout-terrain >") BREAK
        CASE 5 RETURN TR("< Tuner >", "< Tuner >", "< 改装车 >", "< Tuner >", "< チューナー >", "< Тюнер >", "< Tuner >", "< Tuning >") BREAK
        CASE 6 RETURN TR("< Bike >", "< Moto >", "< 摩托车 >", "< Motorrad >", "< バイク >", "< Мотоцикл >", "< Moto >", "< Moto >") BREAK
        CASE 7 RETURN TR("< Hi-End >", "< Alta gama >", "< 高端豪华 >", "< Luxus >", "< ハイエンド >", "< Люкс >", "< Luxo >", "< Haut de gamme >") BREAK
        CASE 8 RETURN "< Supermod 1 >" BREAK
        CASE 9 RETURN "< Supermod 2 >" BREAK
        CASE 10 RETURN "< Supermod 3 >" BREAK
        CASE 11 RETURN "< Supermod 4 >" BREAK
        CASE 12 RETURN "< Supermod 5 >" BREAK
    ENDSWITCH
    RETURN TR("< Sport >", "< Deportivo >", "< 运动跑车 >", "< Sport >", "< スポーツ >", "< Спорт >", "< Esportivo >", "< Sport >")
ENDFUNC

PROC DRAW_LSC_SCROLL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < LSC_MENU_ROWS
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        SWITCH index
            CASE 0 DRAW_OPTION(y, TR("Max All Available Mods", "Mejorar todo al máximo", "全满改装", "Alle verfügbaren Mods max.", "全改造を最大化", "Макс. все модификации", "Maximizar Todas as Mods", "Toutes les mods au max"), "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_OPTION(y, TR("Return To Stock", "Volver a serie", "恢复原厂", "Auf Serie zurücksetzen", "純正に戻す", "Вернуть сток", "Voltar ao Original", "Remettre d'origine"), "APPLY", g_item = index, 2) BREAK
            CASE 2 DRAW_LSC_SLOT_SELECTOR(y, g_item = index) BREAK
            CASE 3 DRAW_LSC_MOD_SELECTOR(y, g_item = index) BREAK
            CASE 4 DRAW_LSC_VARIANT_COUNT(y, g_item = index) BREAK
            CASE 5 DRAW_LSC_COLOUR_SELECTOR(y, TR("Primary Paint", "Pintura principal", "主色调", "Primärfarbe", "メインカラー", "Основной цвет", "Pintura Primária", "Couleur principale"), g_lsc_primary_colour, g_item = index) BREAK
            CASE 6 DRAW_LSC_COLOUR_SELECTOR(y, TR("Secondary Paint", "Pintura secundaria", "副色调", "Sekundärfarbe", "サブカラー", "Дополнительный цвет", "Pintura Secundária", "Couleur secondaire"), g_lsc_secondary_colour, g_item = index) BREAK
            CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, TR("Pearlescent Paint", "Pintura nacarada", "珠光色", "Perleffekt", "パールセント", "Перламутр", "Pintura Perolada", "Nacré"), g_lsc_pearlescent_colour, g_item = index) BREAK
            CASE 8 DRAW_LSC_COLOUR_SELECTOR(y, TR("Wheel Colour", "Color de ruedas", "轮毂颜色", "Felgenfarbe", "ホイールカラー", "Цвет дисков", "Cor das Rodas", "Couleur des jantes"), g_lsc_wheel_colour, g_item = index) BREAK
            CASE 9 DRAW_OPTION(y, TR("Wheel Type", "Tipo de rueda", "车轮类型", "Radtyp", "ホイールタイプ", "Тип колёс", "Tipo de Roda", "Type de roues"), WHEEL_FAMILY_LABEL(g_lsc_wheel_type), g_item = index, 3) BREAK
            CASE 10 IF g_lsc_turbo DRAW_OPTION(y, TR("Turbo", "Turbo", "涡轮增压", "Turbo", "ターボ", "Турбонаддув", "Turbo", "Turbo"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Turbo", "Turbo", "涡轮增压", "Turbo", "ターボ", "Турбонаддув", "Turbo", "Turbo"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 11 IF g_lsc_xenon DRAW_OPTION(y, TR("Xenon Lights", "Luces de xenón", "氙气大灯", "Xenon-Scheinwerfer", "キセノンライト", "Ксеноновые фары", "Faróis de Xenon", "Phares au xénon"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Xenon Lights", "Luces de xenón", "氙气大灯", "Xenon-Scheinwerfer", "キセノンライト", "Ксеноновые фары", "Faróis de Xenon", "Phares au xénon"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 12 DRAW_LSC_LIGHT_SELECTOR(y, TR("Xenon Colour", "Color de xenón", "氙气灯颜色", "Xenon-Farbe", "キセノンカラー", "Цвет ксенона", "Cor do Xenon", "Couleur du xénon"), g_lsc_xenon_colour, g_item = index) BREAK
            CASE 13 IF g_lsc_neon DRAW_OPTION(y, TR("Neon Kit", "Kit de neón", "霓虹灯套件", "Neon-Kit", "ネオンキット", "Неоновая подсветка", "Kit de Neon", "Kit néon"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Neon Kit", "Kit de neón", "霓虹灯套件", "Neon-Kit", "ネオンキット", "Неоновая подсветка", "Kit de Neon", "Kit néon"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 14 DRAW_LSC_LIGHT_SELECTOR(y, TR("Neon Colour", "Color de neón", "霓虹灯颜色", "Neon-Farbe", "ネオンカラー", "Цвет неона", "Cor do Neon", "Couleur du néon"), g_lsc_neon_colour, g_item = index) BREAK
            CASE 15 DRAW_LSC_WINDOW_TINT_SELECTOR(y, g_item = index) BREAK
            CASE 16 DRAW_LSC_PLATE_STYLE_SELECTOR(y, g_item = index) BREAK
            CASE 17 DRAW_LSC_PLATE_ROW(y, g_item = index) BREAK
            CASE 18 DRAW_OPTION(y, TR("Apply Plate Text", "Aplicar texto de matrícula", "应用车牌文字", "Kennzeichentext anwenden", "ナンバー文字列を適用", "Применить текст номера", "Aplicar Texto da Placa", "Appliquer texte de plaque"), "APPLY", g_item = index, 2) BREAK
            CASE 19 DRAW_OPTION(y, TR("Clear Selected Slot", "Limpiar ranura seleccionada", "清除所选槽位", "Gewählten Slot leeren", "選択スロットを解除", "Очистить выбранный слот", "Limpar Slot Selecionado", "Vider l'emplacement"), "APPLY", g_item = index, 2) BREAK
            // ---- v0.9.9 depth (rows 20-26, shifted by 1 when License Plate Style was added at row 16).
            CASE 20 DRAW_OPTION(y, TR("Mod Kit", "Kit de mod", "改装套件", "Mod-Kit", "改造キット", "Мод-кит", "Kit de Mod", "Kit de mod"), LSC_KIT_INDEX_TEXT(), g_item = index, 3) BREAK
            CASE 21 DRAW_OPTION(y, TR("Mod Kit Type", "Tipo de kit de mod", "套件类型", "Mod-Kit-Typ", "キットタイプ", "Тип мод-кита", "Tipo de Kit", "Type de kit"), LSC_KIT_TYPE_TEXT(), g_item = index, 2) BREAK
            CASE 22 DRAW_OPTION(y, TR("Mod Kit Count", "Cantidad de kits", "套件数量", "Mod-Kit-Anzahl", "キット数", "Кол-во мод-китов", "Total de Kits", "Nombre de kits"), LSC_KIT_COUNT_TEXT(), g_item = index, 2) BREAK
            CASE 23 DRAW_OPTION(y, TR("Hydraulics & Bounce", "Hidráulica y rebote", "液压与弹跳", "Hydraulik & Hüpfen", "ハイドロ＆バウンス", "Гидравлика и прыжки", "Hidráulica e Salto", "Hydraulique et rebond"), "OPEN", g_item = index, 2) BREAK
            CASE 24 DRAW_OPTION(y, TR("Lowrider Interior", "Interior lowrider", "低底盘车内饰", "Lowrider-Innenraum", "ローライダー内装", "Салон лоурайдера", "Interior Lowrider", "Intérieur lowrider"), "OPEN", g_item = index, 2) BREAK
            CASE 25 DRAW_OPTION(y, TR("Wheels & Tyres", "Ruedas y neumáticos", "车轮与轮胎", "Räder & Reifen", "ホイール＆タイヤ", "Колёса и шины", "Rodas e Pneus", "Roues et pneus"), "OPEN", g_item = index, 2) BREAK
            CASE 26 DRAW_OPTION(y, TR("Extras & Livery", "Extras y cubierta", "配件与涂装", "Extras & Design", "エクストラ＆ペイント", "Экстры и раскраска", "Extras e Estampa", "Extras et motif"), "OPEN", g_item = index, 2) BREAK
            // ---- v0.9.9 lowrider capability rows (27-29) ----
            CASE 27 DRAW_OPTION(y, TR("Bennys & Lowriders", "Benny's y Lowriders", "班尼车坊与低底盘车", "Benny's & Lowrider", "ベニーズ＆ローライダー", "Benny's и лоурайдеры", "Benny's e Lowriders", "Benny's et Lowriders"), "OPEN", g_item = index, 2) BREAK
            CASE 28 DRAW_OPTION(y, TR("Convert To Custom", "Convertir a Custom", "升级为改装版", "Zu Custom umbauen", "カスタム仕様に変換", "Конвертировать в Custom", "Converter para Custom", "Convertir en Custom"), CONVERT_STATUS_TEXT(), g_item = index, 2) BREAK
            CASE 29 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, TR("Vehicle Support Check", "Comprobar compatibilidad", "载具支持检查", "Fahrzeug-Kompatibilität", "車両対応チェック", "Проверка совместимости", "Verificar Compatibilidade", "Vérif. compatibilité"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, TR("Vehicle Support Check", "Comprobar compatibilidad", "载具支持检查", "Fahrzeug-Kompatibilität", "車両対応チェック", "Проверка совместимости", "Verificar Compatibilidade", "Vérif. compatibilité"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
        ENDSWITCH
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_LSC_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "LS CUSTOMS")
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Vehicle Upgrades", "Mejoras del vehículo", "载具升级", "Fahrzeug-Upgrades", "車両アップグレード", "Улучшения транспорта", "Melhorias do Veículo", "Améliorations véhicule"), "NO VEHICLE", g_item = 0, 0)
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

FUNC BOOL DLC_CATEGORY_MATCH(INT category, INT index)
    INT total = GET_NUM_DLC_VEHICLES()
    MODEL_NAMES model
    IF index < 0 OR index >= total RETURN FALSE ENDIF
    model = GET_DLC_VEHICLE_MODEL(index)
    IF category = 3 RETURN IS_THIS_MODEL_A_CAR(model) ENDIF
    IF category = 4 RETURN IS_THIS_MODEL_A_BIKE(model) ENDIF
    IF category = 5 RETURN IS_THIS_MODEL_A_PLANE(model) OR IS_THIS_MODEL_A_HELI(model) ENDIF
    IF category = 6 RETURN IS_THIS_MODEL_A_BOAT(model) ENDIF
    RETURN FALSE
ENDFUNC

FUNC INT FIND_FIRST_DLC_FOR_CATEGORY(INT category)
    INT index = 0
    INT total = GET_NUM_DLC_VEHICLES()
    WHILE index < total
        IF DLC_CATEGORY_MATCH(category, index) RETURN index ENDIF
        index = index + 1
    ENDWHILE
    RETURN -1
ENDFUNC

FUNC INT GET_NUM_DLC_VEHICLES_FOR_CATEGORY(INT category)
    IF category = 3 AND g_dlc_cars_count >= 0 RETURN g_dlc_cars_count ENDIF
    IF category = 4 AND g_dlc_bikes_count >= 0 RETURN g_dlc_bikes_count ENDIF
    IF category = 5 AND g_dlc_aircraft_count >= 0 RETURN g_dlc_aircraft_count ENDIF
    IF category = 6 AND g_dlc_boats_count >= 0 RETURN g_dlc_boats_count ENDIF

    INT total = GET_NUM_DLC_VEHICLES()
    INT count = 0
    INT i = 0
    WHILE i < total
        IF DLC_CATEGORY_MATCH(category, i)
            count = count + 1
        ENDIF
        i = i + 1
    ENDWHILE

    IF category = 3 g_dlc_cars_count = count ENDIF
    IF category = 4 g_dlc_bikes_count = count ENDIF
    IF category = 5 g_dlc_aircraft_count = count ENDIF
    IF category = 6 g_dlc_boats_count = count ENDIF
    RETURN count
ENDFUNC

FUNC INT GET_DLC_VEHICLE_INDEX_FOR_SLOT(INT category, INT slot)
    INT total = GET_NUM_DLC_VEHICLES()
    INT count = 0
    INT i = 0
    WHILE i < total
        IF DLC_CATEGORY_MATCH(category, i)
            IF count = slot RETURN i ENDIF
            count = count + 1
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN -1
ENDFUNC

FUNC INT GET_SLOT_FOR_DLC_VEHICLE_INDEX(INT category, INT dlcIdx)
    INT total = GET_NUM_DLC_VEHICLES()
    INT count = 0
    INT i = 0
    WHILE i < total
        IF DLC_CATEGORY_MATCH(category, i)
            IF i = dlcIdx RETURN count ENDIF
            count = count + 1
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN 0
ENDFUNC

FUNC MODEL_NAMES GET_VEHICLE_CHOICE_MODEL(INT choice)
    IF choice >= 89 RETURN MISC_VEHICLE_MODEL(choice) ENDIF
    SWITCH choice
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

FUNC STRING GET_VEHICLE_CHOICE_NAME(INT choice)
    SWITCH choice
        CASE 0 RETURN "Adder" BREAK
        CASE 1 RETURN "Buffalo" BREAK
        CASE 2 RETURN "Cheetah" BREAK
        CASE 3 RETURN "Comet" BREAK
        CASE 4 RETURN "Entity XF" BREAK
        CASE 5 RETURN "Infernus" BREAK
        CASE 6 RETURN "Sultan" BREAK
        CASE 7 RETURN "Rapid GT" BREAK
        CASE 8 RETURN "Carbonizzare" BREAK
        CASE 9 RETURN "Feltzer" BREAK
        CASE 10 RETURN "9F" BREAK
        CASE 11 RETURN "Dominator" BREAK
        CASE 12 RETURN "Gauntlet" BREAK
        CASE 13 RETURN "Elegy" BREAK
        CASE 14 RETURN "Baller" BREAK
        CASE 15 RETURN "Granger" BREAK
        CASE 16 RETURN "Sandking" BREAK
        CASE 17 RETURN "Mesa" BREAK
        CASE 18 RETURN "Transport Bus" BREAK
        CASE 19 RETURN "Bati 801" BREAK
        CASE 20 RETURN "PCJ-600" BREAK
        CASE 21 RETURN "Akuma" BREAK
        CASE 22 RETURN "Sanchez" BREAK
        CASE 23 RETURN "Faggio" BREAK
        CASE 24 RETURN "Buzzard" BREAK
        CASE 25 RETURN "Duster" BREAK
        CASE 26 RETURN "Cargobob" BREAK
        CASE 27 RETURN "P-996 Lazer" BREAK
        CASE 28 RETURN "Blazer Custom" BREAK
        CASE 29 RETURN "Chimera" BREAK
        CASE 30 RETURN "Daemon Custom" BREAK
        CASE 31 RETURN "Defiler" BREAK
        CASE 32 RETURN "Esskey" BREAK
        CASE 33 RETURN "Faggio 3" BREAK
        CASE 34 RETURN "Hakuchou Drag" BREAK
        CASE 35 RETURN "Manchez" BREAK
        CASE 36 RETURN "Nightblade" BREAK
        CASE 37 RETURN "Raptor" BREAK
        CASE 38 RETURN "Rat Bike" BREAK
        CASE 39 RETURN "Sanctus" BREAK
        CASE 40 RETURN "Shotaro" BREAK
        CASE 41 RETURN "Tornado Custom" BREAK
        CASE 42 RETURN "Vortex" BREAK
        CASE 43 RETURN "Wolfsbane" BREAK
        CASE 44 RETURN "Youga Classic" BREAK
        CASE 45 RETURN "Zombie A" BREAK
        CASE 46 RETURN "Zombie B" BREAK
        CASE 47 RETURN "Jester Racecar" BREAK
        CASE 48 RETURN "Massacro Racecar" BREAK
        CASE 49 RETURN "Rat Loader Custom" BREAK
        CASE 50 RETURN "Slamvan Custom" BREAK
        CASE 51 RETURN "Barracks Custom" BREAK
        CASE 52 RETURN "Boxville Armoured" BREAK
        CASE 53 RETURN "Casco" BREAK
        CASE 54 RETURN "Dinghy" BREAK
        CASE 55 RETURN "Enduro" BREAK
        CASE 56 RETURN "GBurrito" BREAK
        CASE 57 RETURN "Guardian" BREAK
        CASE 58 RETURN "Hydra" BREAK
        CASE 59 RETURN "Insurgent" BREAK
        CASE 60 RETURN "Insurgent Pick-Up" BREAK
        CASE 61 RETURN "Kuruma" BREAK
        CASE 62 RETURN "Kuruma Armoured" BREAK
        CASE 63 RETURN "Lectro" BREAK
        CASE 64 RETURN "Mule Custom" BREAK
        CASE 65 RETURN "Savage" BREAK
        CASE 66 RETURN "Slamvan" BREAK
        CASE 67 RETURN "Tanker" BREAK
        CASE 68 RETURN "Technical" BREAK
        CASE 69 RETURN "Trashmaster" BREAK
        CASE 70 RETURN "Valkyrie" BREAK
        CASE 71 RETURN "Velum" BREAK
        CASE 72 RETURN "Dinghy" BREAK
        CASE 73 RETURN "Dinghy 2" BREAK
        CASE 74 RETURN "Dinghy 3" BREAK
        CASE 75 RETURN "Jetmax" BREAK
        CASE 76 RETURN "Marquis" BREAK
        CASE 77 RETURN "Seashark / Jetski" BREAK
        CASE 78 RETURN "Seashark Lifeguard" BREAK
        CASE 79 RETURN "Seashark Custom" BREAK
        CASE 80 RETURN "Speeder" BREAK
        CASE 81 RETURN "Speeder 2" BREAK
        CASE 82 RETURN "Squalo" BREAK
        CASE 83 RETURN "Submersible" BREAK
        CASE 84 RETURN "Suntrap" BREAK
        CASE 85 RETURN "Toro" BREAK
        CASE 86 RETURN "Toro 2" BREAK
        CASE 87 RETURN "Tropic" BREAK
        CASE 88 RETURN "Tug" BREAK
        CASE 89 RETURN "Avarus" BREAK
        CASE 90 RETURN "Banshee" BREAK
        CASE 91 RETURN "Bullet" BREAK
        CASE 92 RETURN "Coquette" BREAK
        CASE 93 RETURN "Phoenix" BREAK
        CASE 94 RETURN "Surano" BREAK
        CASE 95 RETURN "Vacca" BREAK
        CASE 96 RETURN "Stinger" BREAK
        CASE 97 RETURN "Exemplar" BREAK
        CASE 98 RETURN "Jackal" BREAK
        CASE 99 RETURN "Oracle" BREAK
        CASE 100 RETURN "Felon" BREAK
        CASE 101 RETURN "Schafter 2" BREAK
        CASE 102 RETURN "Tailgater" BREAK
        CASE 103 RETURN "Washington" BREAK
        CASE 104 RETURN "Cognoscenti" BREAK
        CASE 105 RETURN "Baller 2" BREAK
        CASE 106 RETURN "Cavalcade" BREAK
        CASE 107 RETURN "Dubsta" BREAK
        CASE 108 RETURN "Fq 2" BREAK
        CASE 109 RETURN "Granger" BREAK
        CASE 110 RETURN "Gresley" BREAK
        CASE 111 RETURN "Habanero" BREAK
        CASE 112 RETURN "Landstalker" BREAK
        CASE 113 RETURN "Patriot" BREAK
        CASE 114 RETURN "Radius" BREAK
        CASE 115 RETURN "Rocoto" BREAK
        CASE 116 RETURN "Seminole" BREAK
        CASE 117 RETURN "Serrano" BREAK
        CASE 118 RETURN "Bison" BREAK
        CASE 119 RETURN "Bobcat Xl" BREAK
        CASE 120 RETURN "Bodhi" BREAK
        CASE 121 RETURN "Duneloader" BREAK
        CASE 122 RETURN "Rebel" BREAK
        CASE 123 RETURN "Sadler" BREAK
        CASE 124 RETURN "Sandking 2" BREAK
        CASE 125 RETURN "Benson" BREAK
        CASE 126 RETURN "Biff" BREAK
        CASE 127 RETURN "Hauler" BREAK
        CASE 128 RETURN "Mule" BREAK
        CASE 129 RETURN "Packer" BREAK
        CASE 130 RETURN "Phantom" BREAK
        CASE 131 RETURN "Pounder" BREAK
        CASE 132 RETURN "Stockade" BREAK
        CASE 133 RETURN "Airbus" BREAK
        CASE 134 RETURN "Bus" BREAK
        CASE 135 RETURN "Coach" BREAK
        CASE 136 RETURN "Rallytruck" BREAK
        CASE 137 RETURN "Rentalbus" BREAK
        CASE 138 RETURN "Taxi" BREAK
        CASE 139 RETURN "Tourbus" BREAK
        CASE 140 RETURN "Trash" BREAK
        CASE 141 RETURN "Ambulance" BREAK
        CASE 142 RETURN "Fbi" BREAK
        CASE 143 RETURN "Fbi 2" BREAK
        CASE 144 RETURN "Firetruk" BREAK
        CASE 145 RETURN "Pbus" BREAK
        CASE 146 RETURN "Police" BREAK
        CASE 147 RETURN "Police 2" BREAK
        CASE 148 RETURN "Police 3" BREAK
        CASE 149 RETURN "Police 4" BREAK
        CASE 150 RETURN "Police Old 1" BREAK
        CASE 151 RETURN "Police Old 2" BREAK
        CASE 152 RETURN "Policet" BREAK
        CASE 153 RETURN "Pranger" BREAK
        CASE 154 RETURN "Predator" BREAK
        CASE 155 RETURN "Riot" BREAK
        CASE 156 RETURN "Sheriff" BREAK
        CASE 157 RETURN "Sheriff 2" BREAK
        CASE 158 RETURN "Barracks" BREAK
        CASE 159 RETURN "Barracks 2" BREAK
        CASE 160 RETURN "Crusader" BREAK
        CASE 161 RETURN "Rhino" BREAK
        CASE 162 RETURN "Blazer" BREAK
        CASE 163 RETURN "Blazer 2" BREAK
        CASE 164 RETURN "Blazer 3" BREAK
        CASE 165 RETURN "Bmx" BREAK
        CASE 166 RETURN "Cruiser" BREAK
        CASE 167 RETURN "Fixter" BREAK
        CASE 168 RETURN "Scorcher" BREAK
        CASE 169 RETURN "Tribike" BREAK
        CASE 170 RETURN "Tribike 2" BREAK
        CASE 171 RETURN "Tribike 3" BREAK
        CASE 172 RETURN "Zhaba" BREAK
        CASE 173 RETURN "Kosatka" BREAK
        CASE 174 RETURN "Toreador" BREAK
        CASE 175 RETURN "Rc Bandito" BREAK
        CASE 176 RETURN "Astron" BREAK
        CASE 177 RETURN "Champion" BREAK
        CASE 178 RETURN "Sultan RS Classic" BREAK
        CASE 179 RETURN "Vagrant" BREAK
        CASE 180 RETURN "Clique" BREAK
        CASE 181 RETURN "Deviant" BREAK
        CASE 182 RETURN "Schlagen GT" BREAK
        CASE 183 RETURN "Itali GTO" BREAK
        CASE 184 RETURN "Toros" BREAK
        CASE 185 RETURN "Vamos" BREAK
        CASE 186 RETURN "JB 700W" BREAK
        CASE 187 RETURN "Trailer Large" BREAK
        CASE 188 RETURN "Trailer 4" BREAK
        CASE 189 RETURN "Trailer Small 2" BREAK
    ENDSWITCH
    RETURN "Vehicle"
ENDFUNC

FUNC INT VEHICLE_LIST_TOTAL_ROWS()
    INT count = 0
    SWITCH g_vehicle_spawn_category
        CASE 0 count = 19 BREAK
        CASE 1 count = 5 BREAK
        CASE 2 count = 4 BREAK
        CASE 3 count = GET_NUM_DLC_VEHICLES_FOR_CATEGORY(3) BREAK
        CASE 4 count = GET_NUM_DLC_VEHICLES_FOR_CATEGORY(4) BREAK
        CASE 5 count = GET_NUM_DLC_VEHICLES_FOR_CATEGORY(5) BREAK
        CASE 6 count = GET_NUM_DLC_VEHICLES_FOR_CATEGORY(6) BREAK
        CASE 7 count = 17 BREAK
        CASE 8 count = 101 BREAK
    ENDSWITCH
    IF count <= 0 RETURN 1 ENDIF
    RETURN count
ENDFUNC

FUNC INT GET_VEHICLE_CHOICE_FOR_CATEGORY_SLOT(INT category, INT slot)
    SWITCH category
        CASE 0 RETURN slot BREAK
        CASE 1 RETURN 19 + slot BREAK
        CASE 2 RETURN 24 + slot BREAK
        CASE 7 RETURN 72 + slot BREAK
        CASE 8 RETURN 89 + slot BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

FUNC MODEL_NAMES GET_VEHICLE_MODEL_FOR_CATEGORY_SLOT(INT category, INT slot)
    IF category >= 3 AND category <= 6
        INT dlcIdx = GET_DLC_VEHICLE_INDEX_FOR_SLOT(category, slot)
        IF dlcIdx >= 0
            RETURN GET_DLC_VEHICLE_MODEL(dlcIdx)
        ENDIF
        RETURN ADDER
    ENDIF
    INT choice = GET_VEHICLE_CHOICE_FOR_CATEGORY_SLOT(category, slot)
    RETURN GET_VEHICLE_CHOICE_MODEL(choice)
ENDFUNC

FUNC STRING GET_VEHICLE_NAME_FOR_CATEGORY_SLOT(INT category, INT slot)
    IF category >= 3 AND category <= 6
        INT dlcIdx = GET_DLC_VEHICLE_INDEX_FOR_SLOT(category, slot)
        IF dlcIdx >= 0
            MODEL_NAMES dlcModel = GET_DLC_VEHICLE_MODEL(dlcIdx)
            STRING dlcName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(dlcModel)
            IF NOT IS_STRING_NULL_OR_EMPTY(dlcName)
                STRING localizedName = GET_FILENAME_FOR_AUDIO_CONVERSATION(dlcName)
                IF NOT IS_STRING_NULL_OR_EMPTY(localizedName)
                    RETURN localizedName
                ENDIF
                RETURN dlcName
            ENDIF
        ENDIF
        RETURN "DLC Vehicle"
    ENDIF
    INT choice = GET_VEHICLE_CHOICE_FOR_CATEGORY_SLOT(category, slot)
    RETURN GET_VEHICLE_CHOICE_NAME(choice)
ENDFUNC

FUNC BOOL IS_VEHICLE_SLOT_CURRENTLY_SELECTED(INT category, INT slot)
    IF g_saved_veh_selected_index >= 0 RETURN FALSE ENDIF
    IF category >= 3 AND category <= 6
        INT dlcIdx = GET_DLC_VEHICLE_INDEX_FOR_SLOT(category, slot)
        IF dlcIdx >= 0 AND dlcIdx = g_dlc_vehicle_index RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    INT choice = GET_VEHICLE_CHOICE_FOR_CATEGORY_SLOT(category, slot)
    IF choice = g_vehicle_spawn_choice RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

FUNC INT GET_SLOT_FOR_CURRENT_SELECTION(INT category)
    IF category >= 3 AND category <= 6
        IF g_dlc_vehicle_index >= 0
            RETURN GET_SLOT_FOR_DLC_VEHICLE_INDEX(category, g_dlc_vehicle_index)
        ENDIF
        RETURN 0
    ENDIF
    SWITCH category
        CASE 0
            IF g_vehicle_spawn_choice >= 0 AND g_vehicle_spawn_choice <= 18
                RETURN g_vehicle_spawn_choice
            ENDIF
            RETURN 0
        CASE 1
            IF g_vehicle_spawn_choice >= 19 AND g_vehicle_spawn_choice <= 23
                RETURN g_vehicle_spawn_choice - 19
            ENDIF
            RETURN 0
        CASE 2
            IF g_vehicle_spawn_choice >= 24 AND g_vehicle_spawn_choice <= 27
                RETURN g_vehicle_spawn_choice - 24
            ENDIF
            RETURN 0
        CASE 7
            IF g_vehicle_spawn_choice >= 72 AND g_vehicle_spawn_choice <= 88
                RETURN g_vehicle_spawn_choice - 72
            ENDIF
            RETURN 0
        CASE 8
            IF g_vehicle_spawn_choice >= 89 AND g_vehicle_spawn_choice <= 189
                RETURN g_vehicle_spawn_choice - 89
            ENDIF
            RETURN 0
    ENDSWITCH
    RETURN 0
ENDFUNC

PROC APPLY_VEHICLE_LIST_SELECTION(INT slot)
    g_saved_veh_selected_index = -1
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        INT dlcIdx = GET_DLC_VEHICLE_INDEX_FOR_SLOT(g_vehicle_spawn_category, slot)
        IF dlcIdx >= 0
            g_dlc_vehicle_index = dlcIdx
        ENDIF
    ELSE
        g_vehicle_spawn_choice = GET_VEHICLE_CHOICE_FOR_CATEGORY_SLOT(g_vehicle_spawn_category, slot)
    ENDIF
ENDPROC

FUNC MODEL_NAMES CURRENT_SPAWNER_MODEL()
    IF g_vehicle_list_open
        RETURN GET_VEHICLE_MODEL_FOR_CATEGORY_SLOT(g_vehicle_spawn_category, g_item)
    ENDIF
    IF g_saved_veh_selected_index >= 0 AND g_saved_veh_selected_index < g_saved_vehicles_count
        RETURN INT_TO_ENUM(MODEL_NAMES, g_saved_veh_model_hashes[g_saved_veh_selected_index])
    ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() > 0 AND g_dlc_vehicle_index >= 0
            RETURN GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
        ENDIF
        RETURN ADDER
    ENDIF
    RETURN GET_VEHICLE_CHOICE_MODEL(g_vehicle_spawn_choice)
ENDFUNC

PROC CLEANUP_VEHICLE_PREVIEW()
    IF g_vehicle_preview_vehicle = NULL AND g_vehicle_preview_model = DUMMY_MODEL_FOR_SCRIPT AND g_vehicle_preview_request_time = 0
        EXIT
    ENDIF
    IF DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_vehicle_preview_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_vehicle_preview_vehicle)
    ENDIF
    g_vehicle_preview_vehicle = NULL
    IF g_vehicle_preview_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_vehicle_preview_model)
        g_vehicle_preview_model = DUMMY_MODEL_FOR_SCRIPT
    ENDIF
    g_vehicle_preview_request_time = 0
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
    IF NOT g_vehicle_preview_enabled OR NOT g_open OR g_home OR NOT g_spawner_open OR NOT g_vehicle_list_open
        CLEANUP_VEHICLE_PREVIEW()
        EXIT
    ENDIF
    IF g_vehicle_spawn_pending OR g_convert_pending EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        CLEANUP_VEHICLE_PREVIEW()
        EXIT
    ENDIF
    SYNC_VEHICLE_PREVIEW_MODEL()
    IF NOT IS_MODEL_IN_CDIMAGE(g_vehicle_preview_model) OR NOT IS_MODEL_VALID(g_vehicle_preview_model) EXIT ENDIF
    IF NOT DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
        IF NOT HAS_MODEL_LOADED(g_vehicle_preview_model)
            IF g_vehicle_preview_request_time = 0
                REQUEST_MODEL(g_vehicle_preview_model)
                g_vehicle_preview_request_time = GET_GAME_TIMER()
            ELIF GET_GAME_TIMER() > g_vehicle_preview_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_vehicle_preview_model)
                g_vehicle_preview_request_time = 0
            ENDIF
            EXIT
        ENDIF
        previewPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.5>>)
        previewHeading = GET_ENTITY_HEADING(PLAYER_PED_ID()) + 90.0
        g_vehicle_preview_vehicle = CREATE_VEHICLE(g_vehicle_preview_model, previewPosition, previewHeading, FALSE)
        IF DOES_ENTITY_EXIST(g_vehicle_preview_vehicle)
            SET_ENTITY_AS_MISSION_ENTITY(g_vehicle_preview_vehicle, TRUE, TRUE)
            FREEZE_ENTITY_POSITION(g_vehicle_preview_vehicle, TRUE)
            SET_ENTITY_COLLISION(g_vehicle_preview_vehicle, FALSE, FALSE)
            SET_ENTITY_CAN_BE_DAMAGED(g_vehicle_preview_vehicle, FALSE)
            SET_ENTITY_PROOFS(g_vehicle_preview_vehicle, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
            SET_ENTITY_ALPHA(g_vehicle_preview_vehicle, 200, FALSE)
            SET_VEHICLE_DOORS_LOCKED(g_vehicle_preview_vehicle, VEHICLELOCK_LOCKED)
        ENDIF
        SET_MODEL_AS_NO_LONGER_NEEDED(g_vehicle_preview_model)
        g_vehicle_preview_request_time = 0
        EXIT
    ENDIF
    previewPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.5>>)
    previewHeading = GET_ENTITY_HEADING(PLAYER_PED_ID()) + 90.0
    SET_ENTITY_COORDS(g_vehicle_preview_vehicle, previewPosition, TRUE, TRUE, TRUE, TRUE)
    SET_ENTITY_HEADING(g_vehicle_preview_vehicle, previewHeading)
ENDPROC

PROC START_VEHICLE_MODEL_SPAWN(MODEL_NAMES model)
    IF g_vehicle_spawn_pending OR g_convert_pending EXIT ENDIF
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
    ELIF target = 16
        g_story_ped_search_not_found = FALSE
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
    ELIF target = 17
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "TP DISTANCE", "DISTANCE IN METERS (10-500)", "", "", "", "", 16)
    ELIF target = 18
        DISPLAY_ONSCREEN_KEYBOARD(ONSCREEN_KEYBOARD_BASIC_ENGLISH, "VEHICLE NAME", "NAME THIS VEHICLE (MAX 24)", "", "", "", "", 24)
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
            g_ped_search_error = 0
            foundChoice = FIND_PED_CHOICE_BY_NAME(result)
            IF foundChoice >= 0
                g_ped_search_not_found = FALSE
                g_ped_search_has_value = TRUE
                g_ped_search_is_custom = FALSE
                g_ped_search_value = result
                g_ped_choice = foundChoice
                g_item = foundChoice + 4
                SAVE_ACTIVE_CHARACTER_PED()
                REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(foundChoice))
                IF NOT g_ped_change_pending AND g_ped_search_error = 0
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
                    IF NOT g_ped_change_pending AND g_ped_search_error = 0
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
                // Same addon-name path the player changer uses (target 3): a
                // typed model that is absent from the catalog still resolves by
                // hash, so a bodyguard can be any ped in the game rather than
                // only the 683 browsable ones.
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
                // Same addon-name path the player changer (target 3) and the
                // guard search (target 10) use: a typed model that is absent
                // from the catalog still resolves by hash, so any ped in the
                // game can drive.
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
        ELIF g_keyboard_target = 16
            foundChoice = FIND_PED_CHOICE_BY_NAME(result)
            IF foundChoice >= 0
                SET_STORY_CHAR_CATALOG_CHOICE(g_story_ped_active_char, foundChoice)
                g_story_ped_search_not_found = FALSE
                g_item = foundChoice + 2
            ELSE
                MODEL_NAMES customStoryModel = INT_TO_ENUM(MODEL_NAMES, GET_HASH_KEY(result))
                IF IS_MODEL_IN_CDIMAGE(customStoryModel) AND IS_MODEL_VALID(customStoryModel)
                    SET_STORY_CHAR_CUSTOM_MODEL(g_story_ped_active_char, customStoryModel, result)
                    g_story_ped_search_not_found = FALSE
                ELSE
                    g_story_ped_search_not_found = TRUE
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
            IF IS_MODEL_IN_CDIMAGE(spoonerModel) AND IS_MODEL_VALID(spoonerModel)
                g_spooner_custom_preview_model = spoonerModel
                g_spooner_use_custom_preview = TRUE
                SYNC_SPOONER_PREVIEW_MODEL()
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
            // Auto Save Interval, in minutes. Same clamp as the Left/Right steps.
            IF STRING_TO_INT(result, parsed)
                IF parsed < 0 parsed = 0 ENDIF
                IF parsed > 120 parsed = 120 ENDIF
                g_auto_save_interval = parsed
                IF g_auto_save g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000) ENDIF
            ENDIF
        ELIF g_keyboard_target = 17
            // Bodyguard TP Distance threshold (meters).
            IF STRING_TO_INT(result, parsed)
                IF parsed < 10 parsed = 10 ENDIF
                IF parsed > 500 parsed = 500 ENDIF
                g_bodyguard_tp_distance = parsed
            ENDIF
        ELIF g_keyboard_target = 18
            COMMIT_STAGED_VEHICLE_WITH_NAME(result)
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

// Misc "Clear Vehicles" deletes every vehicle in the radius, and
// CLEAR_AREA_OF_VEHICLES has no flag to spare script vehicles (only
// KeepScriptTrains exists), so the spawner's tracked cars can lose their entities
// behind the menu's back.  Keeps the entries that still resolve - a car spawned
// outside the radius is still tracked and still deletable - and drops only the
// dead ones, so DELETE_ALL_CUSTOM_CARS and DELETE_PREVIOUS_CUSTOM_CAR cannot
// later act on an index the engine has recycled into a different vehicle.
PROC PRUNE_SPAWNED_VEHICLE_TRACKING()
    INT readIndex = 0
    INT writeIndex = 0
    REPEAT g_spawned_custom_vehicle_count readIndex
        IF DOES_ENTITY_EXIST(g_spawned_custom_vehicles[readIndex])
            IF NOT IS_ENTITY_DEAD(g_spawned_custom_vehicles[readIndex])
                g_spawned_custom_vehicles[writeIndex] = g_spawned_custom_vehicles[readIndex]
                writeIndex = writeIndex + 1
            ELSE
                SET_VEHICLE_AS_NO_LONGER_NEEDED(g_spawned_custom_vehicles[readIndex])
            ENDIF
        ENDIF
    ENDREPEAT
    g_spawned_custom_vehicle_count = writeIndex
    WHILE writeIndex < MAX_TRACKED_CUSTOM_VEHICLES
        g_spawned_custom_vehicles[writeIndex] = NULL
        writeIndex = writeIndex + 1
    ENDWHILE
    IF NOT DOES_ENTITY_EXIST(g_last_spawned_vehicle)
        g_last_spawned_vehicle = NULL
    ELIF IS_ENTITY_DEAD(g_last_spawned_vehicle)
        SET_VEHICLE_AS_NO_LONGER_NEEDED(g_last_spawned_vehicle)
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
        // Remove the handle before deletion. Entity handles can be reused;
        // keeping it in the tracked array could later delete an unrelated car.
        FORGET_CUSTOM_CAR(g_last_spawned_vehicle)
        SET_ENTITY_AS_MISSION_ENTITY(g_last_spawned_vehicle, TRUE, TRUE)
        DELETE_VEHICLE(g_last_spawned_vehicle)
    ENDIF
    g_last_spawned_vehicle = NULL
ENDPROC

// ===========================================================================
// Convert To Custom (v0.9.9)
//
// The Benny's conversion, done from the menu instead of at a shop: replace the car
// the player is sitting in with its verified custom variant, carrying the paint
// and wheels across.
//
// Pairings come only from BENNYS_PAIR_FOR_MODEL (Rockstar's own tables).  A car
// with no verified conversion is refused before anything is created - nothing is
// inferred from a model name.
//
// Safety shape, because this is the one feature here that destroys an entity:
//
//   1. Refuse first: no variant, or a target this port does not ship
//      (IS_MODEL_IN_CDIMAGE / IS_MODEL_VALID), and no entity is ever created.
//   2. The request is asynchronous and timeout-bounded
//      (CONVERT_REQUEST_TIMEOUT_MS), the same staged shape the spawner uses.
//      There is no tight model-wait loop.
//   3. The replaced car is deleted only AFTER the player is confirmed to be in
//      the new one.  If creation fails, or the player got out while the model
//      streamed, the source car is left exactly as it was and the row says so.
//   4. The source handle is removed from the spawned-vehicle tracking before
//      deletion, exactly like DELETE_PREVIOUS_CUSTOM_CAR, so a recycled handle
//      can never delete an unrelated car later.
//
// It cannot run while the spawner is mid-request and the spawner cannot start
// while it is: both use g_pending_vehicle_model, and each checks the other's
// pending flag before taking it.
// ===========================================================================

// Carries paint and wheel family from one car to another, using the same
// reads/writes the paint rows use, so a converted car keeps the player's choices.
// The parameters are not named from/to: both are reserved words in this compiler
// ("parse error, expecting `&'" on the declaration line).
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

// One exit for every failure path, so none of them can leave the pending flag
// latched with a model still held.
PROC CANCEL_VEHICLE_CONVERSION(INT result)
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
    g_convert_pending = FALSE
    g_convert_pair = -1
    g_convert_source_vehicle = NULL
    SET_CONVERT_FEEDBACK(result)
ENDPROC

// Step 1: resolve the pairing and start the model request.  Every rejection
// happens here, before any entity exists.
PROC START_VEHICLE_CONVERSION()
    IF g_convert_pending EXIT ENDIF
    IF g_vehicle_spawn_pending EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX source = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT DOES_ENTITY_EXIST(source) EXIT ENDIF
    INT pair = BENNYS_PAIR_FOR_MODEL(GET_ENTITY_MODEL(source))
    IF pair < 0
        // Either this car has no Benny's variant at all, or it is already one.
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

// Step 2: the target model has streamed.  Build it, move the player across, and
// only then dispose of the car that was replaced.
PROC FINISH_VEHICLE_CONVERSION()
    IF NOT g_convert_pending EXIT ENDIF
    IF g_convert_pair < 0
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF
    VEHICLE_INDEX source = g_convert_source_vehicle
    // The player may have stepped out (or the car may be gone) while the model
    // streamed.  Abandon rather than converting a car nobody is sitting in - the
    // source is untouched.
    IF NOT DOES_ENTITY_EXIST(source) OR GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()) != source
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF

    // Offset by 2.5m, exactly like the spawner's single-vehicle case: creating
    // the replacement on top of the original would leave two solid bodies
    // intersecting for a frame, and that interpenetration is what launches cars
    // into the air.
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(source, <<0.0, 2.50, 1.0>>)
    FLOAT spawnHeading = GET_ENTITY_HEADING(source)
    VEHICLE_INDEX converted = CREATE_VEHICLE(BENNYS_CUSTOM_MODEL(g_convert_pair), spawnPosition, spawnHeading, FALSE)
    IF NOT DOES_ENTITY_EXIST(converted)
        // Failed to create: the player's car is still there, untouched.
        CANCEL_VEHICLE_CONVERSION(4)
        EXIT
    ENDIF

    COPY_LSC_APPEARANCE(source, converted)
    SET_VEHICLE_ON_GROUND_PROPERLY(converted)
    // Track it the way the spawner does so "Delete All Custom Cars" still cleans
    // it up, and so a later spawn's auto-delete can find it.
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

    // Verified: the player is in the replacement, so the old car is disposable.
    // Untrack it first - entity handles get recycled, and a stale entry here
    // could later delete an unrelated car.
    FORGET_CUSTOM_CAR(source)
    IF DOES_ENTITY_EXIST(source)
        SET_ENTITY_AS_MISSION_ENTITY(source, TRUE, TRUE)
        DELETE_VEHICLE(source)
    ENDIF

    // The car under the LSC pages just changed, so re-read it: this refreshes the
    // kit, the hydraulic support predicate and every row on the page, which is
    // what makes the hydraulics rows usable immediately after converting.
    SYNC_LSC_VEHICLE_STATE()
    SET_CONVERT_FEEDBACK(1)
ENDPROC
// ===========================================================================
// LS Customs depth - Hydraulics page (v0.9.9)
//
// Natives used, all verified present in this Switch header set
// (X:\gta5\script\dev_ng\core\common\native\commands_vehicle.sch):
//   SET_CAN_USE_HYDRAULICS(veh, BOOL)                                    4697
//   SET_HYDRAULIC_VEHICLE_STATE(veh, WHEEL_HYDRAULIC_SCRIPT_STATE)       4713
//   SET_HYDRAULIC_WHEEL_STATE(veh, SC_WHEEL_LIST, state, FLOAT, FLOAT)   4718
//   SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(veh, SC_WHEEL_LIST, FLOAT)     4687
//   SET_HYDRAULICS_CONTROL(veh, BOOL)                                    4637
//   SET_REDUCED_SUSPENSION_FORCE(veh, BOOL)                              5479
//   TOGGLE_VEHICLE_MOD(veh, MOD_TOGGLE_HYDRAULICS, BOOL)                 3777
//
// The game's own scripts use exactly this shape for the front-up / rear-up
// hydraulics cheats (net_process_events.sch sets per-wheel raise factors), so
// the presets below are shipping behaviour, not an invention.
//
// Safety rules kept throughout: every ON toggle has an OFF path that restores
// stock, raise factors are bounded to 0.0-1.0 (above 1.0 is undocumented in the
// SDK and untested on this port, so it is never sent), and the only repeating
// work - Hold Stance - is cadence-limited to HYDRO_HOLD_TICK_MS.
// ===========================================================================

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

// frontFactor goes to both front wheels; rearFactor to the mid and rear pairs.
// A four-wheel car has no mid wheels, so the two extra calls are harmless.
PROC HYDRO_SET_AXLE(FLOAT frontFactor, FLOAT rearFactor)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, frontFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, frontFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, rearFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, rearFactor)
ENDPROC

// Left/right pair across every left or right wheel, for the lean presets.
PROC HYDRO_SET_SIDE(FLOAT leftFactor, FLOAT rightFactor)
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_FRONT_RIGHT, rightFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_MID_RIGHT, rightFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_LEFT, leftFactor)
    SET_HYDRAULIC_SUSPENSION_RAISE_FACTOR(vehicle, SC_WHEEL_CAR_REAR_RIGHT, rightFactor)
ENDPROC

// The four page sliders.  Each row owns its own wheels with no overlap: Front =
// both front wheels, Rear = both rear wheels, Mid Left / Mid Right = the middle
// pair (which only exists on a six-wheel car, hence the "Mid" label).
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
    // Remember what the hold tick has to re-assert, so moving the preset row on
    // without pressing A cannot silently change an active hold.
    g_hydro_hold_preset = g_hydro_preset
ENDPROC

FUNC STRING HYDRO_PRESET_LABEL(INT preset)
    SWITCH preset
        CASE 0 RETURN TR("< Stock Height >", "< Altura de serie >", "< 原厂高度 >", "< Serienhöhe >", "< 純正車高 >", "< Стоковая высота >", "< Altura Original >", "< Hauteur d'origine >") BREAK
        CASE 1 RETURN TR("< Slammed >", "< Al suelo >", "< 贴地低趴 >", "< Tiefergelegt >", "< ベタ下げ >", "< Заниженная >", "< Rebaixado >", "< Surbaissé >") BREAK
        CASE 2 RETURN TR("< Max High >", "< Altura máx. >", "< 最高抬升 >", "< Max. Hoch >", "< 最高車高 >", "< Макс. подъём >", "< Altura Máx. >", "< Hauteur max >") BREAK
        CASE 3 RETURN TR("< Bouncy >", "< Rebote >", "< 弹跳模式 >", "< Hüpfend >", "< バウンス >", "< Прыгучая >", "< Saltitante >", "< Rebondissant >") BREAK
        CASE 4 RETURN TR("< Free >", "< Libre >", "< 自由悬挂 >", "< Frei >", "< フリー >", "< Свободная >", "< Livre >", "< Libre >") BREAK
        CASE 5 RETURN TR("< Front Up >", "< Frente arriba >", "< 车头抬起 >", "< Vorne hoch >", "< フロント上げ >", "< Перед поднят >", "< Frente Erguida >", "< Avant levé >") BREAK
        CASE 6 RETURN TR("< Rear Up >", "< Trasera arriba >", "< 车尾抬起 >", "< Hinten hoch >", "< リア上げ >", "< Зад поднят >", "< Traseira Erguida >", "< Arrière levé >") BREAK
        CASE 7 RETURN TR("< Lean Left >", "< Inclinar izq. >", "< 向左倾斜 >", "< Links neigen >", "< 左傾き >", "< Крен влево >", "< Inclinar à Esq. >", "< Pencher à gauche >") BREAK
        CASE 8 RETURN TR("< Lean Right >", "< Inclinar der. >", "< 向右倾斜 >", "< Rechts neigen >", "< 右傾き >", "< Крен вправо >", "< Inclinar à Dir. >", "< Pencher à droite >") BREAK
    ENDSWITCH
    RETURN TR("< Stock Height >", "< Altura de serie >", "< 原厂高度 >", "< Serienhöhe >", "< 純正車高 >", "< Стоковая высота >", "< Altura Original >", "< Hauteur d'origine >")
ENDFUNC

// Hydraulics Kit ON/OFF.  MOD_TOGGLE_HYDRAULICS is the kit itself;
// SET_CAN_USE_HYDRAULICS is the "may this car use them" gate.  Both are driven
// from the same flag so the OFF path cannot leave a car still allowed to use
// hydraulics it no longer has.
PROC APPLY_HYDRO_KIT_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    // A car with no hydraulic mod data cannot take the kit.  TOGGLE_VEHICLE_MOD
    // would write a flag the car has no mod for, and the row would then sit on ON
    // until the next sync flipped it back - which reads as a broken row rather
    // than an unsupported car.  Refuse and leave the row reporting OFF; the
    // Lowrider Support row carries the reason.
    IF NOT HYDRO_SUPPORTED(vehicle)
        g_hydro_enabled = FALSE
        EXIT
    ENDIF
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_HYDRAULICS, g_hydro_enabled)
    SET_CAN_USE_HYDRAULICS(vehicle, g_hydro_enabled)
ENDPROC

// Hydraulic Level = the MOD_HYDRO variant (the pump/valve level).  -1 writes
// stock back with REMOVE_VEHICLE_MOD, the same convention as the main LSC page.
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
    // Same game flag as the Wheels & Tyres "Soft Suspension" row, so mirror it -
    // the two rows are one setting and must never disagree.
    g_wheeltyre_soft_suspension = g_hydro_soft
ENDPROC

// Single-wheel control.  raiseAmount is the 0.0-1.0 height for that wheel and
// raiseSpeed how fast it travels - the header's own parameter names.
PROC APPLY_HYDRO_WHEEL()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    FLOAT amount = HYDRO_HEIGHT_VALUE(g_hydro_wheel_height)
    FLOAT speed = TO_FLOAT(g_hydro_raise_speed + 1) * 0.1
    IF speed < 0.1 speed = 0.1 ENDIF
    IF speed > 2.0 speed = 2.0 ENDIF
    SET_HYDRAULIC_WHEEL_STATE(vehicle, INT_TO_ENUM(SC_WHEEL_LIST, g_hydro_wheel), INT_TO_ENUM(WHEEL_HYDRAULIC_SCRIPT_STATE, g_hydro_wheel_state), amount, speed)
ENDPROC

// Full restore: every factor back to 1.0, state Free, and the car no longer
// allowed to use hydraulics.  Mirrors the game's own reset shape.
PROC RESET_HYDRAULICS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    HYDRO_SET_ALL(1.0)
    SET_HYDRAULIC_VEHICLE_STATE(vehicle, HS_ALL_FREE)
    SET_HYDRAULICS_CONTROL(vehicle, FALSE)
    SET_REDUCED_SUSPENSION_FORCE(vehicle, FALSE)
    SET_CAN_USE_HYDRAULICS(vehicle, FALSE)
    // Also un-fit the kit itself, so the "Hydraulics Kit" ON/OFF row reports the
    // truth after a reset instead of still claiming the kit is fitted.
    LSC_USE_KIT(vehicle)
    TOGGLE_VEHICLE_MOD(vehicle, MOD_TOGGLE_HYDRAULICS, FALSE)
    // Also clear the pump/valve variant (MOD_HYDRO).  Un-fitting the kit left the
    // chosen level behind, so re-fitting the kit came back already pumped.
    LSC_KIT_FOR_SLOT(vehicle, ENUM_TO_INT(MOD_HYDRO))
    IF GET_NUM_VEHICLE_MODS(vehicle, MOD_HYDRO) > 0 REMOVE_VEHICLE_MOD(vehicle, MOD_HYDRO) ENDIF
    g_hydro_enabled = FALSE
    g_hydro_hold = FALSE
    g_hydro_preset = 0
    g_hydro_hold_preset = 0
    g_hydro_control = FALSE
    g_hydro_level = -1
    // The single-wheel controls are hydraulic state too, so they are reset with
    // everything else instead of staying on the last wheel the player picked.
    g_hydro_wheel = 0
    g_hydro_wheel_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_wheel_state = 0
    g_hydro_raise_speed = 4
    g_hydro_soft = FALSE
    // Keep the Wheels & Tyres "Soft Suspension" row in agreement - same flag.
    g_wheeltyre_soft_suspension = FALSE
    g_hydro_front_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_rear_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_left_height = HYDRO_HEIGHT_LEVELS - 1
    g_hydro_right_height = HYDRO_HEIGHT_LEVELS - 1
ENDPROC
// Hold Stance: re-assert the chosen preset on a bounded cadence.  Called from the
// main loop, and exits immediately when it is off or the player is on foot.
// Leaving the vehicle stops it, so it can never keep running with nothing to hold.
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
    IF state = 1 RETURN TR("< Locked >", "< Bloqueada >", "< 锁定 >", "< Gesperrt >", "< ロック >", "< Заблокировано >", "< Travada >", "< Verrouillé >") ENDIF
    IF state = 2 RETURN TR("< Bounce >", "< Rebote >", "< 弹跳 >", "< Hüpfen >", "< バウンス >", "< Прыжок >", "< Salto >", "< Rebond >") ENDIF
    RETURN TR("< Free >", "< Libre >", "< 自由 >", "< Frei >", "< フリー >", "< Свободно >", "< Livre >", "< Libre >")
ENDFUNC

FUNC STRING HYDRO_WHEEL_LABEL(INT wheel)
    SWITCH wheel
        CASE 1 RETURN TR("< Front Right >", "< Delantera der. >", "< 右前轮 >", "< Vorne rechts >", "< 右前輪 >", "< Переднее правое >", "< Dianteira Dir. >", "< Avant droite >") BREAK
        CASE 2 RETURN TR("< Mid Left >", "< Central izq. >", "< 左中轮 >", "< Mitte links >", "< 左中輪 >", "< Среднее левое >", "< Central Esq. >", "< Milieu gauche >") BREAK
        CASE 3 RETURN TR("< Mid Right >", "< Central der. >", "< 右中轮 >", "< Mitte rechts >", "< 右中輪 >", "< Среднее правое >", "< Central Dir. >", "< Milieu droite >") BREAK
        CASE 4 RETURN TR("< Rear Left >", "< Trasera izq. >", "< 左后轮 >", "< Hinten links >", "< 左後輪 >", "< Заднее левое >", "< Traseira Esq. >", "< Arrière gauche >") BREAK
        CASE 5 RETURN TR("< Rear Right >", "< Trasera der. >", "< 右后轮 >", "< Hinten rechts >", "< 右後輪 >", "< Заднее правое >", "< Traseira Dir. >", "< Arrière droite >") BREAK
    ENDSWITCH
    RETURN TR("< Front Left >", "< Delantera izq. >", "< 左前轮 >", "< Vorne links >", "< 左前輪 >", "< Переднее левое >", "< Dianteira Esq. >", "< Avant gauche >")
ENDFUNC

// Hydraulic level row value.  "None on this car" when the car has no MOD_HYDRO
// variants at all - that is a real, reportable state, not a silent no-op.
//
// Read-only: it does NOT activate a kit.  Draw paths never call
// SET_VEHICLE_MOD_KIT (that would write the car's kit every frame); the kit is
// activated by SYNC_LSC_VEHICLE_STATE on a vehicle/slot/kit change instead, so
// the counts read here already reflect the active kit.
FUNC STRING HYDRO_LEVEL_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF GET_NUM_VEHICLE_MODS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_HYDRO) <= 0 RETURN TR("< None on this car >", "< Ninguno en este coche >", "< 此车无此项 >", "< Keins bei diesem Auto >", "< この車両には無し >", "< Нет на этом авто >", "< Nenhum neste carro >", "< Aucun sur cette voiture >") ENDIF
    IF g_hydro_level < 0 RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Origine >") ENDIF
    IF g_hydro_level = 0 RETURN "< Level 1 >" ENDIF
    IF g_hydro_level = 1 RETURN "< Level 2 >" ENDIF
    IF g_hydro_level = 2 RETURN "< Level 3 >" ENDIF
    IF g_hydro_level = 3 RETURN "< Level 4 >" ENDIF
    IF g_hydro_level = 4 RETURN "< Level 5 >" ENDIF
    IF g_hydro_level = 5 RETURN "< Level 6 >" ENDIF
    RETURN "< Level 7+ >"
ENDFUNC

// 0-100% in 5% steps.  One literal per level: see the note on LSC_KIT_INDEX_TEXT
// for why a composed value is impossible in this compiler.
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

// 0.1x to 2.0x in 0.1 steps, one literal per level.
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
                // Say why rather than showing a toggle that cannot take: an OFF
                // row here used to look like a row that was merely switched off.
                DRAW_OPTION(y, TR("Hydraulics Kit", "Kit hidráulico", "液压套件", "Hydraulik-Kit", "ハイドロキット", "Гидрокомплект", "Kit Hidráulico", "Kit hydraulique"), TR("< Not Supported >", "< No compatible >", "< 不支持 >", "< Nicht unterstützt >", "< 非対応 >", "< Не поддерживается >", "< Não Compatível >", "< Non compatible >"), g_item = index, 0)
            ELIF g_hydro_enabled
                DRAW_OPTION(y, TR("Hydraulics Kit", "Kit hidráulico", "液压套件", "Hydraulik-Kit", "ハイドロキット", "Гидрокомплект", "Kit Hidráulico", "Kit hydraulique"), "ON", g_item = index, 1)
            ELSE
                DRAW_OPTION(y, TR("Hydraulics Kit", "Kit hidráulico", "液压套件", "Hydraulik-Kit", "ハイドロキット", "Гидрокомплект", "Kit Hidráulico", "Kit hydraulique"), "OFF", g_item = index, 0)
            ENDIF
        BREAK
        CASE 1 DRAW_OPTION(y, TR("Hydraulic Level", "Nivel hidráulico", "液压等级", "Hydraulik-Stufe", "ハイドロレベル", "Уровень гидравлики", "Nível Hidráulico", "Niveau hydraulique"), HYDRO_LEVEL_TEXT(), g_item = index, 3) BREAK
        CASE 2 IF g_hydro_control DRAW_OPTION(y, TR("Player Control", "Control del jugador", "玩家控制", "Spielersteuerung", "プレイヤー操作", "Управление игрока", "Controle do Jogador", "Contrôle joueur"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Player Control", "Control del jugador", "玩家控制", "Spielersteuerung", "プレイヤー操作", "Управление игрока", "Controle do Jogador", "Contrôle joueur"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_OPTION(y, TR("Stance Preset", "Preajuste de postura", "姿态预设", "Haltungs-Preset", "スタンスプリセット", "Пресет посадки", "Predefinição de Postura", "Préréglage posture"), HYDRO_PRESET_LABEL(g_hydro_preset), g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, TR("Apply Stance Preset", "Aplicar postura", "应用姿态预设", "Preset anwenden", "プリセットを適用", "Применить пресет", "Aplicar Postura", "Appliquer posture"), "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Front Axle Height", "Altura eje delantero", "前轴高度", "Vorderachshöhe", "フロント軸車高", "Высота передней оси", "Altura do Eixo Diant.", "Hauteur essieu avant"), HYDRO_HEIGHT_TEXT(g_hydro_front_height), g_item = index, 3) BREAK
        CASE 6 DRAW_OPTION(y, TR("Rear Axle Height", "Altura eje trasero", "后轴高度", "Hinterachshöhe", "リア軸車高", "Высота задней оси", "Altura do Eixo Tras.", "Hauteur essieu arrière"), HYDRO_HEIGHT_TEXT(g_hydro_rear_height), g_item = index, 3) BREAK
        CASE 7 DRAW_OPTION(y, TR("Mid Left Height", "Altura central izq.", "左中高度", "Höhe Mitte links", "左中央車高", "Высота левого борта", "Altura Central Esq.", "Hauteur milieu gauche"), HYDRO_HEIGHT_TEXT(g_hydro_left_height), g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, TR("Mid Right Height", "Altura central der.", "右中高度", "Höhe Mitte rechts", "右中央車高", "Высота правого борта", "Altura Central Dir.", "Hauteur milieu droite"), HYDRO_HEIGHT_TEXT(g_hydro_right_height), g_item = index, 3) BREAK
        CASE 9 DRAW_OPTION(y, TR("Apply All Heights", "Aplicar todas las alturas", "应用全部高度", "Alle Höhen anwenden", "全車高を適用", "Применить все высоты", "Aplicar Todas as Alturas", "Appliquer les hauteurs"), "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, TR("Single Wheel", "Rueda individual", "单轮选择", "Einzelrad", "個別ホイール", "Отдельное колесо", "Roda Individual", "Roue individuelle"), HYDRO_WHEEL_LABEL(g_hydro_wheel), g_item = index, 3) BREAK
        CASE 11 DRAW_OPTION(y, TR("Wheel Height", "Altura de rueda", "车轮高度", "Radhöhe", "ホイール車高", "Высота колеса", "Altura da Roda", "Hauteur de roue"), HYDRO_HEIGHT_TEXT(g_hydro_wheel_height), g_item = index, 3) BREAK
        CASE 12 DRAW_OPTION(y, TR("Wheel State", "Estado de rueda", "车轮状态", "Radstatus", "ホイール状態", "Состояние колеса", "Estado da Roda", "État de la roue"), HYDRO_WHEEL_STATE_LABEL(g_hydro_wheel_state), g_item = index, 3) BREAK
        CASE 13 DRAW_OPTION(y, TR("Wheel Raise Speed", "Velocidad de elevación", "抬升速度", "Hebegeschwindigkeit", "昇降速度", "Скорость подъёма", "Velocidade de Elevação", "Vitesse de levage"), HYDRO_SPEED_TEXT(g_hydro_raise_speed), g_item = index, 3) BREAK
        CASE 14 DRAW_OPTION(y, TR("Apply To Wheel", "Aplicar a la rueda", "应用至该车轮", "Auf Rad anwenden", "ホイールに適用", "Применить к колесу", "Aplicar à Roda", "Appliquer à la roue"), "APPLY", g_item = index, 2) BREAK
        CASE 15 IF g_hydro_hold DRAW_OPTION(y, TR("Hold Stance", "Mantener postura", "保持姿态", "Haltung halten", "スタンス維持", "Удерживать посадку", "Manter Postura", "Maintenir la posture"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Hold Stance", "Mantener postura", "保持姿态", "Haltung halten", "スタンス維持", "Удерживать посадку", "Manter Postura", "Maintenir la posture"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 IF g_hydro_soft DRAW_OPTION(y, TR("Stance Softness", "Suavidad de postura", "软悬挂姿态", "Weiche Haltung", "ソフトスタンス", "Мягкость посадки", "Maciez da Postura", "Souplesse de posture"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Stance Softness", "Suavidad de postura", "软悬挂姿态", "Weiche Haltung", "ソフトスタンス", "Мягкость посадки", "Maciez da Postura", "Souplesse de posture"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 DRAW_OPTION(y, TR("Reset Hydraulics", "Restablecer hidráulica", "重置液压系统", "Hydraulik zurücksetzen", "ハイドロをリセット", "Сбросить гидравлику", "Redefinir Hidráulica", "Réinitialiser hydraulique"), "APPLY", g_item = index, 2) BREAK
        // Appended row (v0.9.9), so every index above keeps its meaning.  This is
        // the row that turns "the hydraulics rows do nothing" into "this car
        // cannot take a lowrider kit, here is the car that can".
        CASE 18 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, TR("Lowrider Support", "Soporte Lowrider", "低底盘车支持", "Lowrider-Unterstützung", "ローライダー対応", "Поддержка лоурайдера", "Suporte Lowrider", "Support lowrider"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, TR("Lowrider Support", "Soporte Lowrider", "低底盘车支持", "Lowrider-Unterstützung", "ローライダー対応", "Поддержка лоурайдера", "Suporte Lowrider", "Support lowrider"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_HYDRO_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("HYDRAULICS", "HIDRÁULICA", "液压系统", "HYDRAULIK", "ハイドロ", "ГИДРАВЛИКА", "HIDRÁULICA", "HYDRAULIQUE"))
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Hydraulics", "Hidráulica", "液压系统", "Hydraulik", "ハイドロ", "Гидравлика", "Hidráulica", "Hydraulique"), "NO VEHICLE", g_item = 0, 0)
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
// ===========================================================================
// LS Customs depth - Lowrider Interior page (v0.9.9)
//
// These are the slots that only exist on a car carrying the lowrider add-on mod
// kit, which is exactly why they never worked before: the menu forced kit 0 and
// then read GET_NUM_VEHICLE_MODS == 0 for every one of them.  Each apply path
// below goes through LSC_KIT_FOR_SLOT, so the write lands in the kit that
// actually holds the slot.
//
// Live names come from the game, not from a table: GET_MOD_SLOT_NAME and
// GET_MOD_TEXT_LABEL replace the old, meaningless "Selected Variant 3" row, so
// the page tells the player what it is actually changing.
// ===========================================================================

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
        CASE 1 RETURN TR("< Interior 2 >", "< Interior 2 >", "< 内饰 2 >", "< Innenraum 2 >", "< 内装 2 >", "< Салон 2 >", "< Interior 2 >", "< Intérieur 2 >") BREAK
        CASE 2 RETURN TR("< Interior 3 >", "< Interior 3 >", "< 内饰 3 >", "< Innenraum 3 >", "< 内装 3 >", "< Салон 3 >", "< Interior 3 >", "< Intérieur 3 >") BREAK
        CASE 3 RETURN TR("< Interior 4 >", "< Interior 4 >", "< 内饰 4 >", "< Innenraum 4 >", "< 内装 4 >", "< Салон 4 >", "< Interior 4 >", "< Intérieur 4 >") BREAK
        CASE 4 RETURN TR("< Interior 5 >", "< Interior 5 >", "< 内饰 5 >", "< Innenraum 5 >", "< 内装 5 >", "< Салон 5 >", "< Interior 5 >", "< Intérieur 5 >") BREAK
        CASE 5 RETURN TR("< Seats >", "< Asientos >", "< 座椅 >", "< Sitze >", "< シート >", "< Сиденья >", "< Bancos >", "< Sièges >") BREAK
        CASE 6 RETURN TR("< Steering Wheel >", "< Volante >", "< 方向盘 >", "< Lenkrad >", "< ステアリング >", "< Руль >", "< Volante >", "< Volant >") BREAK
        CASE 7 RETURN TR("< Knob >", "< Pomo >", "< 排挡头 >", "< Schaltknauf >", "< シフトノブ >", "< Ручка КПП >", "< Manopla >", "< Pommeau >") BREAK
        CASE 8 RETURN TR("< Plaque >", "< Placa >", "< 铭牌 >", "< Plakette >", "< プラーク >", "< Табличка >", "< Placa >", "< Plaque >") BREAK
        CASE 9 RETURN TR("< ICE / Speakers >", "< Altavoces >", "< 音响喇叭 >", "< Lautsprecher >", "< スピーカー >", "< Аудиосистема >", "< Alto-falantes >", "< Haut-parleurs >") BREAK
        CASE 10 RETURN TR("< Trunk >", "< Maletero >", "< 后备箱 >", "< Kofferraum >", "< トランク >", "< Багажник >", "< Porta-malas >", "< Coffre >") BREAK
        CASE 11 RETURN TR("< Engine Bay 1 >", "< Vano motor 1 >", "< 引擎舱 1 >", "< Motorraum 1 >", "< エンジンルーム 1 >", "< Моторный отсек 1 >", "< Cofre do Motor 1 >", "< Compartiment moteur 1 >") BREAK
        CASE 12 RETURN TR("< Engine Bay 2 >", "< Vano motor 2 >", "< 引擎舱 2 >", "< Motorraum 2 >", "< エンジンルーム 2 >", "< Моторный отсек 2 >", "< Cofre do Motor 2 >", "< Compartiment moteur 2 >") BREAK
        CASE 13 RETURN TR("< Engine Bay 3 >", "< Vano motor 3 >", "< 引擎舱 3 >", "< Motorraum 3 >", "< エンジンルーム 3 >", "< Моторный отсек 3 >", "< Cofre do Motor 3 >", "< Compartiment moteur 3 >") BREAK
        CASE 14 RETURN TR("< Chassis 2 >", "< Chasis 2 >", "< 底盘 2 >", "< Fahrgestell 2 >", "< シャーシ 2 >", "< Шасси 2 >", "< Chassi 2 >", "< Châssis 2 >") BREAK
        CASE 15 RETURN TR("< Chassis 3 >", "< Chasis 3 >", "< 底盘 3 >", "< Fahrgestell 3 >", "< シャーシ 3 >", "< Шасси 3 >", "< Chassi 3 >", "< Châssis 3 >") BREAK
        CASE 16 RETURN TR("< Chassis 4 >", "< Chasis 4 >", "< 底盘 4 >", "< Fahrgestell 4 >", "< シャーシ 4 >", "< Шасси 4 >", "< Chassi 4 >", "< Châssis 4 >") BREAK
        CASE 17 RETURN TR("< Chassis 5 >", "< Chasis 5 >", "< 底盘 5 >", "< Fahrgestell 5 >", "< シャーシ 5 >", "< Шасси 5 >", "< Chassi 5 >", "< Châssis 5 >") BREAK
        CASE 18 RETURN TR("< Left Door >", "< Puerta izquierda >", "< 左车门 >", "< Linke Tür >", "< 左ドア >", "< Левая дверь >", "< Porta Esquerda >", "< Porte gauche >") BREAK
        CASE 19 RETURN TR("< Right Door >", "< Puerta derecha >", "< 右车门 >", "< Rechte Tür >", "< 右ドア >", "< Правая дверь >", "< Porta Direita >", "< Porte droite >") BREAK
        CASE 20 RETURN TR("< Plate Holder >", "< Portamatrículas >", "< 车牌架 >", "< Kennzeichenhalter >", "< プレートホルダー >", "< Рамка номера >", "< Suporte de Placa >", "< Support de plaque >") BREAK
        CASE 21 RETURN TR("< Vanity Plate >", "< Matrícula decorativa >", "< 装饰车牌 >", "< Zierkennzeichen >", "< バニティプレート >", "< Декор. номер >", "< Placa Decorativa >", "< Plaque décorative >") BREAK
    ENDSWITCH
    RETURN TR("< Interior 1 >", "< Interior 1 >", "< 内饰 1 >", "< Innenraum 1 >", "< 内装 1 >", "< Салон 1 >", "< Interior 1 >", "< Intérieur 1 >")
ENDFUNC
// How many variants the selected lowrider slot offers ON THE ACTIVE KIT.  Zero
// is the state that used to be reported for every one of these slots.
FUNC INT INTERIOR_AVAILABLE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN 0 ENDIF
    RETURN GET_NUM_VEHICLE_MODS(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
ENDFUNC

// How many of the lowrider slots this car can actually take, on whichever kit
// holds them.  Walks the same slot list the Interior page walks, so the Support
// Check count and the Interior page can never disagree.  A stock car returns 0 -
// the number that explains why the Interior rows did nothing on one.
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

// One literal per value: this compiler cannot compose a STRING (see the note on
// LSC_KIT_INDEX_TEXT), so the panel is a table like every other composed row.
FUNC STRING LOWRIDER_SLOT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT slots = LOWRIDER_SLOT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF slots <= 0 RETURN TR("< None On This Car >", "< Ninguno en este coche >", "< 此车无此槽位 >", "< Keins bei diesem Auto >", "< この車両には無し >", "< Нет на этом авто >", "< Nenhum Neste Carro >", "< Aucun sur cette voiture >") ENDIF
    IF slots = 1 RETURN "< 1 / 22 >" ENDIF
    IF slots = 2 RETURN "< 2 / 22 >" ENDIF
    IF slots = 3 RETURN "< 3 / 22 >" ENDIF
    IF slots = 4 RETURN "< 4 / 22 >" ENDIF
    IF slots = 5 RETURN "< 5 / 22 >" ENDIF
    IF slots = 6 RETURN "< 6 / 22 >" ENDIF
    IF slots = 7 RETURN "< 7 / 22 >" ENDIF
    IF slots = 8 RETURN "< 8 / 22 >" ENDIF
    IF slots = 9 RETURN "< 9 / 22 >" ENDIF
    IF slots = 10 RETURN "< 10 / 22 >" ENDIF
    IF slots = 11 RETURN "< 11 / 22 >" ENDIF
    IF slots = 12 RETURN "< 12 / 22 >" ENDIF
    IF slots = 13 RETURN "< 13 / 22 >" ENDIF
    IF slots = 14 RETURN "< 14 / 22 >" ENDIF
    IF slots = 15 RETURN "< 15 / 22 >" ENDIF
    IF slots = 16 RETURN "< 16 / 22 >" ENDIF
    IF slots = 17 RETURN "< 17 / 22 >" ENDIF
    IF slots = 18 RETURN "< 18 / 22 >" ENDIF
    IF slots = 19 RETURN "< 19 / 22 >" ENDIF
    IF slots = 20 RETURN "< 20 / 22 >" ENDIF
    IF slots = 21 RETURN "< 21 / 22 >" ENDIF
    RETURN TR("< All 22 Slots >", "< Las 22 ranuras >", "< 全部 22 个槽位 >", "< Alle 22 Slots >", "< 全22スロット >", "< Все 22 слота >", "< Todos os 22 Slots >", "< Les 22 emplacements >")
ENDFUNC

FUNC STRING INTERIOR_AVAILABLE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT available = INTERIOR_AVAILABLE()
    IF available <= 0 RETURN TR("< None on this kit >", "< Ninguno en este kit >", "< 此套件无此项 >", "< Keins in diesem Kit >", "< このキットには無し >", "< Нет в этом ките >", "< Nenhum neste kit >", "< Aucun dans ce kit >") ENDIF
    IF available = 1 RETURN "< 1 >" ENDIF
    IF available = 2 RETURN "< 2 >" ENDIF
    IF available = 3 RETURN "< 3 >" ENDIF
    IF available = 4 RETURN "< 4 >" ENDIF
    IF available = 5 RETURN "< 5 >" ENDIF
    IF available = 6 RETURN "< 6 >" ENDIF
    IF available = 7 RETURN "< 7 >" ENDIF
    IF available = 8 RETURN "< 8 >" ENDIF
    IF available = 9 RETURN "< 9 >" ENDIF
    IF available = 10 RETURN "< 10 >" ENDIF
    RETURN "< 10+ >"
ENDFUNC

// Live slot name from the game.  Falls back rather than rendering an empty row.
FUNC STRING INTERIOR_SLOT_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    STRING slotName = GET_MOD_SLOT_NAME(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
    IF NOT IS_STRING_NULL_OR_EMPTY(slotName) AND NOT ARE_STRINGS_EQUAL(slotName, "NULL")
        slotName = LSC_RESOLVE_LABEL(slotName)
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(slotName) OR ARE_STRINGS_EQUAL(slotName, "NULL")
        RETURN TR("< unnamed slot >", "< ranura sin nombre >", "< 未命名槽位 >", "< unbenannter Slot >", "< 名称なしスロット >", "< слот без имени >", "< slot sem nome >", "< emplacement sans nom >")
    ENDIF
    RETURN slotName
ENDFUNC

// Live variant name for the current choice.  "Stock" for -1, and an explicit
// "no variants" message when the slot is absent on the active kit.
FUNC STRING INTERIOR_VARIANT_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    INT available = INTERIOR_AVAILABLE()
    IF available <= 0 RETURN TR("< none on this kit >", "< ninguno en este kit >", "< 此套件无此项 >", "< keins in diesem Kit >", "< このキットには無し >", "< нет в этом ките >", "< nenhum neste kit >", "< aucun dans ce kit >") ENDIF
    IF g_interior_choice < 0 RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Origine >") ENDIF
    INT choice = g_interior_choice
    IF choice >= available choice = available - 1 ENDIF
    STRING variantName = GET_MOD_TEXT_LABEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()), choice)
    IF NOT IS_STRING_NULL_OR_EMPTY(variantName) AND NOT ARE_STRINGS_EQUAL(variantName, "NULL")
        variantName = LSC_RESOLVE_LABEL(variantName)
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(variantName) OR ARE_STRINGS_EQUAL(variantName, "NULL")
        RETURN TR("< unnamed variant >", "< variante sin nombre >", "< 未命名款式 >", "< unbenannte Variante >", "< 名称なしバリエーション >", "< вариант без имени >", "< variante sem nome >", "< variante sans nom >")
    ENDIF
    RETURN variantName
ENDFUNC

FUNC STRING INTERIOR_VARIANT_TEXT()
    IF INTERIOR_AVAILABLE() <= 0 RETURN TR("< None >", "< Ninguno >", "< 无 >", "< Keins >", "< なし >", "< Нет >", "< Nenhum >", "< Aucun >") ENDIF
    IF g_interior_choice < 0 RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Origine >") ENDIF
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

// Fill index for the "Apply To Every Slot" row.  0-9 literal table.
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
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF HAVE_VEHICLE_MODS_STREAMED_IN(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) RETURN TR("< Yes >", "< Sí >", "< 是 >", "< Ja >", "< はい >", "< Да >", "< Sim >", "< Oui >") ENDIF
    RETURN TR("< Not yet >", "< Aún no >", "< 尚未 >", "< Noch nicht >", "< 未完了 >", "< Ещё нет >", "< Ainda não >", "< Pas encore >")
ENDFUNC
// Apply the chosen variant to the selected lowrider slot.  The kit search makes
// this work on any car regardless of which kit holds the slot.
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

// Read-only: report what the active kit holds for the selected slot.
PROC SYNC_INTERIOR_SLOT()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    g_interior_choice = GET_VEHICLE_MOD(vehicle, INT_TO_ENUM(MOD_TYPE, INTERIOR_SLOT()))
    IF g_interior_choice >= INTERIOR_AVAILABLE() g_interior_choice = -1 ENDIF
ENDPROC

// Fill every lowrider slot this car actually has with the same variant index.
// Slots with no variants on the active kit are skipped, so this cannot write an
// out-of-range index into a slot that has fewer entries.
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

// Trim (extra colour 5) and metal (extra colour 6).  The SDK's own param note
// says both "should be taken from the list in carcols.dat", which is the same
// palette the paint rows already use via LSC_COLOUR_ID.
PROC APPLY_INTERIOR_COLOURS()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_EXTRA_COLOUR_5(vehicle, LSC_COLOUR_ID(g_lsc_trim_colour))
    SET_VEHICLE_EXTRA_COLOUR_6(vehicle, LSC_COLOUR_ID(g_lsc_metal_colour))
ENDPROC

PROC DRAW_INTERIOR_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Apply To Every Slot", "Aplicar a cada ranura", "应用到所有槽位", "Auf jeden Slot anwenden", "全スロットに適用", "Применить ко всем слотам", "Aplicar a Todos os Slots", "Appliquer à chaque slot"), "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, TR("Fill Variant", "Variante de relleno", "统一填充款式", "Füll-Variante", "一括バリエーション", "Вариант заполнения", "Variante de Preenchimento", "Variante de remplissage"), INTERIOR_FILL_TEXT(), g_item = index, 3) BREAK
        CASE 2 DRAW_OPTION(y, TR("Slot", "Ranura", "槽位", "Slot", "スロット", "Слот", "Slot", "Emplacement"), INTERIOR_SLOT_LABEL(g_interior_slot), g_item = index, 3) BREAK
        CASE 3 DRAW_OPTION(y, TR("Variant", "Variante", "款式", "Variante", "バリエーション", "Вариант", "Variante", "Variante"), INTERIOR_VARIANT_TEXT(), g_item = index, 3) BREAK
        CASE 4 DRAW_OPTION(y, TR("Available", "Disponibles", "可用数量", "Verfügbar", "利用可能数", "Доступно", "Disponíveis", "Disponibles"), INTERIOR_AVAILABLE_TEXT(), g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Slot Name", "Nombre de ranura", "槽位名称", "Slot-Name", "スロット名", "Имя слота", "Nome do Slot", "Nom de l'emplacement"), INTERIOR_SLOT_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Variant Name", "Nombre de variante", "款式名称", "Variantenname", "バリエーション名", "Имя варианта", "Nome da Variante", "Nom de la variante"), INTERIOR_VARIANT_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_LSC_COLOUR_SELECTOR(y, TR("Trim Colour", "Color de tapicería", "内饰饰条颜色", "Zierleistenfarbe", "トリムカラー", "Цвет отделки", "Cor do Acabamento", "Couleur de finition"), g_lsc_trim_colour, g_item = index) BREAK
        CASE 8 DRAW_LSC_COLOUR_SELECTOR(y, TR("Metal Colour", "Color de metal", "金属装饰颜色", "Metallfarbe", "メタルカラー", "Цвет металла", "Cor do Metal", "Couleur du métal"), g_lsc_metal_colour, g_item = index) BREAK
        CASE 9 DRAW_OPTION(y, TR("Mods Streamed", "Mods cargados", "改装件已加载", "Mods geladen", "改造データ読込済", "Моды загружены", "Mods Carregados", "Mods chargés"), INTERIOR_STREAMED_TEXT(), g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, TR("Reset Interior", "Restablecer interior", "重置内饰", "Innenraum zurücksetzen", "内装をリセット", "Сбросить салон", "Redefinir Interior", "Réinitialiser l'intérieur"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_INTERIOR_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("LOWRIDER INTERIOR", "INTERIOR LOWRIDER", "低底盘车内饰", "LOWRIDER-INNENRAUM", "ローライダー内装", "САЛОН ЛОУРАЙДЕРА", "INTERIOR LOWRIDER", "INTÉRIEUR LOWRIDER"))
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Lowrider Interior", "Interior lowrider", "低底盘车内饰", "Lowrider-Innenraum", "ローライダー内装", "Салон лоурайдера", "Interior Lowrider", "Intérieur lowrider"), "NO VEHICLE", g_item = 0, 0)
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
// ===========================================================================
// LS Customs depth - Wheels & Tyres page (v0.9.9)
//
// Natives: SET_VEHICLE_WHEEL_TYPE / GET_VEHICLE_WHEEL_TYPE (MOD_WHEEL_TYPE
// 0-12), SET_VEHICLE_MOD(..., variation) / GET_VEHICLE_MOD_VARIATION,
// TOGGLE_VEHICLE_MOD(MOD_TOGGLE_TYRE_SMOKE), SET_VEHICLE_TYRES_CAN_BURST and
// SET_REDUCED_SUSPENSION_FORCE (the SDK's param note: "so users can stance
// cars").
// ===========================================================================

// MOD_WHEELS covers the front/normal wheels; MOD_REAR_WHEELS is the bike rear
// wheel slot.  Both are real enum members (commands_vehicle.sch MOD_TYPE).
FUNC INT WHEEL_SLOT_TYPE()
    IF g_wheeltyre_rear_slot RETURN ENUM_TO_INT(MOD_REAR_WHEELS) ENDIF
    RETURN ENUM_TO_INT(MOD_WHEELS)
ENDFUNC

FUNC STRING WHEEL_SLOT_LABEL()
    IF g_wheeltyre_rear_slot RETURN TR("< Rear Wheel >", "< Rueda trasera >", "< 后轮 >", "< Hinterrad >", "< 後輪 >", "< Заднее колесо >", "< Roda Traseira >", "< Roue arrière >") ENDIF
    RETURN TR("< Front / All >", "< Delantera / Todas >", "< 前轮 / 全部 >", "< Vorne / Alle >", "< 前輪 / すべて >", "< Передние / Все >", "< Dianteira / Todas >", "< Avant / Toutes >")
ENDFUNC

FUNC STRING WHEEL_VARIATION_TEXT()
    IF g_wheeltyre_variation = 1 RETURN TR("< Variant B >", "< Variante B >", "< 款式 B >", "< Variante B >", "< バリエーションB >", "< Вариант B >", "< Variante B >", "< Variante B >") ENDIF
    RETURN TR("< Variant A >", "< Variante A >", "< 款式 A >", "< Variante A >", "< バリエーションA >", "< Вариант A >", "< Variante A >", "< Variante A >")
ENDFUNC

FUNC STRING WHEEL_VARIATION_STATE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT variation = GET_VEHICLE_MOD_VARIATION(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_TYPE, WHEEL_SLOT_TYPE()))
    IF variation = 1 RETURN TR("< Variant B fitted >", "< Variante B instalada >", "< 已装 B 款 >", "< Variante B montiert >", "< バリエーションB装着 >", "< Вариант B установлен >", "< Variante B instalada >", "< Variante B montée >") ENDIF
    RETURN TR("< Variant A fitted >", "< Variante A instalada >", "< 已装 A 款 >", "< Variante A montiert >", "< バリエーションA装着 >", "< Вариант A установлен >", "< Variante A instalada >", "< Variante A montée >")
ENDFUNC

FUNC STRING WHEEL_TYRE_SMOKE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF IS_TOGGLE_MOD_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_TOGGLE_TYRE_SMOKE) RETURN TR("< Fitted >", "< Instalado >", "< 已安装 >", "< Montiert >", "< 装着済 >", "< Установлено >", "< Instalado >", "< Installé >") ENDIF
    RETURN TR("< Not fitted >", "< No instalado >", "< 未安装 >", "< Nicht montiert >", "< 未装着 >", "< Не установлено >", "< Não instalado >", "< Non installé >")
ENDFUNC

PROC APPLY_WHEEL_FAMILY()
    SET_VEHICLE_WHEEL_TYPE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
ENDPROC

// Variation is a property of the *current* mod index in the slot, so the row
// re-writes the index the car already has with the variation flag flipped.  The
// index is clamped to the slot's real variant count first, so a car whose wheel
// slot is empty is a clean no-op instead of an out-of-range write.
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

// "Tyres Can Burst" (Wheels & Tyres) and the Vehicle Control "Bulletproof Tyres"
// toggle drive the same native, so they are one setting with two rows.  Asking
// for burstable tyres here clears the bulletproof toggle rather than being
// overwritten by it on the next frame - the main loop only ever forces the tyres
// unburstable while that toggle is ON.
PROC APPLY_TYRES_CAN_BURST()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_TYRES_CAN_BURST(vehicle, g_wheeltyre_can_burst)
    IF g_wheeltyre_can_burst
        g_vehicle_bulletproof_tyres = FALSE
        g_bulletproof_tyres_applied = FALSE
    ENDIF
ENDPROC

// "Soft Suspension" (Wheels & Tyres) and "Stance Softness" (Hydraulics) write the
// same game flag - SET_REDUCED_SUSPENSION_FORCE - so they are likewise one setting
// with two rows.  Each mirrors the value into the other's global, so the two rows
// can never display contradictory states whichever one the player uses.
PROC APPLY_SOFT_SUSPENSION()
    SET_REDUCED_SUSPENSION_FORCE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_wheeltyre_soft_suspension)
    g_hydro_soft = g_wheeltyre_soft_suspension
ENDPROC

// Seeds the Wheels & Tyres rows from the current car when the page is opened, so
// a row cannot be showing the previous car's state.  Tyre smoke is a real
// readback (IS_TOGGLE_MOD_ON); tyres-can-burst and reduced suspension have no
// getter in this header at all, so they are seeded from the menu's own single
// source of truth for those two flags instead.
PROC SYNC_WHEELTYRE_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    LSC_USE_KIT(vehicle)
    IF IS_TOGGLE_MOD_ON(vehicle, MOD_TOGGLE_TYRE_SMOKE)
        g_wheeltyre_smoke = TRUE
    ELSE
        g_wheeltyre_smoke = FALSE
    ENDIF
    // While the bulletproof toggle is ON the main loop is holding the tyres
    // unburstable, so this row must not claim they can burst.
    IF g_vehicle_bulletproof_tyres g_wheeltyre_can_burst = FALSE ENDIF
    g_wheeltyre_soft_suspension = g_hydro_soft
ENDPROC

PROC DRAW_WHEELTYRE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Wheel Family", "Familia de ruedas", "车轮系列", "Radfamilie", "ホイール系統", "Семейство колёс", "Família de Rodas", "Famille de roues"), WHEEL_FAMILY_LABEL(g_lsc_wheel_type), g_item = index, 3) BREAK
        CASE 1 DRAW_OPTION(y, TR("Wheel Variation", "Variación de rueda", "轮胎花纹款式", "Radvariante", "ホイールバリエーション", "Вариация колёс", "Variação da Roda", "Variante de roue"), WHEEL_VARIATION_TEXT(), g_item = index, 3) BREAK
        CASE 2 DRAW_OPTION(y, TR("Wheel Slot", "Ranura de rueda", "车轮位置", "Rad-Slot", "ホイール位置", "Слот колеса", "Slot de Roda", "Emplacement roue"), WHEEL_SLOT_LABEL(), g_item = index, 3) BREAK
        CASE 3 DRAW_OPTION(y, TR("Apply Wheel Family", "Aplicar familia de ruedas", "应用车轮系列", "Radfamilie anwenden", "ホイール系統を適用", "Применить семейство", "Aplicar Família de Rodas", "Appliquer famille de roues"), "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Apply Wheel Variation", "Aplicar variación de rueda", "应用轮胎款式", "Radvariante anwenden", "バリエーションを適用", "Применить вариацию", "Aplicar Variação da Roda", "Appliquer variante de roue"), "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Fitted Variation", "Variación instalada", "当前已装款式", "Montierte Variante", "装着バリエーション", "Установленная вариация", "Variação Instalada", "Variante montée"), WHEEL_VARIATION_STATE_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Smoke Fitted", "Humo instalado", "烧胎烟雾已装", "Reifenqualm montiert", "スモーク装着状態", "Дым покрышек уст.", "Fumaça Instalada", "Fumée installée"), WHEEL_TYRE_SMOKE_TEXT(), g_item = index, 2) BREAK
        CASE 7 IF g_wheeltyre_smoke DRAW_OPTION(y, TR("Tyre Smoke", "Humo de neumáticos", "烧胎烟雾", "Reifenqualm", "タイヤスモーク", "Дым из-под колёс", "Fumaça dos Pneus", "Fumée de pneus"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Tyre Smoke", "Humo de neumáticos", "烧胎烟雾", "Reifenqualm", "タイヤスモーク", "Дым из-под колёс", "Fumaça dos Pneus", "Fumée de pneus"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 IF g_wheeltyre_can_burst DRAW_OPTION(y, TR("Tyres Can Burst", "Neumáticos perforables", "轮胎可爆胎", "Reifen können platzen", "パンク有効", "Пробиваемые шины", "Pneus Podem Furados", "Pneus crevables"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Tyres Can Burst", "Neumáticos perforables", "轮胎可爆胎", "Reifen können platzen", "パンク有効", "Пробиваемые шины", "Pneus Podem Furados", "Pneus crevables"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 9 IF g_wheeltyre_soft_suspension DRAW_OPTION(y, TR("Soft Suspension", "Suspensión blanda", "软性悬挂", "Weiche Federung", "ソフトサスペンション", "Мягкая подвеска", "Suspensão Macia", "Suspension souple"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Soft Suspension", "Suspensión blanda", "软性悬挂", "Weiche Federung", "ソフトサスペンション", "Мягкая подвеска", "Suspensão Macia", "Suspension souple"), "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WHEELTYRE_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WHEELS AND TYRES", "RUEDAS Y NEUMÁTICOS", "车轮与轮胎", "RÄDER & REIFEN", "ホイール＆タイヤ", "КОЛЁСА И ШИНЫ", "RODAS E PNEUS", "ROUES ET PNEUS"))
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Wheels & Tyres", "Ruedas y neumáticos", "车轮与轮胎", "Räder & Reifen", "ホイール＆タイヤ", "Колёса и шины", "Rodas e Pneus", "Roues et pneus"), "NO VEHICLE", g_item = 0, 0)
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
// ===========================================================================
// LS Customs depth - Extras & Livery page (v0.9.9)
//
// Natives: SET_VEHICLE_LIVERY / GET_VEHICLE_LIVERY / GET_VEHICLE_LIVERY_COUNT /
// GET_LIVERY_NAME, and the extras trio DOES_EXTRA_EXIST /
// IS_VEHICLE_EXTRA_TURNED_ON / SET_VEHICLE_EXTRA.
//
// SET_VEHICLE_EXTRA's third parameter is named TurnOff in this header - it is
// inverted relative to what the row label implies - so every call below passes
// the negation explicitly and never an inferred value.
// ===========================================================================

FUNC STRING LIVERY_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT count = GET_VEHICLE_LIVERY_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF count <= 0 RETURN TR("< No liveries >", "< Sin cubiertas >", "< 无涂装 >", "< Keine Designs >", "< ペイント無し >", "< Нет раскрасок >", "< Sem estampas >", "< Aucun motif >") ENDIF
    IF g_lsc_livery < 0 RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Origine >") ENDIF
    IF g_lsc_livery = 0 RETURN "< 1 >" ENDIF
    IF g_lsc_livery = 1 RETURN "< 2 >" ENDIF
    IF g_lsc_livery = 2 RETURN "< 3 >" ENDIF
    IF g_lsc_livery = 3 RETURN "< 4 >" ENDIF
    IF g_lsc_livery = 4 RETURN "< 5 >" ENDIF
    IF g_lsc_livery = 5 RETURN "< 6 >" ENDIF
    IF g_lsc_livery = 6 RETURN "< 7 >" ENDIF
    IF g_lsc_livery = 7 RETURN "< 8 >" ENDIF
    RETURN "< 9+ >"
ENDFUNC

FUNC STRING LIVERY_COUNT_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    INT count = GET_VEHICLE_LIVERY_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    IF count <= 0 RETURN TR("< None on this car >", "< Ninguno en este coche >", "< 此车无涂装 >", "< Keins bei diesem Auto >", "< この車両には無し >", "< Нет на этом авто >", "< Nenhum neste carro >", "< Aucun sur cette voiture >") ENDIF
    IF count = 1 RETURN "< 1 >" ENDIF
    IF count = 2 RETURN "< 2 >" ENDIF
    IF count = 3 RETURN "< 3 >" ENDIF
    IF count = 4 RETURN "< 4 >" ENDIF
    IF count = 5 RETURN "< 5 >" ENDIF
    IF count = 6 RETURN "< 6 >" ENDIF
    IF count = 7 RETURN "< 7 >" ENDIF
    IF count = 8 RETURN "< 8 >" ENDIF
    RETURN "< 9+ >"
ENDFUNC

// Live livery name from the game; falls back rather than rendering an empty row.
FUNC STRING LIVERY_NAME_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN "-" ENDIF
    IF g_lsc_livery < 0 RETURN TR("< Stock >", "< De serie >", "< 原厂 >", "< Serie >", "< 純正 >", "< Сток >", "< Original >", "< Origine >") ENDIF
    STRING liveryName = GET_LIVERY_NAME(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_livery)
    IF NOT IS_STRING_NULL_OR_EMPTY(liveryName) AND NOT ARE_STRINGS_EQUAL(liveryName, "NULL")
        liveryName = LSC_RESOLVE_LABEL(liveryName)
    ENDIF
    IF IS_STRING_NULL_OR_EMPTY(liveryName) OR ARE_STRINGS_EQUAL(liveryName, "NULL")
        RETURN TR("< unnamed livery >", "< cubierta sin nombre >", "< 未命名涂装 >", "< unbenanntes Design >", "< 名称なしペイント >", "< раскраска без имени >", "< estampa sem nome >", "< motif sans nom >")
    ENDIF
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
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF DOES_EXTRA_EXIST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN TR("< Fitted >", "< Instalado >", "< 有此配件 >", "< Vorhanden >", "< あり >", "< Есть >", "< Presente >", "< Présent >") ENDIF
    RETURN TR("< Not on this car >", "< No en este coche >", "< 此车无此项 >", "< Nicht bei diesem Auto >", "< この車両には無し >", "< Нет на этом авто >", "< Ausente neste carro >", "< Absent sur cette voiture >")
ENDFUNC

FUNC STRING EXTRA_STATE_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF NOT DOES_EXTRA_EXIST(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN TR("< Unavailable >", "< No disponible >", "< 不可用 >", "< Nicht verfügbar >", "< 利用不可 >", "< Недоступно >", "< Indisponível >", "< Indisponible >") ENDIF
    IF IS_VEHICLE_EXTRA_TURNED_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1) RETURN TR("< On >", "< Activo >", "< 开启 >", "< Ein >", "< オン >", "< Вкл >", "< Ligado >", "< Activé >") ENDIF
    RETURN TR("< Off >", "< Inactivo >", "< 关闭 >", "< Aus >", "< オフ >", "< Выкл >", "< Desligado >", "< Désactivé >")
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

// Toggle the selected extra.  TurnOff is inverted in this header, so the
// negation is explicit.  A slot the car does not have is a clean no-op.
PROC APPLY_EXTRA_TOGGLE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    REFRESH_EXTRA_PROBE()
    IF NOT g_lsc_extra_exists EXIT ENDIF
    SET_VEHICLE_EXTRA(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_extra + 1, g_lsc_extra_on)
    REFRESH_EXTRA_PROBE()
ENDPROC

// All 12 extras on or off.  Absent slots are skipped, so the loop can never
// write an extra the car does not carry.
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
        CASE 0 DRAW_OPTION(y, TR("Livery", "Cubierta", "涂装", "Design", "ペイントジョブ", "Раскраска", "Estampa", "Motif"), LIVERY_TEXT(), g_item = index, 3) BREAK
        CASE 1 DRAW_OPTION(y, TR("Livery Count", "Cantidad de cubiertas", "涂装数量", "Design-Anzahl", "ペイント数", "Кол-во раскрасок", "Total de Estampas", "Nombre de motifs"), LIVERY_COUNT_TEXT(), g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Livery Name", "Nombre de cubierta", "涂装名称", "Design-Name", "ペイント名", "Имя раскраски", "Nome da Estampa", "Nom du motif"), LIVERY_NAME_TEXT(), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Apply Livery", "Aplicar cubierta", "应用涂装", "Design anwenden", "ペイントを適用", "Применить раскраску", "Aplicar Estampa", "Appliquer motif"), "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Extra Slot", "Ranura de extra", "配件槽位", "Extra-Slot", "エクストラスロット", "Слот экстры", "Slot de Extra", "Emplacement extra"), EXTRA_SLOT_TEXT(), g_item = index, 3) BREAK
        CASE 5 DRAW_OPTION(y, TR("Extra Fitted", "Extra disponible", "配件存在状态", "Extra vorhanden", "エクストラ有無", "Наличие экстры", "Extra Presente", "Extra présent"), EXTRA_FITTED_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Extra State", "Estado del extra", "配件开关状态", "Extra-Status", "エクストラ状態", "Состояние экстры", "Estado do Extra", "État de l'extra"), EXTRA_STATE_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Toggle This Extra", "Alternar este extra", "切换此配件", "Dieses Extra umschalten", "このエクストラを切替", "Переключить экстру", "Alternar Este Extra", "Basculer cet extra"), "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Fit All Extras", "Instalar todos los extras", "开启全部配件", "Alle Extras montieren", "全エクストラを装着", "Включить все экстры", "Ativar Todos os Extras", "Activer tous les extras"), "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, TR("Remove All Extras", "Quitar todos los extras", "移除全部配件", "Alle Extras entfernen", "全エクストラを解除", "Снять все экстры", "Remover Todos os Extras", "Retirer tous les extras"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_LSC_EXTRAS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("EXTRAS AND LIVERY", "EXTRAS Y CUBIERTA", "配件与涂装", "EXTRAS & DESIGN", "エクストラ＆ペイント", "ЭКСТРЫ И РАСКРАСКА", "EXTRAS E ESTAMPA", "EXTRAS ET MOTIF"))
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Extras & Livery", "Extras y cubierta", "配件与涂装", "Extras & Design", "エクストラ＆ペイント", "Экстры и раскраска", "Extras e Estampa", "Extras et motif"), "NO VEHICLE", g_item = 0, 0)
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
// ===========================================================================
// LS Customs depth - Bennys & Lowriders page (v0.9.9)
//
// The discoverability half of the lowrider work.  Before this page the only route
// to the cars that can take a lowrider kit was to scroll every DLC entry in the
// spawner - and of the twelve, only SABREGT2 and SLAMVAN3 appeared anywhere in
// this menu's curated lists at all.  The other ten were unreachable unless you
// already knew the model name.
//
// Every model here comes from BENNYS_CUSTOM_MODEL (Rockstar's own table - see the
// note at the top of this file).  Availability is asked at runtime with
// IS_MODEL_IN_CDIMAGE / IS_MODEL_VALID, so a model this port does not ship draws
// as unavailable and its row refuses instead of requesting a model that is not
// there.
// ===========================================================================

// Row value: SPAWN only when this build really has the model.  Nothing here
// assumes the lowrider DLC packs are present - the port's contents are asked, not
// inferred from the fact that the identifier compiles.
FUNC STRING BENNYS_ROW_TEXT(INT index)
    IF NOT IS_MODEL_IN_CDIMAGE(BENNYS_CUSTOM_MODEL(index)) RETURN TR("< Absent >", "< Ausente >", "< 缺失 >", "< Fehlt >", "< 未収録 >", "< Отсутствует >", "< Ausente >", "< Absent >") ENDIF
    IF NOT IS_MODEL_VALID(BENNYS_CUSTOM_MODEL(index)) RETURN TR("< Unavailable >", "< No disponible >", "< 不可用 >", "< Nicht verfügbar >", "< 利用不可 >", "< Недоступно >", "< Indisponível >", "< Indisponible >") ENDIF
    RETURN TR("SPAWN", "GENERAR", "生成", "SPAWNEN", "出現", "СОЗДАТЬ", "GERAR", "FAIRE APPARAÎTRE")
ENDFUNC

// Spawns the selected car through the existing, hardware-proven spawn path
// (START_VEHICLE_MODEL_SPAWN + FINISH_SELECTED_VEHICLE_SPAWN) instead of a second
// copy of it: the asynchronous model request with its timeout, the formation
// offset, honouring "TP in Spawned Vehicle" and the custom-car tracking all come
// with it.
//
// An absent model is refused before anything is requested.
PROC APPLY_BENNYS_SPAWN()
    // The highlighted row IS the choice on this page: every row is one car and
    // the draw proc marks the highlighted row with g_item, so there is no separate
    // selector global to drift out of step with what is drawn.
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
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("BENNYS AND LOWRIDERS", "BENNY'S Y LOWRIDERS", "班尼车坊与低底盘车", "BENNY'S & LOWRIDER", "ベニーズ＆ローライダー", "BENNY'S И ЛОУРАЙДЕРЫ", "BENNY'S E LOWRIDERS", "BENNY'S ET LOWRIDERS"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_bennys_scroll
    INT row = 0
    WHILE row < 8 AND index < BENNYS_MENU_ROWS
        DRAW_BENNYS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

// Hydraulics readback for the Support Check page.  IS_TOGGLE_MOD_ON is the native
// SYNC_LSC_VEHICLE_STATE already uses, so this page and the Hydraulics page can
// never report a different fitted state.
FUNC STRING HYDRO_FITTED_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF IS_TOGGLE_MOD_ON(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), MOD_TOGGLE_HYDRAULICS) RETURN TR("< Fitted >", "< Instalado >", "< 已安装 >", "< Montiert >", "< 装着済 >", "< Установлено >", "< Instalado >", "< Installé >") ENDIF
    RETURN TR("< Not Fitted >", "< No instalado >", "< 未安装 >", "< Nicht montiert >", "< 未装着 >", "< Не установлено >", "< Não Instalado >", "< Non installé >")
ENDFUNC

FUNC STRING HYDRO_READY_TEXT()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN TR("< No Vehicle >", "< Sin vehículo >", "< 无载具 >", "< Kein Fahrzeug >", "< 車両なし >", "< Нет транспорта >", "< Sem Veículo >", "< Aucun véhicule >") ENDIF
    IF PLAYER_CAR_HAS_HYDRO() RETURN TR("< Yes - Kit Fits >", "< Sí - Admite kit >", "< 是 - 支持套件 >", "< Ja - Kit passt >", "< 可 - キット対応 >", "< Да - Кит подходит >", "< Sim - Aceita Kit >", "< Oui - Kit compatible >") ENDIF
    RETURN TR("< No - Needs Custom >", "< No - Requiere Custom >", "< 否 - 需升级改装版 >", "< Nein - Braucht Custom >", "< 不可 - 要カスタム変換 >", "< Нет - Нужен Custom >", "< Não - Requer Custom >", "< Non - Custom requis >")
ENDFUNC

// ===========================================================================
// LS Customs depth - Vehicle Support Check page (v0.9.9)
//
// Read-only, and deliberately so: it has no apply path and no selector, so there
// is nothing on it that can change the car or the menu.  It answers "why does
// nothing on the Hydraulics page work", and it answers the two questions that
// decide whether the lowrider feature set can work here at all:
//
//   * does this car carry a lowrider kit  -> Lowrider Slots / Hydraulics Ready
//   * does this build ship the custom variant -> Custom Variant / Built From
//
// Every value is a live native readback or a count taken from the same helper the
// page it explains uses (INTERIOR_SLOT list, LSC_KIT_* helpers, HYDRO_SUPPORTED),
// so this page cannot drift away from the pages it is explaining.  If this build
// ships none of the custom models the honest answer appears here as
// "< None For This Car >" rather than a promise.
// ===========================================================================

PROC DRAW_SUPPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF PLAYER_CAR_HAS_HYDRO() DRAW_OPTION(y, TR("Lowrider Support", "Soporte Lowrider", "低底盘车支持", "Lowrider-Unterstützung", "ローライダー対応", "Поддержка лоурайдера", "Suporte Lowrider", "Support lowrider"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 1) ELSE DRAW_OPTION(y, TR("Lowrider Support", "Soporte Lowrider", "低底盘车支持", "Lowrider-Unterstützung", "ローライダー対応", "Поддержка лоурайдера", "Suporte Lowrider", "Support lowrider"), LOWRIDER_SUPPORT_TEXT(), g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, TR("Hydraulics Ready", "Listo para hidráulica", "液压就绪", "Hydraulik-bereit", "ハイドロ対応可否", "Готовность к гидравлике", "Pronto p/ Hidráulica", "Prêt pour hydraulique"), HYDRO_READY_TEXT(), g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Hydraulics Fitted", "Hidráulica instalada", "已安装液压", "Hydraulik montiert", "ハイドロ装着状態", "Гидравлика установлена", "Hidráulica Instalada", "Hydraulique installée"), HYDRO_FITTED_TEXT(), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("This Car", "Este vehículo", "当前载具", "Dieses Auto", "現在の車両", "Этот транспорт", "Este Veículo", "Ce véhicule"), VEHICLE_MODEL_NAME_TEXT(LSC_PLAYER_VEHICLE_MODEL()), g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Custom Variant", "Variante Custom", "改装版型号", "Custom-Variante", "カスタム仕様", "Кастом-вариант", "Variante Custom", "Variante Custom"), BENNYS_VARIANT_TEXT(), g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Built From", "Basado en", "原厂原型车", "Basismodell", "ベース車両", "Базовая модель", "Baseado em", "Basé sur"), BENNYS_BASE_TEXT(), g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Mod Kits", "Kits de mod", "改装套件数", "Mod-Kits", "改造キット数", "Мод-киты", "Kits de Mod", "Kits de mod"), LSC_KIT_COUNT_TEXT(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Active Kit", "Kit activo", "当前套件", "Aktives Kit", "有効キット", "Активный кит", "Kit Ativo", "Kit actif"), LSC_KIT_INDEX_TEXT(), g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Kit Type", "Tipo de kit", "套件类型", "Kit-Typ", "キットタイプ", "Тип кита", "Tipo de Kit", "Type de kit"), LSC_KIT_TYPE_TEXT(), g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, TR("Lowrider Slots", "Ranuras Lowrider", "低底盘槽位数", "Lowrider-Slots", "ローライダースロット", "Слоты лоурайдера", "Slots Lowrider", "Emplacements lowrider"), LOWRIDER_SLOT_TEXT(), g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SUPPORT_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("VEHICLE SUPPORT", "SOPORTE DE VEHÍCULO", "载具支持检查", "FAHRZEUG-SUPPORT", "車両対応チェック", "ПОДДЕРЖКА ТРАНСПОРТА", "SUPORTE DO VEÍCULO", "SUPPORT VÉHICULE"))
    DRAW_MENU_VERSION_TAG()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(0.268, TR("Vehicle Support", "Soporte de vehículo", "载具支持", "Fahrzeug-Support", "車両対応", "Поддержка транспорта", "Suporte do Veículo", "Support véhicule"), "NO VEHICLE", g_item = 0, 0)
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

