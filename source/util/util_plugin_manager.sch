// Manager v3: startup policy and cooperative execution are separate from mapping.
// Kill Process cancels execution without invalidating native handlers or pointers.
USING "commands_scripthook_nx.sch"

FUNC BOOL PLUGIN_MGR_BRIDGE_READY()
    IF NOT SHVNX_AVAILABLE(1481659953, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481655089, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481657905, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481659185, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481659441, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481658956, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481657393, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481658417, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481658418, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481655601, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481657137, 1397249614) RETURN FALSE ENDIF
    IF NOT SHVNX_AVAILABLE(1481658929, 1397249614) RETURN FALSE ENDIF
    RETURN SHVNX_PLUGIN_MANAGER_VERSION() >= 3
ENDFUNC

PROC SYNC_PLUGIN_MGR_LIST()
    INT now = GET_GAME_TIMER()
    INT slot = 0
    INT status = 0
    INT memKb = 0
    INT plugStep = 0
    IF g_plugin_mgr_next_sync > now EXIT ENDIF
    g_plugin_mgr_next_sync = now + 500
    g_plugin_mgr_ready = PLUGIN_MGR_BRIDGE_READY()
    IF NOT g_plugin_mgr_ready
        g_plugin_mgr_count = 0
        g_plugin_mgr_detail_open = FALSE
        g_plugin_mgr_slot = -1
        EXIT
    ENDIF
    g_plugin_mgr_count = SHVNX_GET_PLUGIN_COUNT()
    IF g_plugin_mgr_count > PLUGIN_MGR_MAX_PLUGINS g_plugin_mgr_count = PLUGIN_MGR_MAX_PLUGINS ENDIF
    IF g_plugin_mgr_count < 0 g_plugin_mgr_count = 0 ENDIF
    WHILE slot < g_plugin_mgr_count
        g_plugin_mgr_names[slot] = SHVNX_GET_PLUGIN_NAME(slot)
        status = 0
        memKb = 0
        plugStep = 0
        IF SHVNX_GET_PLUGIN_STATUS(slot, status, memKb, plugStep)
            g_plugin_mgr_states[slot] = status
            g_plugin_mgr_memory[slot] = memKb
        ELSE
            g_plugin_mgr_states[slot] = 2
            g_plugin_mgr_memory[slot] = 0
        ENDIF
        g_plugin_mgr_policies[slot] = SHVNX_GET_PLUGIN_POLICY(slot)
        g_plugin_mgr_status_text[slot] = SHVNX_GET_PLUGIN_STATUS_TEXT(slot)
        g_plugin_mgr_running[slot] = SHVNX_IS_PLUGIN_RUNNING(slot)
        slot = slot + 1
    ENDWHILE
    IF g_plugin_mgr_detail_open
        IF g_plugin_mgr_slot < 0 OR g_plugin_mgr_slot >= g_plugin_mgr_count
            g_plugin_mgr_detail_open = FALSE
            g_plugin_mgr_slot = -1
            g_item = g_plugin_mgr_item
            g_scroll = g_plugin_mgr_scroll
        ELIF g_plugin_mgr_feedback = 1
            IF g_plugin_mgr_states[g_plugin_mgr_slot] = 1 OR g_plugin_mgr_states[g_plugin_mgr_slot] = 5
                g_plugin_mgr_feedback = 3
            ELIF g_plugin_mgr_states[g_plugin_mgr_slot] = 7
                g_plugin_mgr_feedback = 6
            ELIF g_plugin_mgr_states[g_plugin_mgr_slot] = 6
                g_plugin_mgr_feedback = 5
            ELIF g_plugin_mgr_states[g_plugin_mgr_slot] = 2
                g_plugin_mgr_feedback = -1
            ENDIF
        ELIF g_plugin_mgr_feedback = 4
            IF NOT g_plugin_mgr_running[g_plugin_mgr_slot]
                g_plugin_mgr_feedback = 5
            ENDIF
        ENDIF
    ENDIF
ENDPROC

FUNC INT PLUGIN_MGR_TOTAL_ROWS()
    IF NOT g_plugin_mgr_ready RETURN 2 ENDIF
    IF g_plugin_mgr_detail_open RETURN 7 ENDIF
    IF g_plugin_mgr_count > 0 RETURN 1 + g_plugin_mgr_count ENDIF
    RETURN 2
ENDFUNC

