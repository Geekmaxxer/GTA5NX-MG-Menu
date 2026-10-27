PROC MENU_TEXT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y + g_menu_y)
ENDPROC

PROC MENU_TEXT_RIGHT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, x)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_MENU_VERSION_TAG()
    MENU_TEXT_RIGHT(g_menu_x + 0.105, 0.198, 0.270, 255, 255, 255, g_menu_version)
ENDPROC

// Single funnel for every menu press sound. There were twelve raw
// PLAY_SOUND_FRONTEND calls scattered across ragemenu.sc and submenus_all.sch;
// routing them through here costs nothing, removes the duplication, and - the
// reason it exists - lets the frame-time probe time the one native call that
// fires on literally every press. An unloaded soundset would stall inside that
// native, and "hitches whenever I press something" is exactly what that looks
// like, so this was one of the two candidates the probe had to be able to
// separate.
PROC MENU_PLAY_SOUND(STRING soundName)
    // g_prof_sound_t0, not g_prof_t0: this runs inside the main-loop iteration,
    // and g_prof_t0 has to stay pinned to the start of that iteration for the
    // "Worst Script MS" calculation at the bottom of the loop.
    g_prof_sound_t0 = GET_GAME_TIMER()
    PLAY_SOUND_FRONTEND(-1, soundName, "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
    g_prof_t1 = GET_GAME_TIMER() - g_prof_sound_t0
    g_prof_sound_count = g_prof_sound_count + 1
    IF g_prof_t1 > g_prof_worst_sound
        g_prof_worst_sound = g_prof_t1
    ENDIF
ENDPROC

// The stock instructional-buttons scaleform gives us the same compact,
// controller-aware prompts used by RageMenu.  It is drawn independently of
// the menu rectangle, so the menu dimensions never need to grow for hints.
// Scaleform data slots are cached so CLEAR_ALL and SET_DATA_SLOT only run
// when the required layout or language changes, saving ~1.5-2.0ms per frame.
PROC DRAW_INSTRUCTIONAL_BUTTONS()
    IF NOT g_show_instructional_buttons
        EXIT
    ENDIF
    IF g_instructional_scaleform = NULL
        g_instructional_scaleform = REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS")
    ENDIF
    IF NOT HAS_SCALEFORM_MOVIE_LOADED(g_instructional_scaleform)
        EXIT
    ENDIF
    INT wantedMode = 0
    IF NOT g_home AND g_tab = 7 AND g_credits_open
        wantedMode = 1
    ENDIF
    IF g_instructional_buttons_mode != wantedMode OR g_instructional_cached_lang != g_menu_language
        g_instructional_buttons_mode = wantedMode
        g_instructional_cached_lang = g_menu_language
        BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "TOGGLE_MOUSE_BUTTONS")
            SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(TRUE)
        END_SCALEFORM_MOVIE_METHOD()
        CALL_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "CLEAR_ALL")
        IF wantedMode = 1
            BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(0)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL, TRUE))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(TR("Back", "Atrás", "返回", "Zurück", "戻る", "Назад", "Voltar", "Retour"))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUT_FRONTEND_CANCEL))
            END_SCALEFORM_MOVIE_METHOD()
            BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(1)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUTGROUP_FRONTEND_DPAD_ALL, TRUE))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(TR("Move", "Mover", "移动", "Bewegen", "移動", "Движение", "Mover", "Déplacer"))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUTGROUP_FRONTEND_DPAD_ALL))
            END_SCALEFORM_MOVIE_METHOD()
        ELSE
            BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(0)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(TR("Select", "Seleccionar", "选择", "Auswählen", "選択", "Выбрать", "Selecionar", "Sélectionner"))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUT_FRONTEND_ACCEPT))
            END_SCALEFORM_MOVIE_METHOD()
            BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(1)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL, TRUE))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(TR("Back", "Atrás", "返回", "Zurück", "戻る", "Назад", "Voltar", "Retour"))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUT_FRONTEND_CANCEL))
            END_SCALEFORM_MOVIE_METHOD()
            BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "SET_DATA_SLOT")
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(2)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(FRONTEND_CONTROL, INPUTGROUP_FRONTEND_DPAD_ALL, TRUE))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(TR("Move", "Mover", "移动", "Bewegen", "移動", "Движение", "Mover", "Déplacer"))
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(FALSE)
                SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(ENUM_TO_INT(INPUTGROUP_FRONTEND_DPAD_ALL))
            END_SCALEFORM_MOVIE_METHOD()
        ENDIF
        BEGIN_SCALEFORM_MOVIE_METHOD(g_instructional_scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        END_SCALEFORM_MOVIE_METHOD()
    ENDIF
    DRAW_SCALEFORM_MOVIE_FULLSCREEN(g_instructional_scaleform, 255, 255, 255, 220, 0)
ENDPROC

// BEGIN SHARED DESCRIPTION RENDERER
// The target HUD stores 99 UTF-8 bytes per text component, even for PLAYER_NAME.
// Keep each cached component inside a TEXT_LABEL_63 without splitting a character.
// All current localized descriptions fit within five of these ten slots.
PROC APPEND_DESCRIPTION_COMPONENTS()
    INT component = 0
    WHILE component < g_description_chunk_count
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_description_chunks[component])
        component = component + 1
    ENDWHILE
ENDPROC

PROC SET_DESCRIPTION_STYLE()
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(g_description_scale, g_description_scale)
    SET_TEXT_CENTRE(FALSE)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_WRAP(g_menu_x - 0.130, g_menu_x + 0.105)
ENDPROC

PROC PREPARE_DESCRIPTION_LAYOUT(STRING value)
    IF IS_STRING_NULL_OR_EMPTY(value)
        g_description_layout_valid = FALSE
        g_description_cached_value = ""
        g_description_chunk_count = 0
        g_description_lines = 0
        g_description_height = 0.0
        EXIT
    ENDIF
    INT totalCharacters = 0
    INT characterOffset = 0
    INT copiedCharacters = 0
    INT attempt = 0
    FLOAT lineHeight = 0.024
    FLOAT availableHeight = 0.98 - (0.593 + g_menu_y)
    TEXT_LABEL_63 piece = ""
    IF g_description_layout_valid AND g_description_cached_language = g_menu_language AND g_description_cached_x = g_menu_x AND g_description_cached_y = g_menu_y
        IF ARE_STRINGS_EQUAL(value, g_description_cached_value) EXIT ENDIF
    ENDIF
    g_description_layout_valid = TRUE
    g_description_cached_value = value
    g_description_cached_language = g_menu_language
    g_description_cached_x = g_menu_x
    g_description_cached_y = g_menu_y
    g_description_chunk_count = 0
    g_description_lines = 0
    g_description_height = 0.0
    g_description_scale = 0.3
    totalCharacters = GET_LENGTH_OF_LITERAL_STRING(value)
    WHILE characterOffset < totalCharacters AND g_description_chunk_count < 10
        piece = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME_WITH_BYTE_LIMIT(value, characterOffset, totalCharacters, 56)
        copiedCharacters = GET_LENGTH_OF_LITERAL_STRING(piece)
        IF copiedCharacters <= 0 EXIT ENDIF
        g_description_chunks[g_description_chunk_count] = piece
        g_description_chunk_count = g_description_chunk_count + 1
        characterOffset = characterOffset + copiedCharacters
    ENDWHILE
    // Measure precisely what we draw using CELL_EMAIL_BCON (10 ~a~ components).
    // The previous STRING label only had a single ~a~ and truncated chunks 1-9.
    WHILE attempt < 4
        SET_DESCRIPTION_STYLE()
        BEGIN_TEXT_COMMAND_GET_NUMBER_OF_LINES_FOR_STRING("CELL_EMAIL_BCON")
            APPEND_DESCRIPTION_COMPONENTS()
        g_description_lines = END_TEXT_COMMAND_GET_NUMBER_OF_LINES_FOR_STRING(g_menu_x - 0.130, 0.594 + g_menu_y)
        IF g_description_lines < 1 g_description_lines = 1 ENDIF
        lineHeight = GET_RENDERED_CHARACTER_HEIGHT(g_description_scale, FONT_STANDARD)
        IF lineHeight <= 0.0 OR lineHeight > 0.1 lineHeight = 0.024 ENDIF
        g_description_height = (TO_FLOAT(g_description_lines) * lineHeight) + 0.012
        IF g_description_height < 0.034 g_description_height = 0.034 ENDIF
        IF g_description_height <= availableHeight EXIT ENDIF
        IF attempt >= 3 EXIT ENDIF
        IF g_description_scale <= 0.24 EXIT ENDIF
        g_description_scale = g_description_scale - 0.02
        attempt = attempt + 1
    ENDWHILE
ENDPROC

PROC MENU_DESCRIPTION_TEXT(STRING value)
    PREPARE_DESCRIPTION_LAYOUT(value)
    IF g_description_chunk_count <= 0 EXIT ENDIF
    SET_DESCRIPTION_STYLE()
    SET_TEXT_COLOUR(205, 212, 220, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 150)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("CELL_EMAIL_BCON")
        APPEND_DESCRIPTION_COMPONENTS()
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.130, 0.594 + g_menu_y)
ENDPROC

FUNC FLOAT DESCRIPTION_PANEL_HEIGHT(STRING value)
    PREPARE_DESCRIPTION_LAYOUT(value)
    RETURN g_description_height
ENDFUNC
// END SHARED DESCRIPTION RENDERER

FUNC INT CORE_NSC_ACTIVE_COUNT()
    INT count = 0
    INT i = 0
    WHILE i < g_nsc_discovered_count
        IF g_nsc_is_active[i]
            count = count + 1
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN count
ENDFUNC

