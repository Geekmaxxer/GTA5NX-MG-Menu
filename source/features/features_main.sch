PROC DRAW_ATTACKER_MODEL(FLOAT y, BOOL selected)
    DRAW_OPTION(y, "Attacker PED:", g_attacker_ped_name, selected, 2)
ENDPROC

PROC DRAW_ATTACKER_WEAPON(FLOAT y, BOOL selected)
    SWITCH g_attacker_weapon_choice
        CASE 0 DRAW_OPTION(y, "Attacker Weapon:", "< Pistol >", selected, 3) BREAK
        CASE 1 DRAW_OPTION(y, "Attacker Weapon:", "< SMG >", selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, "Attacker Weapon:", "< Rifle >", selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, "Attacker Weapon:", "< Shotgun >", selected, 3) BREAK
    ENDSWITCH
ENDPROC

PROC START_ATTACKER_SPAWN()
    IF g_attacker_spawn_pending OR g_menu_attacker_count >= COUNT_OF(g_menu_attackers) EXIT ENDIF
    IF g_attacker_ped_search_is_custom
        g_pending_attacker_model = g_attacker_ped_model
    ELSE
        g_pending_attacker_model = PED_MODEL_FOR_CHOICE(g_attacker_ped_choice)
    ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(g_pending_attacker_model) OR NOT IS_MODEL_VALID(g_pending_attacker_model) EXIT ENDIF
    SWITCH g_attacker_weapon_choice
        CASE 0 g_pending_attacker_weapon = WEAPONTYPE_PISTOL BREAK
        CASE 1 g_pending_attacker_weapon = WEAPONTYPE_SMG BREAK
        CASE 2 g_pending_attacker_weapon = WEAPONTYPE_ASSAULTRIFLE BREAK
        CASE 3 g_pending_attacker_weapon = WEAPONTYPE_PUMPSHOTGUN BREAK
    ENDSWITCH
    REQUEST_MODEL(g_pending_attacker_model)
    g_attacker_spawn_pending = TRUE
    g_attacker_request_time = GET_GAME_TIMER()
ENDPROC

PROC FINISH_ATTACKER_SPAWN()
    PED_INDEX attacker
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 8.0, 0.0>>)
    attacker = CREATE_PED(PEDTYPE_CIVMALE, g_pending_attacker_model, spawnPosition, GET_ENTITY_HEADING(PLAYER_PED_ID()), FALSE, TRUE)
    IF DOES_ENTITY_EXIST(attacker)
        SET_ENTITY_AS_MISSION_ENTITY(attacker, TRUE, TRUE)
        GIVE_WEAPON_TO_PED(attacker, g_pending_attacker_weapon, 9999, TRUE, TRUE)
        SET_PED_AS_ENEMY(attacker, TRUE)
        SET_PED_RELATIONSHIP_GROUP_HASH(attacker, RELGROUPHASH_HATES_PLAYER)
        SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_PLAYER)
        SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_PLAYER, RELGROUPHASH_HATES_PLAYER)
        SET_PED_FLEE_ATTRIBUTES(attacker, FA_NEVER_FLEE, TRUE)
        SET_PED_COMBAT_ABILITY(attacker, CAL_PROFESSIONAL)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(attacker, TRUE)
        IF g_attacker_rage
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVFEMALE)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_HATES_PLAYER)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_COP)
            SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_COP, RELGROUPHASH_HATES_PLAYER)
            TASK_COMBAT_HATED_TARGETS_AROUND_PED(attacker, 100.0)
        ELSE
            TASK_COMBAT_PED(attacker, PLAYER_PED_ID())
        ENDIF
        SET_PED_KEEP_TASK(attacker, TRUE)
        SET_ENTITY_INVINCIBLE(attacker, g_attacker_god)
        IF g_menu_attacker_count < COUNT_OF(g_menu_attackers)
            g_menu_attackers[g_menu_attacker_count] = attacker
            g_menu_attacker_count = g_menu_attacker_count + 1
        ENDIF
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_attacker_model)
    g_attacker_spawn_pending = FALSE
ENDPROC

PROC RESTORE_ATTACKER_RELATIONSHIP_GROUPS()
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVMALE)
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_CIVMALE, RELGROUPHASH_HATES_PLAYER)
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVFEMALE)
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_HATES_PLAYER)
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_COP)
    SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_IGNORE, RELGROUPHASH_COP, RELGROUPHASH_HATES_PLAYER)
ENDPROC

PROC CLEAR_MENU_ATTACKERS()
    INT index = 0
    REPEAT g_menu_attacker_count index
        IF DOES_ENTITY_EXIST(g_menu_attackers[index])
            SET_ENTITY_AS_MISSION_ENTITY(g_menu_attackers[index], TRUE, TRUE)
            DELETE_PED(g_menu_attackers[index])
        ENDIF
    ENDREPEAT
    g_menu_attacker_count = 0
    RESTORE_ATTACKER_RELATIONSHIP_GROUPS()
ENDPROC

PROC APPLY_ATTACKER_RAGE_STATE()
    INT index = 0
    IF NOT g_attacker_rage
        RESTORE_ATTACKER_RELATIONSHIP_GROUPS()
    ENDIF
    REPEAT g_menu_attacker_count index
        IF DOES_ENTITY_EXIST(g_menu_attackers[index]) AND NOT IS_PED_INJURED(g_menu_attackers[index])
            IF g_attacker_rage
                SET_PED_AS_ENEMY(g_menu_attackers[index], TRUE)
                SET_PED_RELATIONSHIP_GROUP_HASH(g_menu_attackers[index], RELGROUPHASH_HATES_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_PLAYER, RELGROUPHASH_HATES_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVMALE)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVMALE, RELGROUPHASH_HATES_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_CIVFEMALE)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_CIVFEMALE, RELGROUPHASH_HATES_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_COP)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_COP, RELGROUPHASH_HATES_PLAYER)
                CLEAR_PED_TASKS(g_menu_attackers[index])
                TASK_COMBAT_HATED_TARGETS_AROUND_PED(g_menu_attackers[index], 100.0)
                SET_PED_KEEP_TASK(g_menu_attackers[index], TRUE)
            ELSE
                SET_PED_AS_ENEMY(g_menu_attackers[index], TRUE)
                SET_PED_RELATIONSHIP_GROUP_HASH(g_menu_attackers[index], RELGROUPHASH_HATES_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_HATES_PLAYER, RELGROUPHASH_PLAYER)
                SET_RELATIONSHIP_BETWEEN_GROUPS(ACQUAINTANCE_TYPE_PED_HATE, RELGROUPHASH_PLAYER, RELGROUPHASH_HATES_PLAYER)
                CLEAR_PED_TASKS(g_menu_attackers[index])
                TASK_COMBAT_PED(g_menu_attackers[index], PLAYER_PED_ID())
                SET_PED_KEEP_TASK(g_menu_attackers[index], TRUE)
            ENDIF
        ENDIF
    ENDREPEAT
ENDPROC

PROC APPLY_ATTACKER_GOD_STATE()
    INT index = 0
    REPEAT g_menu_attacker_count index
        IF DOES_ENTITY_EXIST(g_menu_attackers[index])
            SET_ENTITY_INVINCIBLE(g_menu_attackers[index], g_attacker_god)
        ENDIF
    ENDREPEAT
ENDPROC

PROC DRAW_ATTACKER_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 DRAW_OPTION(y, "Send Attacker", "APPLY", g_item = index, 2) BREAK
        CASE 1 DRAW_ATTACKER_MODEL(y, g_item = index) BREAK
        CASE 2 DRAW_ATTACKER_WEAPON(y, g_item = index) BREAK
        CASE 3 IF g_attacker_rage DRAW_OPTION(y, "Rage Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Rage Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 4 IF g_attacker_god DRAW_OPTION(y, "God Mode", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "God Mode", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 5 DRAW_OPTION(y, "Dismiss All Attackers", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_ATTACKER_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "ATTACKER")
    DRAW_MENU_VERSION_TAG()
    INT index = g_attacker_scroll
    INT row = 0
    WHILE row < 8 AND index < 6
        DRAW_ATTACKER_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

FUNC PEDGROUP_FORMATION BODYGUARD_GROUP_FORMATION()
    IF g_bodyguard_formation_choice = 1 RETURN FORMATION_LINE_ABREAST ENDIF
    IF g_bodyguard_formation_choice = 2 RETURN FORMATION_FOLLOW_IN_LINE ENDIF
    RETURN FORMATION_SURROUND_FACING_AHEAD
ENDFUNC

PROC APPLY_BODYGUARD_GROUP_FORMATION()
    IF NOT DOES_GROUP_EXIST(g_bodyguard_group) EXIT ENDIF
    SET_GROUP_FORMATION(g_bodyguard_group, BODYGUARD_GROUP_FORMATION())
ENDPROC

FUNC GROUP_INDEX ENSURE_BODYGUARD_GROUP()
    IF NOT DOES_GROUP_EXIST(g_bodyguard_group)
        g_bodyguard_group = CREATE_GROUP(DEFAULT_TASK_ALLOCATOR_FOLLOW_ANY_MEANS)
        SET_PED_AS_GROUP_LEADER(PLAYER_PED_ID(), g_bodyguard_group)
        SET_GROUP_SEPARATION_RANGE(g_bodyguard_group, 50.0)
        SET_GROUP_FORMATION_SPACING(g_bodyguard_group, 2.0, -1.0, -1.0)
        APPLY_BODYGUARD_GROUP_FORMATION()
    ENDIF
    RETURN g_bodyguard_group
ENDFUNC

PROC START_BODYGUARD_SPAWN()
    IF g_bodyguard_spawn_pending OR g_bodyguard_count >= COUNT_OF(g_bodyguards) EXIT ENDIF
    IF g_guard_ped_search_is_custom
        g_pending_bodyguard_model = g_guard_ped_model
    ELSE
        g_pending_bodyguard_model = PED_MODEL_FOR_CHOICE(g_guard_ped_choice)
    ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(g_pending_bodyguard_model) OR NOT IS_MODEL_VALID(g_pending_bodyguard_model) EXIT ENDIF
    REQUEST_MODEL(g_pending_bodyguard_model)
    g_bodyguard_spawn_pending = TRUE
    g_bodyguard_request_time = GET_GAME_TIMER()
ENDPROC

PROC BODYGUARD_FOLLOW_OFFSET(INT slot, VECTOR &offset)
    IF slot = 0 offset = <<-2.5, 2.5, 0.0>> ENDIF
    IF slot = 1 offset = <<2.5, 2.5, 0.0>> ENDIF
    IF slot = 2 offset = <<-2.5, -2.5, 0.0>> ENDIF
    IF slot = 3 offset = <<2.5, -2.5, 0.0>> ENDIF
    IF slot = 4 offset = <<-5.0, 0.0, 0.0>> ENDIF
    IF slot = 5 offset = <<5.0, 0.0, 0.0>> ENDIF
    IF slot = 6 offset = <<0.0, 5.0, 0.0>> ENDIF
    IF slot = 7 offset = <<0.0, -5.0, 0.0>> ENDIF
    IF slot >= 8
        INT ringSlot = slot - 8
        INT ring = 0
        INT ringStart = 0
        INT ringSize = 8
        WHILE ringSlot >= ringStart + ringSize
            ringStart = ringStart + ringSize
            ring = ring + 1
            ringSize = 8 + (ring * 4)
        ENDWHILE
        INT positionInRing = ringSlot - ringStart
        INT angleStep = (positionInRing * 137) % 360
        FLOAT radius = 8.0 + (TO_FLOAT(ring) * 3.0)
        FLOAT angleRad = TO_FLOAT(angleStep) * 0.0174533
        offset = <<radius * COS(angleRad), radius * SIN(angleRad), 0.0>>
    ENDIF
    IF g_bodyguard_formation_choice = 1
        IF slot = 0 offset = <<-3.0, 2.0, 0.0>> ENDIF
        IF slot = 1 offset = <<3.0, 2.0, 0.0>> ENDIF
        IF slot = 2 offset = <<-6.0, 2.0, 0.0>> ENDIF
        IF slot = 3 offset = <<6.0, 2.0, 0.0>> ENDIF
        IF slot = 4 offset = <<-9.0, 2.0, 0.0>> ENDIF
        IF slot = 5 offset = <<9.0, 2.0, 0.0>> ENDIF
        IF slot = 6 offset = <<-12.0, 2.0, 0.0>> ENDIF
        IF slot = 7 offset = <<12.0, 2.0, 0.0>> ENDIF
        IF slot >= 8
            IF (slot % 2) = 0
                offset = <<-12.0 - (TO_FLOAT((slot - 8) / 2) * 3.0), 2.0, 0.0>>
            ELSE
                offset = <<12.0 + (TO_FLOAT((slot - 8) / 2) * 3.0), 2.0, 0.0>>
            ENDIF
        ENDIF
    ENDIF
    IF g_bodyguard_formation_choice = 2
        IF slot = 0 offset = <<-1.5, -3.0, 0.0>> ENDIF
        IF slot = 1 offset = <<1.5, -3.0, 0.0>> ENDIF
        IF slot = 2 offset = <<-1.5, -6.0, 0.0>> ENDIF
        IF slot = 3 offset = <<1.5, -6.0, 0.0>> ENDIF
        IF slot = 4 offset = <<-1.5, -9.0, 0.0>> ENDIF
        IF slot = 5 offset = <<1.5, -9.0, 0.0>> ENDIF
        IF slot = 6 offset = <<-1.5, -12.0, 0.0>> ENDIF
        IF slot = 7 offset = <<1.5, -12.0, 0.0>> ENDIF
        IF slot >= 8
            IF (slot % 2) = 0
                offset = <<-1.5, -12.0 - (TO_FLOAT((slot - 8) / 2) * 3.0), 0.0>>
            ELSE
                offset = <<1.5, -12.0 - (TO_FLOAT((slot - 8) / 2) * 3.0), 0.0>>
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC ISSUE_BODYGUARD_FOLLOW_TASK_AT(INT slot)
    VECTOR offset = <<-2.5, 2.5, 0.0>>
    IF NOT g_bodyguard_follow EXIT ENDIF
    IF slot < 0 OR slot >= g_bodyguard_count EXIT ENDIF
    IF NOT DOES_ENTITY_EXIST(g_bodyguards[slot]) EXIT ENDIF
    IF IS_PED_INJURED(g_bodyguards[slot]) EXIT ENDIF
    BODYGUARD_FOLLOW_OFFSET(slot, offset)
    TASK_FOLLOW_TO_OFFSET_OF_ENTITY(g_bodyguards[slot], PLAYER_PED_ID(), offset, 1.0, -1, 2.0, TRUE)
ENDPROC

PROC FINISH_BODYGUARD_SPAWN()
    PED_INDEX guard
    WEAPON_TYPE guardWeapon = WEAPONTYPE_ASSAULTRIFLE
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 4.0, 0.0>>)
    BLIP_INDEX guardBlip
    guard = CREATE_PED(PEDTYPE_CIVMALE, g_pending_bodyguard_model, spawnPosition, GET_ENTITY_HEADING(PLAYER_PED_ID()), FALSE, TRUE)
    IF DOES_ENTITY_EXIST(guard)
        SET_ENTITY_AS_MISSION_ENTITY(guard, TRUE, TRUE)
        SWITCH g_bodyguard_weapon_choice
            CASE 0 guardWeapon = WEAPONTYPE_PISTOL BREAK
            CASE 1 guardWeapon = WEAPONTYPE_SMG BREAK
            CASE 2 guardWeapon = WEAPONTYPE_ASSAULTRIFLE BREAK
            CASE 3 guardWeapon = WEAPONTYPE_PUMPSHOTGUN BREAK
            CASE 4 guardWeapon = WEAPONTYPE_MG BREAK
        ENDSWITCH
        GIVE_WEAPON_TO_PED(guard, guardWeapon, 9999, TRUE, TRUE)
        SET_PED_AS_ENEMY(guard, FALSE)
        SET_PED_RELATIONSHIP_GROUP_HASH(guard, RELGROUPHASH_PLAYER)
        SET_PED_FLEE_ATTRIBUTES(guard, FA_NEVER_FLEE, TRUE)
        SET_PED_COMBAT_ABILITY(guard, CAL_PROFESSIONAL)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(guard, FALSE)
        SET_PED_COMBAT_ATTRIBUTES(guard, CA_ALWAYS_FIGHT, TRUE)
        SET_PED_KEEP_TASK(guard, TRUE)
        SET_PED_NEVER_LEAVES_GROUP(guard, TRUE)
        SET_PED_AS_GROUP_MEMBER(guard, ENSURE_BODYGUARD_GROUP())
        SET_PED_CAN_TELEPORT_TO_GROUP_LEADER(guard, g_bodyguard_group, TRUE)
        SET_ENTITY_INVINCIBLE(guard, g_bodyguard_god)
        TASK_COMBAT_HATED_TARGETS_AROUND_PED(guard, 60.0)
        IF g_bodyguard_blips
            guardBlip = ADD_BLIP_FOR_ENTITY(guard)
            SET_BLIP_SPRITE(guardBlip, RADAR_TRACE_FRIEND)
            SET_BLIP_COLOUR(guardBlip, BLIP_COLOUR_BLUE)
        ENDIF
        IF g_bodyguard_count < COUNT_OF(g_bodyguards)
            g_bodyguards[g_bodyguard_count] = guard
            g_bodyguard_count = g_bodyguard_count + 1
            ISSUE_BODYGUARD_FOLLOW_TASK_AT(g_bodyguard_count - 1)
        ENDIF
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_bodyguard_model)
    g_bodyguard_spawn_pending = FALSE