FUNC STRING PLUGIN_MGR_POLICY_LABEL(INT policy)
    IF policy = 2 RETURN TR("Auto", "Auto", "自动", "Auto", "自動", "Авто", "Auto", "Auto") ENDIF
    IF policy = 1 RETURN TR("Manual", "Manual", "手动", "Manuell", "手動", "Вручную", "Manual", "Manuel") ENDIF
    RETURN TR("Disabled", "Desactivado", "禁用", "Deaktiviert", "無効", "Отключено", "Desativado", "Désactivé")
ENDFUNC

FUNC STRING PLUGIN_MGR_STATE_LABEL(INT status)
    SWITCH status
        CASE 0 RETURN PLUGIN_MGR_POLICY_LABEL(0) BREAK
        CASE 1 RETURN TR("RUNNING", "EJECUTANDO", "运行中", "LÄUFT", "実行中", "РАБОТАЕТ", "EXECUTANDO", "EN COURS") BREAK
        CASE 3 RETURN TR("QUEUED", "EN COLA", "已排队", "EINGEREIHT", "待機中", "В ОЧЕРЕДИ", "NA FILA", "EN ATTENTE") BREAK
        CASE 4 RETURN TR("READY", "LISTO", "就绪", "BEREIT", "待機中", "ГОТОВ", "PRONTO", "PRÊT") BREAK
        CASE 5 RETURN TR("RESTART", "REINICIAR", "需重启", "NEUSTART", "再起動", "ПЕРЕЗАПУСК", "REINICIAR", "REDÉMARRER") BREAK
        CASE 6 RETURN TR("STOPPED", "DETENIDO", "已停止", "GESTOPPT", "停止済み", "ОСТАНОВЛЕН", "PARADO", "ARRÊTÉ") BREAK
        CASE 7 RETURN TR("FINISHED", "FINALIZADO", "已结束", "BEENDET", "終了済み", "ЗАВЕРШЁН", "CONCLUÍDO", "TERMINÉ") BREAK
    ENDSWITCH
    RETURN "ERROR"
ENDFUNC

FUNC TEXT_LABEL_31 PLUGIN_MGR_SHORT_NAME(INT slot)
    TEXT_LABEL_31 label = g_plugin_mgr_names[slot]
    IF GET_LENGTH_OF_LITERAL_STRING(label) > 20
        label = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(label, 0, 18)
        label += ".."
    ENDIF
    RETURN label
ENDFUNC

PROC PLUGIN_MGR_ANNOUNCE(STRING message)
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
ENDPROC