// The selected text is published through g_selected_description (see
// core_globals.sch): STRING params are copy-on-write for text commands, so a
// helper PROC cannot return the text through its own parameter.
PROC SELECTED_DESCRIPTION_TEXT()
    g_selected_description = ""
    IF g_home
        SWITCH g_item
            CASE 0 g_selected_description = TR("Player abilities, appearance, and character tools.", "Habilidades del jugador, apariencia y herramientas del personaje.", "玩家能力、外观和角色工具。", "Spielerfähigkeiten, Aussehen und Charakter-Werkzeuge.", "プレイヤーの能力、外見、キャラクターツール。", "Способности игрока, внешность и инструменты персонажа.", "Habilidades do jogador, aparência e ferramentas do personagem.", "Capacités du joueur, apparence et outils du personnage.") BREAK
            CASE 1 g_selected_description = TR("Give, refill, and modify your weapons and ammunition.", "Obtén, recarga y modifica tus armas y munición.", "获取、补充和改装你的武器与弹药。", "Waffen und Munition geben, auffüllen und modifizieren.", "武器や弾薬の入手、補充、改造を行います。", "Выдача, пополнение и модификация оружия и боеприпасов.", "Obtenha, recarregue e modifique suas armas e munições.", "Donner, recharger et modifier vos armes et munitions.") BREAK
            CASE 2 g_selected_description = TR("Control wanted level, police behavior, and dispatch.", "Controla el nivel de búsqueda, la policía y los refuerzos.", "控制通缉等级、警察行为和警力派遣。", "Fahndungslevel, Polizeiverhalten und Einsatzkräfte steuern.", "手配度、警察の行動、出動を制御します。", "Управление уровнем розыска, поведением полиции и диспетчером.", "Controle o nível de procurado, o comportamento policial e as viaturas.", "Contrôler l'indice de recherche, le comportement de la police et les renforts.") BREAK
            CASE 3 g_selected_description = TR("Spawn, enter, repair, and customize vehicles.", "Genera, entra, repara y personaliza vehículos.", "生成、进入、修理和改装载具。", "Fahrzeuge spawnen, betreten, reparieren und anpassen.", "乗り物の出現、乗車、修理、カスタマイズを行います。", "Создание, посадка, ремонт и тюнинг транспорта.", "Gere, entre, repare e personalize veículos.", "Faire apparaître, entrer, réparer et personnaliser des véhicules.") BREAK
            CASE 4 g_selected_description = TR("Change time, weather, vision, and camera effects.", "Cambia la hora, el clima, la visión y los efectos de cámara.", "更改时间、天气、视觉和镜头效果。", "Zeit, Wetter, Sicht und Kameraeffekte ändern.", "時間、天候、ビジョン、カメラ効果を変更します。", "Изменение времени, погоды, зрения и эффектов камеры.", "Altere horário, clima, visão e efeitos de câmera.", "Changer l'heure, la météo, la vision et les effets de caméra.") BREAK
            CASE 5 g_selected_description = TR("Teleport to map targets and fixed locations.", "Teletranspórtate a destinos del mapa y ubicaciones fijas.", "传送到地图目标和固定地点。", "Zu Kartenzielen und festen Orten teleportieren.", "マップの目標や固定ロケーションへテレポートします。", "Телепортация к меткам на карте и фиксированным местам.", "Teleporte-se para marcadores do mapa e locais fixos.", "Se téléporter vers des cibles de la carte et des lieux fixes.") BREAK
            CASE 6 g_selected_description = TR("World population, NPC, HUD, and phone options.", "Opciones de población, NPC, HUD y teléfono.", "世界人口、NPC、HUD 和手机选项。", "Weltbevölkerung, NPC-, HUD- und Telefonoptionen.", "世界の人口、NPC、HUD、スマートフォンの設定。", "Настройки населения мира, NPC, интерфейса и телефона.", "Opções de população do mundo, NPCs, HUD e celular.", "Options de population, PNJ, HUD et téléphone.") BREAK
            CASE 7 g_selected_description = TR("Menu colors, position, and custom respawn behavior.", "Colores del menú, posición y reaparición personalizada.", "菜单颜色、位置和自定义重生行为。", "Menüfarben, Position und eigenes Respawn-Verhalten.", "メニューの色、位置、カスタムリスポーンの挙動。", "Цвета меню, позиция и настройка возрождения.", "Cores do menu, posição e comportamento de renascimento.", "Couleurs du menu, position et réapparition personnalisée.") BREAK
        ENDSWITCH
    ELIF g_outfit_open
        g_selected_description = TR("Cycle the selected clothing slot with Left/Right; press A to change its texture.", "Cambia la prenda seleccionada con Izquierda/Derecha; pulsa A para cambiar la textura.", "用左/右方向键切换所选服装槽位；按 A 更换纹理。", "Ausgewählten Kleidungsslot mit Links/Rechts wechseln; A drücken, um die Textur zu ändern.", "左右で選択中の服装スロットを切り替え、Aでテクスチャを変更します。", "Влево/Вправо меняет предмет одежды; нажмите A для смены текстуры.", "Alterne o espaço de roupa com Esquerda/Direita; pressione A para mudar a textura.", "Parcourez l'emplacement de vêtement avec Gauche/Droite ; appuyez sur A pour changer sa texture.")
    ELIF g_radio_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Displays the currently tuned radio station.", "Muestra la emisora de radio sintonizada actualmente.", "显示当前收听的广播电台。", "Zeigt den aktuell eingestellten Radiosender an.", "現在受信中のラジオ局を表示します。", "Отображает текущую настроенную радиостанцию.", "Exibe a estação de rádio sintonizada atualmente.", "Affiche la station de radio actuellement syntonisée.") BREAK
            CASE 1 g_selected_description = TR("Enable portable radio control while on foot.", "Activa el control de la radio portátil a pie.", "在步行时启用随身电台控制。", "Tragbare Radiosteuerung zu Fuß aktivieren.", "徒歩中のポータブルラジオ操作を有効にします。", "Включить управление переносным радио пешком.", "Ativar o controle do rádio portátil a pé.", "Activer le contrôle de la radio portable à pied.") BREAK
            CASE 2 g_selected_description = TR("Tune the radio to the previous station.", "Sintoniza la emisora de radio anterior.", "将电台调到上一个频道。", "Radio auf den vorherigen Sender einstellen.", "前のラジオ局に合わせます。", "Переключить радио на предыдущую станцию.", "Sintonizar o rádio na estação anterior.", "Syntoniser la station de radio précédente.") BREAK
            CASE 3 g_selected_description = TR("Tune the radio to the next station.", "Sintoniza la siguiente emisora de radio.", "将电台调到下一个频道。", "Radio auf den nächsten Sender einstellen.", "次のラジオ局に合わせます。", "Переключить радио на следующую станцию.", "Sintonizar o rádio na próxima estação.", "Syntoniser la station de radio suivante.") BREAK
        ENDSWITCH
    ELIF g_bodyguard_open
        IF g_guard_ped_open
            IF g_item = 0 g_selected_description = TR("Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!", "Busca por nombre de modelo PED; sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按 PED 模型名称搜索；严格区分大小写，请务必使用大写字母！", "Nach PED-Modellnamen suchen; extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "PEDモデル名で検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Поиск по имени модели PED; чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Pesquise pelo nome do modelo PED; diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Rechercher par nom de modèle PED ; très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") ENDIF
            IF g_item = 1 g_selected_description = TR("Pick a random validated PED model for bodyguards.", "Elige un modelo PED aleatorio validado para los guardaespaldas.", "为保镖随机选择一个已验证的 PED 模型。", "Wählt ein zufälliges geprüftes PED-Modell für Bodyguards.", "ボディガード用に検証済みのランダムなPEDモデルを選択します。", "Выбрать случайную проверенную модель PED для телохранителей.", "Escolha um modelo PED aleatório validado para os guarda-costas.", "Choisir un modèle PED aléatoire validé pour les gardes du corps.") ENDIF
            IF g_item > 1 g_selected_description = TR("Use the selected PED model for spawned bodyguards.", "Usa el modelo PED seleccionado para los guardaespaldas generados.", "将所选 PED 模型用于生成的保镖。", "Das gewählte PED-Modell für gespawnte Bodyguards verwenden.", "選択したPEDモデルを出現させるボディガードに使用します。", "Использовать выбранную модель PED для создаваемых телохранителей.", "Usar o modelo PED selecionado para os guarda-costas gerados.", "Utiliser le modèle PED sélectionné pour les gardes du corps générés.") ENDIF
        ELSE
            IF g_bodyguard_tp_too_far
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Spawn one armed bodyguard next to the player.", "Genera un guardaespaldas armado junto al jugador.", "在玩家旁边生成一名武装保镖。", "Einen bewaffneten Bodyguard neben dem Spieler spawnen.", "プレイヤーの隣に武装したボディガードを1人出現させます。", "Создать одного вооруженного телохранителя рядом с игроком.", "Gera um guarda-costas armado ao lado do jogador.", "Faire apparaître un garde du corps armé à côté du joueur.") BREAK
                    CASE 1 g_selected_description = TR("Open the bodyguard PED list; shows the current model.", "Abre la lista de PED de guardaespaldas; muestra el modelo actual.", "打开保镖 PED 列表；显示当前模型。", "PED-Liste für Bodyguards öffnen; zeigt das aktuelle Modell.", "ボディガードのPEDリストを開きます（現在のモデルを表示）。", "Открыть список PED телохранителей; показывает текущую модель.", "Abre a lista de PEDs de guarda-costas; mostra o modelo atual.", "Ouvrir la liste des PED de gardes du corps ; affiche le modèle actuel.") BREAK
                    CASE 2 g_selected_description = TR("Choose the weapon given to spawned bodyguards.", "Elige el arma que recibirán los guardaespaldas generados.", "选择配备给生成保镖的武器。", "Die Waffe für gespawnte Bodyguards auswählen.", "出現するボディガードに持たせる武器を選択します。", "Выбрать оружие для создаваемых телохранителей.", "Escolha a arma entregue aos guarda-costas gerados.", "Choisir l'arme donnée aux gardes du corps générés.") BREAK
                    CASE 3 g_selected_description = TR("Choose how bodyguards position around the player.", "Elige cómo se posicionan los guardaespaldas alrededor del jugador.", "选择保镖在玩家周围的队形。", "Formation der Bodyguards um den Spieler wählen.", "プレイヤー周囲でのボディガードの陣形を選択します。", "Выбрать построение телохранителей вокруг игрока.", "Escolha como os guarda-costas se posicionam ao redor do jogador.", "Choisir la formation des gardes du corps autour du joueur.") BREAK
                    CASE 4 g_selected_description = TR("Make every bodyguard follow the player in formation.", "Haz que todos los guardaespaldas sigan al jugador en formación.", "让所有保镖保持队形跟随玩家。", "Alle Bodyguards folgen dem Spieler in Formation.", "すべてのボディガードに陣形を保ってプレイヤーを追従させます。", "Приказать всем телохранителям следовать за игроком в строю.", "Faz todos os guarda-costas seguirem o jogador em formação.", "Faire suivre le joueur en formation par tous les gardes du corps.") BREAK
                    CASE 5 g_selected_description = TR("Allow bodyguards to enter and ride in your vehicle.", "Permite que los guardaespaldas entren y viajen en tu vehículo.", "允许保镖进入并乘坐你的载具。", "Erlaube Bodyguards, in dein Fahrzeug einzusteigen.", "ボディガードがあなたの車両に乗車することを許可します。", "Разрешить телохранителям садиться в ваш транспорт.", "Permite que os guarda-costas entrem no seu veículo.", "Autoriser les gardes du corps à monter dans votre véhicule.") BREAK
                    CASE 6 g_selected_description = TR("Teleport bodyguards to your location if they fall too far behind.", "Teletransporta a los guardaespaldas si se quedan muy atrás.", "如果保镖落后太远，将其传送到你的位置。", "Teleportiert Bodyguards zu dir, wenn sie zu weit zurückfallen.", "ボディガードが離れすぎた場合、あなたの位置へテレポートします。", "Телепортировать телохранителей к вам, если они отстали.", "Teleporta os guarda-costas para perto se ficarem longe.", "Téléporter les gardes du corps vers vous s'ils sont trop loin.") BREAK
                    CASE 7 g_selected_description = TR("Distance in meters before bodyguards teleport to you. Left/Right or A to type.", "Distancia en metros para teletransportar guardias. Izq/Der o A para escribir.", "保镖传送到你身边的距离（米）。按左/右或按 A 输入。", "Distanz in Metern für Bodyguard-Teleport. Links/Rechts oder A zum Tippen.", "テレポートする距離（メートル）。左右で変更、Aで入力。", "Дистанция в метрах для телепортации. Влево/Вправо или A для ввода.", "Distância em metros para teleporte dos guardas. Esq/Dir ou A para digitar.", "Distance en mètres pour téléporter les gardes. Gauche/Droite ou A pour saisir.") BREAK
                    CASE 8 g_selected_description = TR("Show or hide bodyguard map blips for new guards.", "Muestra u oculta los iconos del mapa para nuevos guardaespaldas.", "为新保镖显示或隐藏地图标记。", "Kartenmarkierungen für neue Bodyguards ein- oder ausblenden.", "新しいボディガードのマップアイコンを表示または非表示にします。", "Показать или скрыть метки на карте для новых телохранителей.", "Mostrar ou ocultar ícones no mapa para novos guarda-costas.", "Afficher ou masquer les icônes sur la carte pour les nouveaux gardes.") BREAK
                    CASE 9 g_selected_description = TR("Make every spawned bodyguard invincible.", "Haz invencibles a todos los guardaespaldas generados.", "让所有生成的保镖处于无敌状态。", "Alle gespawnten Bodyguards unverwundbar machen.", "出現させたすべてのボディガードを無敵にします。", "Сделать всех созданных телохранителей неуязвимыми.", "Tornar todos os guarda-costas gerados invencíveis.", "Rendre invincibles tous les gardes du corps générés.") BREAK
                    CASE 10 g_selected_description = TR("Remove every spawned bodyguard.", "Elimina a todos los guardaespaldas generados.", "移除所有已生成的保镖。", "Alle gespawnten Bodyguards entfernen.", "出現させたすべてのボディガードを消去します。", "Удалить всех созданных телохранителей.", "Remover todos os guarda-costas gerados.", "Supprimer tous les gardes du corps générés.") BREAK
                ENDSWITCH
            ELSE
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Spawn one armed bodyguard next to the player.", "Genera un guardaespaldas armado junto al jugador.", "在玩家旁边生成一名武装保镖。", "Einen bewaffneten Bodyguard neben dem Spieler spawnen.", "プレイヤーの隣に武装したボディガードを1人出現させます。", "Создать одного вооруженного телохранителя рядом с игроком.", "Gera um guarda-costas armado ao lado do jogador.", "Faire apparaître un garde du corps armé à côté du joueur.") BREAK
                    CASE 1 g_selected_description = TR("Open the bodyguard PED list; shows the current model.", "Abre la lista de PED de guardaespaldas; muestra el modelo actual.", "打开保镖 PED 列表；显示当前模型。", "PED-Liste für Bodyguards öffnen; zeigt das aktuelle Modell.", "ボディガードのPEDリストを開きます（現在のモデルを表示）。", "Открыть список PED телохранителей; показывает текущую модель.", "Abre a lista de PEDs de guarda-costas; mostra o modelo atual.", "Ouvrir la liste des PED de gardes du corps ; affiche le modèle actuel.") BREAK
                    CASE 2 g_selected_description = TR("Choose the weapon given to spawned bodyguards.", "Elige el arma que recibirán los guardaespaldas generados.", "选择配备给生成保镖的武器。", "Die Waffe für gespawnte Bodyguards auswählen.", "出現するボディガードに持たせる武器を選択します。", "Выбрать оружие для создаваемых телохранителей.", "Escolha a arma entregue aos guarda-costas gerados.", "Choisir l'arme donnée aux gardes du corps générés.") BREAK
                    CASE 3 g_selected_description = TR("Choose how bodyguards position around the player.", "Elige cómo se posicionan los guardaespaldas alrededor del jugador.", "选择保镖在玩家周围的队形。", "Formation der Bodyguards um den Spieler wählen.", "プレイヤー周囲でのボディガードの陣形を選択します。", "Выбрать построение телохранителей вокруг игрока.", "Escolha como os guarda-costas se posicionam ao redor do jogador.", "Choisir la formation des gardes du corps autour du joueur.") BREAK
                    CASE 4 g_selected_description = TR("Make every bodyguard follow the player in formation.", "Haz que todos los guardaespaldas sigan al jugador en formación.", "让所有保镖保持队形跟随玩家。", "Alle Bodyguards folgen dem Spieler in Formation.", "すべてのボディガードに陣形を保ってプレイヤーを追従させます。", "Приказать всем телохранителям следовать за игроком в строю.", "Faz todos os guarda-costas seguirem o jogador em formação.", "Faire suivre le joueur en formation par tous les gardes du corps.") BREAK
                    CASE 5 g_selected_description = TR("Allow bodyguards to enter and ride in your vehicle.", "Permite que los guardaespaldas entren y viajen en tu vehículo.", "允许保镖进入并乘坐你的载具。", "Erlaube Bodyguards, in dein Fahrzeug einzusteigen.", "ボディガードがあなたの車両に乗車することを許可します。", "Разрешить телохранителям садиться в ваш транспорт.", "Permite que os guarda-costas entrem no seu veículo.", "Autoriser les gardes du corps à monter dans votre véhicule.") BREAK
                    CASE 6 g_selected_description = TR("Teleport bodyguards to your location if they fall too far behind.", "Teletransporta a los guardaespaldas si se quedan muy atrás.", "如果保镖落后太远，将其传送到你的位置。", "Teleportiert Bodyguards zu dir, wenn sie zu weit zurückfallen.", "ボディガードが離れすぎた場合、あなたの位置へテレポートします。", "Телепортировать телохранителей к вам, если они отстали.", "Teleporta os guarda-costas para perto se ficarem longe.", "Téléporter les gardes du corps vers vous s'ils sont trop loin.") BREAK
                    CASE 7 g_selected_description = TR("Show or hide bodyguard map blips for new guards.", "Muestra u oculta los iconos del mapa para nuevos guardaespaldas.", "为新保镖显示或隐藏地图标记。", "Kartenmarkierungen für neue Bodyguards ein- oder ausblenden.", "新しいボディガードのマップアイコンを表示または非表示にします。", "Показать или скрыть метки на карте для новых телохранителей.", "Mostrar ou ocultar ícones no mapa para novos guarda-costas.", "Afficher ou masquer les icônes sur la carte pour les nouveaux gardes.") BREAK
                    CASE 8 g_selected_description = TR("Make every spawned bodyguard invincible.", "Haz invencibles a todos los guardaespaldas generados.", "让所有生成的保镖处于无敌状态。", "Alle gespawnten Bodyguards unverwundbar machen.", "出現させたすべてのボディガードを無敵にします。", "Сделать всех созданных телохранителей неуязвимыми.", "Tornar todos os guarda-costas gerados invencíveis.", "Rendre invincibles tous les gardes du corps générés.") BREAK
                    CASE 9 g_selected_description = TR("Remove every spawned bodyguard.", "Elimina a todos los guardaespaldas generados.", "移除所有已生成的保镖。", "Alle gespawnten Bodyguards entfernen.", "出現させたすべてのボディガードを消去します。", "Удалить всех созданных телохранителей.", "Remover todos os guarda-costas gerados.", "Supprimer tous les gardes du corps générés.") BREAK
                ENDSWITCH
            ENDIF
        ENDIF
    ELIF g_attacker_open
        IF g_attacker_ped_open
            IF g_item = 0 g_selected_description = TR("Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!", "Busca por nombre de modelo PED; sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按 PED 模型名称搜索；严格区分大小写，请务必使用大写字母！", "Nach PED-Modellnamen suchen; extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "PEDモデル名で検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Поиск по имени модели PED; чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Pesquise pelo nome do modelo PED; diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Rechercher par nom de modèle PED ; très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") ENDIF
            IF g_item = 1 g_selected_description = TR("Pick a random validated PED model for attackers.", "Elige un modelo PED aleatorio validado para los atacantes.", "为袭击者随机选择一个已验证的 PED 模型。", "Wählt ein zufälliges geprüftes PED-Modell für Angreifer.", "襲撃者用に検証済みのランダムなPEDモデルを選択します。", "Выбрать случайную проверенную модель PED для нападающих.", "Escolha um modelo PED aleatório validado para os atacantes.", "Choisir un modèle PED aléatoire validé pour les assaillants.") ENDIF
            IF g_item > 1 g_selected_description = TR("Use the selected PED model for spawned attackers.", "Usa el modelo PED seleccionado para los atacantes generados.", "将所选 PED 模型用于生成的袭击者。", "Das gewählte PED-Modell für gespawnte Angreifer verwenden.", "選択したPEDモデルを出現させる襲撃者に使用します。", "Использовать выбранную модель PED для создаваемых нападающих.", "Usar o modelo PED selecionado para os atacantes gerados.", "Utiliser le modèle PED sélectionné pour les assaillants générés.") ENDIF
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = TR("Spawn an armed hostile attacker nearby.", "Genera un atacante hostil armado cerca.", "在附近生成一名武装敌对袭击者。", "Einen bewaffneten feindlichen Angreifer in der Nähe spawnen.", "近くに武装した敵対的な襲撃者を出現させます。", "Создать вооруженного враждебного нападающего поблизости.", "Gera um atacante hostil armado por perto.", "Faire apparaître un assaillant hostile armé à proximité.") BREAK
                CASE 1 g_selected_description = TR("Open the attacker PED list; shows the current model.", "Abre la lista de PED de atacantes; muestra el modelo actual.", "打开袭击者 PED 列表；显示当前模型。", "PED-Liste für Angreifer öffnen; zeigt das aktuelle Modell.", "襲撃者のPEDリストを開きます（現在のモデルを表示）。", "Открыть список PED нападающих; показывает текущую модель.", "Abre a lista de PEDs de atacantes; mostra o modelo atual.", "Ouvrir la liste des PED d'assaillants ; affiche le modèle actuel.") BREAK
                CASE 2 g_selected_description = TR("Choose the weapon given to spawned attackers.", "Elige el arma que recibirán los atacantes generados.", "选择配备给生成袭击者的武器。", "Die Waffe für gespawnte Angreifer auswählen.", "出現する襲撃者に持たせる武器を選択します。", "Выбрать оружие для создаваемых нападающих.", "Escolha a arma entregue aos atacantes gerados.", "Choisir l'arme donnée aux assaillants générés.") BREAK
                CASE 3 g_selected_description = TR("ON: attackers fight everyone nearby. OFF: they only attack the player.", "ACT.: los atacantes pelean contra todos. DES.: solo atacan al jugador.", "开：袭击者攻击附近所有人。关：仅攻击玩家。", "EIN: Angreifer bekämpfen jeden in der Nähe. AUS: Sie greifen nur den Spieler an.", "ON: 近くの全員を攻撃します。OFF: プレイヤーのみを攻撃します。", "ВКЛ: нападающие атакуют всех вокруг. ВЫКЛ: атакуют только игрока.", "LIG.: atacantes lutam contra todos por perto. DESL.: atacam apenas o jogador.", "OUI : les assaillants attaquent tout le monde. NON : ils n'attaquent que le joueur.") BREAK
                CASE 4 g_selected_description = TR("Make every spawned attacker invincible.", "Haz invencibles a todos los atacantes generados.", "让所有生成的袭击者处于无敌状态。", "Alle gespawnten Angreifer unverwundbar machen.", "出現させたすべての襲撃者を無敵にします。", "Сделать всех созданных нападающих неуязвимыми.", "Tornar todos os atacantes gerados invencíveis.", "Rendre invincibles tous les assaillants générés.") BREAK
                CASE 5 g_selected_description = TR("Remove every spawned attacker.", "Elimina a todos los atacantes generados.", "移除所有已生成的袭击者。", "Alle gespawnten Angreifer entfernen.", "出現させたすべての襲撃者を消去します。", "Удалить всех созданных нападающих.", "Remover todos os atacantes gerados.", "Supprimer tous les assaillants générés.") BREAK
            ENDSWITCH
        ENDIF
    ELIF g_neon_anim_open
        IF g_neon_mode = 3
            SWITCH g_item
                CASE 0 g_selected_description = TR("Choose the neon animation mode. Left/Right applies it at once.", "Elige el modo de animación de neón. Izquierda/Derecha lo aplica al instante.", "选择霓虹灯动画模式。左/右方向键立即生效。", "Neon-Animationsmodus wählen. Links/Rechts wendet ihn sofort an.", "ネオンのアニメーションモードを選択します。左右で即座に適用されます。", "Выберите режим анимации неона. Влево/Вправо применяет сразу.", "Escolha o modo de animação do neon. Esquerda/Direita aplica na hora.", "Choisir le mode d'animation néon. Gauche/Droite l'applique immédiatement.") BREAK
                CASE 1 g_selected_description = TR("Speed 0.25x to 10.00x. Stopped freezes. Forward only.", "Velocidad de 0.25x a 10.00x. Detenido congela. Solo hacia adelante.", "速度 0.25x 至 10.00x。停止会冻结动画。仅限正向。", "Geschwindigkeit 0.25x bis 10.00x. Gestoppt friert ein. Nur vorwärts.", "速度 0.25x〜10.00x。停止でフリーズ。順方向のみ。", "Скорость от 0.25x до 10.00x. Стоп замораживает. Только вперед.", "Velocidade de 0.25x a 10.00x. Parado congela. Apenas para frente.", "Vitesse de 0.25x à 10.00x. Arrêté fige l'animation. Vers l'avant uniquement.") BREAK
                CASE 2 g_selected_description = TR("Smooth fades or Hard snaps. RGB Cycle only.", "Transiciones suaves o saltos bruscos. Solo en ciclo RGB.", "平滑渐变或硬切跳变。仅限 RGB 循环模式。", "Sanfte Übergänge oder harte Wechsel. Nur für RGB-Zyklus.", "滑らかなフェードか瞬時切り替え。RGBサイクル専用。", "Плавные переходы или резкая смена. Только для цикла RGB.", "Transições suaves ou cortes secos. Apenas para Ciclo RGB.", "Fondus fluides ou changements nets. Cycle RVB uniquement.") BREAK
            ENDSWITCH
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = TR("Choose the neon animation mode. Left/Right applies it at once.", "Elige el modo de animación de neón. Izquierda/Derecha lo aplica al instante.", "选择霓虹灯动画模式。左/右方向键立即生效。", "Neon-Animationsmodus wählen. Links/Rechts wendet ihn sofort an.", "ネオンのアニメーションモードを選択します。左右で即座に適用されます。", "Выберите режим анимации неона. Влево/Вправо применяет сразу.", "Escolha o modo de animação do neon. Esquerda/Direita aplica na hora.", "Choisir le mode d'animation néon. Gauche/Droite l'applique immédiatement.") BREAK
                CASE 1 g_selected_description = TR("Cycle the underglow base colour, like LSC. Non-RGB effects use it.", "Cambia el color base del neón, como en LSC. Lo usan los efectos no RGB.", "切换底盘灯基础颜色（同改车王）。非 RGB 特效会使用该颜色。", "Basis-Unterbodenfarbe wie bei LSC wechseln. Wird von Nicht-RGB-Effekten genutzt.", "LSCのようにアンダーネオンの基本色を切り替えます（非RGB効果で使用）。", "Смена базового цвета подсветки, как в LSC. Используется не-RGB эффектами.", "Alterne a cor base do neon, como na LSC. Efeitos não RGB usam essa cor.", "Parcourir la couleur de base du néon, comme au LSC. Utilisé hors effets RVB.") BREAK
                CASE 2 g_selected_description = TR("Speed 0.25x to 10.00x. Stopped freezes. Forward only.", "Velocidad de 0.25x a 10.00x. Detenido congela. Solo hacia adelante.", "速度 0.25x 至 10.00x。停止会冻结动画。仅限正向。", "Geschwindigkeit 0.25x bis 10.00x. Gestoppt friert ein. Nur vorwärts.", "速度 0.25x〜10.00x。停止でフリーズ。順方向のみ。", "Скорость от 0.25x до 10.00x. Стоп замораживает. Только вперед.", "Velocidade de 0.25x a 10.00x. Parado congela. Apenas para frente.", "Vitesse de 0.25x à 10.00x. Arrêté fige l'animation. Vers l'avant uniquement.") BREAK
            ENDSWITCH
        ENDIF
    ELIF g_ped_open
        IF g_story_ped_picker_open
            IF g_item = 0 g_selected_description = TR("Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!", "Busca por nombre de modelo PED; sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按 PED 模型名称搜索；严格区分大小写，请务必使用大写字母！", "Nach PED-Modellnamen suchen; extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "PEDモデル名で検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Поиск по имени модели PED; чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Pesquise pelo nome do modelo PED; diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Rechercher par nom de modèle PED ; très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") ENDIF
            IF g_item = 1 g_selected_description = TR("Assign a random validated PED model to this story character.", "Asigna un modelo PED aleatorio validado a este personaje de historia.", "为该故事角色分配一个随机验证的 PED 模型。", "Diesem Story-Charakter ein zufälliges geprüftes PED-Modell zuweisen.", "このストーリーキャラクターにランダムなPEDモデルを割り当てます。", "Назначить этому сюжетному персонажу случайную модель PED.", "Atribui um modelo PED aleatório validado a este personagem da história.", "Attribuer un modèle PED aléatoire validé à ce personnage de l'histoire.") ENDIF
            IF g_item >= 2 g_selected_description = TR("Assign the selected PED model to this story character.", "Asigna el modelo PED seleccionado a este personaje de historia.", "将所选 PED 模型分配给该故事角色。", "Das ausgewählte PED-Modell diesem Story-Charakter zuweisen.", "選択したPEDモデルをこのストーリーキャラクターに割り当てます。", "Назначить выбранную модель PED этому сюжетному персонажу.", "Atribui o modelo PED selecionado a este personagem da história.", "Attribuer le modèle PED sélectionné à ce personnage de l'histoire.") ENDIF
        ELIF g_story_peds_open
            g_selected_description = TR("Open the PED picker to change this story character's model in cutscenes and missions.", "Abre el selector de PED para cambiar el modelo de este personaje en cinemáticas y misiones.", "打开模型选择器以更改此故事角色在过场动画和任务中的模型。", "PED-Auswahl öffnen, um das Modell dieses Story-Charakters in Zwischensequenzen und Missionen zu ändern.", "PEDピッカーを開き、カットシーンやミッションでのこのキャラクターのモデルを変更します。", "Открыть выбор модели PED для замены этого персонажа в катсценах и миссиях.", "Abra o seletor de PED para alterar o modelo deste personagem em cutscenes e missões.", "Ouvrir le sélecteur de PED pour changer le modèle de ce personnage dans les cinématiques et missions.")
        ELSE
            IF g_item = 0 g_selected_description = TR("Customize the PED models of story characters, heist crew, and cutscene NPCs.", "Personaliza los modelos PED de los personajes de la historia, equipo de golpes y NPCs.", "自定义故事模式角色、抢劫队员及过场动画人物的 PED 模型。", "PED-Modelle von Story-Charakteren, Raubüberfall-Crew und Zwischensequenz-NPCs anpassen.", "ストーリーキャラクター、強盗クルー、カットシーンNPCのPEDモデルを変更します。", "Настроить модели PED для сюжетных персонажей, команды ограбления и NPC в катсценах.", "Personalize os modelos PED dos personagens da história, equipe de golpe e NPCs.", "Personnaliser les modèles PED des personnages de l'histoire, de l'équipe de braquage et des PNJ.") ENDIF
            IF g_item = 1 g_selected_description = TR("Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!", "Busca por nombre de modelo PED; sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按 PED 模型名称搜索；严格区分大小写，请务必使用大写字母！", "Nach PED-Modellnamen suchen; extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "PEDモデル名で検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Поиск по имени модели PED; чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Pesquise pelo nome do modelo PED; diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Rechercher par nom de modèle PED ; très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") ENDIF
            IF g_item = 2 g_selected_description = TR("Apply a random validated PED model to the player.", "Aplica un modelo PED aleatorio validado al jugador.", "为玩家应用一个随机的已验证 PED 模型。", "Wendet ein zufälliges geprüftes PED-Modell auf den Spieler an.", "検証済みのランダムなPEDモデルをプレイヤーに適用します。", "Применить к игроку случайную проверенную модель PED.", "Aplica um modelo PED aleatório validado ao jogador.", "Appliquer un modèle PED aléatoire validé au joueur.") ENDIF
            IF g_item = 3 g_selected_description = TR("Switch between Franklin, Michael, and Trevor saved PED profiles.", "Cambia entre los perfiles PED guardados de Franklin, Michael y Trevor.", "在富兰克林、麦克和崔佛保存的 PED 档案之间切换。", "Zwischen gespeicherten PED-Profilen von Franklin, Michael und Trevor wechseln.", "フランクリン、マイケル、トレバーの保存済みPEDプロファイルを切り替えます。", "Переключение между сохраненными профилями PED Франклина, Майкла и Тревора.", "Alterne entre os perfis PED salvos de Franklin, Michael e Trevor.", "Basculer entre les profils PED sauvegardés de Franklin, Michael et Trevor.") ENDIF
            IF g_item >= 4 g_selected_description = TR("Apply the selected PED model to the player.", "Aplica el modelo PED seleccionado al jugador.", "将所选 PED 模型应用到玩家。", "Das ausgewählte PED-Modell auf den Spieler anwenden.", "選択したPEDモデルをプレイヤーに適用します。", "Применить выбранную модель PED к игроку.", "Aplicar o modelo PED selecionado ao jogador.", "Appliquer le modèle PED sélectionné au joueur.") ENDIF
        ENDIF
    ELIF g_spawner_open
        IF g_saved_veh_confirm_open
            SWITCH g_item
                CASE 0 g_selected_description = TR("Cancel and keep this saved vehicle in your list.", "Cancelar y mantener este vehículo guardado.", "取消并保留此已保存载具。", "Abbrechen und dieses Fahrzeug behalten.", "キャンセルしてこの保存済み車両を保持します。", "Отмена и сохранение этого ТС в списке.", "Cancelar e manter este veículo salvo.", "Annuler et conserver ce véhicule sauvegardé.") BREAK
                CASE 1 g_selected_description = TR("Permanently delete this saved vehicle entry from SD card storage.", "Eliminar permanentemente este vehículo guardado del almacenamiento SD.", "从 SD 卡存储中永久删除此已保存载具。", "Dieses gespeicherte Fahrzeug dauerhaft von der SD-Karte löschen.", "この保存済み車両をSDカードストレージから完全に削除します。", "Навсегда удалить этот сохраненный транспорт с SD-карты.", "Excluir permanentemente este veículo salvo do cartão SD.", "Supprimer définitivement ce véhicule sauvegardé de la carte SD.") BREAK
            ENDSWITCH
        ELIF g_saved_vehicles_open
            IF g_item = 0
                g_selected_description = TR("Save current vehicle with all its modifications, colors, and neon to SD card.", "Guarda el vehículo actual con todas sus modificaciones y colores en la SD.", "保存当前载具及其所有改装、涂装与霓虹灯到 SD 卡。", "Aktuelles Fahrzeug mit allen Mods, Farben und Neon auf SD speichern.", "現在の車両の全改造・カラー・ネオン設定をSDカードに保存します。", "Сохранить текущий транспорт со всеми модификациями на SD-карту.", "Salvar veículo atual com todas as modificações no cartão SD.", "Sauvegarder le véhicule actuel et toutes ses modifications sur la carte SD.")
            ELSE
                g_selected_description = TR("Press A to select for Spawner. Press LB + RB + X to delete.", "Pulsa A para elegirlo en el generador. Pulsa LB + RB + X para borrar.", "按 A 选择用于生成器。按 LB + RB + X 删除。", "A drücken zum Auswählen für Spawner. LB + RB + X zum Löschen.", "Aでスポナー用に選択。LB + RB + Xで削除。", "Нажмите A для выбора в спавнере. Нажмите LB + RB + X для удаления.", "Pressione A para selecionar no gerador. Pressione LB + RB + X para excluir.", "Appuyez sur A pour sélectionner dans le spawner. LB + RB + X pour supprimer.")
            ENDIF
        ELIF g_vehicle_list_open
            g_selected_description = TR("Press A to select this vehicle and spawn 1 immediately.", "Pulsa A para elegir este vehículo y generar 1 al instante.", "按 A 选择此载具并立即生成 1 辆。", "A drücken, um dieses Fahrzeug auszuwählen und sofort 1 zu spawnen.", "Aを押してこの車両を選択し、すぐに1台スポーンします。", "Нажмите A для выбора этого ТС и немедленного спавна 1 шт.", "Pressione A para selecionar este veículo e gerar 1 imediatamente.", "Appuyez sur A pour sélectionner ce véhicule et en faire apparaître 1 immédiatement.")
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = TR("Spawn the selected vehicle, using the configured count and layout.", "Genera el vehículo seleccionado con la cantidad y disposición configuradas.", "按配置的数量和排列生成所选载具。", "Ausgewähltes Fahrzeug mit eingestellter Anzahl und Formation spawnen.", "設定した台数と配置で選択中の乗り物を出現させます。", "Создать выбранный транспорт в указанном количестве и построении.", "Gera o veículo selecionado usando a quantidade e o formato configurados.", "Faire apparaître le véhicule sélectionné selon le nombre et la disposition définis.") BREAK
                CASE 1 g_selected_description = TR("View and manage custom saved vehicles stored on your SD card.", "Ver y gestionar vehículos guardados personalizados en tu tarjeta SD.", "查看并管理存储在 SD 卡上的自定义已保存载具。", "Auf der SD-Karte gespeicherte eigene Fahrzeuge ansehen und verwalten.", "SDカードに保存されたカスタム車両を表示・管理します。", "Просмотр и управление сохраненными ТС на SD-карте.", "Ver e gerenciar veículos personalizados salvos no seu cartão SD.", "Afficher et gérer les véhicules sauvegardés personnalisés sur la carte SD.") BREAK
                CASE 2 g_selected_description = TR("Find a vehicle by model name. Extremely case sensitive. ALWAYS USE CAPS!", "Busca un vehículo por nombre de modelo. Sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按模型名称查找载具。严格区分大小写，请务必使用大写字母！", "Fahrzeug nach Modellnamen suchen. Extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "モデル名で乗り物を検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Найти транспорт по имени модели. Чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Encontre um veículo pelo nome do modelo. Diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Trouver un véhicule par nom de modèle. Très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") BREAK
                CASE 3 g_selected_description = TR("Choose a base-game, DLC, aircraft, bike, watercraft, or misc list.", "Elige una lista del juego base, DLC, aeronaves, motos, barcos o varios.", "选择本体、DLC、飞机、摩托、船只或杂项载具列表。", "Liste wählen: Basisspiel, DLC, Luftfahrzeuge, Motorräder, Boote oder Sonstiges.", "本編、DLC、航空機、バイク、船舶、その他のリストを選択します。", "Выберите список: базовая игра, DLC, авиация, мото, водный или разное.", "Escolha uma lista do juego base, DLC, aeronaves, motos, barcos ou diversos.", "Choisir une liste : jeu de base, DLC, avions, motos, bateaux ou divers.") BREAK
                CASE 4 g_selected_description = TR("Browse and select vehicles from the active category list. Spawns 1 vehicle directly.", "Explora y selecciona vehículos de la categoría activa. Genera 1 al pulsar A.", "浏览并选择当前类别中的载具。按 A 直接生成 1 辆。", "Fahrzeuge der aktiven Kategorie durchsuchen und wählen. Spawnt direkt 1 Fahrzeug.", "選択中カテゴリーの車両一覧を表示・選択。Aで1台直接スポーン。", "Список транспорта активной категории. Нажмите A для спавна 1 машины.", "Navegue e selecione veículos da categoria ativa. Gera 1 veículo diretamente.", "Parcourir et sélectionner des véhicules de la catégorie. Fait apparaître 1 véhicule directement.") BREAK
                CASE 5 g_selected_description = TR("Set how many copies to create at once; DPAD Left/Right changes the count by intervals of 1; 500 Max", "Define cuántas copias crear a la vez; Izquierda/Derecha cambia de 1 en 1; máx. 500.", "设置一次生成的数量；方向键左/右每次增减 1；最多 500 辆。", "Anzahl gleichzeitig erzeugter Fahrzeuge; Steuerkreuz Links/Rechts ändert um 1; Max. 500.", "一度に出現させる台数を設定（十字キー左右で1ずつ変更、最大500）。", "Количество создаваемых копий за раз; Влево/Вправо меняет на 1; макс. 500.", "Defina quantas cópias criar de uma vez; Esquerda/Direita altera de 1 em 1; máx. 500.", "Définir le nombre de copies à créer ; Gauche/Droite change de 1 ; 500 max.") BREAK
                CASE 6 g_selected_description = TR("Apply the highest available upgrade to every spawned vehicle.", "Aplica la mejora máxima disponible a cada vehículo generado.", "为每辆生成的载具应用最高可用升级。", "Höchstes verfügbares Upgrade auf jedes gespawnte Fahrzeug anwenden.", "出現するすべての乗り物に最高レベルの改造を適用します。", "Применить максимальные улучшения ко всем создаваемым машинам.", "Aplica a melhoria máxima disponível a cada veículo gerado.", "Appliquer la meilleure amélioration disponible à chaque véhicule généré.") BREAK
                CASE 7 g_selected_description = TR("Choose door-to-door or bumper-to-bumper formation.", "Elige formación puerta con puerta o parachoques con parachoques.", "选择并排（车门对车门）或纵列（首尾相接）队形。", "Formation Tür-an-Tür oder Stoßstange-an-Stoßstange wählen.", "横並び（ドア・ツー・ドア）か縦並び（バンパー・ツー・バンパー）を選択します。", "Выберите построение: бок о бок или бампер к бамперу.", "Escolha a formação lado a lado ou para-choque com para-choque.", "Choisir la formation côte à côte ou pare-chocs contre pare-chocs.") BREAK
                CASE 8 g_selected_description = TR("Choose the heading of spawned vehicles relative to the player.", "Elige la orientación de los vehículos generados respecto al jugador.", "选择生成载具相对于玩家的朝向。", "Ausrichtung der gespawnten Fahrzeuge relativ zum Spieler wählen.", "プレイヤーに対する出現車両の向きを選択します。", "Выберите направление создаваемого транспорта относительно игрока.", "Escolha a direção dos veículos gerados em relação ao jogador.", "Choisir l'orientation des véhicules générés par rapport au joueur.") BREAK
                CASE 9 g_selected_description = TR("Automatically remove the previous custom vehicle when spawning.", "Elimina automáticamente el vehículo personalizado anterior al generar otro.", "生成新载具时自动移除上一辆自定义载具。", "Vorheriges eigenes Fahrzeug beim Spawnen automatisch entfernen.", "新しい車両を出現させる際、前のカスタム車両を自動的に消去します。", "Автоматически удалять предыдущий созданный транспорт при спавне нового.", "Remove automaticamente o veículo personalizado anterior ao gerar outro.", "Supprimer automatiquement le véhicule personnalisé précédent lors de l'apparition.") BREAK
                CASE 10 g_selected_description = TR("Delete every vehicle created by this menu.", "Elimina todos los vehículos creados por este menú.", "删除此菜单创建的所有载具。", "Alle von diesem Menü erstellten Fahrzeuge löschen.", "このメニューで作成したすべての乗り物を削除します。", "Удалить весь транспорт, созданный через это меню.", "Excluir todos os veículos criados por este menu.", "Supprimer tous les véhicules créés par ce menu.") BREAK
                CASE 11 g_selected_description = TR("Enter a spawned vehicle automatically after it is created.", "Entra automáticamente en el vehículo generado tras crearlo.", "生成载具后自动进入驾驶座。", "Nach dem Erstellen automatisch in das gespawnte Fahrzeug einsteigen.", "出現させた乗り物に自動的に乗り込みます。", "Автоматически садиться в созданный транспорт после появления.", "Entrar automaticamente no veículo gerado após a criação.", "Monter automatiquement dans le véhicule après sa création.") BREAK
            ENDSWITCH
        ENDIF
    // The six LSC child pages are checked further down this chain, so the parent
    // branch has to stand aside while one of them is open.  Without this guard
    // g_lsc_open is always TRUE when a child is open, the parent branch swallows
    // them, and every child row displayed a main-LS-Customs description instead of
    // its own (the child blocks below were unreachable).
    ELIF g_lsc_open AND NOT g_hydro_open AND NOT g_interior_open AND NOT g_wheeltyre_open AND NOT g_lsc_extras_open AND NOT g_bennys_open AND NOT g_support_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Apply the best available upgrade in every supported mod slot.", "Aplica la mejor mejora disponible en cada ranura compatible.", "在每个支持的改装槽位应用最高级升级。", "Bestes verfügbares Upgrade in jedem unterstützten Mod-Slot anwenden.", "対応するすべての改造スロットに最高レベルのアップグレードを適用します。", "Применить лучшее улучшение в каждом поддерживаемом слоте тюнинга.", "Aplica a melhor melhoria disponível em cada espaço de modificação compatível.", "Appliquer la meilleure amélioration disponible dans chaque emplacement compatible.") BREAK
            CASE 1 g_selected_description = TR("Remove every modification and restore factory stock.", "Elimina todas las modificaciones y restaura el estado de fábrica.", "移除所有改装并恢复原厂状态。", "Alle Modifikationen entfernen und Werkszustand wiederherstellen.", "すべての改造を解除して純正状態に戻します。", "Снять все модификации и вернуть заводское состояние.", "Remove todas as modificações e restaura o padrão de fábrica.", "Supprimer toutes les modifications et restaurer l'état d'origine.") BREAK
            CASE 2 g_selected_description = TR("Select the vehicle modification slot (automatically skips unsupported slots).", "Selecciona la ranura de modificación del vehículo (salta automáticamente las incompatibles).", "选择车辆改装槽位（自动跳过不支持的槽位）。", "Fahrzeug-Modifikationsslot auswählen (überspringt nicht unterstützte Slots automatisch).", "車両の改造スロットを選択します（非対応スロットを自動スキップ）。", "Выберите слот модификации (автоматически пропускает неподдерживаемые).", "Selecione o espaço de modificação do veículo (pula os não suportados automaticamente).", "Sélectionner l'emplacement de modification (ignore automatiquement les emplacements incompatibles).") BREAK
            CASE 3 g_selected_description = TR("Cycle and apply the available variant for the selected slot.", "Recorre y aplica la variante disponible para la ranura seleccionada.", "切换并应用所选槽位的可用改装件。", "Verfügbare Variante für den gewählten Slot durchschalten und anwenden.", "選択したスロットの利用可能なバリエーションを切り替えて適用します。", "Переключить и применить доступный вариант для выбранного слота.", "Alterne e aplique a variante disponível para o espaço selecionado.", "Parcourir et appliquer la variante disponible pour l'emplacement sélectionné.") BREAK
            CASE 4 g_selected_description = TR("Shows available variants. Press Left/Right to cycle, or A to toggle stock.", "Muestra variantes disponibles. Pulsa Izq/Der para alternar o A para serie.", "显示可用款式。按左/右循环，或按 A 键切换原厂。", "Zeigt verfügbare Varianten. Links/Rechts zum Wechseln, A für Serie.", "利用可能なバリエーションを表示。左右で切替、Aで純正トグル。", "Показывает доступные варианты. Влево/Вправо для переключения, А для сброса на сток.", "Mostra variantes disponíveis. Esquerda/Direita para alternar ou A para original.", "Affiche les variantes disponibles. Gauche/Droite pour changer ou A pour l'origine.") BREAK
            CASE 5 g_selected_description = TR("Set the primary paint color.", "Define el color de pintura principal.", "设置主喷漆颜色。", "Primäre Lackfarbe festlegen.", "メインペイントの色を設定します。", "Установить основной цвет окраски.", "Definir a cor de pintura primária.", "Définir la couleur de peinture principale.") BREAK
            CASE 6 g_selected_description = TR("Set the secondary paint color.", "Define el color de pintura secundario.", "设置副喷漆颜色。", "Sekundäre Lackfarbe festlegen.", "サブペイントの色を設定します。", "Установить дополнительный цвет окраски.", "Definir a cor de pintura secundária.", "Définir la couleur de peinture secondaire.") BREAK
            CASE 7 g_selected_description = TR("Set the pearlescent paint color.", "Define el color nacarado de la pintura.", "设置珠光涂装颜色。", "Perleffekt-Lackfarbe festlegen.", "パールセントの色を設定します。", "Установить перламутровый оттенок окраски.", "Definir a cor do perolado.", "Définir la couleur nacrée.") BREAK
            CASE 8 g_selected_description = TR("Set the wheel paint color.", "Define el color de pintura de las ruedas.", "设置车轮颜色。", "Felgenfarbe festlegen.", "ホイールの色を設定します。", "Установить цвет дисков.", "Definir a cor das rodas.", "Définir la couleur des jantes.") BREAK
            CASE 9 g_selected_description = TR("Change the vehicle wheel family.", "Cambia la categoría de ruedas del vehículo.", "更改载具车轮类别。", "Felgenkategorie des Fahrzeugs ändern.", "ホイールのカテゴリを変更します。", "Изменить категорию колес транспорта.", "Alterar a categoria de rodas do veículo.", "Changer la catégorie de roues du véhicule.") BREAK
            CASE 10 g_selected_description = TR("Toggle the turbo modification.", "Activa o desactiva la modificación de turbo.", "切换涡轮增压改装。", "Turbo-Modifikation ein- oder ausschalten.", "ターボチューニングのON/OFFを切り替えます。", "Включить или выключить турбонаддув.", "Ativar ou desativar o turbo.", "Activer ou désactiver le turbo.") BREAK
            CASE 11 g_selected_description = TR("Toggle xenon headlights.", "Activa o desactiva los faros de xenón.", "切换氙气车灯。", "Xenon-Scheinwerfer ein- oder ausschalten.", "キセノンライトのON/OFFを切り替えます。", "Включить или выключить ксеноновые фары.", "Ativar ou desativar faróis de xênon.", "Activer ou désactiver les phares au xénon.") BREAK
            CASE 12 g_selected_description = TR("Choose the xenon headlight color.", "Elige el color de los faros de xenón.", "选择氙气车灯颜色。", "Farbe der Xenon-Scheinwerfer wählen.", "キセノンライトの色を選択します。", "Выбрать цвет ксеноновых фар.", "Escolher a cor dos faróis de xênon.", "Choisir la couleur des phares au xénon.") BREAK
            CASE 13 g_selected_description = TR("Toggle all four neon tubes.", "Activa o desactiva los cuatro tubos de neón.", "开启或关闭全部四个霓虹灯管。", "Alle vier Neonröhren ein- oder ausschalten.", "4方向すべてのネオン管のON/OFFを切り替えます。", "Включить или выключить все четыре неоновые лампы.", "Ativar ou desativar os quatro tubos de neon.", "Activer ou désactiver les quatre tubes néon.") BREAK
            CASE 14 g_selected_description = TR("Choose the neon light color.", "Elige el color de la luz de neón.", "选择霓虹灯颜色。", "Farbe der Neonbeleuchtung wählen.", "ネオンライトの色を選択します。", "Выбрать цвет неоновой подсветки.", "Escolher a cor da luz de neon.", "Choisir la couleur des néons.") BREAK
            CASE 15 g_selected_description = TR("Choose the window tint level.", "Elige el nivel de tinte de las ventanillas.", "选择车窗贴膜深浅。", "Scheibentönung auswählen.", "ウィンドウティントの濃さを選択します。", "Выбрать степень тонировки стекол.", "Escolher o nível de película dos vidros.", "Choisir le niveau de teinte des vitres.") BREAK
            CASE 16 g_selected_description = TR("Choose the license plate background design.", "Elige el diseño de fondo de la matrícula.", "选择车牌背景样式。", "Hintergrunddesign des Nummernschilds wählen.", "ナンバープレートの背景デザインを選択します。", "Выбрать дизайн фона номерного знака.", "Escolher o estilo de fundo da placa.", "Choisir le style de plaque d'immatriculation.") BREAK
            CASE 17 g_selected_description = TR("Type a custom plate (8 chars max) with the keyboard.", "Escribe una matrícula personalizada (máx. 8 caracteres) con el teclado.", "使用键盘输入自定义车牌（最多 8 个字符）。", "Eigenes Kennzeichen (max. 8 Zeichen) per Tastatur eingeben.", "キーボードでカスタムナンバー（最大8文字）を入力します。", "Введите свой текст номера (макс. 8 символов) с клавиатуры.", "Digite uma placa personalizada (máx. 8 caracteres) com o teclado.", "Saisir une plaque personnalisée (8 caractères max) au clavier.") BREAK
            CASE 18 g_selected_description = TR("Write the entered plate text to the occupied vehicle.", "Aplica el texto de matrícula introducido al vehículo actual.", "将输入的车牌文本应用到当前载具。", "Eingegebenen Kennzeichentext auf das aktuelle Fahrzeug anwenden.", "入力したナンバー文字列を乗車中の車両に適用します。", "Применить введенный текст номера к текущему транспорту.", "Aplicar o texto da placa digitado ao veículo atual.", "Appliquer le texte de plaque saisi au véhicule occupé.") BREAK
            CASE 19 g_selected_description = TR("Remove the currently selected slot's modification.", "Elimina la modificación de la ranura seleccionada.", "移除当前所选槽位的改装。", "Modifikation des aktuell gewählten Slots entfernen.", "現在選択しているスロットの改造を解除します。", "Удалить модификацию из выбранного слота.", "Remover a modificação do espaço selecionado.", "Supprimer la modification de l'emplacement sélectionné.") BREAK
            CASE 20 g_selected_description = TR("Choose which of the car's mod kits the menu writes to. Lowrider interiors and hydraulics live in an add-on kit, not the stock one. Left/Right switches kit and re-reads every row.", "Elige en qué kit de modificaciones escribe el menú. Los interiores lowrider e hidráulicos están en un kit adicional. Izquierda/Derecha cambia el kit.", "选择菜单写入的改装套件。低底盘内饰和液压系统位于附加套件中。左/右切换套件并重新读取。", "Wählt das Mod-Kit des Fahrzeugs. Lowrider-Innenräume und Hydraulik liegen in einem Zusatz-Kit. Links/Rechts wechselt das Kit.", "書き込み先のMODキットを選択します。ローライダー内装やハイドロは追加キットにあります。左右で切り替えます。", "Выберите набор тюнинга (mod kit). Интерьер лоурайдера и гидравлика находятся в доп. наборе. Влево/Вправо меняет набор.", "Escolha em qual kit de modificação o menu escreve. Interiores lowrider e hidráulica ficam em um kit extra. Esquerda/Direita alterna o kit.", "Choisir le kit de mod du véhicule. Les intérieurs lowrider et l'hydraulique sont dans un kit additionnel. Gauche/Droite change de kit.") BREAK
            CASE 21 g_selected_description = TR("Type of the active mod kit, as the game reports it.", "Tipo del kit de modificaciones activo según el juego.", "游戏报告的当前活动改装套件类型。", "Typ des aktiven Mod-Kits laut Spiel.", "ゲームが報告する現在のアクティブなMODキットの種類。", "Тип активного набора модификаций по данным игры.", "Tipo do kit de modificação ativo conforme informado pelo jogo.", "Type du kit de modification actif tel qu'indiqué par le jeu.") BREAK
            CASE 22 g_selected_description = TR("How many mod kits this car carries. 'Stock Kit Only' means the lowrider slots do not exist on it.", "Cuántos kits de modificación tiene este coche. 'Solo kit de serie' indica que no tiene ranuras lowrider.", "此车拥有的改装套件数量。'仅原厂套件'表示该车没有低底盘槽位。", "Anzahl der Mod-Kits dieses Autos. 'Nur Standard-Kit' bedeutet, dass keine Lowrider-Slots vorhanden sind.", "この車が持つMODキット数。「標準キットのみ」の場合、ローライダースロットはありません。", "Количество наборов тюнинга у машины. 'Только сток' означает отсутствие слотов лоурайдера.", "Quantos kits de mod este carro possui. 'Apenas Kit Original' significa que não há espaços lowrider.", "Nombre de kits de mod sur cette voiture. 'Kit d'origine seul' signifie qu'elle n'a pas d'emplacements lowrider.") BREAK
            CASE 23 g_selected_description = TR("Open the hydraulics submenu: stance presets, per-axle heights, single-wheel control and Hold Stance.", "Abre el submenú de hidráulica: posturas, altura por eje, control por rueda y mantener postura.", "打开液压系统子菜单：姿态预设、车轴高度、单轮控制和保持姿态。", "Hydraulik-Untermenü öffnen: Stance-Presets, Achshöhen, Einzelradsteuerung und Stance halten.", "ハイドロメニューを開きます（スタンスプリセット、車軸高、単輪制御、スタンス維持）。", "Открыть подменю гидравлики: пресеты посадки, высота осей, управление колесами и удержание.", "Abre o submenu de hidráulica: predefinições de postura, altura por eixo, controle por roda e manter postura.", "Ouvrir le sous-menu hydraulique : préréglages de posture, hauteur par essieu, contrôle par roue et maintien.") BREAK
            CASE 24 g_selected_description = TR("Open the lowrider interior submenu: interiors, seats, steering, dash, trunk and engine bay, with the game's own slot and variant names.", "Abre el submenú de interior lowrider: interiores, asientos, volante, salpicadero, maletero y motor.", "打开低底盘内饰子菜单：内饰、座椅、方向盘、仪表盘、后备箱和发动机舱。", "Lowrider-Innenraum-Untermenü öffnen: Innenraum, Sitze, Lenkrad, Armaturenbrett, Kofferraum und Motorraum.", "ローライダー内装メニューを開きます（内装、シート、ステアリング、ダッシュ、トランク、エンジンルーム）。", "Открыть подменю салона лоурайдера: салон, сиденья, руль, панель, багажник и моторный отсек.", "Abre o submenu de interior lowrider: interiores, bancos, volante, painel, porta-malas e cofre do motor.", "Ouvrir le sous-menu intérieur lowrider : intérieur, sièges, volant, tableau de bord, coffre et compartiment moteur.") BREAK
            CASE 25 g_selected_description = TR("Open the wheels and tyres submenu: wheel family, front/rear variation, tyre smoke and reduced suspension force.", "Abre el submenú de ruedas y neumáticos: categoría, variación delantera/trasera, humo y suspensión rebajada.", "打开车轮与轮胎子菜单：车轮类别、前后轮款式、轮胎烟雾和降低悬挂。", "Räder-und-Reifen-Untermenü öffnen: Felgenkategorie, Vorder-/Hinterrad-Variante, Reifenrauch und Tieferlegung.", "ホイール＆タイヤメニューを開きます（カテゴリ、前後バリエーション、タイヤスモーク、ローダウン）。", "Открыть подменю колес и шин: категория, передние/задние варианты, дым покрышек и занижение подвески.", "Abre o submenu de rodas e pneus: categoria, variação dianteira/traseira, fumaça e suspensão rebaixada.", "Ouvrir le sous-menu roues et pneus : catégorie, variante avant/arrière, fumée de pneu et suspension abaissée.") BREAK
            CASE 26 g_selected_description = TR("Open the extras and livery submenu: liveries by name, plus the car's 12 extras (roof racks, light bars and similar).", "Abre el submenú de extras y diseños: diseños por nombre y los 12 extras del coche (bacas, luces, etc.).", "打开配件与涂装子菜单：按名称选择涂装，以及车辆的 12 个附加部件（车顶架、灯条等）。", "Extras-und-Designs-Untermenü öffnen: Designs nach Namen sowie die 12 Fahrzeug-Extras (Dachträger, Lichtbalken usw.).", "エクストラ＆ペイントジョブメニューを開きます（名前付きリバリーとルーフラック等の12個のエクストラ）。", "Открыть подменю экстр и раскрасок: раскраски по названиям и 12 дополнительных деталей кузова.", "Abre o submenu de extras e pinturas: estampas por nome e os 12 extras do carro (bagageiros, barras de luz, etc.).", "Ouvrir le sous-menu extras et livrées : livrées par nom et les 12 extras de la voiture (galeries, rampes de phares, etc.).") BREAK
            CASE 27 g_selected_description = TR("Spawn a car that can take a lowrider kit. These are Rockstar's own conversion targets, and the only cars hydraulics and the lowrider interiors work on. A row only offers a car this build really ships.", "Genera un coche compatible con kit lowrider. Son las variantes en las que funcionan la hidráulica y los interiores lowrider.", "生成支持低底盘套件的车辆。只有这些 Rockstar 原生改装车型才能使用液压系统和低底盘内饰。", "Spawnt ein Fahrzeug mit Lowrider-Kit-Unterstützung. Nur bei diesen Modellen funktionieren Hydraulik und Lowrider-Innenräume.", "ローライダーキット対応車両を出現させます。ハイドロとローライダー内装が機能する専用車両です。", "Создать машину с поддержкой лоурайдер-кита. Только на них работают гидравлика и салоны лоурайдеров.", "Gera um carro compatível com kit lowrider. São os únicos carros em que a hidráulica e os interiores lowrider funcionam.", "Faire apparaître une voiture compatible lowrider. Ce sont les seules voitures où l'hydraulique et les intérieurs lowrider fonctionnent.") BREAK
            CASE 28 g_selected_description = TR("Convert the car you are sitting in into its Benny's custom variant, keeping the paint and wheels. This is what makes hydraulics and the lowrider interiors usable: a stock car has no hydraulic data in any kit. Refused if this car has no verified variant.", "Convierte tu coche actual en su variante personalizada de Benny's conservando pintura y ruedas para habilitar hidráulica e interiores.", "将当前乘坐的车辆转换为班尼改车坊定制版（保留车漆和车轮），以启用液压系统和低底盘内饰。", "Wandelt das aktuelle Fahrzeug unter Beibehaltung von Lack und Felgen in seine Benny's-Custom-Variante um, damit Hydraulik und Lowrider-Innenraum nutzbar werden.", "塗装とホイールを維持したまま乗車中の車をベニーズ・カスタム仕様に変換し、ハイドロと内装を有効化します。", "Преобразовать текущую машину в кастом-версию Benny's с сохранением цвета и колес для работы гидравлики и салона.", "Converte o carro atual na variante personalizada da Benny's, mantendo pintura e rodas para ativar hidráulica e interiores.", "Convertir la voiture actuelle en sa variante Benny's Custom en gardant peinture et roues afin d'activer l'hydraulique et les intérieurs.") BREAK
            CASE 29 g_selected_description = TR("Why nothing here works: shows whether this car carries a lowrider kit, whether it can take hydraulics, how many lowrider slots it has, and whether this build ships its custom variant. Read-only.", "Diagnóstico de compatibilidad: muestra si este coche tiene kit lowrider, hidráulica, ranuras lowrider y variante personalizada. Solo lectura.", "兼容性诊断：显示此车是否带有低底盘套件、是否支持液压系统、低底盘槽位数量及定制变体（只读）。", "Kompatibilitätsprüfung: Zeigt, ob dieses Auto ein Lowrider-Kit, Hydraulik, Lowrider-Slots und eine Custom-Variante besitzt. Schreibgeschützt.", "この車がローライダーキットやハイドロに対応しているか、スロット数やカスタム仕様の有無を表示します（読み取り専用）。", "Диагностика совместимости: показывает наличие лоурайдер-кита, гидравлики, числа слотов и кастом-версии. Только чтение.", "Diagnóstico: mostra se o carro possui kit lowrider, suporte a hidráulica, quantos espaços lowrider tem e se há variante customizada. Somente leitura.", "Diagnostic : affiche si la voiture possède un kit lowrider, l'hydraulique, le nombre d'emplacements et une variante custom. Lecture seule.") BREAK
        ENDSWITCH
    ELIF g_hydro_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Fit or remove the hydraulic kit itself, and allow the car to use it.", "Instala o retira el kit hidráulico y permite que el coche lo utilice.", "安装或移除液压套件本身，并允许车辆使用它。", "Hydraulik-Kit ein- oder ausbauen und für das Fahrzeug freigeben.", "ハイドロキット自体を装着または取り外し、車両で使用可能にします。", "Установить или снять сам гидравлический комплект и разрешить машине его использовать.", "Instala ou remove o kit hidráulico e permite que o carro o utilize.", "Installer ou retirer le kit hydraulique et autoriser la voiture à l'utiliser.") BREAK
            CASE 1 g_selected_description = TR("Choose the hydraulic pump level. 'None on this car' means it has no hydraulic kit at all.", "Elige el nivel de la bomba hidráulica. 'Ninguno en este coche' significa que no tiene kit hidráulico.", "选择液压泵级别。'此车无'表示该车完全没有液压套件。", "Hydraulikpumpen-Stufe wählen. 'Keine bei diesem Auto' bedeutet, dass kein Hydraulik-Kit vorhanden ist.", "ハイドロポンプの段階を選択します。「非対応」はこの車にハイドロキットがないことを意味します。", "Выберите уровень гидравлического насоса. 'Нет на этой машине' означает отсутствие гидравлики.", "Escolha o nível da bomba hidráulica. 'Nenhum neste carro' significa que ele não possui kit hidráulico.", "Choisir le niveau de pompe hydraulique. 'Aucun sur cette voiture' signifie qu'elle n'a pas de kit hydraulique.") BREAK
            CASE 2 g_selected_description = TR("Let the player raise and lower the car with the game's own hydraulics controls.", "Permite subir y bajar el coche con los controles hidráulicos propios del juego.", "允许玩家使用游戏自带的液压控制升降车辆。", "Erlaubt das Heben und Senken des Autos mit der spielinternen Hydrauliksteuerung.", "ゲーム本来のハイドロ操作で車体を上下できるようにします。", "Разрешить игроку поднимать и опускать машину штатным управлением гидравликой.", "Permite levantar e abaixar o carro usando os controles de hidráulica do próprio jogo.", "Permettre au joueur de lever et baisser la voiture avec les commandes hydrauliques du jeu.") BREAK
            CASE 3 g_selected_description = TR("Choose a stance: Stock, Slammed, Max High, Bouncy, Free, Front Up, Rear Up, Lean Left, Lean Right. Applies as you move it.", "Elige una postura: Serie, Al suelo, Máx. alto, Rebote, Libre, Frente arriba, Atrás arriba, Inclinar izq./der. Se aplica al moverlo.", "选择姿态：原厂、贴地、最高、弹跳、自由、前抬、后抬、左倾、右倾。切换时立即应用。", "Stance wählen: Serie, Tiefergelegt, Max. Hoch, Federnd, Frei, Vorne hoch, Hinten hoch, Links/Rechts neigen. Wird sofort angewendet.", "スタンスを選択（標準、スラムド、最高、バウンス、フリー、前上げ、後上げ、左傾き、右傾き）。移動時に即適用。", "Выберите посадку: Сток, Заниженная, Макс. высота, Прыгучая, Свободная, Перед/Зад вверх, Крен влево/вправо.", "Escolha uma postura: Original, Rebaixado, Altura Máx., Quicando, Livre, Frente Alta, Traseira Alta, Inclinar Esq./Dir.", "Choisir une posture : Origine, Plaqué, Haut max, Rebond, Libre, Avant haut, Arrière haut, Pencher G/D. S'applique aussitôt.") BREAK
            CASE 4 g_selected_description = TR("Apply the chosen stance preset again.", "Vuelve a aplicar la postura predefinida elegida.", "再次应用所选的姿态预设。", "Gewähltes Stance-Preset erneut anwenden.", "選択したスタンスプリセットを再適用します。", "Повторно применить выбранный пресет посадки.", "Aplica novamente a predefinição de postura escolhida.", "Appliquer à nouveau le préréglage de posture choisi.") BREAK
            CASE 5 g_selected_description = TR("How high the front pair rides, 0-100%. Applies as you move it.", "Altura del eje delantero, 0-100%. Se aplica al cambiarlo.", "前轮对的高度（0-100%）。调节时立即生效。", "Höhe der Vorderachse, 0-100%. Wird beim Verstellen sofort angewendet.", "前輪ペアの車高（0〜100%）。動かすと即座に適用されます。", "Высота передней оси, 0-100%. Применяется сразу при изменении.", "Altura do eixo dianteiro, 0-100%. Aplica conforme você move.", "Hauteur du train avant, 0-100 %. S'applique dès le déplacement.") BREAK
            CASE 6 g_selected_description = TR("How high the rear pair rides, 0-100%. Applies as you move it.", "Altura del eje trasero, 0-100%. Se aplica al cambiarlo.", "后轮对的高度（0-100%）。调节时立即生效。", "Höhe der Hinterachse, 0-100%. Wird beim Verstellen sofort angewendet.", "後輪ペアの車高（0〜100%）。動かすと即座に適用されます。", "Высота задней оси, 0-100%. Применяется сразу при изменении.", "Altura do eixo traseiro, 0-100%. Aplica conforme você move.", "Hauteur du train arrière, 0-100 %. S'applique dès le déplacement.") BREAK
            CASE 7 g_selected_description = TR("How high the mid-left wheel rides. Only six-wheel cars have a mid pair.", "Altura de la rueda central izquierda. Solo los coches de seis ruedas tienen par central.", "左中轮高度。仅六轮车辆拥有中轮对。", "Höhe des mittleren linken Rads. Nur Sechsrad-Fahrzeuge haben ein Mittelpaar.", "中左輪の車高。6輪車両のみ中間ペアがあります。", "Высота среднего левого колеса. Средняя ось есть только у шестиколесных машин.", "Altura da roda central esquerda. Apenas carros de seis rodas têm eixo central.", "Hauteur de la roue centrale gauche. Seules les voitures à six roues ont un train central.") BREAK
            CASE 8 g_selected_description = TR("How high the mid-right wheel rides. Only six-wheel cars have a mid pair.", "Altura de la rueda central derecha. Solo los coches de seis ruedas tienen par central.", "右中轮高度。仅六轮车辆拥有中轮对。", "Höhe des mittleren rechten Rads. Nur Sechsrad-Fahrzeuge haben ein Mittelpaar.", "中右輪の車高。6輪車両のみ中間ペアがあります。", "Высота среднего правого колеса. Средняя ось есть только у шестиколесных машин.", "Altura da roda central direita. Apenas carros de seis rodas têm eixo central.", "Hauteur de la roue centrale droite. Seules les voitures à six roues ont un train central.") BREAK
            CASE 9 g_selected_description = TR("Apply all four height sliders to the car at once.", "Aplica los cuatro controles de altura al coche a la vez.", "将全部四个高度滑块一次性应用到车辆。", "Alle vier Höhenregler gleichzeitig auf das Fahrzeug anwenden.", "4つの車高スライダーすべてを同時に車両へ適用します。", "Применить все четыре ползунка высоты к машине одновременно.", "Aplica os quatro controles de altura ao carro de uma só vez.", "Appliquer les quatre curseurs de hauteur à la voiture en même temps.") BREAK
            CASE 10 g_selected_description = TR("Pick which single wheel the next four rows control.", "Elige qué rueda individual controlan las cuatro filas siguientes.", "选择下方四行要控制的单个车轮。", "Einzelnes Rad auswählen, das von den nächsten vier Zeilen gesteuert wird.", "次の4行で制御する単一のホイールを選択します。", "Выберите отдельное колесо, которым управляют следующие четыре строки.", "Escolha qual roda individual as próximas quatro linhas controlam.", "Choisir la roue individuelle contrôlée par les quatre lignes suivantes.") BREAK
            CASE 11 g_selected_description = TR("How high the selected wheel rides, 0-100%. Applies as you move it.", "Altura de la rueda seleccionada, 0-100%. Se aplica al cambiarlo.", "所选车轮的高度（0-100%）。调节时立即生效。", "Höhe des gewählten Rads, 0-100%. Wird beim Verstellen sofort angewendet.", "選択したホイールの高さ（0〜100%）。動かすと即座に適用されます。", "Высота выбранного колеса, 0-100%. Применяется сразу при изменении.", "Altura da roda selecionada, 0-100%. Aplica conforme você move.", "Hauteur de la roue sélectionnée, 0-100 %. S'applique dès le déplacement.") BREAK
            CASE 12 g_selected_description = TR("Whether the selected wheel is Free, Locked or set to Bounce.", "Define si la rueda seleccionada está Libre, Bloqueada o en Rebote.", "设置所选车轮为自由、锁定或弹跳状态。", "Ob das gewählte Rad Frei, Gesperrt oder auf Hüpfen gesetzt ist.", "選択したホイールの状態（フリー、ロック、バウンス）を設定します。", "Режим выбранного колеса: Свободно, Заблокировано или Прыжок.", "Define se a roda selecionada fica Livre, Travada ou Quicando.", "Définit si la roue sélectionnée est Libre, Verrouillée ou en Rebond.") BREAK
            CASE 13 g_selected_description = TR("How fast the selected wheel travels, 0.1x to 2.0x.", "Velocidad de recorrido de la rueda seleccionada, de 0.1x a 2.0x.", "所选车轮的升降速度（0.1x 至 2.0x）。", "Bewegungsgeschwindigkeit des gewählten Rads, 0.1x bis 2.0x.", "選択したホイールの上下動スピード（0.1x〜2.0x）。", "Скорость хода выбранного колеса от 0.1x до 2.0x.", "Velocidade de curso da roda selecionada, de 0.1x a 2.0x.", "Vitesse de débattement de la roue sélectionnée, de 0.1x à 2.0x.") BREAK
            CASE 14 g_selected_description = TR("Send the selected wheel's height, state and speed to the car.", "Envía la altura, el estado y la velocidad de la rueda seleccionada al coche.", "将所选车轮的高度、状态和速度应用到车辆。", "Höhe, Status und Geschwindigkeit des gewählten Rads an das Auto senden.", "選択したホイールの高さ・状態・速度を車両に適用します。", "Отправить высоту, состояние и скорость выбранного колеса на машину.", "Envia a altura, o estado e a velocidade da roda selecionada para o carro.", "Envoyer la hauteur, l'état et la vitesse de la roue sélectionnée à la voiture.") BREAK
            CASE 15 g_selected_description = TR("Keep re-applying the chosen stance so the car cannot settle out of it. Turns itself off when you leave the car.", "Mantiene aplicada la postura elegida para que el coche no pierda la posición. Se desactiva al salir.", "持续保持所选姿态，防止车身回落。下车时自动关闭。", "Wendet die gewählte Stance fortlaufend an, damit das Auto nicht absinkt. Schaltet sich beim Aussteigen ab.", "選択したスタンスを維持し続けます。降車すると自動的にOFFになります。", "Постоянно удерживать выбранную посадку. Отключается при выходе из машины.", "Mantém a postura escolhida aplicada para o carro não ceder. Desliga ao sair do carro.", "Maintenir la posture choisie pour empêcher la voiture de s'affaisser. Se désactive en sortant.") BREAK
            CASE 16 g_selected_description = TR("Soften the suspension so the car can sit lower - the game's own stance flag.", "Suaviza la suspensión para que el coche quede más bajo (opción de postura del juego).", "软化悬挂使车身更低——使用游戏原生低姿态标记。", "Federung weicher stellen, damit das Auto tiefer liegt - das spielinterne Stance-Flag.", "サスペンションを柔らかくして車高を下げます（ゲーム内のスタンスフラグ）。", "Смягчить подвеску для более низкой посадки (штатный флаг стенса в игре).", "Suaviza a suspensão para o carro ficar mais baixo (ajuste nativo de postura do jogo).", "Assouplir la suspension pour abaisser la voiture (option de posture native du jeu).") BREAK
            CASE 17 g_selected_description = TR("Put every hydraulic value back to stock and stop the car using hydraulics.", "Restaura todos los valores hidráulicos de serie y desactiva el uso de hidráulica.", "将所有液压数值恢复原厂并停用车辆液压系统。", "Alle Hydraulikwerte auf Standard zurücksetzen und Hydraulik deaktivieren.", "すべてのハイドロ設定を標準に戻し、ハイドロの使用を停止します。", "Сбросить все параметры гидравлики на сток и отключить ее использование.", "Restaura todos os valores hidráulicos para o original e desativa a hidráulica.", "Remettre toutes les valeurs hydrauliques d'origine et désactiver l'hydraulique.") BREAK
            CASE 18 g_selected_description = TR("Whether this car can take hydraulics at all. A plain car has no hydraulic data in any mod kit, so every row above it is a no-op until it is converted at Benny's - see Convert To Custom on the LS Customs page.", "Indica si este coche admite hidráulica. Un coche normal requiere convertirse primero en su variante de Benny's en la página de LS Customs.", "显示此车是否支持液压系统。普通车辆需要先在改车王页面转换为班尼定制版才能使用液压功能。", "Zeigt an, ob dieses Auto überhaupt Hydraulik unterstützt. Ein Standardauto muss zuerst auf der LS-Customs-Seite in seine Benny's-Variante umgewandelt werden.", "この車がハイドロに対応しているかを表示します。通常車両はLSCページでベニーズ仕様に変換するまで機能しません。", "Поддерживает ли эта машина гидравлику. Обычную машину сначала нужно переделать в кастом Benny's на странице LS Customs.", "Indica se este carro suporta hidráulica. Um carro comum precisa ser convertido na versão Benny's na página da LS Customs.", "Indique si cette voiture accepte l'hydraulique. Une voiture standard doit d'abord être convertie en variante Benny's sur la page LS Customs.") BREAK
        ENDSWITCH
    ELIF g_interior_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Apply the fill variant to every lowrider slot this car has. Slots it does not have are skipped.", "Aplica la variante de relleno a todas las ranuras lowrider que tenga este coche.", "将填充款式应用到此车拥有的每个低底盘槽位（跳过不存在的槽位）。", "Wendet die Füll-Variante auf jeden vorhandenen Lowrider-Slot dieses Autos an.", "この車が持つすべてのローライダースロットに一括バリエーションを適用します。", "Применить выбранный вариант ко всем слотам лоурайдера на этой машине.", "Aplica a variante escolhida a todos os espaços lowrider que este carro possui.", "Appliquer la variante choisie à chaque emplacement lowrider présent sur cette voiture.") BREAK
            CASE 1 g_selected_description = TR("Which variant index the fill row writes.", "Qué índice de variante aplica la fila de relleno.", "填充行写入的改装款式编号。", "Welchen Varianten-Index die Füll-Zeile schreibt.", "一括適用行で書き込むバリエーション番号。", "Индекс варианта, который записывает строка заполнения.", "Qual índice de variante a linha de preenchimento aplica.", "Indice de variante appliqué par la ligne de remplissage.") BREAK
            CASE 2 g_selected_description = TR("Choose the lowrider slot to edit.", "Elige la ranura lowrider que quieres editar.", "选择要编辑的低底盘槽位。", "Lowrider-Slot zum Bearbeiten auswählen.", "編集するローライダースロットを選択します。", "Выберите слот лоурайдера для редактирования.", "Escolha o espaço lowrider para editar.", "Choisir l'emplacement lowrider à modifier.") BREAK
            CASE 3 g_selected_description = TR("Choose the variant for this slot. 'None on this kit' means the active kit has none.", "Elige la variante para esta ranura. 'Ninguno en este kit' significa que el kit activo no tiene.", "选择此槽位的款式。'此套件无'表示当前套件没有可用项。", "Variante für diesen Slot wählen. 'Keine in diesem Kit' bedeutet, dass das aktive Kit keine hat.", "このスロットのバリエーションを選択します。「このキットになし」は非対応を意味します。", "Выберите вариант для этого слота. 'Нет в этом наборе' означает отсутствие вариантов.", "Escolha a variante para este espaço. 'Nenhum neste kit' significa que o kit ativo não possui.", "Choisir la variante pour cet emplacement. 'Aucun sur ce kit' signifie que le kit actif n'en a pas.") BREAK
            CASE 4 g_selected_description = TR("How many variants the active kit offers for this slot. Zero was why these slots did nothing before v0.9.9.", "Cuántas variantes ofrece el kit activo para esta ranura.", "当前套件为此槽位提供的款式数量。", "Wie viele Varianten das aktive Kit für diesen Slot bietet.", "現在のキットがこのスロットに提供するバリエーション数。", "Сколько вариантов предлагает активный набор для этого слота.", "Quantas variantes o kit ativo oferece para este espaço.", "Nombre de variantes proposées par le kit actif pour cet emplacement.") BREAK
            CASE 5 g_selected_description = TR("The game's own name for this slot.", "El nombre propio del juego para esta ranura.", "游戏内此槽位的原生名称。", "Der spielinterne Name für diesen Slot.", "このスロットのゲーム内名称。", "Собственное название этого слота в игре.", "O nome nativo do jogo para este espaço.", "Le nom utilisé par le jeu pour cet emplacement.") BREAK
            CASE 6 g_selected_description = TR("The game's own name for the selected variant.", "El nombre propio del juego para la variante seleccionada.", "游戏内所选款式的原生名称。", "Der spielinterne Name für die gewählte Variante.", "選択したバリエーションのゲーム内名称。", "Собственное название выбранного варианта в игре.", "O nome nativo do jogo para a variante selecionada.", "Le nom utilisé par le jeu pour la variante sélectionnée.") BREAK
            CASE 7 g_selected_description = TR("Interior trim colour, from the carcols palette.", "Color de la tapicería interior, de la paleta de colores.", "来自车辆色板的内饰饰条颜色。", "Innenraum-Zierfarbe aus der Fahrzeugfarbpalette.", "カラーパレットから選ぶ内装トリム色。", "Цвет внутренней отделки салона из палитры авто.", "Cor do acabamento interno, da paleta de cores do veículo.", "Couleur de garniture intérieure, issue de la palette du véhicule.") BREAK
            CASE 8 g_selected_description = TR("Interior metal colour, from the carcols palette.", "Color de los detalles metálicos interiores, de la paleta de colores.", "来自车辆色板的内饰金属颜色。", "Innenraum-Metallfarbe aus der Fahrzeugfarbpalette.", "カラーパレットから選ぶ内装アクセント（金属）色。", "Цвет металлических деталей салона из палитры авто.", "Cor dos detalhes metálicos internos, da paleta de cores do veículo.", "Couleur des finitions métalliques intérieures, issue de la palette du véhicule.") BREAK
            CASE 9 g_selected_description = TR("Whether the game has streamed in this car's modification parts yet. 'Not yet' means a slot can read as empty or take a write that does nothing.", "Indica si el juego ya ha cargado las piezas de modificación de este coche.", "游戏是否已加载此车的改装部件。'尚未'表示槽位可能暂时为空或无法生效。", "Ob das Spiel die Mod-Teile dieses Autos bereits geladen hat. 'Noch nicht' bedeutet, dass Slots leer erscheinen können.", "この車の改造パーツが読み込み済みかを表示します。「未読込」の間は反映されません。", "Загрузила ли игра детали тюнинга этой машины. 'Еще нет' означает, что слоты могут не применяться.", "Indica se o jogo já carregou as peças de modificação deste carro.", "Indique si le jeu a chargé les pièces de modification de cette voiture.") BREAK
            CASE 10 g_selected_description = TR("Remove every lowrider modification on this car.", "Elimina todas las modificaciones lowrider de este coche.", "移除此车上的所有低底盘改装。", "Alle Lowrider-Modifikationen an diesem Fahrzeug entfernen.", "この車のすべてのローライダー改造を解除します。", "Удалить все модификации лоурайдера с этой машины.", "Remove todas as modificações lowrider deste carro.", "Supprimer toutes les modifications lowrider de cette voiture.") BREAK
        ENDSWITCH
    ELIF g_wheeltyre_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Choose the wheel family: Sport through Supermod 5.", "Elige la categoría de ruedas: desde Deportivas hasta Supermod 5.", "选择车轮类别：从跑车轮毂到超级改装 5。", "Felgenkategorie wählen: Sport bis Supermod 5.", "ホイールカテゴリを選択します（スポーツ〜スーパーMOD 5）。", "Выберите категорию колес: от Спортивных до Супермод 5.", "Escolha a categoria de rodas: de Esportivas até Supermod 5.", "Choisir la catégorie de roues : de Sport à Supermod 5.") BREAK
            CASE 1 g_selected_description = TR("Variant A or B of the wheel design. Applied by the row below.", "Variante A o B del diseño de rueda. Se aplica con la fila inferior.", "车轮样式的 A 或 B 变体。通过下一行应用。", "Variante A oder B des Felgendesigns. Wird über die Zeile darunter angewendet.", "ホイールデザインのバリエーションAまたはB。下の行で適用します。", "Вариант A или B дизайна колес. Применяется строкой ниже.", "Variante A ou B do design da roda. Aplicada pela linha abaixo.", "Variante A ou B du modèle de jante. Appliquée par la ligne ci-dessous.") BREAK
            CASE 2 g_selected_description = TR("Target the front/all wheels or the bike rear wheel.", "Apunta a las ruedas delanteras/todas o a la rueda trasera de moto.", "选择作用于前轮/全部车轮，或摩托车后轮。", "Vorderräder/alle Räder oder das Motorrad-Hinterrad auswählen.", "対象を前輪/全輪、またはバイクの後輪に指定します。", "Выбрать передние/все колеса или заднее колесо мотоцикла.", "Direcionar para as rodas dianteiras/todas ou para a roda traseira de moto.", "Cibler les roues avant/toutes les roues ou la roue arrière de moto.") BREAK
            CASE 3 g_selected_description = TR("Apply the chosen wheel family.", "Aplica la categoría de ruedas elegida.", "应用所选的车轮类别。", "Gewählte Felgenkategorie anwenden.", "選択したホイールカテゴリを適用します。", "Применить выбранную категорию колес.", "Aplicar a categoria de rodas escolhida.", "Appliquer la catégorie de roues choisie.") BREAK
            CASE 4 g_selected_description = TR("Apply the chosen variation to the current wheel design.", "Aplica la variación elegida al diseño de rueda actual.", "将所选变体应用到当前车轮样式。", "Gewählte Variante auf das aktuelle Felgendesign anwenden.", "現在のホイールデザインに選択したバリエーションを適用します。", "Применить выбранную вариацию к текущему дизайну колес.", "Aplicar a variação escolhida ao design de roda atual.", "Appliquer la variante choisie au modèle de roue actuel.") BREAK
            CASE 5 g_selected_description = TR("Which variation the car's wheel slot currently has fitted.", "Qué variación tiene instalada actualmente la ranura de ruedas del coche.", "当前车辆车轮槽位已安装的变体。", "Welche Variante aktuell im Felgenslot des Fahrzeugs montiert ist.", "現在車両のホイールスロットに装着されているバリエーション。", "Какая вариация колес сейчас установлена на машине.", "Qual variação está instalada atualmente nas rodas do carro.", "Quelle variante est actuellement montée sur les roues de la voiture.") BREAK
            CASE 6 g_selected_description = TR("Whether the car has the tyre smoke modification fitted.", "Indica si el coche tiene instalada la modificación de humo de neumáticos.", "显示车辆是否已安装轮胎烟雾改装。", "Ob das Fahrzeug die Reifenrauch-Modifikation eingebaut hat.", "タイヤスモーク改造が装着されているかを表示します。", "Установлена ли на машине модификация дыма из-под колес.", "Indica se o carro possui a modificação de fumaça dos pneus instalada.", "Indique si la modification de fumée de pneu est installée sur la voiture.") BREAK
            CASE 7 g_selected_description = TR("Fit or remove the tyre smoke modification.", "Instala o retira la modificación de humo de neumáticos.", "安装或移除轮胎烟雾改装。", "Reifenrauch-Modifikation ein- oder ausbauen.", "タイヤスモーク改造を装着または解除します。", "Установить или снять модификацию дыма из-под колес.", "Instalar ou remover a modificação de fumaça dos pneus.", "Installer ou retirer la modification de fumée de pneu.") BREAK
            CASE 8 g_selected_description = TR("ON lets tyres burst normally; OFF makes them unburstable.", "ACT. permite que los neumáticos revienten; DES. los hace antibalas.", "开：轮胎可正常爆胎；关：防爆轮胎。", "EIN lässt Reifen normal platzen; AUS macht sie kugelsicher.", "ONで通常通りパンクし、OFFでパンクしなくなります（防弾タイヤ）。", "ВКЛ: шины лопаются обычно; ВЫКЛ: пуленепробиваемые покрышки.", "LIG. permite que os pneus estourem normalmente; DESL. os torna à prova de balas.", "OUI permet aux pneus d'éclater normalement ; NON les rend increvables.") BREAK
            CASE 9 g_selected_description = TR("Soften the suspension so the car can sit lower - the game's own stance flag.", "Suaviza la suspensión para que el coche quede más bajo (opción de postura del juego).", "软化悬挂使车身更低——使用游戏原生低姿态标记。", "Federung weicher stellen, damit das Auto tiefer liegt - das spielinterne Stance-Flag.", "サスペンションを柔らかくして車高を下げます（ゲーム内のスタンスフラグ）。", "Смягчить подвеску для более низкой посадки (штатный флаг стенса в игре).", "Suaviza a suspensão para o carro ficar mais baixo (ajuste nativo de postura do jogo).", "Assouplir la suspension pour abaisser la voiture (option de posture native du jeu).") BREAK
        ENDSWITCH
    ELIF g_lsc_extras_open
        SWITCH g_item
            CASE 0 g_selected_description = TR("Choose a livery. '< Stock >' removes it. Applies as you move it.", "Elige un diseño. '< Stock >' lo quita. Se aplica al cambiarlo.", "选择涂装。'< 原厂 >'可移除涂装。切换时立即生效。", "Design wählen. '< Standard >' entfernt es. Wird sofort angewendet.", "ペイントジョブ（リバリー）を選択します。「< 標準 >」で解除。移動時に即適用。", "Выберите раскраску. '< Сток >' убирает ее. Применяется сразу.", "Escolha uma estampa. '< Original >' remove. Aplica conforme você move.", "Choisir une livrée. '< Origine >' la retire. S'applique dès le déplacement.") BREAK
            CASE 1 g_selected_description = TR("How many liveries this car offers.", "Cuántos diseños ofrece este coche.", "此车辆提供的涂装数量。", "Wie viele Designs dieses Fahrzeug bietet.", "この車が対応しているペイントジョブの数。", "Сколько раскрасок доступно для этой машины.", "Quantas estampas este carro oferece.", "Nombre de livrées proposées par cette voiture.") BREAK
            CASE 2 g_selected_description = TR("The game's own name for the selected livery.", "El nombre propio del juego para el diseño seleccionado.", "游戏内所选涂装的原生名称。", "Der spielinterne Name für das gewählte Design.", "選択したペイントジョブのゲーム内名称。", "Собственное название выбранной раскраски в игре.", "O nome nativo do jogo para a estampa selecionada.", "Le nom utilisé par le jeu pour la livrée sélectionnée.") BREAK
            CASE 3 g_selected_description = TR("Apply the chosen livery again.", "Vuelve a aplicar el diseño elegido.", "再次应用所选的涂装。", "Gewähltes Design erneut anwenden.", "選択したペイントジョブを再適用します。", "Повторно применить выбранную раскраску.", "Aplicar novamente a estampa escolhida.", "Appliquer à nouveau la livrée choisie.") BREAK
            CASE 4 g_selected_description = TR("Choose one of the car's 12 extras, such as roof racks, light bars and spoiler variants.", "Elige uno de los 12 extras del coche, como bacas, barras de luces o alerones.", "选择车辆的 12 个附加部件之一，如车顶架、灯条和尾翼变体。", "Eines der 12 Fahrzeug-Extras wählen, z. B. Dachträger, Lichtbalken oder Spoiler.", "ルーフラックやライトバーなど、車両の12個のエクストラから1つを選択します。", "Выберите одну из 12 экстр машины (багажники на крыше, люстры, спойлеры и т.д.).", "Escolha um dos 12 extras do carro, como bagageiros, barras de luz e aerofólios.", "Choisir l'un des 12 extras de la voiture (galeries de toit, rampes de phares, ailerons, etc.).") BREAK
            CASE 5 g_selected_description = TR("Whether this car actually carries the selected extra.", "Indica si este coche dispone realmente del extra seleccionado.", "此车辆是否实际拥有所选的附加部件。", "Ob dieses Fahrzeug das gewählte Extra tatsächlich besitzt.", "この車に選択したエクストラが存在するかを表示します。", "Есть ли у этой машины выбранная дополнительная деталь.", "Indica se este carro realmente possui o extra selecionado.", "Indique si cette voiture possède réellement l'extra sélectionné.") BREAK
            CASE 6 g_selected_description = TR("Whether the selected extra is currently on or off.", "Indica si el extra seleccionado está activado o desactivado.", "所选附加部件当前处于开启还是关闭状态。", "Ob das gewählte Extra aktuell ein- oder ausgeschaltet ist.", "選択したエクストラが現在ONかOFFかを表示します。", "Включена или выключена выбранная экстра в данный момент.", "Indica se o extra selecionado está ligado ou desligado.", "Indique si l'extra sélectionné est actuellement activé ou désactivé.") BREAK
            CASE 7 g_selected_description = TR("Turn the selected extra on or off.", "Activa o desactiva el extra seleccionado.", "开启或关闭所选的附加部件。", "Gewähltes Extra ein- oder ausschalten.", "選択したエクストラのON/OFFを切り替えます。", "Включить или выключить выбранную экстру.", "Ativar ou desativar o extra selecionado.", "Activer ou désactiver l'extra sélectionné.") BREAK
            CASE 8 g_selected_description = TR("Fit every extra this car carries.", "Instala todos los extras disponibles en este coche.", "安装此车拥有的所有附加部件。", "Alle vorhandenen Extras an diesem Fahrzeug anbringen.", "この車が持つすべてのエクストラを装着します。", "Установить все доступные экстры на эту машину.", "Instalar todos os extras disponíveis neste carro.", "Installer tous les extras disponibles sur cette voiture.") BREAK
            CASE 9 g_selected_description = TR("Remove every extra this car carries.", "Quita todos los extras de este coche.", "移除此车拥有的所有附加部件。", "Alle vorhandenen Extras von diesem Fahrzeug entfernen.", "この車のすべてのエクストラを取り外します。", "Снять все экстры с этой машины.", "Remover todos os extras deste carro.", "Retirer tous les extras de cette voiture.") BREAK
        ENDSWITCH
    ELIF g_bennys_open
        // All twelve rows are the same action on a different car, so the
        // description does not vary by row - one honest sentence covers the page.
        g_selected_description = TR("Spawn this car. These Benny's variants are the only cars hydraulics and the lowrider interiors work on. Each row is checked against this build, so a car it does not ship is marked Absent and cannot be spawned.", "Genera este coche. Estas variantes de Benny's son los únicos coches en los que funcionan la hidráulica y los interiores lowrider.", "生成此车辆。这些班尼定制版车型是唯一支持液压系统和低底盘内饰的车辆。", "Dieses Auto spawnen. Diese Benny's-Varianten sind die einzigen Fahrzeuge, bei denen Hydraulik und Lowrider-Innenräume funktionieren.", "この車を出現させます。これらのベニーズ仕様車のみハイドロとローライダー内装が機能します。", "Создать эту машину. Только на этих кастом-версиях Benny's работают гидравлика и салоны лоурайдеров.", "Gera este carro. Estas variantes da Benny's são os únicos carros em que a hidráulica e os interiores lowrider funcionam.", "Faire apparaître cette voiture. Ces variantes Benny's sont les seules où l'hydraulique et les intérieurs lowrider fonctionnent.")
    ELIF g_support_open
        // Read-only diagnostics; one description covers the page for the same
        // reason as the Bennys page.
        g_selected_description = TR("Live readback for the car you are in: whether it carries a lowrider mod kit, whether it can take hydraulics, how many of the 22 lowrider slots exist on it, and whether this build ships its Benny's variant. Nothing on this page changes the car.", "Lectura en vivo del coche actual: indica si tiene kit lowrider, hidráulica, cuántas de las 22 ranuras existen y si incluye variante de Benny's. No modifica el coche.", "当前车辆实时诊断：显示是否有低底盘套件、是否支持液压、22 个低底盘槽位数量及班尼变体。此页不会修改车辆。", "Live-Diagnose für das aktuelle Fahrzeug: Lowrider-Mod-Kit, Hydraulik, Anzahl der 22 Lowrider-Slots und Benny's-Variante. Ändert nichts am Auto.", "現在の車両のリアルタイム診断（ローライダーキット、ハイドロ対応、22スロットの有無、ベニーズ仕様の有無）。車両は変更されません。", "Диагностика текущей машины: наличие лоурайдер-кита, гидравлики, число слотов из 22 и наличие версии Benny's. Ничего не меняет.", "Diagnóstico em tempo real do carro atual: kit lowrider, hidráulica, quantos dos 22 espaços existem e variante Benny's. Nada aqui altera o carro.", "Diagnostic en direct de la voiture actuelle : kit lowrider, hydraulique, nombre d'emplacements sur 22 et variante Benny's. Ne modifie pas la voiture.")
    ELIF g_chauffeur_open
        // ---- Chauffeur submenu (Vehicle Settings row 25) ----
        // Child pages first, for the same reason the LSC child pages are: the
        // parent's g_chauffeur_open flag stays TRUE while one of them is open.
        IF g_chauffeur_armed_open
            IF g_item = 0 g_selected_description = TR("Arm the driver. He will shoot at hostile peds near the car.", "Arma al conductor. Disparará a los peatones hostiles cerca del coche.", "武装司机。他会向车辆附近的敌对行人开枪。", "Fahrer bewaffnen. Er schießt auf feindliche Passanten in Fahrzeugnähe.", "運転手を武装させます。車両近くの敵対的なNPCを銃撃します。", "Вооружить водителя. Он будет стрелять по враждебным NPC рядом с машиной.", "Arma o motorista. Ele atirará em pedestres hostis perto do carro.", "Armer le chauffeur. Il tirera sur les PNJ hostiles près de la voiture.") ENDIF
            IF g_item > 0 g_selected_description = TR("Give the driver this weapon. One-handed guns fire properly from the driver's seat.", "Entrega esta arma al conductor. Las armas de una mano disparan bien desde el asiento.", "给司机配备此武器。单手枪械可在驾驶座正常射击。", "Dem Fahrer diese Waffe geben. Einhandwaffen feuern vom Fahrersitz aus korrekt.", "運転手にこの武器を持たせます。片手武器は運転席から正常に発砲できます。", "Дать водителю это оружие. Одноручное оружие корректно стреляет с водительского места.", "Dá esta arma ao motorista. Armas de uma mão disparam corretamente do banco do motorista.", "Donner cette arme au chauffeur. Les armes à une main tirent correctement depuis le siège conducteur.") ENDIF
        ELIF g_chauffeur_vehicle_open
            g_selected_description = TR("Choose the chauffeur's car. Every one is spawned black. Takes effect on the next spawn.", "Elige el coche del chófer. Todos se generan en negro. Surte efecto al volver a generarlo.", "选择专属司机的座驾。所有车辆均生成为黑色，下次生成时生效。", "Fahrzeug des Chauffeurs wählen. Jedes wird in Schwarz gespawnt. Wirksam beim nächsten Spawnen.", "運転手の車両を選択します。すべて黒色で出現し、次回出現時から有効になります。", "Выберите машину шофера. Все создаются черными. Вступает в силу при следующем спавне.", "Escolha o carro do motorista. Todos são gerados na cor preta. Vale no próximo spawn.", "Choisir la voiture du chauffeur. Toutes apparaissent en noir. Prend effet à la prochaine apparition.")
        ELIF g_chauffeur_ped_open
            IF g_item = 0 g_selected_description = TR("Search by PED model name; Extremely case sensitive. ALWAYS USE CAPS!", "Busca por nombre de modelo PED; sensible a mayúsculas. ¡USA SIEMPRE MAYÚSCULAS!", "按 PED 模型名称搜索；严格区分大小写，请务必使用大写字母！", "Nach PED-Modellnamen suchen; extrem groß-/kleinschreibungsempfindlich. IMMER GROSSBUCHSTABEN!", "PEDモデル名で検索（大文字・小文字を厳密に区別します。常に大文字で入力！）。", "Поиск по имени модели PED; чувствителен к регистру. ВСЕГДА ИСПОЛЬЗУЙТЕ ЗАГЛАВНЫЕ БУКВЫ!", "Pesquise pelo nome do modelo PED; diferencia maiúsculas. USE SEMPRE MAIÚSCULAS!", "Rechercher par nom de modèle PED ; très sensible à la casse. UTILISEZ TOUJOURS DES MAJUSCULES !") ENDIF
            IF g_item = 1 g_selected_description = TR("Pick a random validated PED model for the chauffeur.", "Elige un modelo PED aleatorio validado para el chófer.", "为专属司机随机选择一个已验证的 PED 模型。", "Wählt ein zufälliges geprüftes PED-Modell für den Chauffeur.", "運転手用に検証済みのランダムなPEDモデルを選択します。", "Выбрать случайную проверенную модель PED для шофера.", "Escolha um modelo PED aleatório validado para o motorista.", "Choisir un modèle PED aléatoire validé pour le chauffeur.") ENDIF
            IF g_item > 1 g_selected_description = TR("Use the selected PED model for the chauffeur.", "Usa el modelo PED seleccionado para el chófer.", "将所选 PED 模型用于专属司机。", "Das gewählte PED-Modell für den Chauffeur verwenden.", "選択したPEDモデルを運転手に使用します。", "Использовать выбранную модель PED для шофера.", "Usar o modelo PED selecionado para o motorista.", "Utiliser le modèle PED sélectionné pour le chauffeur.") ENDIF
        ELSE
            SWITCH g_item
                CASE 0 g_selected_description = TR("Spawn the chauffeur car and sit the player in the passenger seat. Press again to replace it.", "Genera el coche con chófer y sienta al jugador de pasajero. Pulsa de nuevo para reemplazarlo.", "生成专属座驾并将玩家安置在乘客座位。再次按下可替换车辆。", "Chauffeur-Fahrzeug spawnen und Spieler auf den Beifahrersitz setzen. Erneut drücken zum Ersetzen.", "運転手付きの車を出現させ、助手席に乗ります。もう一度押すと車両を交換します。", "Создать машину с шофером и посадить игрока на пассажирское место. Нажмите снова для замены.", "Gera o carro com motorista e coloca o jogador no banco do passageiro. Pressione novamente para substituir.", "Faire apparaître la voiture avec chauffeur et asseoir le joueur en passager. Appuyer à nouveau pour remplacer.") BREAK
                CASE 1 g_selected_description = TR("Open the chauffeur PED list; shows the current driver model.", "Abre la lista de PED del chófer; muestra el modelo de conductor actual.", "打开司机 PED 列表；显示当前司机模型。", "PED-Liste des Chauffeurs öffnen; zeigt das aktuelle Fahrermodell.", "運転手のPEDリストを開きます（現在のモデルを表示）。", "Открыть список PED шофера; показывает текущую модель водителя.", "Abre a lista de PEDs do motorista; mostra o modelo atual.", "Ouvrir la liste des PED du chauffeur ; affiche le modèle actuel.") BREAK
                CASE 2 g_selected_description = TR("Open the chauffeur vehicle list; shows the current car.", "Abre la lista de vehículos del chófer; muestra el coche actual.", "打开司机座驾列表；显示当前车型。", "Fahrzeugliste des Chauffeurs öffnen; zeigt das aktuelle Auto.", "運転手の車両リストを開きます（現在の車両を表示）。", "Открыть список транспорта шофера; показывает текущую машину.", "Abre a lista de veículos do motorista; mostra o carro atual.", "Ouvrir la liste des véhicules du chauffeur ; affiche la voiture actuelle.") BREAK
                CASE 3 g_selected_description = TR("Normal obeys traffic; Rushed hurries; Aggressive never stops for cars or peds and breaks all traffic laws.", "Normal respeta el tráfico; Apresurado va rápido; Agresivo no se detiene ante coches ni peatones.", "正常：遵守交规；急促：加快车速；激进：无视车辆行人与一切交通规则。", "Normal beachtet den Verkehr; Eilig fährt zügig; Aggressiv hält nie an und ignoriert alle Verkehrsregeln.", "通常は交通法規を遵守、急ぎは迅速に走行、アグレッシブは車や歩行者を無視して暴走します。", "Обычный соблюдает ПДД; Спешащий торопится; Агрессивный таранит поток и нарушает все правила.", "Normal respeita o trânsito; Apressado corre; Agressivo não para por carros ou pedestres e ignora as leis.", "Normal respecte le code ; Pressé se dépêche ; Agressif ne s'arrête jamais et enfreint toutes les règles.") BREAK
                CASE 4 g_selected_description = TR("Let the chauffeur drive through red lights. Only affects Normal, which is the mode that stops at them.", "Permite al chófer saltarse los semáforos en rojo. Solo afecta al modo Normal.", "允许司机闯红灯。仅对会停等红灯的'正常'模式生效。", "Chauffeur darf rote Ampeln überfahren. Betrifft nur den Modus Normal.", "運転手が赤信号を無視して進行できるようにします（信号待ちをする通常モードのみ影響）。", "Разрешить шоферу проезжать на красный свет (влияет только на Обычный режим).", "Permite que o motorista avance sinais vermelhos. Afeta apenas o modo Normal.", "Permettre au chauffeur de brûler les feux rouges. N'affecte que le mode Normal.") BREAK
                CASE 5 g_selected_description = TR("Make the chauffeur invincible. The car is not affected.", "Hace invencible al chófer. El coche no se ve afectado.", "使专属司机处于无敌状态（不影响车辆本身）。", "Macht den Chauffeur unverwundbar. Das Auto ist davon nicht betroffen.", "運転手を無敵にします（車両自体は対象外）。", "Сделать шофера неуязвимым. На саму машину не влияет.", "Torna o motorista invencível. O carro não é afetado.", "Rendre le chauffeur invincible. La voiture n'est pas affectée.") BREAK
                CASE 6 g_selected_description = TR("Stop the chauffeur car's tyres from bursting.", "Evita que revienten los neumáticos del coche del chófer.", "防止专属座驾的轮胎爆胎。", "Verhindert das Platzen der Reifen am Chauffeur-Fahrzeug.", "運転手の車両のタイヤがパンクしないようにします。", "Защитить шины машины шофера от проколов и прострелов.", "Impede que os pneus do carro do motorista estourem.", "Empêcher les pneus de la voiture du chauffeur d'éclater.") BREAK
                CASE 7 g_selected_description = TR("Arm the chauffeur and choose his weapon; opens the armed driver page.", "Arma al chófer y elige su arma; abre la página de conductor armado.", "武装司机并选择其武器；打开武装司机页面。", "Chauffeur bewaffnen und Waffe wählen; öffnet die Seite für bewaffnete Fahrer.", "運転手を武装させ、武器を選択します（武装ドライバー設定を開きます）。", "Вооружить шофера и выбрать ему оружие; открывает страницу вооружения.", "Arme o motorista e escolha sua arma; abre a página de motorista armado.", "Armer le chauffeur et choisir son arme ; ouvre la page du chauffeur armé.") BREAK
            ENDSWITCH
        ENDIF
    ELSE
        SWITCH g_tab
            CASE 0
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Open the portable radio submenu.", "Abre el submenú de la radio portátil.", "打开随身电台子菜单。", "Untermenü für das tragbare Radio öffnen.", "ポータブルラジオのサブメニューを開きます。", "Открыть подменю переносного радио.", "Abre o submenu do rádio portátil.", "Ouvrir le sous-menu de la radio portable.") BREAK
                    CASE 1 g_selected_description = TR("Make the player immune to damage.", "Hace que el jugador sea inmune al daño.", "使玩家免疫一切伤害。", "Macht den Spieler immun gegen Schaden.", "プレイヤーをあらゆるダメージから無敵にします。", "Сделать игрока неуязвимым к любому урону.", "Torna o jogador imune a danos.", "Rendre le joueur insensible aux dégâts.") BREAK
                    CASE 2 g_selected_description = TR("Restore health and armor to full.", "Restaura la salud y el blindaje al máximo.", "将生命值和护甲恢复至满值。", "Gesundheit und Panzerung vollständig wiederherstellen.", "体力とアーマーを最大まで回復します。", "Полностью восстановить здоровье и броню.", "Restaura a vida e o colete ao máximo.", "Restaurer la santé et l'armure au maximum.") BREAK
                    CASE 3 g_selected_description = TR("Hide the player model from the world.", "Oculta el modelo del jugador en el mundo.", "在世界中隐藏玩家角色模型。", "Spielermodell in der Spielwelt unsichtbar machen.", "プレイヤーの姿を周囲から見えなくします。", "Скрыть модель игрока от окружающего мира.", "Oculta o modelo do jogador no mundo.", "Rendre le modèle du joueur invisible.") BREAK
                    CASE 4 g_selected_description = TR("Open the searchable PED model selector.", "Abre el selector de modelos PED con búsqueda.", "打开可搜索的 PED 模型选择器。", "Durchsuchbare PED-Modellauswahl öffnen.", "検索可能なPEDモデル選択メニューを開きます。", "Открыть выбор модели персонажа (PED) с поиском.", "Abre o seletor de modelos PED com busca.", "Ouvrir le sélecteur de modèles PED avec recherche.") BREAK
                    CASE 5 g_selected_description = TR("Open the clothing and apparel editor.", "Abre el editor de ropa y vestimenta.", "打开服装与外观编辑器。", "Kleidungs- und Outfit-Editor öffnen.", "服装・コスチュームエディターを開きます。", "Открыть редактор одежды и внешнего вида.", "Abre o editor de roupas e trajes.", "Ouvrir l'éditeur de vêtements et de tenues.") BREAK
                    CASE 6 g_selected_description = TR("Open the bodyguard management submenu.", "Abre el submenú de gestión de guardaespaldas.", "打开保镖管理子菜单。", "Untermenü zur Bodyguard-Verwaltung öffnen.", "ボディガード管理サブメニューを開きます。", "Открыть подменю управления телохранителями.", "Abre o submenu de gerenciamento de guarda-costas.", "Ouvrir le sous-menu de gestion des gardes du corps.") BREAK
                    CASE 7 g_selected_description = TR("Open the attacker management submenu.", "Abre el submenú de gestión de atacantes.", "打开袭击者管理子菜单。", "Untermenü zur Angreifer-Verwaltung öffnen.", "襲撃者管理サブメニューを開きます。", "Открыть подменю управления нападающими.", "Abre o submenu de gerenciamento de atacantes.", "Ouvrir le sous-menu de gestion des assaillants.") BREAK
                    CASE 8 g_selected_description = TR("Stick moves, Y up, B down. No entry while on.", "El stick mueve, Y sube, B baja. No permite entrar a vehículos mientras está activo.", "摇杆移动，Y 上升，B 下降。开启时无法进入载具。", "Stick bewegt, Y hoch, B runter. Kein Einsteigen während aktiv.", "スティックで移動、Yで上昇、Bで下降。有効中は乗車不可。", "Стик — движение, Y — вверх, B — вниз. Посадка в авто отключена.", "Analógico move, Y sobe, B desce. Sem entrar em veículos enquanto ativo.", "Stick pour bouger, Y monter, B descendre. Entrée véhicule désactivée.") BREAK
                    CASE 9 g_selected_description = TR("Invisible first-person fly. Y up, B down", "Vuelo invisible en primera persona. Y sube, B baja.", "第一人称隐身飞行。Y 上升，B 下降。", "Unsichtbarer Ego-Flugmodus. Y hoch, B runter.", "一人称視点の透明飛行モード。Yで上昇、Bで下降。", "Невидимый полет от первого лица. Y — вверх, B — вниз.", "Voo invisível em primeira pessoa. Y sobe, B desce.", "Vol invisible à la première personne. Y monter, B descendre.") BREAK
                    CASE 10 g_selected_description = TR("Keep the player's underwater air supply full.", "Mantiene lleno el suministro de aire bajo el agua.", "保持玩家水下氧气充足。", "Unterwasser-Atemluft des Spielers dauerhaft voll halten.", "水中の酸素ゲージを常に最大に保ちます。", "Поддерживать бесконечный запас кислорода под водой.", "Mantém o fôlego do jogador sempre cheio debaixo d'água.", "Maintenir la jauge d'oxygène sous l'eau au maximum.") BREAK
                    CASE 11 g_selected_description = TR("Keep the character's special ability charged.", "Mantiene cargada la habilidad especial del personaje.", "保持角色特殊能力槽常满。", "Spezialfähigkeit des Charakters dauerhaft aufgeladen halten.", "キャラクターの特殊スキルゲージを常に満タンに保ちます。", "Поддерживать спецспособность персонажа полностью заряженной.", "Mantém a habilidade especial do personagem sempre carregada.", "Maintenir la compétence spéciale du personnage chargée.") BREAK
                    CASE 12 g_selected_description = TR("Increase running speed.", "Aumenta la velocidad al correr.", "提高奔跑速度。", "Laufgeschwindigkeit erhöhen.", "走る速度を上げます。", "Увеличить скорость бега.", "Aumenta a velocidade de corrida.", "Augmenter la vitesse de course.") BREAK
                    CASE 13 g_selected_description = TR("Increase swimming speed.", "Aumenta la velocidad al nadar.", "提高游泳速度。", "Schwimmgeschwindigkeit erhöhen.", "泳ぐ速度を上げます。", "Увеличить скорость плавания.", "Aumenta a velocidade de nado.", "Augmenter la vitesse de nage.") BREAK
                    CASE 14 g_selected_description = TR("Allow the player to jump higher.", "Permite al jugador saltar mucho más alto.", "允许玩家跳得更高。", "Dem Spieler höhere Sprünge ermöglichen.", "通常より高くジャンプできるようにします。", "Позволяет игроку прыгать значительно выше.", "Permite que o jogador pule mais alto.", "Permettre au joueur de sauter plus haut.") BREAK
                    CASE 15 g_selected_description = TR("Prevent the player from ragdolling.", "Evita que el jugador caiga derribado (ragdoll).", "防止玩家摔倒或进入布娃娃状态。", "Verhindert, dass der Spieler hinfällt (Ragdoll).", "プレイヤーが転倒（ラグドール化）しないようにします。", "Предотвращает падение игрока с ног (рэгдолл).", "Impede que o jogador caia no chão (ragdoll).", "Empêcher le joueur de tomber à la renverse (ragdoll).") BREAK
                    CASE 16 g_selected_description = TR("Keep a parachute available whenever needed.", "Mantiene un paracaídas disponible siempre que se necesite.", "随时保持降落伞可用。", "Immer einen Fallschirm bereithalten.", "いつでもパラシュートを使用できるようにします。", "Всегда держать парашют в инвентаре игрока.", "Mantém um paraquedas sempre disponível quando necessário.", "Garder un parachute disponible à tout moment.") BREAK
                    CASE 17 g_selected_description = TR("DPAD Left/Right adjusts by $10,000. A opens keyboard entry.", "Izquierda/Derecha ajusta en $10,000. A abre el teclado.", "方向键左/右每次调整 $10,000。按 A 打开键盘输入。", "Steuerkreuz Links/Rechts ändert um 10.000 $. A öffnet die Tastatur.", "十字キー左右で$10,000ずつ調整。Aでキーボード入力を開きます。", "Влево/Вправо меняет сумму на $10,000. A открывает клавиатуру.", "Esquerda/Direita ajusta em $10.000. A abre o teclado.", "Gauche/Droite ajuste de 10 000 $. A ouvre le clavier.") BREAK
                    CASE 18 g_selected_description = TR("Apply the selected cash amount to the active character.", "Aplica la cantidad de dinero seleccionada al personaje activo.", "将所选金额应用到当前角色。", "Ausgewählten Geldbetrag auf den aktiven Charakter anwenden.", "設定した金額を現在のキャラクターに適用します。", "Применить выбранную сумму денег к текущему персонажу.", "Aplica a quantia de dinheiro selecionada ao personagem ativo.", "Appliquer le montant d'argent sélectionné au personnage actif.") BREAK
                    CASE 19 g_selected_description = TR("Make melee impacts explosive.", "Hace que los golpes cuerpo a cuerpo sean explosivos.", "使近战攻击产生爆炸效果。", "Nahkampftreffer explosiv machen.", "近接攻撃のヒット時に爆発を起こします。", "Сделать удары в ближнем бою взрывными.", "Torna os golpes corpo a corpo explosivos.", "Rendre les impacts au corps à corps explosifs.") BREAK
                    CASE 20 g_selected_description = TR("Launch peds, vehicles and loose props with melee hits.", "Lanza peatones, vehículos y objetos con golpes cuerpo a cuerpo.", "用近战攻击击飞路人、载具和散落物体。", "Passanten, Fahrzeuge und Objekte mit Nahkampftreffern wegschleudern.", "近接攻撃で歩行者、乗り物、オブジェクトを吹き飛ばします。", "Отбрасывать педов, машины и объекты ударами ближнего боя.", "Arremessa pedestres, veículos e objetos com golpes corpo a corpo.", "Projeter les PNJ, véhicules et objets avec des coups au corps à corps.") BREAK
                    CASE 21 g_selected_description = TR("Apply the drunk movement style.", "Aplica el estilo de movimiento de ebrio.", "应用醉酒行走动作风格。", "Betrunkenen Bewegungsstil anwenden.", "酔っ払った歩き方・動きを適用します。", "Применить пьяную походку к персонажу.", "Aplica o estilo de movimento bêbado.", "Appliquer la démarche d'ivresse.") BREAK
                    CASE 22 g_selected_description = TR("Remove blood, wetness, dirt, and visible damage from the player.", "Elimina sangre, humedad, suciedad y heridas visibles del jugador.", "清除玩家身上的血迹、水渍、污垢和可见伤痕。", "Blut, Nässe, Schmutz und sichtbare Schäden vom Spieler entfernen.", "プレイヤーの血痕、濡れ、汚れ、傷跡をきれいに消去します。", "Очистить игрока от крови, воды, грязи и видимых повреждений.", "Remove sangue, água, sujeira e ferimentos visíveis do jogador.", "Retirer le sang, l'humidité, la saleté et les blessures visibles du joueur.") BREAK
                    CASE 23 g_selected_description = TR("Set the player's health to zero.", "Reduce la salud del jugador a cero.", "将玩家的生命值设为零。", "Gesundheit des Spielers auf null setzen.", "プレイヤーの体力をゼロにして自滅します。", "Обнулить здоровье игрока (самоубийство).", "Define a vida do jogador como zero.", "Mettre la santé du joueur à zéro.") BREAK
                    CASE 24 g_selected_description = TR("Silently autosave on a timer while you play. Respects the game's own autosave setting and never fires mid-mission or in a cutscene.", "Guarda automáticamente con temporizador mientras juegas. Respeta el ajuste del juego y no guarda en misiones ni cinemáticas.", "游玩时按计时器静默自动保存。遵循游戏自带的自动保存设置，不在任务或过场动画中触发。", "Speichert beim Spielen zeitgesteuert im Hintergrund. Beachtet die Autosave-Einstellung des Spiels und speichert nie in Missionen oder Zwischensequenzen.", "プレイ中にタイマーで自動セーブします（ミッション中やムービー中は実行されません）。", "Тихое автосохранение по таймеру во время игры. Не срабатывает во время миссий и катсцен.", "Salva automaticamente com temporizador enquanto você joga. Nunca dispara em missões ou cenas.", "Sauvegarde automatique périodique en jeu. Ne se déclenche jamais en mission ou cinématique.") BREAK
                    CASE 25 g_selected_description = TR("Minutes between autosaves. Left/Right changes it by 1; A opens the keyboard. 0 stops the periodic save.", "Minutos entre autoguardados. Izquierda/Derecha cambia de 1 en 1; A abre el teclado. 0 detiene el guardado.", "自动保存间隔分钟数。左/右每次增减 1；按 A 打开键盘输入。设为 0 停止定时保存。", "Minuten zwischen Autosaves. Links/Rechts ändert um 1; A öffnet die Tastatur. 0 stoppt das Speichern.", "オートセーブの間隔（分）。左右で1ずつ変更、Aでキーボード入力。0で停止します。", "Интервал автосохранения в минутах. Влево/Вправо меняет на 1; A — клавиатура. 0 отключает таймер.", "Minutos entre salvamentos automáticos. Esquerda/Direita altera em 1; A abre o teclado. 0 desativa.", "Minutes entre les sauvegardes auto. Gauche/Droite change de 1 ; A ouvre le clavier. 0 arrête.") BREAK
                ENDSWITCH
                BREAK
            CASE 1
                IF g_weapon_upgrades_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Refill ammunition for the weapon currently in hand.", "Recarga al máximo la munición del arma actual.", "补充当前手持武器的弹药。", "Munition für die aktuell gehaltene Waffe auffüllen.", "現在手に持っている武器の弾薬を補充します。", "Пополнить боезапас текущего оружия в руках.", "Recarrega a munição da arma atualmente em mãos.", "Recharger les munitions de l'arme actuellement en main.") BREAK
                        CASE 1 g_selected_description = TR("Give or remove the best magazine available for this weapon.", "Equipa o quita el mejor cargador disponible para esta arma.", "为当前武器安装或移除最佳弹匣。", "Bestes verfügbares Magazin für diese Waffe anbringen oder entfernen.", "この武器に利用可能な最高のマガジンを装着または解除します。", "Установить или снять лучший доступный магазин для этого оружия.", "Equipa ou remove o melhor carregador disponível para esta arma.", "Installer ou retirer le meilleur chargeur disponible pour cette arme.") BREAK
                        CASE 2 g_selected_description = TR("Give or remove the flashlight for this weapon.", "Equipa o quita la linterna para esta arma.", "为当前武器安装或移除战术手电。", "Taschenlampe für diese Waffe anbringen oder entfernen.", "この武器のフラッシュライトを装着または解除します。", "Установить или снять фонарик для этого оружия.", "Equipa ou remove a lanterna desta arma.", "Installer ou retirer la lampe torche pour cette arme.") BREAK
                        CASE 3 g_selected_description = TR("Give or remove the suppressor for this weapon.", "Equipa o quita el silenciador para esta arma.", "为当前武器安装或移除消音器。", "Schalldämpfer für diese Waffe anbringen oder entfernen.", "この武器のサプレッサーを装着または解除します。", "Установить или снять глушитель для этого оружия.", "Equipa ou remove o silenciador desta arma.", "Installer ou retirer le silencieux pour cette arme.") BREAK
                        CASE 4 g_selected_description = TR("Give or remove the grip for this weapon.", "Equipa o quita la empuñadura para esta arma.", "为当前武器安装或移除握把。", "Griff für diese Waffe anbringen oder entfernen.", "この武器のグリップを装着または解除します。", "Установить или снять рукоятку для этого оружия.", "Equipa ou remove a empunhadura desta arma.", "Installer ou retirer la poignée pour cette arme.") BREAK
                        CASE 5 g_selected_description = TR("Give or remove the scope for this weapon.", "Equipa o quita la mira para esta arma.", "为当前武器安装或移除瞄准镜。", "Zielfernrohr für diese Waffe anbringen oder entfernen.", "この武器のスコープを装着または解除します。", "Установить или снять прицел для этого оружия.", "Equipa ou remove a mira desta arma.", "Installer ou retirer la lunette pour cette arme.") BREAK
                        CASE 6 g_selected_description = TR("Change the weapon tint color with Left/Right.", "Cambia el tinte de color del arma con Izquierda/Derecha.", "使用左/右方向键更改武器涂装颜色。", "Waffenfarbton mit Links/Rechts ändern.", "左右キーで武器のカラーリングを変更します。", "Изменить расцветку оружия кнопками Влево/Вправо.", "Altere a cor da pintura da arma com Esquerda/Direita.", "Changer la teinte de l'arme avec Gauche/Droite.") BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Give every supported base-game and installed DLC weapon.", "Entrega todas las armas compatibles del juego base y DLC instalados.", "获取所有支持的本体和已安装 DLC 武器。", "Alle unterstützten Waffen aus Basisspiel und installierten DLCs geben.", "本編および導入済みDLCの対応するすべての武器を入手します。", "Выдать все поддерживаемое оружие базовой игры и установленных DLC.", "Entrega todas as armas compatíveis do jogo base e DLCs instalados.", "Donner toutes les armes compatibles du jeu de base et des DLC installés.") BREAK
                        CASE 1 g_selected_description = TR("Choose one weapon with Left/Right, then press A to give it.", "Elige un arma con Izquierda/Derecha y pulsa A para obtenerla.", "用左/右方向键选择一把武器，按 A 获取。", "Waffe mit Links/Rechts wählen und mit A erhalten.", "左右で武器を選択し、Aボタンで入手します。", "Выберите оружие кнопками Влево/Вправо и нажмите A для выдачи.", "Escolha uma arma com Esquerda/Direita e pressione A para recebê-la.", "Choisir une arme avec Gauche/Droite, puis appuyer sur A pour l'obtenir.") BREAK
                        CASE 2 g_selected_description = TR("Keep the player's ammunition from running out.", "Evita que se agote la munición del jugador.", "保持玩家弹药无限，不会耗尽。", "Verhindert, dass dem Spieler die Munition ausgeht.", "プレイヤーの弾薬が減らないようにします。", "Сделать запас патронов игрока бесконечным.", "Impede que a munição do jogador acabe.", "Empêcher les munitions du joueur de s'épuiser.") BREAK
                        CASE 3 g_selected_description = TR("Prevent the current magazine from being depleted.", "Evita que se vacíe el cargador actual (sin recargar).", "防止当前弹匣子弹消耗（无需换弹）。", "Verhindert, dass sich das aktuelle Magazin leert.", "現在のマガジンの弾が減らないようにします（リロード不要）。", "Бесконечные патроны в магазине (стрельба без перезарядки).", "Impede que o carregador atual se esgote (sem recarregar).", "Empêcher le chargeur actuel de se vider (sans recharger).") BREAK
                        CASE 4 g_selected_description = TR("Refill ammunition for every weapon the player owns.", "Recarga al máximo la munición de todas las armas que posee el jugador.", "补满玩家拥有的所有武器的弹药。", "Munition für jede Waffe im Besitz des Spielers auffüllen.", "所持しているすべての武器の弾薬を満タンに補充します。", "Пополнить боезапас всего оружия, имеющегося у игрока.", "Recarrega a munição de todas as armas que o jogador possui.", "Recharger les munitions de toutes les armes possédées.") BREAK
                        CASE 5 g_selected_description = TR("Open upgrades for the weapon currently in hand.", "Abre las mejoras para el arma que tienes en la mano.", "打开当前手持武器的配件与改装菜单。", "Upgrades für die aktuell gehaltene Waffe öffnen.", "現在手に持っている武器のアップグレードを開きます。", "Открыть модификации для текущего оружия в руках.", "Abre as melhorias para a arma atualmente em mãos.", "Ouvrir les améliorations pour l'arme actuellement en main.") BREAK
                        CASE 6 g_selected_description = TR("Make fired bullets create explosive impacts.", "Hace que las balas disparadas causen impactos explosivos.", "使射出的子弹产生爆炸冲击。", "Abgefeuerte Kugeln erzeugen explosive Einschläge.", "発射した銃弾が着弾時に爆発するようにします。", "Сделать выстрелы из огнестрельного оружия взрывными.", "Faz as balas disparadas criarem impactos explosivos.", "Faire en sorte que les balles tirées créent des impacts explosifs.") BREAK
                        CASE 7 g_selected_description = TR("Left/Right picks a special gun mode (Gravity, Teleport, Delete, Airstrike, Vehicle, Force, or PED Gun).", "Izquierda/Derecha elige un modo de arma especial (Gravedad, Teletransporte, Borrar, Ataque aéreo, Vehículo, Fuerza o PED).", "左/右方向键选择特殊枪械模式（重力、传送、删除、空袭、载具、冲击波或行人枪）。", "Links/Rechts wählt einen Spezialwaffen-Modus (Gravitation, Teleport, Löschen, Luftschlag, Fahrzeug, Kraft oder PED).", "左右で特殊銃モードを選択（重力、テレポート、削除、空爆、車両、フォース、PED銃）。", "Влево/Вправо выбирает режим спец-оружия (Гравитация, Телепорт, Удаление, Авиаудар, Транспорт, Импульс или PED).", "Esquerda/Direita escolhe um modo de arma especial (Gravidade, Teleporte, Excluir, Ataque Aéreo, Veículo, Força ou PED).", "Gauche/Droite choisit un mode d'arme spéciale (Gravité, Téléportation, Supprimer, Frappe aérienne, Véhicule, Force ou PED).") BREAK
                        CASE 8 g_selected_description = TR("Remove the weapon currently selected in the weapon wheel.", "Elimina el arma seleccionada actualmente en la rueda de armas.", "移除当前在武器轮盘中选中的武器。", "Die aktuell im Waffenrad gewählte Waffe entfernen.", "現在武器ホイールで選択している武器を消去します。", "Удалить оружие, выбранное сейчас в селекторе оружия.", "Remove a arma atualmente selecionada na roda de armas.", "Retirer l'arme actuellement sélectionnée dans la roue des armes.") BREAK
                        CASE 9 g_selected_description = TR("Remove every weapon from the player.", "Elimina todas las armas del jugador.", "移除玩家身上的所有武器。", "Alle Waffen des Spielers entfernen.", "プレイヤーからすべての武器を消去します。", "Забрать все оружие у игрока.", "Remove todas as armas do jogador.", "Retirer toutes les armes du joueur.") BREAK
                    ENDSWITCH
                ENDIF
                BREAK
            CASE 2
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Continuously clear the player's wanted level.", "Borra continuamente el nivel de búsqueda del jugador.", "持续清除玩家的通缉等级。", "Fahndungslevel des Spielers fortlaufend löschen.", "プレイヤーの手配度を常にゼロに保ちます。", "Постоянно сбрасывать уровень розыска игрока.", "Limpa continuamente o nível de procurado do jogador.", "Effacer continuellement l'indice de recherche du joueur.") BREAK
                    CASE 1 g_selected_description = TR("Clear the current wanted level immediately.", "Borra el nivel de búsqueda actual inmediatamente.", "立即清除当前的通缉等级。", "Aktuelles Fahndungslevel sofort löschen.", "現在の手配度を即座に消去します。", "Мгновенно сбросить текущий уровень розыска.", "Limpa o nível de procurado atual imediatamente.", "Effacer immédiatement l'indice de recherche actuel.") BREAK
                    CASE 2 g_selected_description = TR("Choose a wanted level from one to five, then apply it.", "Elige un nivel de búsqueda de uno a cinco y aplícalo.", "选择 1 至 5 星通缉等级并应用。", "Fahndungslevel von eins bis fünf wählen und anwenden.", "1〜5の手配度を選択して適用します。", "Выберите уровень розыска от 1 до 5 звезд и примените его.", "Escolha um nível de procurado de um a cinco e aplique-o.", "Choisir un indice de recherche de un à cinq, puis l'appliquer.") BREAK
                    CASE 3 g_selected_description = TR("Make police ignore the player.", "Hace que la policía ignore al jugador.", "让警察无视玩家。", "Polizei ignoriert den Spieler.", "警察がプレイヤーを無視するようにします。", "Заставить полицию игнорировать игрока.", "Faz a polícia ignorar o jogador.", "Faire en sorte que la police ignore le joueur.") BREAK
                    CASE 4 g_selected_description = TR("Enable or disable police and emergency dispatch services.", "Activa o desactiva el envío de unidades policiales y de emergencia.", "启用或禁用警察和紧急救援派遣服务。", "Polizei- und Notfall-Einsatzkräfte aktivieren oder deaktivieren.", "警察や緊急車両の出動・派遣を有効または無効にします。", "Включить или отключить выезд полиции и экстренных служб.", "Ativa ou desativa o envio de viaturas policiais e de emergência.", "Activer ou désactiver l'envoi des forces de l'ordre et des secours.") BREAK
                    CASE 5 g_selected_description = TR("Enable or disable civilian reports to police.", "Activa o desactiva las denuncias de civiles a la policía.", "启用或禁用市民向警察报警。", "Meldungen von Zivilisten an die Polizei aktivieren oder deaktivieren.", "市民から警察への通報を有効または無効にします。", "Включить или отключить сообщения граждан в полицию.", "Ativa ou desativa denúncias de civis à polícia.", "Activer ou désactiver les signalements des civils à la police.") BREAK
                ENDSWITCH
                BREAK
            CASE 3
                IF g_vehicle_control_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Roll every window down, or raise the rollable windows back up.", "Baja todas las ventanillas o vuelve a subirlas.", "降下所有车窗，或将可升降车窗重新升起。", "Alle Fenster herunterkurbeln oder wieder schließen.", "すべての窓を下げるか、開閉可能な窓を元の位置まで上げます。", "Опустить все окна или поднять их обратно.", "Abaixa todos os vidros ou levanta os vidros novamente.", "Baisser toutes les vitres ou les remonter.") BREAK
                        CASE 1 g_selected_description = TR("Choose which window the roll commands below act on.", "Elige sobre qué ventanilla actúan los comandos inferiores.", "选择下方升降命令作用的车窗。", "Fenster auswählen, auf das sich die Befehle darunter beziehen.", "下の開閉コマンドで操作する窓を選択します。", "Выберите окно для команд опускания и поднятия ниже.", "Escolha em qual vidro os comandos abaixo vão agir.", "Choisir la vitre sur laquelle agissent les commandes ci-dessous.") BREAK
                        CASE 2 g_selected_description = TR("Roll the selected window down.", "Baja la ventanilla seleccionada.", "降下所选的车窗。", "Ausgewähltes Fenster herunterlassen.", "選択した窓を下げます。", "Опустить выбранное окно.", "Abaixa o vidro selecionado.", "Baisser la vitre sélectionnée.") BREAK
                        CASE 3 g_selected_description = TR("Roll the selected window back up.", "Sube la ventanilla seleccionada.", "升起所选的车窗。", "Ausgewähltes Fenster wieder schließen.", "選択した窓を上げます。", "Поднять выбранное окно обратно.", "Levanta o vidro selecionado.", "Remonter la vitre sélectionnée.") BREAK
                        CASE 4 g_selected_description = TR("Turn the occupied vehicle's engine on or off.", "Enciende o apaga el motor del vehículo actual.", "启动或关闭当前载具的引擎。", "Motor des aktuellen Fahrzeugs ein- oder ausschalten.", "乗車中の車両のエンジンをONまたはOFFにします。", "Завести или заглушить двигатель текущего транспорта.", "Liga ou desliga o motor do veículo atual.", "Allumer ou éteindre le moteur du véhicule occupé.") BREAK
                        CASE 5 g_selected_description = TR("Toggle the hazard lights on both sides of the vehicle.", "Activa o desactiva las luces de emergencia en ambos lados.", "开启或关闭车辆双闪警示灯。", "Warnblinkanlage auf beiden Fahrzeugseiten ein- oder ausschalten.", "車両の両側のハザードランプを点灯または消灯します。", "Включить или выключить аварийную сигнализацию.", "Ativa ou desativa o pisca-alerta do veículo.", "Activer ou désactiver les feux de détresse du véhicule.") BREAK
                        CASE 6 g_selected_description = TR("Move the player into the chosen seat.", "Cambia al jugador al asiento elegido.", "将玩家移动到所选的座位。", "Spieler auf den gewählten Sitzplatz setzen.", "選択した座席にプレイヤーを移動させます。", "Пересадить игрока на выбранное место в салоне.", "Move o jogador para o assento escolhido.", "Déplacer le joueur sur le siège choisi.") BREAK
                        CASE 7 g_selected_description = TR("Set how dirty the vehicle is, from clean to filthy.", "Ajusta el nivel de suciedad del vehículo, de limpio a muy sucio.", "设置载具的脏污程度（从干净到极脏）。", "Verschmutzungsgrad des Fahrzeugs von sauber bis schmutzig einstellen.", "車両の汚れ具合を「きれい」から「泥だらけ」まで設定します。", "Задать степень загрязнения машины — от чистой до грязной.", "Define o nível de sujeira do veículo, de limpo a imundo.", "Définir le niveau de saleté du véhicule, de propre à très sale.") BREAK
                        CASE 8 g_selected_description = TR("Wash the occupied vehicle back to a clean finish.", "Lava el vehículo actual hasta dejarlo limpio.", "清洗当前乘坐的载具使其恢复干净。", "Aktuelles Fahrzeug komplett sauber waschen.", "乗車中の車両を洗車してピカピカに戻します。", "Помыть текущий транспорт до чистого блеска.", "Lava o veículo atual deixando-o totalmente limpo.", "Laver le véhicule occupé pour le rendre impeccable.") BREAK
                    ENDSWITCH
                ELSE
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Open the vehicle spawner and choose a vehicle to create.", "Abre el generador de vehículos y elige uno para crear.", "打开载具生成器并选择要生成的载具。", "Fahrzeug-Spawner öffnen und ein Fahrzeug zum Erstellen wählen.", "車両スポナーを開き、出現させる乗り物を選択します。", "Открыть спавнер транспорта и выбрать машину для создания.", "Abre o gerador de veículos para escolher um veículo.", "Ouvrir le générateur de véhicules et choisir un véhicule à créer.") BREAK
                    CASE 1 g_selected_description = TR("Open the LS Customs modification and paint editor.", "Abre el editor de modificaciones y pintura de LS Customs.", "打开洛圣都改车王改装与喷漆编辑器。", "LS-Customs-Modifikations- und Lack-Editor öffnen.", "LSカスタムの改造・ペイントエディターを開きます。", "Открыть редактор тюнинга и покраски LS Customs.", "Abre o editor de modificações e pintura da LS Customs.", "Ouvrir l'éditeur de modifications et de peinture LS Customs.") BREAK
                    CASE 2 g_selected_description = TR("Open the neon animation submenu. Requires a vehicle.", "Abre el submenú de animación de neón. Requiere un vehículo.", "打开霓虹灯动画子菜单（需要在载具内）。", "Neon-Animations-Untermenü öffnen. Erfordert ein Fahrzeug.", "ネオンアニメーションのサブメニューを開きます（乗車中のみ）。", "Открыть подменю анимации неона. Требуется транспорт.", "Abre o submenu de animação de neon. Requer um veículo.", "Ouvrir le sous-menu d'animation néon. Nécessite un véhicule.") BREAK
                    CASE 3 g_selected_description = TR("Open the vehicle control submenu. Requires a vehicle.", "Abre el submenú de control del vehículo. Requiere un vehículo.", "打开载具控制子菜单（需要在载具内）。", "Fahrzeugsteuerungs-Untermenü öffnen. Erfordert ein Fahrzeug.", "車両コントロールのサブメニューを開きます（乗車中のみ）。", "Открыть подменю управления транспортом. Требуется транспорт.", "Abre o submenu de controle do veículo. Requer um veículo.", "Ouvrir le sous-menu de contrôle du véhicule. Nécessite un véhicule.") BREAK
                    CASE 4 g_selected_description = TR("Make the occupied vehicle immune to damage.", "Hace que el vehículo actual sea inmune al daño.", "使当前乘坐的载具免疫一切伤害。", "Aktuelles Fahrzeug immun gegen Schaden machen.", "乗車中の乗り物をダメージから無敵にします。", "Сделать текущий транспорт неуязвимым к урону.", "Torna o veículo atual imune a danos.", "Rendre le véhicule occupé insensible aux dégâts.") BREAK
                    CASE 5 g_selected_description = TR("Repair damage to the occupied vehicle immediately.", "Repara inmediatamente los daños del vehículo actual.", "立即修复当前载具的所有损伤。", "Schäden am aktuellen Fahrzeug sofort reparieren.", "乗車中の乗り物の損傷を即座に修理します。", "Мгновенно починить текущий транспорт.", "Repara os danos do veículo atual imediatamente.", "Réparer immédiatement les dégâts du véhicule occupé.") BREAK
                    CASE 6 g_selected_description = TR("Apply the highest available upgrade to the occupied vehicle.", "Aplica la mejora máxima disponible al vehículo actual.", "为当前载具应用最高级别的可用改装。", "Höchstes verfügbares Upgrade auf das aktuelle Fahrzeug anwenden.", "乗車中の乗り物に最高レベルのアップグレードを適用します。", "Применить максимальные улучшения к текущему транспорту.", "Aplica a melhoria máxima disponível ao veículo atual.", "Appliquer la meilleure amélioration disponible au véhicule occupé.") BREAK
                    CASE 7 g_selected_description = TR("Automatically max upgrades on every vehicle entered.", "Mejora al máximo automáticamente cada vehículo al que entres.", "进入任何载具时自动升至满改。", "Jedes betretene Fahrzeug automatisch maximal aufrüsten.", "乗り込んだすべての車両を自動的にフル改造します。", "Автоматически улучшать до максимума каждый транспорт при посадке.", "Melhora ao máximo automaticamente todo veículo em que você entrar.", "Améliorer automatiquement au maximum chaque véhicule utilisé.") BREAK
                    CASE 8 g_selected_description = TR("Increase vehicle acceleration from stock through 200x.", "Aumenta la aceleración del vehículo desde serie hasta 200x.", "将载具加速度从原厂提升至最高 200 倍。", "Fahrzeugbeschleunigung von Standard bis 200x erhöhen.", "車両の加速力を標準から最大200倍まで強化します。", "Увеличить ускорение транспорта от стандарта до 200x.", "Aumenta a aceleração do veículo do original até 200x.", "Augmenter l'accélération du véhicule de l'origine jusqu'à 200x.") BREAK
                    CASE 9 g_selected_description = TR("Adjust tyre grip from reduced grip through high grip.", "Ajusta el agarre de los neumáticos desde reducido hasta alto.", "调整轮胎抓地力（从低抓地力到超强抓地力）。", "Reifenhaftung von verringert bis stark anpassen.", "タイヤのグリップ力を低グリップから高グリップまで調整します。", "Настроить сцепление шин от скольжения до сверхсцепления.", "Ajusta a aderência dos pneus de reduzida até alta aderência.", "Ajuster l'adhérence des pneus, de réduite à élevée.") BREAK
                    CASE 10 g_selected_description = TR("Keep the tow hook attached no matter the impacts.", "Mantiene enganchado el cable de la grúa sin importar los golpes.", "无论受到何种撞击都保持拖车钩连接不脱落。", "Abschlepphaken trotz Kollisionen dauerhaft verbunden halten.", "衝撃を受けてもレッカー車のフックが外れないようにします。", "Удерживать крюк эвакуатора закрепленным при любых ударах.", "Mantém o gancho do guincho preso independentemente dos impactos.", "Maintenir le crochet de remorquage attaché malgré les chocs.") BREAK
                    CASE 11 g_selected_description = TR("Toggle the vehicle's turbo modification.", "Activa o desactiva la modificación de turbo del vehículo.", "开启或关闭载具的涡轮增压改装。", "Turbo-Modifikation des Fahrzeugs ein- oder ausschalten.", "車両のターボ改造のON/OFFを切り替えます。", "Включить или выключить турбонаддув на транспорте.", "Ativa ou desativa a modificação de turbo do veículo.", "Activer ou désactiver le turbo du véhicule.") BREAK
                    CASE 12 g_selected_description = TR("Prevent tyres from bursting.", "Evita que los neumáticos revienten.", "防止轮胎爆胎。", "Platzen der Reifen verhindern.", "タイヤがパンクしないようにします。", "Защитить шины от проколов и прострелов.", "Impede que os pneus estourem.", "Empêcher les pneus d'éclater.") BREAK
                    CASE 13 g_selected_description = TR("Set the occupied vehicle upright on the ground.", "Coloca el vehículo actual derecho sobre el suelo.", "将当前载具翻转回正并放到地面上。", "Aktuelles Fahrzeug wieder aufrecht auf den Boden stellen.", "乗車中の乗り物を地面に正しく起き上がらせます。", "Поставить перевернутый транспорт ровно на колеса.", "Coloca o veículo atual de volta em pé no chão.", "Remettre le véhicule occupé à l'endroit sur le sol.") BREAK
                    CASE 14 g_selected_description = TR("Skip entry and exit animations when entering or leaving vehicles.", "Omite las animaciones al entrar o salir de los vehículos.", "进入或离开载具时跳过上下车动画。", "Ein- und Ausstiegsanimationen bei Fahrzeugen überspringen.", "乗り降りする際のアニメーションをスキップして瞬時に移動します。", "Пропускать анимацию посадки и выхода из транспорта.", "Pula as animações ao entrar ou sair de veículos.", "Passer les animations d'entrée et de sortie des véhicules.") BREAK
                    CASE 15 g_selected_description = TR("Enter the personal vehicle marked by the game.", "Entra directamente en el vehículo personal marcado por el juego.", "直接进入游戏标记的个人载具。", "In das vom Spiel markierte persönliche Fahrzeug einsteigen.", "ゲーム内でマークされている個人車両に乗り込みます。", "Сесть в личный транспорт, отмеченный игрой.", "Entra no veículo pessoal marcado pelo jogo.", "Monter dans le véhicule personnel marqué par le jeu.") BREAK
                    CASE 16 g_selected_description = TR("Bring the player's story-mode personal vehicle to the current location and enter it.", "Trae el vehículo personal del modo historia a tu ubicación y entra en él.", "将故事模式角色的专属座驾召唤到当前位置并坐入车内。", "Persönliches Story-Modus-Fahrzeug zum aktuellen Ort holen und einsteigen.", "ストーリーモードの個人車両を現在地に呼び出して乗り込みます。", "Доставить личный транспорт сюжетного режима к игроку и сесть в него.", "Traz o veículo pessoal do modo história até o local atual e entra nele.", "Amener le véhicule personnel du mode Histoire à votre position et y monter.") BREAK
                    CASE 17 g_selected_description = TR("Hold the horn to apply a forward boost.", "Mantén pulsado el claxon para aplicar un impulso hacia adelante.", "按住喇叭向前喷射加速。", "Hupe gedrückt halten, um einen Vorwärts-Boost auszulösen.", "クラクションを押し続けている間、前方へブースト加速します。", "Удерживайте гудок для ускорения транспорта вперед.", "Segure a buzina para aplicar um impulso para frente.", "Maintenir le klaxon pour appliquer un boost vers l'avant.") BREAK
                    CASE 18 g_selected_description = TR("Repair the occupied vehicle continuously.", "Repara continuamente el vehículo actual.", "持续自动修复当前乘坐的载具。", "Aktuelles Fahrzeug fortlaufend reparieren.", "乗車中の乗り物を常時自動修理します。", "Непрерывно чинить текущий транспорт.", "Repara o veículo atual continuamente.", "Réparer continuellement le véhicule occupé.") BREAK
                    CASE 19 g_selected_description = TR("Open the rear cargo/ramp doors on the occupied plane.", "Abre la rampa o puertas de carga traseras del avión actual.", "打开当前所乘飞机的后部货舱门/坡道。", "Heckladerampe am aktuellen Flugzeug öffnen.", "搭乗中の航空機の後部カーゴドア・ランプを開閉します。", "Открыть задний грузовой люк или рампу текущего самолета.", "Abre a rampa ou portas de carga traseiras do avião atual.", "Ouvrir la rampe ou la soute arrière de l'avion occupé.") BREAK
                    CASE 20 g_selected_description = TR("Lock or unlock the occupied vehicle's doors.", "Bloquea o desbloquea las puertas del vehículo actual.", "锁上或解锁当前载具的车门。", "Türen des aktuellen Fahrzeugs ver- oder entriegeln.", "乗車中の車両のドアをロックまたはアンロックします。", "Запереть или отпереть двери текущего транспорта.", "Tranca ou destranca as portas do veículo atual.", "Verrouiller ou déverrouiller les portes du véhicule occupé.") BREAK
                    CASE 21 g_selected_description = TR("Prevent ejection from crashes; X is still used to exit.", "Evita salir despedido en choques; X sigue funcionando para salir.", "防止车祸时飞出车窗；仍可按 X 正常下车。", "Herausschleudern bei Unfällen verhindern; Aussteigen mit X bleibt möglich.", "衝突時に車外へ投げ出されるのを防ぎます（Xボタンで降車可能）。", "Предотвращает вылет через лобовое стекло при авариях (выход по X работает).", "Impede ser ejetado em batidas; X ainda é usado para sair.", "Empêcher l'éjection lors des collisions ; X permet toujours de sortir.") BREAK
                    CASE 22 g_selected_description = TR("Destroy the occupied vehicle's engine.", "Destruye el motor del vehículo actual.", "摧毁当前载具的引擎。", "Motor des aktuellen Fahrzeugs zerstören.", "乗車中の車両のエンジンを破壊します。", "Уничтожить двигатель текущего транспорта.", "Destrói o motor do veículo atual.", "Détruire le moteur du véhicule occupé.") BREAK
                    CASE 23 g_selected_description = TR("Show the occupied vehicle's current speed.", "Muestra la velocidad actual del vehículo en pantalla.", "显示当前乘坐载具的实时车速。", "Aktuelle Geschwindigkeit des Fahrzeugs anzeigen.", "乗車中の車両の現在速度を表示します。", "Показывать текущую скорость транспорта на экране.", "Mostra a velocidade atual do veículo na tela.", "Afficher la vitesse actuelle du véhicule occupé.") BREAK
                    CASE 24 g_selected_description = TR("Choose MPH or KMPH for the speedometer.", "Elige MPH o KMPH para el velocímetro.", "为速度计选择英里/小时 (MPH) 或公里/小时 (KMPH)。", "MPH oder KMPH für den Tacho wählen.", "スピードメーターの単位をMPHまたはKMPHから選択します。", "Выбрать единицы скорости для спидометра: MPH или KMPH.", "Escolha MPH ou KMPH para o velocímetro.", "Choisir MPH ou KMPH pour le compteur de vitesse.") BREAK
                    CASE 25 g_selected_description = TR("Hire a driver: spawns a black car with a chauffeur and drives you to your waypoint.", "Contrata un chófer: genera un coche negro con conductor que te lleva a tu destino.", "雇佣专属司机：生成一辆黑色专车并由司机载你前往地图标记点。", "Chauffeur engagieren: Spawnt ein schwarzes Auto mit Fahrer, der zum Wegpunkt fährt.", "運転手を雇う：黒塗りの車と運転手を出現させ、目的地まで送迎させます。", "Нанять шофера: создает черную машину с водителем, который отвезет вас к метке.", "Contrate um motorista: gera um carro preto com chofer que dirige até a sua marcação.", "Engager un chauffeur : fait apparaître une voiture noire avec chauffeur qui vous conduit au repère.") BREAK
                    CASE 26 g_selected_description = TR("Maintain your current vehicle speed after releasing gas until you brake or accelerate.", "Mantiene la velocidad actual tras soltar el acelerador hasta que frenes o aceleres.", "松开油门后保持当前车速巡航，直到刹车或再次加速。", "Aktuelle Geschwindigkeit nach Loslassen des Gaspedals halten, bis gebremst oder beschleunigt wird.", "アクセルを離しても現在の速度を維持します（ブレーキや再加速で解除）。", "Поддерживать текущую скорость после отпускания газа до нажатия тормоза или газа.", "Mantém a velocidade atual após soltar o acelerador até você frear ou acelerar.", "Maintenir la vitesse actuelle après avoir relâché l'accélérateur jusqu'au freinage ou à l'accélération.") BREAK
                    CASE 27 g_selected_description = TR("Hold R3 in an emergency vehicle to mute siren sound while keeping lights and traffic yield active. Keep OFF if other mods use R3.", "Mantén R3 en un vehículo de emergencia para silenciar la sirena manteniendo las luces activas. Déjalo en NO si otros mods usan R3.", "在紧急载具中长按 R3 可静音警笛并保留警灯闪烁。若其他模组占用 R3 请保持关闭。", "Halte R3 im Einsatzfahrzeug, um die Sirene bei aktivem Blaulicht stummzuschalten. Auf AUS lassen, wenn andere Mods R3 nutzen.", "緊急車両でR3を長押しすると、警告灯を維持したままサイレン音を消します。他のMODでR3を使う場合はOFFにしてください。", "Удерживайте R3 в спецтранспорте, чтобы выключить звук сирены, оставив мигалки. Отключите, если R3 нужен другим модам.", "Segure R3 em um veículo de emergência para silenciar a sirene mantendo o giroflex ativo. Deixe DESL. se outros mods usarem R3.", "Maintenez R3 dans un véhicule d'urgence pour couper le son de la sirène tout en gardant les gyrophares. Laissez désactivé si un mod utilise R3.") BREAK
                ENDSWITCH
                ENDIF
                BREAK
            CASE 4
                IF g_timeweather_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Choose a time of day and press A to apply it.", "Elige una hora del día y pulsa A para aplicarla.", "选择一个时间预设并按 A 应用。", "Tageszeit wählen und mit A anwenden.", "時間帯を選択し、Aボタンで適用します。", "Выберите время суток и нажмите A для применения.", "Escolha um horário do dia e pressione A para aplicar.", "Choisir une heure de la journée et appuyer sur A pour l'appliquer.") BREAK
                        CASE 1 g_selected_description = TR("Set the editable hour; Left/Right changes it immediately.", "Ajusta la hora; Izquierda/Derecha la cambia al instante.", "设置小时数；左/右方向键立即更改。", "Stunde einstellen; Links/Rechts ändert sie sofort.", "時間を設定します（左右キーで即座に変更）。", "Установить часы; Влево/Вправо меняет значение сразу.", "Ajusta a hora; Esquerda/Direita altera imediatamente.", "Définir l'heure ; Gauche/Droite la change immédiatement.") BREAK
                        CASE 2 g_selected_description = TR("Set the editable minute; Left/Right changes it immediately.", "Ajusta los minutos; Izquierda/Derecha los cambia al instante.", "设置分钟数；左/右方向键立即更改。", "Minute einstellen; Links/Rechts ändert sie sofort.", "分を設定します（左右キーで即座に変更）。", "Установить минуты; Влево/Вправо меняет значение сразу.", "Ajusta os minutos; Esquerda/Direita altera imediatamente.", "Définir les minutes ; Gauche/Droite les change immédiatement.") BREAK
                        CASE 3 g_selected_description = TR("Set the editable second; Left/Right changes it immediately.", "Ajusta los segundos; Izquierda/Derecha los cambia al instante.", "设置秒数；左/右方向键立即更改。", "Sekunde einstellen; Links/Rechts ändert sie sofort.", "秒を設定します（左右キーで即座に変更）。", "Установить секунды; Влево/Вправо меняет значение сразу.", "Ajusta os segundos; Esquerda/Direita altera imediatamente.", "Définir les secondes ; Gauche/Droite les change immédiatement.") BREAK
                        CASE 4 g_selected_description = TR("Freeze or resume the world clock.", "Congela o reanuda el reloj del mundo.", "冻结或恢复世界时间流逝。", "Weltzeituhr einfrieren oder fortsetzen.", "ゲーム内時間の経過を停止または再開します。", "Остановить или возобновить ход игрового времени.", "Congela ou retoma o relógio do mundo.", "Figer ou reprendre l'horloge du monde.") BREAK
                        CASE 5 g_selected_description = TR("Choose weather and press A to apply it persistently.", "Elige el clima y pulsa A para aplicarlo de forma persistente.", "选择天气并按 A 持久应用。", "Wetter wählen und mit A dauerhaft anwenden.", "天候を選択し、Aボタンで持続的に適用します。", "Выберите погоду и нажмите A для постоянного применения.", "Escolha o clima e pressione A para aplicá-lo de forma persistente.", "Choisir la météo et appuyer sur A pour l'appliquer durablement.") BREAK
                    ENDSWITCH
                ELIF g_mayhem_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Shut off all artificial city, building, and street lights across the map.", "Apaga todas las luces artificiales de la ciudad, edificios y calles en el mapa.", "关闭全地图所有城市、建筑和街道的人工照明。", "Alle künstlichen Stadt-, Gebäude- und Straßenlichter auf der Karte ausschalten.", "マップ中の都市、建物、街灯などの人工照明をすべて消灯します。", "Отключить все искусственное освещение города, зданий и улиц на карте.", "Desliga todas as luzes artificiais da cidade, prédios e ruas pelo mapa.", "Éteindre tous les éclairages artificiels de la ville, des bâtiments et des rues.") BREAK
                        CASE 1 g_selected_description = TR("Continuously rain explosive flaming meteors from the sky around the player.", "Hace llover continuamente meteoritos explosivos en llamas alrededor del jugador.", "在玩家周围天空持续降下爆炸燃烧的陨石雨。", "Lässt fortlaufend explosive Flammen-Meteore um den Spieler vom Himmel regnen.", "プレイヤーの周囲に爆発する火炎メテオを空から絶え間なく降らせます。", "Непрерывный дождь из взрывающихся огненных метеоритов вокруг игрока.", "Faz chover continuamente meteoros explosivos em chamas ao redor do jogador.", "Faire pleuvoir continuellement des météores enflammés explosifs autour du joueur.") BREAK
                        CASE 2 g_selected_description = TR("Arm nearby pedestrians with firearms and pit them against everyone around them.", "Arma a los peatones cercanos con armas de fuego y haz que luchen contra todos.", "为附近行人配备枪支并让他们相互混战。", "Passanten in der Nähe mit Schusswaffen ausrüsten und aufeinander losgehen lassen.", "近くの歩行者を銃火器で武装させ、周囲の全員と銃撃戦をさせます。", "Вооружить ближайших пешеходов огнестрельным оружием и стравить их со всеми вокруг.", "Arma pedestres próximos com armas de fogo e faz todos lutarem entre si.", "Armer les piétons proches avec des armes à feu et les faire s'entre-tuer.") BREAK
                        CASE 3 g_selected_description = TR("Make nearby ambient traffic floor the gas and swerve recklessly through the streets.", "Hace que el tráfico cercano pise el acelerador a fondo y conduzca de forma temeraria.", "让附近交通车辆猛踩油门并在街道上疯狂乱撞。", "Umgebungsverkehr in der Nähe gibt Vollgas und rast rücksichtslos durch die Straßen.", "周囲の一般車両にアクセル全開で街中を暴走させます。", "Заставить ближайших водителей вдавить газ в пол и безумно носиться по улицам.", "Faz o trânsito próximo pisar fundo no acelerador e dirigir de forma imprudente.", "Faire accélérer à fond le trafic environnant et conduire dangereusement.") BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                    CASE 0 g_selected_description = TR("Open the time and weather controls.", "Abre los controles de hora y clima.", "打开时间与天气控制菜单。", "Zeit- und Wettersteuerung öffnen.", "時間と天候のコントロールを開きます。", "Открыть управление временем и погодой.", "Abre os controles de horário e clima.", "Ouvrir les commandes de l'heure et de la météo.") BREAK
                    CASE 1 g_selected_description = TR("Toggle night vision.", "Activa o desactiva la visión nocturna.", "开启或关闭夜视仪效果。", "Nachtsicht ein- oder ausschalten.", "ナイトビジョンのON/OFFを切り替えます。", "Включить или выключить ночное видение.", "Ativa ou desativa a visão noturna.", "Activer ou désactiver la vision nocturne.") BREAK
                    CASE 2 g_selected_description = TR("Toggle thermal vision.", "Activa o desactiva la visión térmica.", "开启或关闭热成像视野。", "Wärmebildsicht ein- oder ausschalten.", "サーマルビジョンのON/OFFを切り替えます。", "Включить или выключить тепловизор.", "Ativa ou desativa a visão térmica.", "Activer ou désactiver la vision thermique.") BREAK
                    CASE 3 g_selected_description = TR("Choose a safe story-mode IPL preset.", "Elige un ajuste predefinido de IPL seguro para el modo historia.", "选择一个安全的故事模式地图区块 (IPL) 预设。", "Sicheres Story-Modus-IPL-Preset wählen.", "ストーリーモード用の安全なIPLプリセットを選択します。", "Выбрать безопасный пресет интерьера/локации (IPL).", "Escolha uma predefinição de IPL segura para o modo história.", "Choisir un préréglage d'IPL sûr pour le mode Histoire.") BREAK
                    CASE 4 g_selected_description = TR("Slow down or speed up the whole simulation. 1x default.", "Ralentiza o acelera toda la simulación. 1x por defecto.", "减慢或加快整个游戏模拟速度（默认 1x）。", "Gesamte Simulation verlangsamen oder beschleunigen. 1x ist Standard.", "ゲーム全体の進行速度を遅くするか速くします（標準は1x）。", "Замедлить или ускорить всю симуляцию игры. По умолчанию 1x.", "Desacelera ou acelera toda a simulação. 1x é o padrão.", "Ralentir ou accélérer toute la simulation. 1x par défaut.") BREAK
                    CASE 5 g_selected_description = TR("Set global gravity. Earth default.", "Define la gravedad global. Tierra por defecto.", "设置全局重力级别（默认为地球重力）。", "Globale Schwerkraft einstellen. Erde ist Standard.", "全体の重力を設定します（標準は地球）。", "Установить глобальную гравитацию. По умолчанию — Земля.", "Define a gravidade global. Terra é o padrão.", "Définir la gravité globale. Terre par défaut.") BREAK
                    CASE 6 g_selected_description = TR("Request the selected IPL preset.", "Carga el ajuste predefinido de IPL seleccionado.", "加载所选的地图区块 (IPL) 预设。", "Ausgewähltes IPL-Preset laden.", "選択したIPLプリセットを読み込みます。", "Загрузить выбранный пресет IPL.", "Carrega a predefinição de IPL selecionada.", "Charger le préréglage d'IPL sélectionné.") BREAK
                    CASE 7 g_selected_description = TR("Remove the selected IPL preset.", "Descarga el ajuste predefinido de IPL seleccionado.", "卸载所选的地图区块 (IPL) 预设。", "Ausgewähltes IPL-Preset entfernen.", "選択したIPLプリセットをアンロードします。", "Выгрузить выбранный пресет IPL.", "Remove a predefinição de IPL selecionada.", "Décharger le préréglage d'IPL sélectionné.") BREAK
                    CASE 8 g_selected_description = TR("Enter an IPL name with the Switch keyboard.", "Introduce un nombre de IPL con el teclado de Switch.", "使用 Switch 键盘输入自定义 IPL 名称。", "IPL-Namen über die Switch-Tastatur eingeben.", "SwitchのキーボードでIPL名を入力します。", "Ввести название IPL с помощью клавиатуры Switch.", "Digite um nome de IPL com o teclado do Switch.", "Saisir un nom d'IPL avec le clavier Switch.") BREAK
                    CASE 9 g_selected_description = TR("Request the custom IPL name.", "Carga el IPL personalizado introducido.", "加载输入的自定义 IPL。", "Eingegebenen benutzerdefinierten IPL laden.", "入力したカスタムIPLを読み込みます。", "Загрузить пользовательский IPL по имени.", "Carrega o IPL personalizado digitado.", "Charger l'IPL personnalisé saisi.") BREAK
                    CASE 10 g_selected_description = TR("Remove the custom IPL name.", "Descarga el IPL personalizado introducido.", "卸载输入的自定义 IPL。", "Eingegebenen benutzerdefinierten IPL entfernen.", "入力したカスタムIPLをアンロードします。", "Выгрузить пользовательский IPL по имени.", "Remove o IPL personalizado digitado.", "Décharger l'IPL personnalisé saisi.") BREAK
                    CASE 11 g_selected_description = TR("Apply or clear the CCTV scanline filter.", "Aplica o quita el filtro de líneas de cámara de seguridad (CCTV).", "应用或清除监控摄像头扫描线滤镜。", "CCTV-Scanline-Filter anwenden oder entfernen.", "防犯カメラ（CCTV）の走査線フィルターを適用または解除します。", "Включить или выключить фильтр камеры видеонаблюдения (CCTV).", "Aplica ou limpa o filtro de câmera de segurança (CCTV).", "Appliquer ou retirer le filtre de caméra de surveillance (CCTV).") BREAK
                    CASE 12 g_selected_description = TR("Start or stop the gameplay camera shake effect.", "Inicia o detiene el efecto de temblor de la cámara del juego.", "开启或停止游戏镜头震动效果。", "Kamerawackel-Effekt im Spiel starten oder stoppen.", "ゲームカメラの揺れ効果を開始または停止します。", "Включить или выключить эффект тряски игровой камеры.", "Inicia ou para o efeito de tremor da câmera.", "Démarrer ou arrêter l'effet de tremblement de la caméra.") BREAK
                    CASE 13 g_selected_description = TR("Automatically unlock and open doors, gates, barriers, garages, and interiors when you physically touch them.", "Desbloquea y abre automáticamente puertas, portones, barreras y garajes al tocarlos.", "当身体接触门、大门、栏杆、车库和室内门时自动解锁并推开。", "Türen, Tore, Schranken, Garagen und Innenräume beim Berühren automatisch entriegeln und öffnen.", "ドア、ゲート、遮断機、ガレージに触れると自動的に解錠して開きます。", "Автоматически отпирать и открывать двери, ворота, шлагбаумы и гаражи при касании.", "Destranca e abre automaticamente portas, portões, barreiras e garagens ao tocá-los.", "Déverrouiller et ouvrir automatiquement les portes, portails, barrières et garages au contact.") BREAK
                    CASE 14 g_selected_description = TR("Unlock and open the closest door, gate, barrier, or garage in range.", "Desbloquea y abre la puerta, portón, barrera o garaje más cercano en rango.", "解锁并打开范围内最近的门、大门、栏杆或车库。", "Nächstgelegene Tür, Tor, Schranke oder Garage in Reichweite entriegeln und öffnen.", "範囲内で最も近いドア、ゲート、遮断機、またはガレージを解錠して開きます。", "Отпереть и открыть ближайшую дверь, ворота, шлагбаум или гараж рядом.", "Destranca e abre a porta, portão, barreira ou garagem mais próxima no alcance.", "Déverrouiller et ouvrir la porte, le portail, la barrière ou le garage le plus proche.") BREAK
                    CASE 15 g_selected_description = TR("Close the closest door, gate, barrier, or garage in range.", "Cierra la puerta, portón, barrera o garaje más cercano en rango.", "关闭范围内最近的门、大门、栏杆或车库。", "Nächstgelegene Tür, Tor, Schranke oder Garage in Reichweite schließen.", "範囲内で最も近いドア、ゲート、遮断機、またはガレージを閉じます。", "Закрыть ближайшую дверь, ворота, шлагбаум или гараж рядом.", "Fecha a porta, portão, barreira ou garagem mais próxima no alcance.", "Fermer la porte, le portail, la barrière ou le garage le plus proche.") BREAK
                    CASE 16 g_selected_description = TR("Open the World Mayhem submenu (City Blackout, Meteor Shower, Armed Ped Riot, and Crazy Drivers).", "Abre el submenú de Caos Mundial (Apagón, Lluvia de meteoritos, Disturbios armados y Conductores locos).", "打开世界混乱子菜单（全城停电、陨石雨、武装暴动和疯狂司机）。", "Welt-Chaos-Untermenü öffnen (Stromausfall, Meteorschauer, Bewaffneter Aufstand und Verrückte Fahrer).", "ワールドメイヘム（大停電、メテオシャワー、武装暴動、暴走ドライバー）を開きます。", "Открыть подменю «Хаос в мире» (Блэкаут, Метеоритный дождь, Бунт с оружием и Безумные водители).", "Abre o submenu Caos no Mundo (Apagão, Chuva de Meteoros, Revolta Armada e Motoristas Loucos).", "Ouvrir le sous-menu Chaos Mondial (Blackout, Pluie de météores, Émeute armée et Conducteurs fous).") BREAK
                    ENDSWITCH
                ENDIF
                BREAK
            CASE 5
                IF g_tp_stores_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Teleport inside Gas Store 1.", "Teletranspórtate al interior de la Gasolinera 1.", "传送到加油站便利店 1 内部。", "In Tankstellenladen 1 teleportieren.", "ガソリンスタンドの売店 1 の店内へテレポートします。", "Телепортироваться внутрь магазина на заправке 1.", "Teleporta para dentro da Loja de Posto 1.", "Se téléporter à l'intérieur de la station-service 1.") BREAK
                        CASE 1 g_selected_description = TR("Teleport inside Gas Store 2.", "Teletranspórtate al interior de la Gasolinera 2.", "传送到加油站便利店 2 内部。", "In Tankstellenladen 2 teleportieren.", "ガソリンスタンドの売店 2 の店内へテレポートします。", "Телепортироваться внутрь магазина на заправке 2.", "Teleporta para dentro da Loja de Posto 2.", "Se téléporter à l'intérieur de la station-service 2.") BREAK
                        CASE 2 g_selected_description = TR("Teleport inside Gas Store 3.", "Teletranspórtate al interior de la Gasolinera 3.", "传送到加油站便利店 3 内部。", "In Tankstellenladen 3 teleportieren.", "ガソリンスタンドの売店 3 の店内へテレポートします。", "Телепортироваться внутрь магазина на заправке 3.", "Teleporta para dentro da Loja de Posto 3.", "Se téléporter à l'intérieur de la station-service 3.") BREAK
                        CASE 3 g_selected_description = TR("Teleport inside Gas Store 4.", "Teletranspórtate al interior de la Gasolinera 4.", "传送到加油站便利店 4 内部。", "In Tankstellenladen 4 teleportieren.", "ガソリンスタンドの売店 4 の店内へテレポートします。", "Телепортироваться внутрь магазина на заправке 4.", "Teleporta para dentro da Loja de Posto 4.", "Se téléporter à l'intérieur de la station-service 4.") BREAK
                        CASE 4 g_selected_description = TR("Teleport inside Gas Store 5.", "Teletranspórtate al interior de la Gasolinera 5.", "传送到加油站便利店 5 内部。", "In Tankstellenladen 5 teleportieren.", "ガソリンスタンドの売店 5 の店内へテレポートします。", "Телепортироваться внутрь магазина на заправке 5.", "Teleporta para dentro da Loja de Posto 5.", "Se téléporter à l'intérieur de la station-service 5.") BREAK
                        CASE 5 g_selected_description = TR("Teleport inside Liquor Store 1.", "Teletranspórtate al interior de la Licorería 1.", "传送到酒水店 1 内部。", "In Spirituosenladen 1 teleportieren.", "リカーショップ 1 の店内へテレポートします。", "Телепортироваться внутрь винного магазина 1.", "Teleporta para dentro da Loja de Bebidas 1.", "Se téléporter à l'intérieur du magasin d'alcool 1.") BREAK
                        CASE 6 g_selected_description = TR("Teleport inside Liquor Store 2.", "Teletranspórtate al interior de la Licorería 2.", "传送到酒水店 2 内部。", "In Spirituosenladen 2 teleportieren.", "リカーショップ 2 の店内へテレポートします。", "Телепортироваться внутрь винного магазина 2.", "Teleporta para dentro da Loja de Bebidas 2.", "Se téléporter à l'intérieur du magasin d'alcool 2.") BREAK
                        CASE 7 g_selected_description = TR("Teleport inside Liquor Store 3.", "Teletranspórtate al interior de la Licorería 3.", "传送到酒水店 3 内部。", "In Spirituosenladen 3 teleportieren.", "リカーショップ 3 の店内へテレポートします。", "Телепортироваться внутрь винного магазина 3.", "Teleporta para dentro da Loja de Bebidas 3.", "Se téléporter à l'intérieur du magasin d'alcool 3.") BREAK
                        CASE 8 g_selected_description = TR("Teleport inside Liquor Store 4.", "Teletranspórtate al interior de la Licorería 4.", "传送到酒水店 4 内部。", "In Spirituosenladen 4 teleportieren.", "リカーショップ 4 の店内へテレポートします。", "Телепортироваться внутрь винного магазина 4.", "Teleporta para dentro da Loja de Bebidas 4.", "Se téléporter à l'intérieur du magasin d'alcool 4.") BREAK
                        CASE 9 g_selected_description = TR("Teleport inside Liquor Store 5.", "Teletranspórtate al interior de la Licorería 5.", "传送到酒水店 5 内部。", "In Spirituosenladen 5 teleportieren.", "リカーショップ 5 の店内へテレポートします。", "Телепортироваться внутрь винного магазина 5.", "Teleporta para dentro da Loja de Bebidas 5.", "Se téléporter à l'intérieur du magasin d'alcool 5.") BREAK
                        CASE 10 g_selected_description = TR("Teleport inside Market 1.", "Teletranspórtate al interior del Supermercado 1.", "传送到超市 1 内部。", "In Supermarkt 1 teleportieren.", "マーケット 1 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 1.", "Teleporta para dentro do Mercado 1.", "Se téléporter à l'intérieur de la supérette 1.") BREAK
                        CASE 11 g_selected_description = TR("Teleport inside Market 2.", "Teletranspórtate al interior del Supermercado 2.", "传送到超市 2 内部。", "In Supermarkt 2 teleportieren.", "マーケット 2 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 2.", "Teleporta para dentro do Mercado 2.", "Se téléporter à l'intérieur de la supérette 2.") BREAK
                        CASE 12 g_selected_description = TR("Teleport inside Market 3.", "Teletranspórtate al interior del Supermercado 3.", "传送到超市 3 内部。", "In Supermarkt 3 teleportieren.", "マーケット 3 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 3.", "Teleporta para dentro do Mercado 3.", "Se téléporter à l'intérieur de la supérette 3.") BREAK
                        CASE 13 g_selected_description = TR("Teleport inside Market 4.", "Teletranspórtate al interior del Supermercado 4.", "传送到超市 4 内部。", "In Supermarkt 4 teleportieren.", "マーケット 4 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 4.", "Teleporta para dentro do Mercado 4.", "Se téléporter à l'intérieur de la supérette 4.") BREAK
                        CASE 14 g_selected_description = TR("Teleport inside Market 5.", "Teletranspórtate al interior del Supermercado 5.", "传送到超市 5 内部。", "In Supermarkt 5 teleportieren.", "マーケット 5 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 5.", "Teleporta para dentro do Mercado 5.", "Se téléporter à l'intérieur de la supérette 5.") BREAK
                        CASE 15 g_selected_description = TR("Teleport inside Market 6.", "Teletranspórtate al interior del Supermercado 6.", "传送到超市 6 内部。", "In Supermarkt 6 teleportieren.", "マーケット 6 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 6.", "Teleporta para dentro do Mercado 6.", "Se téléporter à l'intérieur de la supérette 6.") BREAK
                        CASE 16 g_selected_description = TR("Teleport inside Market 7.", "Teletranspórtate al interior del Supermercado 7.", "传送到超市 7 内部。", "In Supermarkt 7 teleportieren.", "マーケット 7 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 7.", "Teleporta para dentro do Mercado 7.", "Se téléporter à l'intérieur de la supérette 7.") BREAK
                        CASE 17 g_selected_description = TR("Teleport inside Market 8.", "Teletranspórtate al interior del Supermercado 8.", "传送到超市 8 内部。", "In Supermarkt 8 teleportieren.", "マーケット 8 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 8.", "Teleporta para dentro do Mercado 8.", "Se téléporter à l'intérieur de la supérette 8.") BREAK
                        CASE 18 g_selected_description = TR("Teleport inside Market 9.", "Teletranspórtate al interior del Supermercado 9.", "传送到超市 9 内部。", "In Supermarkt 9 teleportieren.", "マーケット 9 の店内へテレポートします。", "Телепортироваться внутрь супермаркета 9.", "Teleporta para dentro do Mercado 9.", "Se téléporter à l'intérieur de la supérette 9.") BREAK
                    ENDSWITCH
                ELIF g_tp_locs_open
                    SWITCH g_item
                    CASE 0 g_selected_description = TR("Teleport to the summit of Mount Chiliad.", "Teletranspórtate a la cima del Monte Chiliad.", "传送到奇利亚德山山顶。", "Zum Gipfel des Mount Chiliad teleportieren.", "チリアド山の山頂へテレポートします。", "Телепортироваться на вершину горы Чилиад.", "Teleporta para o topo do Monte Chiliad.", "Se téléporter au sommet du Mont Chiliad.") BREAK
                    CASE 1 g_selected_description = TR("Teleport to Maze Bank Tower.", "Teletranspórtate a la torre del Maze Bank.", "传送到花园银行大厦顶楼。", "Zum Maze Bank Tower teleportieren.", "メイズバンク・タワーへテレポートします。", "Телепортироваться на башню Maze Bank.", "Teleporta para a Torre do Maze Bank.", "Se téléporter à la tour Maze Bank.") BREAK
                    CASE 2 g_selected_description = TR("Teleport to Los Santos International Airport.", "Teletranspórtate al Aeropuerto Internacional de Los Santos.", "传送到洛圣都国际机场。", "Zum Los Santos International Airport teleportieren.", "ロスサントス国際空港へテレポートします。", "Телепортироваться в международный аэропорт Лос-Сантоса.", "Teleporta para o Aeroporto Internacional de Los Santos.", "Se téléporter à l'aéroport international de Los Santos.") BREAK
                    CASE 3 g_selected_description = TR("Teleport to the Vinewood Sign.", "Teletranspórtate al letrero de Vinewood.", "传送到好麦坞山顶标志牌。", "Zum Vinewood-Schild teleportieren.", "バインウッドの看板へテレポートします。", "Телепортироваться к знаку Вайнвуд.", "Teleporta para o Letreiro de Vinewood.", "Se téléporter au panneau Vinewood.") BREAK
                    CASE 4 g_selected_description = TR("Teleport to Fort Zancudo.", "Teletranspórtate a la base militar de Fort Zancudo.", "传送到桑库多堡垒军事基地。", "Nach Fort Zancudo teleportieren.", "フォート・ザンクード軍事基地へテレポートします。", "Телепортироваться на военную базу Форт-Занкудо.", "Teleporta para o Forte Zancudo.", "Se téléporter à Fort Zancudo.") BREAK
                    CASE 5 g_selected_description = TR("Teleport to Grove Street.", "Teletranspórtate a Grove Street.", "传送到格罗夫街。", "Zur Grove Street teleportieren.", "グローブ・ストリートへテレポートします。", "Телепортироваться на Гроув-стрит.", "Teleporta para a Grove Street.", "Se téléporter à Grove Street.") BREAK
                    CASE 6 g_selected_description = TR("Teleport to Franklin's house.", "Teletranspórtate a la casa de Franklin.", "传送到富兰克林的家。", "Zu Franklins Haus teleportieren.", "フランクリンの家へテレポートします。", "Телепортироваться к дому Франклина.", "Teleporta para a casa do Franklin.", "Se téléporter à la maison de Franklin.") BREAK
                    CASE 7 g_selected_description = TR("Teleport to Michael's house.", "Teletranspórtate a la casa de Michael.", "传送到麦克的家。", "Zu Michaels Haus teleportieren.", "マイケルの家へテレポートします。", "Телепортироваться к дому Майкла.", "Teleporta para a casa do Michael.", "Se téléporter à la maison de Michael.") BREAK
                    CASE 8 g_selected_description = TR("Teleport to Trevor's trailer.", "Teletranspórtate a la caravana de Trevor.", "传送到崔佛的拖车住处。", "Zu Trevors Wohnwagen teleportieren.", "トレバーのトレーラーハウスへテレポートします。", "Телепортироваться к трейлеру Тревора.", "Teleporta para o trailer do Trevor.", "Se téléporter à la caravane de Trevor.") BREAK
                    CASE 9 g_selected_description = TR("Teleport to Lester's warehouse.", "Teletranspórtate al almacén de Lester.", "传送到莱斯特的仓库。", "Zu Lesters Lagerhaus teleportieren.", "レスターの倉庫へテレポートします。", "Телепортироваться к складу Лестера.", "Teleporta para o galpão do Lester.", "Se téléporter à l'entrepôt de Lester.") BREAK
                    CASE 10 g_selected_description = TR("Teleport to Simeon's dealership.", "Teletranspórtate al concesionario de Simeon.", "传送到西米恩的车行。", "Zu Simeons Autohaus teleportieren.", "シミオンのカーディーラーへテレポートします。", "Телепортироваться к автосалону Симона.", "Teleporta para a concessionária do Simeon.", "Se téléporter à la concession de Simeon.") BREAK
                    CASE 11 g_selected_description = TR("Teleport to the hospital.", "Teletranspórtate al hospital.", "传送到医院。", "Zum Krankenhaus teleportieren.", "病院へテレポートします。", "Телепортироваться к больнице.", "Teleporta para o hospital.", "Se téléporter à l'hôpital.") BREAK
                    CASE 12 g_selected_description = TR("Teleport to the police station.", "Teletranspórtate a la comisaría de policía.", "传送到警察局。", "Zur Polizeistation teleportieren.", "警察署へテレポートします。", "Телепортироваться к полицейскому участку.", "Teleporta para a delegacia de polícia.", "Se téléporter au commissariat de police.") BREAK
                    CASE 13 g_selected_description = TR("Teleport to an Ammu-Nation store.", "Teletranspórtate a una tienda Ammu-Nation.", "传送到武装国度枪店。", "Zu einem Ammu-Nation-Laden teleportieren.", "アミュネーション（武器屋）へテレポートします。", "Телепортироваться к магазину Ammu-Nation.", "Teleporta para uma loja Ammu-Nation.", "Se téléporter à un magasin Ammu-Nation.") BREAK
                    CASE 14 g_selected_description = TR("Teleport to Los Santos Customs.", "Teletranspórtate al taller de Los Santos Customs.", "传送到洛圣都改车王。", "Zu Los Santos Customs teleportieren.", "ロスサントス・カスタムへテレポートします。", "Телепортироваться к мастерской Los Santos Customs.", "Teleporta para a oficina Los Santos Customs.", "Se téléporter à Los Santos Customs.") BREAK
                    CASE 15 g_selected_description = TR("Load the North Yankton area and teleport there.", "Carga la zona de North Yankton y teletranspórtate allí.", "加载北扬克顿地图区域并传送过去。", "North-Yankton-Gebiet laden und dorthin teleportieren.", "ノース・ヤンクトンのマップを読み込んでテレポートします。", "Загрузить локацию Северный Янктон и телепортироваться туда.", "Carrega a área de North Yankton e teleporta para lá.", "Charger la zone de North Yankton et s'y téléporter.") BREAK
                    CASE 16 g_selected_description = TR("Load the Cayo Perico area and teleport there.", "Carga la zona de Cayo Perico y teletranspórtate allí.", "加载佩里科岛地图区域并传送过去。", "Cayo-Perico-Gebiet laden und dorthin teleportieren.", "カヨ・ペリコのマップを読み込んでテレポートします。", "Загрузить остров Кайо-Перико и телепортироваться туда.", "Carrega a área de Cayo Perico e teleporta para lá.", "Charger la zone de Cayo Perico et s'y téléporter.") BREAK
                    CASE 17 g_selected_description = TR("Teleport to Sandy Shores Airfield.", "Teletranspórtate al aeródromo de Sandy Shores.", "传送到沙滩海岸机场。", "Zum Flugplatz Sandy Shores teleportieren.", "サンディ海岸飛行場へテレポートします。", "Телепортироваться на аэродром Сэнди-Шорс.", "Teleporta para o Aeródromo de Sandy Shores.", "Se téléporter à l'aérodrome de Sandy Shores.") BREAK
                    CASE 18 g_selected_description = TR("Teleport to the IAA Building.", "Teletranspórtate al edificio de la IAA.", "传送到 IAA 大厦。", "Zum IAA-Gebäude teleportieren.", "IAAビルへテレポートします。", "Телепортироваться к зданию ЦУР (IAA).", "Teleporta para o prédio da IAA.", "Se téléporter au bâtiment de l'IAA.") BREAK
                    CASE 19 g_selected_description = TR("Teleport to Mount Gordo.", "Teletranspórtate al Monte Gordo.", "传送到戈多山。", "Zum Mount Gordo teleportieren.", "ゴルド山へテレポートします。", "Телепортироваться на гору Гордо.", "Teleporta para o Monte Gordo.", "Se téléporter au Mont Gordo.") BREAK
                    CASE 20 g_selected_description = TR("Teleport to Diamond Casino.", "Teletranspórtate al casino The Diamond.", "传送到名钻假日赌场。", "Zum Diamond Casino teleportieren.", "ダイヤモンドカジノへテレポートします。", "Телепортироваться к казино-отелю Diamond.", "Teleporta para o Cassino Diamond.", "Se téléporter au Diamond Casino.") BREAK
                    CASE 21 g_selected_description = TR("Teleport to Humane Labs.", "Teletranspórtate a los Laboratorios Humane.", "传送到人道实验室。", "Zu den Humane Labs teleportieren.", "ヒューメイン研究所へテレポートします。", "Телепортироваться в лабораторию Humane Labs.", "Teleporta para os Laboratórios Humane.", "Se téléporter aux laboratoires Humane.") BREAK
                    CASE 22 g_selected_description = TR("Teleport to Bolingbroke Prison.", "Teletranspórtate a la prisión de Bolingbroke.", "传送到博林布鲁克监狱。", "Zum Bolingbroke-Gefängnis teleportieren.", "ボーリングブローク刑務所へテレポートします。", "Телепортироваться в тюрьму Болингброук.", "Teleporta para a Prisão de Bolingbroke.", "Se téléporter à la prison de Bolingbroke.") BREAK
                    CASE 23 g_selected_description = TR("Teleport to Paleto Bay.", "Teletranspórtate a Paleto Bay.", "传送到佩立托湾。", "Nach Paleto Bay teleportieren.", "パレト・ベイへテレポートします。", "Телепортироваться в Палето-Бэй.", "Teleporta para Paleto Bay.", "Se téléporter à Paleto Bay.") BREAK
                    CASE 24 g_selected_description = TR("Teleport to Cayo Airstrip.", "Teletranspórtate a la pista de aterrizaje de Cayo Perico.", "传送到佩里科岛简易机场。", "Zur Landebahn von Cayo Perico teleportieren.", "カヨ・ペリコの滑走路へテレポートします。", "Телепортироваться на взлетную полосу Кайо-Перико.", "Teleporta para a Pista de Pouso de Cayo Perico.", "Se téléporter à la piste d'atterrissage de Cayo Perico.") BREAK
                    CASE 25 g_selected_description = TR("Teleport to Cayo Main Dock.", "Teletranspórtate al muelle principal de Cayo Perico.", "传送到佩里科岛主码头。", "Zum Hauptdock von Cayo Perico teleportieren.", "カヨ・ペリコのメインドックへテレポートします。", "Телепортироваться в главный док Кайо-Перико.", "Teleporta para a Doca Principal de Cayo Perico.", "Se téléporter au quai principal de Cayo Perico.") BREAK
                    CASE 26 g_selected_description = TR("Teleport to Cayo North Dock.", "Teletranspórtate al muelle norte de Cayo Perico.", "传送到佩里科岛北码头。", "Zum Norddock von Cayo Perico teleportieren.", "カヨ・ペリコのノースドックへテレポートします。", "Телепортироваться в северный док Кайо-Перико.", "Teleporta para a Doca Norte de Cayo Perico.", "Se téléporter au quai nord de Cayo Perico.") BREAK
                    CASE 27 g_selected_description = TR("Teleport to Cayo Mansion.", "Teletranspórtate a la mansión de Cayo Perico.", "传送到佩里科岛庄园。", "Zur Villa auf Cayo Perico teleportieren.", "カヨ・ペリコの屋敷へテレポートします。", "Телепортироваться к особняку на Кайо-Перико.", "Teleporta para a Mansão de Cayo Perico.", "Se téléporter à la villa de Cayo Perico.") BREAK
                    CASE 28 g_selected_description = TR("Teleport to Cayo Beach Party.", "Teletranspórtate a la fiesta en la playa de Cayo Perico.", "传送到佩里科岛海滩派对。", "Zur Strandparty auf Cayo Perico teleportieren.", "カヨ・ペリコのビーチパーティー会場へテレポートします。", "Телепортироваться на пляжную вечеринку Кайо-Перико.", "Teleporta para a Festa na Praia de Cayo Perico.", "Se téléporter à la fête sur la plage de Cayo Perico.") BREAK
                    CASE 29 g_selected_description = TR("Teleport to Cayo Control Tower.", "Teletranspórtate a la torre de control de Cayo Perico.", "传送到佩里科岛通信控制塔。", "Zum Kontrollturm auf Cayo Perico teleportieren.", "カヨ・ペリコの管制塔へテレポートします。", "Телепортироваться к диспетчерской вышке Кайо-Перико.", "Teleporta para a Torre de Controle de Cayo Perico.", "Se téléporter à la tour de contrôle de Cayo Perico.") BREAK
                    CASE 30 g_selected_description = TR("Teleport to Salvage Yard.", "Teletranspórtate al desguace.", "传送到回收站。", "Zum Schrottplatz teleportieren.", "サルベージヤード（廃品回収所）へテレポートします。", "Телепортироваться на утилизационный двор.", "Teleporta para o Ferro-Velho.", "Se téléporter à la casse.") BREAK
                    CASE 31 g_selected_description = TR("Teleport to Darnell Bros. Chop Shop.", "Teletranspórtate al taller de despiece Darnell Bros.", "传送到达内尔兄弟拆车厂。", "Zur Darnell-Bros.-Werkstatt teleportieren.", "ダーネル・ブラザーズのチョップショップへテレポートします。", "Телепортироваться на швейную фабрику Darnell Bros.", "Teleporta para o Desmanche Darnell Bros.", "Se téléporter à l'atelier Darnell Bros.") BREAK
                    CASE 32 g_selected_description = TR("Teleport to Gunrunning Bunker.", "Teletranspórtate al búnker de tráfico de armas.", "传送到军火贸易地堡。", "Zum Gunrunning-Bunker teleportieren.", "地下基地（バンカー）へテレポートします。", "Телепортироваться в бункер торговли оружием.", "Teleporta para o Bunker de Tráfico de Armas.", "Se téléporter au bunker de trafic d'armes.") BREAK
                    CASE 33 g_selected_description = TR("Teleport to Doomsday Facility.", "Teletranspórtate a las instalaciones del Juicio Final.", "传送到末日豪劫设施。", "Zur Weltuntergangs-Basis teleportieren.", "ドゥームズ・デイ施設へテレポートします。", "Телепортироваться на базу «Судный день».", "Teleporta para o Complexo do Juízo Final.", "Se téléporter au complexe de la Fin du Monde.") BREAK
                    CASE 34 g_selected_description = TR("Teleport to Dignity Party Yacht.", "Teletranspórtate al yate de fiesta Dignity.", "传送到尊严号派对游艇。", "Zur Party-Yacht Dignity teleportieren.", "パーティーヨット「ディグニティ」へテレポートします。", "Телепортироваться на тусовочную яхту Dignity.", "Teleporta para o Iate de Festa Dignity.", "Se téléporter au yacht de fête Dignity.") BREAK
                    ENDSWITCH
                ELSE
                    SWITCH g_item
                    CASE 0 g_selected_description = TR("Teleport to the active map waypoint.", "Teletranspórtate al destino marcado en el mapa.", "传送到地图上当前设置的导航点。", "Zum aktiven Karten-Wegpunkt teleportieren.", "マップ上の現在のウェイポイントへテレポートします。", "Телепортироваться к активной метке на карте.", "Teleporta para a marcação ativa no mapa.", "Se téléporter au repère actif sur la carte.") BREAK
                    CASE 1 g_selected_description = TR("Automatically teleport when a new waypoint is placed.", "Teletranspórtate automáticamente al colocar un nuevo destino en el mapa.", "在地图上放置新导航点时自动传送过去。", "Automatisch teleportieren, sobald ein neuer Wegpunkt gesetzt wird.", "新しいウェイポイントを置いたときに自動でテレポートします。", "Автоматически телепортироваться при установке новой метки на карте.", "Teleporta automaticamente quando uma nova marcação é colocada.", "Se téléporter automatiquement dès qu'un nouveau repère est placé.") BREAK
                    CASE 2 g_selected_description = TR("Open the robbable convenience store list.", "Abre la lista de tiendas de conveniencia atracables.", "打开可抢劫的便利店传送列表。", "Liste der ausraubbaren Läden öffnen.", "強盗可能なコンビニ・店舗のリストを開きます。", "Открыть список магазинов, доступных для ограбления.", "Abre a lista de lojas de conveniência assaltáveis.", "Ouvrir la liste des supérettes braquables.") BREAK
                    CASE 3 g_selected_description = TR("Teleport to the nearest active objective marker.", "Teletranspórtate al marcador de objetivo activo más cercano.", "传送到最近的当前任务目标点。", "Zur nächsten aktiven Zielmarkierung teleportieren.", "最も近い現在のミッション目標マーカーへテレポートします。", "Телепортироваться к ближайшему активному маркеру задания.", "Teleporta para o marcador de objetivo ativo mais próximo.", "Se téléporter au marqueur d'objectif actif le plus proche.") BREAK
                    CASE 4 g_selected_description = TR("Auto-teleport to the objective after cutscenes.", "Teletranspórtate automáticamente al objetivo tras las cinemáticas.", "过场动画结束后自动传送到任务目标点。", "Nach Zwischensequenzen automatisch zum Missionsziel teleportieren.", "ムービー終了後に自動で目標地点へテレポートします。", "Автоматически телепортироваться к цели задания после катсцен.", "Teleporta automaticamente para o objetivo após as cenas.", "Se téléporter automatiquement à l'objectif après les cinématiques.") BREAK
                    CASE 5 g_selected_description = TR("Open the fixed locations list.", "Abre la lista de ubicaciones fijas.", "打开固定地点传送列表。", "Liste der festen Orte öffnen.", "固定ロケーションのリストを開きます。", "Открыть список фиксированных мест для телепортации.", "Abre a lista de locais fixos.", "Ouvrir la liste des lieux fixes.") BREAK
                    CASE 6 g_selected_description = TR("Move one step forward from the current position. Moves the vehicle too when driving.", "Avanza un paso desde la posición actual. También mueve el vehículo al conducir.", "从当前位置向前瞬移一步（驾驶时连同载具一起移动）。", "Einen Schritt von der aktuellen Position nach vorn bewegen (auch mit Fahrzeug).", "現在位置から一歩前へ移動します（運転中は車両ごと移動）。", "Сместиться на шаг вперед от текущей позиции (вместе с машиной).", "Move um passo para frente da posição atual (move o veículo também).", "Avancer d'un pas depuis la position actuelle (déplace aussi le véhicule).") BREAK
                    CASE 7 g_selected_description = TR("Move one step backward from the current position. Moves the vehicle too when driving.", "Retrocede un paso desde la posición actual. También mueve el vehículo al conducir.", "从当前位置向后瞬移一步（驾驶时连同载具一起移动）。", "Einen Schritt von der aktuellen Position nach hinten bewegen (auch mit Fahrzeug).", "現在位置から一歩後ろへ移動します（運転中は車両ごと移動）。", "Сместиться на шаг назад от текущей позиции (вместе с машиной).", "Move um passo para trás da posição atual (move o veículo também).", "Reculer d'un pas depuis la position actuelle (déplace aussi le véhicule).") BREAK
                    CASE 8 g_selected_description = TR("Move one step up from the current position. Moves the vehicle too when driving.", "Sube un paso desde la posición actual. También mueve el vehículo al conducir.", "从当前位置向上瞬移一步（驾驶时连同载具一起移动）。", "Einen Schritt von der aktuellen Position nach oben bewegen (auch mit Fahrzeug).", "現在位置から一段上へ移動します（運転中は車両ごと移動）。", "Сместиться на шаг вверх от текущей позиции (вместе с машиной).", "Move um passo para cima da posição atual (move o veículo também).", "Monter d'un cran depuis la position actuelle (déplace aussi le véhicule).") BREAK
                    CASE 9 g_selected_description = TR("Move one step down from the current position. Moves the vehicle too when driving.", "Baja un paso desde la posición actual. También mueve el vehículo al conducir.", "从当前位置向下瞬移一步（驾驶时连同载具一起移动）。", "Einen Schritt von der aktuellen Position nach unten bewegen (auch mit Fahrzeug).", "現在位置から一段下へ移動します（運転中は車両ごと移動）。", "Сместиться на шаг вниз от текущей позиции (вместе с машиной).", "Move um passo para baixo da posição atual (move o veículo também).", "Descendre d'un cran depuis la position actuelle (déplace aussi le véhicule).") BREAK
                    CASE 10 g_selected_description = TR("Enter the X coordinate for a custom teleport.", "Introduce la coordenada X para un teletransporte personalizado.", "输入自定义传送的 X 坐标。", "X-Koordinate für einen benutzerdefinierten Teleport eingeben.", "カスタムテレポート用のX座標を入力します。", "Ввести координату X для пользовательского телепорта.", "Digite a coordenada X para um teleporte personalizado.", "Saisir la coordonnée X pour une téléportation personnalisée.") BREAK
                    CASE 11 g_selected_description = TR("Enter the Y coordinate for a custom teleport.", "Introduce la coordenada Y para un teletransporte personalizado.", "输入自定义传送的 Y 坐标。", "Y-Koordinate für einen benutzerdefinierten Teleport eingeben.", "カスタムテレポート用のY座標を入力します。", "Ввести координату Y для пользовательского телепорта.", "Digite a coordenada Y para um teleporte personalizado.", "Saisir la coordonnée Y pour une téléportation personnalisée.") BREAK
                    CASE 12 g_selected_description = TR("Enter the Z coordinate for a custom teleport.", "Introduce la coordenada Z para un teletransporte personalizado.", "输入自定义传送的 Z 坐标。", "Z-Koordinate für einen benutzerdefinierten Teleport eingeben.", "カスタムテレポート用のZ座標を入力します。", "Ввести координату Z для пользовательского телепорта.", "Digite a coordenada Z para um teleporte personalizado.", "Saisir la coordonnée Z pour une téléportation personnalisée.") BREAK
                    CASE 13 g_selected_description = TR("Teleport the player or occupied vehicle to the entered coordinates.", "Teletransporta al jugador o vehículo actual a las coordenadas introducidas.", "将玩家或当前乘坐的载具传送到输入的坐标。", "Spieler oder aktuelles Fahrzeug zu den eingegebenen Koordinaten teleportieren.", "入力した座標へプレイヤーまたは乗車中の車両をテレポートします。", "Телепортировать игрока или транспорт по введенным координатам.", "Teleporta o jogador ou veículo atual para as coordenadas digitadas.", "Téléporter le joueur ou le véhicule occupé aux coordonnées saisies.") BREAK
                ENDSWITCH
                ENDIF
                BREAK
            CASE 6
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Automatically skip story cutscenes while enabled.", "Omite automáticamente las cinemáticas de la historia mientras está activo.", "开启时自动跳过剧情过场动画。", "Story-Zwischensequenzen automatisch überspringen, solange aktiviert.", "有効中、ストーリーのムービー（カットシーン）を自動でスキップします。", "Автоматически пропускать сюжетные катсцены, пока функция включена.", "Pula automaticamente as cenas da história enquanto estiver ativado.", "Passer automatiquement les cinématiques de l'histoire tant que l'option est active.") BREAK
                    CASE 1 g_selected_description = TR("Reload the current interior to fix invisible assets.", "Recarga el interior actual para corregir objetos o texturas invisibles.", "重新加载当前室内场景以修复透明/缺失的模型。", "Aktuellen Innenraum neu laden, um unsichtbare Objekte zu beheben.", "現在の内装を再読み込みして、透明になったオブジェクトを修正します。", "Перезагрузить текущий интерьер для исправления невидимых текстур.", "Recarrega o interior atual para corrigir objetos invisíveis.", "Recharger l'intérieur actuel pour corriger les éléments invisibles.") BREAK
                    CASE 2 g_selected_description = TR("Make nearby non-player characters fight each other.", "Hace que los peatones cercanos se peleen entre sí.", "让附近的路人互相斗殴。", "Passanten in der Nähe gegeneinander kämpfen lassen.", "周囲のNPC同士を乱闘させます。", "Заставить ближайших прохожих драться друг с другом.", "Faz os pedestres próximos brigarem entre si.", "Faire se battre les passants proches entre eux.") BREAK
                    CASE 3 g_selected_description = TR("Make everyone ignore the player.", "Hace que todo el mundo ignore al jugador.", "让所有人无视玩家。", "Jeder in der Welt ignoriert den Spieler.", "周囲のすべての人がプレイヤーを無視するようにします。", "Заставить всех вокруг полностью игнорировать игрока.", "Faz todo mundo ignorar o jogador.", "Faire en sorte que tout le monde ignore le joueur.") BREAK
                    CASE 4 g_selected_description = TR("Reduce ambient pedestrian and vehicle population.", "Reduce la cantidad de peatones y tráfico en el mundo.", "减少环境中的行人和交通车辆密度。", "Passanten- und Fahrzeugdichte in der Spielwelt verringern.", "街中の歩行者や一般車両の出現数を減らします。", "Снизить плотность пешеходов и трафика в игровом мире.", "Reduz a população de pedestres e veículos no mundo.", "Réduire la densité des piétons et de la circulation.") BREAK
                    CASE 5 g_selected_description = TR("Left/Right sets NPC spawn density. 1x is default.", "Izquierda/Derecha ajusta la densidad de aparición de NPC. 1x por defecto.", "左/右方向键设置 NPC 生成密度（默认 1x）。", "Links/Rechts stellt die NPC-Spawndichte ein. 1x ist Standard.", "左右キーでNPCの出現密度を設定します（標準は1x）。", "Влево/Вправо задает плотность появления NPC. По умолчанию 1x.", "Esquerda/Direita define a densidade de NPCs. 1x é o padrão.", "Gauche/Droite définit la densité d'apparition des PNJ. 1x par défaut.") BREAK
                    CASE 6 g_selected_description = TR("Remove nearby vehicles within the cleanup radius.", "Elimina los vehículos cercanos dentro del radio de limpieza.", "清除清理半径内的附近载具。", "Fahrzeuge in der Nähe innerhalb des Bereinigungsradius entfernen.", "周囲の一定範囲内にある乗り物を消去します。", "Удалить ближайший транспорт в радиусе очистки.", "Remove os veículos próximos dentro do raio de limpeza.", "Supprimer les véhicules proches dans le rayon de nettoyage.") BREAK
                    CASE 7 g_selected_description = TR("Remove nearby peds and menu-spawned attackers.", "Elimina los peatones cercanos y los atacantes generados por el menú.", "清除附近的行人和菜单生成的袭击者。", "Passanten in der Nähe und vom Menü gespawnte Angreifer entfernen.", "周囲の歩行者とメニューで出現させた襲撃者を消去します。", "Удалить ближайших пешеходов и созданных через меню нападающих.", "Remove pedestres próximos e atacantes gerados pelo menu.", "Supprimer les piétons proches et les assaillants générés par le menu.") BREAK
                    CASE 8 g_selected_description = TR("Explode every vehicle within 1500m. Skips yours.", "Explota todos los vehículos en un radio de 1500 m, excepto el tuyo.", "引爆 1500 米内的所有载具（跳过你自己的载具）。", "Jedes Fahrzeug im Umkreis von 1500 m sprengen (eigenes ausgenommen).", "1500m以内のすべての乗り物を爆破します（自分の車両は除外）。", "Взорвать весь транспорт в радиусе 1500 м, кроме вашего.", "Explode todos os veículos em um raio de 1500 m (exceto o seu).", "Faire exploser tous les véhicules dans un rayon de 1500 m, sauf le vôtre.") BREAK
                    CASE 9 g_selected_description = TR("Force the camera into first-person view.", "Fuerza la cámara a la vista en primera persona.", "强制将游戏镜头切换为第一人称视角。", "Kamera in die Ego-Perspektive zwingen.", "カメラを強制的に一人称視点にします。", "Принудительно включить вид камеры от первого лица.", "Força a câmera para a visão em primeira pessoa.", "Forcer la caméra en vue à la première personne.") BREAK
                    CASE 10 g_selected_description = TR("Hide the normal HUD.", "Oculta la interfaz (HUD) normal en pantalla.", "隐藏常规游戏 HUD 界面。", "Normales HUD ausblenden.", "通常のHUD表示を非表示にします。", "Скрыть основной игровой интерфейс (HUD).", "Oculta o HUD normal do jogo.", "Masquer l'interface tête haute (HUD) normale.") BREAK
                    CASE 11 g_selected_description = TR("Hide the minimap and radar.", "Oculta el minimapa y el radar.", "隐藏小地图和雷达。", "Minikarte und Radar ausblenden.", "ミニマップとレーダーを非表示にします。", "Скрыть миникарту и радар.", "Oculta o minimapa e o radar.", "Masquer la mini-carte et le radar.") BREAK
                    CASE 12 g_selected_description = TR("Left/Right picks one of four stripper models, A spawns her 3m in front. Keeps at most 128, replacing the oldest. Clear Nearby Peds removes them.", "Izquierda/Derecha elige una de las cuatro bailarinas; A la genera a 3 m delante.", "左/右选择四种舞女模型之一，按 A 在前方 3 米处生成（最多保留 128 个，清除附近路人可移除）。", "Links/Rechts wählt eines von vier Stripperinnen-Modellen, A spawnt sie 3 m vor dem Spieler.", "左右で4種類のストリッパーから選択し、Aで3m前方に出現させます（最大128人）。", "Влево/Вправо выбирает модель танцовщицы, A создает ее в 3 м впереди (до 128).", "Esquerda/Direita escolhe uma das quatro dançarinas, A gera a 3 m na frente.", "Gauche/Droite choisit l'un des quatre modèles de strip-teaseuse, A la fait apparaître à 3 m.") BREAK
                    CASE 13 g_selected_description = TR("Display live player X, Y, and Z coordinates in the top-right corner.", "Muestra las coordenadas X, Y y Z del jugador en vivo en la esquina superior derecha.", "在屏幕右上角实时显示玩家的 X、Y、Z 坐标。", "Live-X-, Y- und Z-Koordinaten des Spielers oben rechts einblenden.", "画面右上にプレイヤーの現在のX・Y・Z座標をリアルタイム表示します。", "Показывать текущие координаты X, Y и Z игрока в правом верхнем углу.", "Exibe as coordenadas X, Y e Z do jogador em tempo real no canto superior direito.", "Afficher les coordonnées X, Y et Z en direct dans le coin supérieur droit.") BREAK
                ENDSWITCH
                BREAK
            CASE 7
                IF g_language_open
                    g_selected_description = TR("Press A to apply this language to the entire menu and save it.", "Pulsa A para aplicar este idioma a todo el menú y guardarlo.", "按 A 将此语言应用到整个菜单并保存。", "Drücke A, um diese Sprache auf das gesamte Menü anzuwenden und zu speichern.", "Aボタンを押してこの言語をメニュー全体に適用し、保存します。", "Нажмите A, чтобы применить этот язык ко всему меню и сохранить его.", "Pressione A para aplicar este idioma a todo o menu e salvá-lo.", "Appuyez sur A pour appliquer cette langue à tout le menu et la sauvegarder.")
                ELIF g_spooner_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Left/Right cycles curated world props. Press A to spawn the selected prop at the player offset.", "Izquierda/Derecha recorre objetos del mundo. Pulsa A para generar el objeto seleccionado.", "左/右切换精选世界物件，按 A 在玩家偏移位置生成所选物件。", "Links/Rechts wechselt durch Welt-Objekte. A drücken, um das Objekt am Spieler-Offset zu spawnen.", "左右でオブジェクトを切り替え、Aでプレイヤー基準位置に出現させます。", "Влево/Вправо листает каталог объектов. Нажмите A для спавна со смещением от игрока.", "Esquerda/Direita alterna objetos do mundo. Pressione A para gerar o objeto selecionado.", "Gauche/Droite parcourt les objets du monde. Appuyez sur A pour faire apparaître l'objet.") BREAK
                        CASE 1 g_selected_description = TR("Enter any prop model name or hash via the keyboard and spawn it into the world.", "Introduce cualquier nombre o hash de objeto con el teclado y genéralo en el mundo.", "通过键盘输入任意物件模型名称或哈希值并在世界中生成。", "Beliebigen Objekt-Modellnamen oder Hash per Tastatur eingeben und in der Welt spawnen.", "キーボードでオブジェクト名またはハッシュ値を入力して出現させます。", "Введите имя модели объекта или хэш с клавиатуры и создайте его в мире.", "Digite qualquer nome ou hash de objeto pelo teclado e gere-o no mundo.", "Saisir un nom de modèle d'objet ou un hash au clavier et le faire apparaître.") BREAK
                        CASE 2 g_selected_description = TR("Request the selected catalog prop into memory and instantiate it at the current offset.", "Carga en memoria el objeto seleccionado del catálogo y lo crea en la posición actual.", "将所选目录物件加载到内存并在当前偏移位置生成。", "Ausgewähltes Katalog-Objekt in den Speicher laden und am aktuellen Offset erstellen.", "選択中のカタログオブジェクトをメモリに読み込み、現在位置に配置します。", "Загрузить выбранный объект из каталога в память и создать его в текущей точке.", "Carrega o objeto selecionado na memória e o instancia no deslocamento atual.", "Charger l'objet du catalogue en mémoire et l'instancier au décalage actuel.") BREAK
                        CASE 3 g_selected_description = TR("Adjust the opacity of the live prop preview from 0 (transparent) to 100 (full texture).", "Ajusta la opacidad de la vista previa del objeto de 0 (transparente) a 100 (opaco).", "调整实时物件预览的不透明度（0 为全透明，100 为完全不透明）。", "Deckkraft der Live-Objektvorschau von 0 (transparent) bis 100 (voll sichtbar) anpassen.", "オブジェクトのプレビュー表示の不透明度を0（透明）から100（不透明）まで調整します。", "Настроить прозрачность предпросмотра объекта от 0 (прозрачный) до 100 (полный).", "Ajusta a opacidade da prévia do objeto de 0 (transparente) a 100 (opaco).", "Ajuster l'opacité de l'aperçu de l'objet de 0 (transparent) à 100 (opaque).") BREAK
                        CASE 4 g_selected_description = TR("Cycle through actively spawned Spooner objects. Press A to snap the selected object to your current offset.", "Recorre los objetos generados activos. Pulsa A para traer el objeto seleccionado a tu posición.", "切换已生成的 Spooner 物件。按 A 将所选物件移动到当前偏移位置。", "Durch aktiv gespawnte Spooner-Objekte wechseln. A drücken, um das Objekt zum aktuellen Offset zu holen.", "出現済みのオブジェクトを切り替えます。Aで選択オブジェクトを現在位置へ移動します。", "Переключение между созданными объектами. Нажмите A, чтобы перенести объект к себе.", "Alterne entre os objetos gerados ativos. Pressione A para puxar o objeto selecionado.", "Parcourir les objets générés actifs. Appuyez sur A pour placer l'objet au décalage actuel.") BREAK
                        CASE 5 g_selected_description = TR("Adjust forward/backward placement relative to the player matrix (-50m to +50m). Press A to reset to 2.50m.", "Ajusta la posición adelante/atrás respecto al jugador (-50 m a +50 m). A restablece a 2.50 m.", "调整相对于玩家的前后位置（-50 米至 +50 米）。按 A 重置为 2.50 米。", "Vor-/Rückwärts-Position relativ zum Spieler anpassen (-50 m bis +50 m). A setzt auf 2.50 m zurück.", "プレイヤー基準の前後位置を調整（-50m〜+50m）。Aで2.50mにリセット。", "Смещение вперед/назад относительно игрока (-50 м до +50 м). A — сброс на 2.50 м.", "Ajusta a posição frente/trás em relação ao jogador (-50 m a +50 m). A redefine para 2.50 m.", "Ajuster la position avant/arrière par rapport au joueur (-50 m à +50 m). A réinitialise à 2.50 m.") BREAK
                        CASE 6 g_selected_description = TR("Adjust left/right placement relative to the player matrix (-50m to +50m). Press A to reset to 0.00m.", "Ajusta la posición izquierda/derecha respecto al jugador (-50 m a +50 m). A restablece a 0.00 m.", "调整相对于玩家的左右位置（-50 米至 +50 米）。按 A 重置为 0.00 米。", "Links-/Rechts-Position relativ zum Spieler anpassen (-50 m bis +50 m). A setzt auf 0.00 m zurück.", "プレイヤー基準の左右位置を調整（-50m〜+50m）。Aで0.00mにリセット。", "Смещение влево/вправо относительно игрока (-50 м до +50 м). A — сброс на 0.00 м.", "Ajusta a posição esquerda/direita em relação ao jogador (-50 m a +50 m). A redefine para 0.00 m.", "Ajuster la position gauche/droite par rapport au joueur (-50 m à +50 m). A réinitialise à 0.00 m.") BREAK
                        CASE 7 g_selected_description = TR("Adjust vertical height relative to the player matrix (-50m to +50m). Press A to reset to 0.00m.", "Ajusta la altura vertical respecto al jugador (-50 m a +50 m). A restablece a 0.00 m.", "调整相对于玩家的垂直高度（-50 米至 +50 米）。按 A 重置为 0.00 米。", "Vertikale Höhe relativ zum Spieler anpassen (-50 m bis +50 m). A setzt auf 0.00 m zurück.", "プレイヤー基準の上下高さを調整（-50m〜+50m）。Aで0.00mにリセット。", "Вертикальная высота относительно игрока (-50 м до +50 м). A — сброс на 0.00 м.", "Ajusta a altura vertical em relação ao jogador (-50 m a +50 m). A redefine para 0.00 m.", "Ajuster la hauteur verticale par rapport au joueur (-50 m à +50 m). A réinitialise à 0.00 m.") BREAK
                        CASE 8 g_selected_description = TR("Adjust heading rotation relative to the player's facing angle (0 to 355 deg). Press A to reset to 0 deg.", "Ajusta el ángulo de giro respecto a la orientación del jugador (0 a 355 grados). A restablece a 0.", "调整相对于玩家朝向的水平旋转角度（0 至 355 度）。按 A 重置为 0 度。", "Drehwinkel relativ zur Blickrichtung des Spielers anpassen (0 bis 355 Grad). A setzt auf 0 zurück.", "プレイヤーの向きに対する回転角を調整（0〜355度）。Aで0度にリセット。", "Угол поворота относительно взгляда игрока (от 0 до 355 град.). A — сброс на 0.", "Ajusta a rotação em relação à direção do jogador (0 a 355 graus). A redefine para 0.", "Ajuster la rotation par rapport à l'angle du joueur (0 à 355 deg). A réinitialise à 0 deg.") BREAK
                        CASE 9 g_selected_description = TR("Anchor the selected object in mid-air so it defies gravity and world physics.", "Fija el objeto seleccionado en el aire para que ignore la gravedad y las físicas.", "将所选物件固定在半空中，使其不受重力和物理碰撞影响。", "Ausgewähltes Objekt in der Luft verankern, sodass Schwerkraft und Physik ignoriert werden.", "選択したオブジェクトを空中に固定し、重力や物理演算を無効化します。", "Зафиксировать выбранный объект в воздухе, отключив гравитацию и физику.", "Trava o objeto selecionado no ar para ignorar a gravidade e a física.", "Figer l'objet sélectionné en l'air pour ignorer la gravité et la physique.") BREAK
                        CASE 10 g_selected_description = TR("Toggle physical model collision boundaries on or off for the selected object.", "Activa o desactiva las colisiones físicas para el objeto seleccionado.", "开启或关闭所选物件的物理碰撞体积。", "Physische Kollisionen für das ausgewählte Objekt ein- oder ausschalten.", "選択したオブジェクトの物理的な当たり判定（コリジョン）を切り替えます。", "Включить или выключить физические коллизии для выбранного объекта.", "Ativa ou desativa a colisão física para o objeto selecionado.", "Activer ou désactiver les collisions physiques pour l'objet sélectionné.") BREAK
                        CASE 11 g_selected_description = TR("Decouple the game camera into free-roaming flight mode for easier construction viewing.", "Desacopla la cámara del juego en modo de vuelo libre para facilitar la construcción.", "将游戏镜头解耦为自由飞行视角，以便于观察和搭建。", "Spielkamera in den freien Flugmodus lösen, um das Bauen besser zu überblicken.", "建築しやすいようにゲームカメラをフリーカメラ（自由飛行）モードにします。", "Переключить камеру в режим свободного полета для удобного строительства.", "Libera a câmera do jogo em modo de voo livre para facilitar a construção.", "Détacher la caméra en mode vol libre pour faciliter la construction.") BREAK
                        CASE 12 g_selected_description = TR("Query terrain collision height and snap the selected object cleanly onto the ground surface.", "Calcula la altura del terreno y ajusta el objeto seleccionado directamente sobre el suelo.", "检测地面高度并将所选物件平整地贴合到地面上。", "Bodenhöhe ermitteln und das ausgewählte Objekt sauber auf dem Boden platzieren.", "地面の高さを取得し、選択したオブジェクトを地表にぴったり接地させます。", "Определить высоту поверхности и ровно поставить выбранный объект на землю.", "Detecta a altura do terreno e alinha o objeto selecionado perfeitamente no chão.", "Calculer la hauteur du sol et plaquer proprement l'objet sélectionné au sol.") BREAK
                        CASE 13 g_selected_description = TR("Select the target player skeleton bone (or player vehicle) for entity attachment.", "Selecciona el hueso del esqueleto del jugador (o su vehículo) para acoplar el objeto.", "选择用于附着实体的目标玩家骨骼部位（或玩家载具）。", "Ziel-Skelettknochen des Spielers (oder Spielerfahrzeug) zum Anheften auswählen.", "オブジェクトを装着するプレイヤーの骨格部位（または車両）を選択します。", "Выберите кость скелета игрока (или его машину) для прикрепления объекта.", "Selecione o osso do esqueleto do jogador (ou veículo) para anexar o objeto.", "Sélectionner l'os du squelette du joueur (ou son véhicule) pour attacher l'objet.") BREAK
                        CASE 14 g_selected_description = TR("Adjust relative X attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m.", "Ajusta el desplazamiento X relativo en el hueso (-5.00 m a +5.00 m). A restablece a 0.00 m.", "调整目标骨骼上的相对 X 附着偏移（-5.00 米至 +5.00 米）。按 A 重置为 0.00 米。", "Relativen X-Versatz am Zielknochen anpassen (-5.00 m bis +5.00 m). A setzt auf 0.00 m zurück.", "対象部位での相対Xオフセットを調整（-5.00m〜+5.00m）。Aで0.00mにリセット。", "Смещение привязки по оси X на кости (-5.00 м до +5.00 м). A — сброс на 0.00 м.", "Ajusta o deslocamento X relativo no osso (-5.00 m a +5.00 m). A redefine para 0.00 m.", "Ajuster le décalage X relatif sur l'os (-5.00 m à +5.00 m). A réinitialise à 0.00 m.") BREAK
                        CASE 15 g_selected_description = TR("Adjust relative Y attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m.", "Ajusta el desplazamiento Y relativo en el hueso (-5.00 m a +5.00 m). A restablece a 0.00 m.", "调整目标骨骼上的相对 Y 附着偏移（-5.00 米至 +5.00 米）。按 A 重置为 0.00 米。", "Relativen Y-Versatz am Zielknochen anpassen (-5.00 m bis +5.00 m). A setzt auf 0.00 m zurück.", "対象部位での相対Yオフセットを調整（-5.00m〜+5.00m）。Aで0.00mにリセット。", "Смещение привязки по оси Y на кости (-5.00 м до +5.00 м). A — сброс на 0.00 м.", "Ajusta o deslocamento Y relativo no osso (-5.00 m a +5.00 m). A redefine para 0.00 m.", "Ajuster le décalage Y relatif sur l'os (-5.00 m à +5.00 m). A réinitialise à 0.00 m.") BREAK
                        CASE 16 g_selected_description = TR("Adjust relative Z attachment offset on the target bone (-5.00m to +5.00m). Press A to reset to 0.00m.", "Ajusta el desplazamiento Z relativo en el hueso (-5.00 m a +5.00 m). A restablece a 0.00 m.", "调整目标骨骼上的相对 Z 附着偏移（-5.00 米至 +5.00 米）。按 A 重置为 0.00 米。", "Relativen Z-Versatz am Zielknochen anpassen (-5.00 m bis +5.00 m). A setzt auf 0.00 m zurück.", "対象部位での相対Zオフセットを調整（-5.00m〜+5.00m）。Aで0.00mにリセット。", "Смещение привязки по оси Z на кости (-5.00 м до +5.00 м). A — сброс на 0.00 м.", "Ajusta o deslocamento Z relativo no osso (-5.00 m a +5.00 m). A redefine para 0.00 m.", "Ajuster le décalage Z relatif sur l'os (-5.00 m à +5.00 m). A réinitialise à 0.00 m.") BREAK
                        CASE 17 g_selected_description = TR("Left/Right adjusts the active rotation offset (-180 to 180 deg). Press A to cycle Pitch, Roll, and Yaw.", "Izquierda/Derecha ajusta el giro activo (-180 a 180 grados). A alterna cabeceo, alabeo y guiñada.", "左/右调整当前旋转偏移（-180 至 180 度）。按 A 切换俯仰角、翻滚角和偏航角。", "Links/Rechts ändert den Drehwinkel (-180 bis 180 Grad). A wechselt zwischen Nick-, Roll- und Gierwinkel.", "左右で回転オフセットを調整（-180〜180度）。Aでピッチ・ロール・ヨーを切り替えます。", "Влево/Вправо меняет угол вращения (-180 до 180 град.). A переключает тангаж, крен и рыскание.", "Esquerda/Direita ajusta a rotação ativa (-180 a 180 graus). A alterna inclinação, rolagem e guinada.", "Gauche/Droite ajuste la rotation (-180 à 180 deg). A alterne tangage, roulis et lacet.") BREAK
                        CASE 18 g_selected_description = TR("Pin the selected object to the chosen player skeleton bone using the relative offsets, or detach it.", "Acopla el objeto seleccionado al hueso elegido usando los desplazamientos relativos, o desacoplalo.", "使用相对偏移将所选物件固定到选定的玩家骨骼上，或将其分离。", "Ausgewähltes Objekt mit dem Versatz an den gewählten Knochen anheften oder wieder lösen.", "相対オフセットを使って選択オブジェクトを指定部位に装着、または取り外します。", "Прикрепить выбранный объект к выбранной кости с учетом смещений или открепить его.", "Prende o objeto selecionado ao osso escolhido usando os deslocamentos, ou o solta.", "Attacher l'objet sélectionné à l'os choisi selon les décalages, ou le détacher.") BREAK
                        CASE 19 g_selected_description = TR("Safely remove the most recently spawned object from the world pool and free its tracking slot.", "Elimina de forma segura el último objeto generado del mundo y libera su ranura.", "从世界中安全移除最近生成的物件并释放其槽位。", "Zuletzt gespawntes Objekt sicher aus der Welt entfernen und seinen Slot freigeben.", "最後に出現させたオブジェクトを安全に削除し、管理スロットを解放します。", "Безопасно удалить последний созданный объект из мира и освободить слот.", "Remove com segurança o último objeto gerado do mundo e libera seu espaço.", "Supprimer proprement le dernier objet généré du monde et libérer son emplacement.") BREAK
                        CASE 20 g_selected_description = TR("Delete all spawned Spooner objects from the active world pool to prevent Switch memory leaks.", "Elimina todos los objetos generados por Spooner para liberar memoria en Switch.", "删除世界中所有已生成的 Spooner 物件，以释放 Switch 内存。", "Alle gespawnten Spooner-Objekte aus der Welt löschen, um Switch-Speicher freizugeben.", "出現させたすべてのSpoonerオブジェクトを一括削除し、Switchのメモリを解放します。", "Удалить все созданные объекты Spooner из мира для очистки памяти Switch.", "Exclui todos os objetos gerados pelo Spooner para liberar memória no Switch.", "Supprimer tous les objets Spooner générés afin de libérer la mémoire de la Switch.") BREAK
                    ENDSWITCH
                ELIF g_nsc_unload_open
                    g_selected_description = TR("Press A to immediately terminate and unload this script from the RAGE VM.", "Pulsa A para terminar y descargar inmediatamente este script de la máquina virtual RAGE.", "按 A 立即终止并从 RAGE 虚拟机中卸载此脚本。", "A drücken, um dieses Skript sofort zu beenden und aus der RAGE-VM zu entladen.", "Aボタンを押してこのスクリプトを即座に終了し、RAGE VMからアンロードします。", "Нажмите A, чтобы немедленно остановить и выгрузить этот скрипт из RAGE VM.", "Pressione A para encerrar e descarregar imediatamente este script da RAGE VM.", "Appuyez sur A pour arrêter et décharger immédiatement ce script de la RAGE VM.")
                ELIF g_nsc_loader_open
                    IF g_item = 0
                        g_selected_description = TR("Enter a .nsc filename with the Switch keyboard and save it to persistence (1000-letter max).", "Introduce un nombre de archivo .nsc con el teclado de Switch y guárdalo (máx. 1000 letras).", "使用 Switch 键盘输入 .nsc 文件名并保存到持久化存储（最多 1000 个字符）。", "Einen .nsc-Dateinamen per Switch-Tastatur eingeben und dauerhaft speichern (max. 1000 Zeichen).", "Switchのキーボードで.nscファイル名を入力し、保存します（最大1000文字）。", "Введите имя файла .nsc с клавиатуры Switch и сохраните его в список (макс. 1000 символов).", "Digite um nome de arquivo .nsc com o teclado do Switch e salve-o (máx. 1000 letras).", "Saisir un nom de fichier .nsc au clavier Switch et le sauvegarder (1000 caractères max).")
                    ELIF g_item = 1
                        g_selected_description = TR("Select the RAGE VM stack pool size allocated when launching or reloading a .nsc script.", "Selecciona el tamaño de pila (stack) de la RAGE VM al iniciar o recargar un script .nsc.", "选择启动或重载 .nsc 脚本时分配的 RAGE 虚拟机栈池大小。", "Stack-Größe der RAGE-VM auswählen, die beim Starten eines .nsc-Skripts reserviert wird.", ".nscスクリプトの起動・再読み込み時に割り当てるRAGE VMスタックサイズを選択します。", "Выберите размер стека RAGE VM, выделяемый при запуске или перезагрузке скрипта .nsc.", "Selecione o tamanho da pilha (stack) da RAGE VM ao iniciar ou recarregar um script .nsc.", "Sélectionner la taille de pile RAGE VM allouée au lancement d'un script .nsc.")
                    ELIF g_item = 2
                        g_selected_description = TR("Terminate all running custom .nsc script threads and release their bytecode handles.", "Termina todos los hilos de scripts .nsc personalizados activos y libera su memoria.", "终止所有正在运行的自定义 .nsc 脚本线程并释放其字节码句柄。", "Alle laufenden benutzerdefinierten .nsc-Skripte beenden und deren Speicher freigeben.", "実行中のすべてのカスタム.nscスクリプトを終了し、メモリハンドルを解放します。", "Остановить все запущенные пользовательские скрипты .nsc и освободить их ресурсы.", "Encerra todos os scripts .nsc personalizados em execução e libera a memória.", "Arrêter tous les scripts .nsc personnalisés actifs et libérer leurs ressources.")
                    ELIF (g_nsc_active_count > 0 OR CORE_NSC_ACTIVE_COUNT() > 0) AND g_item = 3
                        g_selected_description = TR("View and unload individual running custom .nsc scripts.", "Consulta y descarga individualmente los scripts .nsc personalizados en ejecución.", "查看并单独卸载正在运行的自定义 .nsc 脚本。", "Laufende benutzerdefinierte .nsc-Skripte einzeln anzeigen und entladen.", "実行中のカスタム.nscスクリプトを個別に確認・アンロードします。", "Просмотр и индивидуальная выгрузка запущенных пользовательских скриптов .nsc.", "Visualize e descarregue individualmente os scripts .nsc personalizados em execução.", "Voir et décharger individuellement les scripts .nsc personnalisés en cours d'exécution.")
                    ELSE
                        IF g_nsc_discovered_count <= 0
                            g_selected_description = TR("No saved custom .nsc scripts yet. Press A to enter a .nsc filename with the Switch keyboard.", "Aún no hay scripts .nsc guardados. Pulsa A para introducir un nombre con el teclado de Switch.", "尚无已保存的自定义 .nsc 脚本。按 A 使用 Switch 键盘输入 .nsc 文件名。", "Noch keine eigenen .nsc-Skripte gespeichert. A drücken, um einen Dateinamen per Tastatur einzugeben.", "保存されたカスタム.nscスクリプトがありません。Aを押してファイル名を入力してください。", "Сохраненных скриптов .nsc пока нет. Нажмите A, чтобы ввести имя файла с клавиатуры.", "Nenhum script .nsc personalizado salvo ainda. Pressione A para digitar um nome no teclado.", "Aucun script .nsc personnalisé sauvegardé. Appuyez sur A pour saisir un nom au clavier.")
                        ELSE
                            g_selected_description = TR("Press A to load or reload this .nsc script. Hold LB + RB + X to delete it from the list.", "Pulsa A para cargar o recargar este script .nsc. Mantén LB + RB + X para borrarlo de la lista.", "按 A 加载或重载此 .nsc 脚本。按住 LB + RB + X 将其从列表中删除。", "A drücken, um dieses .nsc-Skript zu laden. LB + RB + X halten, um es aus der Liste zu löschen.", "Aでこの.nscスクリプトを起動・再読み込みします。LB+RB+X長押しでリストから削除します。", "Нажмите A для загрузки или перезапуска этого скрипта .nsc. Удерживайте LB + RB + X для удаления.", "Pressione A para carregar ou recarregar este script .nsc. Segure LB + RB + X para excluí-lo.", "Appuyez sur A pour charger ou recharger ce script .nsc. Maintenez LB + RB + X pour le supprimer.")
                        ENDIF
                    ENDIF
                ELIF g_plugin_mgr_open
                    IF NOT g_plugin_mgr_ready
                        g_selected_description = TR("Install the paired ScriptHookV-NX subsdk5 and bindings, then fully restart GTA.", "Instala subsdk5 y los enlaces compatibles y reinicia GTA por completo.", "安装配套 ScriptHookV-NX subsdk5 和绑定文件，然后完全重启 GTA。", "Passendes subsdk5 und Bindings installieren, dann GTA vollständig neu starten.", "対応するsubsdk5とバインドを導入し、GTAを完全に再起動してください。", "Установите совместимые subsdk5 и привязки, затем полностью перезапустите GTA.", "Instale subsdk5 e vínculos compatíveis e reinicie GTA por completo.", "Installez subsdk5 et les liaisons associés, puis redémarrez complètement GTA.")
                    ELIF g_plugin_mgr_detail_open
                        SWITCH g_item
                            CASE 0 g_selected_description = TR("Request one load without changing startup mode. Disabled modules must first be set to Manual or Auto.", "Solicita una carga sin cambiar el inicio. Los desactivados requieren modo Manual o Auto.", "请求加载一次，不改变启动模式。禁用插件须先设为手动或自动。", "Einmal laden ohne Startmodusänderung. Deaktivierte Module zuerst auf Manuell oder Auto setzen.", "起動モードを変えずに一度読み込みます。無効な場合は先に手動か自動に設定してください。", "Однократная загрузка без смены режима. Отключённые сначала переведите в ручной или авто.", "Carrega uma vez sem alterar o início. Desativados precisam do modo Manual ou Auto.", "Charger une fois sans changer le démarrage. Passez les modules désactivés en Manuel ou Auto.") BREAK
                            CASE 1 g_selected_description = TR("Left/Right selects; A saves and verifies. Auto loads on launch; Manual waits; Disabled blocks loading. Use Load Now or Kill Process to change the current session.", "Izq./Der. elige; A guarda y verifica. Auto carga al iniciar; Manual espera; Desactivado bloquea. Usa Cargar ahora o Detener proceso en esta sesión.", "左右选择，按 A 保存并验证。自动随启动加载，手动等待，禁用阻止加载。立即加载或终止进程用于当前会话。", "Links/Rechts wählt, A speichert und prüft. Auto lädt beim Start, Manuell wartet, Deaktiviert sperrt. Aktuell mit Jetzt laden oder Prozess stoppen ändern.", "左右で選択、Aで保存・確認。自動は起動時、手動は待機、無効は読込禁止。現在の実行は今すぐ読込かプロセス停止で変更。", "Влево/вправо — выбор, A — сохранить. Авто при запуске, вручную ждёт, отключено блокирует. Для текущего сеанса — загрузка или остановка.", "Esq./Dir. seleciona; A salva e verifica. Auto ao iniciar; Manual espera; Desativado bloqueia. Use Carregar agora ou Parar processo nesta sessão.", "Gauche/Droite choisit, A enregistre et vérifie. Auto au lancement, Manuel attend, Désactivé bloque. Pour cette session, chargez ou arrêtez le processus.") BREAK
                            CASE 2 g_selected_description = TR("Current session state. Restart means the startup policy changed while the module is still loaded. Stopped or Finished modules can be started again with Load Now.", "Estado actual. Reiniciar indica un inicio cambiado con el módulo cargado. Detenido o Finalizado puede iniciarse con Cargar ahora.", "当前会话状态。需重启表示模块已加载但启动模式已改变。已停止或已结束的模块可用立即加载再次启动。", "Aktueller Zustand. Neustart heißt Startmodus bei geladenem Modul geändert. Gestoppte oder beendete Module mit Jetzt laden starten.", "現在の状態。再起動は読込中に起動設定が変わった印。停止・終了したモジュールは今すぐ読込で再開できます。", "Текущее состояние. Перезапуск — режим изменён при загруженном модуле. Остановленные и завершённые можно загрузить снова.", "Estado atual. Reiniciar indica modo alterado com o módulo carregado. Parados ou concluídos podem iniciar com Carregar agora.", "État actuel. Redémarrer indique un mode changé alors que le module reste chargé. Relancez les modules arrêtés ou terminés avec Charger maintenant.") BREAK
                            CASE 3 g_selected_description = TR("Memory mapped for this plugin. This is not total game memory usage.", "Memoria asignada a este plugin. No es el uso total del juego.", "此插件的映射内存，并非游戏内存总用量。", "Für dieses Plugin belegter Speicher, nicht der Gesamtverbrauch des Spiels.", "このプラグインの割当メモリです。ゲーム全体の使用量ではありません。", "Память этого плагина, а не всей игры.", "Memória alocada ao plugin, não o uso total do jogo.", "Mémoire allouée à ce plugin, pas l'usage total du jeu.") BREAK
                            CASE 4 g_selected_description = TR("Queued confirms the request was accepted. Check Runtime for loading success or failure.", "En cola confirma la solicitud. Consulta el estado para ver el resultado.", "已排队仅表示接受请求，请查看运行状态确认加载结果。", "Eingereiht bestätigt die Anfrage. Ergebnis unter Laufzeit prüfen.", "待機中は要求の受付を示します。読込結果は現在の状態で確認してください。", "В очереди значит запрос принят. Результат смотрите в состоянии.", "Na fila confirma o pedido. Confira o estado para ver o resultado.", "En attente confirme la demande. Consultez l'état pour le résultat.") BREAK
                            CASE 5 g_selected_description = TR("Error returned by the last manager action. Zero means the request was accepted.", "Error de la última acción. Cero indica solicitud aceptada.", "上次管理操作的错误码，零表示请求已接受。", "Fehler der letzten Aktion. Null bedeutet Anfrage angenommen.", "最後の操作のエラー。ゼロは要求受付を示します。", "Ошибка последнего действия. Ноль значит запрос принят.", "Erro da última ação. Zero indica pedido aceito.", "Erreur de la dernière action. Zéro signifie demande acceptée.") BREAK
                            CASE 6 g_selected_description = TR("Stop the running plugin script safely. Loaded code and registered natives stay valid. Load Now restarts the script; Startup Mode is unchanged. Inactive when no script is running.", "Detén el script del plugin. El código y los nativos siguen válidos. Cargar ahora lo reinicia; el inicio no cambia. Inactivo si no hay script ejecutándose.", "安全停止插件脚本，保留已加载代码和已注册原生函数。立即加载可重启脚本，启动模式不变。未运行时不可用。", "Plugin-Skript sicher stoppen. Code und registrierte Natives bleiben gültig. Jetzt laden startet erneut; Startmodus bleibt. Ohne laufendes Skript inaktiv.", "実行中スクリプトを安全に停止。コードと登録ネイティブは保持。今すぐ読込で再開し、起動設定は不変。非実行時は無効。", "Безопасно остановить скрипт. Код и нативы остаются. Загрузка запускает заново; режим не меняется. Без работающего скрипта недоступно.", "Pare o script com segurança. Código e nativos ficam válidos. Carregar agora reinicia; o modo não muda. Inativo sem script em execução.", "Arrête le script sans invalider le code ni les natives. Charger maintenant le relance ; le démarrage reste inchangé. Inactif sans script en cours.") BREAK
                        ENDSWITCH
                        IF g_item = 2 AND g_plugin_mgr_slot >= 0 AND g_plugin_mgr_slot < g_plugin_mgr_count
                            IF g_plugin_mgr_states[g_plugin_mgr_slot] = 2
                                g_selected_description = g_plugin_mgr_status_text[g_plugin_mgr_slot]
                            ENDIF
                        ENDIF
                    ELIF g_item = 0
                        g_selected_description = TR("Discover added or renamed plugin files. Loaded modules are retained; rescan never unloads them.", "Busca plugins nuevos o renombrados. Conserva los cargados; nunca los descarga.", "发现新增或改名的插件文件，保留已加载模块，不会卸载。", "Neue oder umbenannte Plugins suchen. Geladene Module bleiben erhalten.", "追加や改名されたファイルを再走査。読込済みモジュールは保持されます。", "Поиск новых или переименованных файлов. Загруженные модули сохраняются.", "Busca arquivos novos ou renomeados. Módulos carregados são mantidos.", "Détecte les fichiers ajoutés ou renommés. Les modules chargés sont conservés.")
                    ELIF g_plugin_mgr_count <= 0
                        g_selected_description = TR("No .nro plugins found in sd:/switch/gtav-scripthook/plugins/. Place .nro modules there to manage them here.", "No se encontraron plugins .nro en sd:/switch/gtav-scripthook/plugins/. Coloca módulos .nro allí para gestionarlos.", "未在 sd:/switch/gtav-scripthook/plugins/ 中发现 .nro 插件。放置 .nro 模块后在此处管理。", "Keine .nro-Plugins in sd:/switch/gtav-scripthook/plugins/ gefunden. .nro-Module dort ablegen.", "sd:/switch/gtav-scripthook/plugins/ に.nroプラグインが見つかりません。モジュールを配置してください。", "Плагины .nro не найдены в sd:/switch/gtav-scripthook/plugins/. Поместите их туда для управления.", "Nenhum plugin .nro encontrado em sd:/switch/gtav-scripthook/plugins/. Coloque módulos .nro lá.", "Aucun plugin .nro trouvé dans sd:/switch/gtav-scripthook/plugins/. Placez des modules .nro ici.")
                    ELSE
                        g_selected_description = TR("Press A to open this plugin's Load Now, startup mode, and current status.", "Pulsa A para ver Cargar ahora, modo de inicio y estado actual.", "按 A 打开插件的立即加载、启动模式和当前状态。", "A öffnet Jetzt laden, Startmodus und aktuellen Zustand dieses Plugins.", "Aで今すぐ読込、起動モード、現在の状態を開きます。", "A открывает загрузку, режим запуска и состояние плагина.", "A abre Carregar agora, modo de início e estado atual.", "A ouvre le chargement, le mode de démarrage et l'état actuel.")
                    ENDIF
                ELIF g_credits_open
                    SWITCH g_item
                        CASE 0 g_selected_description = "https://discord.gg/us4CNYmVB" BREAK
                        CASE 1 g_selected_description = TR("Aka. @bigasspussy on Discord :3", "También conocido como @bigasspussy en Discord :3", "Discord 昵称：@bigasspussy :3", "Auch bekannt als @bigasspussy auf Discord :3", "Discord名: @bigasspussy :3", "Также известен как @bigasspussy в Discord :3", "Também conhecido como @bigasspussy no Discord :3", "Alias @bigasspussy sur Discord :3") BREAK
                        CASE 2 g_selected_description = TR("GOAT", "El mejor (GOAT)", "传奇大神 (GOAT)", "Der Beste (GOAT)", "最高峰 (GOAT)", "Легенда (GOAT)", "O melhor (GOAT)", "Le meilleur (GOAT)") BREAK
                        CASE 3 g_selected_description = "" BREAK
                        CASE 4 g_selected_description = "https://github.com/ShinyWasabi/RageMenu/" BREAK
                        CASE 5 g_selected_description = "" BREAK
                    ENDSWITCH
                ELIF g_persist_open
                    SWITCH g_item
                        CASE 0 g_selected_description = TR("Restore menu settings automatically from SD card on the next launch.", "Restaura los ajustes del menú automáticamente desde la tarjeta SD en el próximo inicio.", "下次启动游戏时自动从 SD 卡恢复菜单设置。", "Menüeinstellungen beim nächsten Start automatisch von SD-Karte wiederherstellen.", "次回起動時にメニュー設定をSDカードから自動的に復元します。", "Автоматически восстанавливать настройки меню с SD-карты при следующем запуске.", "Restaura as configurações do menu automaticamente do cartão SD na próxima inicialização.", "Restaurer automatiquement les paramètres du menu depuis la carte SD au prochain lancement.") BREAK
                        CASE 1 g_selected_description = TR("Save current settings directly to SD card via ScriptHookV-NX now.", "Guarda los ajustes actuales directamente en la tarjeta SD mediante ScriptHookV-NX ahora.", "立即通过 ScriptHookV-NX 将当前设置直接保存到 SD 卡。", "Aktuelle Einstellungen jetzt über ScriptHookV-NX direkt auf SD-Karte speichern.", "現在の設定をScriptHookV-NX経由で今すぐSDカードに保存します。", "Сохранить текущие настройки напрямую на SD-карту через ScriptHookV-NX прямо сейчас.", "Grava as configurações atuais diretamente no cartão SD via ScriptHookV-NX agora.", "Enregistrer immédiatement les paramètres actuels sur la carte SD via ScriptHookV-NX.") BREAK
                        CASE 2 g_selected_description = TR("Erase the stored settings from SD card so the next launch uses the menu defaults.", "Borra los ajustes guardados de la SD para que el próximo inicio use los valores por defecto.", "从 SD 卡清除已保存的设置，使下次启动时恢复菜单默认值。", "Gespeicherte Einstellungen von der SD-Karte löschen, sodass beim nächsten Start Standardwerte genutzt werden.", "SDカードの保存設定を消去し、次回起動時に初期設定を使用します。", "Стереть сохраненные настройки с SD-карты, чтобы при следующем запуске использовались стандартные.", "Apaga as configurações salvas do cartão SD para usar os padrões no próximo início.", "Effacer les paramètres enregistrés de la carte SD pour revenir aux valeurs par défaut au prochain lancement.") BREAK
                        CASE 3 g_selected_description = TR("Test ScriptHookV-NX SD card bridge read and write. Safe: it never touches your settings.", "Prueba la lectura y escritura del bridge SD de ScriptHookV-NX. Seguro: no altera tus ajustes.", "测试 ScriptHookV-NX SD 卡桥接读写（安全：不会改动你的实际设置）。", "Lese- und Schreibvorgänge der ScriptHookV-NX-SD-Bridge testen. Sicher: Eigene Einstellungen bleiben unberührt.", "ScriptHookV-NXのSDカード読み書きブリッジを診断します（現在の設定には影響しません）。", "Проверить чтение и запись через мост ScriptHookV-NX на SD-карту (безопасно для настроек).", "Testa a leitura e gravação da ponte SD do ScriptHookV-NX (não afeta seus ajustes).", "Tester la lecture et l'écriture du pont SD ScriptHookV-NX (sans risque pour vos paramètres).") BREAK
                        CASE 4 g_selected_description = TR("Result of the last SD card storage self-test.", "Resultado de la última autoprueba de almacenamiento SD.", "上一次 SD 卡存储自检的结果。", "Ergebnis des letzten SD-Speicher-Selbsttests.", "前回のSDカードストレージ自己診断の結果。", "Результат последней проверки хранилища на SD-карте.", "Resultado do último autoteste de armazenamento no SD.", "Résultat du dernier auto-test de stockage SD.") BREAK
                        CASE 5 g_selected_description = TR("Automatically write settings to SD card file whenever a change is made.", "Guarda automáticamente los ajustes en el archivo de la SD cada vez que se hace un cambio.", "设置发生更改时自动写入 SD 卡存储文件。", "Einstellungen bei jeder Änderung automatisch in die SD-Kartendatei schreiben.", "設定変更時にSDカードのファイルへ自動的に保存します。", "Автоматически записывать настройки в файл на SD-карте при любом изменении.", "Grava automaticamente as configurações no arquivo do cartão SD sempre que houver alteração.", "Enregistrer automatiquement les paramètres sur le fichier de la carte SD à chaque modification.") BREAK
                        CASE 6 g_selected_description = TR("What the last launch found in SD card storage.", "Lo que encontró el último inicio en el almacenamiento de la tarjeta SD.", "上次启动时在 SD 卡存储中读取到的状态。", "Was beim letzten Start im SD-Speicher gefunden wurde.", "前回の起動時にSDカード内で検出された状態。", "Что было обнаружено на SD-карте при последнем запуске.", "O que a última inicialização encontrou no armazenamento do cartão SD.", "Ce que le dernier lancement a trouvé sur la carte SD.") BREAK
                        CASE 7 g_selected_description = TR("Whether the stored SD data matches its checksum.", "Indica si los datos guardados en la SD coinciden con su suma de verificación.", "SD 卡上存储的数据是否与其校验和匹配。", "Ob die gespeicherten SD-Daten mit ihrer Prüfsumme übereinstimmen.", "SDカードに保存されたデータがチェックサムと一致しているかを表示します。", "Совпадают ли данные на SD-карте с контрольной суммой.", "Indica se os dados do cartão SD correspondem à soma de verificação.", "Indique si les données stockées sur la carte SD correspondent à leur somme de contrôle.") BREAK
                        CASE 8 g_selected_description = TR("Direct SD card file persistence powered by ScriptHookV-NX (subsdk5). Zero save corruption.", "Persistencia directa en tarjeta SD mediante ScriptHookV-NX (subsdk5). Cero corrupción de partidas.", "基于 ScriptHookV-NX (subsdk5) 的 SD 卡直写持久化，彻底杜绝存档损坏。", "Direkte SD-Karten-Dateipersistenz über ScriptHookV-NX (subsdk5). Verhindert Spielstand-Fehler.", "ScriptHookV-NX (subsdk5) によるSDカード直接ファイル永続化。セーブデータの破損を防ぎます。", "Прямое сохранение на SD-карту через ScriptHookV-NX (subsdk5). Без повреждения сохранений игры.", "Persistência direta em arquivo no cartão SD via ScriptHookV-NX (subsdk5). Zero corrupção de saves.", "Persistance directe sur carte SD via ScriptHookV-NX (subsdk5). Zéro corruption de sauvegarde.") BREAK
                        CASE 9 g_selected_description = TR("Writes the ScriptHookV-NX SD bridge accepted during the last flush.", "Escrituras aceptadas por el bridge SD de ScriptHookV-NX en el último guardado.", "上次刷新时 ScriptHookV-NX SD 桥接接受的写入次数。", "Vom ScriptHookV-NX-SD-Bridge akzeptierte Schreibvorgänge beim letzten Speichern.", "前回の保存でScriptHookV-NX SDブリッジが受け付けた書き込み数。", "Записи, принятые мостом ScriptHookV-NX при последнем сбросе.", "Gravações aceitas pela ponte SD do ScriptHookV-NX no último salvamento.", "Écritures acceptées par le pont SD ScriptHookV-NX lors du dernier enregistrement.") BREAK
                        CASE 10 g_selected_description = TR("Writes rejected by the SD bridge during the last flush. Should be 0.", "Escrituras rechazadas por el bridge SD en el último guardado. Debería ser 0.", "上次刷新时 SD 桥接拒绝的写入次数（正常应为 0）。", "Von der SD-Bridge abgelehnte Schreibvorgänge beim letzten Speichern. Sollte 0 sein.", "前回の保存でSDブリッジに拒否された書き込み数（通常は0）。", "Записи, отклоненные мостом SD при последнем сбросе. Должно быть 0.", "Gravações rejeitadas pela ponte SD no último salvamento. Deve ser 0.", "Écritures refusées par le pont SD lors du dernier enregistrement. Devrait être 0.") BREAK
                        CASE 11 g_selected_description = TR("SD boot load attempts used before giving up.", "Intentos de carga de SD al iniciar empleados antes de terminar.", "启动时从 SD 卡读取设置所用的尝试次数。", "Verwendete SD-Ladeversuche beim Start.", "起動時のSDカード設定読み込み試行回数。", "Количество попыток чтения настроек с SD при запуске.", "Tentativas de carregamento do SD usadas na inicialização.", "Tentatives de chargement SD utilisées au démarrage.") BREAK
                        CASE 12 g_selected_description = TR("SD storage checks that passed during the last self-test.", "Comprobaciones de almacenamiento SD superadas en la última autoprueba.", "上次自检通过的 SD 存储检查项数量。", "Bestandene SD-Speicherprüfungen beim letzten Selbsttest.", "前回の自己診断で合格したSDストレージチェック数。", "Успешные проверки хранилища на SD при последнем тестировании.", "Verificações de armazenamento no SD aprovadas no último autoteste.", "Vérifications de stockage SD réussies lors du dernier auto-test.") BREAK
                        CASE 13 g_selected_description = TR("SD storage checks that failed during the last self-test. Should be 0.", "Comprobaciones de almacenamiento SD fallidas en la última autoprueba. Debería ser 0.", "上次自检失败的 SD 存储检查项数量（正常应为 0）。", "Fehlgeschlagene SD-Speicherprüfungen beim letzten Selbsttest. Sollte 0 sein.", "前回の自己診断で失敗したSDストレージチェック数（通常は0）。", "Ошибки хранилища на SD при последнем тестировании. Должно быть 0.", "Verificações de armazenamento no SD que falharam no último autoteste. Deve ser 0.", "Vérifications de stockage SD échouées lors du dernier auto-test. Devrait être 0.") BREAK
                        // Frame-time probe readout (v0.9.9 hitch hunt). Every one of
                        // these is a worst-case single-frame cost in ms since the
                        // last reset, so the reading is only meaningful when one
                        // action is measured at a time.
                        CASE 14 g_selected_description = TR("Longest gap between two menu frames, in ms. This is the pause the player actually feels.", "Mayor intervalo entre dos fotogramas del menú, en ms. Es la pausa que nota el jugador.", "两次菜单帧之间的最大间隔（毫秒），即玩家实际感受到的卡顿时长。", "Längste Pause zwischen zwei Menü-Frames in ms. Das ist der Ruckler, den der Spieler spürt.", "2つのメニューフレーム間の最長間隔（ミリ秒）。プレイヤーが体感する引っかかりです。", "Максимальная задержка между двумя кадрами меню в мс (ощутимая пауза).", "Maior intervalo entre dois quadros do menu, em ms (a pausa sentida pelo jogador).", "Plus long écart entre deux images du menu, en ms (la saccade ressentie par le joueur).") BREAK
                        CASE 15 g_selected_description = TR("Longest time this script spent inside one frame, in ms. Compare with Worst Frame MS.", "Mayor tiempo empleado por este script en un fotograma, en ms.", "此脚本在单帧内消耗的最长时间（毫秒），可与最差帧耗时对比。", "Längste Zeit, die dieses Skript innerhalb eines Frames verbracht hat, in ms.", "このスクリプトが1フレーム内で費やした最長時間（ミリ秒）。", "Максимальное время работы этого скрипта внутри одного кадра, в мс.", "Maior tempo que este script gastou dentro de um único quadro, em ms.", "Plus long temps passé par ce script dans une seule image, en ms.") BREAK
                        CASE 16 g_selected_description = TR("Longest time spent in the persistence step of the frame loop, in ms.", "Mayor tiempo empleado en el paso de persistencia del bucle, en ms.", "帧循环中持久化步骤消耗的最长时间（毫秒）。", "Längste Zeit im Persistenz-Schritt der Frame-Schleife, in ms.", "フレームループ内の設定保存処理に費やした最長時間（ミリ秒）。", "Максимальное время, затраченное на шаг сохранения настроек в цикле кадра, в мс.", "Maior tempo gasto na etapa de persistência do loop de quadros, em ms.", "Plus long temps passé dans l'étape de persistance de la boucle, en ms.") BREAK
                        CASE 17 g_selected_description = TR("Longest single settings write burst, in ms. Reset, change one setting, read this.", "Mayor ráfaga de escritura de ajustes, en ms.", "单次设置写入突发的最长耗时（毫秒）。", "Längster einzelner Schreibvorgang für Einstellungen, in ms.", "単一の設定書き込みバーストの最長時間（ミリ秒）。", "Самая долгая одиночная запись пакета настроек, в мс.", "Maior rajada única de gravação de configurações, em ms.", "Plus longue rafale d'écriture des paramètres, en ms.") BREAK
                        CASE 18 g_selected_description = TR("Longest menu sound call, in ms.", "Llamada de sonido del menú más larga, en ms.", "菜单音效调用的最长耗时（毫秒）。", "Längster Menü-Soundaufruf, in ms.", "メニュー効果音呼び出しの最長時間（ミリ秒）。", "Самый долгий вызов звука меню, в мс.", "Chamada de som do menu mais longa, em ms.", "Plus long appel sonore du menu, en ms.") BREAK
                        CASE 19 g_selected_description = TR("Longest single A-press apply, in ms.", "Aplicación más larga al pulsar A, en ms.", "单次按 A 应用选项的最长耗时（毫秒）。", "Längste Ausführung beim Drücken von A, in ms.", "Aボタン適用処理の単一最長時間（ミリ秒）。", "Самое долгое применение опции по нажатию A, в мс.", "Aplicação única mais longa ao pressionar A, em ms.", "Plus longue application lors d'un appui sur A, en ms.") BREAK
                        CASE 20 g_selected_description = TR("Longest menu draw pass, in ms.", "Pasada de dibujado del menú más larga, en ms.", "菜单绘制过程的最长耗时（毫秒）。", "Längster Zeichen-Durchlauf des Menüs, in ms.", "メニュー描画パスの最長時間（ミリ秒）。", "Самая долгая отрисовка интерфейса меню, в мс.", "Passagem de desenho do menu mais longa, em ms.", "Plus longue passe de rendu du menu, en ms.") BREAK
                        CASE 21 g_selected_description = TR("Tab x100 + row of the slowest apply above, so the row itself can be identified.", "Pestaña x100 + fila de la aplicación más lenta anterior, para identificar la fila.", "上面最慢应用项的'标签页 x100 + 行号'，用于定位具体行。", "Tab x100 + Zeile der langsamsten Ausführung oben, um die Zeile zu identifizieren.", "上記の最も遅かった適用処理の「タブ×100＋行番号」。", "Вкладка x100 + строка самого медленного применения выше для определения строки.", "Aba x100 + linha da aplicação mais lenta acima, para identificar a linha.", "Onglet x100 + ligne de l'application la plus lente ci-dessus.") BREAK
                        CASE 22 g_selected_description = TR("Settings write bursts since the last reset, including the empty ones.", "Ráfagas de escritura de ajustes desde el último reinicio.", "自上次重置以来的设置写入次数（包括空写入）。", "Schreibvorgänge für Einstellungen seit dem letzten Reset.", "前回のリセット以降の設定書き込み回数（空の処理を含む）。", "Количество циклов записи настроек с момента последнего сброса.", "Rajadas de gravação de configurações desde a última redefinição.", "Rafales d'écriture des paramètres depuis la dernière réinitialisation.") BREAK
                        CASE 23 g_selected_description = TR("Menu sounds played since the last reset.", "Sonidos del menú reproducidos desde el último reinicio.", "自上次重置以来播放的菜单音效次数。", "Gespielte Menü-Sounds seit dem letzten Reset.", "前回のリセット以降に再生されたメニュー効果音の数。", "Количество звуков меню, воспроизведенных с момента последнего сброса.", "Sons do menu reproduzidos desde a última redefinição.", "Sons du menu joués depuis la dernière réinitialisation.") BREAK
                        CASE 24 g_selected_description = TR("Clear every probe reading so the next single action can be measured on its own.", "Borra todas las lecturas de prueba para medir la siguiente acción por separado.", "清零所有性能探针读数，以便单独测量下一次操作。", "Alle Messwerte zurücksetzen, um die nächste einzelne Aktion isoliert zu messen.", "すべての計測値をリセットし、次の単一操作を個別に測定できるようにします。", "Сбросить все показатели профилировщика для замера следующего действия.", "Limpa todas as leituras para que a próxima ação possa ser medida isoladamente.", "Effacer toutes les mesures afin d'évaluer la prochaine action séparément.") BREAK
                    ENDSWITCH
                ELSE
                SWITCH g_item
                    CASE 0 g_selected_description = TR("Change the menu language and save it to your game profile.", "Cambia el idioma del menú y guárdalo en tu perfil de juego.", "更改菜单语言并将其保存到游戏存档。", "Ändere die Menüsprache und speichere sie im Spielprofil.", "メニューの言語を変更し、セーブデータに保存します。", "Изменить язык меню и сохранить его в профиле игры.", "Altere o idioma do menu e salve-o no perfil do jogo.", "Changez la langue du menu et sauvegardez-la dans votre profil.") BREAK
                    CASE 1 g_selected_description = TR("Spawn, position, freeze, attach, and manage live-session world objects.", "Genera, posiciona, congela, acopla y gestiona objetos del mundo en la sesión.", "生成、定位、冻结、附着并管理当前战局中的世界物件。", "Welt-Objekte in der laufenden Sitzung spawnen, positionieren, einfrieren, anheften und verwalten.", "ワールド内のオブジェクトの出現、配置、固定、装着、管理を行います。", "Создание, перемещение, заморозка, прикрепление и управление объектами в мире.", "Gere, posicione, congele, anexe e gerencie objetos do mundo na sessão atual.", "Faire apparaître, positionner, figer, attacher et gérer des objets du monde.") BREAK
                    CASE 2 g_selected_description = TR("Add custom Switch .nsc scripts via keyboard, save them to persistence, and inject or hot-reload them.", "Añade scripts .nsc personalizados por teclado, guárdalos e inyéctalos o recárgalos.", "通过键盘添加自定义 Switch .nsc 脚本，持久保存并注入或热重载。", "Eigene Switch-.nsc-Skripte per Tastatur hinzufügen, speichern und starten oder neu laden.", "キーボードでカスタム.nscスクリプトを追加・保存し、起動やホットリロードを行います。", "Добавление пользовательских скриптов .nsc с клавиатуры, их сохранение и запуск.", "Adicione scripts .nsc personalizados pelo teclado, salve-os e injete ou recarregue-os.", "Ajouter des scripts .nsc Switch au clavier, les sauvegarder et les charger à chaud.") BREAK
                    CASE 3 g_selected_description = TR("Inspect, toggle ON/OFF, and manage universal ScriptHookV-NX .nro plugins dynamically.", "Inspecciona, activa/desactiva y gestiona plugins universales .nro de ScriptHookV-NX.", "检查、动态启闭并管理 ScriptHookV-NX 通用 .nro 插件。", "Universelle ScriptHookV-NX .nro-Plugins dynamisch prüfen, ein-/ausschalten und verwalten.", "ScriptHookV-NXの汎用.nroプラグインを確認し、動的な有効化/無効化や管理を行います。", "Управление универсальными .nro плагинами ScriptHookV-NX на лету.", "Inspecione, ative/desative e gerencie plugins universais .nro do ScriptHookV-NX.", "Inspecter, activer/désactiver et gérer les plugins .nro universels ScriptHookV-NX.") BREAK
                    CASE 4 g_selected_description = TR("Choose the menu accent color.", "Elige el color de acento del menú.", "选择菜单主题强调色。", "Akzentfarbe des Menüs wählen.", "メニューのアクセントカラーを選択します。", "Выбрать основной цвет оформления меню.", "Escolha a cor de destaque do menu.", "Choisir la couleur d'accentuation du menu.") BREAK
                    CASE 5
                        IF g_accent_choice = 14
                            g_selected_description = TR("Speed 0.25x to 10.00x. Stopped freezes.", "Velocidad de 0.25x a 10.00x. Detenido congela el color.", "速度 0.25x 至 10.00x。停止会冻结颜色。", "Geschwindigkeit 0.25x bis 10.00x. Gestoppt friert ein.", "速度 0.25x〜10.00x。停止で色を固定します。", "Скорость от 0.25x до 10.00x. Стоп замораживает цвет.", "Velocidade de 0.25x a 10.00x. Parado congela.", "Vitesse de 0.25x à 10.00x. Arrêté fige la couleur.")
                        ELSE
                            g_selected_description = TR("Choose where custom death respawns place the player.", "Elige dónde reaparece el jugador al morir con la reaparición personalizada.", "选择自定义死亡重生时玩家出现的位置。", "Ort wählen, an dem der Spieler nach dem Tod wiederbelebt wird.", "カスタムリスポーン有効時に死亡後どこに復活するかを選択します。", "Выберите место пользовательского возрождения игрока после смерти.", "Escolha onde o jogador renasce ao morrer com o renascimento personalizado.", "Choisir l'endroit où le joueur réapparaît après la mort.")
                        ENDIF
                    BREAK
                    CASE 6
                        IF g_accent_choice = 14
                            g_selected_description = TR("Choose where custom death respawns place the player.", "Elige dónde reaparece el jugador al morir con la reaparición personalizada.", "选择自定义死亡重生时玩家出现的位置。", "Ort wählen, an dem der Spieler nach dem Tod wiederbelebt wird.", "カスタムリスポーン有効時に死亡後どこに復活するかを選択します。", "Выберите место пользовательского возрождения игрока после смерти.", "Escolha onde o jogador renasce ao morrer com o renascimento personalizado.", "Choisir l'endroit où le joueur réapparaît après la mort.")
                        ELSE
                            g_selected_description = TR("Enable automatic respawn at the selected location.", "Activa la reaparición automática en la ubicación seleccionada.", "启用在所选位置自动重生。", "Automatischen Respawn am gewählten Ort aktivieren.", "選択した場所での自動リスポーンを有効にします。", "Включить автоматическое возрождение в выбранном месте.", "Ativa o renascimento automático no local selecionado.", "Activer la réapparition automatique à l'emplacement sélectionné.")
                        ENDIF
                    BREAK
                    CASE 7
                        IF g_accent_choice = 14
                            g_selected_description = TR("Enable automatic respawn at the selected location.", "Activa la reaparición automática en la ubicación seleccionada.", "启用在所选位置自动重生。", "Automatischen Respawn am gewählten Ort aktivieren.", "選択した場所での自動リスポーンを有効にします。", "Включить автоматическое возрождение в выбранном месте.", "Ativa o renascimento automático no local selecionado.", "Activer la réapparition automatique à l'emplacement sélectionné.")
                        ELSE
                            g_selected_description = TR("Move the menu horizontally.", "Mueve el menú horizontalmente en la pantalla.", "水平移动菜单位置。", "Menü horizontal verschieben.", "メニューの位置を左右に移動します。", "Переместить меню по горизонтали.", "Move o menu horizontalmente.", "Déplacer le menu horizontalement.")
                        ENDIF
                    BREAK
                    CASE 8
                        IF g_accent_choice = 14
                            g_selected_description = TR("Move the menu horizontally.", "Mueve el menú horizontalmente en la pantalla.", "水平移动菜单位置。", "Menü horizontal verschieben.", "メニューの位置を左右に移動します。", "Переместить меню по горизонтали.", "Move o menu horizontalmente.", "Déplacer le menu horizontalement.")
                        ELSE
                            g_selected_description = TR("Move the menu vertically.", "Mueve el menú verticalmente en la pantalla.", "垂直移动菜单位置。", "Menü vertikal verschieben.", "メニューの位置を上下に移動します。", "Переместить меню по вертикали.", "Move o menu verticalmente.", "Déplacer le menu verticalement.")
                        ENDIF
                    BREAK
                    CASE 9
                        IF g_accent_choice = 14
                            g_selected_description = TR("Move the menu vertically.", "Mueve el menú verticalmente en la pantalla.", "垂直移动菜单位置。", "Menü vertikal verschieben.", "メニューの位置を上下に移動します。", "Переместить меню по вертикали.", "Move o menu verticalmente.", "Déplacer le menu verticalement.")
                        ELSE
                            g_selected_description = TR("Choose the button combo that opens the menu.", "Elige la combinación de botones que abre el menú.", "选择打开菜单的按键组合。", "Tastenkombination zum Öffnen des Menüs wählen.", "メニューを開くボタンの組み合わせを選択します。", "Выбрать комбинацию кнопок для открытия меню.", "Escolha a combinação de botões que abre o menu.", "Choisir la combinaison de touches qui ouvre le menu.")
                        ENDIF
                    BREAK
                    CASE 10
                        IF g_accent_choice = 14
                            g_selected_description = TR("Choose the button combo that opens the menu.", "Elige la combinación de botones que abre el menú.", "选择打开菜单的按键组合。", "Tastenkombination zum Öffnen des Menüs wählen.", "メニューを開くボタンの組み合わせを選択します。", "Выбрать комбинацию кнопок для открытия меню.", "Escolha a combinação de botões que abre o menu.", "Choisir la combinaison de touches qui ouvre le menu.")
                        ELSE
                            g_selected_description = TR("Remember menu settings across launches, and check the storage that holds them.", "Recuerda los ajustes del menú entre sesiones y comprueba el almacenamiento.", "在每次启动之间记住菜单设置，并检查保存设置的存储状态。", "Menüeinstellungen über Neustarts hinweg merken und den Speicher prüfen.", "次回起動時もメニュー設定を保持し、保存ストレージの状態を確認します。", "Сохранять настройки меню между запусками и проверять состояние хранилища.", "Lembra as configurações do menu entre sessões e verifica o armazenamento.", "Mémoriser les paramètres du menu entre les sessions et vérifier le stockage.")
                        ENDIF
                    BREAK
                    CASE 11
                        IF g_accent_choice = 14
                            g_selected_description = TR("Remember menu settings across launches, and check the storage that holds them.", "Recuerda los ajustes del menú entre sesiones y comprueba el almacenamiento.", "在每次启动之间记住菜单设置，并检查保存设置的存储状态。", "Menüeinstellungen über Neustarts hinweg merken und den Speicher prüfen.", "次回起動時もメニュー設定を保持し、保存ストレージの状態を確認します。", "Сохранять настройки меню между запусками и проверять состояние хранилища.", "Lembra as configurações do menu entre sessões e verifica o armazenamento.", "Mémoriser les paramètres du menu entre les sessions et vérifier le stockage.")
                        ELSE
                            g_selected_description = TR("View project credits and community links.", "Ver los créditos del proyecto y enlaces de la comunidad.", "查看项目制作人员名单与社区链接。", "Projekt-Credits und Community-Links anzeigen.", "プロジェクトのクレジットとコミュニティリンクを表示します。", "Посмотреть авторов проекта и ссылки на сообщество.", "Veja os créditos do projeto e links da comunidade.", "Voir les crédits du projet et les liens de la communauté.")
                        ENDIF
                    BREAK
                    CASE 12 g_selected_description = TR("View project credits and community links.", "Ver los créditos del proyecto y enlaces de la comunidad.", "查看项目制作人员名单与社区链接。", "Projekt-Credits und Community-Links anzeigen.", "プロジェクトのクレジットとコミュニティリンクを表示します。", "Посмотреть авторов проекта и ссылки на сообщество.", "Veja os créditos do proyecto e links da comunidade.", "Voir les crédits du projet et les liens de la communauté.") BREAK
                ENDSWITCH
                ENDIF
                BREAK
        ENDSWITCH
    ENDIF
ENDPROC

FUNC INT CURRENT_PAGE_ID()
    IF g_home RETURN 0 ENDIF
    IF g_outfit_open RETURN 100 ENDIF
    IF g_radio_open RETURN 101 ENDIF
    IF g_bodyguard_open
        IF g_guard_ped_open RETURN 102 ENDIF
        RETURN 103
    ENDIF
    IF g_attacker_open
        IF g_attacker_ped_open RETURN 104 ENDIF
        RETURN 105
    ENDIF
    IF g_ped_open
        IF g_story_ped_picker_open RETURN 106 ENDIF
        IF g_story_peds_open RETURN 107 ENDIF
        RETURN 108
    ENDIF
    IF g_chauffeur_open
        IF g_chauffeur_armed_open RETURN 109 ENDIF
        IF g_chauffeur_vehicle_open RETURN 110 ENDIF
        IF g_chauffeur_ped_open RETURN 111 ENDIF
        RETURN 112
    ENDIF
    IF g_neon_anim_open RETURN 113 ENDIF
    IF g_spawner_open
        IF g_saved_veh_confirm_open RETURN 114 ENDIF
        IF g_saved_vehicles_open RETURN 115 ENDIF
        IF g_vehicle_list_open RETURN 138 ENDIF
        RETURN 116
    ENDIF
    IF g_vehicle_control_open RETURN 117 ENDIF
    IF g_hydro_open RETURN 118 ENDIF
    IF g_interior_open RETURN 119 ENDIF
    IF g_wheeltyre_open RETURN 120 ENDIF
    IF g_lsc_extras_open RETURN 121 ENDIF
    IF g_bennys_open RETURN 122 ENDIF
    IF g_support_open RETURN 123 ENDIF
    IF g_lsc_open RETURN 124 ENDIF
    IF g_weapon_upgrades_open RETURN 125 ENDIF
    IF g_tp_stores_open RETURN 126 ENDIF
    IF g_tp_locs_open RETURN 127 ENDIF
    IF g_timeweather_open RETURN 128 ENDIF
    IF g_mayhem_open RETURN 129 ENDIF
    IF g_language_open RETURN 130 ENDIF
    IF g_spooner_open RETURN 131 ENDIF
    IF g_nsc_unload_open RETURN 132 ENDIF
    IF g_nsc_loader_open RETURN 133 ENDIF
    IF g_plugin_mgr_open
        IF g_plugin_mgr_detail_open RETURN 134 ENDIF
        RETURN 135
    ENDIF
    IF g_credits_open RETURN 136 ENDIF
    IF g_persist_open RETURN 137 ENDIF
    RETURN g_tab + 1
ENDFUNC

PROC UPDATE_CURRENT_DESCRIPTION()
    INT pageId = CURRENT_PAGE_ID()
    IF NOT g_description_dirty
        IF g_description_cached_item = g_item AND g_description_cached_page_id = pageId AND g_description_cached_language = g_menu_language AND g_description_cached_x = g_menu_x AND g_description_cached_y = g_menu_y
            EXIT
        ENDIF
    ENDIF
    g_description_dirty = FALSE
    g_description_cached_item = g_item
    g_description_cached_page_id = pageId
    SELECTED_DESCRIPTION_TEXT()
    PREPARE_DESCRIPTION_LAYOUT(g_selected_description)
    IF g_description_height <= 0.0
        g_description_cached_extra_height = -0.070
    ELSE
        g_description_cached_extra_height = g_description_height - 0.054
        IF g_description_cached_extra_height < -0.020
            g_description_cached_extra_height = -0.020
        ENDIF
    ENDIF
ENDPROC

PROC DRAW_SELECTED_DESCRIPTION()
    MENU_DESCRIPTION_TEXT(g_selected_description)
ENDPROC

FUNC FLOAT SELECTED_DESCRIPTION_PANEL_HEIGHT()
    RETURN g_description_height
ENDFUNC

PROC DRAW_DESCRIPTION_PANEL()
    // The panel grows downward from the fixed separator so long descriptions
    // are never cut off; the menu backdrop grows with it (see DRAW_PAGE).
    FLOAT panelHeight = SELECTED_DESCRIPTION_PANEL_HEIGHT()
    IF panelHeight <= 0.0
        EXIT
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, 0.578 + g_menu_y, MENU_W - 0.012, 0.002, 100, 108, 118, 220)
    DRAW_RECT(g_menu_x - 0.015, 0.593 + (panelHeight / 2.0) + g_menu_y, MENU_W - 0.012, panelHeight, 8, 9, 12, 205)
    DRAW_SELECTED_DESCRIPTION()
ENDPROC

// The menu backdrop grows and shrinks with the description panel so long
// text never pokes past the menu bottom and 1-line text leaves no dead gap.
// Short 2-line descriptions keep the original dimensions.
FUNC FLOAT DESCRIPTION_PANEL_EXTRA_HEIGHT()
    RETURN g_description_cached_extra_height
ENDFUNC

PROC DRAW_MENU_BACKDROP()
    FLOAT extraHeight = DESCRIPTION_PANEL_EXTRA_HEIGHT()
    DRAW_RECT(g_menu_x - 0.015, 0.403 + (extraHeight / 2.0) + g_menu_y, MENU_W, 0.505 + extraHeight, 8, 9, 12, 220)
ENDPROC

PROC DRAW_TAB(FLOAT x, STRING label, BOOL selected)
    IF selected
        DRAW_RECT(x, 0.204 + g_menu_y, 0.060, 0.034, g_accent_r, g_accent_g, g_accent_b, 255)
        MENU_TEXT(x - 0.025, 0.194, 0.205, 255, 255, 255, label)
    ELSE
        DRAW_RECT(x, 0.204 + g_menu_y, 0.060, 0.034, 28, 30, 34, 245)
        MENU_TEXT(x - 0.025, 0.194, 0.205, 190, 198, 210, label)
    ENDIF
ENDPROC

PROC DRAW_OPTION(FLOAT y, STRING label, STRING value, BOOL selected, INT state)
    value = TR_VALUE_TOKEN(value)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        IF state = 0
            rr = 162
            gg = 50
            bb = 55
        ELIF state = 1
            rr = 27
            gg = 142
            bb = 82
        ELSE
            rr = g_accent_r
            gg = g_accent_g
            bb = g_accent_b
        ENDIF
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    IF state = 0
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 255, 100, 100, value)
    ELIF state = 1
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 95, 245, 150, value)
    ELSE
        MENU_TEXT_RIGHT(g_menu_x + 0.086, y - 0.012, 0.290, 210, 230, 255, value)
    ENDIF
ENDPROC

PROC DRAW_NUMBER_OPTION(FLOAT y, STRING label, INT value, BOOL selected)
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
    // DISPLAY_TEXT_WITH_NUMBER does not resolve consistently in this menu's
    // render path on Switch.  The regular NUMBER command is reliable for
    // both the default spawn count and values entered through the keyboard.
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("NUMBER")
        ADD_TEXT_COMPONENT_INTEGER(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DRAW_FLOAT_OPTION(FLOAT y, STRING label, FLOAT value, BOOL selected)
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
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_FLOAT(value, 2)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

// Auto Save countdown, drawn like the speedometer so it shows whether the menu
// is open or closed. Deliberately positioned with absolute screen coordinates
// rather than MENU_TEXT, which would offset it with the menu's X/Y.
//
// Drawn LEFT-justified on two lines sharing AUTO_SAVE_TIMER_X (label on top,
// timer under it) - the same shape batch39 used, which rendered correctly on
// hardware. The right-justified version moved to in batch40/batch41 did not:
// the label and the digits did not share a right edge and the timer broke one
// part per line. Right-justified text is also sensitive to the wrap window,
// which persists between frames (the description panel leaves a narrow one).
// Left-justified layout has neither problem, so it is used here. Both the wrap
// and the justify are set explicitly so nothing can be inherited from the draw
// before (the speedometer leaves wrap (0.0, 0.905)).
PROC DRAW_AUTO_SAVE_TIMER()
    INT remainingMs = 0
    INT totalSeconds = 0
    INT hours = 0
    INT minutes = 0
    INT seconds = 0
    TEXT_LABEL_63 timerText = ""
    IF NOT g_auto_save EXIT ENDIF
    IF g_auto_save_interval <= 0 EXIT ENDIF
    IF IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() EXIT ENDIF
    IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN() EXIT ENDIF

    remainingMs = g_next_auto_save_time - GET_GAME_TIMER()
    IF remainingMs < 0 remainingMs = 0 ENDIF
    totalSeconds = remainingMs / 1000
    hours = totalSeconds / 3600
    minutes = (totalSeconds / 60) - (hours * 60)
    seconds = totalSeconds - (hours * 3600) - (minutes * 60)

    // Built with the same TEXT_LABEL_63 plus string-append path the page counter
    // already uses successfully (no float-text, which renders blank on Switch).
    IF hours < 10 timerText += "0" ENDIF
    timerText += hours
    timerText += ":"
    IF minutes < 10 timerText += "0" ENDIF
    timerText += minutes
    timerText += ":"
    IF seconds < 10 timerText += "0" ENDIF
    timerText += seconds

    SET_TEXT_RENDER_ID(1)
    SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(TRUE)
    SET_SCRIPT_GFX_DRAW_ORDER(GFX_ORDER_BEFORE_HUD_PRIORITY_LOW)
    // Full-width wrap window and left-justify: with the text box spanning the
    // whole screen neither line can wrap, so "Auto Saving in:" stays on line 1
    // and "hh:mm:ss" on line 2, both starting at AUTO_SAVE_TIMER_X.
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(255, 255, 255, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY(TR("Auto Saving in:", "Autoguardado en:", "自动保存倒计时：", "Autom. Speichern in:", "オートセーブまで:", "Автосохранение через:", "Salvamento auto. em:", "Sauvegarde auto dans :"))
    END_TEXT_COMMAND_DISPLAY_TEXT(AUTO_SAVE_TIMER_X, AUTO_SAVE_TIMER_Y)
    SET_TEXT_SCALE(0.400, 0.400)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(timerText)
    END_TEXT_COMMAND_DISPLAY_TEXT(AUTO_SAVE_TIMER_X, AUTO_SAVE_TIMER_Y + 0.024)
ENDPROC

FUNC TEXT_LABEL_63 FORMAT_LIVE_COORD_LINE(STRING axisPrefix, FLOAT value)
    FLOAT clamped = value
    IF clamped > 999999.0 clamped = 999999.0 ENDIF
    IF clamped < -999999.0 clamped = -999999.0 ENDIF
    INT totalCenti = ROUND(clamped * 100.0)
    BOOL isNeg = FALSE
    IF totalCenti < 0
        isNeg = TRUE
        totalCenti = 0 - totalCenti
    ENDIF
    INT wholePart = totalCenti / 100
    INT fracPart = totalCenti - (wholePart * 100)
    TEXT_LABEL_63 line = ""
    line += axisPrefix
    IF isNeg
        line += "-"
    ENDIF
    line += wholePart
    line += "."
    IF fracPart < 10
        line += "0"
    ENDIF
    line += fracPart
    RETURN line
ENDFUNC

PROC DRAW_LIVE_COORDINATES()
    IF NOT g_show_live_coords EXIT ENDIF
    IF IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() EXIT ENDIF
    IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN() EXIT ENDIF

    IF GET_GAME_TIMER() >= g_live_coords_next_update
        g_live_coords_pos = g_cached_player_coords
        g_live_coords_next_update = GET_GAME_TIMER() + LIVE_COORDS_UPDATE_MS

        g_live_coords_cached_line_x = FORMAT_LIVE_COORD_LINE("X: ", g_live_coords_pos.x)
        g_live_coords_cached_line_y = FORMAT_LIVE_COORD_LINE("Y: ", g_live_coords_pos.y)
        g_live_coords_cached_line_z = FORMAT_LIVE_COORD_LINE("Z: ", g_live_coords_pos.z)

        INT lenX = GET_LENGTH_OF_LITERAL_STRING(g_live_coords_cached_line_x)
        INT lenY = GET_LENGTH_OF_LITERAL_STRING(g_live_coords_cached_line_y)
        INT lenZ = GET_LENGTH_OF_LITERAL_STRING(g_live_coords_cached_line_z)
        INT maxChars = lenX
        IF lenY > maxChars maxChars = lenY ENDIF
        IF lenZ > maxChars maxChars = lenZ ENDIF

        g_live_coords_cached_coord_x = 0.985 - (TO_FLOAT(maxChars) * 0.0062)
        IF g_live_coords_cached_coord_x < 0.700 g_live_coords_cached_coord_x = 0.700 ENDIF
    ENDIF

    SET_TEXT_RENDER_ID(1)
    SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(TRUE)
    SET_SCRIPT_GFX_DRAW_ORDER(GFX_ORDER_BEFORE_HUD_PRIORITY_LOW)

    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_live_coords_cached_line_x)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_live_coords_cached_coord_x, AUTO_SAVE_TIMER_Y)

    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_live_coords_cached_line_y)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_live_coords_cached_coord_x, AUTO_SAVE_TIMER_Y + 0.020)

    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_live_coords_cached_line_z)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_live_coords_cached_coord_x, AUTO_SAVE_TIMER_Y + 0.040)