ENDPROC

PROC APPLY_BODYGUARD_FOLLOW_STATE()
    INT index = 0
    IF g_bodyguard_follow AND NOT DOES_GROUP_EXIST(g_bodyguard_group)
        ENSURE_BODYGUARD_GROUP()
    ENDIF
    APPLY_BODYGUARD_GROUP_FORMATION()
    REPEAT g_bodyguard_count index
        IF DOES_ENTITY_EXIST(g_bodyguards[index]) AND NOT IS_PED_INJURED(g_bodyguards[index]) AND NOT IS_PED_IN_COMBAT(g_bodyguards[index])
            IF g_bodyguard_follow
                SET_PED_AS_GROUP_MEMBER(g_bodyguards[index], g_bodyguard_group)
                SET_PED_CAN_TELEPORT_TO_GROUP_LEADER(g_bodyguards[index], g_bodyguard_group, TRUE)
                ISSUE_BODYGUARD_FOLLOW_TASK_AT(index)
            ELSE
                TASK_GUARD_CURRENT_POSITION(g_bodyguards[index], 5.0, 10.0, TRUE)
            ENDIF
        ENDIF
    ENDREPEAT
ENDPROC

PROC PROCESS_BODYGUARD_FOLLOW()
    INT index = 0
    INT scanned = 0
    VECTOR guardPosition = <<0.0, 0.0, 0.0>>
    VECTOR leaderPosition = <<0.0, 0.0, 0.0>>
    VECTOR delta = <<0.0, 0.0, 0.0>>
    FLOAT distance = 0.0
    IF g_bodyguard_count <= 0 EXIT ENDIF
    IF NOT g_bodyguard_follow EXIT ENDIF
    IF GET_GAME_TIMER() < g_bodyguard_follow_tick EXIT ENDIF
    g_bodyguard_follow_tick = GET_GAME_TIMER() + 2000
    IF NOT DOES_GROUP_EXIST(g_bodyguard_group)
        ENSURE_BODYGUARD_GROUP()
    ENDIF
    leaderPosition = GET_ENTITY_COORDS(PLAYER_PED_ID())
    WHILE scanned < BODYGUARD_FOLLOW_SCAN_PER_TICK AND scanned < g_bodyguard_count
        IF g_bodyguard_scan_index >= g_bodyguard_count g_bodyguard_scan_index = 0 ENDIF
        index = g_bodyguard_scan_index
        g_bodyguard_scan_index = g_bodyguard_scan_index + 1
        scanned = scanned + 1
        IF DOES_ENTITY_EXIST(g_bodyguards[index]) AND NOT IS_PED_INJURED(g_bodyguards[index]) AND NOT IS_PED_IN_COMBAT(g_bodyguards[index])
            guardPosition = GET_ENTITY_COORDS(g_bodyguards[index])
            delta = guardPosition - leaderPosition
            distance = SQRT((delta.x * delta.x) + (delta.y * delta.y) + (delta.z * delta.z))
            IF distance > 7.0
                ISSUE_BODYGUARD_FOLLOW_TASK_AT(index)
            ENDIF
        ENDIF
    ENDWHILE
ENDPROC

PROC APPLY_BODYGUARD_FORMATION()
    INT index = 0
    APPLY_BODYGUARD_GROUP_FORMATION()
    APPLY_BODYGUARD_FOLLOW_STATE()
    REPEAT g_bodyguard_count index
        IF DOES_ENTITY_EXIST(g_bodyguards[index])
            IF g_bodyguard_formation_choice = 1 TASK_COMBAT_HATED_TARGETS_AROUND_PED(g_bodyguards[index], 60.0) ENDIF
            IF g_bodyguard_formation_choice = 2 TASK_COMBAT_HATED_TARGETS_AROUND_PED(g_bodyguards[index], 120.0) ENDIF
        ENDIF
    ENDREPEAT
ENDPROC

PROC APPLY_BODYGUARD_GOD_STATE()
    INT index = 0
    REPEAT g_bodyguard_count index
        IF DOES_ENTITY_EXIST(g_bodyguards[index])
            SET_ENTITY_INVINCIBLE(g_bodyguards[index], g_bodyguard_god)
        ENDIF
    ENDREPEAT
ENDPROC

PROC CLEAR_BODYGUARDS()
    INT index = 0
    REPEAT g_bodyguard_count index
        IF DOES_ENTITY_EXIST(g_bodyguards[index])
            REMOVE_PED_FROM_GROUP(g_bodyguards[index])
            SET_ENTITY_AS_MISSION_ENTITY(g_bodyguards[index], TRUE, TRUE)
            DELETE_PED(g_bodyguards[index])
        ENDIF
    ENDREPEAT
    g_bodyguard_count = 0
    g_bodyguard_scan_index = 0
    IF DOES_GROUP_EXIST(g_bodyguard_group)
        REMOVE_GROUP(g_bodyguard_group)
        g_bodyguard_group = NULL
    ENDIF
ENDPROC

PROC PRUNE_MENU_PED_TRACKING()
    INT readIndex = 0
    INT writeIndex = 0
    REPEAT g_bodyguard_count readIndex
        IF DOES_ENTITY_EXIST(g_bodyguards[readIndex])
            g_bodyguards[writeIndex] = g_bodyguards[readIndex]
            writeIndex = writeIndex + 1
        ENDIF
    ENDREPEAT
    g_bodyguard_count = writeIndex
    g_bodyguard_scan_index = 0
    IF g_bodyguard_count <= 0 AND DOES_GROUP_EXIST(g_bodyguard_group)
        REMOVE_GROUP(g_bodyguard_group)
        g_bodyguard_group = NULL
    ENDIF
    readIndex = 0
    writeIndex = 0
    REPEAT g_brawl_ped_count readIndex
        IF DOES_ENTITY_EXIST(g_brawl_peds[readIndex])
            g_brawl_peds[writeIndex] = g_brawl_peds[readIndex]
            writeIndex = writeIndex + 1
        ENDIF
    ENDREPEAT
    g_brawl_ped_count = writeIndex
    readIndex = 0
    writeIndex = 0
    REPEAT g_stripper_count readIndex
        IF DOES_ENTITY_EXIST(g_stripper_peds[readIndex])
            g_stripper_peds[writeIndex] = g_stripper_peds[readIndex]
            writeIndex = writeIndex + 1
        ENDIF
    ENDREPEAT
    g_stripper_count = writeIndex
    g_stripper_write_index = 0
    IF g_stripper_count < STRIPPER_TRACK_MAX g_stripper_write_index = g_stripper_count ENDIF
    IF g_stripper_write_index >= STRIPPER_TRACK_MAX g_stripper_write_index = 0 ENDIF
ENDPROC

PROC PROCESS_BODYGUARD_SPAWN()
    IF NOT g_bodyguard_spawn_pending EXIT ENDIF
    IF HAS_MODEL_LOADED(g_pending_bodyguard_model)
        FINISH_BODYGUARD_SPAWN()
    ELIF GET_GAME_TIMER() > g_bodyguard_request_time + 8000
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_bodyguard_model)
        g_bodyguard_spawn_pending = FALSE
    ENDIF
ENDPROC

PROC START_STRIPPER_SPAWN()
    IF g_stripper_spawn_pending EXIT ENDIF
    MODEL_NAMES model = STRIPPER_MODEL_FOR_CHOICE(g_stripper_choice)
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model) EXIT ENDIF
    g_pending_stripper_model = model
    REQUEST_MODEL(g_pending_stripper_model)
    g_stripper_spawn_pending = TRUE
    g_stripper_request_time = GET_GAME_TIMER()
ENDPROC

PROC TRACK_STRIPPER_PED(PED_INDEX ped)
    IF g_stripper_count < STRIPPER_TRACK_MAX
        g_stripper_peds[g_stripper_count] = ped
        g_stripper_count = g_stripper_count + 1
        g_stripper_write_index = g_stripper_write_index + 1
        IF g_stripper_write_index >= STRIPPER_TRACK_MAX g_stripper_write_index = 0 ENDIF
        EXIT
    ENDIF
    IF DOES_ENTITY_EXIST(g_stripper_peds[g_stripper_write_index])
        SET_ENTITY_AS_MISSION_ENTITY(g_stripper_peds[g_stripper_write_index], TRUE, TRUE)
        DELETE_PED(g_stripper_peds[g_stripper_write_index])
    ENDIF
    g_stripper_peds[g_stripper_write_index] = ped
    g_stripper_write_index = g_stripper_write_index + 1
    IF g_stripper_write_index >= STRIPPER_TRACK_MAX g_stripper_write_index = 0 ENDIF
ENDPROC

PROC FINISH_STRIPPER_SPAWN()
    VECTOR spawnPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER_PED_ID(), <<0.0, 3.0, 0.0>>)
    PED_INDEX ped = CREATE_PED(PEDTYPE_CIVFEMALE, g_pending_stripper_model, spawnPosition, GET_ENTITY_HEADING(PLAYER_PED_ID()) + 180.0, FALSE, TRUE)
    SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_stripper_model)
    g_stripper_spawn_pending = FALSE
    IF NOT DOES_ENTITY_EXIST(ped) EXIT ENDIF
    SET_ENTITY_AS_MISSION_ENTITY(ped, TRUE, TRUE)
    SET_PED_FLEE_ATTRIBUTES(ped, FA_NEVER_FLEE, TRUE)
    SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, TRUE)
    SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(ped, TRUE)
    TRACK_STRIPPER_PED(ped)
ENDPROC

PROC PROCESS_STRIPPER_SPAWN()
    IF NOT g_stripper_spawn_pending EXIT ENDIF
    IF HAS_MODEL_LOADED(g_pending_stripper_model)
        FINISH_STRIPPER_SPAWN()
    ELIF GET_GAME_TIMER() > g_stripper_request_time + 8000
        SET_MODEL_AS_NO_LONGER_NEEDED(g_pending_stripper_model)
        g_stripper_spawn_pending = FALSE
    ENDIF
ENDPROC

PROC CLEAR_STRIPPER_PEDS()
    INT index = 0
    REPEAT g_stripper_count index
        IF DOES_ENTITY_EXIST(g_stripper_peds[index])
            SET_ENTITY_AS_MISSION_ENTITY(g_stripper_peds[index], TRUE, TRUE)
            DELETE_PED(g_stripper_peds[index])
        ENDIF
    ENDREPEAT
    g_stripper_count = 0
    g_stripper_write_index = 0
ENDPROC

PROC DRAW_STRIPPER_SELECTOR(FLOAT y, BOOL selected)
    IF g_stripper_spawn_pending
        DRAW_OPTION(y, "Spawn Stripper", "< Loading >", selected, 2)
        EXIT
    ENDIF
    DRAW_OPTION(y, "Spawn Stripper", STRIPPER_NAME_FOR_CHOICE(g_stripper_choice), selected, 3)
ENDPROC

FUNC FLOAT NEON_ANIM_SPEED_VALUE()
    IF g_neon_speed_index <= 0 RETURN 0.0 ENDIF
    IF g_neon_speed_index >= 41 RETURN 10.0 ENDIF
    RETURN TO_FLOAT(g_neon_speed_index) * 0.25
ENDFUNC

FUNC INT NEON_ANIM_STEP_SIZE()
    INT level = g_neon_speed_index
    IF level < 0 level = 0 ENDIF
    IF level > 41 level = 41 ENDIF
    IF level <= 0 RETURN 0 ENDIF
    RETURN 1 + ((level * 31) / 41)
ENDFUNC

FUNC INT NEON_ANIM_INTERVAL()
    IF g_neon_speed_index < 0 g_neon_speed_index = 0 ENDIF
    IF g_neon_speed_index > 41 g_neon_speed_index = 41 ENDIF
    IF g_neon_speed_index <= 0 RETURN 2000 ENDIF
    RETURN 300 / g_neon_speed_index
ENDFUNC

FUNC BOOL NEON_ANIM_REVERSED()
    RETURN FALSE
ENDFUNC

PROC APPLY_NEON_ANIM_STATE()
    VEHICLE_INDEX vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    IF g_neon_mode = 0
        g_lsc_neon = FALSE
        SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, FALSE)
        SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, FALSE)
        SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, FALSE)
        SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, FALSE)
        SET_VEHICLE_NEON_INDEX_COLOUR(vehicle, g_neon_saved_colour)
        EXIT
    ENDIF
    IF NOT g_lsc_neon
        g_lsc_neon = TRUE
        g_neon_saved_colour = g_lsc_neon_colour
    ENDIF
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_FRONT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_BACK, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_LEFT, TRUE)
    SET_VEHICLE_NEON_ENABLED(vehicle, NEON_RIGHT, TRUE)
    g_neon_anim_step = 0
    g_neon_anim_time = GET_GAME_TIMER()
ENDPROC