PROC DRAW_PLUGIN_MGR_ROW(INT index, FLOAT y)
    BOOL selected = (g_item = index)
    INT slot = index - 1
    INT colorState = 2
    TEXT_LABEL_31 value = ""
    TEXT_LABEL_31 label = ""
    IF NOT g_plugin_mgr_ready
        IF index = 0
            DRAW_OPTION(y, TR("Bridge unavailable", "Puente no disponible", "桥接不可用", "Bridge nicht verfügbar", "ブリッジ未接続", "Мост недоступен", "Ponte indisponível", "Passerelle indisponible"), "OFFLINE", selected, 0)
        ELSE
            DRAW_OPTION(y, TR("Install matched subsdk5", "Instala subsdk5 compatible", "安装配套 subsdk5", "Passendes subsdk5 nutzen", "対応するsubsdk5を導入", "Установите нужный subsdk5", "Instale subsdk5 compatível", "Installer subsdk5 associé"), "", selected, 2)
        ENDIF
        EXIT
    ENDIF
    IF g_plugin_mgr_detail_open
        slot = g_plugin_mgr_slot
        IF slot < 0 OR slot >= g_plugin_mgr_count EXIT ENDIF
        SWITCH index
            CASE 0
                DRAW_OPTION(y, TR("Load Now", "Cargar ahora", "立即加载", "Jetzt laden", "今すぐ読込", "Загрузить сейчас", "Carregar agora", "Charger maintenant"), "APPLY", selected, 2)
                BREAK
            CASE 1
                value = "< "
                value += PLUGIN_MGR_POLICY_LABEL(g_plugin_mgr_policy_choice)
                value += " >"
                IF g_plugin_mgr_policy_choice != g_plugin_mgr_policies[slot] value += " *" ENDIF
                DRAW_OPTION(y, TR("Startup Mode", "Modo de inicio", "启动模式", "Startmodus", "起動モード", "Режим запуска", "Modo de início", "Mode de démarrage"), value, selected, 2)
                BREAK
            CASE 2
                DRAW_OPTION(y, TR("Runtime", "Estado actual", "运行状态", "Laufzeit", "現在の状態", "Состояние", "Estado atual", "État actuel"), PLUGIN_MGR_STATE_LABEL(g_plugin_mgr_states[slot]), selected, 2)
                BREAK
            CASE 3
                DRAW_NUMBER_OPTION(y, TR("Mapped Memory (KiB)", "Memoria asignada (KiB)", "映射内存 (KiB)", "Belegter Speicher (KiB)", "割当メモリ (KiB)", "Память (КиБ)", "Memória alocada (KiB)", "Mémoire allouée (Kio)"), g_plugin_mgr_memory[slot], selected)
                BREAK
            CASE 4
                value = "--"
                IF g_plugin_mgr_feedback = 1 value = PLUGIN_MGR_STATE_LABEL(3) ENDIF
                IF g_plugin_mgr_feedback = 2 value = TR("SAVED", "GUARDADO", "已保存", "GESPEICHERT", "保存済み", "СОХРАНЕНО", "SALVO", "ENREGISTRÉ") ENDIF
                IF g_plugin_mgr_feedback = 3 value = PLUGIN_MGR_STATE_LABEL(1) ENDIF
                IF g_plugin_mgr_feedback = 4 value = PLUGIN_MGR_STATE_LABEL(3) ENDIF
                IF g_plugin_mgr_feedback = 5 value = PLUGIN_MGR_STATE_LABEL(6) ENDIF
                IF g_plugin_mgr_feedback = 6 value = PLUGIN_MGR_STATE_LABEL(7) ENDIF
                IF g_plugin_mgr_feedback < 0 value = "ERROR" ENDIF
                DRAW_OPTION(y, TR("Last Request", "Última solicitud", "上次请求", "Letzte Anfrage", "最後の操作", "Последний запрос", "Último pedido", "Dernière demande"), value, selected, 2)
                BREAK
            CASE 5
                DRAW_NUMBER_OPTION(y, TR("Request Error", "Error de solicitud", "请求错误", "Anfragefehler", "操作エラー", "Ошибка запроса", "Erro do pedido", "Erreur de demande"), g_plugin_mgr_action_error, selected)
                BREAK
            CASE 6
                value = TR("INACTIVE", "INACTIVO", "未运行", "INAKTIV", "非実行", "НЕАКТИВЕН", "INATIVO", "INACTIF")
                IF g_plugin_mgr_running[slot] value = "APPLY" ENDIF
                DRAW_OPTION(y, TR("Kill Process", "Detener proceso", "终止进程", "Prozess stoppen", "プロセス停止", "Остановить процесс", "Parar processo", "Arrêter le processus"), value, selected, 2)
                BREAK
        ENDSWITCH
        EXIT
    ENDIF
    IF index = 0
        DRAW_OPTION(y, TR("Rescan Plugins", "Buscar plugins", "重新扫描插件", "Plugins suchen", "プラグインを再走査", "Поиск плагинов", "Buscar plugins", "Analyser les plugins"), "APPLY", selected, 2)
        EXIT
    ENDIF
    IF g_plugin_mgr_count <= 0
        DRAW_OPTION(y, TR("No plugins installed", "No hay plugins", "未安装插件", "Keine Plugins installiert", "プラグインなし", "Плагины не установлены", "Nenhum plugin instalado", "Aucun plugin installé"), "EMPTY", selected, 2)
        EXIT
    ENDIF
    IF slot >= 0 AND slot < g_plugin_mgr_count
        IF g_plugin_mgr_states[slot] = 1 colorState = 1 ENDIF
        IF g_plugin_mgr_states[slot] = 2 colorState = 0 ENDIF
        label = PLUGIN_MGR_SHORT_NAME(slot)
        DRAW_OPTION(y, label, PLUGIN_MGR_STATE_LABEL(g_plugin_mgr_states[slot]), selected, colorState)
    ENDIF
ENDPROC