ENDPROC

PROC DRAW_SPEEDOMETER()
    IF NOT g_vehicle_speedometer
        EXIT
    ENDIF
    IF NOT g_cached_player_in_veh OR IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() OR IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN()
        EXIT
    ENDIF
    IF NOT DOES_ENTITY_EXIST(g_cached_player_veh) OR IS_ENTITY_DEAD(g_cached_player_veh)
        EXIT
    ENDIF

    SET_TEXT_RENDER_ID(1)
    SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(TRUE)
    SET_SCRIPT_GFX_DRAW_ORDER(GFX_ORDER_BEFORE_HUD_PRIORITY_LOW)

    FLOAT vehicleSpeed = GET_ENTITY_SPEED(g_cached_player_veh)

    IF g_speedometer_cached_veh != g_cached_player_veh
        g_speedometer_cached_veh = g_cached_player_veh
        g_speedometer_cached_name = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(GET_ENTITY_MODEL(g_cached_player_veh))
    ENDIF

    IF NOT IS_STRING_NULL_OR_EMPTY(g_speedometer_cached_name)
        SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
        SET_TEXT_SCALE(0.55, 0.55)
        SET_TEXT_OUTLINE()
        SET_TEXT_WRAP(0.0, 0.905)
        SET_TEXT_RIGHT_JUSTIFY(TRUE)
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(g_speedometer_cached_name)
        END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.686)
        SET_TEXT_RIGHT_JUSTIFY(FALSE)
    ENDIF

    IF g_vehicle_speed_unit = 0
        vehicleSpeed = vehicleSpeed * 2.23694
        SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
        SET_TEXT_SCALE(0.9, 0.9)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("MPH")
        END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.720)
    ELSE
        vehicleSpeed = vehicleSpeed * 3.6
        SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
        SET_TEXT_SCALE(0.9, 0.9)
        SET_TEXT_OUTLINE()
        BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("KMPH")
        END_TEXT_COMMAND_DISPLAY_TEXT(0.905, 0.720)
    ENDIF

    SET_TEXT_FONT(FONT_ROCKSTAR_TAG)
    SET_TEXT_SCALE(0.9, 0.9)
    SET_TEXT_OUTLINE()
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("NUMBER")
        ADD_TEXT_COMPONENT_INTEGER(ROUND(vehicleSpeed))
    END_TEXT_COMMAND_DISPLAY_TEXT(0.908, 0.760)
ENDPROC
