PROC DRAW_TIME_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Time:", "Hora:", "时间:", "Uhrzeit:", "時間:", "Время:", "Hora:", "Heure :")
    SWITCH g_time_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Morning >", "< Mañana >", "< 早晨 >", "< Morgen >", "< 朝 >", "< Утро >", "< Manhã >", "< Matin >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Noon >", "< Mediodía >", "< 正午 >", "< Mittag >", "< 正午 >", "< Полдень >", "< Meio-dia >", "< Midi >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Evening >", "< Tarde >", "< 傍晚 >", "< Abend >", "< 夕方 >", "< Вечер >", "< Noite >", "< Soir >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Midnight >", "< Medianoche >", "< 午夜 >", "< Mitternacht >", "< 真夜中 >", "< Полночь >", "< Meia-noite >", "< Minuit >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WEATHER_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Weather:", "Clima:", "天气:", "Wetter:", "天候:", "Погода:", "Clima:", "Météo :")
    SWITCH g_weather_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Extra Sunny >", "< Muy soleado >", "< 大晴天 >", "< Sehr sonnig >", "< 快晴 >", "< Очень солнечно >", "< Muito ensolarado >", "< Grand soleil >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Clear >", "< Despejado >", "< 晴朗 >", "< Klar >", "< 晴れ >", "< Ясно >", "< Limpo >", "< Dégagé >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Clouds >", "< Nubes >", "< 多云 >", "< Bewölkt >", "< 曇り >", "< Облачно >", "< Nublado >", "< Nuageux >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Overcast >", "< Nublado >", "< 阴天 >", "< Bedeckt >", "< どんより >", "< Пасмурно >", "< Encoberto >", "< Couvert >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Rain >", "< Lluvia >", "< 雨天 >", "< Regen >", "< 雨 >", "< Дождь >", "< Chuva >", "< Pluie >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Thunder >", "< Tormenta >", "< 雷暴 >", "< Gewitter >", "< 雷雨 >", "< Гроза >", "< Tempestade >", "< Orage >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Clearing >", "< Despejando >", "< 雨后初晴 >", "< Aufklarend >", "< 雨上がり >", "< Прояснение >", "< Abrindo >", "< Éclaircies >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, lbl, TR("< Smog >", "< Smog >", "< 雾霾 >", "< Smog >", "< スモッグ >", "< Смог >", "< Poluição >", "< Smog >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, lbl, TR("< Foggy >", "< Niebla >", "< 大雾 >", "< Neblig >", "< 霧 >", "< Туман >", "< Neblina >", "< Brouillard >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, lbl, TR("< XMAS >", "< Navidad >", "< 圣诞雪 >", "< Weihnachten >", "< クリスマス >", "< Рождество >", "< Natal >", "< Noël >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, lbl, TR("< Snow >", "< Nieve >", "< 雪天 >", "< Schnee >", "< 雪 >", "< Снег >", "< Neve >", "< Neige >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, lbl, TR("< Snowlight >", "< Nieve ligera >", "< 小雪 >", "< Leichter Schnee >", "< 小雪 >", "< Легкий снег >", "< Neve fraca >", "< Neige légère >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, lbl, TR("< Blizzard >", "< Ventisca >", "< 暴风雪 >", "< Schneesturm >", "< 吹雪 >", "< Метель >", "< Nevasca >", "< Blizzard >"), selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, lbl, TR("< Halloween >", "< Halloween >", "< 万圣节 >", "< Halloween >", "< ハロウィン >", "< Хэллоуин >", "< Halloween >", "< Halloween >"), selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, lbl, TR("< Neutral >", "< Neutro >", "< 中性 >", "< Neutral >", "< ニュートラル >", "< Нейтрально >", "< Neutro >", "< Neutre >"), selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, lbl, TR("< Rain Halloween >", "< Lluvia de Halloween >", "< 万圣节雨 >", "< Halloween-Regen >", "< ハロウィン雨 >", "< Хэллоуин дождь >", "< Chuva de Halloween >", "< Pluie Halloween >"), selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, lbl, TR("< Snow Halloween >", "< Nieve de Halloween >", "< 万圣节雪 >", "< Halloween-Schnee >", "< ハロウィン雪 >", "< Хэллоуин снег >", "< Neve de Halloween >", "< Neige Halloween >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_IPL_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("IPL Preset:", "Preajuste IPL:", "IPL 预设:", "IPL-Vorlage:", "IPLプリセット:", "Пресет IPL:", "Predefinição IPL:", "Préréglage IPL :")
    SWITCH g_ipl_preset
        CASE 0 DRAW_OPTION(y, lbl, TR("< Trevor's Trailer >", "< Caravana de Trevor >", "< 崔佛的拖车 >", "< Trevors Wohnwagen >", "< トレバーのトレーラー >", "< Трейлер Тревора >", "< Trailer do Trevor >", "< Caravane de Trevor >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< FIB Lobby >", "< Vestíbulo del FIB >", "< FIB 大厅 >", "< FIB-Lobby >", "< FIBロビー >", "< Лобби ФРБ >", "< Lobby do FIB >", "< Hall du FIB >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Fruit BB >", "< Valla de iFruit >", "< iFruit 广告牌 >", "< iFruit-Werbetafel >", "< iFruit看板 >", "< Билборд iFruit >", "< Outdoor iFruit >", "< Panneau iFruit >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Heist Interior >", "< Interior de golpe >", "< 抢劫任务室内 >", "< Raubüberfall-Innenraum >", "< 強盗インテリア >", "< Интерьер ограбления >", "< Interior do Golpe >", "< Intérieur braquage >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Farm Interior >", "< Interior de granja >", "< 农场室内 >", "< Farm-Innenraum >", "< 農場インテリア >", "< Интерьер фермы >", "< Interior da Fazenda >", "< Intérieur ferme >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Face Lobby >", "< Vestíbulo fachada >", "< 外立面大厅 >", "< Fassaden-Lobby >", "< ファサードロビー >", "< Фасадное лобби >", "< Lobby da Fachada >", "< Hall façade >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Coroner >", "< Forense >", "< 法医局 >", "< Gerichtsmedizin >", "< 検死局 >", "< Морг >", "< Necrotério >", "< Morgue >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, lbl, TR("< Josh's House >", "< Casa de Josh >", "< 乔什的家 >", "< Joshs Haus >", "< ジョシュの家 >", "< Дом Джоша >", "< Casa do Josh >", "< Maison de Josh >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, lbl, TR("< Apartment >", "< Apartamento >", "< 公寓 >", "< Apartment >", "< アパート >", "< Квартира >", "< Apartamento >", "< Appartement >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, lbl, TR("< Chop Shop >", "< Taller de desguace >", "< 拆车厂 >", "< Ausschlachtwerkstatt >", "< チョップショップ >", "< Разборка >", "< Desmanche >", "< Atelier clandestin >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, lbl, TR("< Prologue 1 >", "< Prólogo 1 >", "< 序章 1 >", "< Prolog 1 >", "< プロローグ 1 >", "< Пролог 1 >", "< Prólogo 1 >", "< Prologue 1 >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, lbl, TR("< Prologue 2 >", "< Prólogo 2 >", "< 序章 2 >", "< Prolog 2 >", "< プロローグ 2 >", "< Пролог 2 >", "< Prólogo 2 >", "< Prologue 2 >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, lbl, TR("< North Yankton >", "< North Yankton >", "< 北扬克顿 >", "< North Yankton >", "< ノース・ヤンクトン >", "< Северный Янктон >", "< North Yankton >", "< North Yankton >"), selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, lbl, TR("< Cayo Perico >", "< Cayo Perico >", "< 佩里科岛 >", "< Cayo Perico >", "< カヨ・ペリコ >", "< Кайо-Перико >", "< Cayo Perico >", "< Cayo Perico >"), selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, lbl, TR("< Dignity Party Yacht >", "< Yate de fiesta Dignity >", "< 尊严号派对游艇 >", "< Dignity-Partyyacht >", "< ディグニティ・パーティーヨット >", "< Яхта Dignity >", "< Iate Dignity >", "< Yacht Dignity >"), selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, lbl, TR("< Aircraft Carrier >", "< Portaaviones >", "< 航空母舰 >", "< Flugzeugträger >", "< 空母 >", "< Авианосец >", "< Porta-aviões >", "< Porte-avions >"), selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, lbl, TR("< Sunken Cargo Ship >", "< Carguero hundido >", "< 沉没货船 >", "< Gesunkenes Frachtschiff >", "< 沈没した貨物船 >", "< Затонувший сухогруз >", "< Navio Cargueiro Afundado >", "< Cargo coulé >"), selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, lbl, TR("< Pillbox Hospital >", "< Hospital Pillbox >", "< 药盒山医院 >", "< Pillbox-Krankenhaus >", "< ピルボックス病院 >", "< Больница Пиллбокс >", "< Hospital Pillbox >", "< Hôpital Pillbox >"), selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, lbl, TR("< O'Neil Farm Destroyed >", "< Granja O'Neil destruida >", "< 被毁的奥尼尔农场 >", "< O'Neil-Farm zerstört >", "< 破壊されたオニール農場 >", "< Разрушенная ферма О'Нилов >", "< Fazenda O'Neil Destruída >", "< Ferme O'Neil détruite >"), selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, lbl, TR("< LifeInvader Interior >", "< Interior de LifeInvader >", "< LifeInvader 室内 >", "< LifeInvader-Innenraum >", "< ライフインベーダー内部 >", "< Офис LifeInvader >", "< Interior da LifeInvader >", "< Intérieur LifeInvader >"), selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, lbl, TR("< Jewelry Store Interior >", "< Interior de joyería >", "< 珠宝店室内 >", "< Juwelier-Innenraum >", "< 宝石店内部 >", "< Ювелирный магазин >", "< Interior da Joalheria >", "< Intérieur bijouterie >"), selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, lbl, TR("< Coroner Morgue Interior >", "< Interior de la morgue >", "< 法医停尸房室内 >", "< Leichenschauhaus-Innenraum >", "< 検死局霊安室内部 >", "< Внутри морга >", "< Interior do Necrotério >", "< Intérieur morgue >"), selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, lbl, TR("< Cayo Perico Damaged >", "< Cayo Perico dañado >", "< 受损的佩里科岛 >", "< Cayo Perico beschädigt >", "< カヨ・ペリコ (損傷) >", "< Поврежденный Кайо-Перико >", "< Cayo Perico Danificado >", "< Cayo Perico endommagé >"), selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, lbl, TR("< Casino Door >", "< Puerta del casino >", "< 赌场大门 >", "< Casino-Tür >", "< カジノのドア >", "< Дверь казино >", "< Porta do Cassino >", "< Porte du casino >"), selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, lbl, TR("< Gunrunning Bunker >", "< Búnker de tráfico de armas >", "< 军火贸易地堡 >", "< Gunrunning-Bunker >", "< 銃器密造バンカー >", "< Бункер торговли оружием >", "< Bunker de Tráfico de Armas >", "< Bunker Trafic d'armes >"), selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, lbl, TR("< Mission Row Police Heist Interior >", "< Interior policial atraco Mission Row >", "< 密逊街抢劫警察局室内 >", "< Mission Row Raubüberfall-Polizeirevier >", "< ミッションロウ強盗警察署内部 >", "< Полицейский участок ограбления Мишн-Роу >", "< Interior Delegacia Golpe Mission Row >", "< Intérieur commissariat braquage Mission Row >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIME_SCALE_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Time Scale:", "Escala de tiempo:", "时间流速:", "Zeitskala:", "タイムスケール:", "Масштаб времени:", "Escala de Tempo:", "Échelle du temps :")
    IF g_time_scale_level = 0 DRAW_OPTION(y, lbl, "< 0x >", selected, 0) ENDIF
    IF g_time_scale_level = 1 DRAW_OPTION(y, lbl, "< 0.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 2 DRAW_OPTION(y, lbl, "< 0.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 3 DRAW_OPTION(y, lbl, "< 0.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 4 DRAW_OPTION(y, lbl, "< 1x >", selected, 3) ENDIF
    IF g_time_scale_level = 5 DRAW_OPTION(y, lbl, "< 1.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 6 DRAW_OPTION(y, lbl, "< 1.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 7 DRAW_OPTION(y, lbl, "< 1.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 8 DRAW_OPTION(y, lbl, "< 2x >", selected, 3) ENDIF
    IF g_time_scale_level = 9 DRAW_OPTION(y, lbl, "< 2.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 10 DRAW_OPTION(y, lbl, "< 2.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 11 DRAW_OPTION(y, lbl, "< 2.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 12 DRAW_OPTION(y, lbl, "< 3x >", selected, 3) ENDIF
    IF g_time_scale_level = 13 DRAW_OPTION(y, lbl, "< 3.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 14 DRAW_OPTION(y, lbl, "< 3.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 15 DRAW_OPTION(y, lbl, "< 3.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 16 DRAW_OPTION(y, lbl, "< 4x >", selected, 3) ENDIF
    IF g_time_scale_level = 17 DRAW_OPTION(y, lbl, "< 4.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 18 DRAW_OPTION(y, lbl, "< 4.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 19 DRAW_OPTION(y, lbl, "< 4.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 20 DRAW_OPTION(y, lbl, "< 5x >", selected, 3) ENDIF
    IF g_time_scale_level = 21 DRAW_OPTION(y, lbl, "< 5.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 22 DRAW_OPTION(y, lbl, "< 5.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 23 DRAW_OPTION(y, lbl, "< 5.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 24 DRAW_OPTION(y, lbl, "< 6x >", selected, 3) ENDIF
    IF g_time_scale_level = 25 DRAW_OPTION(y, lbl, "< 6.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 26 DRAW_OPTION(y, lbl, "< 6.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 27 DRAW_OPTION(y, lbl, "< 6.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 28 DRAW_OPTION(y, lbl, "< 7x >", selected, 3) ENDIF
    IF g_time_scale_level = 29 DRAW_OPTION(y, lbl, "< 7.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 30 DRAW_OPTION(y, lbl, "< 7.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 31 DRAW_OPTION(y, lbl, "< 7.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 32 DRAW_OPTION(y, lbl, "< 8x >", selected, 3) ENDIF
    IF g_time_scale_level = 33 DRAW_OPTION(y, lbl, "< 8.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 34 DRAW_OPTION(y, lbl, "< 8.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 35 DRAW_OPTION(y, lbl, "< 8.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 36 DRAW_OPTION(y, lbl, "< 9x >", selected, 3) ENDIF
    IF g_time_scale_level = 37 DRAW_OPTION(y, lbl, "< 9.25x >", selected, 3) ENDIF
    IF g_time_scale_level = 38 DRAW_OPTION(y, lbl, "< 9.5x >", selected, 3) ENDIF
    IF g_time_scale_level = 39 DRAW_OPTION(y, lbl, "< 9.75x >", selected, 3) ENDIF
    IF g_time_scale_level = 40 DRAW_OPTION(y, lbl, "< 10x >", selected, 3) ENDIF
ENDPROC

PROC DRAW_GRAVITY_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Gravity:", "Gravedad:", "重力:", "Schwerkraft:", "重力:", "Гравитация:", "Gravidade:", "Gravité :")
    IF g_gravity_choice = 0 DRAW_OPTION(y, lbl, TR("< Earth >", "< Tierra >", "< 地球 >", "< Erde >", "< 地球 >", "< Земля >", "< Terra >", "< Terre >"), selected, 3) ENDIF
    IF g_gravity_choice = 1 DRAW_OPTION(y, lbl, TR("< Moon >", "< Luna >", "< 月球 >", "< Mond >", "< 月 >", "< Луна >", "< Lua >", "< Lune >"), selected, 3) ENDIF
    IF g_gravity_choice = 2 DRAW_OPTION(y, lbl, TR("< Low >", "< Baja >", "< 低重力 >", "< Niedrig >", "< 低重力 >", "< Низкая >", "< Baixa >", "< Faible >"), selected, 3) ENDIF
    IF g_gravity_choice = 3 DRAW_OPTION(y, lbl, TR("< Zero G >", "< Gravedad cero >", "< 零重力 >", "< Schwerelos >", "< 無重力 >", "< Невесомость >", "< Gravidade Zero >", "< Zéro G >"), selected, 3) ENDIF
ENDPROC

PROC DRAW_WORLD_ROW(INT index, FLOAT y)
    STRING openDoorLbl = TR("Open Closest Door", "Abrir puerta más cercana", "打开最近的门", "Nächste Tür öffnen", "最も近いドアを開ける", "Открыть ближайшую дверь", "Abrir Porta Mais Próxima", "Ouvrir porte la plus proche")
    STRING closeDoorLbl = TR("Close Closest Door", "Cerrar puerta más cercana", "关闭最近的门", "Nächste Tür schließen", "最も近いドアを閉める", "Закрыть ближайшую дверь", "Fechar Porta Mais Próxima", "Fermer porte la plus proche")
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Time & Weather", "Hora y clima", "时间与天气", "Zeit & Wetter", "時間と天候", "Время и погода", "Hora e Clima", "Heure et météo"), "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_night_vision DRAW_OPTION(y, TR("Night Vision", "Visión nocturna", "夜视仪", "Nachtsicht", "ナイトビジョン", "Ночное видение", "Visão Noturna", "Vision nocturne"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Night Vision", "Visión nocturna", "夜视仪", "Nachtsicht", "ナイトビジョン", "Ночное видение", "Visão Noturna", "Vision nocturne"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 IF g_thermal_vision DRAW_OPTION(y, TR("Thermal Vision", "Visión térmica", "热成像", "Wärmebild", "サーマルビジョン", "Тепловизор", "Visão Térmica", "Vision thermique"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Thermal Vision", "Visión térmica", "热成像", "Wärmebild", "サーマルビジョン", "Тепловизор", "Visão Térmica", "Vision thermique"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 DRAW_IPL_SELECTOR(y, g_item = index) BREAK
        CASE 4 DRAW_TIME_SCALE_SELECTOR(y, g_item = index) BREAK
        CASE 5 DRAW_GRAVITY_SELECTOR(y, g_item = index) BREAK
        CASE 6 DRAW_OPTION(y, TR("Load IPL Preset", "Cargar preajuste IPL", "加载 IPL 预设", "IPL-Vorlage laden", "IPLプリセット読込", "Загрузить пресет IPL", "Carregar Predefinição IPL", "Charger préréglage IPL"), "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Unload IPL Preset", "Descargar preajuste IPL", "卸载 IPL 预设", "IPL-Vorlage entladen", "IPLプリセット解除", "Выгрузить пресет IPL", "Descarregar Predefinição IPL", "Décharger préréglage IPL"), "APPLY", g_item = index, 2) BREAK
        CASE 8
            IF IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name) DRAW_OPTION(y, TR("Custom IPL Name", "Nombre de IPL personalizado", "自定义 IPL 名称", "Eigener IPL-Name", "カスタムIPL名", "Имя своего IPL", "Nome de IPL Personalizado", "Nom d'IPL personnalisé"), TR("TYPE NAME", "ESCRIBIR NOMBRE", "输入名称", "NAME EINGEBEN", "名前を入力", "ВВЕДИТЕ ИМЯ", "DIGITAR NOME", "ENTRER NOM"), g_item = index, 3)
            ELSE DRAW_OPTION(y, TR("Custom IPL Name", "Nombre de IPL personalizado", "自定义 IPL 名称", "Eigener IPL-Name", "カスタムIPL名", "Имя своего IPL", "Nome de IPL Personalizado", "Nom d'IPL personnalisé"), g_custom_ipl_name, g_item = index, 3) ENDIF
        BREAK
        CASE 9 DRAW_OPTION(y, TR("Load Custom IPL", "Cargar IPL personalizado", "加载自定义 IPL", "Eigenes IPL laden", "カスタムIPL読込", "Загрузить свой IPL", "Carregar IPL Personalizado", "Charger IPL personnalisé"), "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, TR("Unload Custom IPL", "Descargar IPL personalizado", "卸载自定义 IPL", "Eigenes IPL entladen", "カスタムIPL解除", "Выгрузить свой IPL", "Descarregar IPL Personalizado", "Décharger IPL personnalisé"), "APPLY", g_item = index, 2) BREAK
        CASE 11 IF g_motion_blur DRAW_OPTION(y, TR("CCTV Filter", "Filtro CCTV", "监控滤镜", "CCTV-Filter", "監視カメラフィルター", "Фильтр камеры", "Filtro CCTV", "Filtre vidéosurveillance"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("CCTV Filter", "Filtro CCTV", "监控滤镜", "CCTV-Filter", "監視カメラフィルター", "Фильтр камеры", "Filtro CCTV", "Filtre vidéosurveillance"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_camera_shake DRAW_OPTION(y, TR("Camera Shake", "Temblor de cámara", "镜头晃动", "Kamerawackeln", "カメラ揺れ", "Тряска камеры", "Tremor de Câmera", "Tremblement caméra"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Camera Shake", "Temblor de cámara", "镜头晃动", "Kamerawackeln", "カメラ揺れ", "Тряска камеры", "Tremor de Câmera", "Tremblement caméra"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 IF g_touch_opens_doors DRAW_OPTION(y, TR("Touch Opens Doors", "Abrir puertas al tocar", "触碰开门", "Türen durch Berühren öffnen", "接触でドア開錠", "Открытие дверей касанием", "Abrir Portas ao Tocar", "Ouvrir portes au toucher"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Touch Opens Doors", "Abrir puertas al tocar", "触碰开门", "Türen durch Berühren öffnen", "接触でドア開錠", "Открытие дверей касанием", "Abrir Portas ao Tocar", "Ouvrir portes au toucher"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14
            // Three states for one row: the staged scan is running, it produced a
            // result that is still inside its display window, or the row is idle.
            // The colours come from DRAW_OPTION's own states: 1 = green, 0 = red.
            IF g_door_scan_active AND g_door_scan_mode = 0
                DRAW_OPTION(y, openDoorLbl, TR("Searching...", "Buscando...", "搜索中...", "Suche...", "検索中...", "Поиск...", "Procurando...", "Recherche..."), g_item = index, 2)
            ELIF g_door_scan_mode = 0 AND g_door_feedback_until > GET_GAME_TIMER()
                IF g_door_feedback = 2 DRAW_OPTION(y, openDoorLbl, TR("Opened!", "¡Abierta!", "已打开！", "Geöffnet!", "開きました！", "Открыто!", "Aberta!", "Ouverte !"), g_item = index, 1)
                ELIF g_door_feedback = 3 DRAW_OPTION(y, openDoorLbl, TR("Won't Open", "No se abre", "无法打开", "Geht nicht auf", "開きません", "Не открывается", "Não Abre", "Ne s'ouvre pas"), g_item = index, 0)
                ELSE DRAW_OPTION(y, openDoorLbl, TR("No Doors", "Sin puertas", "附近无门", "Keine Türen", "ドアなし", "Нет дверей", "Sem Portas", "Aucune porte"), g_item = index, 0) ENDIF
            ELSE
                DRAW_OPTION(y, openDoorLbl, "APPLY", g_item = index, 2)
            ENDIF
        BREAK
        CASE 15
            IF g_door_scan_active AND g_door_scan_mode = 1
                DRAW_OPTION(y, closeDoorLbl, TR("Searching...", "Buscando...", "搜索中...", "Suche...", "検索中...", "Поиск...", "Procurando...", "Recherche..."), g_item = index, 2)
            ELIF g_door_scan_mode = 1 AND g_door_feedback_until > GET_GAME_TIMER()
                IF g_door_feedback = 2 DRAW_OPTION(y, closeDoorLbl, TR("Closed!", "¡Cerrada!", "已关闭！", "Geschlossen!", "閉まりました！", "Закрыто!", "Fechada!", "Fermée !"), g_item = index, 1)
                ELIF g_door_feedback = 3 DRAW_OPTION(y, closeDoorLbl, TR("Won't Close", "No se cierra", "无法关闭", "Geht nicht zu", "閉まりません", "Не закрывается", "Não Fecha", "Ne se ferme pas"), g_item = index, 0)
                ELSE DRAW_OPTION(y, closeDoorLbl, TR("No Doors", "Sin puertas", "附近无门", "Keine Türen", "ドアなし", "Нет дверей", "Sem Portas", "Aucune porte"), g_item = index, 0) ENDIF
            ELSE
                DRAW_OPTION(y, closeDoorLbl, "APPLY", g_item = index, 2)
            ENDIF
        BREAK
        CASE 16 DRAW_WORLD_MAYHEM_ENTRY(y, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIMEWEATHER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_TIME_SELECTOR(y, g_item = index) BREAK
        CASE 1 DRAW_NUMBER_OPTION(y, TR("Hour", "Hora", "小时", "Stunde", "時", "Час", "Hora", "Heure"), g_time_hour, g_item = index) BREAK
        CASE 2 DRAW_NUMBER_OPTION(y, TR("Minute", "Minuto", "分钟", "Minute", "分", "Минута", "Minuto", "Minute"), g_time_minute, g_item = index) BREAK
        CASE 3 DRAW_NUMBER_OPTION(y, TR("Second", "Segundo", "秒", "Sekunde", "秒", "Секунда", "Segundo", "Seconde"), g_time_second, g_item = index) BREAK
        CASE 4 IF g_pause_time DRAW_OPTION(y, TR("Freeze / Pause Time", "Congelar / Pausar tiempo", "冻结 / 暂停时间", "Zeit einfrieren / pausieren", "時間停止 / 一時停止", "Заморозить / Пауза времени", "Congelar / Pausar Tempo", "Figer / Pause temps"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Freeze / Pause Time", "Congelar / Pausar tiempo", "冻结 / 暂停时间", "Zeit einfrieren / pausieren", "時間停止 / 一時停止", "Заморозить / Пауза времени", "Congelar / Pausar Tempo", "Figer / Pause temps"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_WEATHER_SELECTOR(y, g_item = index) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TIMEWEATHER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("TIME & WEATHER", "HORA Y CLIMA", "时间与天气", "ZEIT & WETTER", "時間と天候", "ВРЕМЯ И ПОГОДА", "HORA E CLIMA", "HEURE ET MÉTÉO"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_timeweather_scroll
    INT row = 0
    WHILE row < 8 AND index < 6
        DRAW_TIMEWEATHER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_WANTED_LEVEL_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Wanted Level", "Nivel de búsqueda", "通缉等级", "Fahndungslevel", "手配度", "Уровень розыска", "Nível de Procurado", "Niveau de recherche")
    IF g_wanted_level_choice = 1 DRAW_OPTION(y, lbl, TR("< 1 Star >", "< 1 Estrella >", "< 1 星 >", "< 1 Stern >", "< 星1 >", "< 1 звезда >", "< 1 Estrela >", "< 1 étoile >"), selected, 3) ENDIF
    IF g_wanted_level_choice = 2 DRAW_OPTION(y, lbl, TR("< 2 Stars >", "< 2 Estrellas >", "< 2 星 >", "< 2 Sterne >", "< 星2 >", "< 2 звезды >", "< 2 Estrelas >", "< 2 étoiles >"), selected, 3) ENDIF
    IF g_wanted_level_choice = 3 DRAW_OPTION(y, lbl, TR("< 3 Stars >", "< 3 Estrellas >", "< 3 星 >", "< 3 Sterne >", "< 星3 >", "< 3 звезды >", "< 3 Estrelas >", "< 3 étoiles >"), selected, 3) ENDIF
    IF g_wanted_level_choice = 4 DRAW_OPTION(y, lbl, TR("< 4 Stars >", "< 4 Estrellas >", "< 4 星 >", "< 4 Sterne >", "< 星4 >", "< 4 звезды >", "< 4 Estrelas >", "< 4 étoiles >"), selected, 3) ENDIF
    IF g_wanted_level_choice = 5 DRAW_OPTION(y, lbl, TR("< 5 Stars >", "< 5 Estrellas >", "< 5 星 >", "< 5 Sterne >", "< 星5 >", "< 5 звезд >", "< 5 Estrelas >", "< 5 étoiles >"), selected, 3) ENDIF
ENDPROC

PROC DRAW_ACCENT_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Accent Colour:", "Color de acento:", "主题颜色:", "Akzentfarbe:", "アクセントカラー:", "Цвет акцента:", "Cor de Destaque:", "Couleur d'accent :")
    SWITCH g_accent_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Blue >", "< Azul >", "< 蓝色 >", "< Blau >", "< ブルー >", "< Синий >", "< Azul >", "< Bleu >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Crimson >", "< Carmesí >", "< 深红 >", "< Karmesinrot >", "< クリムゾン >", "< Малиновый >", "< Carmesim >", "< Cramoisi >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Gold >", "< Dorado >", "< 金色 >", "< Gold >", "< ゴールド >", "< Золотой >", "< Dourado >", "< Or >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Purple >", "< Morado >", "< 紫色 >", "< Lila >", "< パープル >", "< Фиолетовый >", "< Roxo >", "< Violet >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Emerald >", "< Esmeralda >", "< 翡翠绿 >", "< Smaragd >", "< エメラルド >", "< Изумрудный >", "< Esmeralda >", "< Émeraude >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Cyan >", "< Cian >", "< 青色 >", "< Cyan >", "< シアン >", "< Голубой >", "< Ciano >", "< Cyan >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Orange >", "< Naranja >", "< 橙色 >", "< Orange >", "< オレンジ >", "< Оранжевый >", "< Laranja >", "< Orange >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, lbl, TR("< Pink >", "< Rosa >", "< 粉色 >", "< Rosa >", "< ピンク >", "< Розовый >", "< Rosa >", "< Rose >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, lbl, TR("< Slate >", "< Pizarra >", "< 板岩灰 >", "< Schiefer >", "< スレート >", "< Грифельный >", "< Ardósia >", "< Ardoise >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, lbl, TR("< Lime >", "< Lima >", "< 青柠 >", "< Limette >", "< ライム >", "< Лаймовый >", "< Lima >", "< Citron vert >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, lbl, TR("< White >", "< Blanco >", "< 白色 >", "< Weiß >", "< ホワイト >", "< Белый >", "< Branco >", "< Blanc >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, lbl, TR("< Burnt Orange >", "< Naranja quemado >", "< 焦橙色 >", "< Gebranntes Orange >", "< バーントオレンジ >", "< Жженый оранжевый >", "< Laranja Queimado >", "< Orange brûlé >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, lbl, TR("< Charcoal >", "< Carbón >", "< 炭黑 >", "< Anthrazit >", "< チャコール >", "< Угольный >", "< Carvão >", "< Anthracite >"), selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, lbl, TR("< Sky Blue >", "< Azul cielo >", "< 天蓝 >", "< Himmelblau >", "< スカイブルー >", "< Небесно-голубой >", "< Azul-celeste >", "< Bleu ciel >"), selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, lbl, "< RGB >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_MENU_X_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, TR("Menu Adjustment:", "Ajuste del menú:", "菜单位置调整:", "Menüanpassung:", "メニュー位置調整:", "Позиция меню:", "Ajuste do Menu:", "Position du menu :"), "< X >", selected, 3)
ENDPROC

PROC DRAW_MENU_Y_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, TR("Menu Adjustment:", "Ajuste del menú:", "菜单位置调整:", "Menüanpassung:", "メニュー位置調整:", "Позиция меню:", "Ajuste do Menu:", "Position du menu :"), "< Y >", selected, 3)
ENDPROC

PROC DRAW_RESPAWN_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Respawn Location:", "Lugar de reaparición:", "重生位置:", "Respawn-Ort:", "リスポーン地点:", "Точка возрождения:", "Local de Renascimento:", "Lieu de réapparition :")
    SWITCH g_respawn_location_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Last death >", "< Última muerte >", "< 上次死亡地点 >", "< Letzter Tod >", "< 最後の死亡地点 >", "< Место гибели >", "< Última morte >", "< Dernière mort >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Franklin's House >", "< Casa de Franklin >", "< 富兰克林的家 >", "< Franklins Haus >", "< フランクリンの家 >", "< Дом Франклина >", "< Casa do Franklin >", "< Maison de Franklin >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Michael's House >", "< Casa de Michael >", "< 麦克的家 >", "< Michaels Haus >", "< マイケルの家 >", "< Дом Майкла >", "< Casa do Michael >", "< Maison de Michael >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Trevor's Trailer >", "< Caravana de Trevor >", "< 崔佛的拖车 >", "< Trevors Wohnwagen >", "< トレバーのトレーラー >", "< Трейлер Тревора >", "< Trailer do Trevor >", "< Caravane de Trevor >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Hospital >", "< Hospital >", "< 医院 >", "< Krankenhaus >", "< 病院 >", "< Больница >", "< Hospital >", "< Hôpital >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Simeon's Dealership >", "< Concesionario de Simeon >", "< 西米恩车行 >", "< Simeons Autohaus >", "< シミオンのディーラー >", "< Автосалон Симона >", "< Concessionária do Simeon >", "< Concession de Simeon >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Ammu-Nation >", "< Ammu-Nation >", "< 武装国度 >", "< Ammu-Nation >", "< アミュネーション >", "< Амму-Нация >", "< Ammu-Nation >", "< Ammu-Nation >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, lbl, TR("< Police station >", "< Comisaría >", "< 警察局 >", "< Polizeistation >", "< 警察署 >", "< Полицейский участок >", "< Delegacia >", "< Commissariat >"), selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, lbl, TR("< Los Santos Customs >", "< Los Santos Customs >", "< 洛圣都改车王 >", "< Los Santos Customs >", "< ロスサントス・カスタム >", "< Los Santos Customs >", "< Los Santos Customs >", "< Los Santos Customs >"), selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, lbl, TR("< LS Airport >", "< Aeropuerto de LS >", "< 洛圣都机场 >", "< LS-Flughafen >", "< ロスサントス空港 >", "< Аэропорт ЛС >", "< Aeroporto de LS >", "< Aéroport de LS >"), selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, lbl, TR("< Maze Bank Tower >", "< Torre Maze Bank >", "< 花园银行大厦 >", "< Maze Bank Tower >", "< メイズバンク・タワー >", "< Башня Maze Bank >", "< Maze Bank Tower >", "< Tour Maze Bank >"), selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, lbl, TR("< Grove Street >", "< Grove Street >", "< 格罗夫街 >", "< Grove Street >", "< グローブ・ストリート >", "< Грув-стрит >", "< Grove Street >", "< Grove Street >"), selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, lbl, TR("< North Yankton >", "< North Yankton >", "< 北扬克顿 >", "< North Yankton >", "< ノース・ヤンクトン >", "< Северный Янктон >", "< North Yankton >", "< North Yankton >"), selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, lbl, TR("< Cayo Perico >", "< Cayo Perico >", "< 佩里科岛 >", "< Cayo Perico >", "< カヨ・ペリコ >", "< Кайо-Перико >", "< Cayo Perico >", "< Cayo Perico >"), selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, lbl, TR("< Fort Zancudo >", "< Fort Zancudo >", "< 桑库多堡垒 >", "< Fort Zancudo >", "< フォート・ザンクード >", "< Форт-Занкудо >", "< Fort Zancudo >", "< Fort Zancudo >"), selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, lbl, TR("< Vinewood Sign >", "< Letrero de Vinewood >", "< 好麦坞招牌 >", "< Vinewood-Schild >", "< バインウッドの看板 >", "< Знак Вайнвуд >", "< Letreiro de Vinewood >", "< Panneau Vinewood >"), selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, lbl, TR("< Mount Chiliad >", "< Monte Chiliad >", "< 奇利亚德山 >", "< Mount Chiliad >", "< チリアド山 >", "< Гора Чилиад >", "< Monte Chiliad >", "< Mont Chiliad >"), selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, lbl, TR("< Sandy Shores Airfield >", "< Aeródromo de Sandy Shores >", "< 沙滩海岸机场 >", "< Flugplatz Sandy Shores >", "< サンディ海岸飛行場 >", "< Аэродром Сэнди-Шорс >", "< Aeródromo de Sandy Shores >", "< Aérodrome de Sandy Shores >"), selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, lbl, TR("< IAA Building >", "< Edificio de la IAA >", "< IAA 大楼 >", "< IAA-Gebäude >", "< IAAビル >", "< Здание ЦУР >", "< Edifício da IAA >", "< Bâtiment de l'IAA >"), selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, lbl, TR("< Mount Gordo >", "< Monte Gordo >", "< 戈多山 >", "< Mount Gordo >", "< ゴルド山 >", "< Гора Гордо >", "< Monte Gordo >", "< Mont Gordo >"), selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, lbl, TR("< Del Perro Pier >", "< Muelle de Del Perro >", "< 德尔佩罗码头 >", "< Del Perro Pier >", "< デル・ペロ・ピア >", "< Пирс Дель-Перро >", "< Píer Del Perro >", "< Jetée de Del Perro >"), selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, lbl, TR("< Paleto Bay >", "< Paleto Bay >", "< 佩立托湾 >", "< Paleto Bay >", "< パレト・ベイ >", "< Палето-Бэй >", "< Paleto Bay >", "< Paleto Bay >"), selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, lbl, TR("< Humane Labs >", "< Laboratorios Humane >", "< 人道实验室 >", "< Humane Labs >", "< ヒューメイン研究所 >", "< Лаборатория Humane >", "< Laboratórios Humane >", "< Laboratoires Humane >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_CATEGORY_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Vehicle Type:", "Tipo de vehículo:", "载具类型:", "Fahrzeugtyp:", "車両タイプ:", "Тип транспорта:", "Tipo de Veículo:", "Type de véhicule :")
    IF g_vehicle_spawn_category = 0 DRAW_OPTION(y, lbl, TR("< Cars >", "< Coches >", "< 汽车 >", "< Autos >", "< 車 >", "< Машины >", "< Carros >", "< Voitures >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 1 DRAW_OPTION(y, lbl, TR("< Bikes >", "< Motos >", "< 摩托/自行车 >", "< Motorräder >", "< バイク >", "< Мотоциклы >", "< Motos >", "< Motos >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 2 DRAW_OPTION(y, lbl, TR("< Aircraft >", "< Aeronaves >", "< 飞机 >", "< Luftfahrzeuge >", "< 航空機 >", "< Авиация >", "< Aeronaves >", "< Aéronefs >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 3 DRAW_OPTION(y, lbl, TR("< DLC Cars >", "< Coches DLC >", "< DLC 汽车 >", "< DLC-Autos >", "< DLC車 >", "< DLC Машины >", "< Carros DLC >", "< Voitures DLC >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 4 DRAW_OPTION(y, lbl, TR("< DLC Bikes >", "< Motos DLC >", "< DLC 摩托 >", "< DLC-Motorräder >", "< DLCバイク >", "< DLC Мотоциклы >", "< Motos DLC >", "< Motos DLC >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 5 DRAW_OPTION(y, lbl, TR("< DLC Aircrafts >", "< Aeronaves DLC >", "< DLC 飞机 >", "< DLC-Luftfahrzeuge >", "< DLC航空機 >", "< DLC Авиация >", "< Aeronaves DLC >", "< Aéronefs DLC >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 6 DRAW_OPTION(y, lbl, TR("< DLC Watercraft >", "< Embarcaciones DLC >", "< DLC 船只 >", "< DLC-Boote >", "< DLC水上艇 >", "< DLC Водный >", "< Embarcações DLC >", "< Bateaux DLC >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 7 DRAW_OPTION(y, lbl, TR("< Boats >", "< Barcos >", "< 船只 >", "< Boote >", "< ボート >", "< Лодки >", "< Barcos >", "< Bateaux >"), selected, 3) ENDIF
    IF g_vehicle_spawn_category = 8 DRAW_OPTION(y, lbl, TR("< Miscellaneous >", "< Varios >", "< 其他 >", "< Sonstiges >", "< その他 >", "< Разное >", "< Diversos >", "< Divers >"), selected, 3) ENDIF
ENDPROC

PROC DRAW_VEHICLE_SPAWN_SELECTOR(FLOAT y, BOOL selected)
    STRING vehLbl = TR("Vehicle:", "Vehículo:", "载具:", "Fahrzeug:", "車両:", "Транспорт:", "Veículo:", "Véhicule :")
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() > 0 AND g_dlc_vehicle_index >= 0 AND DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index)
            MODEL_NAMES dlcModel = GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
            STRING dlcName = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(dlcModel)
            // SanScript has no snprintf / C-string formatting and no int-to-string
            // native, so a "< %s >" wrapper cannot be assembled at runtime here.
            // The native display name is drawn verbatim, exactly like every other
            // dynamic row in this menu (ped search, speedometer vehicle name).
            DRAW_OPTION(y, TR("DLC Vehicle:", "Vehículo DLC:", "DLC 载具:", "DLC-Fahrzeug:", "DLC車両:", "DLC транспорт:", "Veículo DLC:", "Véhicule DLC :"), dlcName, selected, 3)
        ELSE
            DRAW_OPTION(y, TR("DLC Vehicle:", "Vehículo DLC:", "DLC 载具:", "DLC-Fahrzeug:", "DLC車両:", "DLC транспорт:", "Veículo DLC:", "Véhicule DLC :"), TR("NO MATCHING VEHICLES", "SIN VEHÍCULOS", "无匹配载具", "KEINE FAHRZEUGE", "該当車両なし", "НЕТ ТРАНСПОРТА", "SEM VEÍCULOS", "AUCUN VÉHICULE"), selected, 0)
        ENDIF
        EXIT
    ENDIF
    SWITCH g_vehicle_spawn_choice
        CASE 0 DRAW_OPTION(y, vehLbl, "< Adder >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, vehLbl, "< Buffalo >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, vehLbl, "< Cheetah >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, vehLbl, "< Comet >", selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, vehLbl, "< Entity XF >", selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, vehLbl, "< Infernus >", selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, vehLbl, "< Sultan >", selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, vehLbl, "< Rapid GT >", selected, 3) BREAK
        CASE 8 DRAW_OPTION(y, vehLbl, "< Carbonizzare >", selected, 3) BREAK
        CASE 9 DRAW_OPTION(y, vehLbl, "< Feltzer >", selected, 3) BREAK
        CASE 10 DRAW_OPTION(y, vehLbl, "< 9F >", selected, 3) BREAK
        CASE 11 DRAW_OPTION(y, vehLbl, "< Dominator >", selected, 3) BREAK
        CASE 12 DRAW_OPTION(y, vehLbl, "< Gauntlet >", selected, 3) BREAK
        CASE 13 DRAW_OPTION(y, vehLbl, "< Elegy >", selected, 3) BREAK
        CASE 14 DRAW_OPTION(y, vehLbl, "< Baller >", selected, 3) BREAK
        CASE 15 DRAW_OPTION(y, vehLbl, "< Granger >", selected, 3) BREAK
        CASE 16 DRAW_OPTION(y, vehLbl, "< Sandking >", selected, 3) BREAK
        CASE 17 DRAW_OPTION(y, vehLbl, "< Mesa >", selected, 3) BREAK
        CASE 18 DRAW_OPTION(y, vehLbl, "< Transport Bus >", selected, 3) BREAK
        CASE 19 DRAW_OPTION(y, vehLbl, "< Bati 801 >", selected, 3) BREAK
        CASE 20 DRAW_OPTION(y, vehLbl, "< PCJ-600 >", selected, 3) BREAK
        CASE 21 DRAW_OPTION(y, vehLbl, "< Akuma >", selected, 3) BREAK
        CASE 22 DRAW_OPTION(y, vehLbl, "< Sanchez >", selected, 3) BREAK
        CASE 23 DRAW_OPTION(y, vehLbl, "< Faggio >", selected, 3) BREAK
        CASE 24 DRAW_OPTION(y, vehLbl, "< Buzzard >", selected, 3) BREAK
        CASE 25 DRAW_OPTION(y, vehLbl, "< Duster >", selected, 3) BREAK
        CASE 26 DRAW_OPTION(y, vehLbl, "< Cargobob >", selected, 3) BREAK
        CASE 27 DRAW_OPTION(y, vehLbl, "< P-996 Lazer >", selected, 3) BREAK
        CASE 28 DRAW_OPTION(y, vehLbl, "< Blazer Custom >", selected, 3) BREAK
        CASE 29 DRAW_OPTION(y, vehLbl, "< Chimera >", selected, 3) BREAK
        CASE 30 DRAW_OPTION(y, vehLbl, "< Daemon Custom >", selected, 3) BREAK
        CASE 31 DRAW_OPTION(y, vehLbl, "< Defiler >", selected, 3) BREAK
        CASE 32 DRAW_OPTION(y, vehLbl, "< Esskey >", selected, 3) BREAK
        CASE 33 DRAW_OPTION(y, vehLbl, "< Faggio 3 >", selected, 3) BREAK
        CASE 34 DRAW_OPTION(y, vehLbl, "< Hakuchou Drag >", selected, 3) BREAK
        CASE 35 DRAW_OPTION(y, vehLbl, "< Manchez >", selected, 3) BREAK
        CASE 36 DRAW_OPTION(y, vehLbl, "< Nightblade >", selected, 3) BREAK
        CASE 37 DRAW_OPTION(y, vehLbl, "< Raptor >", selected, 3) BREAK
        CASE 38 DRAW_OPTION(y, vehLbl, "< Rat Bike >", selected, 3) BREAK
        CASE 39 DRAW_OPTION(y, vehLbl, "< Sanctus >", selected, 3) BREAK
        CASE 40 DRAW_OPTION(y, vehLbl, "< Shotaro >", selected, 3) BREAK
        CASE 41 DRAW_OPTION(y, vehLbl, "< Tornado Custom >", selected, 3) BREAK
        CASE 42 DRAW_OPTION(y, vehLbl, "< Vortex >", selected, 3) BREAK
        CASE 43 DRAW_OPTION(y, vehLbl, "< Wolfsbane >", selected, 3) BREAK
        CASE 44 DRAW_OPTION(y, vehLbl, "< Youga Classic >", selected, 3) BREAK
        CASE 45 DRAW_OPTION(y, vehLbl, "< Zombie A >", selected, 3) BREAK
        CASE 46 DRAW_OPTION(y, vehLbl, "< Zombie B >", selected, 3) BREAK
        CASE 47 DRAW_OPTION(y, vehLbl, "< Jester Racecar >", selected, 3) BREAK
        CASE 48 DRAW_OPTION(y, vehLbl, "< Massacro Racecar >", selected, 3) BREAK
        CASE 49 DRAW_OPTION(y, vehLbl, "< Rat Loader Custom >", selected, 3) BREAK
        CASE 50 DRAW_OPTION(y, vehLbl, "< Slamvan Custom >", selected, 3) BREAK
        CASE 51 DRAW_OPTION(y, vehLbl, "< Barracks Custom >", selected, 3) BREAK
        CASE 52 DRAW_OPTION(y, vehLbl, "< Boxville Armoured >", selected, 3) BREAK
        CASE 53 DRAW_OPTION(y, vehLbl, "< Casco >", selected, 3) BREAK
        CASE 54 DRAW_OPTION(y, vehLbl, "< Dinghy >", selected, 3) BREAK
        CASE 55 DRAW_OPTION(y, vehLbl, "< Enduro >", selected, 3) BREAK
        CASE 56 DRAW_OPTION(y, vehLbl, "< GBurrito >", selected, 3) BREAK
        CASE 57 DRAW_OPTION(y, vehLbl, "< Guardian >", selected, 3) BREAK
        CASE 58 DRAW_OPTION(y, vehLbl, "< Hydra >", selected, 3) BREAK
        CASE 59 DRAW_OPTION(y, vehLbl, "< Insurgent >", selected, 3) BREAK
        CASE 60 DRAW_OPTION(y, vehLbl, "< Insurgent Pick-Up >", selected, 3) BREAK
        CASE 61 DRAW_OPTION(y, vehLbl, "< Kuruma >", selected, 3) BREAK
        CASE 62 DRAW_OPTION(y, vehLbl, "< Kuruma Armoured >", selected, 3) BREAK
        CASE 63 DRAW_OPTION(y, vehLbl, "< Lectro >", selected, 3) BREAK
        CASE 64 DRAW_OPTION(y, vehLbl, "< Mule Custom >", selected, 3) BREAK
        CASE 65 DRAW_OPTION(y, vehLbl, "< Savage >", selected, 3) BREAK
        CASE 66 DRAW_OPTION(y, vehLbl, "< Slamvan >", selected, 3) BREAK
        CASE 67 DRAW_OPTION(y, vehLbl, "< Tanker >", selected, 3) BREAK
        CASE 68 DRAW_OPTION(y, vehLbl, "< Technical >", selected, 3) BREAK
        CASE 69 DRAW_OPTION(y, vehLbl, "< Trashmaster >", selected, 3) BREAK
        CASE 70 DRAW_OPTION(y, vehLbl, "< Valkyrie >", selected, 3) BREAK
        CASE 71 DRAW_OPTION(y, vehLbl, "< Velum >", selected, 3) BREAK
        CASE 72 DRAW_OPTION(y, vehLbl, "< Dinghy >", selected, 3) BREAK
        CASE 73 DRAW_OPTION(y, vehLbl, "< Dinghy 2 >", selected, 3) BREAK
        CASE 74 DRAW_OPTION(y, vehLbl, "< Dinghy 3 >", selected, 3) BREAK
        CASE 75 DRAW_OPTION(y, vehLbl, "< Jetmax >", selected, 3) BREAK
        CASE 76 DRAW_OPTION(y, vehLbl, "< Marquis >", selected, 3) BREAK
        CASE 77 DRAW_OPTION(y, vehLbl, "< Seashark / Jetski >", selected, 3) BREAK
        CASE 78 DRAW_OPTION(y, vehLbl, "< Seashark Lifeguard >", selected, 3) BREAK
        CASE 79 DRAW_OPTION(y, vehLbl, "< Seashark Custom >", selected, 3) BREAK
        CASE 80 DRAW_OPTION(y, vehLbl, "< Speeder >", selected, 3) BREAK
        CASE 81 DRAW_OPTION(y, vehLbl, "< Speeder 2 >", selected, 3) BREAK
        CASE 82 DRAW_OPTION(y, vehLbl, "< Squalo >", selected, 3) BREAK
        CASE 83 DRAW_OPTION(y, vehLbl, "< Submersible >", selected, 3) BREAK
        CASE 84 DRAW_OPTION(y, vehLbl, "< Suntrap >", selected, 3) BREAK
        CASE 85 DRAW_OPTION(y, vehLbl, "< Toro >", selected, 3) BREAK
        CASE 86 DRAW_OPTION(y, vehLbl, "< Toro 2 >", selected, 3) BREAK
        CASE 87 DRAW_OPTION(y, vehLbl, "< Tropic >", selected, 3) BREAK
        CASE 88 DRAW_OPTION(y, vehLbl, "< Tug >", selected, 3) BREAK
        CASE 89 DRAW_OPTION(y, vehLbl, "< Avarus >", selected, 3) BREAK
        CASE 90 DRAW_OPTION(y, vehLbl, "< Banshee >", selected, 3) BREAK
        CASE 91 DRAW_OPTION(y, vehLbl, "< Bullet >", selected, 3) BREAK
        CASE 92 DRAW_OPTION(y, vehLbl, "< Coquette >", selected, 3) BREAK
        CASE 93 DRAW_OPTION(y, vehLbl, "< Phoenix >", selected, 3) BREAK
        CASE 94 DRAW_OPTION(y, vehLbl, "< Surano >", selected, 3) BREAK
        CASE 95 DRAW_OPTION(y, vehLbl, "< Vacca >", selected, 3) BREAK
        CASE 96 DRAW_OPTION(y, vehLbl, "< Stinger >", selected, 3) BREAK
        CASE 97 DRAW_OPTION(y, vehLbl, "< Exemplar >", selected, 3) BREAK
        CASE 98 DRAW_OPTION(y, vehLbl, "< Jackal >", selected, 3) BREAK
        CASE 99 DRAW_OPTION(y, vehLbl, "< Oracle >", selected, 3) BREAK
        CASE 100 DRAW_OPTION(y, vehLbl, "< Felon >", selected, 3) BREAK
        CASE 101 DRAW_OPTION(y, vehLbl, "< Schafter 2 >", selected, 3) BREAK
        CASE 102 DRAW_OPTION(y, vehLbl, "< Tailgater >", selected, 3) BREAK
        CASE 103 DRAW_OPTION(y, vehLbl, "< Washington >", selected, 3) BREAK
        CASE 104 DRAW_OPTION(y, vehLbl, "< Cognoscenti >", selected, 3) BREAK
        CASE 105 DRAW_OPTION(y, vehLbl, "< Baller 2 >", selected, 3) BREAK
        CASE 106 DRAW_OPTION(y, vehLbl, "< Cavalcade >", selected, 3) BREAK
        CASE 107 DRAW_OPTION(y, vehLbl, "< Dubsta >", selected, 3) BREAK
        CASE 108 DRAW_OPTION(y, vehLbl, "< FQ 2 >", selected, 3) BREAK
        CASE 109 DRAW_OPTION(y, vehLbl, "< Patriot >", selected, 3) BREAK
        CASE 110 DRAW_OPTION(y, vehLbl, "< Huntley S >", selected, 3) BREAK
        CASE 111 DRAW_OPTION(y, vehLbl, "< Rocoto >", selected, 3) BREAK
        CASE 112 DRAW_OPTION(y, vehLbl, "< Seminole >", selected, 3) BREAK
        CASE 113 DRAW_OPTION(y, vehLbl, "< Landstalker >", selected, 3) BREAK
        CASE 114 DRAW_OPTION(y, vehLbl, "< Bison >", selected, 3) BREAK
        CASE 115 DRAW_OPTION(y, vehLbl, "< Bobcat XL >", selected, 3) BREAK
        CASE 116 DRAW_OPTION(y, vehLbl, "< Sadler >", selected, 3) BREAK
        CASE 117 DRAW_OPTION(y, vehLbl, "< Primo >", selected, 3) BREAK
        CASE 118 DRAW_OPTION(y, vehLbl, "< Granger 2 >", selected, 3) BREAK
        CASE 119 DRAW_OPTION(y, vehLbl, "< Blazer >", selected, 3) BREAK
        CASE 120 DRAW_OPTION(y, vehLbl, "< Sanchez 2 >", selected, 3) BREAK
        CASE 121 DRAW_OPTION(y, vehLbl, "< Bagger >", selected, 3) BREAK
        CASE 122 DRAW_OPTION(y, vehLbl, "< Daemon >", selected, 3) BREAK
        CASE 123 DRAW_OPTION(y, vehLbl, "< Hexer >", selected, 3) BREAK
        CASE 124 DRAW_OPTION(y, vehLbl, "< Nemesis >", selected, 3) BREAK
        CASE 125 DRAW_OPTION(y, vehLbl, "< Ruffian >", selected, 3) BREAK
        CASE 126 DRAW_OPTION(y, vehLbl, "< Vader >", selected, 3) BREAK
        CASE 127 DRAW_OPTION(y, vehLbl, "< Thrust >", selected, 3) BREAK
        CASE 128 DRAW_OPTION(y, vehLbl, "< Vindicator >", selected, 3) BREAK
        CASE 129 DRAW_OPTION(y, vehLbl, "< Rhino Tank >", selected, 3) BREAK
        CASE 130 DRAW_OPTION(y, vehLbl, "< Bulldozer >", selected, 3) BREAK
        CASE 131 DRAW_OPTION(y, vehLbl, "< Forklift >", selected, 3) BREAK
        CASE 132 DRAW_OPTION(y, vehLbl, "< Mixer >", selected, 3) BREAK
        CASE 133 DRAW_OPTION(y, vehLbl, "< Hauler >", selected, 3) BREAK
        CASE 134 DRAW_OPTION(y, vehLbl, "< Packer >", selected, 3) BREAK
        CASE 135 DRAW_OPTION(y, vehLbl, "< Fire Truck >", selected, 3) BREAK
        CASE 136 DRAW_OPTION(y, vehLbl, "< Taxi >", selected, 3) BREAK
        CASE 137 DRAW_OPTION(y, vehLbl, "< Police Cruiser >", selected, 3) BREAK
        CASE 138 DRAW_OPTION(y, vehLbl, "< Sheriff SUV >", selected, 3) BREAK
        CASE 139 DRAW_OPTION(y, vehLbl, "< Bus >", selected, 3) BREAK
        CASE 140 DRAW_OPTION(y, vehLbl, "< Ambulance >", selected, 3) BREAK
        CASE 141 DRAW_OPTION(y, vehLbl, "< Tow Truck >", selected, 3) BREAK
        CASE 142 DRAW_OPTION(y, vehLbl, "< Trashmaster >", selected, 3) BREAK
        CASE 143 DRAW_OPTION(y, vehLbl, "< Dock Tug >", selected, 3) BREAK
        CASE 144 DRAW_OPTION(y, vehLbl, "< Tractor >", selected, 3) BREAK
        CASE 145 DRAW_OPTION(y, vehLbl, "< Maverick >", selected, 3) BREAK
        CASE 146 DRAW_OPTION(y, vehLbl, "< Frogger >", selected, 3) BREAK
        CASE 147 DRAW_OPTION(y, vehLbl, "< Shamal >", selected, 3) BREAK
        CASE 148 DRAW_OPTION(y, vehLbl, "< Mammatus >", selected, 3) BREAK
        CASE 149 DRAW_OPTION(y, vehLbl, "< Dodo >", selected, 3) BREAK
        CASE 150 DRAW_OPTION(y, vehLbl, "< Mallard Stunt >", selected, 3) BREAK
        CASE 151 DRAW_OPTION(y, vehLbl, "< Predator Boat >", selected, 3) BREAK
        CASE 152 DRAW_OPTION(y, vehLbl, "< Feltzer 3 >", selected, 3) BREAK
        CASE 153 DRAW_OPTION(y, vehLbl, "< Osiris >", selected, 3) BREAK
        CASE 154 DRAW_OPTION(y, vehLbl, "< Brawler >", selected, 3) BREAK
        CASE 155 DRAW_OPTION(y, vehLbl, "< T20 >", selected, 3) BREAK
        CASE 156 DRAW_OPTION(y, vehLbl, "< Moonbeam >", selected, 3) BREAK
        CASE 157 DRAW_OPTION(y, vehLbl, "< Voodoo >", selected, 3) BREAK
        CASE 158 DRAW_OPTION(y, vehLbl, "< Sabre GT >", selected, 3) BREAK
        CASE 159 DRAW_OPTION(y, vehLbl, "< Slamvan 3 >", selected, 3) BREAK
        CASE 160 DRAW_OPTION(y, vehLbl, "< Brickade >", selected, 3) BREAK
        CASE 161 DRAW_OPTION(y, vehLbl, "< Freecrawler >", selected, 3) BREAK
        CASE 162 DRAW_OPTION(y, vehLbl, "< Menacer >", selected, 3) BREAK
        CASE 163 DRAW_OPTION(y, vehLbl, "< Scramjet >", selected, 3) BREAK
        CASE 164 DRAW_OPTION(y, vehLbl, "< Terrorbyte >", selected, 3) BREAK
        CASE 165 DRAW_OPTION(y, vehLbl, "< Oppressor 2 >", selected, 3) BREAK
        CASE 166 DRAW_OPTION(y, vehLbl, "< Caracara >", selected, 3) BREAK
        CASE 167 DRAW_OPTION(y, vehLbl, "< Hotring Sabre >", selected, 3) BREAK
        CASE 168 DRAW_OPTION(y, vehLbl, "< Sea Sparrow >", selected, 3) BREAK
        CASE 169 DRAW_OPTION(y, vehLbl, "< Tampa Weaponized >", selected, 3) BREAK
        CASE 170 DRAW_OPTION(y, vehLbl, "< Formula >", selected, 3) BREAK
        CASE 171 DRAW_OPTION(y, vehLbl, "< Outlaw >", selected, 3) BREAK
        CASE 172 DRAW_OPTION(y, vehLbl, "< Zhaba >", selected, 3) BREAK
        CASE 173 DRAW_OPTION(y, vehLbl, "< Kosatka Sub >", selected, 3) BREAK
        CASE 174 DRAW_OPTION(y, vehLbl, "< Toreador >", selected, 3) BREAK
        CASE 175 DRAW_OPTION(y, vehLbl, "< RC Bandito >", selected, 3) BREAK
        CASE 176 DRAW_OPTION(y, vehLbl, "< Astron >", selected, 3) BREAK
        CASE 177 DRAW_OPTION(y, vehLbl, "< Champion >", selected, 3) BREAK
        CASE 178 DRAW_OPTION(y, vehLbl, "< Sultan Classic >", selected, 3) BREAK
        CASE 179 DRAW_OPTION(y, vehLbl, "< Vagrant >", selected, 3) BREAK
        CASE 180 DRAW_OPTION(y, vehLbl, "< Clique >", selected, 3) BREAK
        CASE 181 DRAW_OPTION(y, vehLbl, "< Deviant >", selected, 3) BREAK
        CASE 182 DRAW_OPTION(y, vehLbl, "< Schlagen GT >", selected, 3) BREAK
        CASE 183 DRAW_OPTION(y, vehLbl, "< Itali GTO >", selected, 3) BREAK
        CASE 184 DRAW_OPTION(y, vehLbl, "< Toros >", selected, 3) BREAK
        CASE 185 DRAW_OPTION(y, vehLbl, "< Vamos >", selected, 3) BREAK
        CASE 186 DRAW_OPTION(y, vehLbl, "< JB 700W >", selected, 3) BREAK
        CASE 187 DRAW_OPTION(y, vehLbl, "< Trailer Large >", selected, 3) BREAK
        CASE 188 DRAW_OPTION(y, vehLbl, "< Trailer 4 >", selected, 3) BREAK
        CASE 189 DRAW_OPTION(y, vehLbl, "< Trailer Small 2 >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_SELECTED_VEHICLE_SPAWN()
    // A spawn is asynchronous while the model streams.  Never replace its
    // pending model/count with another menu press in the meantime.
    IF g_vehicle_spawn_pending OR g_convert_pending EXIT ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() <= 0 EXIT ENDIF
        IF g_dlc_vehicle_index < 0 OR NOT DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index) EXIT ENDIF
        g_pending_vehicle_model = GET_DLC_VEHICLE_MODEL(g_dlc_vehicle_index)
    ELSE
    IF g_vehicle_spawn_choice >= 89
        g_pending_vehicle_model = MISC_VEHICLE_MODEL(g_vehicle_spawn_choice)
    ELSE
    SWITCH g_vehicle_spawn_choice
        CASE 0 g_pending_vehicle_model = ADDER BREAK
        CASE 1 g_pending_vehicle_model = BUFFALO BREAK
        CASE 2 g_pending_vehicle_model = CHEETAH BREAK
        CASE 3 g_pending_vehicle_model = COMET2 BREAK
        CASE 4 g_pending_vehicle_model = ENTITYXF BREAK
        CASE 5 g_pending_vehicle_model = INFERNUS BREAK
        CASE 6 g_pending_vehicle_model = SULTAN BREAK
        CASE 7 g_pending_vehicle_model = RAPIDGT BREAK
        CASE 8 g_pending_vehicle_model = CARBONIZZARE BREAK
        CASE 9 g_pending_vehicle_model = FELTZER2 BREAK
        CASE 10 g_pending_vehicle_model = NINEF BREAK
        CASE 11 g_pending_vehicle_model = DOMINATOR BREAK
        CASE 12 g_pending_vehicle_model = GAUNTLET BREAK
        CASE 13 g_pending_vehicle_model = ELEGY2 BREAK
        CASE 14 g_pending_vehicle_model = BALLER BREAK
        CASE 15 g_pending_vehicle_model = GRANGER BREAK
        CASE 16 g_pending_vehicle_model = SANDKING BREAK
        CASE 17 g_pending_vehicle_model = MESA BREAK
        CASE 18 g_pending_vehicle_model = AIRBUS BREAK
        CASE 19 g_pending_vehicle_model = BATI BREAK
        CASE 20 g_pending_vehicle_model = PCJ BREAK
        CASE 21 g_pending_vehicle_model = AKUMA BREAK
        CASE 22 g_pending_vehicle_model = SANCHEZ BREAK
        CASE 23 g_pending_vehicle_model = FAGGIO BREAK
        CASE 24 g_pending_vehicle_model = BUZZARD BREAK
        CASE 25 g_pending_vehicle_model = DUSTER BREAK
        CASE 26 g_pending_vehicle_model = CARGOBOB BREAK
        CASE 27 g_pending_vehicle_model = LAZER BREAK
        CASE 28 g_pending_vehicle_model = BLAZER4 BREAK
        CASE 29 g_pending_vehicle_model = CHIMERA BREAK
        CASE 30 g_pending_vehicle_model = DAEMON2 BREAK
        CASE 31 g_pending_vehicle_model = DEFILER BREAK
        CASE 32 g_pending_vehicle_model = ESSKEY BREAK
        CASE 33 g_pending_vehicle_model = FAGGIO3 BREAK
        CASE 34 g_pending_vehicle_model = HAKUCHOU2 BREAK
        CASE 35 g_pending_vehicle_model = MANCHEZ BREAK
        CASE 36 g_pending_vehicle_model = NIGHTBLADE BREAK
        CASE 37 g_pending_vehicle_model = RAPTOR BREAK
        CASE 38 g_pending_vehicle_model = RATBIKE BREAK
        CASE 39 g_pending_vehicle_model = SANCTUS BREAK
        CASE 40 g_pending_vehicle_model = SHOTARO BREAK
        CASE 41 g_pending_vehicle_model = TORNADO6 BREAK
        CASE 42 g_pending_vehicle_model = VORTEX BREAK
        CASE 43 g_pending_vehicle_model = WOLFSBANE BREAK
        CASE 44 g_pending_vehicle_model = YOUGA2 BREAK
        CASE 45 g_pending_vehicle_model = ZOMBIEA BREAK
        CASE 46 g_pending_vehicle_model = ZOMBIEB BREAK
        CASE 47 g_pending_vehicle_model = JESTER2 BREAK
        CASE 48 g_pending_vehicle_model = MASSACRO2 BREAK
        CASE 49 g_pending_vehicle_model = RATLOADER2 BREAK
        CASE 50 g_pending_vehicle_model = SLAMVAN BREAK
        CASE 51 g_pending_vehicle_model = BARRACKS3 BREAK
        CASE 52 g_pending_vehicle_model = BOXVILLE4 BREAK
        CASE 53 g_pending_vehicle_model = CASCO BREAK
        CASE 54 g_pending_vehicle_model = DINGHY BREAK
        CASE 55 g_pending_vehicle_model = ENDURO BREAK
        CASE 56 g_pending_vehicle_model = GBURRITO2 BREAK
        CASE 57 g_pending_vehicle_model = GUARDIAN BREAK
        CASE 58 g_pending_vehicle_model = HYDRA BREAK
        CASE 59 g_pending_vehicle_model = INSURGENT BREAK
        CASE 60 g_pending_vehicle_model = INSURGENT2 BREAK
        CASE 61 g_pending_vehicle_model = KURUMA BREAK
        CASE 62 g_pending_vehicle_model = KURUMA2 BREAK
        CASE 63 g_pending_vehicle_model = LECTRO BREAK
        CASE 64 g_pending_vehicle_model = MULE3 BREAK
        CASE 65 g_pending_vehicle_model = SAVAGE BREAK
        CASE 66 g_pending_vehicle_model = SLAMVAN2 BREAK
        CASE 67 g_pending_vehicle_model = TANKER2 BREAK
        CASE 68 g_pending_vehicle_model = TECHNICAL BREAK
        CASE 69 g_pending_vehicle_model = TRASH2 BREAK
        CASE 70 g_pending_vehicle_model = VALKYRIE BREAK
        CASE 71 g_pending_vehicle_model = VELUM2 BREAK
        CASE 72 g_pending_vehicle_model = DINGHY BREAK
        CASE 73 g_pending_vehicle_model = DINGHY2 BREAK
        CASE 74 g_pending_vehicle_model = DINGHY3 BREAK
        CASE 75 g_pending_vehicle_model = JETMAX BREAK
        CASE 76 g_pending_vehicle_model = MARQUIS BREAK
        CASE 77 g_pending_vehicle_model = SEASHARK BREAK
        CASE 78 g_pending_vehicle_model = SEASHARK2 BREAK
        CASE 79 g_pending_vehicle_model = SEASHARK3 BREAK
        CASE 80 g_pending_vehicle_model = SPEEDER BREAK
        CASE 81 g_pending_vehicle_model = SPEEDER2 BREAK
        CASE 82 g_pending_vehicle_model = SQUALO BREAK
        CASE 83 g_pending_vehicle_model = SUBMERSIBLE BREAK
        CASE 84 g_pending_vehicle_model = SUNTRAP BREAK
        CASE 85 g_pending_vehicle_model = TORO BREAK
        CASE 86 g_pending_vehicle_model = TORO2 BREAK
        CASE 87 g_pending_vehicle_model = TROPIC BREAK
        CASE 88 g_pending_vehicle_model = TUG BREAK
    ENDSWITCH
    ENDIF
    ENDIF
    IF IS_MODEL_IN_CDIMAGE(g_pending_vehicle_model)
        IF g_spawn_count < 1 g_spawn_count = 1 ENDIF
        IF g_spawn_count > 500 g_spawn_count = 500 ENDIF
        g_spawn_remaining = g_spawn_count
        g_active_spawn_count = g_spawn_count
        g_spawn_index = 0
        g_spawn_warp_index = -1
        IF g_spawn_teleport_into_vehicle
            IF g_active_spawn_count = 1
                g_spawn_warp_index = 0
            ELSE
                g_spawn_warp_index = GET_RANDOM_INT_IN_RANGE(0, g_active_spawn_count)
            ENDIF
        ENDIF
        g_spawn_heading = GET_ENTITY_HEADING(PLAYER_PED_ID())
        IF g_delete_previous_spawned_vehicle
            DELETE_PREVIOUS_CUSTOM_CAR()
        ENDIF
        REQUEST_MODEL(g_pending_vehicle_model)
        g_vehicle_spawn_pending = TRUE
        g_vehicle_spawn_request_time = GET_GAME_TIMER()
    ENDIF
ENDPROC

PROC START_ONE_SELECTED_VEHICLE_SPAWN()
    INT savedSpawnCount = g_spawn_count
    g_spawn_count = 1
    START_SELECTED_VEHICLE_SPAWN()
    g_spawn_count = savedSpawnCount
ENDPROC

PROC FINISH_SELECTED_VEHICLE_SPAWN()
    VEHICLE_INDEX spawnedVehicle
    INT column = 0
    INT row = 0
    INT shiftIndex = 0
    FLOAT offsetX = 0.0
    FLOAT offsetY = 4.0
    // A single requested vehicle should be immediately usable, rather than
    // using the first cell of the multi-car formation (which placed it off to
    // the side). Keep a small buffer so it does not spawn inside the ped.
    IF g_active_spawn_count <= 1
        offsetX = 0.0
        offsetY = 2.50
    ELIF g_spawn_alignment = 0
        column = g_spawn_index - ((g_spawn_index / 10) * 10)
        row = g_spawn_index / 10
        // 6.5m rather than the old 4.2m/5.5m: a supercar is already 4.5m long, so
        // a 4.2m grid spawned each row overlapping the one in front of it and left
        // the game to push 500 interpenetrating bodies apart.  Larger aircraft can
        // still overlap - this only removes the overlap the grid itself created.
        offsetX = (TO_FLOAT(column) - 4.5) * 6.5
        offsetY = 4.0 + (TO_FLOAT(row) * 6.5)
    ELSE
        column = g_spawn_index - ((g_spawn_index / 5) * 5)
        row = g_spawn_index / 5
        offsetX = (TO_FLOAT(column) - 2.0) * 6.5
        offsetY = 4.0 + (TO_FLOAT(row) * 6.5)
    ENDIF
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<offsetX, offsetY, 1.0>>)
    FLOAT spawnHeading = g_spawn_heading + (TO_FLOAT(g_spawn_facing) * 90.0)
    spawnedVehicle = CREATE_VEHICLE(g_pending_vehicle_model, spawnPosition, spawnHeading, FALSE)
    IF DOES_ENTITY_EXIST(spawnedVehicle)
        SET_VEHICLE_ON_GROUND_PROPERLY(spawnedVehicle)
        IF g_spawn_maxed
            APPLY_LSC_MAX_TO_VEHICLE(spawnedVehicle)
        ENDIF
        PRUNE_SPAWNED_VEHICLE_TRACKING()
        IF g_spawned_custom_vehicle_count >= MAX_TRACKED_CUSTOM_VEHICLES
            IF DOES_ENTITY_EXIST(g_spawned_custom_vehicles[0])
                IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) OR GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()) != g_spawned_custom_vehicles[0]
                    SET_ENTITY_AS_MISSION_ENTITY(g_spawned_custom_vehicles[0], TRUE, TRUE)
                    DELETE_VEHICLE(g_spawned_custom_vehicles[0])
                ELSE
                    SET_VEHICLE_AS_NO_LONGER_NEEDED(g_spawned_custom_vehicles[0])
                ENDIF
            ENDIF
            REPEAT MAX_TRACKED_CUSTOM_VEHICLES - 1 shiftIndex
                g_spawned_custom_vehicles[shiftIndex] = g_spawned_custom_vehicles[shiftIndex + 1]
            ENDREPEAT
            g_spawned_custom_vehicle_count = MAX_TRACKED_CUSTOM_VEHICLES - 1
        ENDIF
        g_spawned_custom_vehicles[g_spawned_custom_vehicle_count] = spawnedVehicle
        g_spawned_custom_vehicle_count = g_spawned_custom_vehicle_count + 1
        g_last_spawned_vehicle = spawnedVehicle
        IF g_spawn_index = g_spawn_warp_index AND NOT NOCLIP_VEHICLE_ENTRY_BLOCKED()
            SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), spawnedVehicle, VS_DRIVER)
        ENDIF
    ENDIF
    g_spawn_index = g_spawn_index + 1
    g_spawn_remaining = g_spawn_remaining - 1
    IF g_spawn_remaining <= 0
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_vehicle_model)
        g_vehicle_spawn_pending = FALSE
        g_active_spawn_count = 0
        g_spawn_warp_index = -1
    ENDIF
ENDPROC

PROC MOVE_PLAYER_TO_RESPAWN_LOCATION()
    SWITCH g_respawn_location_choice
        CASE 0 SET_ENTITY_COORDS(PLAYER_PED_ID(), g_last_living_position) BREAK
        CASE 1 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-14.4, -1438.0, 31.1>>) BREAK
        CASE 2 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-852.4, 160.0, 65.6>>) BREAK
        CASE 3 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<1975.5, 3819.6, 33.4>>) BREAK
        CASE 4 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-449.7, -340.7, 34.5>>) BREAK
        CASE 5 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-47.1, -1112.3, 26.4>>) BREAK
        CASE 6 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-662.1, -948.5, 21.5>>) BREAK
        CASE 7 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<425.1, -979.5, 30.7>>) BREAK
        CASE 8 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-365.4, -131.4, 37.9>>) BREAK
        CASE 9 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1034.6, -2733.6, 20.2>>) BREAK
        CASE 10 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-75.0, -818.9, 326.2>>) BREAK
        CASE 11 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<102.9, -1939.7, 20.8>>) BREAK
        CASE 12 TELEPORT_TO_NORTH_YANKTON() BREAK
        CASE 13 TELEPORT_TO_CAYO_PERICO() BREAK
        CASE 14 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-2047.4, 3132.1, 32.8>>) BREAK
        CASE 15 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<711.7, 1198.8, 348.5>>) BREAK
        CASE 16 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<501.7, 5604.4, 797.9>>) BREAK
        CASE 17 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<1692.0, 3291.0, 41.0>>) BREAK
        CASE 18 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-438.0, 1076.0, 327.0>>) BREAK
        CASE 19 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1170.0, 4927.0, 224.0>>) BREAK
        CASE 20 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-1604.5, -1072.5, 13.0>>) BREAK
        CASE 21 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-112.3, 6463.2, 31.0>>) BREAK
        CASE 22 SET_ENTITY_COORDS(PLAYER_PED_ID(), <<3615.2, 3740.6, 28.7>>) BREAK
    ENDSWITCH
ENDPROC

PROC MOVE_MENU_CURSOR(INT direction)
    g_item = g_item + direction
    IF g_item < 0 g_item = ACTIVE_ITEM_COUNT() - 1 ENDIF
    IF g_item >= ACTIVE_ITEM_COUNT() g_item = 0 ENDIF
ENDPROC

PROC PROCESS_MENU_DIRECTION_INPUT()
    INT now = GET_GAME_TIMER()
    BOOL jumpToTop = FALSE
    IF g_keyboard_active EXIT ENDIF

    // R3 jumps the cursor to the top of the current page.  It drives the same
    // g_item/g_scroll that every tab and every submenu shares, so it works
    // everywhere without a per-submenu case, and SAVE_NAVIGATION_STATE keeps the
    // stored per-menu cursor in step.  Both possible bindings are read because
    // the Switch port does not follow the PC mapping: INPUT_LOOK_BEHIND is R3 on
    // foot in the stock layout, INPUT_SCRIPT_RS is the port's own right-stick
    // click action.
    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_LOOK_BEHIND) jumpToTop = TRUE ENDIF
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_RS) jumpToTop = TRUE ENDIF
    IF jumpToTop
        g_item = 0
        g_scroll = 0
        SAVE_NAVIGATION_STATE()
        MENU_PLAY_SOUND("NAV_UP_DOWN")
    ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP)
        MOVE_MENU_CURSOR(-1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_up_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP) AND now >= g_next_up_repeat
        MOVE_MENU_CURSOR(-1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_up_repeat = now + 70
    ENDIF

    IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
        MOVE_MENU_CURSOR(1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_down_repeat = now + 280
    ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN) AND now >= g_next_down_repeat
        MOVE_MENU_CURSOR(1)
        MENU_PLAY_SOUND("NAV_UP_DOWN")
        g_next_down_repeat = now + 70
    ENDIF

    IF NOT g_home AND IS_SELECTOR_ACTIVE()
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT)
            ADJUST_SELECTOR(-1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_left_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_LEFT) AND now >= g_next_left_repeat
            ADJUST_SELECTOR(-1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_left_repeat = now + 70
        ENDIF
        IF IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT)
            ADJUST_SELECTOR(1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_right_repeat = now + 280
        ELIF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT) AND now >= g_next_right_repeat
            ADJUST_SELECTOR(1) MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("NAV_LEFT_RIGHT")
            g_next_right_repeat = now + 70
        ENDIF
    ENDIF

    IF NOT g_home AND g_tab = 7 AND g_nsc_loader_open AND NOT g_nsc_unload_open AND g_item >= NSC_LOADER_HEADER_ROWS() AND g_nsc_discovered_count > 0
        IF CUSTOM_NSC_REMOVE_COMBO_PRESSED()
            REMOVE_SAVED_CUSTOM_NSC_AT_SLOT(g_item - NSC_LOADER_HEADER_ROWS())
            UPDATE_SCROLL()
            SAVE_NAVIGATION_STATE()
            MARK_PERSIST_DIRTY()
            MENU_PLAY_SOUND("BACK")
        ENDIF
    ENDIF
ENDPROC

PROC HANDLE_NSC_UNLOAD_APPLY()
    INT activeCount = COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
    IF activeCount > 0 AND g_item < activeCount
        INT unloadSlot = NSC_GET_ACTIVE_SLOT_FOR_INDEX(g_item)
        IF unloadSlot >= 0
            TERMINATE_AND_UNLOAD_CUSTOM_NSC_SLOT(unloadSlot)
            MENU_PLAY_SOUND("SELECT")
            INT remainCount = COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
            IF remainCount <= 0
                g_nsc_unload_open = FALSE
                g_item = g_nsc_loader_item
                g_scroll = g_nsc_loader_scroll
                IF g_item >= 3 g_item = 2 ENDIF
                IF g_item >= NSC_LOADER_TOTAL_ROWS()
                    g_item = NSC_LOADER_TOTAL_ROWS() - 1
                ENDIF
                IF g_item < 0 g_item = 0 ENDIF
            ELSE
                IF g_item >= remainCount
                    g_item = remainCount - 1
                ENDIF
            ENDIF
            UPDATE_SCROLL()
            SAVE_NAVIGATION_STATE()
        ENDIF
    ENDIF
ENDPROC

PROC APPLY_SELECTED()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX playerVehicle
    MODEL_NAMES currentPlayerModel
    IF g_outfit_open
        ADJUST_OUTFIT_TEXTURE()
        EXIT
    ENDIF
    IF g_radio_open
        SWITCH g_item
            CASE 0
                // Current Station is read-only
                BREAK
            CASE 1
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    DISABLE_PORTABLE_RADIO()
                ELSE
                    g_mobile_radio = NOT g_mobile_radio
                    SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(g_mobile_radio)
                    SET_MOBILE_PHONE_RADIO_STATE(g_mobile_radio)
                    SET_USER_RADIO_CONTROL_ENABLED(g_mobile_radio)
                    IF g_mobile_radio
                        SET_RADIO_TO_STATION_INDEX(RADIO_STATION_WHEEL_INDEX(g_radio_station_index))
                        SET_RADIO_TO_STATION_NAME(RADIO_STATION_CODE(g_radio_station_index))
                    ENDIF
                ENDIF
                BREAK
            CASE 2
                g_radio_station_index = GET_PREV_RADIO_STATION_INDEX(g_radio_station_index)
                IF g_mobile_radio OR IS_PED_IN_ANY_VEHICLE(playerPed)
                    SET_RADIO_TO_STATION_INDEX(RADIO_STATION_WHEEL_INDEX(g_radio_station_index))
                    SET_RADIO_TO_STATION_NAME(RADIO_STATION_CODE(g_radio_station_index))
                ENDIF
                BREAK
            CASE 3
                g_radio_station_index = GET_NEXT_RADIO_STATION_INDEX(g_radio_station_index)
                IF g_mobile_radio OR IS_PED_IN_ANY_VEHICLE(playerPed)
                    SET_RADIO_TO_STATION_INDEX(RADIO_STATION_WHEEL_INDEX(g_radio_station_index))
                    SET_RADIO_TO_STATION_NAME(RADIO_STATION_CODE(g_radio_station_index))
                ENDIF
                BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF g_ped_open
        IF g_story_ped_picker_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(16)
            ELIF g_item = 1
                APPLY_RANDOM_STORY_CHAR_PED()
            ELIF g_item > 1
                SET_STORY_CHAR_CATALOG_CHOICE(g_story_ped_active_char, g_item - 2)
            ENDIF
            EXIT
        ENDIF
        IF g_story_peds_open
            g_story_peds_item = g_item
            g_story_peds_scroll = g_scroll
            g_story_ped_active_char = STORY_CHAR_ID_FOR_VISIBLE_ROW(g_item)
            g_story_ped_search_not_found = FALSE
            g_story_ped_picker_open = TRUE
            g_item = g_story_ped_picker_item
            g_scroll = g_story_ped_picker_scroll
            UPDATE_SCROLL()
            EXIT
        ENDIF
        IF g_item = 0
            g_ped_item = g_item
            g_ped_scroll = g_scroll
            g_story_peds_open = TRUE
            g_story_ped_picker_open = FALSE
            g_item = g_story_peds_item
            g_scroll = g_story_peds_scroll
            UPDATE_SCROLL()
        ELIF g_item = 1
            OPEN_MENU_KEYBOARD(3)
        ELIF g_item = 2
            APPLY_RANDOM_PED()
        ELIF g_item = 3
            SAVE_ACTIVE_CHARACTER_PED()
            APPLY_CHARACTER_PROFILE(g_character_slot)
        ELIF g_item > 3
            SAVE_ACTIVE_CHARACTER_PED()
            g_ped_choice = g_item - 4
            g_ped_search_not_found = FALSE
            g_ped_search_has_value = TRUE
            g_ped_search_is_custom = FALSE
            g_ped_search_value = PED_NAME_FOR_CHOICE(g_ped_choice)
            REQUEST_PED_CHANGE(PED_MODEL_FOR_CHOICE(g_ped_choice))
        ENDIF
        EXIT
    ENDIF
    IF g_bodyguard_open
        IF g_guard_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(10)
            ELIF g_item = 1
                APPLY_RANDOM_GUARD_PED()
            ELIF g_item > 1
                g_guard_ped_choice = g_item - 2
                g_guard_ped_name = PED_NAME_FOR_CHOICE(g_guard_ped_choice)
                g_guard_ped_search_is_custom = FALSE
                g_guard_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        IF g_bodyguard_tp_too_far
            SWITCH g_item
                CASE 0 START_BODYGUARD_SPAWN() BREAK
                CASE 1
                    g_bodyguard_item = g_item
                    g_bodyguard_scroll = g_scroll
                    g_guard_ped_open = TRUE
                    g_item = g_guard_ped_item
                    g_scroll = g_guard_ped_scroll
                BREAK
                CASE 4
                    g_bodyguard_follow = NOT g_bodyguard_follow
                    APPLY_BODYGUARD_FOLLOW_STATE()
                BREAK
                CASE 5
                    g_bodyguard_allow_vehicle = NOT g_bodyguard_allow_vehicle
                BREAK
                CASE 6
                    g_bodyguard_tp_too_far = NOT g_bodyguard_tp_too_far
                    IF NOT g_bodyguard_tp_too_far AND g_item > 6
                        g_item = g_item - 1
                    ENDIF
                BREAK
                CASE 7
                    OPEN_MENU_KEYBOARD(17)
                BREAK
                CASE 8
                    g_bodyguard_blips = NOT g_bodyguard_blips
                    SYNC_BODYGUARD_BLIPS()
                BREAK
                CASE 9
                    g_bodyguard_god = NOT g_bodyguard_god
                    APPLY_BODYGUARD_GOD_STATE()
                BREAK
                CASE 10 CLEAR_BODYGUARDS() BREAK
            ENDSWITCH
        ELSE
            SWITCH g_item
                CASE 0 START_BODYGUARD_SPAWN() BREAK
                CASE 1
                    g_bodyguard_item = g_item
                    g_bodyguard_scroll = g_scroll
                    g_guard_ped_open = TRUE
                    g_item = g_guard_ped_item
                    g_scroll = g_guard_ped_scroll
                BREAK
                CASE 4
                    g_bodyguard_follow = NOT g_bodyguard_follow
                    APPLY_BODYGUARD_FOLLOW_STATE()
                BREAK
                CASE 5
                    g_bodyguard_allow_vehicle = NOT g_bodyguard_allow_vehicle
                BREAK
                CASE 6
                    g_bodyguard_tp_too_far = NOT g_bodyguard_tp_too_far
                BREAK
                CASE 7
                    g_bodyguard_blips = NOT g_bodyguard_blips
                    SYNC_BODYGUARD_BLIPS()
                BREAK
                CASE 8
                    g_bodyguard_god = NOT g_bodyguard_god
                    APPLY_BODYGUARD_GOD_STATE()
                BREAK
                CASE 9 CLEAR_BODYGUARDS() BREAK
            ENDSWITCH
        ENDIF
        IF g_item = 3 APPLY_BODYGUARD_FORMATION() ENDIF
        EXIT
    ENDIF
    IF g_attacker_open
        IF g_attacker_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(11)
            ELIF g_item = 1
                APPLY_RANDOM_ATTACKER_PED()
            ELIF g_item > 1
                g_attacker_ped_choice = g_item - 2
                g_attacker_ped_name = PED_NAME_FOR_CHOICE(g_attacker_ped_choice)
                g_attacker_ped_search_is_custom = FALSE
                g_attacker_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        SWITCH g_item
            CASE 0 START_ATTACKER_SPAWN() BREAK
            CASE 1
                g_attacker_item = g_item
                g_attacker_scroll = g_scroll
                g_attacker_ped_open = TRUE
                g_item = g_attacker_ped_item
                g_scroll = g_attacker_ped_scroll
            BREAK
            CASE 3
                g_attacker_rage = NOT g_attacker_rage
                APPLY_ATTACKER_RAGE_STATE()
            BREAK
            CASE 4
                g_attacker_god = NOT g_attacker_god
                APPLY_ATTACKER_GOD_STATE()
            BREAK
            CASE 5 CLEAR_MENU_ATTACKERS() BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF g_chauffeur_open
        // ---- Chauffeur submenu (Vehicle Settings row 25) ----
        // Child pages first, for the same reason their count and draw tests are
        // first: g_chauffeur_open stays TRUE while one of them is displayed.
        IF g_chauffeur_armed_open
            IF g_item = 0
                g_chauffeur_armed = NOT g_chauffeur_armed
                APPLY_CHAUFFEUR_ARMED_STATE()
            ELIF g_item > 0
                g_chauffeur_weapon_choice = g_item - 1
                IF g_chauffeur_weapon_choice >= MENU_WEAPON_COUNT() g_chauffeur_weapon_choice = 0 ENDIF
                APPLY_CHAUFFEUR_ARMED_STATE()
            ENDIF
            EXIT
        ENDIF
        IF g_chauffeur_vehicle_open
            IF g_item < CHAUFFEUR_VEHICLE_COUNT g_chauffeur_vehicle_choice = g_item ENDIF
            EXIT
        ENDIF
        IF g_chauffeur_ped_open
            IF g_item = 0
                OPEN_MENU_KEYBOARD(13)
            ELIF g_item = 1
                APPLY_RANDOM_CHAUFFEUR_PED()
            ELIF g_item > 1
                g_chauffeur_ped_choice = g_item - 2
                g_chauffeur_ped_name = PED_NAME_FOR_CHOICE(g_chauffeur_ped_choice)
                g_chauffeur_ped_search_is_custom = FALSE
                g_chauffeur_ped_search_not_found = FALSE
            ENDIF
            EXIT
        ENDIF
        SWITCH g_item
            CASE 0 START_CHAUFFEUR_SPAWN() BREAK
            CASE 1
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_ped_open = TRUE
                g_item = g_chauffeur_ped_item
                g_scroll = g_chauffeur_ped_scroll
            BREAK
            CASE 2
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_vehicle_open = TRUE
                g_item = g_chauffeur_vehicle_item
                g_scroll = g_chauffeur_vehicle_scroll
            BREAK
            CASE 3
                g_chauffeur_style = g_chauffeur_style + 1
                IF g_chauffeur_style > 2 g_chauffeur_style = 0 ENDIF
                REFRESH_CHAUFFEUR_DRIVING_MODE()
                ISSUE_CHAUFFEUR_DRIVE_TASK()
            BREAK
            CASE 4
                g_chauffeur_ignore_lights = NOT g_chauffeur_ignore_lights
                REFRESH_CHAUFFEUR_DRIVING_MODE()
                ISSUE_CHAUFFEUR_DRIVE_TASK()
            BREAK
            CASE 5
                g_chauffeur_god = NOT g_chauffeur_god
                APPLY_CHAUFFEUR_EXTRAS()
            BREAK
            CASE 6
                g_chauffeur_bulletproof_tyres = NOT g_chauffeur_bulletproof_tyres
                APPLY_CHAUFFEUR_EXTRAS()
            BREAK
            CASE 7
                g_chauffeur_item = g_item
                g_chauffeur_scroll = g_scroll
                g_chauffeur_armed_open = TRUE
                g_item = g_chauffeur_armed_item
                g_scroll = g_chauffeur_armed_scroll
            BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF g_neon_anim_open
        // Mode and speed auto-apply on Left/Right; A has no action here.
        EXIT
    ENDIF
    IF g_vehicle_control_open
        // Windows (0) and Dirt Level (7) auto-apply on Left/Right and the
        // Window picker (1) is a selection only, so A acts on the remainder.
        IF NOT IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
        SWITCH g_item
            CASE 2 APPLY_VEHICLE_SELECTED_WINDOW(TRUE) BREAK
            CASE 3 APPLY_VEHICLE_SELECTED_WINDOW(FALSE) BREAK
            CASE 4 APPLY_VEHICLE_ENGINE_TOGGLE() BREAK
            CASE 5
                g_vehicle_hazards = NOT g_vehicle_hazards
                g_vehicle_hazards_tick = 0
                APPLY_VEHICLE_HAZARDS_STATE()
            BREAK
            CASE 6 APPLY_VEHICLE_SEAT_SWITCH() BREAK
            CASE 8 APPLY_VEHICLE_WASH() BREAK
        ENDSWITCH
        EXIT
    ENDIF
    SWITCH g_tab
        CASE 0
            SWITCH g_item
                CASE 0
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_radio_open = TRUE
                    g_item = g_radio_item
                    g_scroll = g_radio_scroll
                BREAK
                CASE 1
                    g_god = NOT g_god
                    SET_PLAYER_INVINCIBLE(PLAYER_ID(), g_god)
                BREAK
                CASE 2
                    SET_ENTITY_HEALTH(playerPed, GET_ENTITY_MAX_HEALTH(playerPed))
                    SET_PED_ARMOUR(playerPed, 100)
                BREAK
                CASE 3
                    g_invisible = NOT g_invisible
                    SET_ENTITY_VISIBLE(playerPed, NOT g_invisible)
                    IF NOT g_invisible g_player_freecam = FALSE ENDIF
                BREAK
                CASE 4
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    currentPlayerModel = GET_ENTITY_MODEL(playerPed)
                    IF currentPlayerModel = PLAYER_ZERO
                        g_character_slot = 0
                    ELIF currentPlayerModel = PLAYER_ONE
                        g_character_slot = 1
                    ELIF currentPlayerModel = PLAYER_TWO
                        g_character_slot = 2
                    ENDIF
                    g_ped_choice = PED_CHOICE_FOR_MODEL(currentPlayerModel)
                    g_ped_open = TRUE
                    g_item = g_ped_item
                    g_scroll = g_ped_scroll
                BREAK
                CASE 5
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_outfit_open = TRUE
                    g_item = g_outfit_item
                    g_scroll = g_outfit_scroll
                BREAK
                CASE 6
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_bodyguard_open = TRUE
                    g_item = g_bodyguard_item
                    g_scroll = g_bodyguard_scroll
                BREAK
                CASE 7
                    g_page_item[0] = g_item
                    g_page_scroll[0] = g_scroll
                    g_attacker_open = TRUE
                    g_item = g_attacker_item
                    g_scroll = g_attacker_scroll
                BREAK
                CASE 8 SET_PLAYER_NOCLIP_ENABLED(NOT g_player_noclip) BREAK
                CASE 9 SET_PLAYER_FREECAM_ENABLED(NOT g_player_freecam) BREAK
                CASE 10
                    g_unlimited_oxygen = NOT g_unlimited_oxygen
                    APPLY_UNLIMITED_OXYGEN()
                BREAK
                CASE 11
                    g_unlimited_ability = NOT g_unlimited_ability
                    APPLY_UNLIMITED_ABILITY()
                BREAK
                CASE 12
                    g_fast_run = NOT g_fast_run
                BREAK
                CASE 13
                    g_fast_swim = NOT g_fast_swim
                BREAK
                CASE 14
                    g_super_jump = NOT g_super_jump
                BREAK
                CASE 15
                    g_no_ragdoll = NOT g_no_ragdoll
                    SET_PED_CAN_RAGDOLL(playerPed, NOT g_no_ragdoll)
                BREAK
                CASE 16 g_infinite_parachute = NOT g_infinite_parachute BREAK
                CASE 17 OPEN_MENU_KEYBOARD(2) BREAK
                CASE 18
                    SWITCH GET_ENTITY_MODEL(playerPed)
                        CASE PLAYER_ZERO STAT_SET_INT(SP0_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_ONE STAT_SET_INT(SP1_TOTAL_CASH, g_cash_amount) BREAK
                        CASE PLAYER_TWO STAT_SET_INT(SP2_TOTAL_CASH, g_cash_amount) BREAK
                    ENDSWITCH
                BREAK
                CASE 19
                    g_explosive_melee = NOT g_explosive_melee
                BREAK
                CASE 20
                    g_super_punch = NOT g_super_punch
                    g_super_punch_time = 0
                BREAK
                CASE 21
                    g_drunk = NOT g_drunk
                    IF g_drunk
                        SET_PED_IS_DRUNK(playerPed, TRUE)
                        REQUEST_ANIM_SET("move_m@drunk@verydrunk")
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.30)
                    ELSE
                        SET_PED_IS_DRUNK(playerPed, FALSE)
                        RESET_PED_MOVEMENT_CLIPSET(playerPed)
                        REMOVE_ANIM_SET("move_m@drunk@verydrunk")
                        IF g_camera_shake
                            SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.5)
                        ELSE
                            STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                        ENDIF
                    ENDIF
                BREAK
                CASE 22 CLEAR_PLAYER_DAMAGE_MARKS() BREAK
                CASE 23 SET_ENTITY_HEALTH(playerPed, 0) BREAK
                CASE 24
                    g_auto_save = NOT g_auto_save
                    // Re-arm from the moment it is switched on; no save fires
                    // on the toggle itself. Turning it off just stops the timer.
                    g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000)
                BREAK
                CASE 25 OPEN_MENU_KEYBOARD(12) BREAK
            ENDSWITCH
        BREAK
        CASE 1
            IF g_weapon_upgrades_open
                SWITCH g_item
                    CASE 0 REFILL_CURRENT_HELD_WEAPON() BREAK
                    CASE 1 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_MAG_COMPONENT()) BREAK
                    CASE 2 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_FLASHLIGHT_COMPONENT()) BREAK
                    CASE 3 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_SUPPRESSOR_COMPONENT()) BREAK
                    CASE 4 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_GRIP_COMPONENT()) BREAK
                    CASE 5 TOGGLE_HELD_WEAPON_COMPONENT(HELD_WEAPON_SCOPE_COMPONENT()) BREAK
                    CASE 6
                        IF HELD_WEAPON_EDITABLE()
                            SET_PED_WEAPON_TINT_INDEX(playerPed, CURRENT_HELD_WEAPON(), g_weapon_tint_choice)
                        ENDIF
                    BREAK
                ENDSWITCH
            ELSE
                SWITCH g_item
                    CASE 0
                        GIVE_ALL_MENU_WEAPONS(playerPed)
                    BREAK
                    CASE 1
                        GIVE_SELECTED_MENU_WEAPON(playerPed)
                    BREAK
                    CASE 2
                        g_infinite_ammo = NOT g_infinite_ammo
                        SET_PED_INFINITE_AMMO(playerPed, g_infinite_ammo, WEAPONTYPE_INVALID)
                    BREAK
                    CASE 3
                        g_infinite_clip = NOT g_infinite_clip
                        SET_PED_INFINITE_AMMO_CLIP(playerPed, g_infinite_clip)
                    BREAK
                    CASE 4
                        REFILL_ALL_OWNED_WEAPONS(playerPed)
                    BREAK
                    CASE 5
                        IF HELD_WEAPON_EDITABLE()
                            g_page_item[1] = g_item
                            g_page_scroll[1] = g_scroll
                            g_weapon_upgrades_open = TRUE
                            g_item = g_weapon_upgrades_item
                            g_scroll = g_weapon_upgrades_scroll
                        ENDIF
                    BREAK
                    CASE 6
                        g_explosive_ammo = NOT g_explosive_ammo
                    BREAK
                    CASE 7
                        RELEASE_GRAVITY_GUN_ENTITY()
                        g_special_gun_mode = g_special_gun_mode + 1
                        IF g_special_gun_mode >= SPECIAL_GUN_COUNT g_special_gun_mode = 0 ENDIF
                    BREAK
                    CASE 8
                        REMOVE_WEAPON_FROM_PED(playerPed, GET_SELECTED_PED_WEAPON(playerPed))
                    BREAK
                    CASE 9
                        REMOVE_ALL_PED_WEAPONS(playerPed)
                    BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 2
            SWITCH g_item
                CASE 0
                    g_never_wanted = NOT g_never_wanted
                    IF g_never_wanted
                        SET_MAX_WANTED_LEVEL(0)
                        CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID())
                    ELSE
                        SET_MAX_WANTED_LEVEL(5)
                    ENDIF
                BREAK
                CASE 1 CLEAR_PLAYER_WANTED_LEVEL(PLAYER_ID()) BREAK
                CASE 2
                    SET_PLAYER_WANTED_LEVEL(PLAYER_ID(), g_wanted_level_choice)
                    SET_PLAYER_WANTED_LEVEL_NOW(PLAYER_ID())
                BREAK
                CASE 3
                    g_ignore_police = NOT g_ignore_police
                    SET_POLICE_IGNORE_PLAYER(PLAYER_ID(), g_ignore_police)
                BREAK
                CASE 4
                    g_dispatch = NOT g_dispatch
                    APPLY_DISPATCH_SERVICES_STATE()
                BREAK
                CASE 5
                    g_civilian_reports = NOT g_civilian_reports
                    SET_DISPATCH_COPS_FOR_PLAYER(PLAYER_ID(), g_civilian_reports)
                BREAK
            ENDSWITCH
        BREAK
        CASE 3
            IF g_spawner_open
                SWITCH g_item
                    CASE 0 START_SELECTED_VEHICLE_SPAWN() BREAK
                    CASE 2 START_ONE_SELECTED_VEHICLE_SPAWN() BREAK
                    CASE 3 OPEN_MENU_KEYBOARD(1) BREAK
                    CASE 4 g_spawn_maxed = NOT g_spawn_maxed BREAK
                    CASE 7 g_delete_previous_spawned_vehicle = NOT g_delete_previous_spawned_vehicle BREAK
                    CASE 8 DELETE_ALL_CUSTOM_CARS() BREAK
                    CASE 9 g_spawn_teleport_into_vehicle = NOT g_spawn_teleport_into_vehicle BREAK
                    CASE 10 OPEN_MENU_KEYBOARD(4) BREAK
                ENDSWITCH
            ELIF g_hydro_open
                // Hydraulics page.  Row 5 (Apply All Heights) and row 9
                // (Apply To Wheel) exist because the slider rows only move a
                // number: A on them writes it, which is what the page's own
                // instructional text says.
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELIF NOT PLAYER_CAR_HAS_HYDRO() AND g_item != 16 AND g_item != 17
                    // A car with no hydraulic mod data has nothing for any row
                    // below to write to: every hydraulics native is a silent no-op
                    // on one, which is exactly why this page appeared to do
                    // nothing with no explanation.  Refuse here instead and let
                    // row 18 (Lowrider Support) say why.
                    //
                    // Two rows stay live. 16 (Stance Softness) writes
                    // SET_REDUCED_SUSPENSION_FORCE, which is not hydraulics-
                    // specific - it is the same flag the Wheels & Tyres "Soft
                    // Suspension" row uses, and it works on any car. 17 (Reset)
                    // still has to be able to clear the menu's own state.
                    g_hydro_soft = g_wheeltyre_soft_suspension
                ELSE
                SWITCH g_item
                    CASE 0
                        g_hydro_enabled = NOT g_hydro_enabled
                        APPLY_HYDRO_KIT_STATE()
                    BREAK
                    CASE 2
                        g_hydro_control = NOT g_hydro_control
                        APPLY_HYDRO_CONTROL()
                    BREAK
                    CASE 4 APPLY_HYDRO_PRESET() BREAK
                    CASE 5 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 6 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 7 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 8 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 9 APPLY_HYDRO_HEIGHTS() BREAK
                    CASE 14 APPLY_HYDRO_WHEEL() BREAK
                    CASE 15
                        g_hydro_hold = NOT g_hydro_hold
                        IF g_hydro_hold
                            // Latch the preset the hold re-asserts, then run one
                            // pass at once so the stance is visible immediately.
                            g_hydro_hold_preset = g_hydro_preset
                            g_hydro_hold_tick = 0
                            MAINTAIN_HYDRO_HOLD()
                        ENDIF
                    BREAK
                    CASE 16
                        g_hydro_soft = NOT g_hydro_soft
                        APPLY_HYDRO_SOFTNESS()
                    BREAK
                    CASE 17 RESET_HYDRAULICS() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_interior_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 0 APPLY_INTERIOR_FILL() BREAK
                    CASE 3 APPLY_INTERIOR_SLOT() BREAK
                    CASE 7
                        APPLY_INTERIOR_COLOURS()
                    BREAK
                    CASE 8
                        APPLY_INTERIOR_COLOURS()
                    BREAK
                    CASE 10 RESET_INTERIOR_SLOTS() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_wheeltyre_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 3 APPLY_WHEEL_FAMILY() BREAK
                    CASE 4 APPLY_WHEEL_VARIATION() BREAK
                    CASE 7 APPLY_WHEEL_TYRE_SMOKE() BREAK
                    CASE 8 APPLY_TYRES_CAN_BURST() BREAK
                    CASE 9 APPLY_SOFT_SUSPENSION() BREAK
                ENDSWITCH
                ENDIF
            ELIF g_lsc_extras_open
                IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_item = 0
                    g_scroll = 0
                ELSE
                SWITCH g_item
                    CASE 3 APPLY_LIVERY() BREAK
                    CASE 7 APPLY_EXTRA_TOGGLE() BREAK
                    CASE 8 APPLY_ALL_EXTRAS(TRUE) BREAK
                    CASE 9 APPLY_ALL_EXTRAS(FALSE) BREAK
                ENDSWITCH
                ENDIF
            ELIF g_bennys_open
                // Every row on this page is an A-press spawn.  It deliberately
                // does NOT require being in a vehicle: this page is how a player
                // on foot gets into a car that can take a lowrider kit.
                APPLY_BENNYS_SPAWN()
            ELIF g_support_open
                // Read-only page: there is nothing to apply.  The branch exists
                // so a press cannot fall through into the LS Customs switch
                // below, where this page's row index would be read as an LSC row
                // (0 = Max All, 1 = Return To Stock, ...).
                g_support_item = g_item
            ELIF g_lsc_open
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    SWITCH g_item
                        CASE 0 APPLY_LSC_MAX() BREAK
                        CASE 1 APPLY_LSC_STOCK() BREAK
                        CASE 2 g_item = 3 BREAK
                        CASE 3 APPLY_LSC_MOD() BREAK
                        CASE 4
                            IF g_lsc_mod_choice < 0
                                g_lsc_mod_choice = 0
                            ELSE
                                g_lsc_mod_choice = -1
                            ENDIF
                            APPLY_LSC_MOD()
                        BREAK
                        CASE 10
                            g_lsc_turbo = NOT g_lsc_turbo
                            LSC_USE_KIT(playerVehicle)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_lsc_turbo)
                        BREAK
                        CASE 11
                            g_lsc_xenon = NOT g_lsc_xenon
                            LSC_USE_KIT(playerVehicle)
                            TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_XENON_LIGHTS, g_lsc_xenon)
                        BREAK
                        CASE 13
                            g_lsc_neon = NOT g_lsc_neon
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_FRONT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_BACK, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_LEFT, g_lsc_neon)
                            SET_VEHICLE_NEON_ENABLED(playerVehicle, NEON_RIGHT, g_lsc_neon)
                        BREAK
                        CASE 9
                            // Same range as the Left/Right selector on this row
                            // (WHEEL_FAMILY_COUNT).  The old clamp at 9 meant the
                            // three Supermod families were unreachable by A while
                            // Left/Right could still select them.
                            g_lsc_wheel_type = g_lsc_wheel_type + 1
                            IF g_lsc_wheel_type >= WHEEL_FAMILY_COUNT g_lsc_wheel_type = 0 ENDIF
                            SET_VEHICLE_WHEEL_TYPE(playerVehicle, INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
                        BREAK
                        CASE 16 APPLY_LSC_PLATE_STYLE(playerVehicle) BREAK
                        CASE 17 OPEN_MENU_KEYBOARD(9) BREAK
                        CASE 18
                            IF NOT IS_STRING_NULL_OR_EMPTY(g_plate_value)
                                SET_VEHICLE_NUMBER_PLATE_TEXT(playerVehicle, g_plate_value)
                                g_plate_value = GET_VEHICLE_NUMBER_PLATE_TEXT(playerVehicle)
                            ENDIF
                        BREAK
                        CASE 19
                            // Clear the selected slot in the kit that actually
                            // holds it, exactly like APPLY_LSC_MOD.
                            LSC_KIT_FOR_SLOT(playerVehicle, LSC_SLOT())
                            REMOVE_VEHICLE_MOD(playerVehicle, INT_TO_ENUM(MOD_TYPE, LSC_SLOT()))
                            g_lsc_mod_choice = -1
                        BREAK
                        // ---- v0.9.9 depth rows ----
                        CASE 20
                            // Mod Kit: step to the next kit the car actually has,
                            // activate it, then re-sync so every count and name on
                            // the page reflects the newly active kit at once.
                            g_lsc_kit_choice = LSC_ACTIVE_KIT(playerVehicle) + 1
                            IF g_lsc_kit_choice >= LSC_KIT_COUNT(playerVehicle) g_lsc_kit_choice = 0 ENDIF
                            LSC_USE_KIT(playerVehicle)
                            SYNC_LSC_VEHICLE_STATE()
                        BREAK
                        CASE 23
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_hydro_open = TRUE
                            g_item = g_hydro_item
                            g_scroll = g_hydro_scroll
                        BREAK
                        CASE 24
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_interior_open = TRUE
                            SYNC_INTERIOR_SLOT()
                            g_item = g_interior_item
                            g_scroll = g_interior_scroll
                        BREAK
                        CASE 25
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_wheeltyre_open = TRUE
                            // Seed the rows from this car so no row can show the
                            // state left over from the previous one.
                            SYNC_WHEELTYRE_STATE()
                            g_item = g_wheeltyre_item
                            g_scroll = g_wheeltyre_scroll
                        BREAK
                        CASE 26
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_lsc_extras_open = TRUE
                            REFRESH_EXTRA_PROBE()
                            g_item = g_lsc_extras_item
                            g_scroll = g_lsc_extras_scroll
                        BREAK
                        // ---- v0.9.9 lowrider capability rows (27-29) ----
                        CASE 27
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_bennys_open = TRUE
                            g_item = g_bennys_item
                            g_scroll = g_bennys_scroll
                        BREAK
                        // Convert To Custom starts an asynchronous conversion. It
                        // returns here immediately; the row reports the outcome.
                        CASE 28 START_VEHICLE_CONVERSION() BREAK
                        CASE 29
                            g_lsc_item = g_item
                            g_lsc_scroll = g_scroll
                            g_support_open = TRUE
                            g_item = g_support_item
                            g_scroll = g_support_scroll
                        BREAK
                    ENDSWITCH
                ELSE
                    g_lsc_open = TRUE
                ENDIF
            ELIF g_item = 0
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_spawner_open = TRUE
                g_item = g_spawner_item
                g_scroll = g_spawner_scroll
            ELIF g_item = 1
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_lsc_open = TRUE
                g_lsc_mod_choice = -1
                IF IS_PED_IN_ANY_VEHICLE(playerPed) SYNC_LSC_VEHICLE_STATE() ENDIF
                g_item = g_lsc_item
                g_scroll = g_lsc_scroll
            ELIF g_item = 2
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_page_item[3] = g_item
                    g_page_scroll[3] = g_scroll
                    g_neon_anim_open = TRUE
                    g_item = g_neon_anim_item
                    g_scroll = g_neon_anim_scroll
                ENDIF
            ELIF g_item = 3
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    g_page_item[3] = g_item
                    g_page_scroll[3] = g_scroll
                    g_vehicle_control_open = TRUE
                    SYNC_VEHICLE_DIRT_SLIDER()
                    g_item = g_vehicle_control_item
                    g_scroll = g_vehicle_control_scroll
                ENDIF
            ELIF g_item = 7
                g_vehicle_always_max = NOT g_vehicle_always_max
            ELIF g_item = 14
                // Toggle only. Pressing the row used to flip the flag AND
                // immediately warp the player out of (or into) the nearest
                // vehicle, which is not what the label says and yanked the
                // player out of the car they were already driving. The ON/OFF
                // state now only arms PROCESS_QUICK_VEHICLE_ENTRY_EXIT, and
                // that feature does the entering and exiting from game input,
                // and only while the menu is closed.
                g_vehicle_quick_entry_exit = NOT g_vehicle_quick_entry_exit
            ELIF g_item = 15
                // Row 15 "Enter Personal Vehicle" (row 14 before the Vehicle
                // Control entry was inserted at row 3). This branch was a
                // duplicate "ELIF g_item = 13", so the row did nothing and
                // WARP_INTO_LAST_PLAYER_VEHICLE() was unreachable.
                WARP_INTO_LAST_PLAYER_VEHICLE()
            ELIF g_item = 6
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    APPLY_LSC_MAX_TO_VEHICLE(GET_VEHICLE_PED_IS_IN(playerPed))
                ENDIF
            ELIF g_item = 23
                g_vehicle_speedometer = NOT g_vehicle_speedometer
            ELIF g_item = 24
                g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
            ELIF g_item = 25
                // Chauffeur: opens its own submenu.  Same save/restore shape as
                // every other entry row - g_page_item[3] keeps this row's index
                // so B lands back on it.
                g_page_item[3] = g_item
                g_page_scroll[3] = g_scroll
                g_chauffeur_open = TRUE
                g_item = g_chauffeur_item
                g_scroll = g_chauffeur_scroll
            ELIF g_item = 26
                TOGGLE_CRUISE_CONTROL()
            ELIF g_item = 27
                TOGGLE_SIREN_MUTE_ENABLED()
            ELIF g_item = 16
                BRING_PERSONAL_VEHICLE()
            ELIF g_item = 17
                g_vehicle_horn_boost = NOT g_vehicle_horn_boost
            ELIF g_item = 18
                g_vehicle_auto_repair = NOT g_vehicle_auto_repair
            ELIF g_item = 19
                OPEN_PLANE_CARGO_DOORS()
            ELIF g_item = 20
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    g_doors_locked = NOT g_doors_locked
                    IF g_doors_locked
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_LOCKED)
                    ELSE
                        SET_VEHICLE_DOORS_LOCKED(playerVehicle, VEHICLELOCK_UNLOCKED)
                    ENDIF
                ENDIF
            ELIF g_item = 21
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                    g_seatbelt = NOT g_seatbelt
                    IF g_seatbelt
                        SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_NEVER)
                        SET_PED_CAN_BE_DRAGGED_OUT(playerPed, FALSE)
                        SET_PED_CAN_RAGDOLL(playerPed, FALSE)
                        SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(playerPed, FALSE)
                        SET_PED_CONFIG_FLAG(playerPed, PCF_WillFlyThroughWindscreen, FALSE)
                    ELSE
                        SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(playerPed, KNOCKOFFVEHICLE_DEFAULT)
                        SET_PED_CAN_BE_DRAGGED_OUT(playerPed, TRUE)
                        IF NOT g_no_ragdoll SET_PED_CAN_RAGDOLL(playerPed, TRUE) ENDIF
                        SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(playerPed, TRUE)
                        SET_PED_CONFIG_FLAG(playerPed, PCF_WillFlyThroughWindscreen, TRUE)
                    ENDIF
                ENDIF
            ELIF g_item = 22
                IF IS_PED_IN_ANY_VEHICLE(playerPed)
                    SET_VEHICLE_ENGINE_HEALTH(GET_VEHICLE_PED_IS_IN(playerPed), -4000.0)
                ENDIF
            ELIF IS_PED_IN_ANY_VEHICLE(playerPed)
                playerVehicle = GET_VEHICLE_PED_IS_IN(playerPed)
                SWITCH g_item
                    CASE 4
                        g_vehicle_god = NOT g_vehicle_god
                        APPLY_VEHICLE_GOD_STATE(playerVehicle, g_vehicle_god)
                    BREAK
                    CASE 5
                        SET_VEHICLE_FIXED(playerVehicle)
                        SET_VEHICLE_ENGINE_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_PETROL_TANK_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_BODY_HEALTH(playerVehicle, 1000.0)
                        SET_VEHICLE_UNDRIVEABLE(playerVehicle, FALSE)
                    BREAK
                    CASE 13 SET_VEHICLE_ON_GROUND_PROPERLY(playerVehicle) BREAK
                    CASE 8 BREAK
                    CASE 9 BREAK
                    CASE 10
                        g_godmode_tow_hook = NOT g_godmode_tow_hook
                        IF NOT g_godmode_tow_hook
                            g_tow_hook_towed = NULL
                        ENDIF
                    BREAK
                    CASE 12 g_vehicle_bulletproof_tyres = NOT g_vehicle_bulletproof_tyres BREAK
                    CASE 11
                        g_vehicle_turbo = NOT g_vehicle_turbo
                        LSC_USE_KIT(playerVehicle)
                        TOGGLE_VEHICLE_MOD(playerVehicle, MOD_TOGGLE_TURBO, g_vehicle_turbo)
                    BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 4
            IF g_timeweather_open
                SWITCH g_item
                    CASE 0 APPLY_TIME_CHOICE() BREAK
                    CASE 1 APPLY_EDITABLE_TIME() BREAK
                    CASE 2 APPLY_EDITABLE_TIME() BREAK
                    CASE 3 APPLY_EDITABLE_TIME() BREAK
                    CASE 4
                        g_pause_time = NOT g_pause_time
                        PAUSE_CLOCK(g_pause_time)
                    BREAK
                    CASE 5 APPLY_WEATHER_CHOICE() BREAK
                ENDSWITCH
            ELIF g_mayhem_open
                SWITCH g_item
                    CASE 0
                        g_blackout = NOT g_blackout
                        APPLY_BLACKOUT_STATE()
                    BREAK
                    CASE 1
                        g_meteor_shower = NOT g_meteor_shower
                        g_next_meteor_ms = 0
                    BREAK
                    CASE 2
                        g_riot_mode = NOT g_riot_mode
                        g_next_riot_ms = 0
                        IF NOT g_riot_mode
                            STOP_ARMED_PED_RIOT()
                        ENDIF
                    BREAK
                    CASE 3
                        g_crazy_drivers = NOT g_crazy_drivers
                        g_next_crazy_drivers_ms = 0
                    BREAK
                ENDSWITCH
            ELSE
            SWITCH g_item
                CASE 0
                    g_page_item[4] = g_item
                    g_page_scroll[4] = g_scroll
                    g_timeweather_open = TRUE
                    g_item = g_timeweather_item
                    g_scroll = g_timeweather_scroll
                BREAK
                CASE 1
                    g_night_vision = NOT g_night_vision
                    SET_NIGHTVISION(g_night_vision)
                BREAK
                CASE 2
                    g_thermal_vision = NOT g_thermal_vision
                    SET_SEETHROUGH(g_thermal_vision)
                BREAK
                CASE 4 APPLY_TIME_SCALE() BREAK
                CASE 5 APPLY_GRAVITY_CHOICE() BREAK
                CASE 11
                    g_motion_blur = NOT g_motion_blur
                    IF g_motion_blur
                        SET_TIMECYCLE_MODIFIER("scanline_cam_cheap")
                    ELSE
                        CLEAR_TIMECYCLE_MODIFIER()
                    ENDIF
                BREAK
                CASE 12
                    g_camera_shake = NOT g_camera_shake
                    IF g_camera_shake
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.5)
                    ELIF g_drunk
                        SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.30)
                    ELSE
                        STOP_GAMEPLAY_CAM_SHAKING(TRUE)
                    ENDIF
                BREAK
                CASE 6 APPLY_IPL_PRESET(TRUE) BREAK
                CASE 7 APPLY_IPL_PRESET(FALSE) BREAK
                CASE 8 OPEN_MENU_KEYBOARD(8) BREAK
                CASE 9 LOAD_CUSTOM_IPL() BREAK
                CASE 10 UNLOAD_CUSTOM_IPL() BREAK
                CASE 13 g_touch_opens_doors = NOT g_touch_opens_doors BREAK
                CASE 14 START_DOOR_SCAN(0) BREAK
                CASE 15 START_DOOR_SCAN(1) BREAK
                CASE 16
                    g_page_item[4] = g_item
                    g_page_scroll[4] = g_scroll
                    g_mayhem_open = TRUE
                    g_item = g_mayhem_item
                    g_scroll = g_mayhem_scroll
                BREAK
            ENDSWITCH
            ENDIF
        BREAK
        CASE 5
            IF g_tp_stores_open
                SWITCH g_item
                    CASE 0 TELEPORT_PLAYER_FAST(<<-711.82, -915.91, 18.24>>) BREAK
                    CASE 1 TELEPORT_PLAYER_FAST(<<-52.72, -1756.17, 28.44>>) BREAK
                    CASE 2 TELEPORT_PLAYER_FAST(<<1159.44, -325.67, 68.23>>) BREAK
                    CASE 3 TELEPORT_PLAYER_FAST(<<1699.43, 4928.64, 41.09>>) BREAK
                    CASE 4 TELEPORT_PLAYER_FAST(<<-1822.93, 788.95, 137.21>>) BREAK
                    CASE 5 TELEPORT_PLAYER_FAST(<<1166.43, 2703.53, 37.16>>) BREAK
                    CASE 6 TELEPORT_PLAYER_FAST(<<-2973.41, 390.69, 14.04>>) BREAK
                    CASE 7 TELEPORT_PLAYER_FAST(<<-1225.86, -903.58, 11.33>>) BREAK
                    CASE 8 TELEPORT_PLAYER_FAST(<<1140.66, -981.08, 45.42>>) BREAK
                    CASE 9 TELEPORT_PLAYER_FAST(<<-1490.28, -382.85, 39.16>>) BREAK
                    CASE 10 TELEPORT_PLAYER_FAST(<<-3240.72, 1004.51, 11.85>>) BREAK
                    CASE 11 TELEPORT_PLAYER_FAST(<<-3039.25, 589.38, 6.93>>) BREAK
                    CASE 12 TELEPORT_PLAYER_FAST(<<544.43, 2672.06, 41.17>>) BREAK
                    CASE 13 TELEPORT_PLAYER_FAST(<<2558.75, 385.60, 107.64>>) BREAK
                    CASE 14 TELEPORT_PLAYER_FAST(<<2681.51, 3282.76, 54.26>>) BREAK
                    CASE 15 TELEPORT_PLAYER_FAST(<<1731.15, 6411.63, 34.04>>) BREAK
                    CASE 16 TELEPORT_PLAYER_FAST(<<1964.93, 3741.21, 31.36>>) BREAK
                    CASE 17 TELEPORT_PLAYER_FAST(<<29.07, -1348.77, 28.51>>) BREAK
                    CASE 18 TELEPORT_PLAYER_FAST(<<376.85, 323.98, 102.58>>) BREAK
                ENDSWITCH
            ELIF g_tp_locs_open
                SWITCH g_item
                    CASE 0 TELEPORT_PLAYER_FAST(<<501.7, 5604.4, 797.9>>) BREAK
                    CASE 1 TELEPORT_PLAYER_FAST(<<-75.0, -818.9, 326.2>>) BREAK
                    CASE 2 TELEPORT_PLAYER_FAST(<<-1034.6, -2733.6, 20.2>>) BREAK
                    CASE 3 TELEPORT_PLAYER_FAST(<<711.7, 1198.8, 348.5>>) BREAK
                    CASE 4 TELEPORT_PLAYER_FAST(<<-2047.4, 3132.1, 32.8>>) BREAK
                    CASE 5 TELEPORT_PLAYER_FAST(<<102.9, -1939.7, 20.8>>) BREAK
                    CASE 6 TELEPORT_PLAYER_FAST(<<-14.4, -1438.0, 31.1>>) BREAK
                    CASE 7 TELEPORT_PLAYER_FAST(<<-852.4, 160.0, 65.6>>) BREAK
                    CASE 8
                        PREPARE_TELEPORT_IPL(11)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<1975.5, 3819.6, 33.4>>)
                    BREAK
                    CASE 9 TELEPORT_PLAYER_FAST(<<1274.8, -1710.0, 54.8>>) BREAK
                    CASE 10 TELEPORT_PLAYER_FAST(<<-47.1, -1112.3, 26.4>>) BREAK
                    // Rows 11..34. These were previously numbered 15..38 (a
                    // four-case hole sat at 11..14), so the bottom half of the
                    // Locations list launched the wrong destination and the
                    // Hospital / Police Station / Ammu-Nation / LS Customs rows
                    // did nothing at all. Numbers now match DRAW_TP_LOCATION_ROW
                    // and the description table; only the labels changed.
                    CASE 11
                        PREPARE_TELEPORT_IPL(14)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<-449.7, -340.7, 34.5>>)
                    BREAK
                    CASE 12 TELEPORT_PLAYER_FAST(<<425.1, -979.5, 30.7>>) BREAK
                    CASE 13 TELEPORT_PLAYER_FAST(<<-662.1, -948.5, 21.5>>) BREAK
                    CASE 14 TELEPORT_PLAYER_FAST(<<-365.4, -131.4, 37.9>>) BREAK
                    CASE 15 TELEPORT_TO_NORTH_YANKTON() BREAK
                    CASE 16 TELEPORT_TO_CAYO_PERICO() BREAK
                    CASE 17 TELEPORT_PLAYER_FAST(<<1692.0, 3291.0, 41.0>>) BREAK
                    CASE 18 TELEPORT_PLAYER_FAST(<<-438.0, 1076.0, 327.0>>) BREAK
                    CASE 19 TELEPORT_PLAYER_FAST(<<-1170.0, 4927.0, 224.0>>) BREAK
                    CASE 20
                        PREPARE_TELEPORT_IPL(28)
                        TELEPORT_PLAYER_FAST(<<1110.0, 220.0, -49.0>>)
                    BREAK
                    CASE 21 TELEPORT_PLAYER_FAST(<<3615.2, 3744.7, 28.7>>) BREAK
                    CASE 22 TELEPORT_PLAYER_FAST(<<1690.0, 2565.0, 45.6>>) BREAK
                    CASE 23 TELEPORT_PLAYER_FAST(<<-119.0, 6455.0, 31.4>>) BREAK
                    CASE 24
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4439.0, -4458.0, 4.2>>) ENDIF
                    BREAK
                    CASE 25
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4964.0, -5164.0, 0.2>>) ENDIF
                    BREAK
                    CASE 26
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<5040.0, -5784.0, 17.8>>) ENDIF
                    BREAK
                    CASE 27
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4990.0, -5710.0, 19.9>>) ENDIF
                    BREAK
                    CASE 28
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4902.0, -4929.0, 3.3>>) ENDIF
                    BREAK
                    CASE 29
                        IF PREPARE_CAYO_PERICO() TELEPORT_PLAYER_WITH_VEHICLE(<<4441.0, -4440.0, 8.2>>) ENDIF
                    BREAK
                    CASE 30 TELEPORT_PLAYER_FAST(<<-424.2, -1685.8, 19.0>>) BREAK
                    CASE 31 TELEPORT_PLAYER_FAST(<<-81.1, -1395.3, 29.3>>) BREAK
                    CASE 32
                        PREPARE_TELEPORT_IPL(40)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<848.7, 3004.0, 45.6>>)
                    BREAK
                    CASE 33 TELEPORT_PLAYER_FAST(<<-1163.2, -2866.0, 13.9>>) BREAK
                    CASE 34
                        PREPARE_TELEPORT_IPL(42)
                        TELEPORT_PLAYER_WITH_VEHICLE(<<-2023.0, -1038.0, 5.0>>)
                    BREAK
                ENDSWITCH
            ELSE
                SWITCH g_item
                    CASE 0 TELEPORT_TO_WAYPOINT() BREAK
                    CASE 1 g_auto_waypoint = NOT g_auto_waypoint BREAK
                    CASE 2
                        g_page_item[5] = g_item
                        g_page_scroll[5] = g_scroll
                        g_tp_stores_open = TRUE
                        g_item = g_tp_stores_item
                        g_scroll = g_tp_stores_scroll
                    BREAK
                    CASE 3 TELEPORT_TO_OBJECTIVE() BREAK
                    CASE 4
                        g_auto_objective = NOT g_auto_objective
                        IF NOT g_auto_objective
                            g_auto_objective_was_in_cutscene = FALSE
                            g_auto_objective_pending = FALSE
                        ENDIF
                    BREAK
                    CASE 5
                        g_page_item[5] = g_item
                        g_page_scroll[5] = g_scroll
                        g_tp_locs_open = TRUE
                        g_item = g_tp_locs_item
                        g_scroll = g_tp_locs_scroll
                    BREAK
                    // Row 6 is drawn as "Nudge Forward" and row 7 as "Nudge
                    // Backward". NUDGE_PLAYER_BY_OFFSET rotates the offset onto
                    // the entity's forward vector, so +y is forward and these two
                    // were swapped (Forward travelled backwards).
                    CASE 6 NUDGE_PLAYER_BY_OFFSET(<<0.0, 1.0, 0.0>>) BREAK
                    CASE 7 NUDGE_PLAYER_BY_OFFSET(<<0.0, -1.0, 0.0>>) BREAK
                    CASE 8 NUDGE_PLAYER_BY_OFFSET(<<0.0, 0.0, 1.0>>) BREAK
                    CASE 9 NUDGE_PLAYER_BY_OFFSET(<<0.0, 0.0, -1.0>>) BREAK
                    CASE 10 OPEN_MENU_KEYBOARD(5) BREAK
                    CASE 11 OPEN_MENU_KEYBOARD(6) BREAK
                    CASE 12 OPEN_MENU_KEYBOARD(7) BREAK
                    CASE 13 TELEPORT_TO_ENTERED_COORDS() BREAK
                ENDSWITCH
            ENDIF
        BREAK
        CASE 6
            SWITCH g_item
                CASE 0 g_skip_cutscenes = NOT g_skip_cutscenes BREAK
                CASE 1 REFRESH_STREAMED_ASSETS() BREAK
                CASE 2
                    g_npc_brawl = NOT g_npc_brawl
                    IF g_npc_brawl
                        g_everyone_ignores = FALSE
                        TASK_NEARBY_NPCS_TO_BRAWL()
                        g_next_npc_brawl_update = GET_GAME_TIMER() + 3000
                    ELSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 3
                    g_everyone_ignores = NOT g_everyone_ignores
                    IF g_everyone_ignores AND g_npc_brawl
                        g_npc_brawl = FALSE
                        STOP_NPC_BRAWL()
                    ENDIF
                BREAK
                CASE 4 g_low_population = NOT g_low_population BREAK
                CASE 5 APPLY_NPC_DENSITY() BREAK
                CASE 6
                    CLEAR_AREA_OF_VEHICLES(GET_ENTITY_COORDS(playerPed), 50.0)
                    // The native has no flag to spare script vehicles, so tracked
                    // cars inside the radius are gone.  Drop the dead handles, keep
                    // the ones still parked outside it.
                    PRUNE_SPAWNED_VEHICLE_TRACKING()
                BREAK
                CASE 7
                    CLEAR_AREA_OF_PEDS(GET_ENTITY_COORDS(playerPed), 50.0)
                    CLEAR_MENU_ATTACKERS()
                    // Same reason for the guard and brawler arrays, which the
                    // native cannot spare either.
                    PRUNE_MENU_PED_TRACKING()
                    // Spawn Stripper peds are deleted outright rather than
                    // pruned: the row exists to clear them, and leaving ones
                    // that spawned outside the radius would be surprising.
                    CLEAR_STRIPPER_PEDS()
                BREAK
                CASE 8 EXPLODE_ALL_NEARBY_VEHICLES() BREAK
                CASE 9
                    g_first_person = NOT g_first_person
                    IF NOT g_first_person g_player_freecam = FALSE ENDIF
                BREAK
                CASE 10 g_hud_hidden = NOT g_hud_hidden BREAK
                CASE 11 g_radar_hidden = NOT g_radar_hidden BREAK
                CASE 12 START_STRIPPER_SPAWN() BREAK
                CASE 13
                    g_show_live_coords = NOT g_show_live_coords
                    IF g_show_live_coords
                        g_live_coords_pos = GET_ENTITY_COORDS(playerPed)
                        g_live_coords_next_update = GET_GAME_TIMER() + LIVE_COORDS_UPDATE_MS
                    ENDIF
                BREAK
            ENDSWITCH
        BREAK
        CASE 7
            IF g_language_open
                IF g_item >= 0 AND g_item < LANGUAGE_MENU_ROWS
                    g_menu_language = g_item
                    PERSIST_SAVE_LANGUAGE_NOW()
                ENDIF
            ELIF g_spooner_open
                SWITCH g_item
                    CASE 0
                        g_spooner_use_custom_preview = FALSE
                        QUEUE_SPOONER_OBJECT_SPAWN(SPOONER_CATALOG_MODEL(g_spooner_catalog_index))
                    BREAK
                    CASE 1 OPEN_MENU_KEYBOARD(14) BREAK
                    CASE 2
                        g_spooner_use_custom_preview = FALSE
                        QUEUE_SPOONER_OBJECT_SPAWN(SPOONER_CATALOG_MODEL(g_spooner_catalog_index))
                    BREAK
                    CASE 3
                        IF g_spooner_preview_opacity != 100
                            g_spooner_preview_opacity = 100
                        ELSE
                            g_spooner_preview_opacity = 80
                        ENDIF
                        APPLY_SPOONER_PREVIEW_OPACITY()
                    BREAK
                    CASE 4 APPLY_SPOONER_OFFSET_TO_SELECTED() BREAK
                    CASE 5
                        g_spooner_forward_offset = 2.50
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 6
                        g_spooner_side_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 7
                        g_spooner_height_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 8
                        g_spooner_heading_offset = 0.00
                        APPLY_SPOONER_OFFSET_TO_SELECTED()
                    BREAK
                    CASE 9 TOGGLE_SPOONER_FREEZE_POSITION() BREAK
                    CASE 10 TOGGLE_SPOONER_COLLISION() BREAK
                    CASE 11 SET_PLAYER_FREECAM_ENABLED(NOT g_player_freecam) BREAK
                    CASE 12 SNAP_SPOONER_OBJECT_TO_GROUND() BREAK
                    CASE 13 APPLY_SPOONER_ATTACHMENT(TRUE) BREAK
                    CASE 14
                        g_spooner_attach_x = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 15
                        g_spooner_attach_y = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 16
                        g_spooner_attach_z = 0.00
                        IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                            APPLY_SPOONER_ATTACHMENT(TRUE)
                        ENDIF
                    BREAK
                    CASE 17
                        g_spooner_rot_axis = g_spooner_rot_axis + 1
                        IF g_spooner_rot_axis > 2 g_spooner_rot_axis = 0 ENDIF
                    BREAK
                    CASE 18 APPLY_SPOONER_ATTACHMENT(FALSE) BREAK
                    CASE 19 DELETE_SPOONER_LAST_OBJECT() BREAK
                    CASE 20 CLEAR_ALL_SPOONER_OBJECTS() BREAK
                ENDSWITCH
            ELIF g_nsc_unload_open
                HANDLE_NSC_UNLOAD_APPLY()
            ELIF g_nsc_loader_open
                IF g_item = 0
                    OPEN_MENU_KEYBOARD(15)
                ELIF g_item = 1
                    g_nsc_stack_choice = g_nsc_stack_choice + 1
                    IF g_nsc_stack_choice > 2 g_nsc_stack_choice = 0 ENDIF
                ELIF g_item = 2
                    STOP_ALL_CUSTOM_NSC_SCRIPTS()
                ELIF COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS() > 0 AND g_item = 3
                    g_nsc_loader_item = g_item
                    g_nsc_loader_scroll = g_scroll
                    g_nsc_unload_open = TRUE
                    IF g_nsc_unload_item >= COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
                        g_nsc_unload_item = COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS() - 1
                    ENDIF
                    IF g_nsc_unload_item < 0 g_nsc_unload_item = 0 ENDIF
                    g_item = g_nsc_unload_item
                    g_scroll = g_nsc_unload_scroll
                ELSE
                    IF g_nsc_discovered_count > 0
                        IF g_item >= NSC_LOADER_HEADER_ROWS()
                            TRIGGER_LOAD_OR_RELOAD_CUSTOM_NSC(g_item - NSC_LOADER_HEADER_ROWS())
                        ENDIF
                    ELSE
                        OPEN_MENU_KEYBOARD(15)
                    ENDIF
                ENDIF
            ELIF g_plugin_mgr_open
                HANDLE_PLUGIN_MGR_APPLY(g_item)
            ELIF g_credits_open
                // Read-only Credits submenu: options are not interactable.
            ELIF g_persist_open
                PERSIST_HANDLE_ROW(g_item)
            ELSE
                IF g_item = 0
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_language_open = TRUE
                    g_item = g_language_item
                    g_scroll = g_language_scroll
                ELIF g_item = 1
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_spooner_open = TRUE
                    g_item = g_spooner_item
                    g_scroll = g_spooner_scroll
                    SYNC_SPOONER_UI_FROM_SELECTED()
                    SYNC_SPOONER_PREVIEW_MODEL()
                ELIF g_item = 2
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_nsc_loader_open = TRUE
                    SYNC_CUSTOM_NSC_THREAD_STATES()
                    IF g_nsc_loader_item > NSC_LOADER_TOTAL_ROWS() - 1 g_nsc_loader_item = NSC_LOADER_TOTAL_ROWS() - 1 ENDIF
                    IF g_nsc_loader_item < 0 g_nsc_loader_item = 0 ENDIF
                    g_item = g_nsc_loader_item
                    g_scroll = g_nsc_loader_scroll
                ELIF g_item = 3
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_plugin_mgr_open = TRUE
                    g_plugin_mgr_detail_open = FALSE
                    g_plugin_mgr_next_sync = 0
                    SYNC_PLUGIN_MGR_LIST()
                    IF g_plugin_mgr_item > PLUGIN_MGR_TOTAL_ROWS() - 1 g_plugin_mgr_item = PLUGIN_MGR_TOTAL_ROWS() - 1 ENDIF
                    IF g_plugin_mgr_item < 0 g_plugin_mgr_item = 0 ENDIF
                    g_item = g_plugin_mgr_item
                    g_scroll = g_plugin_mgr_scroll
                ELIF (g_item = 10 AND g_accent_choice != 14) OR (g_item = 11 AND g_accent_choice = 14)
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_persist_open = TRUE
                    g_item = g_persist_item
                    g_scroll = g_persist_scroll
                ELIF (g_item = 11 AND g_accent_choice != 14) OR (g_item = 12 AND g_accent_choice = 14)
                    g_page_item[7] = g_item
                    g_page_scroll[7] = g_scroll
                    g_credits_open = TRUE
                    g_item = g_credits_item
                    g_scroll = g_credits_scroll
                ELIF (g_item = 6 AND g_accent_choice != 14) OR (g_item = 7 AND g_accent_choice = 14)
                    g_respawn_at_death = NOT g_respawn_at_death
                ENDIF
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