PROC DRAW_PLUGIN_MGR_PAGE()
    INT index = 0
    INT row = 0
    INT totalRows = 0
    TEXT_LABEL_31 title = "SCRIPTHOOKV-NX PLUGINS"
    SYNC_PLUGIN_MGR_LIST()
    IF g_plugin_mgr_detail_open AND g_plugin_mgr_slot >= 0 AND g_plugin_mgr_slot < g_plugin_mgr_count
        title = PLUGIN_MGR_SHORT_NAME(g_plugin_mgr_slot)
    ENDIF
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, title)
    DRAW_MENU_VERSION_TAG()
    totalRows = PLUGIN_MGR_TOTAL_ROWS()
    IF g_item >= totalRows g_item = totalRows - 1 ENDIF
    IF g_item < 0 g_item = 0 ENDIF
    IF g_scroll > g_item g_scroll = g_item ENDIF
    IF g_item >= g_scroll + 8 g_scroll = g_item - 7 ENDIF
    IF g_scroll < 0 g_scroll = 0 ENDIF
    index = g_scroll
    WHILE row < 8 AND index < totalRows
        DRAW_PLUGIN_MGR_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC ADJUST_PLUGIN_MGR_SELECTOR(INT direction)
    IF NOT g_plugin_mgr_ready OR NOT g_plugin_mgr_detail_open OR g_item != 1 EXIT ENDIF
    g_plugin_mgr_policy_choice = g_plugin_mgr_policy_choice + direction
    IF g_plugin_mgr_policy_choice < 0 g_plugin_mgr_policy_choice = 2 ENDIF
    IF g_plugin_mgr_policy_choice > 2 g_plugin_mgr_policy_choice = 0 ENDIF
ENDPROC