PROC PROCESS_NEON_ANIM()
    VEHICLE_INDEX vehicle
    INT phase = 0
    IF g_neon_mode = 0 EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF GET_GAME_TIMER() < g_neon_anim_time EXIT ENDIF
    g_neon_anim_time = GET_GAME_TIMER() + NEON_ANIM_INTERVAL()
    IF NEON_ANIM_REVERSED()
        g_neon_anim_step = g_neon_anim_step - NEON_ANIM_STEP_SIZE()
        WHILE g_neon_anim_step < 0 g_neon_anim_step = g_neon_anim_step + 2400 ENDWHILE
    ELSE
        g_neon_anim_step = g_neon_anim_step + NEON_ANIM_STEP_SIZE()
        WHILE g_neon_anim_step > 2399 g_neon_anim_step = g_neon_anim_step - 2400 ENDWHILE
    ENDIF
    phase = g_neon_anim_step / 10
    IF g_neon_mode = 1
        IF phase < 87
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255, 255)
        ELIF phase < 90
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (89 - phase)) / 3, (255 * (89 - phase)) / 3, (255 * (89 - phase)) / 3)
        ELIF phase < 177
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, 0, 0)
        ELIF phase < 180
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 177)) / 3, (255 * (phase - 177)) / 3, (255 * (phase - 177)) / 3)
        ELSE
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, 0, 0)
        ENDIF
    ELIF g_neon_mode = 2
        IF phase < 120
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * phase) / 120, (255 * phase) / 120, (255 * phase) / 120)
        ELSE
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (239 - phase)) / 120, (255 * (239 - phase)) / 120, (255 * (239 - phase)) / 120)
        ENDIF
    ELIF g_neon_mode = 3
        IF g_neon_transition = 1
            IF phase < 30
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 0, 0)
            ELIF phase < 60
                SET_VEHICLE_NEON_COLOUR(vehicle, 0, 255, 0)
            ELIF phase < 90
                SET_VEHICLE_NEON_COLOUR(vehicle, 0, 0, 255)
            ELIF phase < 120
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255, 0)
            ELIF phase < 150
                SET_VEHICLE_NEON_COLOUR(vehicle, 0, 255, 255)
            ELIF phase < 180
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 0, 255)
            ELIF phase < 210
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255, 255)
            ELSE
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 128, 0)
            ENDIF
        ELSE
            IF phase < 30
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, (255 * phase) / 30, (255 * phase) / 30)
            ELIF phase < 60
                SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (59 - phase)) / 30, 255, (255 * (phase - 30)) / 30)
            ELIF phase < 90
                SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 60)) / 30, (255 * (89 - phase)) / 30, 255)
            ELIF phase < 120
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255, (255 * (phase - 90)) / 30)
            ELIF phase < 150
                SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (149 - phase)) / 30, 255, 255)
            ELIF phase < 180
                SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 150)) / 30, (255 * (179 - phase)) / 30, 255)
            ELIF phase < 210
                SET_VEHICLE_NEON_COLOUR(vehicle, 255, (255 * (phase - 180)) / 30, (255 * (phase - 180)) / 30)
            ELSE
                SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 210)) / 30), (255 * (239 - phase)) / 30, (255 * (phase - 210)) / 30)
            ENDIF
        ENDIF
    ELIF g_neon_mode = 4
        IF phase < 30
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, (255 * phase) / 30, (255 * phase) / 30)
        ELIF phase < 60
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255 - ((255 * (phase - 30)) / 30), 255 - ((255 * (phase - 30)) / 30))
        ELIF phase < 90
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 60)) / 30, 255, (255 * (phase - 60)) / 30)
        ELIF phase < 120
            SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 90)) / 30), 255, 255 - ((255 * (phase - 90)) / 30))
        ELIF phase < 150
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 120)) / 30, (255 * (phase - 120)) / 30, 255)
        ELIF phase < 180
            SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 150)) / 30), 255 - ((255 * (phase - 150)) / 30), 255)
        ELIF phase < 210
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 180)) / 30, (255 * (phase - 180)) / 30, (255 * (phase - 180)) / 30)
        ELSE
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255 - ((255 * (phase - 210)) / 30), 255 - ((255 * (phase - 210)) / 30))
        ENDIF
    ELIF g_neon_mode = 5
        IF phase < 30
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * phase) / 30, 0, 255)
        ELIF phase < 60
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, 0, 255 - ((255 * (phase - 30)) / 30))
        ELIF phase < 90
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, (255 * (phase - 60)) / 30, 0)
        ELIF phase < 120
            SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 90)) / 30), 255, 0)
        ELIF phase < 150
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, 255, (255 * (phase - 120)) / 30)
        ELIF phase < 180
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, 255 - ((255 * (phase - 150)) / 30), 255)
        ELIF phase < 210
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 180)) / 30, (255 * (phase - 180)) / 30, 255 - ((255 * (phase - 180)) / 30))
        ELSE
            SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 210)) / 30), 255 - ((255 * (phase - 210)) / 30), (255 * (phase - 210)) / 30)
        ENDIF
    ELSE
        IF phase < 30
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, (255 * phase) / 30, 255)
        ELIF phase < 60
            SET_VEHICLE_NEON_COLOUR(vehicle, 0, 255 - ((255 * (phase - 30)) / 30), 255)
        ELIF phase < 90
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 60)) / 30, 255, 255 - ((255 * (phase - 60)) / 30))
        ELIF phase < 120
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, 255 - ((255 * (phase - 90)) / 30), 255 - ((255 * (phase - 90)) / 30))
        ELIF phase < 150
            SET_VEHICLE_NEON_COLOUR(vehicle, 255, (255 * (phase - 120)) / 30, (255 * (phase - 120)) / 30)
        ELIF phase < 180
            SET_VEHICLE_NEON_COLOUR(vehicle, 255 - ((255 * (phase - 150)) / 30), (255 * (phase - 150)) / 30, 255 - ((255 * (phase - 150)) / 30))
        ELIF phase < 210
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (phase - 180)) / 30, 255 - ((255 * (phase - 180)) / 30), 255 - ((255 * (phase - 180)) / 30))
        ELSE
            SET_VEHICLE_NEON_COLOUR(vehicle, (255 * (239 - phase)) / 30, (255 * (239 - phase)) / 30, 255)
        ENDIF
    ENDIF
ENDPROC

PROC CLEAR_PLAYER_DAMAGE_MARKS()
    PED_INDEX playerPed = PLAYER_PED_ID()
    CLEAR_PED_BLOOD_DAMAGE(playerPed)
    CLEAR_PED_WETNESS(playerPed)
    CLEAR_PED_ENV_DIRT(playerPed)
    RESET_PED_VISIBLE_DAMAGE(playerPed)
ENDPROC

PROC APPLY_UNLIMITED_OXYGEN()
    IF g_unlimited_oxygen
        SET_PED_MAX_TIME_UNDERWATER(PLAYER_PED_ID(), 2147483647)
    ELSE
        SET_PED_MAX_TIME_UNDERWATER(PLAYER_PED_ID(), -1.0)
    ENDIF
ENDPROC

PROC APPLY_UNLIMITED_ABILITY()
    IF g_unlimited_ability
        SPECIAL_ABILITY_CHARGE_ABSOLUTE(PLAYER_ID(), 200, TRUE, 0)
    ENDIF
ENDPROC

PROC PROCESS_GODMODE_TOW_HOOK()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX truck = NULL
    VEHICLE_INDEX towed = NULL
    IF NOT g_godmode_tow_hook EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
    truck = GET_VEHICLE_PED_IS_IN(playerPed)
    IF NOT DOES_ENTITY_EXIST(truck) EXIT ENDIF
    IF DOES_ENTITY_EXIST(g_tow_hook_towed) AND IS_ENTITY_A_VEHICLE(g_tow_hook_towed)
        IF VDIST(GET_ENTITY_COORDS(truck), GET_ENTITY_COORDS(g_tow_hook_towed)) < 25.0
            towed = g_tow_hook_towed
        ELSE
            g_tow_hook_towed = NULL
        ENDIF
    ELSE
        IF IS_ENTITY_ATTACHED(truck)
            IF IS_ENTITY_A_VEHICLE(GET_ENTITY_ATTACHED_TO(truck))
                IF DOES_ENTITY_EXIST(GET_ENTITY_ATTACHED_TO(truck))
                    towed = GET_RANDOM_VEHICLE_IN_SPHERE(GET_ENTITY_COORDS(truck), 12.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
                ENDIF
            ENDIF
        ENDIF
    ENDIF
    IF NOT DOES_ENTITY_EXIST(towed) EXIT ENDIF
    IF NOT IS_ENTITY_A_VEHICLE(towed) EXIT ENDIF
    IF NOT IS_VEHICLE_ATTACHED_TO_TOW_TRUCK(truck, towed)
        ATTACH_VEHICLE_TO_TOW_TRUCK(truck, towed, -1, <<0.0, -1.5, 0.0>>)
    ENDIF
    g_tow_hook_vehicle = truck
    g_tow_hook_towed = towed
ENDPROC

PROC APPLY_DISPATCH_SERVICES_STATE()
    ENABLE_DISPATCH_SERVICE(DT_POLICE_AUTOMOBILE, g_dispatch)
    ENABLE_DISPATCH_SERVICE(DT_POLICE_HELICOPTER, g_dispatch)
    ENABLE_DISPATCH_SERVICE(DT_SWAT_AUTOMOBILE, g_dispatch)
    ENABLE_DISPATCH_SERVICE(DT_POLICE_ROAD_BLOCK, g_dispatch)
    ENABLE_DISPATCH_SERVICE(DT_ARMY_VEHICLE, g_dispatch)
ENDPROC

PROC APPLY_NPC_DENSITY()
    VECTOR center = GET_ENTITY_COORDS(PLAYER_PED_ID())
    FLOAT pedDensity = 1.0
    IF g_pop_multiplier_sphere >= 0 AND DOES_POP_MULTIPLIER_SPHERE_EXIST(g_pop_multiplier_sphere)
        REMOVE_POP_MULTIPLIER_SPHERE(g_pop_multiplier_sphere, FALSE)
        g_pop_multiplier_sphere = -1
    ENDIF
    IF g_npc_density_choice = 0 pedDensity = 0.25 ENDIF
    IF g_npc_density_choice = 1 pedDensity = 0.5 ENDIF
    IF g_npc_density_choice = 2 pedDensity = 1.0 ENDIF
    IF g_npc_density_choice = 3 pedDensity = 2.0 ENDIF
    IF g_npc_density_choice = 4 pedDensity = 4.0 ENDIF
    g_pop_multiplier_sphere = ADD_POP_MULTIPLIER_SPHERE(center, 1500.0, pedDensity, 1.0, FALSE, TRUE)
ENDPROC

PROC PROCESS_SUPER_PUNCH()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR playerPosition = <<0.0, 0.0, 0.0>>
    VECTOR fwd = <<0.0, 1.0, 0.0>>
    VECTOR targetPosition = <<0.0, 0.0, 0.0>>
    VECTOR launch = <<0.0, 0.0, 0.0>>
    VECTOR vehicleLaunch = <<0.0, 0.0, 0.0>>
    VECTOR delta = <<0.0, 0.0, 0.0>>
    PED_INDEX closestPed = NULL
    VEHICLE_INDEX closestVehicle = NULL
    IF NOT g_super_punch EXIT ENDIF
    IF IS_ENTITY_DEAD(playerPed) EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(playerPed) EXIT ENDIF
    IF NOT IS_PED_IN_MELEE_COMBAT(playerPed) EXIT ENDIF
    IF GET_GAME_TIMER() < g_super_punch_time EXIT ENDIF
    g_super_punch_time = GET_GAME_TIMER() + 150
    playerPosition = GET_ENTITY_COORDS(playerPed)
    fwd = GET_ENTITY_FORWARD_VECTOR(playerPed)
    launch = <<fwd.x * 60.0, fwd.y * 60.0, 18.0>>
    vehicleLaunch = <<fwd.x * 30.0, fwd.y * 30.0, 10.0>>
    IF GET_CLOSEST_PED(playerPosition, 3.5, TRUE, TRUE, closestPed)
        IF DOES_ENTITY_EXIST(closestPed) AND closestPed != playerPed
            IF NOT IS_ENTITY_DEAD(closestPed)
                targetPosition = GET_ENTITY_COORDS(closestPed)
                delta = targetPosition - playerPosition
                IF delta.x * fwd.x + delta.y * fwd.y > 0.0
                    SET_PED_TO_RAGDOLL(closestPed, 2000, 3000, TASK_NM_SCRIPT, TRUE, TRUE, TRUE)
                    SET_ENTITY_VELOCITY(closestPed, launch)
                ENDIF
            ENDIF
        ENDIF
    ENDIF
    closestVehicle = GET_CLOSEST_VEHICLE(playerPosition, 4.5, ADDER, 71)
    IF DOES_ENTITY_EXIST(closestVehicle)
        targetPosition = GET_ENTITY_COORDS(closestVehicle)
        delta = targetPosition - playerPosition
        IF delta.x * fwd.x + delta.y * fwd.y > 0.0
            SET_ENTITY_VELOCITY(closestVehicle, vehicleLaunch)
        ENDIF
    ENDIF
ENDPROC

PROC EXPLODE_ALL_NEARBY_VEHICLES()
    VECTOR center = GET_ENTITY_COORDS(PLAYER_PED_ID())
    VEHICLE_INDEX found[64]
    INT foundCount = 0
    INT guard = 0
    INT deadRun = 0
    VEHICLE_INDEX candidate = NULL
    VEHICLE_INDEX occupied = NULL
    INT index = 0
    INT check = 0
    BOOL known = FALSE
    IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        occupied = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    ENDIF
    WHILE foundCount < 64 AND guard < 512 AND deadRun < 48
        candidate = GET_RANDOM_VEHICLE_IN_SPHERE(center, 1500.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_MISSION_VEHICLES)
        guard = guard + 1
        IF NOT DOES_ENTITY_EXIST(candidate)
            deadRun = deadRun + 1
        ELIF candidate = occupied
            deadRun = deadRun + 1
        ELSE
            known = FALSE
            check = 0
            WHILE check < foundCount
                IF found[check] = candidate known = TRUE ENDIF
                check = check + 1
            ENDWHILE
            IF known
                deadRun = deadRun + 1
            ELSE
                found[foundCount] = candidate
                foundCount = foundCount + 1
                deadRun = 0
            ENDIF
        ENDIF
    ENDWHILE
    g_explode_queue_count = 0
    g_explode_queue_index = 0
    WHILE index < foundCount
        IF DOES_ENTITY_EXIST(found[index]) AND found[index] != occupied
            IF g_explode_queue_count < COUNT_OF(g_explode_queue)
                g_explode_queue[g_explode_queue_count] = found[index]
                g_explode_queue_count = g_explode_queue_count + 1
            ENDIF
        ENDIF
        index = index + 1
    ENDWHILE
ENDPROC

PROC PROCESS_EXPLODE_QUEUE()
    INT burst = 0
    IF g_explode_queue_index >= g_explode_queue_count
        g_explode_queue_count = 0
        g_explode_queue_index = 0
        EXIT
    ENDIF
    WHILE burst < EXPLODE_BURST_PER_FRAME AND g_explode_queue_index < g_explode_queue_count
        IF DOES_ENTITY_EXIST(g_explode_queue[g_explode_queue_index])
            EXPLODE_VEHICLE(g_explode_queue[g_explode_queue_index], TRUE, FALSE)
        ENDIF
        g_explode_queue_index = g_explode_queue_index + 1
        burst = burst + 1
    ENDWHILE
ENDPROC

FUNC FLOAT DIRT_LEVEL_VALUE(INT level)
    RETURN TO_FLOAT(level) * 0.5
ENDFUNC

FUNC STRING DIRT_LEVEL_VALUE_LABEL(INT level)
    IF level = 0 RETURN "< 0.0 >" ENDIF
    IF level = 1 RETURN "< 0.5 >" ENDIF
    IF level = 2 RETURN "< 1.0 >" ENDIF
    IF level = 3 RETURN "< 1.5 >" ENDIF
    IF level = 4 RETURN "< 2.0 >" ENDIF
    IF level = 5 RETURN "< 2.5 >" ENDIF
    IF level = 6 RETURN "< 3.0 >" ENDIF
    IF level = 7 RETURN "< 3.5 >" ENDIF
    IF level = 8 RETURN "< 4.0 >" ENDIF
    IF level = 9 RETURN "< 4.5 >" ENDIF
    IF level = 10 RETURN "< 5.0 >" ENDIF
    IF level = 11 RETURN "< 5.5 >" ENDIF
    IF level = 12 RETURN "< 6.0 >" ENDIF
    IF level = 13 RETURN "< 6.5 >" ENDIF
    IF level = 14 RETURN "< 7.0 >" ENDIF
    IF level = 15 RETURN "< 7.5 >" ENDIF
    IF level = 16 RETURN "< 8.0 >" ENDIF
    IF level = 17 RETURN "< 8.5 >" ENDIF
    IF level = 18 RETURN "< 9.0 >" ENDIF
    IF level = 19 RETURN "< 9.5 >" ENDIF
    IF level = 20 RETURN "< 10.0 >" ENDIF
    IF level = 21 RETURN "< 10.5 >" ENDIF
    IF level = 22 RETURN "< 11.0 >" ENDIF
    IF level = 23 RETURN "< 11.5 >" ENDIF
    IF level = 24 RETURN "< 12.0 >" ENDIF
    IF level = 25 RETURN "< 12.5 >" ENDIF
    IF level = 26 RETURN "< 13.0 >" ENDIF
    IF level = 27 RETURN "< 13.5 >" ENDIF
    IF level = 28 RETURN "< 14.0 >" ENDIF
    IF level = 29 RETURN "< 14.5 >" ENDIF
    IF level = 30 RETURN "< 15.0 >" ENDIF
    RETURN "< 15.0 >"
ENDFUNC

PROC SYNC_VEHICLE_DIRT_SLIDER()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    FLOAT currentDirt = GET_VEHICLE_DIRT_LEVEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
    g_vehicle_dirt_level = ROUND(currentDirt * 2.0)
    IF g_vehicle_dirt_level < 0 g_vehicle_dirt_level = 0 ENDIF
    IF g_vehicle_dirt_level > 30 g_vehicle_dirt_level = 30 ENDIF
ENDPROC

PROC APPLY_VEHICLE_DIRT_LEVEL()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    SET_VEHICLE_DIRT_LEVEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), DIRT_LEVEL_VALUE(g_vehicle_dirt_level))
ENDPROC