// PAGE_COUNT() used to live here (an unused "RETURN 8" helper). Removed: the
// page total now comes from ACTIVE_ITEM_COUNT()/DRAW_PAGE_COUNTER().

PROC DRAW_PLAYER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Portable Radio", "Radio portátil", "随身电台", "Tragbares Radio", "ポータブルラジオ", "Портативное радио", "Rádio Portátil", "Radio portable"), "OPEN", g_item = index, 2) BREAK
        CASE 1 IF g_god DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, TR("Heal + Armour", "Curar + Blindaje", "恢复生命与护甲", "Heilen + Schutzweste", "回復 + アーマー", "Здоровье и броня", "Vida + Colete", "Soin + Armure"), "APPLY", g_item = index, 2) BREAK
        CASE 3 IF g_invisible DRAW_OPTION(y, TR("Invisible Player", "Jugador invisible", "玩家隐身", "Unsichtbarer Spieler", "透明化", "Невидимость", "Jogador Invisível", "Joueur invisible"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Invisible Player", "Jugador invisible", "玩家隐身", "Unsichtbarer Spieler", "透明化", "Невидимость", "Jogador Invisível", "Joueur invisible"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 DRAW_OPTION(y, TR("PED Changer", "Cambiador de PED", "人物模型更换", "PED-Wechsler", "PEDチェンジャー", "Смена модели PED", "Trocar PED", "Changeur de PED"), "OPEN", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Outfit Customization", "Personalizar atuendo", "服装自定义", "Outfit-Anpassung", "コスチューム変更", "Настройка одежды", "Personalizar Traje", "Personnalisation tenue"), "OPEN", g_item = index, 2) BREAK
        // Row 6 used to be "Stat Manager". Removed in this build: on this port
        // only the Special ability key accepted a write, so seven of the eight
        // stats could never be set. Rows below shifted up by one and the Auto
        // Save rows moved from 25/26 to 24/25.
        CASE 6 DRAW_OPTION(y, TR("Bodyguards", "Guardaespaldas", "保镖", "Leibwächter", "ボディガード", "Телохранители", "Guarda-costas", "Gardes du corps"), "OPEN", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Attacker", "Atacante", "袭击者", "Angreifer", "アタッカー", "Нападающие", "Atacante", "Assaillant"), "OPEN", g_item = index, 2) BREAK
        CASE 8 IF g_player_noclip DRAW_OPTION(y, TR("Player No-Clip", "No-Clip de jugador", "玩家穿墙 (No-Clip)", "Spieler No-Clip", "ノークリップ", "Ноуклип игрока", "No-Clip do Jogador", "No-Clip joueur"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Player No-Clip", "No-Clip de jugador", "玩家穿墙 (No-Clip)", "Spieler No-Clip", "ノークリップ", "Ноуклип игрока", "No-Clip do Jogador", "No-Clip joueur"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 9 IF g_player_freecam DRAW_OPTION(y, TR("Free Cam", "Cámara libre", "自由视角", "Freie Kamera", "フリーカメラ", "Свободная камера", "Câmera Livre", "Caméra libre"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Free Cam", "Cámara libre", "自由视角", "Freie Kamera", "フリーカメラ", "Свободная камера", "Câmera Livre", "Caméra libre"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_unlimited_oxygen DRAW_OPTION(y, TR("Unlimited Oxygen", "Oxígeno ilimitado", "无限氧气", "Unbegrenzt Sauerstoff", "酸素無限", "Бесконечный кислород", "Oxigênio Ilimitado", "Oxygène illimité"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Unlimited Oxygen", "Oxígeno ilimitado", "无限氧气", "Unbegrenzt Sauerstoff", "酸素無限", "Бесконечный кислород", "Oxigênio Ilimitado", "Oxygène illimité"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_unlimited_ability DRAW_OPTION(y, TR("Unlimited Ability", "Habilidad ilimitada", "无限特殊能力", "Unbegrenzte Spezialfähigkeit", "特殊スキル無限", "Бесконечная способность", "Habilidade Ilimitada", "Compétence illimitée"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Unlimited Ability", "Habilidad ilimitada", "无限特殊能力", "Unbegrenzte Spezialfähigkeit", "特殊スキル無限", "Бесконечная способность", "Habilidade Ilimitada", "Compétence illimitée"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_fast_run DRAW_OPTION(y, TR("Fast Run", "Correr rápido", "快速奔跑", "Schnelles Laufen", "高速ラン", "Быстрый бег", "Corrida Rápida", "Course rapide"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Fast Run", "Correr rápido", "快速奔跑", "Schnelles Laufen", "高速ラン", "Быстрый бег", "Corrida Rápida", "Course rapide"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 IF g_fast_swim DRAW_OPTION(y, TR("Fast Swim", "Nadar rápido", "快速游泳", "Schnelles Schwimmen", "高速スイム", "Быстрое плавание", "Nado Rápido", "Nage rapide"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Fast Swim", "Nadar rápido", "快速游泳", "Schnelles Schwimmen", "高速スイム", "Быстрое плавание", "Nado Rápido", "Nage rapide"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 14 IF g_super_jump DRAW_OPTION(y, TR("Super Jump", "Súper salto", "超级跳跃", "Supersprung", "スーパージャンプ", "Суперпрыжок", "Super Pulo", "Super saut"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Super Jump", "Súper salto", "超级跳跃", "Supersprung", "スーパージャンプ", "Суперпрыжок", "Super Pulo", "Super saut"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 IF g_no_ragdoll DRAW_OPTION(y, TR("Disable Ragdoll", "Desactivar ragdoll", "防摔倒 (无布娃娃)", "Ragdoll deaktivieren", "ラグドール無効", "Отключить рэгдолл", "Desativar Ragdoll", "Désactiver ragdoll"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Disable Ragdoll", "Desactivar ragdoll", "防摔倒 (无布娃娃)", "Ragdoll deaktivieren", "ラグドール無効", "Отключить рэгдолл", "Desativar Ragdoll", "Désactiver ragdoll"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 16 IF g_infinite_parachute DRAW_OPTION(y, TR("Infinite Parachute", "Paracaídas infinito", "无限降落伞", "Unendlich Fallschirme", "無限パラシュート", "Бесконечный парашют", "Paraquedas Infinito", "Parachute infini"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Infinite Parachute", "Paracaídas infinito", "无限降落伞", "Unendlich Fallschirme", "無限パラシュート", "Бесконечный парашют", "Paraquedas Infinito", "Parachute infini"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 17 DRAW_NUMBER_OPTION(y, TR("Cash Balance", "Saldo de dinero", "现金数额", "Kontostand", "所持金", "Сумма денег", "Saldo de Dinheiro", "Solde d'argent"), g_cash_amount, g_item = index) BREAK
        CASE 18 DRAW_OPTION(y, TR("Apply Cash Balance", "Aplicar saldo de dinero", "应用现金数额", "Kontostand anwenden", "所持金を適用", "Применить деньги", "Aplicar Dinheiro", "Appliquer l'argent"), "APPLY", g_item = index, 2) BREAK
        CASE 19 IF g_explosive_melee DRAW_OPTION(y, TR("Explosive Melee", "Cuerpo a cuerpo explosivo", "爆炸近战", "Explosiver Nahkampf", "爆発格闘", "Взрывной ближний бой", "Corpo a Corpo Explosivo", "Mêlée explosive"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Explosive Melee", "Cuerpo a cuerpo explosivo", "爆炸近战", "Explosiver Nahkampf", "爆発格闘", "Взрывной ближний бой", "Corpo a Corpo Explosivo", "Mêlée explosive"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 20 IF g_super_punch DRAW_OPTION(y, TR("Super Punch", "Súper puñetazo", "超级重拳", "Superschlag", "スーパーパンチ", "Суперудар", "Super Soco", "Super coup de poing"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Super Punch", "Súper puñetazo", "超级重拳", "Superschlag", "スーパーパンチ", "Суперудар", "Super Soco", "Super coup de poing"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 IF g_drunk DRAW_OPTION(y, TR("Drunk Mode", "Modo borracho", "醉酒模式", "Betrunkener Modus", "泥酔モード", "Пьяный режим", "Modo Bêbado", "Mode ivre"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Drunk Mode", "Modo borracho", "醉酒模式", "Betrunkener Modus", "泥酔モード", "Пьяный режим", "Modo Bêbado", "Mode ivre"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 22 DRAW_OPTION(y, TR("Clear Damage / Blood", "Limpiar daño / sangre", "清除伤痕与血迹", "Schaden / Blut entfernen", "傷・血痕を消去", "Очистить кровь и раны", "Limpar Dano / Sangue", "Nettoyer dégâts / sang"), "APPLY", g_item = index, 2) BREAK
        CASE 23 DRAW_OPTION(y, TR("Suicide", "Suicidio", "自杀", "Selbstmord", "自殺", "Самоубийство", "Suicídio", "Suicide"), "APPLY", g_item = index, 0) BREAK
        CASE 24 IF g_auto_save DRAW_OPTION(y, TR("Auto Save", "Autoguardado", "自动保存", "Automatisches Speichern", "オートセーブ", "Автосохранение", "Salvamento Automático", "Sauvegarde auto"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Auto Save", "Autoguardado", "自动保存", "Automatisches Speichern", "オートセーブ", "Автосохранение", "Salvamento Automático", "Sauvegarde auto"), "OFF", g_item = index, 0) ENDIF BREAK
        // Row 25 only exists while Auto Save is ON (see ITEM_COUNT), exactly
        // like the RGB transition-speed row in Menu Settings.
        CASE 25 DRAW_NUMBER_OPTION(y, TR("Auto Save Interval", "Intervalo de autoguardado", "自动保存间隔", "Speicherintervall", "オートセーブ間隔", "Интервал автосохранения", "Intervalo de Salvamento", "Intervalle de sauvegarde"), g_auto_save_interval, g_item = index) BREAK
    ENDSWITCH
ENDPROC

// DRAW_STAT_LEVEL_ROW, DRAW_STATMAN_ROW and DRAW_STATMAN_PAGE used to live here.
// Removed with the Stat Manager submenu.

PROC DRAW_NPC_DENSITY_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("NPC Density:", "Densidad de NPC:", "NPC 密度:", "NPC-Dichte:", "NPC密度:", "Плотность NPC:", "Densidade de NPCs:", "Densité des PNJ :")
    IF g_npc_density_choice = 0 DRAW_OPTION(y, lbl, "< 0.25x >", selected, 3) ENDIF
    IF g_npc_density_choice = 1 DRAW_OPTION(y, lbl, "< 0.5x >", selected, 3) ENDIF
    IF g_npc_density_choice = 2 DRAW_OPTION(y, lbl, "< 1x >", selected, 3) ENDIF
    IF g_npc_density_choice = 3 DRAW_OPTION(y, lbl, "< 2x >", selected, 3) ENDIF
    IF g_npc_density_choice = 4 DRAW_OPTION(y, lbl, "< 4x >", selected, 3) ENDIF
ENDPROC

PROC DRAW_MENU_COMBO_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Menu Combo:", "Combo del menú:", "菜单快捷键:", "Menü-Kombo:", "メニュー開閉コンボ:", "Комбинация меню:", "Atalho do Menu:", "Combo du menu :")
    IF g_menu_combo = 0 DRAW_OPTION(y, lbl, TR("< LB + Down >", "< LB + Abajo >", "< LB + 下 >", "< LB + Unten >", "< LB + 下 >", "< LB + Вниз >", "< LB + Baixo >", "< LB + Bas >"), selected, 3) ENDIF
    IF g_menu_combo = 1 DRAW_OPTION(y, lbl, "< RB + Y >", selected, 3) ENDIF
    IF g_menu_combo = 2 DRAW_OPTION(y, lbl, "< LB + Y >", selected, 3) ENDIF
ENDPROC

PROC DRAW_BODYGUARD_MODEL_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, TR("Bodyguard PED:", "PED guardaespaldas:", "保镖模型:", "Leibwächter-PED:", "ボディガードPED:", "Модель телохранителя:", "PED do Guarda-costas:", "PED garde du corps :"), g_guard_ped_name, selected, 2)
ENDPROC

PROC DRAW_BODYGUARD_WEAPON_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Guard Weapon:", "Arma del guardia:", "保镖武器:", "Waffe:", "武器:", "Оружие охраны:", "Arma do Guarda:", "Arme du garde :")
    SWITCH g_bodyguard_weapon_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Pistol >", "< Pistola >", "< 手枪 >", "< Pistole >", "< ピストル >", "< Пистолет >", "< Pistola >", "< Pistolet >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< SMG >", "< Subfusil >", "< 冲锋枪 >", "< MP >", "< サブマシンガン >", "< ПП >", "< Submetralhadora >", "< Mitraillette >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Rifle >", "< Fusil >", "< 步枪 >", "< Gewehr >", "< ライフル >", "< Винтовка >", "< Fuzil >", "< Fusil >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< Shotgun >", "< Escopeta >", "< 霰弹枪 >", "< Schrotflinte >", "< ショットガン >", "< Дробовик >", "< Escopeta >", "< Fusil à pompe >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< MG >", "< Ametralladora >", "< 机枪 >", "< MG >", "< マシンガン >", "< Пулемет >", "< Metralhadora >", "< Mitrailleuse >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BODYGUARD_FORMATION_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Formation:", "Formación:", "队形:", "Formation:", "陣形:", "Построение:", "Formação:", "Formation :")
    SWITCH g_bodyguard_formation_choice
        CASE 0 DRAW_OPTION(y, lbl, TR("< Circle >", "< Círculo >", "< 环形 >", "< Kreis >", "< 円陣 >", "< Круг >", "< Círculo >", "< Cercle >"), selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Line >", "< Línea >", "< 纵队 >", "< Linie >", "< 一列 >", "< Линия >", "< Linha >", "< Ligne >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Wedge >", "< Cuña >", "< 楔形 >", "< Keil >", "< 楔形 >", "< Клин >", "< Cunha >", "< Coin >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_BODYGUARD_ROW(INT index, FLOAT y)
    IF g_bodyguard_tp_too_far
        SWITCH index
            CASE 0 DRAW_OPTION(y, TR("Spawn Bodyguard", "Generar guardaespaldas", "生成保镖", "Leibwächter spawnen", "ボディガードをスポーン", "Создать телохранителя", "Gerar Guarda-costas", "Faire apparaître garde"), "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_BODYGUARD_MODEL_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_BODYGUARD_WEAPON_SELECTOR(y, g_item = index) BREAK
            CASE 3 DRAW_BODYGUARD_FORMATION_SELECTOR(y, g_item = index) BREAK
            CASE 4 IF g_bodyguard_follow DRAW_OPTION(y, TR("Follow Player", "Seguir al jugador", "跟随玩家", "Spieler folgen", "プレイヤーを追従", "Следовать за игроком", "Seguir Jogador", "Suivre le joueur"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Follow Player", "Seguir al jugador", "跟随玩家", "Spieler folgen", "プレイヤーを追従", "Следовать за игроком", "Seguir Jogador", "Suivre le joueur"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 5 IF g_bodyguard_allow_vehicle DRAW_OPTION(y, TR("Allow in Vehicle", "Permitir en vehículo", "允许上车", "Im Fahrzeug erlauben", "車両乗車を許可", "Посадка в транспорт", "Permitir no Veículo", "Autoriser en véhicule"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Allow in Vehicle", "Permitir en vehículo", "允许上车", "Im Fahrzeug erlauben", "車両乗車を許可", "Посадка в транспорт", "Permitir no Veículo", "Autoriser en véhicule"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 6 IF g_bodyguard_tp_too_far DRAW_OPTION(y, TR("TP When Too Far", "TP si está lejos", "太远传送", "TP wenn zu weit", "離れたらテレポート", "ТП если далеко", "TP se Longe", "TP si trop loin"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("TP When Too Far", "TP si está lejos", "太远传送", "TP wenn zu weit", "離れたらテレポート", "ТП если далеко", "TP se Longe", "TP si trop loin"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 7 DRAW_NUMBER_OPTION(y, TR("TP Distance:", "Distancia TP:", "传送距离:", "TP-Distanz:", "TP距離:", "Дистанция ТП:", "Distância TP:", "Distance TP :"), g_bodyguard_tp_distance, g_item = index) BREAK
            CASE 8 IF g_bodyguard_blips DRAW_OPTION(y, TR("Guard Blips", "Iconos de guardias", "保镖地图标记", "Leibwächter-Symbole", "マップアイコン表示", "Метки на карте", "Ícones no Mapa", "Icônes des gardes"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Guard Blips", "Iconos de guardias", "保镖地图标记", "Leibwächter-Symbole", "マップアイコン表示", "Метки на карте", "Ícones no Mapa", "Icônes des gardes"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 9 IF g_bodyguard_god DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 10 DRAW_OPTION(y, TR("Dismiss All Guards", "Despedir a todos", "解散所有保镖", "Alle entlassen", "全員解散", "Распустить всех", "Dispensar Todos", "Renvoyer tous les gardes"), "APPLY", g_item = index, 2) BREAK
        ENDSWITCH
    ELSE
        SWITCH index
            CASE 0 DRAW_OPTION(y, TR("Spawn Bodyguard", "Generar guardaespaldas", "生成保镖", "Leibwächter spawnen", "ボディガードをスポーン", "Создать телохранителя", "Gerar Guarda-costas", "Faire apparaître garde"), "APPLY", g_item = index, 2) BREAK
            CASE 1 DRAW_BODYGUARD_MODEL_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_BODYGUARD_WEAPON_SELECTOR(y, g_item = index) BREAK
            CASE 3 DRAW_BODYGUARD_FORMATION_SELECTOR(y, g_item = index) BREAK
            CASE 4 IF g_bodyguard_follow DRAW_OPTION(y, TR("Follow Player", "Seguir al jugador", "跟随玩家", "Spieler folgen", "プレイヤーを追従", "Следовать за игроком", "Seguir Jogador", "Suivre le joueur"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Follow Player", "Seguir al jugador", "跟随玩家", "Spieler folgen", "プレイヤーを追従", "Следовать за игроком", "Seguir Jogador", "Suivre le joueur"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 5 IF g_bodyguard_allow_vehicle DRAW_OPTION(y, TR("Allow in Vehicle", "Permitir en vehículo", "允许上车", "Im Fahrzeug erlauben", "車両乗車を許可", "Посадка в транспорт", "Permitir no Veículo", "Autoriser en véhicule"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Allow in Vehicle", "Permitir en vehículo", "允许上车", "Im Fahrzeug erlauben", "車両乗車を許可", "Посадка в транспорт", "Permitir no Veículo", "Autoriser en véhicule"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 6 IF g_bodyguard_tp_too_far DRAW_OPTION(y, TR("TP When Too Far", "TP si está lejos", "太远传送", "TP wenn zu weit", "離れたらテレポート", "ТП если далеко", "TP se Longe", "TP si trop loin"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("TP When Too Far", "TP si está lejos", "太远传送", "TP wenn zu weit", "離れたらテレポート", "ТП если далеко", "TP se Longe", "TP si trop loin"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 7 IF g_bodyguard_blips DRAW_OPTION(y, TR("Guard Blips", "Iconos de guardias", "保镖地图标记", "Leibwächter-Symbole", "マップアイコン表示", "Метки на карте", "Ícones no Mapa", "Icônes des gardes"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Guard Blips", "Iconos de guardias", "保镖地图标记", "Leibwächter-Symbole", "マップアイコン表示", "Метки на карте", "Ícones no Mapa", "Icônes des gardes"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 8 IF g_bodyguard_god DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("God Mode", "Modo Dios", "无敌模式", "Gottmodus", "ゴッドモード", "Режим бога", "Modo Deus", "Mode Dieu"), "OFF", g_item = index, 0) ENDIF BREAK
            CASE 9 DRAW_OPTION(y, TR("Dismiss All Guards", "Despedir a todos", "解散所有保镖", "Alle entlassen", "全員解散", "Распустить всех", "Dispensar Todos", "Renvoyer tous les gardes"), "APPLY", g_item = index, 2) BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_BODYGUARD_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("BODYGUARDS", "GUARDAESPALDAS", "保镖", "LEIBWÄCHTER", "ボディガード", "ТЕЛОХРАНИТЕЛИ", "GUARDA-COSTAS", "GARDES DU CORPS"))
    DRAW_MENU_VERSION_TAG()
    INT total = 10
    IF g_bodyguard_tp_too_far total = 11 ENDIF
    INT index = g_bodyguard_scroll
    INT row = 0
    WHILE row < 8 AND index < total
        DRAW_BODYGUARD_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_GUARD_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("BODYGUARD PED", "PED GUARDAESPALDAS", "保镖模型", "LEIBWÄCHTER-PED", "ボディガードPED", "МОДЕЛЬ ОХРАНЫ", "PED DO GUARDA-COSTAS", "PED GARDE DU CORPS"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_guard_ped_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_guard_ped_search_not_found
                DRAW_OPTION(y, TR("PED Search", "Buscar PED", "搜索模型", "PED-Suche", "PED検索", "Поиск PED", "Buscar PED", "Recherche PED"), "NOT FOUND", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, TR("PED Search", "Buscar PED", "搜索模型", "PED-Suche", "PED検索", "Поиск PED", "Buscar PED", "Recherche PED"), g_guard_ped_name, g_item = index, 2)
            ENDIF
        ELIF index = 1
            DRAW_OPTION(y, TR("Random PED", "PED aleatorio", "随机模型", "Zufälliges PED", "ランダムPED", "Случайный PED", "PED Aleatório", "PED aléatoire"), "APPLY", g_item = index, 2)
        ELSE
            DRAW_OPTION(y, TR("PED:", "PED:", "模型:", "PED:", "PED:", "PED:", "PED:", "PED :"), PED_NAME_FOR_CHOICE(index - 2), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_ATTACKER_PED_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("ATTACKER PED", "PED ATACANTE", "袭击者模型", "ANGREIFER-PED", "アタッカーPED", "МОДЕЛЬ НАПАДАЮЩЕГО", "PED DO ATACANTE", "PED ASSAILLANT"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_attacker_ped_scroll
    INT row = 0
    WHILE row < 8 AND index < PED_CHOICE_COUNT() + 2
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF index = 0
            IF g_attacker_ped_search_not_found
                DRAW_OPTION(y, TR("PED Search", "Buscar PED", "搜索模型", "PED-Suche", "PED検索", "Поиск PED", "Buscar PED", "Recherche PED"), "NOT FOUND", g_item = index, 0)
            ELSE
                DRAW_OPTION(y, TR("PED Search", "Buscar PED", "搜索模型", "PED-Suche", "PED検索", "Поиск PED", "Buscar PED", "Recherche PED"), g_attacker_ped_name, g_item = index, 2)
            ENDIF
        ELIF index = 1
            DRAW_OPTION(y, TR("Random PED", "PED aleatorio", "随机模型", "Zufälliges PED", "ランダムPED", "Случайный PED", "PED Aleatório", "PED aléatoire"), "APPLY", g_item = index, 2)
        ELSE
            DRAW_OPTION(y, TR("PED:", "PED:", "模型:", "PED:", "PED:", "PED:", "PED:", "PED :"), PED_NAME_FOR_CHOICE(index - 2), g_item = index, 2)
        ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_RADIO_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Current Station", "Emisora actual", "当前电台", "Aktueller Sender", "現在の局", "Текущая станция", "Estação Atual", "Station actuelle"), RADIO_STATION_NAME(g_radio_station_index), g_item = index, 2) BREAK
        CASE 1 IF g_mobile_radio DRAW_OPTION(y, TR("Portable Radio", "Radio portátil", "随身电台", "Tragbares Radio", "ポータブルラジオ", "Портативное радио", "Rádio Portátil", "Radio portable"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Portable Radio", "Radio portátil", "随身电台", "Tragbares Radio", "ポータブルラジオ", "Портативное радио", "Rádio Portátil", "Radio portable"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, TR("Previous Station", "Emisora anterior", "上一电台", "Vorheriger Sender", "前の局", "Предыдущая станция", "Estação Anterior", "Station précédente"), RADIO_STATION_NAME(GET_PREV_RADIO_STATION_INDEX(g_radio_station_index)), g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Next Station", "Siguiente emisora", "下一电台", "Nächster Sender", "次の局", "Следующая станция", "Próxima Estação", "Station suivante"), RADIO_STATION_NAME(GET_NEXT_RADIO_STATION_INDEX(g_radio_station_index)), g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_RADIO_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("PORTABLE RADIO", "RADIO PORTÁTIL", "随身电台", "TRAGBARES RADIO", "ポータブルラジオ", "ПОРТАТИВНОЕ РАДИО", "RÁDIO PORTÁTIL", "RADIO PORTABLE"))
    DRAW_MENU_VERSION_TAG()
    SYNC_RADIO_STATION_INDEX()
    INT index = g_radio_scroll
    INT row = 0
    WHILE row < 8 AND index < 4
        DRAW_RADIO_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_VEHICLE_MULTIPLIER(FLOAT y, STRING label, INT level, BOOL selected)
    IF level = 0
        DRAW_OPTION(y, label, "< OFF >", selected, 0)
    ELIF level = 1
        DRAW_OPTION(y, label, "< 1.25x >", selected, 3)
    ELIF level = 2
        DRAW_OPTION(y, label, "< 1.5x >", selected, 3)
    ELIF level = 3
        DRAW_OPTION(y, label, "< 2x >", selected, 3)
    ELIF level = 4
        DRAW_OPTION(y, label, "< 2.5x >", selected, 3)
    ELIF level = 5
        DRAW_OPTION(y, label, "< 3x >", selected, 3)
    ELIF level = 6
        DRAW_OPTION(y, label, "< 4x >", selected, 3)
    ELIF level = 7
        DRAW_OPTION(y, label, "< 5x >", selected, 3)
    ELIF level = 8
        DRAW_OPTION(y, label, "< 10x >", selected, 3)
    ELIF level = 9
        DRAW_OPTION(y, label, "< 20x >", selected, 3)
    ELIF level = 10
        DRAW_OPTION(y, label, "< 50x >", selected, 3)
    ELIF level = 11
        DRAW_OPTION(y, label, "< 100x >", selected, 3)
    ELSE
        DRAW_OPTION(y, label, "< 200x >", selected, 3)
    ENDIF
ENDPROC

FUNC FLOAT VEHICLE_MULTIPLIER_VALUE(INT level)
    IF level = 1 RETURN 1.25 ENDIF
    IF level = 2 RETURN 1.5 ENDIF
    IF level = 3 RETURN 2.0 ENDIF
    IF level = 4 RETURN 2.5 ENDIF
    IF level = 5 RETURN 3.0 ENDIF
    IF level = 6 RETURN 4.0 ENDIF
    IF level = 7 RETURN 5.0 ENDIF
    IF level = 8 RETURN 10.0 ENDIF
    IF level = 9 RETURN 20.0 ENDIF
    IF level = 10 RETURN 50.0 ENDIF
    IF level = 11 RETURN 100.0 ENDIF
    IF level = 12 RETURN 200.0 ENDIF
    RETURN 0.0
ENDFUNC

FUNC FLOAT TRAIN_ACCELERATION_SPEED(INT level)
    FLOAT speed = VEHICLE_MULTIPLIER_VALUE(level) * 15.0
    IF speed > 120.0 RETURN 120.0 ENDIF
    IF speed < 15.0 RETURN 15.0 ENDIF
    RETURN speed
ENDFUNC

// Friction override uses a positive coefficient. The negative selections are
// deliberately represented as fractions below the stock 1.0 coefficient,
// rather than passing a negative native value (which resets/invalidates the
// override on some vehicle classes).
FUNC FLOAT VEHICLE_GRIP_VALUE(INT level)
    IF level = -4 RETURN 0.15 ENDIF
    IF level = -3 RETURN 0.30 ENDIF
    IF level = -2 RETURN 0.50 ENDIF
    IF level = -1 RETURN 0.75 ENDIF
    IF level = 1 RETURN 1.10 ENDIF
    IF level = 2 RETURN 1.25 ENDIF
    IF level = 3 RETURN 1.40 ENDIF
    IF level = 4 RETURN 1.60 ENDIF
    IF level = 5 RETURN 1.80 ENDIF
    IF level = 6 RETURN 2.00 ENDIF
    IF level = 7 RETURN 2.25 ENDIF
    IF level = 8 RETURN 2.50 ENDIF
    RETURN -1.0
ENDFUNC

PROC DRAW_VEHICLE_GRIP_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Grip Strength", "Fuerza de agarre", "抓地力强度", "Haftung", "グリップ強度", "Сцепление с дорогой", "Força de Aderência", "Adhérence")
    IF g_vehicle_grip_level = -4 DRAW_OPTION(y, lbl, "< -85% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -3 DRAW_OPTION(y, lbl, "< -70% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -2 DRAW_OPTION(y, lbl, "< -50% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = -1 DRAW_OPTION(y, lbl, "< -25% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 0 DRAW_OPTION(y, lbl, "< OFF >", selected, 0) ENDIF
    IF g_vehicle_grip_level = 1 DRAW_OPTION(y, lbl, "< +10% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 2 DRAW_OPTION(y, lbl, "< +25% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 3 DRAW_OPTION(y, lbl, "< +40% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 4 DRAW_OPTION(y, lbl, "< +60% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 5 DRAW_OPTION(y, lbl, "< +80% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 6 DRAW_OPTION(y, lbl, "< +100% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 7 DRAW_OPTION(y, lbl, "< +125% >", selected, 3) ENDIF
    IF g_vehicle_grip_level = 8 DRAW_OPTION(y, lbl, "< +150% >", selected, 3) ENDIF
ENDPROC

PROC DRAW_NEON_MODE_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Neon Animation:", "Animación de neón:", "霓虹灯动画:", "Neon-Animation:", "ネオンアニメーション:", "Анимация неона:", "Animação de Neon:", "Animation néon :")
    SWITCH g_neon_mode
        CASE 0 DRAW_OPTION(y, lbl, TR("< Off >", "< Desactivado >", "< 关闭 >", "< Aus >", "< オフ >", "< Выкл >", "< Desligado >", "< Désactivé >"), selected, 0) BREAK
        CASE 1 DRAW_OPTION(y, lbl, TR("< Flashing >", "< Parpadeo >", "< 闪烁 >", "< Blinken >", "< 点滅 >", "< Мигание >", "< Piscando >", "< Clignotant >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, lbl, TR("< Fade >", "< Fundido >", "< 渐变 >", "< Überblenden >", "< フェード >", "< Затухание >", "< Suave >", "< Fondu >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, lbl, TR("< RGB Cycle >", "< Ciclo RGB >", "< RGB 循环 >", "< RGB-Zyklus >", "< RGBサイクル >", "< RGB-цикл >", "< Ciclo RGB >", "< Cycle RGB >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, lbl, TR("< Spin >", "< Giro >", "< 旋转 >", "< Drehen >", "< スピン >", "< Вращение >", "< Giro >", "< Rotation >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, lbl, TR("< Slide >", "< Deslizar >", "< 滑动 >", "< Gleiten >", "< スライド >", "< Скольжение >", "< Deslizar >", "< Glissement >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, lbl, TR("< Colour Shift >", "< Cambio de color >", "< 色彩变换 >", "< Farbwechsel >", "< カラーシフト >", "< Смена цвета >", "< Mudança de Cor >", "< Changement de couleur >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_NEON_TRANSITION_SELECTOR(FLOAT y, BOOL selected)
    STRING lbl = TR("Transition Smoothness:", "Suavidad de transición:", "过渡平滑度:", "Übergangsglättung:", "遷移の滑らかさ:", "Плавность перехода:", "Suavidade da Transição:", "Fluidité de transition :")
    IF g_neon_transition = 0 DRAW_OPTION(y, lbl, TR("< Smooth >", "< Suave >", "< 平滑 >", "< Weich >", "< スムーズ >", "< Плавно >", "< Suave >", "< Fluide >"), selected, 3) ELSE DRAW_OPTION(y, lbl, TR("< Hard >", "< Brusco >", "< 硬切 >", "< Hart >", "< ハード >", "< Резко >", "< Forte >", "< Brut >"), selected, 3) ENDIF
ENDPROC

PROC DRAW_SPEED_LEVEL_OPTION(FLOAT y, STRING label, INT level, BOOL selected)
    IF level <= 0
        DRAW_OPTION(y, label, "< Stopped >", selected, 0)
    ELIF level = 1
        DRAW_OPTION(y, label, "< 0.25x >", selected, 3)
    ELIF level = 2
        DRAW_OPTION(y, label, "< 0.50x >", selected, 3)
    ELIF level = 3
        DRAW_OPTION(y, label, "< 0.75x >", selected, 3)
    ELIF level = 4
        DRAW_OPTION(y, label, "< 1.00x >", selected, 3)
    ELIF level = 5
        DRAW_OPTION(y, label, "< 1.25x >", selected, 3)
    ELIF level = 6
        DRAW_OPTION(y, label, "< 1.50x >", selected, 3)
    ELIF level = 7
        DRAW_OPTION(y, label, "< 1.75x >", selected, 3)
    ELIF level = 8
        DRAW_OPTION(y, label, "< 2.00x >", selected, 3)
    ELIF level = 9
        DRAW_OPTION(y, label, "< 2.25x >", selected, 3)
    ELIF level = 10
        DRAW_OPTION(y, label, "< 2.50x >", selected, 3)
    ELIF level = 11
        DRAW_OPTION(y, label, "< 2.75x >", selected, 3)
    ELIF level = 12
        DRAW_OPTION(y, label, "< 3.00x >", selected, 3)
    ELIF level = 13
        DRAW_OPTION(y, label, "< 3.25x >", selected, 3)
    ELIF level = 14
        DRAW_OPTION(y, label, "< 3.50x >", selected, 3)
    ELIF level = 15
        DRAW_OPTION(y, label, "< 3.75x >", selected, 3)
    ELIF level = 16
        DRAW_OPTION(y, label, "< 4.00x >", selected, 3)
    ELIF level = 17
        DRAW_OPTION(y, label, "< 4.25x >", selected, 3)
    ELIF level = 18
        DRAW_OPTION(y, label, "< 4.50x >", selected, 3)
    ELIF level = 19
        DRAW_OPTION(y, label, "< 4.75x >", selected, 3)
    ELIF level = 20
        DRAW_OPTION(y, label, "< 5.00x >", selected, 3)
    ELIF level = 21
        DRAW_OPTION(y, label, "< 5.25x >", selected, 3)
    ELIF level = 22
        DRAW_OPTION(y, label, "< 5.50x >", selected, 3)
    ELIF level = 23
        DRAW_OPTION(y, label, "< 5.75x >", selected, 3)
    ELIF level = 24
        DRAW_OPTION(y, label, "< 6.00x >", selected, 3)
    ELIF level = 25
        DRAW_OPTION(y, label, "< 6.25x >", selected, 3)
    ELIF level = 26
        DRAW_OPTION(y, label, "< 6.50x >", selected, 3)
    ELIF level = 27
        DRAW_OPTION(y, label, "< 6.75x >", selected, 3)
    ELIF level = 28
        DRAW_OPTION(y, label, "< 7.00x >", selected, 3)
    ELIF level = 29
        DRAW_OPTION(y, label, "< 7.25x >", selected, 3)
    ELIF level = 30
        DRAW_OPTION(y, label, "< 7.50x >", selected, 3)
    ELIF level = 31
        DRAW_OPTION(y, label, "< 7.75x >", selected, 3)
    ELIF level = 32
        DRAW_OPTION(y, label, "< 8.00x >", selected, 3)
    ELIF level = 33
        DRAW_OPTION(y, label, "< 8.25x >", selected, 3)
    ELIF level = 34
        DRAW_OPTION(y, label, "< 8.50x >", selected, 3)
    ELIF level = 35
        DRAW_OPTION(y, label, "< 8.75x >", selected, 3)
    ELIF level = 36
        DRAW_OPTION(y, label, "< 9.00x >", selected, 3)
    ELIF level = 37
        DRAW_OPTION(y, label, "< 9.25x >", selected, 3)
    ELIF level = 38
        DRAW_OPTION(y, label, "< 9.50x >", selected, 3)
    ELIF level = 39
        DRAW_OPTION(y, label, "< 9.75x >", selected, 3)
    ELSE
        DRAW_OPTION(y, label, "< 10.00x >", selected, 3)
    ENDIF
ENDPROC

PROC DRAW_NEON_SPEED_SELECTOR(FLOAT y, BOOL selected)
    DRAW_SPEED_LEVEL_OPTION(y, TR("Neon Speed", "Velocidad de neón", "霓虹灯速度", "Neon-Geschwindigkeit", "ネオン速度", "Скорость неона", "Velocidade do Neon", "Vitesse du néon"), g_neon_speed_index, selected)
ENDPROC

PROC DRAW_ACCENT_RGB_SPEED_SELECTOR(FLOAT y, BOOL selected)
    DRAW_SPEED_LEVEL_OPTION(y, TR("Transition Speed", "Velocidad de transición", "过渡速度", "Übergangsgeschwindigkeit", "遷移速度", "Скорость перехода", "Velocidade de Transição", "Vitesse de transition"), g_accent_rgb_speed_index, selected)
ENDPROC

PROC DRAW_NEON_ANIM_ENTRY(FLOAT y, BOOL selected)
    STRING lbl = TR("Neon Animation", "Animación de neón", "霓虹灯动画", "Neon-Animation", "ネオンアニメーション", "Анимация неона", "Animação de Neon", "Animation néon")
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, lbl, "No Vehicle", selected, 0)
    ELSE
        DRAW_OPTION(y, lbl, "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_NEON_ANIM_ROW(INT index, FLOAT y)
    IF g_neon_mode = 3
        SWITCH index
            CASE 0 DRAW_NEON_MODE_SELECTOR(y, g_item = index) BREAK
            CASE 1 DRAW_NEON_SPEED_SELECTOR(y, g_item = index) BREAK
            CASE 2 DRAW_NEON_TRANSITION_SELECTOR(y, g_item = index) BREAK
        ENDSWITCH
    ELSE
        SWITCH index
            CASE 0 DRAW_NEON_MODE_SELECTOR(y, g_item = index) BREAK
            CASE 1 DRAW_LSC_LIGHT_SELECTOR(y, TR("Underglow Colour", "Color de neón", "底盘灯颜色", "Unterbodenfarbe", "アンダーネオン色", "Цвет подсветки", "Cor do Neon", "Couleur du néon"), g_lsc_neon_colour, g_item = index) BREAK
            CASE 2 DRAW_NEON_SPEED_SELECTOR(y, g_item = index) BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_NEON_ANIM_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("NEON ANIMATION", "ANIMACIÓN DE NEÓN", "霓虹灯动画", "NEON-ANIMATION", "ネオンアニメーション", "АНИМАЦИЯ НЕОНА", "ANIMAÇÃO DE NEON", "ANIMATION NÉON"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_neon_anim_scroll
    INT row = 0
    INT total = 3
    WHILE row < 8 AND index < total
        DRAW_NEON_ANIM_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_VEHICLE_CONTROL_ENTRY(FLOAT y, BOOL selected)
    STRING lbl = TR("Vehicle Control", "Control del vehículo", "载具控制", "Fahrzeugsteuerung", "車両コントロール", "Управление ТС", "Controle do Veículo", "Contrôle du véhicule")
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        DRAW_OPTION(y, lbl, "No Vehicle", selected, 0)
    ELSE
        DRAW_OPTION(y, lbl, "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_VEHICLE_CONTROL_ROW(INT index, FLOAT y)
    STRING winLbl = TR("Window", "Ventanilla", "单侧车窗", "Fenster", "窓選択", "Окно", "Janela", "Vitre")
    STRING seatLbl = TR("Switch Seat", "Cambiar de asiento", "切换座位", "Sitz wechseln", "座席変更", "Сменить место", "Trocar Assento", "Changer de siège")
    STRING engLbl = TR("Engine", "Motor", "引擎", "Motor", "エンジン", "Двигатель", "Motor", "Moteur")
    SWITCH index
        CASE 0
            IF g_vehicle_window_action = 0 DRAW_OPTION(y, TR("Windows", "Ventanillas", "车窗", "Fenster", "ウィンドウ", "Окна", "Janelas", "Vitres"), TR("< All Down >", "< Bajar todas >", "< 全部降下 >", "< Alle runter >", "< すべて開ける >", "< Опустить все >", "< Abaixar Todas >", "< Tout baisser >"), g_item = index, 3) ELSE DRAW_OPTION(y, TR("Windows", "Ventanillas", "车窗", "Fenster", "ウィンドウ", "Окна", "Janelas", "Vitres"), TR("< All Up >", "< Subir todas >", "< 全部升起 >", "< Alle hoch >", "< すべて閉める >", "< Поднять все >", "< Levantar Todas >", "< Tout monter >"), g_item = index, 3) ENDIF
        BREAK
        CASE 1
            IF g_vehicle_window_choice = 0 DRAW_OPTION(y, winLbl, TR("< Front Left >", "< Delantera izq. >", "< 左前 >", "< Vorne links >", "< 前方左 >", "< Переднее левое >", "< Dianteira Esq. >", "< Avant gauche >"), g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 1 DRAW_OPTION(y, winLbl, TR("< Front Right >", "< Delantera der. >", "< 右前 >", "< Vorne rechts >", "< 前方右 >", "< Переднее правое >", "< Dianteira Dir. >", "< Avant droite >"), g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 2 DRAW_OPTION(y, winLbl, TR("< Rear Left >", "< Trasera izq. >", "< 左后 >", "< Hinten links >", "< 後方左 >", "< Заднее левое >", "< Traseira Esq. >", "< Arrière gauche >"), g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 3 DRAW_OPTION(y, winLbl, TR("< Rear Right >", "< Trasera der. >", "< 右后 >", "< Hinten rechts >", "< 後方右 >", "< Заднее правое >", "< Traseira Dir. >", "< Arrière droite >"), g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 4 DRAW_OPTION(y, winLbl, TR("< Middle Left >", "< Central izq. >", "< 中左 >", "< Mitte links >", "< 中央左 >", "< Среднее левое >", "< Central Esq. >", "< Milieu gauche >"), g_item = index, 3) ENDIF
            IF g_vehicle_window_choice = 5 DRAW_OPTION(y, winLbl, TR("< Middle Right >", "< Central der. >", "< 中右 >", "< Mitte rechts >", "< 中央右 >", "< Среднее правое >", "< Central Dir. >", "< Milieu droite >"), g_item = index, 3) ENDIF
        BREAK
        CASE 2 DRAW_OPTION(y, TR("Roll Selected Down", "Bajar seleccionada", "降下所选车窗", "Ausgewähltes runter", "選択した窓を開ける", "Опустить выбранное", "Abaixar Selecionada", "Baisser la vitre"), "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Roll Selected Up", "Subir seleccionada", "升起所选车窗", "Ausgewähltes hoch", "選択した窓を閉める", "Поднять выбранное", "Levantar Selecionada", "Monter la vitre"), "APPLY", g_item = index, 2) BREAK
        CASE 4
            // Engine reads the live state, so the row tracks stalls and
            // restarts instead of the last thing the menu set.
            IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
                IF GET_IS_VEHICLE_ENGINE_RUNNING(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) DRAW_OPTION(y, engLbl, "ON", g_item = index, 1) ELSE DRAW_OPTION(y, engLbl, "OFF", g_item = index, 0) ENDIF
            ELSE
                DRAW_OPTION(y, engLbl, "No Vehicle", g_item = index, 0)
            ENDIF
        BREAK
        CASE 5
            IF g_vehicle_hazards DRAW_OPTION(y, TR("Hazard Lights", "Luces de emergencia", "双闪警示灯", "Warnblinker", "ハザードランプ", "Аварийка", "Pisca-alerta", "Feux de détresse"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Hazard Lights", "Luces de emergencia", "双闪警示灯", "Warnblinker", "ハザードランプ", "Аварийка", "Pisca-alerta", "Feux de détresse"), "OFF", g_item = index, 0) ENDIF
        BREAK
        CASE 6
            IF g_vehicle_seat_choice = 0 DRAW_OPTION(y, seatLbl, TR("< Driver >", "< Conductor >", "< 驾驶座 >", "< Fahrer >", "< 運転席 >", "< Водитель >", "< Motorista >", "< Conducteur >"), g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 1 DRAW_OPTION(y, seatLbl, TR("< Front Right >", "< Copiloto >", "< 副驾驶 >", "< Beifahrer >", "< 助手席 >", "< Переднее правое >", "< Passageiro >", "< Passager avant >"), g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 2 DRAW_OPTION(y, seatLbl, TR("< Back Left >", "< Trasero izq. >", "< 左后座 >", "< Hinten links >", "< 後部左 >", "< Заднее левое >", "< Traseiro Esq. >", "< Arrière gauche >"), g_item = index, 3) ENDIF
            IF g_vehicle_seat_choice = 3 DRAW_OPTION(y, seatLbl, TR("< Back Right >", "< Trasero der. >", "< 右后座 >", "< Hinten rechts >", "< 後部右 >", "< Заднее правое >", "< Traseiro Dir. >", "< Arrière droite >"), g_item = index, 3) ENDIF
        BREAK
        CASE 7 DRAW_OPTION(y, TR("Dirt Level", "Nivel de suciedad", "污垢程度", "Schmutzgrad", "汚れ具合", "Уровень грязи", "Nível de Sujeira", "Niveau de saleté"), DIRT_LEVEL_VALUE_LABEL(g_vehicle_dirt_level), g_item = index, 3) BREAK
        CASE 8 DRAW_OPTION(y, TR("Wash Vehicle", "Lavar vehículo", "清洗载具", "Fahrzeug waschen", "洗車する", "Помыть транспорт", "Lavar Veículo", "Laver le véhicule"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_VEHICLE_CONTROL_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("VEHICLE CONTROL", "CONTROL DEL VEHÍCULO", "载具控制", "FAHRZEUGSTEUERUNG", "車両コントロール", "УПРАВЛЕНИЕ ТС", "CONTROLE DO VEÍCULO", "CONTRÔLE DU VÉHICULE"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_vehicle_control_scroll
    INT row = 0
    INT total = 9
    WHILE row < 8 AND index < total
        DRAW_VEHICLE_CONTROL_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_VEHICLE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Vehicle Spawner", "Generador de vehículos", "载具生成器", "Fahrzeug-Spawner", "車両スポナー", "Спавнер транспорта", "Gerador de Veículos", "Générateur de véhicules"), "OPEN", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, TR("LS Customs", "LS Customs", "洛圣都改车王", "LS Customs", "ロスサントス・カスタム", "LS Customs", "LS Customs", "LS Customs"), "OPEN", g_item = index, 2) BREAK
        CASE 2 DRAW_NEON_ANIM_ENTRY(y, g_item = index) BREAK
        CASE 3 DRAW_VEHICLE_CONTROL_ENTRY(y, g_item = index) BREAK
        CASE 4 IF g_vehicle_god DRAW_OPTION(y, TR("Vehicle God Mode", "Vehículo invencible", "载具无敌", "Fahrzeug-Gottmodus", "車両ゴッドモード", "Неуязвимость ТС", "Veículo Invencível", "Véhicule invincible"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Vehicle God Mode", "Vehículo invencible", "载具无敌", "Fahrzeug-Gottmodus", "車両ゴッドモード", "Неуязвимость ТС", "Veículo Invencível", "Véhicule invincible"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_OPTION(y, TR("Repair Vehicle", "Reparar vehículo", "修复载具", "Fahrzeug reparieren", "車両を修理", "Починить транспорт", "Reparar Veículo", "Réparer le véhicule"), "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Max Vehicle Upgrades", "Mejorar vehículo al máximo", "满配载具改装", "Maximale Upgrades", "フル改造", "Макс. улучшения ТС", "Melhorar ao Máximo", "Améliorations max"), "APPLY", g_item = index, 2) BREAK
        CASE 7 IF g_vehicle_always_max DRAW_OPTION(y, TR("Always Max Upgrades", "Mejorar siempre al máximo", "始终满配改装", "Immer max. Upgrades", "常にフル改造", "Всегда макс. тюнинг", "Sempre no Máximo", "Toujours au max"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Always Max Upgrades", "Mejorar siempre al máximo", "始终满配改装", "Immer max. Upgrades", "常にフル改造", "Всегда макс. тюнинг", "Sempre no Máximo", "Toujours au max"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_VEHICLE_MULTIPLIER(y, TR("Acceleration Boost", "Impulso de aceleración", "加速倍率", "Beschleunigungs-Boost", "加速ブースト", "Ускорение", "Impulso de Aceleração", "Boost d'accélération"), g_vehicle_acceleration_level, g_item = index) BREAK
        CASE 9 DRAW_VEHICLE_GRIP_SELECTOR(y, g_item = index) BREAK
        CASE 10 IF g_godmode_tow_hook DRAW_OPTION(y, TR("God Mode Tow-Hook", "Gancho de grúa invencible", "拖车钩无敌", "Unzerstörbarer Abschlepphaken", "牽引フック無敵", "Неуязвимый крюк тягача", "Guincho Invencível", "Crochet de remorquage invincible"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("God Mode Tow-Hook", "Gancho de grúa invencible", "拖车钩无敌", "Unzerstörbarer Abschlepphaken", "牽引フック無敵", "Неуязвимый крюк тягача", "Guincho Invencível", "Crochet de remorquage invincible"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_vehicle_turbo DRAW_OPTION(y, TR("Turbo Mod", "Modificación Turbo", "涡轮增压", "Turbo-Mod", "ターボチューン", "Турбо-наддув", "Mod Turbo", "Mod Turbo"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Turbo Mod", "Modificación Turbo", "涡轮增压", "Turbo-Mod", "ターボチューン", "Турбо-наддув", "Mod Turbo", "Mod Turbo"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 IF g_vehicle_bulletproof_tyres DRAW_OPTION(y, TR("Bulletproof Tyres", "Neumáticos antibalas", "防弹轮胎", "Kugelsichere Reifen", "防弾タイヤ", "Пулестойкие шины", "Pneus à Prova de Balas", "Pneus à l'épreuve des balles"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Bulletproof Tyres", "Neumáticos antibalas", "防弹轮胎", "Kugelsichere Reifen", "防弾タイヤ", "Пулестойкие шины", "Pneus à Prova de Balas", "Pneus à l'épreuve des balles"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 13 DRAW_OPTION(y, TR("Flip Vehicle upright", "Enderezar vehículo", "翻转扶正载具", "Fahrzeug aufrichten", "車両を起こす", "Перевернуть на колеса", "Desvirar Veículo", "Remettre à l'endroit"), "APPLY", g_item = index, 2) BREAK
        CASE 14 IF g_vehicle_quick_entry_exit DRAW_OPTION(y, TR("Instant Enter / Exit", "Entrar / Salir al instante", "瞬间上下车", "Sofort Ein-/Aussteigen", "即時乗降", "Мгновенная посадка/выход", "Entrar / Sair Instantâneo", "Entrée / Sortie instantanée"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Instant Enter / Exit", "Entrar / Salir al instante", "瞬间上下车", "Sofort Ein-/Aussteigen", "即時乗降", "Мгновенная посадка/выход", "Entrar / Sair Instantâneo", "Entrée / Sortie instantanée"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 15 DRAW_OPTION(y, TR("Enter Personal Vehicle", "Entrar al vehículo personal", "进入个人载具", "In persönliches Fahrzeug setzen", "個人車両に乗る", "Сесть в личный ТС", "Entrar no Veículo Pessoal", "Entrer dans véhicule perso"), "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, TR("Bring Personal Vehicle", "Traer vehículo personal", "召唤个人载具", "Persönliches Fahrzeug holen", "個人車両を呼ぶ", "Доставить личный ТС", "Trazer Veículo Pessoal", "Appeler véhicule perso"), "APPLY", g_item = index, 2) BREAK
        CASE 17 IF g_vehicle_horn_boost DRAW_OPTION(y, TR("Horn Boost", "Impulso con claxon", "喇叭加速", "Hupen-Boost", "ホーンブースト", "Ускорение гудком", "Impulso na Buzina", "Boost klaxon"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Horn Boost", "Impulso con claxon", "喇叭加速", "Hupen-Boost", "ホーンブースト", "Ускорение гудком", "Impulso na Buzina", "Boost klaxon"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 18 IF g_vehicle_auto_repair DRAW_OPTION(y, TR("Auto Repair Vehicle", "Autorreparar vehículo", "自动修复载具", "Auto-Reparatur", "自動修理", "Автопочинка ТС", "Autorreparo de Veículo", "Réparation auto"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Auto Repair Vehicle", "Autorreparar vehículo", "自动修复载具", "Auto-Reparatur", "自動修理", "Автопочинка ТС", "Autorreparo de Veículo", "Réparation auto"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 19 DRAW_OPTION(y, TR("Open Plane Cargo / Backdoor", "Abrir bodega / puerta trasera", "打开飞机货舱 / 后门", "Frachtraum / Hecktür öffnen", "貨物ドア / 後部ドアを開ける", "Открыть грузовой отсек", "Abrir Compartimento de Carga", "Ouvrir soute / porte arrière"), "APPLY", g_item = index, 2) BREAK
        CASE 20 IF g_doors_locked DRAW_OPTION(y, TR("Lock Doors", "Bloquear puertas", "锁上车门", "Türen verriegeln", "ドアロック", "Запереть двери", "Trancar Portas", "Verrouiller les portes"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Lock Doors", "Bloquear puertas", "锁上车门", "Türen verriegeln", "ドアロック", "Запереть двери", "Trancar Portas", "Verrouiller les portes"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 21 IF g_seatbelt DRAW_OPTION(y, TR("Always Seatbelt", "Cinturón de seguridad", "始终系安全带", "Immer angeschnallt", "シートベルト常時着用", "Ремень безопасности", "Cinto de Segurança", "Ceinture de sécurité"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Always Seatbelt", "Cinturón de seguridad", "始终系安全带", "Immer angeschnallt", "シートベルト常時着用", "Ремень безопасности", "Cinto de Segurança", "Ceinture de sécurité"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 22 DRAW_OPTION(y, TR("Destroy Engine", "Destruir motor", "摧毁引擎", "Motor zerstören", "エンジンを破壊", "Сломать двигатель", "Destruir Motor", "Détruire le moteur"), "APPLY", g_item = index, 2) BREAK
        CASE 23 IF g_vehicle_speedometer DRAW_OPTION(y, TR("Speedometer", "Velocímetro", "速度表", "Tachometer", "スピードメーター", "Спидометр", "Velocímetro", "Compteur de vitesse"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Speedometer", "Velocímetro", "速度表", "Tachometer", "スピードメーター", "Спидометр", "Velocímetro", "Compteur de vitesse"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 24 IF g_vehicle_speed_unit = 0 DRAW_OPTION(y, TR("Speed Unit", "Unidad de velocidad", "速度单位", "Geschwindigkeitseinheit", "速度単位", "Единицы скорости", "Unidade de Velocidade", "Unité de vitesse"), "< MPH >", g_item = index, 3) ELSE DRAW_OPTION(y, TR("Speed Unit", "Unidad de velocidad", "速度单位", "Geschwindigkeitseinheit", "速度単位", "Единицы скорости", "Unidade de Velocidade", "Unité de vitesse"), "< KMPH >", g_item = index, 3) ENDIF BREAK
        CASE 25 DRAW_CHAUFFEUR_ENTRY(y, g_item = index) BREAK
        CASE 26 IF g_vehicle_cruise_control DRAW_OPTION(y, TR("Cruise Control", "Control de crucero", "定速巡航", "Tempomat", "クルーズコントロール", "Круиз-контроль", "Piloto Automático", "Régulateur de vitesse"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Cruise Control", "Control de crucero", "定速巡航", "Tempomat", "クルーズコントロール", "Круиз-контроль", "Piloto Automático", "Régulateur de vitesse"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 27 IF g_siren_mute_enabled DRAW_OPTION(y, TR("Silent Sirens (Hold R3)", "Sirenas silenciosas (R3)", "静音警笛 (长按 R3)", "Stumme Sirenen (R3 halten)", "サイレン消音 (R3長押し)", "Тихие сирены (удерж. R3)", "Sirene Silenciosa (Segurar R3)", "Sirènes muettes (maintenir R3)"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Silent Sirens (Hold R3)", "Sirenas silenciosas (R3)", "静音警笛 (长按 R3)", "Stumme Sirenen (R3 halten)", "サイレン消音 (R3長押し)", "Тихие сирены (удерж. R3)", "Sirene Silenciosa (Segurar R3)", "Sirènes muettes (maintenir R3)"), "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_VEHICLE_SEARCH(FLOAT y, BOOL selected)
    STRING lbl = TR("Spawn by Model Name", "Generar por nombre de modelo", "按模型名称生成", "Nach Modellnamen spawnen", "モデル名でスポーン", "Создать по модели", "Gerar por Nome do Modelo", "Apparaître par modèle")
    IF g_vehicle_search_not_found
        DRAW_OPTION(y, lbl, "NOT FOUND", selected, 0)
    ELIF g_vehicle_search_has_value
        DRAW_OPTION(y, lbl, g_vehicle_search_value, selected, 1)
    ELSE
        DRAW_OPTION(y, lbl, CURRENT_VEHICLE_SEARCH_LABEL(), selected, 2)
    ENDIF
ENDPROC

PROC DRAW_SPAWNER_ROW(INT index, FLOAT y)
    STRING faceLbl = TR("Facing", "Orientación", "朝向", "Blickrichtung", "向き", "Направление", "Direção", "Orientation")
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Spawn Selected Vehicle(s)", "Generar vehículo(s)", "生成所选载具", "Ausgewählte(s) Fahrzeug(e) spawnen", "選択した車両をスポーン", "Создать выбранный ТС", "Gerar Veículo(s) Selecionado(s)", "Faire apparaître véhicule(s)"), "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_VEHICLE_CATEGORY_SELECTOR(y, g_item = index) BREAK
        CASE 2 DRAW_VEHICLE_SPAWN_SELECTOR(y, g_item = index) BREAK
        CASE 3 DRAW_NUMBER_OPTION(y, TR("Spawn Count", "Cantidad a generar", "生成数量", "Spawn-Anzahl", "スポーン数", "Количество", "Quantidade", "Nombre à générer"), g_spawn_count, g_item = index) BREAK
        CASE 4 IF g_spawn_maxed DRAW_OPTION(y, TR("Max Available Upgrades", "Mejoras máximas disponibles", "满配可用改装", "Maximale Upgrades", "最大アップグレード", "Макс. улучшения", "Melhorias Máximas", "Améliorations max"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Max Available Upgrades", "Mejoras máximas disponibles", "满配可用改装", "Maximale Upgrades", "最大アップグレード", "Макс. улучшения", "Melhorias Máximas", "Améliorations max"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 IF g_spawn_alignment = 0 DRAW_OPTION(y, TR("Alignment", "Alineación", "排列方式", "Ausrichtung", "整列方式", "Выравнивание", "Alinhamento", "Alignement"), TR("< Door to Door >", "< Puerta a puerta >", "< 并排排列 >", "< Tür an Tür >", "< 横並び >", "< Борт к борту >", "< Lado a Lado >", "< Côte à côte >"), g_item = index, 3) ELSE DRAW_OPTION(y, TR("Alignment", "Alineación", "排列方式", "Ausrichtung", "整列方式", "Выравнивание", "Alinhamento", "Alignement"), TR("< Bumper to Bumper >", "< Parachoques a parachoques >", "< 前后排列 >", "< Stoßstange an Stoßstange >", "< 縦並び >", "< Бампер к бамперу >", "< Para-choque a Para-choque >", "< Pare-chocs contre pare-chocs >"), g_item = index, 3) ENDIF BREAK
        CASE 6
            IF g_spawn_facing = 0 DRAW_OPTION(y, faceLbl, TR("< Forward >", "< Adelante >", "< 向前 >", "< Vorwärts >", "< 前方 >", "< Вперед >", "< Frente >", "< Avant >"), g_item = index, 3)
            ELIF g_spawn_facing = 1 DRAW_OPTION(y, faceLbl, TR("< Right >", "< Derecha >", "< 向右 >", "< Rechts >", "< 右 >", "< Вправо >", "< Direita >", "< Droite >"), g_item = index, 3)
            ELIF g_spawn_facing = 2 DRAW_OPTION(y, faceLbl, TR("< Backward >", "< Atrás >", "< 向后 >", "< Rückwärts >", "< 後方 >", "< Назад >", "< Trás >", "< Arrière >"), g_item = index, 3)
            ELSE DRAW_OPTION(y, faceLbl, TR("< Left >", "< Izquierda >", "< 向左 >", "< Links >", "< 左 >", "< Влево >", "< Esquerda >", "< Gauche >"), g_item = index, 3) ENDIF
        BREAK
        CASE 7 IF g_delete_previous_spawned_vehicle DRAW_OPTION(y, TR("Auto Delete Previous Car", "Borrar coche anterior auto.", "自动删除上一辆车", "Vorheriges Auto autom. löschen", "前の車両を自動削除", "Автоудаление прошлой машины", "Excluir Carro Anterior Auto.", "Suppr. auto voiture précédente"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Auto Delete Previous Car", "Borrar coche anterior auto.", "自动删除上一辆车", "Vorheriges Auto autom. löschen", "前の車両を自動削除", "Автоудаление прошлой машины", "Excluir Carro Anterior Auto.", "Suppr. auto voiture précédente"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 8 DRAW_OPTION(y, TR("Delete All Custom Cars", "Borrar todos los coches", "删除所有生成载具", "Alle gespawnten Autos löschen", "生成した全車両を削除", "Удалить все созданные машины", "Excluir Todos os Carros Gerados", "Supprimer voitures générées"), "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_spawn_teleport_into_vehicle DRAW_OPTION(y, TR("TP in Spawned Vehicle", "TP dentro del vehículo", "传送进生成的载具", "In gespawntes Fahrzeug TP", "スポーン車両に乗車", "ТП в созданный транспорт", "TP para Dentro do Veículo", "TP dans le véhicule généré"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("TP in Spawned Vehicle", "TP dentro del vehículo", "传送进生成的载具", "In gespawntes Fahrzeug TP", "スポーン車両に乗車", "ТП в созданный транспорт", "TP para Dentro do Veículo", "TP dans le véhicule généré"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10
            DRAW_SPAWNER_VEHICLE_SEARCH(y, g_item = index)
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPAWNER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("VEHICLE SPAWNER", "GENERADOR DE VEHÍCULOS", "载具生成器", "FAHRZEUG-SPAWNER", "車両スポナー", "СПАВНЕР ТРАНСПОРТА", "GERADOR DE VEÍCULOS", "GÉNÉRATEUR DE VÉHICULES"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_spawner_scroll
    INT row = 0
    WHILE row < 8 AND index < 11
        DRAW_SPAWNER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_MISC_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_skip_cutscenes DRAW_OPTION(y, TR("Skip Cutscenes", "Saltar cinemáticas", "跳过过场动画", "Zwischensequenzen überspringen", "カットシーンをスキップ", "Пропуск катсцен", "Pular Cutscenes", "Passer les cinématiques"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Skip Cutscenes", "Saltar cinemáticas", "跳过过场动画", "Zwischensequenzen überspringen", "カットシーンをスキップ", "Пропуск катсцен", "Pular Cutscenes", "Passer les cinématiques"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, TR("Refresh Interior", "Recargar interior", "刷新室内场景", "Innenraum aktualisieren", "インテリアを再読込", "Обновить интерьер", "Atualizar Interior", "Actualiser l'intérieur"), "APPLY", g_item = index, 2) BREAK
        CASE 2 IF g_npc_brawl DRAW_OPTION(y, TR("Nearby NPC Brawl", "Pelea de NPC cercanos", "附近 NPC 乱斗", "NPC-Schlägerei in der Nähe", "周囲のNPC乱闘", "Драка NPC рядом", "Briga de NPCs Próximos", "Bagarre de PNJ proches"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Nearby NPC Brawl", "Pelea de NPC cercanos", "附近 NPC 乱斗", "NPC-Schlägerei in der Nähe", "周囲のNPC乱闘", "Драка NPC рядом", "Briga de NPCs Próximos", "Bagarre de PNJ proches"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_everyone_ignores DRAW_OPTION(y, TR("Everyone Ignores Player", "Todos ignoran al jugador", "所有人无视玩家", "Jeder ignoriert Spieler", "全員がプレイヤーを無視", "Все игнорируют игрока", "Todos Ignoram o Jogador", "Tout le monde ignore le joueur"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Everyone Ignores Player", "Todos ignoran al jugador", "所有人无视玩家", "Jeder ignoriert Spieler", "全員がプレイヤーを無視", "Все игнорируют игрока", "Todos Ignoram o Jogador", "Tout le monde ignore le joueur"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_low_population DRAW_OPTION(y, TR("Low Population", "Baja población", "低人口密度", "Geringe Bevölkerung", "低人口モード", "Мало людей и машин", "Baixa População", "Faible population"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Low Population", "Baja población", "低人口密度", "Geringe Bevölkerung", "低人口モード", "Мало людей и машин", "Baixa População", "Faible population"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_NPC_DENSITY_SELECTOR(y, g_item = index) BREAK
        // "NPC Vehicle Speed" used to be row 6 here. Removed in batch38: the
        // torque cheat does not survive this port's traffic handling, so the
        // row never had a visible effect. Rows below shifted up by one.
        CASE 6 DRAW_OPTION(y, TR("Clear Nearby Vehicles", "Limpiar vehículos cercanos", "清除附近载具", "Fahrzeuge in der Nähe löschen", "周囲の車両を消去", "Очистить транспорт рядом", "Limpar Veículos Próximos", "Supprimer véhicules proches"), "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Clear Nearby Peds", "Limpiar peatones cercanos", "清除附近行人", "PEDs in der Nähe löschen", "周囲のNPCを消去", "Очистить педов рядом", "Limpar Pedestres Próximos", "Supprimer PNJ proches"), "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Explode All Vehicles", "Explotar todos los vehículos", "引爆所有载具", "Alle Fahrzeuge sprengen", "全車両を爆破", "Взорвать весь транспорт", "Explodir Todos os Veículos", "Exploser tous les véhicules"), "APPLY", g_item = index, 2) BREAK
        CASE 9 IF g_first_person DRAW_OPTION(y, TR("Force First Person", "Forzar primera persona", "强制第一人称", "Erste Person erzwingen", "一人称視点強制", "Принудительно от 1-го лица", "Forçar Primeira Pessoa", "Forcer la première personne"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Force First Person", "Forzar primera persona", "强制第一人称", "Erste Person erzwingen", "一人称視点強制", "Принудительно от 1-го лица", "Forçar Primeira Pessoa", "Forcer la première personne"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 10 IF g_hud_hidden DRAW_OPTION(y, TR("Hide HUD", "Ocultar HUD", "隐藏 HUD", "HUD ausblenden", "HUDを非表示", "Скрыть интерфейс", "Ocultar HUD", "Masquer le HUD"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Hide HUD", "Ocultar HUD", "隐藏 HUD", "HUD ausblenden", "HUDを非表示", "Скрыть интерфейс", "Ocultar HUD", "Masquer le HUD"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 11 IF g_radar_hidden DRAW_OPTION(y, TR("Hide Radar", "Ocultar radar", "隐藏雷达小地图", "Radar ausblenden", "レーダーを非表示", "Скрыть радар", "Ocultar Radar", "Masquer le radar"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Hide Radar", "Ocultar radar", "隐藏雷达小地图", "Radar ausblenden", "レーダーを非表示", "Скрыть радар", "Ocultar Radar", "Masquer le radar"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 12 DRAW_STRIPPER_SELECTOR(y, g_item = index) BREAK
        CASE 13 IF g_show_live_coords DRAW_OPTION(y, TR("Show Live Coordinates", "Mostrar coordenadas en vivo", "显示实时坐标", "Live-Koordinaten anzeigen", "現在座標を表示", "Показывать координаты", "Mostrar Coordenadas ao Vivo", "Afficher coordonnées en direct"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Show Live Coordinates", "Mostrar coordenadas en vivo", "显示实时坐标", "Live-Koordinaten anzeigen", "現在座標を表示", "Показывать координаты", "Mostrar Coordenadas ao Vivo", "Afficher coordonnées en direct"), "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TELEPORT_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Teleport to Waypoint", "TP al marcador", "传送到导航点", "Zum Wegpunkt teleportieren", "ウェイポイントへテレポート", "ТП к метке на карте", "Teleportar ao Marcador", "Téléporter au repère"), "APPLY", g_item = index, 2) BREAK
        CASE 1 IF g_auto_waypoint DRAW_OPTION(y, TR("Auto Teleport Waypoint", "Auto TP al marcador", "自动传送到导航点", "Auto-TP zum Wegpunkt", "自動ウェイポイントTP", "Авто-ТП к метке", "Auto TP ao Marcador", "TP auto au repère"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Auto Teleport Waypoint", "Auto TP al marcador", "自动传送到导航点", "Auto-TP zum Wegpunkt", "自動ウェイポイントTP", "Авто-ТП к метке", "Auto TP ao Marcador", "TP auto au repère"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 DRAW_OPTION(y, TR("Robbable Stores", "Tiendas atracables", "可抢劫商店", "Ausraubbare Läden", "強盗可能な店舗", "Магазины для ограбления", "Lojas Assaltáveis", "Magasins braquables"), "OPEN", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Teleport to Objective", "TP al objetivo", "传送到任务目标", "Zum Ziel teleportieren", "目的地へテレポート", "ТП к цели задания", "Teleportar ao Objetivo", "Téléporter à l'objectif"), "APPLY", g_item = index, 2) BREAK
        CASE 4 IF g_auto_objective DRAW_OPTION(y, TR("Auto Teleport Objective", "Auto TP al objetivo", "自动传送到任务目标", "Auto-TP zum Ziel", "自動目的地TP", "Авто-ТП к цели", "Auto TP ao Objetivo", "TP auto à l'objectif"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Auto Teleport Objective", "Auto TP al objetivo", "自动传送到任务目标", "Auto-TP zum Ziel", "自動目的地TP", "Авто-ТП к цели", "Auto TP ao Objetivo", "TP auto à l'objectif"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_OPTION(y, TR("Locations", "Ubicaciones", "地点列表", "Orte", "ロケーション", "Локации", "Locais", "Lieux"), "OPEN", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Nudge Forward", "Mover adelante", "向前微移", "Nach vorne rücken", "少し前へ移動", "Сдвиг вперед", "Mover para Frente", "Avancer légèrement"), "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Nudge Backward", "Mover atrás", "向后微移", "Nach hinten rücken", "少し後ろへ移動", "Сдвиг назад", "Mover para Trás", "Reculer légèrement"), "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Nudge Up", "Mover arriba", "向上微移", "Nach oben rücken", "少し上へ移動", "Сдвиг вверх", "Mover para Cima", "Monter légèrement"), "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, TR("Nudge Down", "Mover abajo", "向下微移", "Nach unten rücken", "少し下へ移動", "Сдвиг вниз", "Mover para Baixo", "Descendre légèrement"), "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_FLOAT_OPTION(y, TR("Coordinate X", "Coordenada X", "X 坐标", "Koordinate X", "X座標", "Координата X", "Coordenada X", "Coordonnée X"), g_teleport_x, g_item = index) BREAK
        CASE 11 DRAW_FLOAT_OPTION(y, TR("Coordinate Y", "Coordenada Y", "Y 坐标", "Koordinate Y", "Y座標", "Координата Y", "Coordenada Y", "Coordonnée Y"), g_teleport_y, g_item = index) BREAK
        CASE 12 DRAW_FLOAT_OPTION(y, TR("Coordinate Z", "Coordenada Z", "Z 坐标", "Koordinate Z", "Z座標", "Координата Z", "Coordenada Z", "Coordonnée Z"), g_teleport_z, g_item = index) BREAK
        CASE 13 DRAW_OPTION(y, TR("Teleport to Coordinates", "TP a coordenadas", "传送到指定坐标", "Zu Koordinaten teleportieren", "座標へテレポート", "ТП по координатам", "Teleportar às Coordenadas", "Téléporter aux coordonnées"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_STORE_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Teleport To Gas Store 1", "TP a Gasolinera 1", "传送到加油站商店 1", "TP zu Tankstelle 1", "ガソリンスタンド 1 へTP", "ТП к заправке 1", "TP para Posto 1", "TP Station-service 1"), "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, TR("Teleport To Gas Store 2", "TP a Gasolinera 2", "传送到加油站商店 2", "TP zu Tankstelle 2", "ガソリンスタンド 2 へTP", "ТП к заправке 2", "TP para Posto 2", "TP Station-service 2"), "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Teleport To Gas Store 3", "TP a Gasolinera 3", "传送到加油站商店 3", "TP zu Tankstelle 3", "ガソリンスタンド 3 へTP", "ТП к заправке 3", "TP para Posto 3", "TP Station-service 3"), "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Teleport To Gas Store 4", "TP a Gasolinera 4", "传送到加油站商店 4", "TP zu Tankstelle 4", "ガソリンスタンド 4 へTP", "ТП к заправке 4", "TP para Posto 4", "TP Station-service 4"), "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Teleport To Gas Store 5", "TP a Gasolinera 5", "传送到加油站商店 5", "TP zu Tankstelle 5", "ガソリンスタンド 5 へTP", "ТП к заправке 5", "TP para Posto 5", "TP Station-service 5"), "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Teleport To Liquor Store 1", "TP a Licorería 1", "传送到酒水店 1", "TP zu Spirituosenladen 1", "酒屋 1 へTP", "ТП к винному магазину 1", "TP para Loja de Bebidas 1", "TP Caviste 1"), "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Teleport To Liquor Store 2", "TP a Licorería 2", "传送到酒水店 2", "TP zu Spirituosenladen 2", "酒屋 2 へTP", "ТП к винному магазину 2", "TP para Loja de Bebidas 2", "TP Caviste 2"), "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Teleport To Liquor Store 3", "TP a Licorería 3", "传送到酒水店 3", "TP zu Spirituosenladen 3", "酒屋 3 へTP", "ТП к винному магазину 3", "TP para Loja de Bebidas 3", "TP Caviste 3"), "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Teleport To Liquor Store 4", "TP a Licorería 4", "传送到酒水店 4", "TP zu Spirituosenladen 4", "酒屋 4 へTP", "ТП к винному магазину 4", "TP para Loja de Bebidas 4", "TP Caviste 4"), "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, TR("Teleport To Liquor Store 5", "TP a Licorería 5", "传送到酒水店 5", "TP zu Spirituosenladen 5", "酒屋 5 へTP", "ТП к винному магазину 5", "TP para Loja de Bebidas 5", "TP Caviste 5"), "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, TR("Teleport To Market 1", "TP a Supermercado 1", "传送到超市 1", "TP zu Supermarkt 1", "マーケット 1 へTP", "ТП к магазину 1", "TP para Mercado 1", "TP Supérette 1"), "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, TR("Teleport To Market 2", "TP a Supermercado 2", "传送到超市 2", "TP zu Supermarkt 2", "マーケット 2 へTP", "ТП к магазину 2", "TP para Mercado 2", "TP Supérette 2"), "APPLY", g_item = index, 2) BREAK
        CASE 12 DRAW_OPTION(y, TR("Teleport To Market 3", "TP a Supermercado 3", "传送到超市 3", "TP zu Supermarkt 3", "マーケット 3 へTP", "ТП к магазину 3", "TP para Mercado 3", "TP Supérette 3"), "APPLY", g_item = index, 2) BREAK
        CASE 13 DRAW_OPTION(y, TR("Teleport To Market 4", "TP a Supermercado 4", "传送到超市 4", "TP zu Supermarkt 4", "マーケット 4 へTP", "ТП к магазину 4", "TP para Mercado 4", "TP Supérette 4"), "APPLY", g_item = index, 2) BREAK
        CASE 14 DRAW_OPTION(y, TR("Teleport To Market 5", "TP a Supermercado 5", "传送到超市 5", "TP zu Supermarkt 5", "マーケット 5 へTP", "ТП к магазину 5", "TP para Mercado 5", "TP Supérette 5"), "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, TR("Teleport To Market 6", "TP a Supermercado 6", "传送到超市 6", "TP zu Supermarkt 6", "マーケット 6 へTP", "ТП к магазину 6", "TP para Mercado 6", "TP Supérette 6"), "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, TR("Teleport To Market 7", "TP a Supermercado 7", "传送到超市 7", "TP zu Supermarkt 7", "マーケット 7 へTP", "ТП к магазину 7", "TP para Mercado 7", "TP Supérette 7"), "APPLY", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, TR("Teleport To Market 8", "TP a Supermercado 8", "传送到超市 8", "TP zu Supermarkt 8", "マーケット 8 へTP", "ТП к магазину 8", "TP para Mercado 8", "TP Supérette 8"), "APPLY", g_item = index, 2) BREAK
        CASE 18 DRAW_OPTION(y, TR("Teleport To Market 9", "TP a Supermercado 9", "传送到超市 9", "TP zu Supermarkt 9", "マーケット 9 へTP", "ТП к магазину 9", "TP para Mercado 9", "TP Supérette 9"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_STORES_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("ROBBABLE STORES", "TIENDAS ATRACABLES", "可抢劫商店", "AUSRAUBBARE LÄDEN", "強盗可能な店舗", "МАГАЗИНЫ ДЛЯ ОГРАБЛЕНИЯ", "LOJAS ASSALTÁVEIS", "MAGASINS BRAQUABLES"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_tp_stores_scroll
    INT row = 0
    WHILE row < 8 AND index < 19
        DRAW_TP_STORE_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_TP_LOCATION_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Mount Chiliad", "Monte Chiliad", "奇利亚德山", "Mount Chiliad", "チリアド山", "Гора Чилиад", "Monte Chiliad", "Mont Chiliad"), "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_OPTION(y, TR("Maze Bank Tower", "Torre Maze Bank", "花园银行大厦", "Maze Bank Tower", "メイズバンク・タワー", "Башня Maze Bank", "Maze Bank Tower", "Tour Maze Bank"), "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Los Santos Airport", "Aeropuerto de Los Santos", "洛圣都国际机场", "Flughafen Los Santos", "ロスサントス国際空港", "Аэропорт Лос-Сантоса", "Aeroporto de Los Santos", "Aéroport de Los Santos"), "APPLY", g_item = index, 2) BREAK
        CASE 3 DRAW_OPTION(y, TR("Vinewood Sign", "Letrero de Vinewood", "好麦坞招牌", "Vinewood-Schild", "バインウッドの看板", "Знак Вайнвуд", "Letreiro de Vinewood", "Panneau Vinewood"), "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Fort Zancudo", "Fort Zancudo", "桑库多堡垒", "Fort Zancudo", "フォート・ザンクード", "Форт-Занкудо", "Fort Zancudo", "Fort Zancudo"), "APPLY", g_item = index, 2) BREAK
        CASE 5 DRAW_OPTION(y, TR("Grove Street", "Grove Street", "格罗夫街", "Grove Street", "グローブ・ストリート", "Грув-стрит", "Grove Street", "Grove Street"), "APPLY", g_item = index, 2) BREAK
        CASE 6 DRAW_OPTION(y, TR("Franklin's House", "Casa de Franklin", "富兰克林的家", "Franklins Haus", "フランクリンの家", "Дом Франклина", "Casa do Franklin", "Maison de Franklin"), "APPLY", g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Michael's House", "Casa de Michael", "麦克的家", "Michaels Haus", "マイケルの家", "Дом Майкла", "Casa do Michael", "Maison de Michael"), "APPLY", g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Trevor's Trailer", "Caravana de Trevor", "崔佛的拖车", "Trevors Wohnwagen", "トレバーのトレーラー", "Трейлер Тревора", "Trailer do Trevor", "Caravane de Trevor"), "APPLY", g_item = index, 2) BREAK
        CASE 9 DRAW_OPTION(y, TR("Lester's Warehouse", "Almacén de Lester", "莱斯特的仓库", "Lesters Lagerhaus", "レスターの倉庫", "Склад Лестера", "Galpão do Lester", "Entrepôt de Lester"), "APPLY", g_item = index, 2) BREAK
        CASE 10 DRAW_OPTION(y, TR("Simeon's Dealership", "Concesionario de Simeon", "西米恩车行", "Simeons Autohaus", "シミオンのディーラー", "Автосалон Симона", "Concessionária do Simeon", "Concession de Simeon"), "APPLY", g_item = index, 2) BREAK
        CASE 11 DRAW_OPTION(y, TR("Hospital", "Hospital", "医院", "Krankenhaus", "病院", "Больница", "Hospital", "Hôpital"), "APPLY", g_item = index, 2) BREAK
        CASE 12 DRAW_OPTION(y, TR("Police Station", "Comisaría", "警察局", "Polizeistation", "警察署", "Полицейский участок", "Delegacia", "Commissariat"), "APPLY", g_item = index, 2) BREAK
        CASE 13 DRAW_OPTION(y, TR("Ammu-Nation", "Ammu-Nation", "武装国度", "Ammu-Nation", "アミュネーション", "Амму-Нация", "Ammu-Nation", "Ammu-Nation"), "APPLY", g_item = index, 2) BREAK
        CASE 14 DRAW_OPTION(y, TR("Los Santos Customs", "Los Santos Customs", "洛圣都改车王", "Los Santos Customs", "ロスサントス・カスタム", "Los Santos Customs", "Los Santos Customs", "Los Santos Customs"), "APPLY", g_item = index, 2) BREAK
        CASE 15 DRAW_OPTION(y, TR("North Yankton", "North Yankton", "北扬克顿", "North Yankton", "ノース・ヤンクトン", "Северный Янктон", "North Yankton", "North Yankton"), "APPLY", g_item = index, 2) BREAK
        CASE 16 DRAW_OPTION(y, TR("Cayo Perico", "Cayo Perico", "佩里科岛", "Cayo Perico", "カヨ・ペリコ", "Кайо-Перико", "Cayo Perico", "Cayo Perico"), "APPLY", g_item = index, 2) BREAK
        CASE 17 DRAW_OPTION(y, TR("Sandy Shores Airfield", "Aeródromo de Sandy Shores", "沙滩海岸机场", "Flugplatz Sandy Shores", "サンディ海岸飛行場", "Аэродром Сэнди-Шорс", "Aeródromo de Sandy Shores", "Aérodrome de Sandy Shores"), "APPLY", g_item = index, 2) BREAK
        CASE 18 DRAW_OPTION(y, TR("IAA Building", "Edificio de la IAA", "IAA 大楼", "IAA-Gebäude", "IAAビル", "Здание ЦУР", "Edifício da IAA", "Bâtiment de l'IAA"), "APPLY", g_item = index, 2) BREAK
        CASE 19 DRAW_OPTION(y, TR("Mount Gordo", "Monte Gordo", "戈多山", "Mount Gordo", "ゴルド山", "Гора Гордо", "Monte Gordo", "Mont Gordo"), "APPLY", g_item = index, 2) BREAK
        CASE 20 DRAW_OPTION(y, TR("Diamond Casino", "Casino Diamond", "名钻假日赌场", "Diamond Casino", "ダイヤモンドカジノ", "Казино Diamond", "Cassino Diamond", "Diamond Casino"), "APPLY", g_item = index, 2) BREAK
        CASE 21 DRAW_OPTION(y, TR("Humane Labs", "Laboratorios Humane", "人道实验室", "Humane Labs", "ヒューメイン研究所", "Лаборатория Humane", "Laboratórios Humane", "Laboratoires Humane"), "APPLY", g_item = index, 2) BREAK
        CASE 22 DRAW_OPTION(y, TR("Bolingbroke Prison", "Prisión de Bolingbroke", "博林布鲁克监狱", "Bolingbroke-Gefängnis", "ボーリングブローク刑務所", "Тюрьма Болингброук", "Prisão de Bolingbroke", "Prison de Bolingbroke"), "APPLY", g_item = index, 2) BREAK
        CASE 23 DRAW_OPTION(y, TR("Paleto Bay", "Paleto Bay", "佩立托湾", "Paleto Bay", "パレト・ベイ", "Палето-Бэй", "Paleto Bay", "Paleto Bay"), "APPLY", g_item = index, 2) BREAK
        CASE 24 DRAW_OPTION(y, TR("Cayo Airstrip", "Pista de Cayo Perico", "佩里科岛机场跑道", "Cayo-Flugfeld", "カヨ・滑走路", "ВПП Кайо-Перико", "Pista de Cayo Perico", "Piste de Cayo Perico"), "APPLY", g_item = index, 2) BREAK
        CASE 25 DRAW_OPTION(y, TR("Cayo Main Dock", "Muelle principal de Cayo", "佩里科岛主码头", "Cayo-Hauptdock", "カヨ・メインドック", "Главный док Кайо", "Doca Principal de Cayo", "Quai principal de Cayo"), "APPLY", g_item = index, 2) BREAK
        CASE 26 DRAW_OPTION(y, TR("Cayo North Dock", "Muelle norte de Cayo", "佩里科岛北码头", "Cayo-Norddock", "カヨ・ノースドック", "Северный док Кайо", "Doca Norte de Cayo", "Quai nord de Cayo"), "APPLY", g_item = index, 2) BREAK
        CASE 27 DRAW_OPTION(y, TR("Cayo Mansion", "Mansión de Cayo Perico", "佩里科岛庄园", "Cayo-Villa", "カヨ・屋敷", "Особняк Кайо-Перико", "Mansão de Cayo Perico", "Manoir de Cayo Perico"), "APPLY", g_item = index, 2) BREAK
        CASE 28 DRAW_OPTION(y, TR("Cayo Beach Party", "Fiesta en la playa de Cayo", "佩里科岛海滩派对", "Cayo-Strandparty", "カヨ・ビーチパーティー", "Пляжная вечеринка Кайо", "Festa na Praia de Cayo", "Fête sur la plage de Cayo"), "APPLY", g_item = index, 2) BREAK
        CASE 29 DRAW_OPTION(y, TR("Cayo Control Tower", "Torre de control de Cayo", "佩里科岛控制塔", "Cayo-Kontrollturm", "カヨ・管制塔", "Вышка связи Кайо", "Torre de Controle de Cayo", "Tour de contrôle de Cayo"), "APPLY", g_item = index, 2) BREAK
        CASE 30 DRAW_OPTION(y, TR("Salvage Yard", "Desguace", "回收站", "Schrottplatz", "サルベージヤード", "Утилизационный цех", "Ferro-velho", "Casse automobile"), "APPLY", g_item = index, 2) BREAK
        CASE 31 DRAW_OPTION(y, TR("Darnell Bros. Chop Shop", "Taller de Darnell Bros.", "达内尔兄弟拆车厂", "Darnell Bros. Werkstatt", "ダーネル・ブラザーズ工場", "Цех братьев Дарнелл", "Desmanche Darnell Bros.", "Atelier Darnell Bros."), "APPLY", g_item = index, 2) BREAK
        CASE 32 DRAW_OPTION(y, TR("Gunrunning Bunker", "Búnker de tráfico de armas", "军火贸易地堡", "Gunrunning-Bunker", "銃器密造バンカー", "Бункер торговли оружием", "Bunker de Tráfico de Armas", "Bunker Trafic d'armes"), "APPLY", g_item = index, 2) BREAK
        CASE 33 DRAW_OPTION(y, TR("Doomsday Facility", "Instalaciones del Juicio Final", "末日豪劫设施", "Weltuntergangs-Basis", "ドゥームズ・デイ施設", "База Судного дня", "Complexo do Juízo Final", "Complexe Fin du monde"), "APPLY", g_item = index, 2) BREAK
        CASE 34 DRAW_OPTION(y, TR("Dignity Party Yacht", "Yate de fiesta Dignity", "尊严号派对游艇", "Dignity-Partyyacht", "ディグニティ・パーティーヨット", "Яхта Dignity", "Iate Dignity", "Yacht Dignity"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_TP_LOCATIONS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("LOCATIONS", "UBICACIONES", "地点列表", "ORTE", "ロケーション", "ЛОКАЦИИ", "LOCAIS", "LIEUX"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_tp_locs_scroll
    INT row = 0
    WHILE row < 8 AND index < 35
        DRAW_TP_LOCATION_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

// DRAW_LSC_ROW used to live here. It was an unused duplicate of the live LSC
// row table (util_vehicle_catalog's DRAW_LSC_SCROLL_ROWS) and had drifted out
// of sync with it (no "Return To Stock" row, every index after it shifted), so
// it was removed rather than left as a trap for the next edit.

PROC DRAW_SCROLLING_ROWS(INT total, INT rowType)
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < total
        FLOAT y = 0.268 + (TO_FLOAT(row) * ROW_H)
        IF rowType = 0 DRAW_PLAYER_ROW(index, y) ENDIF
        IF rowType = 1 DRAW_VEHICLE_ROW(index, y) ENDIF
        IF rowType = 2 DRAW_MISC_ROW(index, y) ENDIF
        IF rowType = 3 DRAW_TELEPORT_ROW(index, y) ENDIF
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_WORLD_PAGE()
    INT worldIndex = g_scroll
    INT worldRow = 0
    WHILE worldRow < 8 AND worldIndex < 17
        DRAW_WORLD_ROW(worldIndex, 0.268 + (TO_FLOAT(worldRow) * ROW_H))
        worldIndex = worldIndex + 1
        worldRow = worldRow + 1
    ENDWHILE
ENDPROC

PROC DRAW_WEAPON_PAGE()
    IF g_weapon_upgrades_open
        DRAW_WEAPON_UPGRADES_PAGE()
        EXIT
    ENDIF
    INT weaponIndex = g_scroll
    INT weaponRow = 0
    WHILE weaponRow < 8 AND weaponIndex < 10
        FLOAT y = 0.268 + (TO_FLOAT(weaponRow) * ROW_H)
        IF weaponIndex = 0 DRAW_OPTION(y, TR("Give All Weapons", "Dar todas las armas", "获取所有武器", "Alle Waffen geben", "全武器を入手", "Выдать всё оружие", "Dar Todas as Armas", "Donner toutes les armes"), "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 1 DRAW_MENU_WEAPON_SELECTOR(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 2
            IF g_infinite_ammo DRAW_OPTION(y, TR("Infinite Ammo", "Munición infinita", "无限弹药", "Unendlich Munition", "無限弾薬", "Бесконечные патроны", "Munição Infinita", "Munitions infinies"), "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, TR("Infinite Ammo", "Munición infinita", "无限弹药", "Unendlich Munition", "無限弾薬", "Бесконечные патроны", "Munição Infinita", "Munitions infinies"), "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 3
            IF g_infinite_clip DRAW_OPTION(y, TR("Infinite Clip", "Cargador infinito", "无需换弹", "Unendlich Magazin", "リロード不要", "Без перезарядки", "Pente Infinito", "Chargeur infini"), "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, TR("Infinite Clip", "Cargador infinito", "无需换弹", "Unendlich Magazin", "リロード不要", "Без перезарядки", "Pente Infinito", "Chargeur infini"), "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 4 DRAW_OPTION(y, TR("Refill All Ammo", "Recargar toda la munición", "补满所有弹药", "Alle Munition auffüllen", "全弾薬を補充", "Пополнить боезапас", "Recarregar Toda Munição", "Recharger toutes les munitions"), "APPLY", g_item = weaponIndex, 2) ENDIF
        IF weaponIndex = 5 DRAW_WEAPON_UPGRADES_ENTRY(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 6
            IF g_explosive_ammo DRAW_OPTION(y, TR("Explosive Bullets", "Balas explosivas", "爆炸子弹", "Explosive Munition", "爆発弾", "Взрывные пули", "Balas Explosivas", "Balles explosives"), "ON", g_item = weaponIndex, 1) ELSE DRAW_OPTION(y, TR("Explosive Bullets", "Balas explosivas", "爆炸子弹", "Explosive Munition", "爆発弾", "Взрывные пули", "Balas Explosivas", "Balles explosives"), "OFF", g_item = weaponIndex, 0) ENDIF
        ENDIF
        IF weaponIndex = 7 DRAW_SPECIAL_GUN_SELECTOR(y, g_item = weaponIndex) ENDIF
        IF weaponIndex = 8 DRAW_OPTION(y, TR("Remove Current Weapon", "Quitar arma actual", "移除当前武器", "Aktuelle Waffe entfernen", "現在の武器を削除", "Убрать текущее оружие", "Remover Arma Atual", "Retirer l'arme actuelle"), "APPLY", g_item = weaponIndex, 0) ENDIF
        IF weaponIndex = 9 DRAW_OPTION(y, TR("Remove All Weapons", "Quitar todas las armas", "移除所有武器", "Alle Waffen entfernen", "全武器を削除", "Убрать всё оружие", "Remover Todas as Armas", "Retirer toutes les armes"), "APPLY", g_item = weaponIndex, 2) ENDIF
        weaponIndex = weaponIndex + 1
        weaponRow = weaponRow + 1
    ENDWHILE
ENDPROC

PROC DRAW_SPOONER_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    SWITCH index
        CASE 0 DRAW_OPTION(y, TR("Prop Catalog", "Catálogo de objetos", "物件目录", "Prop-Katalog", "プロップカタログ", "Каталог объектов", "Catálogo de Objetos", "Catalogue d'objets"), SPOONER_CATALOG_LABEL(g_spooner_catalog_index), selected, -1) BREAK
        CASE 1 DRAW_OPTION(y, TR("Custom Model / Hash", "Modelo / Hash personalizado", "自定义模型 / 哈希", "Eigenes Modell / Hash", "カスタムモデル / ハッシュ", "Своя модель / Хэш", "Modelo / Hash Personalizado", "Modèle / Hash personnalisé"), SPOONER_CUSTOM_INPUT_LABEL(), selected, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Spawn Selected Prop", "Generar objeto seleccionado", "生成所选物件", "Ausgewähltes Prop spawnen", "選択したプロップをスポーン", "Создать выбранный объект", "Gerar Objeto Selecionado", "Faire apparaître l'objet"), SPOONER_SPAWN_STATUS_LABEL(), selected, 2) BREAK
        CASE 3 DRAW_SPOONER_PREVIEW_OPACITY_ROW(y, selected) BREAK
        CASE 4 DRAW_SPOONER_SELECTED_OBJECT_ROW(y, selected) BREAK
        CASE 5 DRAW_SPOONER_METRE_OPTION(y, TR("Forward Offset", "Desplazamiento frontal", "前后偏移", "Vorwärts-Versatz", "前後オフセット", "Смещение вперед", "Deslocamento Frontal", "Décalage avant"), g_spooner_forward_offset, selected) BREAK
        CASE 6 DRAW_SPOONER_METRE_OPTION(y, TR("Side Offset", "Desplazamiento lateral", "左右偏移", "Seiten-Versatz", "左右オフセット", "Смещение вбок", "Deslocamento Lateral", "Décalage latéral"), g_spooner_side_offset, selected) BREAK
        CASE 7 DRAW_SPOONER_METRE_OPTION(y, TR("Height Offset", "Desplazamiento vertical", "高度偏移", "Höhen-Versatz", "高さオフセット", "Смещение по высоте", "Deslocamento de Altura", "Décalage hauteur"), g_spooner_height_offset, selected) BREAK
        CASE 8 DRAW_SPOONER_DEGREE_OPTION(y, TR("Heading Rotation", "Rotación de rumbo", "朝向旋转", "Drehung (Heading)", "向き回転", "Поворот (курс)", "Rotação de Direção", "Rotation (cap)"), "", g_spooner_heading_offset, selected) BREAK
        CASE 9
            IF g_spooner_freeze_pos
                DRAW_OPTION(y, TR("Freeze Position", "Congelar posición", "固定位置", "Position einfrieren", "位置を固定", "Заморозить позицию", "Congelar Posição", "Figer la position"), "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, TR("Freeze Position", "Congelar posición", "固定位置", "Position einfrieren", "位置を固定", "Заморозить позицию", "Congelar Posição", "Figer la position"), "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 10
            IF g_spooner_collision
                DRAW_OPTION(y, TR("Object Collision", "Colisión del objeto", "物件碰撞", "Objektkollision", "オブジェクト衝突判定", "Коллизия объекта", "Colisão do Objeto", "Collision de l'objet"), "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, TR("Object Collision", "Colisión del objeto", "物件碰撞", "Objektkollision", "オブジェクト衝突判定", "Коллизия объекта", "Colisão do Objeto", "Collision de l'objet"), "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 11
            IF g_player_freecam
                DRAW_OPTION(y, TR("Free Cam", "Cámara libre", "自由视角", "Freie Kamera", "フリーカメラ", "Свободная камера", "Câmera Livre", "Caméra libre"), "ON", selected, 1)
            ELSE
                DRAW_OPTION(y, TR("Free Cam", "Cámara libre", "自由视角", "Freie Kamera", "フリーカメラ", "Свободная камера", "Câmera Livre", "Caméra libre"), "OFF", selected, 0)
            ENDIF
        BREAK
        CASE 12 DRAW_OPTION(y, TR("Snap to Ground", "Ajustar al suelo", "贴合地面", "Am Boden ausrichten", "地面にスナップ", "Прижать к земле", "Alinhar ao Chão", "Coller au sol"), "APPLY", selected, 2) BREAK
        CASE 13 DRAW_OPTION(y, TR("Attach Target Bone", "Hueso de anclaje", "附加目标骨骼", "Zielknochen zum Anheften", "アタッチ先のボーン", "Кость привязки", "Osso de Fixação", "Os d'attache cible"), SPOONER_BONE_CHOICE_LABEL(g_spooner_bone_choice), selected, -1) BREAK
        CASE 14 DRAW_SPOONER_METRE_OPTION(y, TR("Attach Offset X", "Desplaz. de anclaje X", "附加偏移 X", "Anheft-Versatz X", "アタッチオフセット X", "Смещение привязки X", "Desloc. de Fixação X", "Décalage d'attache X"), g_spooner_attach_x, selected) BREAK
        CASE 15 DRAW_SPOONER_METRE_OPTION(y, TR("Attach Offset Y", "Desplaz. de anclaje Y", "附加偏移 Y", "Anheft-Versatz Y", "アタッチオフセット Y", "Смещение привязки Y", "Desloc. de Fixação Y", "Décalage d'attache Y"), g_spooner_attach_y, selected) BREAK
        CASE 16 DRAW_SPOONER_METRE_OPTION(y, TR("Attach Offset Z", "Desplaz. de anclaje Z", "附加偏移 Z", "Anheft-Versatz Z", "アタッチオフセット Z", "Смещение привязки Z", "Desloc. de Fixação Z", "Décalage d'attache Z"), g_spooner_attach_z, selected) BREAK
        CASE 17 DRAW_SPOONER_ROT_AXIS_ROW(y, selected) BREAK
        CASE 18 DRAW_OPTION(y, TR("Attach Selected to Player", "Anclar al jugador", "将所选物件附加到玩家", "An Spieler anheften", "選択物をプレイヤーに装着", "Прикрепить к игроку", "Fixar no Jogador", "Attacher au joueur"), SPOONER_ATTACH_ACTION_LABEL(), selected, SPOONER_ATTACH_ACTION_STATE()) BREAK
        CASE 19
            IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 4
                DRAW_OPTION(y, TR("Delete Last Object", "Borrar último objeto", "删除上一个物件", "Letztes Objekt löschen", "最後のオブジェクトを削除", "Удалить последний объект", "Excluir Último Objeto", "Supprimer le dernier objet"), "DELETED", selected, 1)
            ELSE
                DRAW_OPTION(y, TR("Delete Last Object", "Borrar último objeto", "删除上一个物件", "Letztes Objekt löschen", "最後のオブジェクトを削除", "Удалить последний объект", "Excluir Último Objeto", "Supprimer le dernier objet"), "APPLY", selected, 0)
            ENDIF
        BREAK
        CASE 20
            IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 5
                DRAW_OPTION(y, TR("Clear All Spawned Objects", "Borrar todos los objetos", "清除所有生成物件", "Alle gespawnten Objekte löschen", "全オブジェクトを消去", "Очистить все объекты", "Limpar Todos os Objetos", "Supprimer tous les objets"), "CLEARED", selected, 1)
            ELSE
                DRAW_OPTION(y, TR("Clear All Spawned Objects", "Borrar todos los objetos", "清除所有生成物件", "Alle gespawnten Objekte löschen", "全オブジェクトを消去", "Очистить все объекты", "Limpar Todos os Objetos", "Supprimer tous les objets"), "APPLY", selected, 0)
            ENDIF
        BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_SPOONER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("OBJECT SPOONER", "GENERADOR DE OBJETOS", "物件编辑器", "OBJEKT-SPOONER", "オブジェクトスプーナー", "СПАВНЕР ОБЪЕКТОВ", "GERADOR DE OBJETOS", "ÉDITEUR D'OBJETS"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < SPOONER_MENU_ROWS
        DRAW_SPOONER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_NSC_LOADER_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    TEXT_LABEL_63 rowBadge = ""
    IF index = 0
        rowBadge = FORMAT_NSC_PROBE_BADGE()
        DRAW_OPTION(y, TR("Add Custom .nsc", "Añadir .nsc personalizado", "添加自定义 .nsc", "Eigenes .nsc hinzufügen", "カスタム .nsc を追加", "Добавить свой .nsc", "Adicionar .nsc Personalizado", "Ajouter .nsc personnalisé"), rowBadge, selected, 2)
        EXIT
    ENDIF
    IF index = 1
        DRAW_OPTION(y, TR("VM Stack Size", "Tamaño de pila VM", "虚拟机栈大小", "VM-Stack-Größe", "VMスタックサイズ", "Размер стека VM", "Tamanho da Pilha VM", "Taille de pile VM"), NSC_STACK_LABEL_FROM_CHOICE(g_nsc_stack_choice), selected, -1)
        EXIT
    ENDIF
    IF index = 2
        rowBadge = FORMAT_NSC_STOP_ALL_BADGE()
        DRAW_OPTION(y, TR("Stop All Custom Scripts", "Detener todos los scripts", "停止所有自定义脚本", "Alle eigenen Skripte stoppen", "全カスタムスクリプト停止", "Остановить все скрипты", "Parar Todos os Scripts", "Arrêter tous les scripts"), rowBadge, selected, 0)
        EXIT
    ENDIF
    IF COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS() > 0 AND index = 3
        DRAW_OPTION(y, TR("Unload Scripts", "Descargar scripts", "卸载脚本", "Skripte entladen", "スクリプトをアンロード", "Выгрузить скрипты", "Descarregar Scripts", "Décharger les scripts"), "OPEN", selected, 2)
        EXIT
    ENDIF
    INT slot = index - NSC_LOADER_HEADER_ROWS()
    INT badgeState = 2
    TEXT_LABEL_63 rowLabel = FORMAT_CUSTOM_NSC_ROW_LABEL(slot)
    rowBadge = FORMAT_CUSTOM_NSC_ROW_BADGE(slot, badgeState)
    DRAW_OPTION(y, rowLabel, rowBadge, selected, badgeState)
ENDPROC

PROC DRAW_NSC_LOADER_PAGE()
    SYNC_CUSTOM_NSC_THREAD_STATES()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("CUSTOM NSC LOADER", "CARGADOR NSC PERSONALIZADO", "自定义 NSC 加载器", "CUSTOM-NSC-LOADER", "カスタムNSCローダー", "ЗАГРУЗЧИК СВОИХ NSC", "CARREGADOR NSC PERSONALIZADO", "CHARGEUR NSC PERSONNALISÉ"))
    DRAW_MENU_VERSION_TAG()
    INT totalRows = NSC_LOADER_TOTAL_ROWS()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_NSC_LOADER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_NSC_UNLOAD_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    INT slot = NSC_GET_ACTIVE_SLOT_FOR_INDEX(index)
    IF slot >= 0
        TEXT_LABEL_63 rowLabel = FORMAT_CUSTOM_NSC_ROW_LABEL(slot)
        DRAW_OPTION(y, rowLabel, "REMOVE", selected, 0)
    ENDIF
ENDPROC

PROC DRAW_NSC_UNLOAD_PAGE()
    SYNC_CUSTOM_NSC_THREAD_STATES()
    INT totalRows = COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
    IF totalRows <= 0
        g_nsc_unload_open = FALSE
        g_item = g_nsc_loader_item
        g_scroll = g_nsc_loader_scroll
        IF g_item >= 3 g_item = 2 ENDIF
        IF g_item >= NSC_LOADER_TOTAL_ROWS()
            g_item = NSC_LOADER_TOTAL_ROWS() - 1
        ENDIF
        IF g_item < 0 g_item = 0 ENDIF
        DRAW_NSC_LOADER_PAGE()
        EXIT
    ENDIF
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("UNLOAD SCRIPTS", "DESCARGAR SCRIPTS", "卸载脚本", "SKRIPTE ENTLADEN", "スクリプトのアンロード", "ВЫГРУЗКА СКРИПТОВ", "DESCARREGAR SCRIPTS", "DÉCHARGER LES SCRIPTS"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_NSC_UNLOAD_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_READONLY_OPTION(FLOAT y, STRING label, BOOL selected)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        IF g_accent_choice = 12
            rr = 95
            gg = 100
            bb = 110
        ELSE
            rr = 45
            gg = 48
            bb = 56
        ENDIF
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, g_accent_r, g_accent_g, g_accent_b, label)
ENDPROC

PROC DRAW_CREDITS_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    SWITCH index
        CASE 0 DRAW_READONLY_OPTION(y, TR("Join the Discord Server", "Únete al servidor de Discord", "加入 Discord 服务器", "Tritt dem Discord-Server bei", "Discordサーバーに参加", "Присоединяйтесь к Discord", "Entre no Servidor do Discord", "Rejoindre le serveur Discord"), selected) BREAK
        CASE 1 DRAW_READONLY_OPTION(y, "Geekmaxxer", selected) BREAK
        CASE 2 DRAW_READONLY_OPTION(y, "lenniix3", selected) BREAK
        CASE 3 DRAW_READONLY_OPTION(y, "maritoguionyo", selected) BREAK
        CASE 4 DRAW_READONLY_OPTION(y, "ShinyWasabi", selected) BREAK
        CASE 5 DRAW_READONLY_OPTION(y, "xandercade", selected) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_CREDITS_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("CREDITS", "CRÉDITOS", "制作人员", "CREDITS", "クレジット", "АВТОРЫ", "CRÉDITOS", "CRÉDITS"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < CREDITS_MENU_ROWS
        DRAW_CREDITS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_LANGUAGE_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    STRING label = "English"
    SWITCH index
        CASE 0 label = TR("English", "Inglés (English)", "", "Englisch (English)", "", "Английский (English)", "Inglês (English)", "Anglais (English)") BREAK
        CASE 1 label = TR("Spanish", "Español", "", "Spanisch (Español)", "", "Испанский (Español)", "Espanhol (Español)", "Espagnol (Español)") BREAK
        CASE 2 label = TR("German", "Alemán (Deutsch)", "", "Deutsch", "", "Немецкий (Deutsch)", "Alemão (Deutsch)", "Allemand (Deutsch)") BREAK
        CASE 3 label = TR("Russian", "Ruso (Русский)", "", "Russisch (Русский)", "", "Русский", "Russo (Русский)", "Russe (Русский)") BREAK
        CASE 4 label = TR("Portuguese", "Português", "", "Portugiesisch (Português)", "", "Португальский (Português)", "Português", "Portugais (Português)") BREAK
        CASE 5 label = TR("French", "Francés (Français)", "", "Französisch (Français)", "", "Французский (Français)", "Francês (Français)", "Français") BREAK
    ENDSWITCH
    IF g_menu_language = index
        DRAW_OPTION(y, label, "SELECTED", selected, 1)
    ELSE
        DRAW_OPTION(y, label, "APPLY", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_LANGUAGE_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("LANGUAGE", "IDIOMA", "语言", "SPRACHE", "言語", "ЯЗЫК", "IDIOMA", "LANGUE"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < LANGUAGE_MENU_ROWS
        DRAW_LANGUAGE_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_MENU_SETTINGS_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    STRING respawnLbl = TR("Enable Custom Respawn", "Activar reaparición pers.", "启用自定义重生", "Eigenen Respawn aktivieren", "カスタムリスポーン有効化", "Своя точка возрождения", "Ativar Renascimento Pers.", "Activer réapparition perso")
    STRING persistLbl = TR("Persistent Settings", "Ajustes persistentes", "持久化设置", "Dauerhafte Einstellungen", "設定の保存・管理", "Сохранение настроек", "Configurações Persistentes", "Paramètres persistants")
    STRING creditsLbl = TR("Credits", "Créditos", "制作人员", "Credits", "クレジット", "Авторы", "Créditos", "Crédits")
    IF index = 0
        DRAW_OPTION(y, TR("Language", "Idioma", "语言", "Sprache", "言語", "Язык", "Idioma", "Langue"), "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 1
        DRAW_OPTION(y, TR("Object Spooner", "Generador de objetos", "物件编辑器", "Objekt-Spooner", "オブジェクトスプーナー", "Спавнер объектов", "Gerador de Objetos", "Éditeur d'objets"), "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 2
        DRAW_OPTION(y, TR("Custom NSC Loader", "Cargador NSC personalizado", "自定义 NSC 加载器", "Custom-NSC-Loader", "カスタムNSCローダー", "Загрузчик своих NSC", "Carregador NSC Personalizado", "Chargeur NSC personnalisé"), "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 3
        DRAW_OPTION(y, TR("ScriptHookV-NX Plugins", "Plugins ScriptHookV-NX", "ScriptHookV-NX 插件管理", "ScriptHookV-NX Plugins", "ScriptHookV-NX プラグイン", "Плагины ScriptHookV-NX", "Plugins ScriptHookV-NX", "Plugins ScriptHookV-NX"), "OPEN", selected, 2)
        EXIT
    ENDIF
    IF index = 4
        DRAW_ACCENT_SELECTOR(y, selected)
        EXIT
    ENDIF
    IF g_accent_choice = 14
        SWITCH index
            CASE 5 DRAW_ACCENT_RGB_SPEED_SELECTOR(y, selected) BREAK
            CASE 6 DRAW_RESPAWN_SELECTOR(y, selected) BREAK
            CASE 7
                IF g_respawn_at_death DRAW_OPTION(y, respawnLbl, "ON", selected, 1) ELSE DRAW_OPTION(y, respawnLbl, "OFF", selected, 0) ENDIF
            BREAK
            CASE 8 DRAW_MENU_X_SELECTOR(y, selected) BREAK
            CASE 9 DRAW_MENU_Y_SELECTOR(y, selected) BREAK
            CASE 10 DRAW_MENU_COMBO_SELECTOR(y, selected) BREAK
            CASE 11 DRAW_OPTION(y, persistLbl, "OPEN", selected, 2) BREAK
            CASE 12 DRAW_OPTION(y, creditsLbl, "OPEN", selected, 2) BREAK
        ENDSWITCH
    ELSE
        SWITCH index
            CASE 5 DRAW_RESPAWN_SELECTOR(y, selected) BREAK
            CASE 6
                IF g_respawn_at_death DRAW_OPTION(y, respawnLbl, "ON", selected, 1) ELSE DRAW_OPTION(y, respawnLbl, "OFF", selected, 0) ENDIF
            BREAK
            CASE 7 DRAW_MENU_X_SELECTOR(y, selected) BREAK
            CASE 8 DRAW_MENU_Y_SELECTOR(y, selected) BREAK
            CASE 9 DRAW_MENU_COMBO_SELECTOR(y, selected) BREAK
            CASE 10 DRAW_OPTION(y, persistLbl, "OPEN", selected, 2) BREAK
            CASE 11 DRAW_OPTION(y, creditsLbl, "OPEN", selected, 2) BREAK
        ENDSWITCH
    ENDIF
ENDPROC

PROC DRAW_MENU_SETTINGS_PAGE()
    INT totalRows = 12
    IF g_accent_choice = 14 totalRows = 13 ENDIF
    INT index = g_scroll
    INT row = 0
    WHILE row < 8 AND index < totalRows
        DRAW_MENU_SETTINGS_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_PAGE()
    INT titleR = 255
    INT titleG = 255
    INT titleB = 255
    IF g_accent_choice = 10
        titleR = 35
        titleG = 45
        titleB = 65
    ENDIF
    DRAW_MENU_BACKDROP()
    DRAW_RECT(g_menu_x - 0.015, MENU_TOP + g_menu_y, MENU_W, 0.102, g_accent_r, g_accent_g, g_accent_b, 255)
    DRAW_RECT(g_menu_x - 0.015, 0.210 + g_menu_y, MENU_W, 0.035, 0, 0, 0, 255)
    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(titleR, titleG, titleB, 255)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_KEYBOARD_DISPLAY("MEGATARD")
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x - 0.079, 0.100 + g_menu_y)
    MENU_TEXT(g_menu_x - 0.085, 0.158, 0.390, titleR, titleG, titleB, TR("Made by: @Geekmaxxer", "Creado por: @Geekmaxxer", "作者: @Geekmaxxer", "Erstellt von: @Geekmaxxer", "制作: @Geekmaxxer", "Автор: @Geekmaxxer", "Feito por: @Geekmaxxer", "Créé par : @Geekmaxxer"))
    SWITCH g_tab
        CASE 0
            IF g_outfit_open
                DRAW_OUTFIT_PAGE()
            ELIF g_radio_open
                DRAW_RADIO_PAGE()
            ELIF g_bodyguard_open
                IF g_guard_ped_open
                    DRAW_GUARD_PED_PAGE()
                ELSE
                    DRAW_BODYGUARD_PAGE()
                ENDIF
            ELIF g_attacker_open
                IF g_attacker_ped_open
                    DRAW_ATTACKER_PED_PAGE()
                ELSE
                    DRAW_ATTACKER_PAGE()
                ENDIF
            ELIF g_ped_open
                IF g_story_ped_picker_open
                    DRAW_STORY_PED_PICKER_PAGE()
                ELIF g_story_peds_open
                    DRAW_CUSTOM_STORY_PEDS_PAGE()
                ELSE
                    DRAW_PED_PAGE()
                ENDIF
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("PLAYER SETTINGS", "AJUSTES DE JUGADOR", "玩家设置", "SPIELEREINSTELLUNGEN", "プレイヤー設定", "НАСТРОЙКИ ИГРОКА", "CONFIGURAÇÕES DO JOGADOR", "PARAMÈTRES DU JOUEUR"))
                DRAW_MENU_VERSION_TAG()
                DRAW_SCROLLING_ROWS(ITEM_COUNT(), 0)
            ENDIF
        BREAK
        CASE 1
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WEAPON SETTINGS", "AJUSTES DE ARMAS", "武器设置", "WAFFENEINSTELLUNGEN", "武器設定", "НАСТРОЙКИ ОРУЖИЯ", "CONFIGURAÇÕES DE ARMAS", "PARAMÈTRES DES ARMES"))
            DRAW_MENU_VERSION_TAG()
            DRAW_WEAPON_PAGE()
        BREAK
        CASE 2
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WANTED LEVEL SETTINGS", "NIVEL DE BÚSQUEDA", "通缉等级设置", "FAHNDUNGSLEVEL", "手配度設定", "УРОВЕНЬ РОЗЫСКА", "NÍVEL DE PROCURADO", "NIVEAU DE RECHERCHE"))
            DRAW_MENU_VERSION_TAG()
            IF g_never_wanted DRAW_OPTION(0.268, TR("Never Wanted", "Nunca buscado", "永不通缉", "Nie gesucht", "手配度なし", "Никогда не разыскивается", "Nunca Procurado", "Jamais recherché"), "ON", g_item = 0, 1) ELSE DRAW_OPTION(0.268, TR("Never Wanted", "Nunca buscado", "永不通缉", "Nie gesucht", "手配度なし", "Никогда не разыскивается", "Nunca Procurado", "Jamais recherché"), "OFF", g_item = 0, 0) ENDIF
            DRAW_OPTION(0.306, TR("Clear Wanted Level", "Limpiar nivel de búsqueda", "清除通缉等级", "Fahndungslevel löschen", "手配度を消去", "Сбросить уровень розыска", "Limpar Nível de Procurado", "Effacer indice de recherche"), "APPLY", g_item = 1, 2)
            DRAW_WANTED_LEVEL_SELECTOR(0.344, g_item = 2)
            IF g_ignore_police DRAW_OPTION(0.382, TR("Police Ignore Player", "La policía ignora al jugador", "警察无视玩家", "Polizei ignoriert Spieler", "警察がプレイヤーを無視", "Полиция игнорирует игрока", "Polícia Ignora o Jogador", "La police ignore le joueur"), "ON", g_item = 3, 1) ELSE DRAW_OPTION(0.382, TR("Police Ignore Player", "La policía ignora al jugador", "警察无视玩家", "Polizei ignoriert Spieler", "警察がプレイヤーを無視", "Полиция игнорирует игрока", "Polícia Ignora o Jogador", "La police ignore le joueur"), "OFF", g_item = 3, 0) ENDIF
            IF g_dispatch DRAW_OPTION(0.420, TR("Dispatch Services", "Servicios de emergencia", "派遣紧急服务", "Einsatzkräfte", "緊急サービス派遣", "Экстренные службы", "Serviços de Emergência", "Services d'urgence"), "ON", g_item = 4, 1) ELSE DRAW_OPTION(0.420, TR("Dispatch Services", "Servicios de emergencia", "派遣紧急服务", "Einsatzkräfte", "緊急サービス派遣", "Экстренные службы", "Serviços de Emergência", "Services d'urgence"), "OFF", g_item = 4, 0) ENDIF
            IF g_civilian_reports DRAW_OPTION(0.458, TR("Civilian Reports", "Denuncias de civiles", "市民报警", "Zivilisten-Meldungen", "市民の通報", "Сообщения гражданских", "Denúncias de Civis", "Signalements civils"), "ON", g_item = 5, 1) ELSE DRAW_OPTION(0.458, TR("Civilian Reports", "Denuncias de civiles", "市民报警", "Zivilisten-Meldungen", "市民の通報", "Сообщения гражданских", "Denúncias de Civis", "Signalements civils"), "OFF", g_item = 5, 0) ENDIF
        BREAK
        CASE 3
            // Chauffeur is tested before the LSC child pages for the same
            // reason they are tested before g_lsc_open: the four flags below
            // are mutually exclusive, but the child pages must win while the
            // parent flag is still set.
            IF g_chauffeur_open
                IF g_chauffeur_armed_open
                    DRAW_CHAUFFEUR_ARMED_PAGE()
                ELIF g_chauffeur_vehicle_open
                    DRAW_CHAUFFEUR_VEHICLE_PAGE()
                ELIF g_chauffeur_ped_open
                    DRAW_CHAUFFEUR_PED_PAGE()
                ELSE
                    DRAW_CHAUFFEUR_PAGE()
                ENDIF
            ELIF g_spawner_open
                DRAW_SPAWNER_PAGE()
            ELIF g_neon_anim_open
                DRAW_NEON_ANIM_PAGE()
            ELIF g_vehicle_control_open
                DRAW_VEHICLE_CONTROL_PAGE()
            ELIF g_hydro_open
                DRAW_HYDRO_PAGE()
            ELIF g_interior_open
                DRAW_INTERIOR_PAGE()
            ELIF g_wheeltyre_open
                DRAW_WHEELTYRE_PAGE()
            ELIF g_lsc_extras_open
                DRAW_LSC_EXTRAS_PAGE()
            ELIF g_bennys_open
                DRAW_BENNYS_PAGE()
            ELIF g_support_open
                DRAW_SUPPORT_PAGE()
            ELIF g_lsc_open
                DRAW_LSC_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("VEHICLE SETTINGS", "AJUSTES DE VEHÍCULO", "载具设置", "FAHRZEUGEINSTELLUNGEN", "車両設定", "НАСТРОЙКИ ТРАНСПОРТА", "CONFIGURAÇÕES DE VEÍCULO", "PARAMÈTRES DU VÉHICULE"))
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(28, 1)
            ENDIF
        BREAK
        CASE 4
            IF g_timeweather_open
                DRAW_TIMEWEATHER_PAGE()
            ELIF g_mayhem_open
                DRAW_WORLD_MAYHEM_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WORLD AND WEATHER", "MUNDO Y CLIMA", "世界与天气", "WELT UND WETTER", "ワールド＆天候", "МИР И ПОГОДА", "MUNDO E CLIMA", "MONDE ET MÉTÉO"))
            DRAW_MENU_VERSION_TAG()
            DRAW_WORLD_PAGE()
            ENDIF
        BREAK
        CASE 5
            IF g_tp_stores_open
                DRAW_TP_STORES_PAGE()
            ELIF g_tp_locs_open
                DRAW_TP_LOCATIONS_PAGE()
            ELSE
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("TELEPORT LOCATIONS", "TELETRANSPORTE", "传送地点", "TELEPORT-ORTE", "テレポート", "ТЕЛЕПОРТАЦИЯ", "TELEPORTE", "TÉLÉPORTATION"))
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(14, 3)
            ENDIF
        BREAK
        CASE 6
            MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("MISC AND NPC", "VARIOS Y NPC", "杂项与 NPC", "SONSTIGES & NPC", "その他＆NPC", "РАЗНОЕ И NPC", "DIVERSOS E NPC", "DIVERS ET PNJ"))
            DRAW_MENU_VERSION_TAG()
            DRAW_SCROLLING_ROWS(MISC_MENU_ROWS, 2)
        BREAK
        CASE 7
            IF g_language_open
                DRAW_LANGUAGE_PAGE()
            ELIF g_spooner_open
                DRAW_SPOONER_PAGE()
            ELIF g_nsc_unload_open
                DRAW_NSC_UNLOAD_PAGE()
            ELIF g_nsc_loader_open
                DRAW_NSC_LOADER_PAGE()
            ELIF g_plugin_mgr_open
                DRAW_PLUGIN_MGR_PAGE()
            ELIF g_credits_open
                DRAW_CREDITS_PAGE()
            ELIF g_persist_open
                DRAW_PERSIST_PAGE()
            ELSE
                MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("MENU SETTINGS", "AJUSTES DEL MENÚ", "菜单设置", "MENÜEINSTELLUNGEN", "メニュー設定", "НАСТРОЙКИ МЕНЮ", "CONFIGURAÇÕES DO MENU", "PARAMÈTRES DU MENU"))
                DRAW_MENU_VERSION_TAG()
                DRAW_MENU_SETTINGS_PAGE()
            ENDIF
        BREAK
    ENDSWITCH
    DRAW_PAGE_COUNTER()
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
ENDPROC