PROC HANDLE_PLUGIN_MGR_APPLY(INT item)
    BOOL accepted = FALSE
    INT slot = 0
    INT requestedPolicy = 0
    INT confirmedPolicy = -1
    SYNC_PLUGIN_MGR_LIST()
    IF NOT g_plugin_mgr_ready EXIT ENDIF
    IF g_plugin_mgr_detail_open
        slot = g_plugin_mgr_slot
        IF slot < 0 OR slot >= g_plugin_mgr_count EXIT ENDIF
        IF item = 0
            accepted = SHVNX_LOAD_PLUGIN(slot)
            IF accepted
                g_plugin_mgr_feedback = 1
                PLUGIN_MGR_ANNOUNCE(TR("Load requested. Check Runtime for the result.", "Carga solicitada. Consulta el estado actual.", "已请求加载，请查看运行状态。", "Laden angefragt. Ergebnis unter Laufzeit prüfen.", "読込を要求しました。現在の状態を確認してください。", "Загрузка запрошена. Проверьте состояние.", "Carga solicitada. Confira o estado atual.", "Chargement demandé. Consultez l'état actuel."))
            ELSE
                g_plugin_mgr_feedback = -1
            ENDIF
        ELIF item = 1
            requestedPolicy = g_plugin_mgr_policy_choice
            accepted = SHVNX_SET_PLUGIN_POLICY(slot, requestedPolicy)
            g_plugin_mgr_action_error = SHVNX_GET_PLUGIN_ACTION_ERROR()
            confirmedPolicy = SHVNX_GET_PLUGIN_POLICY(slot)
            // Refresh filenames and actual policy now, not at the next timed poll.
            // Never announce success solely from the action's boolean result.
            g_plugin_mgr_next_sync = 0
            SYNC_PLUGIN_MGR_LIST()
            IF accepted AND confirmedPolicy = requestedPolicy AND g_plugin_mgr_policies[slot] = requestedPolicy
                g_plugin_mgr_feedback = 2
                g_plugin_mgr_policy_choice = confirmedPolicy
                PLUGIN_MGR_ANNOUNCE(TR("Startup mode saved and confirmed. Runtime changes only with Load Now or Kill Process.", "Inicio guardado y confirmado. Usa Cargar ahora o Detener proceso para cambiar la ejecución.", "启动模式已保存并确认。当前运行仅由立即加载或终止进程改变。", "Startmodus gespeichert und bestätigt. Laufzeit nur mit Jetzt laden oder Prozess stoppen ändern.", "起動モードを保存・確認。現在の実行は今すぐ読込かプロセス停止で変更します。", "Режим запуска сохранён и проверен. Для текущего запуска используйте загрузку или остановку.", "Modo salvo e confirmado. Use Carregar agora ou Parar processo para mudar a execução.", "Mode enregistré et vérifié. Utilisez Charger maintenant ou Arrêter le processus pour l'exécution."))
            ELSE
                g_plugin_mgr_feedback = -1
                IF confirmedPolicy >= 0 AND confirmedPolicy <= 2
                    g_plugin_mgr_policy_choice = confirmedPolicy
                ENDIF
                PLUGIN_MGR_ANNOUNCE(TR("Startup mode was not confirmed. The current saved mode is shown.", "No se confirmó el inicio. Se muestra el modo guardado actual.", "启动模式未确认，当前显示实际已保存的模式。", "Startmodus nicht bestätigt. Der aktuell gespeicherte Modus wird angezeigt.", "起動モードを確認できません。現在保存されたモードを表示します。", "Режим не подтверждён. Показан текущий сохранённый режим.", "Modo não confirmado. O modo salvo atual é exibido.", "Mode non confirmé. Le mode actuellement enregistré est affiché."))
            ENDIF
            EXIT
        ELIF item = 6
            // The cached badge can be up to 500 ms old; recheck before acting.
            IF NOT SHVNX_IS_PLUGIN_RUNNING(slot)
                g_plugin_mgr_next_sync = 0
                SYNC_PLUGIN_MGR_LIST()
                EXIT
            ENDIF
            accepted = SHVNX_KILL_PLUGIN(slot)
            IF accepted
                g_plugin_mgr_feedback = 4
                PLUGIN_MGR_ANNOUNCE(TR("Stop requested. Startup mode is unchanged; module memory stays resident.", "Parada solicitada. El inicio no cambia; la memoria del módulo permanece.", "已请求停止。启动模式不变，模块内存保持驻留。", "Stopp angefragt. Startmodus bleibt unverändert; Modulspeicher bleibt geladen.", "停止を要求。起動モードは変わらず、モジュールメモリは常駐します。", "Остановка запрошена. Режим запуска не меняется; память модуля остаётся.", "Parada solicitada. O início não muda; a memória do módulo permanece.", "Arrêt demandé. Le démarrage ne change pas ; la mémoire du module reste chargée."))
            ELSE
                g_plugin_mgr_feedback = -1
            ENDIF
        ELSE
            EXIT
        ENDIF
    ELSE
        IF item = 0
            accepted = SHVNX_RELOAD_PLUGINS()
            IF accepted
                g_plugin_mgr_feedback = 1
                PLUGIN_MGR_ANNOUNCE(TR("Rescan requested. Running plugins are kept.", "Búsqueda solicitada. Se conservan los plugins activos.", "已请求重新扫描，保留运行中的插件。", "Suche angefragt. Laufende Plugins bleiben erhalten.", "再走査を要求。実行中のプラグインは保持されます。", "Поиск запрошен. Работающие плагины сохранены.", "Busca solicitada. Plugins ativos são mantidos.", "Analyse demandée. Les plugins actifs sont conservés."))
            ELSE
                g_plugin_mgr_feedback = -1
            ENDIF
        ELSE
            slot = item - 1
            IF slot >= 0 AND slot < g_plugin_mgr_count
                g_plugin_mgr_item = g_item
                g_plugin_mgr_scroll = g_scroll
                g_plugin_mgr_slot = slot
                g_plugin_mgr_policy_choice = g_plugin_mgr_policies[slot]
                IF g_plugin_mgr_policy_choice < 0 OR g_plugin_mgr_policy_choice > 2 g_plugin_mgr_policy_choice = 0 ENDIF
                g_plugin_mgr_detail_open = TRUE
                g_plugin_mgr_feedback = 0
                g_plugin_mgr_action_error = 0
                g_item = 0
                g_scroll = 0
            ENDIF
            EXIT
        ENDIF
    ENDIF
    g_plugin_mgr_action_error = SHVNX_GET_PLUGIN_ACTION_ERROR()
    IF g_plugin_mgr_feedback < 0
        PLUGIN_MGR_ANNOUNCE(TR("Request rejected. Check Runtime and Request Error.", "Solicitud rechazada. Revisa el estado y el error.", "请求被拒绝，请查看运行状态和请求错误。", "Anfrage abgelehnt. Laufzeit und Fehler prüfen.", "要求が拒否されました。状態とエラーを確認してください。", "Запрос отклонён. Проверьте состояние и ошибку.", "Pedido rejeitado. Confira o estado e o erro.", "Demande refusée. Consultez l'état et l'erreur."))
    ENDIF
    g_plugin_mgr_next_sync = 0
ENDPROC