PROC APPLY_VEHICLE_WINDOW_ACTION()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX windowVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF g_vehicle_window_action = 0
        ROLL_DOWN_WINDOWS(windowVehicle)
    ELSE
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_FRONT_LEFT)
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_FRONT_RIGHT)
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_REAR_LEFT)
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_REAR_RIGHT)
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_MIDDLE_LEFT)
        ROLL_UP_WINDOW(windowVehicle, SC_WINDOW_MIDDLE_RIGHT)
    ENDIF
ENDPROC

PROC APPLY_VEHICLE_SELECTED_WINDOW(BOOL rollDown)
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX selectedWindowVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF rollDown
        IF g_vehicle_window_choice = 0 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_FRONT_LEFT) ENDIF
        IF g_vehicle_window_choice = 1 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_FRONT_RIGHT) ENDIF
        IF g_vehicle_window_choice = 2 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_REAR_LEFT) ENDIF
        IF g_vehicle_window_choice = 3 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_REAR_RIGHT) ENDIF
        IF g_vehicle_window_choice = 4 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_MIDDLE_LEFT) ENDIF
        IF g_vehicle_window_choice = 5 ROLL_DOWN_WINDOW(selectedWindowVehicle, SC_WINDOW_MIDDLE_RIGHT) ENDIF
    ELSE
        IF g_vehicle_window_choice = 0 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_FRONT_LEFT) ENDIF
        IF g_vehicle_window_choice = 1 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_FRONT_RIGHT) ENDIF
        IF g_vehicle_window_choice = 2 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_REAR_LEFT) ENDIF
        IF g_vehicle_window_choice = 3 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_REAR_RIGHT) ENDIF
        IF g_vehicle_window_choice = 4 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_MIDDLE_LEFT) ENDIF
        IF g_vehicle_window_choice = 5 ROLL_UP_WINDOW(selectedWindowVehicle, SC_WINDOW_MIDDLE_RIGHT) ENDIF
    ENDIF
ENDPROC

PROC APPLY_VEHICLE_ENGINE_TOGGLE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX engineVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF GET_IS_VEHICLE_ENGINE_RUNNING(engineVehicle)
        SET_VEHICLE_ENGINE_ON(engineVehicle, FALSE, TRUE, TRUE)
    ELSE
        SET_VEHICLE_ENGINE_ON(engineVehicle, TRUE, TRUE, FALSE)
    ENDIF
ENDPROC

PROC APPLY_VEHICLE_HAZARDS_STATE()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX hazardVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SET_VEHICLE_INDICATOR_LIGHTS(hazardVehicle, TRUE, g_vehicle_hazards)
    SET_VEHICLE_INDICATOR_LIGHTS(hazardVehicle, FALSE, g_vehicle_hazards)
ENDPROC

PROC PROCESS_VEHICLE_HAZARDS()
    IF NOT g_vehicle_hazards EXIT ENDIF
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    IF GET_GAME_TIMER() < g_vehicle_hazards_tick EXIT ENDIF
    APPLY_VEHICLE_HAZARDS_STATE()
    g_vehicle_hazards_tick = GET_GAME_TIMER() + 500
ENDPROC

PROC APPLY_EMERGENCY_SIREN_MUTE_STATE(VEHICLE_INDEX sirenVehicle, BOOL muteSirens)
    IF NOT DOES_ENTITY_EXIST(sirenVehicle) EXIT ENDIF
    IF IS_ENTITY_DEAD(sirenVehicle) EXIT ENDIF
    IF muteSirens
        IF SIREN_MUTE_FORCE_SIREN = 1
            SET_VEHICLE_SIREN(sirenVehicle, TRUE)
        ENDIF
        SET_VEHICLE_HAS_MUTED_SIRENS(sirenVehicle, TRUE)
        IF SIREN_MUTE_TRAFFIC_YIELD = 1
            SET_VEHICLE_ACT_AS_IF_HAS_SIREN_ON(sirenVehicle, TRUE)
        ENDIF
    ELSE
        SET_VEHICLE_HAS_MUTED_SIRENS(sirenVehicle, FALSE)
        SET_VEHICLE_ACT_AS_IF_HAS_SIREN_ON(sirenVehicle, FALSE)
    ENDIF
ENDPROC

PROC ANNOUNCE_SIREN_MUTE(BOOL muteSirens)
    IF muteSirens
        BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Sirens Muted")
        END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
    ELSE
        BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
            ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Sirens Unmuted")
        END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
    ENDIF
ENDPROC

PROC PROCESS_EMERGENCY_SIREN_MUTE()
    VEHICLE_INDEX sirenVehicle = NULL
    BOOL eligible = FALSE
    IF g_open EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        sirenVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
        IF DOES_ENTITY_EXIST(sirenVehicle)
            IF NOT IS_ENTITY_DEAD(sirenVehicle)
                IF GET_VEHICLE_CLASS(sirenVehicle) = VC_EMERGENCY
                    IF GET_PED_IN_VEHICLE_SEAT(sirenVehicle, VS_DRIVER, FALSE) = PLAYER_PED_ID()
                        eligible = TRUE
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDIF
    IF NOT eligible
        IF g_siren_mute_armed
            APPLY_EMERGENCY_SIREN_MUTE_STATE(g_siren_muted_veh, FALSE)
            ANNOUNCE_SIREN_MUTE(FALSE)
        ENDIF
        g_siren_mute_armed = FALSE
        g_siren_muted_veh = NULL
        g_siren_hold_start = 0
        g_siren_hold_latched = FALSE
        g_siren_mute_tick = 0
        EXIT
    ENDIF
    IF g_siren_mute_armed AND g_siren_muted_veh != sirenVehicle
        APPLY_EMERGENCY_SIREN_MUTE_STATE(g_siren_muted_veh, FALSE)
        g_siren_muted_veh = sirenVehicle
        APPLY_EMERGENCY_SIREN_MUTE_STATE(sirenVehicle, TRUE)
    ENDIF
    IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_HORN)
        IF g_siren_hold_start = 0
            g_siren_hold_start = GET_GAME_TIMER()
        ENDIF
        IF NOT g_siren_hold_latched
            IF GET_GAME_TIMER() - g_siren_hold_start >= SIREN_MUTE_HOLD_MS
                g_siren_hold_latched = TRUE
                g_siren_mute_armed = NOT g_siren_mute_armed
                IF g_siren_mute_armed
                    g_siren_muted_veh = sirenVehicle
                    APPLY_EMERGENCY_SIREN_MUTE_STATE(sirenVehicle, TRUE)
                    g_siren_mute_tick = GET_GAME_TIMER() + SIREN_MUTE_TICK_MS
                ELSE
                    APPLY_EMERGENCY_SIREN_MUTE_STATE(g_siren_muted_veh, FALSE)
                    g_siren_muted_veh = NULL
                ENDIF
                ANNOUNCE_SIREN_MUTE(g_siren_mute_armed)
            ENDIF
        ENDIF
    ELSE
        g_siren_hold_start = 0
        g_siren_hold_latched = FALSE
    ENDIF
    IF g_siren_mute_armed
        IF DOES_ENTITY_EXIST(g_siren_muted_veh)
            IF GET_GAME_TIMER() >= g_siren_mute_tick
                IF IS_VEHICLE_SIREN_AUDIO_ON(g_siren_muted_veh)
                    SET_VEHICLE_HAS_MUTED_SIRENS(g_siren_muted_veh, TRUE)
                ENDIF
                SET_VEHICLE_ACT_AS_IF_HAS_SIREN_ON(g_siren_muted_veh, TRUE)
                g_siren_mute_tick = GET_GAME_TIMER() + SIREN_MUTE_TICK_MS
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC APPLY_VEHICLE_SEAT_SWITCH()
    IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
    VEHICLE_INDEX seatVehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    SWITCH g_vehicle_seat_choice
        CASE 0 SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), seatVehicle, VS_DRIVER) BREAK
        CASE 1 SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), seatVehicle, VS_FRONT_RIGHT) BREAK
        CASE 2 SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), seatVehicle, VS_BACK_LEFT) BREAK
        CASE 3 SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), seatVehicle, VS_BACK_RIGHT) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_VEHICLE_WASH()
    g_vehicle_dirt_level = 0
    APPLY_VEHICLE_DIRT_LEVEL()
ENDPROC

FUNC BOOL MENU_COMBO_OPEN_PRESSED()
    IF g_menu_combo = 1
        IF IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB) AND IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_X) RETURN TRUE ENDIF
    ELIF g_menu_combo = 2
        IF IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) AND IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_X) RETURN TRUE ENDIF
    ELSE
        IF IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) AND IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN) RETURN TRUE ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

FUNC INT ITEM_COUNT()
    IF g_tab = 0 AND g_bodyguard_open
        IF g_guard_ped_open RETURN PED_CHOICE_COUNT() + 2 ENDIF
        RETURN 8
    ENDIF
    IF g_tab = 0 AND g_attacker_open
        IF g_attacker_ped_open RETURN PED_CHOICE_COUNT() + 2 ENDIF
        RETURN 6
    ENDIF
    IF g_tab = 0 AND g_outfit_open RETURN 21 ENDIF
    IF g_tab = 0 AND g_radio_open RETURN 3 ENDIF
    IF g_tab = 0 AND g_ped_open RETURN PED_CHOICE_COUNT() + 3 ENDIF
    IF g_tab = 3 AND g_chauffeur_open
        IF g_chauffeur_armed_open RETURN MENU_WEAPON_COUNT() + 1 ENDIF
        IF g_chauffeur_vehicle_open RETURN CHAUFFEUR_VEHICLE_COUNT ENDIF
        IF g_chauffeur_ped_open RETURN PED_CHOICE_COUNT() + 2 ENDIF
        RETURN CHAUFFEUR_MENU_ROWS
    ENDIF
    IF g_tab = 3 AND g_neon_anim_open RETURN 3 ENDIF
    IF g_tab = 3 AND g_spawner_open RETURN 11 ENDIF
    IF g_tab = 3 AND g_vehicle_control_open RETURN 9 ENDIF
    IF g_tab = 3 AND g_hydro_open RETURN HYDRO_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_interior_open RETURN INTERIOR_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_wheeltyre_open RETURN WHEELTYRE_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_lsc_extras_open RETURN LSC_EXTRAS_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_bennys_open RETURN BENNYS_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_support_open RETURN SUPPORTCHECK_MENU_ROWS ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) RETURN 1 ENDIF
        RETURN LSC_MENU_ROWS
    ENDIF
    IF g_tab = 1 AND g_weapon_upgrades_open RETURN 7 ENDIF
    IF g_tab = 5 AND g_tp_stores_open RETURN 19 ENDIF
    IF g_tab = 5 AND g_tp_locs_open RETURN 35 ENDIF
    IF g_tab = 4 AND g_timeweather_open RETURN 6 ENDIF
    IF g_tab = 7 AND g_spooner_open RETURN SPOONER_MENU_ROWS ENDIF
    IF g_tab = 7 AND g_nsc_loader_open RETURN NSC_LOADER_TOTAL_ROWS() ENDIF
    IF g_tab = 7 AND g_persist_open RETURN PERSIST_MENU_ROWS ENDIF
    SWITCH g_tab
        CASE 0
            IF g_auto_save RETURN 26 ENDIF
            RETURN 25 BREAK
        CASE 1 RETURN 9 BREAK
        CASE 2 RETURN 6 BREAK
        CASE 3 RETURN 26 BREAK
        CASE 4 RETURN 14 BREAK
        CASE 5 RETURN 14 BREAK
        CASE 6 RETURN MISC_MENU_ROWS BREAK
        CASE 7
            IF g_accent_choice = 14 RETURN 10 ENDIF
            RETURN 9 BREAK
    ENDSWITCH
    RETURN 1
ENDFUNC

FUNC INT ACTIVE_ITEM_COUNT()
    IF g_home RETURN 8 ENDIF
    RETURN ITEM_COUNT()
ENDFUNC

PROC DRAW_PAGE_COUNTER()
    INT total = ACTIVE_ITEM_COUNT()
    INT current = g_item + 1
    IF total < 1 total = 1 ENDIF
    IF current < 1 current = 1 ENDIF
    IF current > total current = total ENDIF
    TEXT_LABEL_63 tlCounter = ""
    tlCounter += current
    tlCounter += " / "
    tlCounter += total
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.270, 0.270)
    SET_TEXT_COLOUR(g_accent_r, g_accent_g, g_accent_b, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.105)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(tlCounter)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.105, 0.556 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC UPDATE_SCROLL()
    INT activeCount = ACTIVE_ITEM_COUNT()
    INT maxScroll = activeCount - 8
    IF activeCount < 1
        g_item = 0
        g_scroll = 0
        EXIT
    ENDIF
    IF maxScroll < 0 maxScroll = 0 ENDIF
    IF g_item < 0 g_item = 0 ENDIF
    IF g_item >= activeCount g_item = activeCount - 1 ENDIF
    IF g_scroll < 0 g_scroll = 0 ENDIF
    IF g_item < g_scroll g_scroll = g_item ENDIF
    IF g_item > g_scroll + 7 g_scroll = g_item - 7 ENDIF
    IF g_scroll > maxScroll g_scroll = maxScroll ENDIF
ENDPROC

PROC SAVE_NAVIGATION_STATE()
    IF g_home
        g_home_item = g_item
        g_home_scroll = g_scroll
    ELIF g_spawner_open
        g_spawner_item = g_item
        g_spawner_scroll = g_scroll
    ELIF g_vehicle_control_open
        g_vehicle_control_item = g_item
        g_vehicle_control_scroll = g_scroll
    ELIF g_outfit_open
        g_outfit_item = g_item
        g_outfit_scroll = g_scroll
    ELIF g_radio_open
        g_radio_item = g_item
        g_radio_scroll = g_scroll
    ELIF g_bodyguard_open
        IF g_guard_ped_open
            g_guard_ped_item = g_item
            g_guard_ped_scroll = g_scroll
        ELSE
            g_bodyguard_item = g_item
            g_bodyguard_scroll = g_scroll
        ENDIF
    ELIF g_attacker_open
        IF g_attacker_ped_open
            g_attacker_ped_item = g_item
            g_attacker_ped_scroll = g_scroll
        ELSE
            g_attacker_item = g_item
            g_attacker_scroll = g_scroll
        ENDIF
    ELIF g_neon_anim_open
        g_neon_anim_item = g_item
        g_neon_anim_scroll = g_scroll
    ELIF g_hydro_open
        g_hydro_item = g_item
        g_hydro_scroll = g_scroll
    ELIF g_interior_open
        g_interior_item = g_item
        g_interior_scroll = g_scroll
    ELIF g_wheeltyre_open
        g_wheeltyre_item = g_item
        g_wheeltyre_scroll = g_scroll
    ELIF g_lsc_extras_open
        g_lsc_extras_item = g_item
        g_lsc_extras_scroll = g_scroll
    ELIF g_bennys_open
        g_bennys_item = g_item
        g_bennys_scroll = g_scroll
    ELIF g_support_open
        g_support_item = g_item
        g_support_scroll = g_scroll
    ELIF g_lsc_open
        g_lsc_item = g_item
        g_lsc_scroll = g_scroll
    ELIF g_ped_open
        g_ped_item = g_item
        g_ped_scroll = g_scroll
    ELIF g_weapon_upgrades_open
        g_weapon_upgrades_item = g_item
        g_weapon_upgrades_scroll = g_scroll
    ELIF g_tp_stores_open
        g_tp_stores_item = g_item
        g_tp_stores_scroll = g_scroll
    ELIF g_tp_locs_open
        g_tp_locs_item = g_item
        g_tp_locs_scroll = g_scroll
    ELIF g_timeweather_open
        g_timeweather_item = g_item
        g_timeweather_scroll = g_scroll
    ELIF g_chauffeur_open
        IF g_chauffeur_armed_open
            g_chauffeur_armed_item = g_item
            g_chauffeur_armed_scroll = g_scroll
        ELIF g_chauffeur_vehicle_open
            g_chauffeur_vehicle_item = g_item
            g_chauffeur_vehicle_scroll = g_scroll
        ELIF g_chauffeur_ped_open
            g_chauffeur_ped_item = g_item
            g_chauffeur_ped_scroll = g_scroll
        ELSE
            g_chauffeur_item = g_item
            g_chauffeur_scroll = g_scroll
        ENDIF
    ELIF g_spooner_open
        g_spooner_item = g_item
        g_spooner_scroll = g_scroll
    ELIF g_nsc_loader_open
        g_nsc_loader_item = g_item
        g_nsc_loader_scroll = g_scroll
    ELIF g_persist_open
        g_persist_item = g_item
        g_persist_scroll = g_scroll
    ELSE
        g_page_item[g_tab] = g_item
        g_page_scroll[g_tab] = g_scroll
    ENDIF
ENDPROC

PROC DRAW_HOME()
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
    MENU_TEXT(g_menu_x - 0.085, 0.158, 0.390, titleR, titleG, titleB, "Made by: @Geekmaxxer")
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "CATEGORIES")
    DRAW_MENU_VERSION_TAG()
    DRAW_OPTION(0.268, "Player Settings", ">>>", g_item = 0, 2)
    DRAW_OPTION(0.306, "Weapon Options", ">>>", g_item = 1, 2)
    DRAW_OPTION(0.344, "Wanted Level", ">>>", g_item = 2, 2)
    DRAW_OPTION(0.382, "Vehicle Settings", ">>>", g_item = 3, 2)
    DRAW_OPTION(0.420, "World and Weather", ">>>", g_item = 4, 2)
    DRAW_OPTION(0.458, "Teleport Options", ">>>", g_item = 5, 2)
    DRAW_OPTION(0.496, "Misc Options", ">>>", g_item = 6, 2)
    DRAW_OPTION(0.534, "Menu Settings", ">>>", g_item = 7, 2)
    DRAW_PAGE_COUNTER()
    DRAW_DESCRIPTION_PANEL()
    DRAW_INSTRUCTIONAL_BUTTONS()
ENDPROC

PROC WARP_INTO_LAST_PLAYER_VEHICLE()
    IF NOCLIP_VEHICLE_ENTRY_BLOCKED() EXIT ENDIF
    VEHICLE_INDEX vehicle = GET_PLAYERS_LAST_VEHICLE()
    IF DOES_ENTITY_EXIST(vehicle) AND NOT IS_ENTITY_DEAD(vehicle)
        SET_PED_INTO_VEHICLE(PLAYER_PED_ID(), vehicle, VS_DRIVER)
    ENDIF
ENDPROC

PROC PROCESS_QUICK_VEHICLE_ENTRY_EXIT()
    PED_INDEX playerPed = PLAYER_PED_ID()
    IF NOCLIP_VEHICLE_ENTRY_BLOCKED() EXIT ENDIF
    IF NOT g_vehicle_quick_entry_exit OR g_open EXIT ENDIF
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_CONTEXT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_ENTER) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_VEH_EXIT) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_CONTEXT) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_ENTER) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_VEH_EXIT)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER, TRUE)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_EXIT, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CONTEXT, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_ENTER, TRUE)
        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_EXIT, TRUE)
        IF IS_PED_IN_ANY_VEHICLE(playerPed)
            CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
            TASK_LEAVE_ANY_VEHICLE(playerPed, 0, ECF_WARP_PED | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP)
        ELSE
            VEHICLE_INDEX nearbyVehicle = GET_CLOSEST_VEHICLE(GET_ENTITY_COORDS(playerPed), 7.5, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_LAW_ENFORCER_VEHICLES | VEHICLE_SEARCH_FLAG_RETURN_MISSION_VEHICLES)
            IF DOES_ENTITY_EXIST(nearbyVehicle)
                SET_PED_INTO_VEHICLE(playerPed, nearbyVehicle, VS_DRIVER)
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC PROCESS_HORN_BOOST()
    VEHICLE_INDEX vehicle
    VECTOR velocity = <<0.0, 0.0, 0.0>>
    IF NOT g_vehicle_horn_boost OR NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
        g_horn_boost_speed = 10.0
        EXIT
    ENDIF
    vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())
    IF IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_VEH_HORN)
        g_horn_boost_speed = GET_ENTITY_SPEED(vehicle)
        IF g_horn_boost_speed < 10.0 g_horn_boost_speed = 10.0 ENDIF
    ENDIF
    IF IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_VEH_HORN)
        IF g_horn_boost_speed < 65.0 g_horn_boost_speed = g_horn_boost_speed + 0.30 ENDIF
        velocity = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, <<0.0, g_horn_boost_speed, 0.0>>) - GET_ENTITY_COORDS(vehicle)
        SET_ENTITY_VELOCITY(vehicle, velocity)
    ELIF IS_CONTROL_JUST_RELEASED(PLAYER_CONTROL, INPUT_VEH_HORN)
        g_horn_boost_speed = 10.0
    ENDIF
ENDPROC

PROC MENU_CAPTURE_INPUT()
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_UP)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT)
    SET_INPUT_EXCLUSIVE(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_FRONTEND_ACCEPT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_CANCEL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_UP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_DOWN, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_LEFT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_FRONTEND_RIGHT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_LOOK_BEHIND, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_LOOK_BEHIND, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_LOOK_BEHIND, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_VEH_LOOK_BEHIND, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_RECORD, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_RECORD, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_START_STOP_RECORDING_SECONDARY, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_RECORD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SHOWHOTKEY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_CAMERAUP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_CAMERADOWN, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CINEMATIC_SLOWMO, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SCREENSHOT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_HIDEHUD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_MARKER_DELETE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CLIP_DELETE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PAUSE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_REWIND, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FFWD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_NEWMARKER, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_STARTPOINT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_ENDPOINT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_ADVANCE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_BACK, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOOLS, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_RESTART, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CYCLEMARKERLEFT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CYCLEMARKERRIGHT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FOVINCREASE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_FOVDECREASE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLETIME, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLETIPS, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PREVIEW, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TOGGLE_TIMELINE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_PICKUP_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_PLACE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_CTRL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_TIMELINE_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_PREVIEW_AUDIO, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_REPLAY_SNAPMATIC_PHOTO, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_CTRL, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TIMELINE_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_PREVIEW_AUDIO, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SNAPMATIC_PHOTO, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TOGGLETIME, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TOGGLETIPS, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_PREVIEW, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TOGGLE_TIMELINE, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TIMELINE_PICKUP_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_REPLAY_TIMELINE_PLACE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_CTRL, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TIMELINE_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_PREVIEW_AUDIO, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_SNAPMATIC_PHOTO, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_SAVE, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TOGGLETIME, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TOGGLETIPS, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_PREVIEW, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TOGGLE_TIMELINE, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TIMELINE_PICKUP_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(CAMERA_CONTROL, INPUT_REPLAY_TIMELINE_PLACE_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_SAVE_REPLAY_CLIP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_JUMP, TRUE)
ENDPROC

PROC ANNOUNCE_AUTO_SAVE()
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Autosaved!")
    END_TEXT_COMMAND_THEFEED_POST_UNLOCK_TU_WITH_COLOR("Autosaved!", 0, "", FALSE, HUD_COLOUR_GREEN, TRUE)
ENDPROC

PROC ANNOUNCE_MENU_WELCOME()
    TEXT_LABEL_63 welcomeTitle = "~p~MEGATARD Menu ~s~"
    welcomeTitle += g_menu_version
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(welcomeTitle)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Press ~y~LB + DPAD Down~s~ at the same time to open the menu.")
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Report any bugs or feature requests to ~b~@Geekmaxxer~s~, & ~g~Enjoy!~s~")
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
ENDPROC

FUNC BOOL AUTO_SAVE_STATE_SAFE()
    IF IS_AUTO_SAVE_IN_PROGRESS() RETURN FALSE ENDIF
    IF GET_IS_AUTO_SAVE_OFF() RETURN FALSE ENDIF
    IF GET_MISSION_FLAG() RETURN FALSE ENDIF
    IF IS_CUTSCENE_PLAYING() OR IS_CUTSCENE_ACTIVE() RETURN FALSE ENDIF
    IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN() RETURN FALSE ENDIF
    IF IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() RETURN FALSE ENDIF
    IF NOT IS_PLAYER_CONTROL_ON(PLAYER_ID()) RETURN FALSE ENDIF
    IF IS_PLAYER_DEAD(PLAYER_ID()) OR IS_ENTITY_DEAD(PLAYER_PED_ID()) RETURN FALSE ENDIF
    RETURN TRUE
ENDFUNC

PROC PROCESS_AUTO_SAVE()
    IF NOT g_auto_save EXIT ENDIF
    IF g_auto_save_interval <= 0 EXIT ENDIF
    IF GET_GAME_TIMER() < g_next_auto_save_time EXIT ENDIF
    IF NOT AUTO_SAVE_STATE_SAFE() EXIT ENDIF
    DO_AUTO_SAVE()
    g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000)
    g_auto_save_pending_announce = TRUE
    g_auto_save_pending_since = GET_GAME_TIMER()
ENDPROC

PROC PROCESS_AUTO_SAVE_ANNOUNCE()
    IF NOT g_auto_save_pending_announce EXIT ENDIF
    IF IS_AUTO_SAVE_IN_PROGRESS()
        g_auto_save_pending_announce = FALSE
        ANNOUNCE_AUTO_SAVE()
        EXIT
    ENDIF
    IF GET_GAME_TIMER() > g_auto_save_pending_since + 15000
        g_auto_save_pending_announce = FALSE
    ENDIF
ENDPROC

PROC PROCESS_MENU_WELCOME()
    IF g_welcome_shown EXIT ENDIF
    IF GET_GAME_TIMER() < g_menu_start_time + 5000 EXIT ENDIF
    IF NOT IS_PLAYER_CONTROL_ON(PLAYER_ID()) EXIT ENDIF
    IF IS_PLAYER_DEAD(PLAYER_ID()) OR IS_ENTITY_DEAD(PLAYER_PED_ID()) EXIT ENDIF
    IF IS_CUTSCENE_PLAYING() OR IS_CUTSCENE_ACTIVE() EXIT ENDIF
    IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT() OR IS_SCREEN_FADING_IN() EXIT ENDIF
    IF IS_PAUSE_MENU_ACTIVE() OR IS_WARNING_MESSAGE_ACTIVE() EXIT ENDIF
    g_welcome_shown = TRUE
    ANNOUNCE_MENU_WELCOME()
ENDPROC

PROC STOP_NPC_BRAWL()
    INT index = 0
    REPEAT g_brawl_ped_count index
        IF DOES_ENTITY_EXIST(g_brawl_peds[index])
            CLEAR_PED_TASKS(g_brawl_peds[index])
            SET_PED_KEEP_TASK(g_brawl_peds[index], FALSE)
            SET_PED_AS_ENEMY(g_brawl_peds[index], FALSE)
            SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[index], FALSE)
        ENDIF
    ENDREPEAT
    g_brawl_ped_count = 0
ENDPROC

FUNC BOOL IS_TRACKED_BRAWLER(PED_INDEX ped)
    INT index = 0
    REPEAT g_brawl_ped_count index
        IF g_brawl_peds[index] = ped RETURN TRUE ENDIF
    ENDREPEAT
    RETURN FALSE
ENDFUNC

PROC TASK_NEARBY_NPCS_TO_BRAWL()
    PED_INDEX nearbyPeds[32]
    INT index = 0
    INT pair = 0
    INT nearbyCount = GET_PED_NEARBY_PEDS(PLAYER_PED_ID(), nearbyPeds, PEDTYPE_INVALID)
    IF nearbyCount > COUNT_OF(nearbyPeds) nearbyCount = COUNT_OF(nearbyPeds) ENDIF
    STOP_NPC_BRAWL()
    REPEAT nearbyCount index
        IF nearbyPeds[index] != PLAYER_PED_ID()
        AND DOES_ENTITY_EXIST(nearbyPeds[index])
        AND NOT IS_PED_INJURED(nearbyPeds[index])
        AND NOT IS_PED_IN_ANY_VEHICLE(nearbyPeds[index])
        AND NOT IS_PED_A_PLAYER(nearbyPeds[index])
            IF g_brawl_ped_count < COUNT_OF(g_brawl_peds)
                g_brawl_peds[g_brawl_ped_count] = nearbyPeds[index]
                g_brawl_ped_count = g_brawl_ped_count + 1
            ENDIF
        ENDIF
    ENDREPEAT
    IF g_brawl_ped_count > 16 g_brawl_ped_count = 16 ENDIF
    pair = 0
    WHILE pair + 1 < g_brawl_ped_count
        SET_PED_AS_ENEMY(g_brawl_peds[pair], TRUE)
        SET_PED_AS_ENEMY(g_brawl_peds[pair + 1], TRUE)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[pair], TRUE)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_brawl_peds[pair + 1], TRUE)
        TASK_COMBAT_PED(g_brawl_peds[pair], g_brawl_peds[pair + 1])
        TASK_COMBAT_PED(g_brawl_peds[pair + 1], g_brawl_peds[pair])
        SET_PED_KEEP_TASK(g_brawl_peds[pair], TRUE)
        SET_PED_KEEP_TASK(g_brawl_peds[pair + 1], TRUE)
        pair = pair + 2
    ENDWHILE
ENDPROC

PROC APPLY_ACCENT_CHOICE()
    SWITCH g_accent_choice
        CASE 0 g_accent_r = 31 g_accent_g = 100 g_accent_b = 190 BREAK
        CASE 1 g_accent_r = 185 g_accent_g = 35 g_accent_b = 48 BREAK
        CASE 2 g_accent_r = 205 g_accent_g = 145 g_accent_b = 28 BREAK
        CASE 3 g_accent_r = 125 g_accent_g = 62 g_accent_b = 188 BREAK
        CASE 4 g_accent_r = 20 g_accent_g = 150 g_accent_b = 105 BREAK
        CASE 5 g_accent_r = 0 g_accent_g = 170 g_accent_b = 210 BREAK
        CASE 6 g_accent_r = 235 g_accent_g = 110 g_accent_b = 25 BREAK
        CASE 7 g_accent_r = 220 g_accent_g = 55 g_accent_b = 130 BREAK
        CASE 8 g_accent_r = 85 g_accent_g = 95 g_accent_b = 115 BREAK
        CASE 9 g_accent_r = 155 g_accent_g = 205 g_accent_b = 35 BREAK
        CASE 10 g_accent_r = 230 g_accent_g = 230 g_accent_b = 235 BREAK
        CASE 11 g_accent_r = 210 g_accent_g = 75 g_accent_b = 25 BREAK
        CASE 12 g_accent_r = 55 g_accent_g = 55 g_accent_b = 55 BREAK
        CASE 13 g_accent_r = 35 g_accent_g = 135 g_accent_b = 215 BREAK
        CASE 14 g_accent_rgb = TRUE g_accent_rgb_step = 0 g_accent_rgb_time = GET_GAME_TIMER() BREAK
    ENDSWITCH
    IF g_accent_choice != 14 g_accent_rgb = FALSE ENDIF
ENDPROC

PROC PROCESS_PLAYER_NOCLIP()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR currentPosition = <<0.0, 0.0, 0.0>>
    VECTOR resyncPosition = <<0.0, 0.0, 0.0>>
    VECTOR forwardStep = <<0.0, 0.0, 0.0>>
    VECTOR rightStep = <<0.0, 0.0, 0.0>>
    VECTOR moveDelta = <<0.0, 0.0, 0.0>>
    VECTOR targetPosition = <<0.0, 0.0, 0.0>>
    FLOAT stepSize = 0.55
    FLOAT groundZ = 0.0
    FLOAT lockedZ = 0.0
    BOOL wantsForward = FALSE
    BOOL wantsBack = FALSE
    BOOL wantsLeft = FALSE
    BOOL wantsRight = FALSE
    BOOL wantsUp = FALSE
    BOOL wantsDown = FALSE
    BOOL wantsFast = FALSE
    IF NOT g_player_noclip EXIT ENDIF
    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        FREEZE_ENTITY_POSITION(playerPed, FALSE)
        SET_ENTITY_HAS_GRAVITY(playerPed, TRUE)
        SET_ENTITY_COLLISION(playerPed, TRUE, TRUE)
        SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
        resyncPosition = GET_ENTITY_COORDS(playerPed)
        g_player_noclip_z = resyncPosition.z
        EXIT
    ENDIF
    IF IS_ENTITY_DEAD(playerPed)
        FREEZE_ENTITY_POSITION(playerPed, FALSE)
        SET_ENTITY_HAS_GRAVITY(playerPed, TRUE)
        SET_ENTITY_COLLISION(playerPed, TRUE, TRUE)
        SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
        resyncPosition = GET_ENTITY_COORDS(playerPed)
        g_player_noclip_z = resyncPosition.z
        EXIT
    ENDIF
    FREEZE_ENTITY_POSITION(playerPed, TRUE)
    SET_ENTITY_HAS_GRAVITY(playerPed, FALSE)
    SET_ENTITY_COLLISION(playerPed, FALSE, FALSE)
    SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
    IF g_open
        wantsForward = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_UP_ONLY)
        wantsBack = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_DOWN_ONLY)
        wantsLeft = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_LEFT_ONLY)
        wantsRight = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_RIGHT_ONLY)
        wantsUp = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_JUMP)
        wantsDown = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_SPRINT)
        wantsFast = IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_RELOAD)
    ELSE
        wantsForward = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_UP_ONLY)
        wantsBack = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_DOWN_ONLY)
        wantsLeft = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_LEFT_ONLY)
        wantsRight = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_MOVE_RIGHT_ONLY)
        wantsUp = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_JUMP)
        wantsDown = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_SPRINT)
        wantsFast = IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_RELOAD)
    ENDIF
    IF wantsFast stepSize = 1.65 ENDIF
    currentPosition = GET_ENTITY_COORDS(playerPed)
    forwardStep = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<0.0, stepSize, 0.0>>)
    rightStep = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<stepSize, 0.0, 0.0>>)
    forwardStep = <<forwardStep.x - currentPosition.x, forwardStep.y - currentPosition.y, 0.0>>
    rightStep = <<rightStep.x - currentPosition.x, rightStep.y - currentPosition.y, 0.0>>
    moveDelta = <<0.0, 0.0, 0.0>>
    IF wantsForward moveDelta = moveDelta + forwardStep ENDIF
    IF wantsBack moveDelta = moveDelta - forwardStep ENDIF
    IF wantsRight moveDelta = moveDelta + rightStep ENDIF
    IF wantsLeft moveDelta = moveDelta - rightStep ENDIF
    lockedZ = g_player_noclip_z
    IF wantsUp AND NOT wantsDown
        lockedZ = lockedZ + stepSize
    ELIF wantsDown AND NOT wantsUp
        lockedZ = lockedZ - stepSize
    ENDIF
    targetPosition = <<currentPosition.x + moveDelta.x, currentPosition.y + moveDelta.y, lockedZ>>
    IF GET_GROUND_Z_FOR_3D_COORD(targetPosition, groundZ)
        IF NOT wantsUp AND NOT wantsDown
            IF groundZ + g_player_noclip_ground_offset > lockedZ
                lockedZ = groundZ + g_player_noclip_ground_offset
            ELIF lockedZ - (groundZ + g_player_noclip_ground_offset) < 1.5
                IF groundZ + g_player_noclip_ground_offset < lockedZ - 0.3
                    lockedZ = lockedZ - 0.3
                ELSE
                    lockedZ = groundZ + g_player_noclip_ground_offset
                ENDIF
            ENDIF
        ELSE
            IF groundZ + 0.5 > lockedZ lockedZ = groundZ + 0.5 ENDIF
        ENDIF
    ENDIF
    g_player_noclip_z = lockedZ
    SET_ENTITY_COORDS(playerPed, <<targetPosition.x, targetPosition.y, g_player_noclip_z>>, FALSE, TRUE, TRUE)
    SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
ENDPROC

PROC SET_PLAYER_NOCLIP_ENABLED(BOOL enabled)
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR enablePosition = <<0.0, 0.0, 0.0>>
    FLOAT groundZ = 0.0
    g_player_noclip = enabled
    IF NOT enabled g_player_freecam = FALSE ENDIF
    IF enabled
        enablePosition = GET_ENTITY_COORDS(playerPed)
        g_player_noclip_z = enablePosition.z
        IF GET_GROUND_Z_FOR_3D_COORD(enablePosition, groundZ)
            IF groundZ + 1.0 > enablePosition.z
                g_player_noclip_ground_offset = groundZ + 1.0 - enablePosition.z
            ELSE
                g_player_noclip_ground_offset = enablePosition.z - groundZ
            ENDIF
            IF g_player_noclip_ground_offset < 0.5 g_player_noclip_ground_offset = 0.5 ENDIF
            IF g_player_noclip_ground_offset > 3.0 g_player_noclip_ground_offset = 3.0 ENDIF
        ELSE
            g_player_noclip_ground_offset = 1.0
        ENDIF
        FREEZE_ENTITY_POSITION(playerPed, TRUE)
        SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
        SET_ENTITY_HAS_GRAVITY(playerPed, FALSE)
        SET_ENTITY_COLLISION(playerPed, FALSE, FALSE)
        SET_ENTITY_COORDS(playerPed, <<enablePosition.x, enablePosition.y, g_player_noclip_z>>, FALSE, TRUE, TRUE)
        SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
    ELSE
        FREEZE_ENTITY_POSITION(playerPed, FALSE)
        SET_ENTITY_HAS_GRAVITY(playerPed, TRUE)
        SET_ENTITY_COLLISION(playerPed, TRUE, TRUE)
        SET_ENTITY_VELOCITY(playerPed, <<0.0, 0.0, 0.0>>)
        REQUEST_COLLISION_AT_COORD(GET_ENTITY_COORDS(playerPed))
    ENDIF
ENDPROC

PROC SET_PLAYER_FREECAM_ENABLED(BOOL enabled)
    PED_INDEX playerPed = PLAYER_PED_ID()
    g_player_freecam = enabled
    IF enabled
        g_invisible = TRUE
        SET_ENTITY_VISIBLE(playerPed, FALSE)
        g_first_person = TRUE
        IF NOT IS_PED_IN_ANY_VEHICLE(playerPed) SET_PLAYER_NOCLIP_ENABLED(TRUE) ENDIF
    ELSE
        g_invisible = FALSE
        SET_ENTITY_VISIBLE(playerPed, TRUE)
        g_first_person = FALSE
        IF g_player_noclip SET_PLAYER_NOCLIP_ENABLED(FALSE) ENDIF
    ENDIF
ENDPROC

FUNC FLOAT ACCENT_RGB_SPEED_VALUE()
    IF g_accent_rgb_speed_index <= 0 RETURN 0.0 ENDIF
    IF g_accent_rgb_speed_index >= 41 RETURN 10.0 ENDIF
    RETURN TO_FLOAT(g_accent_rgb_speed_index) * 0.25
ENDFUNC

FUNC INT ACCENT_RGB_STEP_SIZE()
    INT level = g_accent_rgb_speed_index
    IF level < 0 level = 0 ENDIF
    IF level > 41 level = 41 ENDIF
    IF level <= 0 RETURN 0 ENDIF
    RETURN 1 + ((level * 31) / 41)
ENDFUNC

FUNC INT RGB_ACCENT_INTERVAL()
    IF g_accent_rgb_speed_index < 0 g_accent_rgb_speed_index = 0 ENDIF
    IF g_accent_rgb_speed_index > 41 g_accent_rgb_speed_index = 41 ENDIF
    IF g_accent_rgb_speed_index <= 0 RETURN 2000 ENDIF
    RETURN 300 / g_accent_rgb_speed_index
ENDFUNC

FUNC BOOL ACCENT_RGB_REVERSED()
    RETURN FALSE
ENDFUNC

PROC PROCESS_RGB_ACCENT()
    INT phase = 0
    INT next = 0
    IF NOT g_accent_rgb OR g_accent_choice != 14 EXIT ENDIF
    IF GET_GAME_TIMER() < g_accent_rgb_time EXIT ENDIF
    g_accent_rgb_time = GET_GAME_TIMER() + RGB_ACCENT_INTERVAL()
    phase = g_accent_rgb_step
    IF phase < 0 phase = 0 ENDIF
    IF phase > 1799 phase = 0 ENDIF
    IF ACCENT_RGB_REVERSED()
        next = phase - ACCENT_RGB_STEP_SIZE()
        WHILE next < 0 next = next + 1800 ENDWHILE
    ELSE
        next = phase + ACCENT_RGB_STEP_SIZE()
        WHILE next > 1799 next = next - 1800 ENDWHILE
    ENDIF
    g_accent_rgb_step = next
    phase = g_accent_rgb_step
    IF phase < 300
        g_accent_r = 31 + (((185 - 31) * phase) / 300)
        g_accent_g = 100 + (((35 - 100) * phase) / 300)
        g_accent_b = 190 + (((48 - 190) * phase) / 300)
    ELIF phase < 600
        g_accent_r = 185 + (((20 - 185) * (phase - 300)) / 300)
        g_accent_g = 35 + (((150 - 35) * (phase - 300)) / 300)
        g_accent_b = 48 + (((105 - 48) * (phase - 300)) / 300)
    ELIF phase < 900
        g_accent_r = 20 + (((0 - 20) * (phase - 600)) / 300)
        g_accent_g = 150 + (((170 - 150) * (phase - 600)) / 300)
        g_accent_b = 105 + (((210 - 105) * (phase - 600)) / 300)
    ELIF phase < 1200
        g_accent_r = 0 + (((235 - 0) * (phase - 900)) / 300)
        g_accent_g = 170 + (((110 - 170) * (phase - 900)) / 300)
        g_accent_b = 210 + (((25 - 210) * (phase - 900)) / 300)
    ELIF phase < 1500
        g_accent_r = 235 + (((125 - 235) * (phase - 1200)) / 300)
        g_accent_g = 110 + (((62 - 110) * (phase - 1200)) / 300)
        g_accent_b = 25 + (((188 - 25) * (phase - 1200)) / 300)
    ELSE
        g_accent_r = 125 + (((31 - 125) * (phase - 1500)) / 300)
        g_accent_g = 62 + (((100 - 62) * (phase - 1500)) / 300)
        g_accent_b = 188 + (((190 - 188) * (phase - 1500)) / 300)
    ENDIF
ENDPROC

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

PROC ADJUST_VEHICLE_SPAWN_CHOICE(INT direction)
    INT first = 0
    INT last = 18
    INT candidate = 0
    INT attempts = 0
    IF g_vehicle_spawn_category = 1
        first = 19
        last = 23
    ENDIF
    IF g_vehicle_spawn_category = 2
        first = 24
        last = 27
    ENDIF
    IF g_vehicle_spawn_category = 7
        first = 72
        last = 88
    ENDIF
    IF g_vehicle_spawn_category = 8
        first = 89
        last = 189
    ENDIF
    IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
        IF GET_NUM_DLC_VEHICLES() <= 0 EXIT ENDIF
        IF g_dlc_vehicle_index < 0 OR NOT DLC_CATEGORY_MATCH(g_vehicle_spawn_category, g_dlc_vehicle_index)
            g_dlc_vehicle_index = FIND_FIRST_DLC_FOR_CATEGORY(g_vehicle_spawn_category)
        ENDIF
        IF g_dlc_vehicle_index < 0 EXIT ENDIF
        candidate = g_dlc_vehicle_index + direction
        WHILE attempts < 512
            IF candidate < 0 candidate = GET_NUM_DLC_VEHICLES() - 1 ENDIF
            IF candidate >= GET_NUM_DLC_VEHICLES() candidate = 0 ENDIF
            IF DLC_CATEGORY_MATCH(g_vehicle_spawn_category, candidate)
                g_dlc_vehicle_index = candidate
                EXIT
            ENDIF
            candidate = candidate + direction
            attempts = attempts + 1
        ENDWHILE
        EXIT
    ENDIF
    g_vehicle_spawn_choice = g_vehicle_spawn_choice + direction
    IF g_vehicle_spawn_choice < first g_vehicle_spawn_choice = last ENDIF
    IF g_vehicle_spawn_choice > last g_vehicle_spawn_choice = first ENDIF
ENDPROC

FUNC BOOL IS_SELECTOR_ACTIVE()
    IF g_tab = 0 AND g_outfit_open RETURN TRUE ENDIF
    IF g_tab = 0 AND g_radio_open RETURN FALSE ENDIF
    IF g_tab = 0 AND g_bodyguard_open
        IF g_guard_ped_open RETURN FALSE ENDIF
        IF g_item = 1 OR g_item = 2 OR g_item = 3 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0 AND g_attacker_open
        IF g_attacker_ped_open RETURN FALSE ENDIF
        IF g_item = 1 OR g_item = 2 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 3 AND g_neon_anim_open
        IF g_item = 0 OR g_item = 1 OR g_item = 2 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 3 AND g_chauffeur_open
        IF g_chauffeur_armed_open RETURN FALSE ENDIF
        IF g_chauffeur_vehicle_open RETURN FALSE ENDIF
        IF g_chauffeur_ped_open RETURN FALSE ENDIF
        IF g_item = 3 RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    IF g_tab = 3 AND g_vehicle_control_open
        IF g_item = 0 OR g_item = 1 OR g_item = 6 OR g_item = 7 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0 AND g_ped_open
        IF g_item = 2 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1 OR g_item = 2 OR g_item = 3 OR g_item = 5 OR g_item = 6 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 6
        IF g_item = 5 OR g_item = 12 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0 AND NOT g_outfit_open AND NOT g_radio_open AND NOT g_bodyguard_open AND NOT g_attacker_open AND NOT g_ped_open AND NOT g_weapon_upgrades_open
        IF g_item = 17 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 0 AND NOT g_outfit_open AND NOT g_radio_open AND NOT g_bodyguard_open AND NOT g_attacker_open AND NOT g_ped_open AND NOT g_weapon_upgrades_open
        IF g_item = 25 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 4
        IF g_timeweather_open
            IF g_item = 0 OR g_item = 1 OR g_item = 2 OR g_item = 3 OR g_item = 5 RETURN TRUE ENDIF
        ELSE
            IF g_item = 3 OR g_item = 4 OR g_item = 5 RETURN TRUE ENDIF
        ENDIF
    ENDIF
    IF g_tab = 2 AND g_item = 2 RETURN TRUE ENDIF
    IF g_tab = 1 AND (g_item = 1) AND NOT g_weapon_upgrades_open RETURN TRUE ENDIF
    IF g_tab = 1 AND g_weapon_upgrades_open AND g_item = 6 RETURN TRUE ENDIF
    IF g_tab = 3 AND g_item = 24 AND NOT g_lsc_open AND NOT g_vehicle_control_open RETURN TRUE ENDIF
    IF g_tab = 3 AND NOT g_lsc_open AND NOT g_vehicle_control_open AND (g_item = 8 OR g_item = 9) RETURN TRUE ENDIF
    IF g_tab = 3 AND g_hydro_open
        IF g_item = 1 OR g_item = 3 OR g_item = 5 OR g_item = 6 OR g_item = 7 OR g_item = 8 OR g_item = 10 OR g_item = 11 OR g_item = 12 OR g_item = 13 RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    IF g_tab = 3 AND g_interior_open
        IF g_item = 1 OR g_item = 2 OR g_item = 3 OR g_item = 7 OR g_item = 8 RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    IF g_tab = 3 AND g_wheeltyre_open
        IF g_item = 0 OR g_item = 1 OR g_item = 2 RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    IF g_tab = 3 AND g_lsc_extras_open
        IF g_item = 0 OR g_item = 4 RETURN TRUE ENDIF
        RETURN FALSE
    ENDIF
    IF g_tab = 3 AND g_bennys_open RETURN FALSE ENDIF
    IF g_tab = 3 AND g_support_open RETURN FALSE ENDIF
    IF g_tab = 3 AND g_lsc_open
        IF g_item = 2 OR g_item = 3 OR g_item = 5 OR g_item = 6 OR g_item = 7 OR g_item = 8 OR g_item = 9 OR g_item = 12 OR g_item = 14 OR g_item = 15 OR g_item = 19 RETURN TRUE ENDIF
    ENDIF
    IF g_tab = 7
        IF g_spooner_open
            IF g_item = 0 OR g_item = 3 OR g_item = 4 OR g_item = 5 OR g_item = 6 OR g_item = 7 OR g_item = 12 OR g_item = 13 OR g_item = 14 OR g_item = 15 OR g_item = 16 RETURN TRUE ENDIF
            RETURN FALSE
        ENDIF
        IF g_nsc_loader_open
            IF g_item = 2 RETURN TRUE ENDIF
            RETURN FALSE
        ENDIF
        IF g_persist_open
            IF g_item = 0 OR g_item = 5 RETURN TRUE ENDIF
            RETURN FALSE
        ENDIF
        IF g_item = 2 OR g_item = 3 RETURN TRUE ENDIF
        IF g_accent_choice = 14
            IF g_item = 4 OR g_item = 6 OR g_item = 7 OR g_item = 8 RETURN TRUE ENDIF
        ELSE
            IF g_item = 5 OR g_item = 6 OR g_item = 7 RETURN TRUE ENDIF
        ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

PROC ADJUST_SELECTOR(INT direction)
    IF g_tab = 0 AND g_outfit_open
        ADJUST_OUTFIT_SLOT(direction)
        EXIT
    ENDIF
    IF g_tab = 0 AND g_ped_open
        ADJUST_PED_SELECTOR(direction)
        EXIT
    ENDIF
    IF g_tab = 3 AND g_chauffeur_open
        IF g_chauffeur_armed_open EXIT ENDIF
        IF g_chauffeur_vehicle_open EXIT ENDIF
        IF g_chauffeur_ped_open EXIT ENDIF
        IF g_item = 3
            g_chauffeur_style = 1 - g_chauffeur_style
            REFRESH_CHAUFFEUR_DRIVING_MODE()
            ISSUE_CHAUFFEUR_DRIVE_TASK()
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_spawner_open
        IF g_item = 1
            g_vehicle_spawn_category = g_vehicle_spawn_category + direction
            IF g_vehicle_spawn_category < 0 g_vehicle_spawn_category = 8 ENDIF
            IF g_vehicle_spawn_category > 8 g_vehicle_spawn_category = 0 ENDIF
            IF g_vehicle_spawn_category = 0 g_vehicle_spawn_choice = 0 ENDIF
            IF g_vehicle_spawn_category = 1 g_vehicle_spawn_choice = 19 ENDIF
            IF g_vehicle_spawn_category = 2 g_vehicle_spawn_choice = 24 ENDIF
            IF g_vehicle_spawn_category >= 3 AND g_vehicle_spawn_category <= 6
                g_dlc_vehicle_index = FIND_FIRST_DLC_FOR_CATEGORY(g_vehicle_spawn_category)
            ENDIF
            IF g_vehicle_spawn_category = 7 g_vehicle_spawn_choice = 72 ENDIF
            IF g_vehicle_spawn_category = 8 g_vehicle_spawn_choice = 89 ENDIF
        ELIF g_item = 2
            ADJUST_VEHICLE_SPAWN_CHOICE(direction)
        ELIF g_item = 3
            g_spawn_count = g_spawn_count + direction
            IF g_spawn_count < 1 g_spawn_count = 500 ENDIF
            IF g_spawn_count > 500 g_spawn_count = 1 ENDIF
        ELIF g_item = 5
            g_spawn_alignment = 1 - g_spawn_alignment
        ELIF g_item = 6
            g_spawn_facing = g_spawn_facing + direction
            IF g_spawn_facing < 0 g_spawn_facing = 3 ENDIF
            IF g_spawn_facing > 3 g_spawn_facing = 0 ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 0 AND g_bodyguard_open
        IF g_guard_ped_open EXIT ENDIF
        IF g_item = 2
            g_bodyguard_weapon_choice = g_bodyguard_weapon_choice + direction
            IF g_bodyguard_weapon_choice < 0 g_bodyguard_weapon_choice = 4 ENDIF
            IF g_bodyguard_weapon_choice > 4 g_bodyguard_weapon_choice = 0 ENDIF
        ENDIF
        IF g_item = 3
            g_bodyguard_formation_choice = g_bodyguard_formation_choice + direction
            IF g_bodyguard_formation_choice < 0 g_bodyguard_formation_choice = 2 ENDIF
            IF g_bodyguard_formation_choice > 2 g_bodyguard_formation_choice = 0 ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_vehicle_control_open
        IF NOT IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID()) EXIT ENDIF
        IF g_item = 0
            g_vehicle_window_action = 1 - g_vehicle_window_action
            APPLY_VEHICLE_WINDOW_ACTION()
        ENDIF
        IF g_item = 1
            g_vehicle_window_choice = g_vehicle_window_choice + direction
            IF g_vehicle_window_choice < 0 g_vehicle_window_choice = 5 ENDIF
            IF g_vehicle_window_choice > 5 g_vehicle_window_choice = 0 ENDIF
        ENDIF
        IF g_item = 6
            g_vehicle_seat_choice = g_vehicle_seat_choice + direction
            IF g_vehicle_seat_choice < 0 g_vehicle_seat_choice = 3 ENDIF
            IF g_vehicle_seat_choice > 3 g_vehicle_seat_choice = 0 ENDIF
        ENDIF
        IF g_item = 7
            g_vehicle_dirt_level = g_vehicle_dirt_level + direction
            IF g_vehicle_dirt_level < 0 g_vehicle_dirt_level = 0 ENDIF
            IF g_vehicle_dirt_level > 30 g_vehicle_dirt_level = 30 ENDIF
            APPLY_VEHICLE_DIRT_LEVEL()
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_neon_anim_open
        IF g_item = 0
            g_neon_mode = g_neon_mode + direction
            IF g_neon_mode < 0 g_neon_mode = 6 ENDIF
            IF g_neon_mode > 6 g_neon_mode = 0 ENDIF
            APPLY_NEON_ANIM_STATE()
        ENDIF
        IF g_item = 1 AND g_neon_mode = 3
            g_neon_speed_index = g_neon_speed_index + direction
            IF g_neon_speed_index < 0 g_neon_speed_index = 0 ENDIF
            IF g_neon_speed_index > 41 g_neon_speed_index = 41 ENDIF
            IF NOT g_lsc_neon APPLY_NEON_ANIM_STATE() ENDIF
        ENDIF
        IF g_item = 1 AND g_neon_mode != 3
            g_lsc_neon_colour = g_lsc_neon_colour + direction
            IF g_lsc_neon_colour < 0 g_lsc_neon_colour = 12 ENDIF
            IF g_lsc_neon_colour > 12 g_lsc_neon_colour = 0 ENDIF
            SET_VEHICLE_NEON_INDEX_COLOUR(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_neon_colour)
        ENDIF
        IF g_item = 2 AND g_neon_mode != 3
            g_neon_speed_index = g_neon_speed_index + direction
            IF g_neon_speed_index < 0 g_neon_speed_index = 0 ENDIF
            IF g_neon_speed_index > 41 g_neon_speed_index = 41 ENDIF
            IF NOT g_lsc_neon APPLY_NEON_ANIM_STATE() ENDIF
        ENDIF
        IF g_item = 2 AND g_neon_mode = 3
            g_neon_transition = 1 - g_neon_transition
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 0 AND g_attacker_open
        IF g_attacker_ped_open EXIT ENDIF
        IF g_item = 2
            g_attacker_weapon_choice = g_attacker_weapon_choice + direction
            IF g_attacker_weapon_choice < 0 g_attacker_weapon_choice = 3 ENDIF
            IF g_attacker_weapon_choice > 3 g_attacker_weapon_choice = 0 ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 6
        IF g_item = 5
            g_npc_density_choice = g_npc_density_choice + direction
            IF g_npc_density_choice < 0 g_npc_density_choice = 4 ENDIF
            IF g_npc_density_choice > 4 g_npc_density_choice = 0 ENDIF
            APPLY_NPC_DENSITY()
        ENDIF
        IF g_item = 12
            g_stripper_choice = g_stripper_choice + direction
            IF g_stripper_choice < 0 g_stripper_choice = STRIPPER_MODEL_COUNT - 1 ENDIF
            IF g_stripper_choice >= STRIPPER_MODEL_COUNT g_stripper_choice = 0 ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 0 AND NOT g_outfit_open AND NOT g_radio_open AND NOT g_bodyguard_open AND NOT g_attacker_open AND NOT g_ped_open AND NOT g_weapon_upgrades_open
        IF g_item = 17
            g_cash_amount = g_cash_amount + (direction * 10000)
            IF g_cash_amount < 0 g_cash_amount = 0 ENDIF
            IF g_cash_amount > 2147483647 g_cash_amount = 2147483647 ENDIF
        ENDIF
        IF g_item = 25
            g_auto_save_interval = g_auto_save_interval + direction
            IF g_auto_save_interval < 0 g_auto_save_interval = 0 ENDIF
            IF g_auto_save_interval > 120 g_auto_save_interval = 120 ENDIF
            IF g_auto_save g_next_auto_save_time = GET_GAME_TIMER() + (g_auto_save_interval * 60000) ENDIF
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 4
        IF g_timeweather_open
            IF g_item = 0
                g_time_choice = g_time_choice + direction
                IF g_time_choice < 0 g_time_choice = 3 ENDIF
                IF g_time_choice > 3 g_time_choice = 0 ENDIF
            ENDIF
            IF g_item = 5
                g_weather_choice = g_weather_choice + direction
                IF g_weather_choice < 0 g_weather_choice = 16 ENDIF
                IF g_weather_choice > 16 g_weather_choice = 0 ENDIF
            ENDIF
            IF g_item = 1
                g_time_hour = g_time_hour + direction
                IF g_time_hour < 0 g_time_hour = 23 ENDIF
                IF g_time_hour > 23 g_time_hour = 0 ENDIF
                APPLY_EDITABLE_TIME()
            ENDIF
            IF g_item = 2
                g_time_minute = g_time_minute + direction
                IF g_time_minute < 0 g_time_minute = 59 ENDIF
                IF g_time_minute > 59 g_time_minute = 0 ENDIF
                APPLY_EDITABLE_TIME()
            ENDIF
            IF g_item = 3
                g_time_second = g_time_second + direction
                IF g_time_second < 0 g_time_second = 59 ENDIF
                IF g_time_second > 59 g_time_second = 0 ENDIF
                APPLY_EDITABLE_TIME()
            ENDIF
        ELSE
            IF g_item = 3
                g_ipl_preset = g_ipl_preset + direction
                IF g_ipl_preset < 0 g_ipl_preset = 24 ENDIF
                IF g_ipl_preset > 24 g_ipl_preset = 0 ENDIF
            ENDIF
            IF g_item = 4
                g_time_scale_level = g_time_scale_level + direction
                IF g_time_scale_level < 0 g_time_scale_level = 40 ENDIF
                IF g_time_scale_level > 40 g_time_scale_level = 0 ENDIF
                APPLY_TIME_SCALE()
            ENDIF
            IF g_item = 5
                g_gravity_choice = g_gravity_choice + direction
                IF g_gravity_choice < 0 g_gravity_choice = 3 ENDIF
                IF g_gravity_choice > 3 g_gravity_choice = 0 ENDIF
                APPLY_GRAVITY_CHOICE()
            ENDIF
        ENDIF
    ENDIF
    IF g_tab = 2 AND g_item = 2
        g_wanted_level_choice = g_wanted_level_choice + direction
        IF g_wanted_level_choice < 1 g_wanted_level_choice = 5 ENDIF
        IF g_wanted_level_choice > 5 g_wanted_level_choice = 1 ENDIF
    ENDIF
    IF g_tab = 1 AND g_weapon_upgrades_open AND g_item = 6
        g_weapon_tint_choice = g_weapon_tint_choice + direction
        IF g_weapon_tint_choice < 0 g_weapon_tint_choice = 7 ENDIF
        IF g_weapon_tint_choice > 7 g_weapon_tint_choice = 0 ENDIF
    ENDIF
    IF g_tab = 1 AND g_item = 1
        g_weapon_choice = g_weapon_choice + direction
        IF g_weapon_choice < 0 g_weapon_choice = MENU_WEAPON_COUNT() - 1 ENDIF
        IF g_weapon_choice >= MENU_WEAPON_COUNT() g_weapon_choice = 0 ENDIF
    ENDIF
    IF g_tab = 3 AND g_hydro_open
        IF g_item = 1
            g_hydro_level = g_hydro_level + direction
            IF g_hydro_level < -1 g_hydro_level = 8 ENDIF
            IF g_hydro_level > 8 g_hydro_level = -1 ENDIF
            APPLY_HYDRO_LEVEL()
        ENDIF
        IF g_item = 3
            g_hydro_preset = g_hydro_preset + direction
            IF g_hydro_preset < 0 g_hydro_preset = HYDRO_PRESET_COUNT - 1 ENDIF
            IF g_hydro_preset >= HYDRO_PRESET_COUNT g_hydro_preset = 0 ENDIF
            APPLY_HYDRO_PRESET()
        ENDIF
        IF g_item = 5
            g_hydro_front_height = g_hydro_front_height + direction
            IF g_hydro_front_height < 0 g_hydro_front_height = HYDRO_HEIGHT_LEVELS - 1 ENDIF
            IF g_hydro_front_height >= HYDRO_HEIGHT_LEVELS g_hydro_front_height = 0 ENDIF
            APPLY_HYDRO_HEIGHTS()
        ENDIF
        IF g_item = 6
            g_hydro_rear_height = g_hydro_rear_height + direction
            IF g_hydro_rear_height < 0 g_hydro_rear_height = HYDRO_HEIGHT_LEVELS - 1 ENDIF
            IF g_hydro_rear_height >= HYDRO_HEIGHT_LEVELS g_hydro_rear_height = 0 ENDIF
            APPLY_HYDRO_HEIGHTS()
        ENDIF
        IF g_item = 7
            g_hydro_left_height = g_hydro_left_height + direction
            IF g_hydro_left_height < 0 g_hydro_left_height = HYDRO_HEIGHT_LEVELS - 1 ENDIF
            IF g_hydro_left_height >= HYDRO_HEIGHT_LEVELS g_hydro_left_height = 0 ENDIF
            APPLY_HYDRO_HEIGHTS()
        ENDIF
        IF g_item = 8
            g_hydro_right_height = g_hydro_right_height + direction
            IF g_hydro_right_height < 0 g_hydro_right_height = HYDRO_HEIGHT_LEVELS - 1 ENDIF
            IF g_hydro_right_height >= HYDRO_HEIGHT_LEVELS g_hydro_right_height = 0 ENDIF
            APPLY_HYDRO_HEIGHTS()
        ENDIF
        IF g_item = 10
            g_hydro_wheel = g_hydro_wheel + direction
            IF g_hydro_wheel < 0 g_hydro_wheel = 5 ENDIF
            IF g_hydro_wheel > 5 g_hydro_wheel = 0 ENDIF
        ENDIF
        IF g_item = 11
            g_hydro_wheel_height = g_hydro_wheel_height + direction
            IF g_hydro_wheel_height < 0 g_hydro_wheel_height = HYDRO_HEIGHT_LEVELS - 1 ENDIF
            IF g_hydro_wheel_height >= HYDRO_HEIGHT_LEVELS g_hydro_wheel_height = 0 ENDIF
            APPLY_HYDRO_WHEEL()
        ENDIF
        IF g_item = 12
            g_hydro_wheel_state = g_hydro_wheel_state + direction
            IF g_hydro_wheel_state < 0 g_hydro_wheel_state = 2 ENDIF
            IF g_hydro_wheel_state > 2 g_hydro_wheel_state = 0 ENDIF
            APPLY_HYDRO_WHEEL()
        ENDIF
        IF g_item = 13
            g_hydro_raise_speed = g_hydro_raise_speed + direction
            IF g_hydro_raise_speed < 0 g_hydro_raise_speed = 19 ENDIF
            IF g_hydro_raise_speed > 19 g_hydro_raise_speed = 0 ENDIF
            APPLY_HYDRO_WHEEL()
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_interior_open
        IF g_item = 1
            g_interior_fill_index = g_interior_fill_index + direction
            IF g_interior_fill_index < 0 g_interior_fill_index = 9 ENDIF
            IF g_interior_fill_index > 9 g_interior_fill_index = 0 ENDIF
        ENDIF
        IF g_item = 2
            g_interior_slot = g_interior_slot + direction
            IF g_interior_slot < 0 g_interior_slot = INTERIOR_SLOT_COUNT - 1 ENDIF
            IF g_interior_slot >= INTERIOR_SLOT_COUNT g_interior_slot = 0 ENDIF
            SYNC_INTERIOR_SLOT()
        ENDIF
        IF g_item = 3
            g_interior_choice = g_interior_choice + direction
            IF g_interior_choice < -1 g_interior_choice = 9 ENDIF
            IF g_interior_choice > 9 g_interior_choice = -1 ENDIF
            APPLY_INTERIOR_SLOT()
        ENDIF
        IF g_item = 7
            g_lsc_trim_colour = g_lsc_trim_colour + direction
            IF g_lsc_trim_colour < 0 g_lsc_trim_colour = 26 ENDIF
            IF g_lsc_trim_colour > 26 g_lsc_trim_colour = 0 ENDIF
            APPLY_INTERIOR_COLOURS()
        ENDIF
        IF g_item = 8
            g_lsc_metal_colour = g_lsc_metal_colour + direction
            IF g_lsc_metal_colour < 0 g_lsc_metal_colour = 26 ENDIF
            IF g_lsc_metal_colour > 26 g_lsc_metal_colour = 0 ENDIF
            APPLY_INTERIOR_COLOURS()
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_wheeltyre_open
        IF g_item = 0
            g_lsc_wheel_type = g_lsc_wheel_type + direction
            IF g_lsc_wheel_type < 0 g_lsc_wheel_type = WHEEL_FAMILY_COUNT - 1 ENDIF
            IF g_lsc_wheel_type >= WHEEL_FAMILY_COUNT g_lsc_wheel_type = 0 ENDIF
            APPLY_WHEEL_FAMILY()
        ENDIF
        IF g_item = 1
            g_wheeltyre_variation = g_wheeltyre_variation + direction
            IF g_wheeltyre_variation < 0 g_wheeltyre_variation = 1 ENDIF
            IF g_wheeltyre_variation > 1 g_wheeltyre_variation = 0 ENDIF
            APPLY_WHEEL_VARIATION()
        ENDIF
        IF g_item = 2
            g_wheeltyre_rear_slot = NOT g_wheeltyre_rear_slot
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_lsc_extras_open
        IF g_item = 0
            g_lsc_livery = g_lsc_livery + direction
            IF g_lsc_livery < -1 g_lsc_livery = 8 ENDIF
            IF g_lsc_livery > 8 g_lsc_livery = -1 ENDIF
            APPLY_LIVERY()
        ENDIF
        IF g_item = 4
            g_lsc_extra = g_lsc_extra + direction
            IF g_lsc_extra < 0 g_lsc_extra = 11 ENDIF
            IF g_lsc_extra > 11 g_lsc_extra = 0 ENDIF
            REFRESH_EXTRA_PROBE()
        ENDIF
        EXIT
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 19
        g_lsc_kit_choice = LSC_ACTIVE_KIT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) + direction
        IF g_lsc_kit_choice < 0 g_lsc_kit_choice = LSC_KIT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) - 1 ENDIF
        IF g_lsc_kit_choice >= LSC_KIT_COUNT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())) g_lsc_kit_choice = 0 ENDIF
        LSC_USE_KIT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()))
        SYNC_LSC_VEHICLE_STATE()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 2
        g_lsc_slot_choice = g_lsc_slot_choice + direction
        IF g_lsc_slot_choice < 0 g_lsc_slot_choice = 42 ENDIF
        IF g_lsc_slot_choice > 42 g_lsc_slot_choice = 0 ENDIF
        SYNC_LSC_SLOT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 3
        ADJUST_LSC_MOD(direction)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 5
        g_lsc_primary_colour = g_lsc_primary_colour + direction
        IF g_lsc_primary_colour < 0 g_lsc_primary_colour = 26 ENDIF
        IF g_lsc_primary_colour > 26 g_lsc_primary_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 6
        g_lsc_secondary_colour = g_lsc_secondary_colour + direction
        IF g_lsc_secondary_colour < 0 g_lsc_secondary_colour = 26 ENDIF
        IF g_lsc_secondary_colour > 26 g_lsc_secondary_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 9
        g_lsc_wheel_type = g_lsc_wheel_type + direction
        IF g_lsc_wheel_type < 0 g_lsc_wheel_type = WHEEL_FAMILY_COUNT - 1 ENDIF
        IF g_lsc_wheel_type >= WHEEL_FAMILY_COUNT g_lsc_wheel_type = 0 ENDIF
        SET_VEHICLE_WHEEL_TYPE(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), INT_TO_ENUM(MOD_WHEEL_TYPE, g_lsc_wheel_type))
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 12
        g_lsc_xenon_colour = g_lsc_xenon_colour + direction
        IF g_lsc_xenon_colour < 0 g_lsc_xenon_colour = 12 ENDIF
        IF g_lsc_xenon_colour > 12 g_lsc_xenon_colour = 0 ENDIF
        SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_xenon_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 14
        g_lsc_neon_colour = g_lsc_neon_colour + direction
        IF g_lsc_neon_colour < 0 g_lsc_neon_colour = 12 ENDIF
        IF g_lsc_neon_colour > 12 g_lsc_neon_colour = 0 ENDIF
        SET_VEHICLE_NEON_INDEX_COLOUR(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_neon_colour)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 15
        g_lsc_window_tint = g_lsc_window_tint + direction
        IF g_lsc_window_tint < 0 g_lsc_window_tint = 6 ENDIF
        IF g_lsc_window_tint > 6 g_lsc_window_tint = 0 ENDIF
        SET_VEHICLE_WINDOW_TINT(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID()), g_lsc_window_tint)
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 7
        g_lsc_pearlescent_colour = g_lsc_pearlescent_colour + direction
        IF g_lsc_pearlescent_colour < 0 g_lsc_pearlescent_colour = 26 ENDIF
        IF g_lsc_pearlescent_colour > 26 g_lsc_pearlescent_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND g_lsc_open AND g_item = 8
        g_lsc_wheel_colour = g_lsc_wheel_colour + direction
        IF g_lsc_wheel_colour < 0 g_lsc_wheel_colour = 26 ENDIF
        IF g_lsc_wheel_colour > 26 g_lsc_wheel_colour = 0 ENDIF
        APPLY_LSC_PAINT()
    ENDIF
    IF g_tab = 3 AND NOT g_lsc_open AND g_item = 24
        g_vehicle_speed_unit = 1 - g_vehicle_speed_unit
    ENDIF
    IF g_tab = 3 AND NOT g_spawner_open AND NOT g_lsc_open AND NOT g_vehicle_control_open AND g_item = 8
        g_vehicle_acceleration_level = g_vehicle_acceleration_level + direction
        IF g_vehicle_acceleration_level < 0 g_vehicle_acceleration_level = 12 ENDIF
        IF g_vehicle_acceleration_level > 12 g_vehicle_acceleration_level = 0 ENDIF
    ENDIF
    IF g_tab = 3 AND NOT g_spawner_open AND NOT g_lsc_open AND NOT g_vehicle_control_open AND g_item = 9
        g_vehicle_grip_level = g_vehicle_grip_level + direction
        IF g_vehicle_grip_level < -4 g_vehicle_grip_level = 8 ENDIF
        IF g_vehicle_grip_level > 8 g_vehicle_grip_level = -4 ENDIF
    ENDIF
    IF g_tab = 7
        IF g_spooner_open
            IF g_item = 0
                g_spooner_catalog_index = g_spooner_catalog_index + direction
                IF g_spooner_catalog_index < 0 g_spooner_catalog_index = SPOONER_CATALOG_COUNT - 1 ENDIF
                IF g_spooner_catalog_index >= SPOONER_CATALOG_COUNT g_spooner_catalog_index = 0 ENDIF
            ELIF g_item = 3
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0
                    g_spooner_selected_index = g_spooner_selected_index + direction
                    IF g_spooner_selected_index < 0 g_spooner_selected_index = g_spooner_object_count - 1 ENDIF
                    IF g_spooner_selected_index >= g_spooner_object_count g_spooner_selected_index = 0 ENDIF
                    SYNC_SPOONER_UI_FROM_SELECTED()
                ENDIF
            ELIF g_item = 4
                g_spooner_forward_offset = g_spooner_forward_offset + (TO_FLOAT(direction) * 0.25)
                IF g_spooner_forward_offset < -50.0 g_spooner_forward_offset = -50.0 ENDIF
                IF g_spooner_forward_offset > 50.0 g_spooner_forward_offset = 50.0 ENDIF
                APPLY_SPOONER_OFFSET_TO_SELECTED()
            ELIF g_item = 5
                g_spooner_side_offset = g_spooner_side_offset + (TO_FLOAT(direction) * 0.25)
                IF g_spooner_side_offset < -50.0 g_spooner_side_offset = -50.0 ENDIF
                IF g_spooner_side_offset > 50.0 g_spooner_side_offset = 50.0 ENDIF
                APPLY_SPOONER_OFFSET_TO_SELECTED()
            ELIF g_item = 6
                g_spooner_height_offset = g_spooner_height_offset + (TO_FLOAT(direction) * 0.25)
                IF g_spooner_height_offset < -50.0 g_spooner_height_offset = -50.0 ENDIF
                IF g_spooner_height_offset > 50.0 g_spooner_height_offset = 50.0 ENDIF
                APPLY_SPOONER_OFFSET_TO_SELECTED()
            ELIF g_item = 7
                g_spooner_heading_offset = g_spooner_heading_offset + (TO_FLOAT(direction) * 5.0)
                IF g_spooner_heading_offset < 0.0 g_spooner_heading_offset = 355.0 ENDIF
                IF g_spooner_heading_offset >= 360.0 g_spooner_heading_offset = 0.0 ENDIF
                APPLY_SPOONER_OFFSET_TO_SELECTED()
            ELIF g_item = 12
                g_spooner_bone_choice = g_spooner_bone_choice + direction
                IF g_spooner_bone_choice < 0 g_spooner_bone_choice = SPOONER_BONE_COUNT - 1 ENDIF
                IF g_spooner_bone_choice >= SPOONER_BONE_COUNT g_spooner_bone_choice = 0 ENDIF
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                    APPLY_SPOONER_ATTACHMENT(TRUE)
                ENDIF
            ELIF g_item = 13
                g_spooner_attach_x = g_spooner_attach_x + (TO_FLOAT(direction) * 0.05)
                IF g_spooner_attach_x < -5.0 g_spooner_attach_x = -5.0 ENDIF
                IF g_spooner_attach_x > 5.0 g_spooner_attach_x = 5.0 ENDIF
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                    APPLY_SPOONER_ATTACHMENT(TRUE)
                ENDIF
            ELIF g_item = 14
                g_spooner_attach_y = g_spooner_attach_y + (TO_FLOAT(direction) * 0.05)
                IF g_spooner_attach_y < -5.0 g_spooner_attach_y = -5.0 ENDIF
                IF g_spooner_attach_y > 5.0 g_spooner_attach_y = 5.0 ENDIF
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                    APPLY_SPOONER_ATTACHMENT(TRUE)
                ENDIF
            ELIF g_item = 15
                g_spooner_attach_z = g_spooner_attach_z + (TO_FLOAT(direction) * 0.05)
                IF g_spooner_attach_z < -5.0 g_spooner_attach_z = -5.0 ENDIF
                IF g_spooner_attach_z > 5.0 g_spooner_attach_z = 5.0 ENDIF
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                    APPLY_SPOONER_ATTACHMENT(TRUE)
                ENDIF
            ELIF g_item = 16
                IF g_spooner_rot_axis = 0
                    g_spooner_attach_pitch = g_spooner_attach_pitch + (TO_FLOAT(direction) * 5.0)
                    IF g_spooner_attach_pitch < -180.0 g_spooner_attach_pitch = 175.0 ENDIF
                    IF g_spooner_attach_pitch > 180.0 g_spooner_attach_pitch = -175.0 ENDIF
                ELIF g_spooner_rot_axis = 1
                    g_spooner_attach_roll = g_spooner_attach_roll + (TO_FLOAT(direction) * 5.0)
                    IF g_spooner_attach_roll < -180.0 g_spooner_attach_roll = 175.0 ENDIF
                    IF g_spooner_attach_roll > 180.0 g_spooner_attach_roll = -175.0 ENDIF
                ELSE
                    g_spooner_attach_yaw = g_spooner_attach_yaw + (TO_FLOAT(direction) * 5.0)
                    IF g_spooner_attach_yaw < -180.0 g_spooner_attach_yaw = 175.0 ENDIF
                    IF g_spooner_attach_yaw > 180.0 g_spooner_attach_yaw = -175.0 ENDIF
                ENDIF
                COMPACT_SPOONER_POOL()
                IF g_spooner_object_count > 0 AND IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
                    APPLY_SPOONER_ATTACHMENT(TRUE)
                ENDIF
            ENDIF
            EXIT
        ENDIF
        IF g_nsc_loader_open
            IF g_item = 2
                g_nsc_stack_choice = g_nsc_stack_choice + direction
                IF g_nsc_stack_choice < 0 g_nsc_stack_choice = 2 ENDIF
                IF g_nsc_stack_choice > 2 g_nsc_stack_choice = 0 ENDIF
            ENDIF
            EXIT
        ENDIF
        IF g_persist_open
            IF g_item = 0
                g_persist_enabled = NOT g_persist_enabled
            ENDIF
            IF g_item = 5
                g_persist_save_disk = NOT g_persist_save_disk
            ENDIF
            EXIT
        ENDIF
        IF g_item = 2
            g_accent_choice = g_accent_choice + direction
            IF g_accent_choice < 0 g_accent_choice = 14 ENDIF
            IF g_accent_choice > 14 g_accent_choice = 0 ENDIF
            APPLY_ACCENT_CHOICE()
            IF g_item > ITEM_COUNT() - 1 g_item = ITEM_COUNT() - 1 ENDIF
        ENDIF
        IF g_item = 3 AND g_accent_choice = 14
            g_accent_rgb_speed_index = g_accent_rgb_speed_index + direction
            IF g_accent_rgb_speed_index < 0 g_accent_rgb_speed_index = 0 ENDIF
            IF g_accent_rgb_speed_index > 41 g_accent_rgb_speed_index = 41 ENDIF
        ENDIF
        IF g_accent_choice = 14
            IF g_item = 4
                g_respawn_location_choice = g_respawn_location_choice + direction
                IF g_respawn_location_choice < 0 g_respawn_location_choice = 22 ENDIF
                IF g_respawn_location_choice > 22 g_respawn_location_choice = 0 ENDIF
            ENDIF
        ELSE
            IF g_item = 3
                g_respawn_location_choice = g_respawn_location_choice + direction
                IF g_respawn_location_choice < 0 g_respawn_location_choice = 22 ENDIF
                IF g_respawn_location_choice > 22 g_respawn_location_choice = 0 ENDIF
            ENDIF
        ENDIF
        IF g_accent_choice = 14
            IF g_item = 6
                g_menu_x = g_menu_x + (TO_FLOAT(direction) * 0.005)
                IF g_menu_x < 0.150 g_menu_x = 0.150 ENDIF
                IF g_menu_x > 0.850 g_menu_x = 0.850 ENDIF
            ENDIF
            IF g_item = 7
                g_menu_y = g_menu_y + (TO_FLOAT(direction) * 0.005)
                IF g_menu_y < -0.080 g_menu_y = -0.080 ENDIF
                IF g_menu_y > 0.120 g_menu_y = 0.120 ENDIF
            ENDIF
            IF g_item = 8
                g_menu_combo = g_menu_combo + direction
                IF g_menu_combo < 0 g_menu_combo = 2 ENDIF
                IF g_menu_combo > 2 g_menu_combo = 0 ENDIF
            ENDIF
        ELSE
            IF g_item = 5
                g_menu_x = g_menu_x + (TO_FLOAT(direction) * 0.005)
                IF g_menu_x < 0.150 g_menu_x = 0.150 ENDIF
                IF g_menu_x > 0.850 g_menu_x = 0.850 ENDIF
            ENDIF
            IF g_item = 6
                g_menu_y = g_menu_y + (TO_FLOAT(direction) * 0.005)
                IF g_menu_y < -0.080 g_menu_y = -0.080 ENDIF
                IF g_menu_y > 0.120 g_menu_y = 0.120 ENDIF
            ENDIF
            IF g_item = 7
                g_menu_combo = g_menu_combo + direction
                IF g_menu_combo < 0 g_menu_combo = 2 ENDIF
                IF g_menu_combo > 2 g_menu_combo = 0 ENDIF
            ENDIF
        ENDIF
    ENDIF
ENDPROC
