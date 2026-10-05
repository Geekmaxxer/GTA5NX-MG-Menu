CONST_INT PERSIST_SCHEMA_VERSION 1
CONST_INT PERSIST_MAGIC_A 77
CONST_INT PERSIST_MAGIC_B 71
CONST_INT PERSIST_CHAR_COUNT 3
CONST_INT PERSIST_HEADER_BYTE_MAGIC_A 0
CONST_INT PERSIST_HEADER_BYTE_MAGIC_B 1
CONST_INT PERSIST_HEADER_BYTE_VERSION 2
CONST_INT PERSIST_HEADER_BYTE_CHECKSUM 3
CONST_INT PERSIST_BOOL_BITS_PER_STAT 64
CONST_INT PERSIST_INT_SLOTS_PER_STAT 8
CONST_INT PERSIST_BOOL_GOD 0
CONST_INT PERSIST_BOOL_NO_RAGDOLL 1
CONST_INT PERSIST_BOOL_FAST_RUN 2
CONST_INT PERSIST_BOOL_FAST_SWIM 3
CONST_INT PERSIST_BOOL_SUPER_JUMP 4
CONST_INT PERSIST_BOOL_UNLIMITED_OXYGEN 5
CONST_INT PERSIST_BOOL_UNLIMITED_ABILITY 6
CONST_INT PERSIST_BOOL_INFINITE_PARACHUTE 7
CONST_INT PERSIST_BOOL_NEVER_WANTED 8
CONST_INT PERSIST_BOOL_IGNORE_POLICE 9
CONST_INT PERSIST_BOOL_DISPATCH 10
CONST_INT PERSIST_BOOL_CIVILIAN_REPORTS 11
CONST_INT PERSIST_BOOL_NIGHT_VISION 12
CONST_INT PERSIST_BOOL_THERMAL_VISION 13
CONST_INT PERSIST_BOOL_RESERVED_14 14
CONST_INT PERSIST_BOOL_HUD_HIDDEN 15
CONST_INT PERSIST_BOOL_RADAR_HIDDEN 16
CONST_INT PERSIST_BOOL_FIRST_PERSON 17
CONST_INT PERSIST_BOOL_LOW_POPULATION 18
CONST_INT PERSIST_BOOL_SKIP_CUTSCENES 19
CONST_INT PERSIST_BOOL_VEHICLE_GOD 20
CONST_INT PERSIST_BOOL_VEHICLE_AUTO_REPAIR 21
CONST_INT PERSIST_BOOL_VEHICLE_ALWAYS_MAX 22
CONST_INT PERSIST_BOOL_VEHICLE_QUICK_ENTRY_EXIT 23
CONST_INT PERSIST_BOOL_VEHICLE_HORN_BOOST 24
CONST_INT PERSIST_BOOL_VEHICLE_TURBO 25
CONST_INT PERSIST_BOOL_VEHICLE_BULLETPROOF_TYRES 26
CONST_INT PERSIST_BOOL_VEHICLE_SPEEDOMETER 27
CONST_INT PERSIST_BOOL_VEHICLE_PREVIEW 28
CONST_INT PERSIST_BOOL_SEATBELT 29
CONST_INT PERSIST_BOOL_RESPAWN_AT_DEATH 30
CONST_INT PERSIST_BOOL_AUTO_SAVE 31
CONST_INT PERSIST_BOOL_INFINITE_AMMO 32
CONST_INT PERSIST_BOOL_INFINITE_CLIP 33
CONST_INT PERSIST_BOOL_AUTO_DISK_SAVE 34
CONST_INT PERSIST_BOOL_ENABLED 35
CONST_INT PERSIST_SCRATCH_BOOL_SLOT 191
CONST_INT PERSIST_SCRATCH_INT_SLOT 39
CONST_INT PERSIST_QUIET_MS 1500
CONST_INT PERSIST_MAX_DEFER_MS 10000
CONST_INT PERSIST_DISK_DEBOUNCE_MS 60000
CONST_INT PERSIST_INT_ACCENT 0
CONST_INT PERSIST_INT_ACCENT_RGB_SPEED 1
CONST_INT PERSIST_INT_RESPAWN_LOCATION 2
CONST_INT PERSIST_INT_MENU_X_STEPS 3
CONST_INT PERSIST_INT_MENU_Y_STEPS 4
CONST_INT PERSIST_INT_MENU_COMBO 5
CONST_INT PERSIST_INT_TIME_CHOICE 6
CONST_INT PERSIST_INT_WEATHER_CHOICE 7
CONST_INT PERSIST_INT_GRAVITY_CHOICE 8
CONST_INT PERSIST_INT_TIME_SCALE 9
CONST_INT PERSIST_INT_NPC_DENSITY 10
CONST_INT PERSIST_INT_SPEED_UNIT 11
CONST_INT PERSIST_INT_AUTO_SAVE_INTERVAL 12
CONST_INT PERSIST_INT_BODYGUARD_WEAPON 13
CONST_INT PERSIST_INT_BODYGUARD_FORMATION 14
CONST_INT PERSIST_INT_ATTACKER_WEAPON 15
CONST_INT PERSIST_INT_VEHICLE_ACCEL 16
CONST_INT PERSIST_INT_VEHICLE_GRIP 17
CONST_INT PERSIST_INT_LSC_PRIMARY 18
CONST_INT PERSIST_INT_LSC_SECONDARY 19
CONST_INT PERSIST_INT_LSC_PEARLESCENT 20
CONST_INT PERSIST_INT_LSC_WHEEL_COLOUR 21
CONST_INT PERSIST_INT_LSC_XENON 22
CONST_INT PERSIST_INT_LSC_NEON 23
CONST_INT PERSIST_INT_LSC_WHEEL_TYPE 24
CONST_INT PERSIST_INT_LSC_WINDOW_TINT 25
CONST_INT PERSIST_MAX_ACCENT 14
CONST_INT PERSIST_MAX_ACCENT_RGB_SPEED 41
CONST_INT PERSIST_MAX_RESPAWN_LOCATION 22
CONST_INT PERSIST_MAX_MENU_X_STEPS 140
CONST_INT PERSIST_MAX_MENU_Y_STEPS 40
CONST_INT PERSIST_MAX_MENU_COMBO 2
CONST_INT PERSIST_MAX_WEATHER 16
CONST_INT PERSIST_MAX_GRAVITY 3
CONST_INT PERSIST_MAX_TIME_SCALE 40
CONST_INT PERSIST_MAX_NPC_DENSITY 4
CONST_INT PERSIST_MAX_TIME_CHOICE 3
CONST_INT PERSIST_MAX_BODYGUARD_WEAPON 4
CONST_INT PERSIST_MAX_BODYGUARD_FORMATION 2
CONST_INT PERSIST_MAX_ATTACKER_WEAPON 3
CONST_INT PERSIST_MAX_VEHICLE_ACCEL 12
CONST_INT PERSIST_MAX_VEHICLE_GRIP 12
CONST_INT PERSIST_MAX_VEHICLE_COLOUR 26
CONST_INT PERSIST_MAX_WHEEL_TYPE 9
CONST_INT PERSIST_MAX_WINDOW_TINT 6
CONST_INT PERSIST_MENU_X_BASE_STEP 30
CONST_INT PERSIST_MENU_Y_BASE_STEP 16
CONST_INT PERSIST_SELF_TEST_INT_A 165
CONST_INT PERSIST_SELF_TEST_INT_B 90
FUNC STATSENUM PERSIST_BOOL_STAT(INT character, INT block)
    SWITCH character
        CASE 0
            SWITCH block
                CASE 0 RETURN SP0_PSTAT_BOOL0 BREAK
                CASE 1 RETURN SP0_PSTAT_BOOL1 BREAK
                CASE 2 RETURN SP0_PSTAT_BOOL2 BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH block
                CASE 0 RETURN SP1_PSTAT_BOOL0 BREAK
                CASE 1 RETURN SP1_PSTAT_BOOL1 BREAK
                CASE 2 RETURN SP1_PSTAT_BOOL2 BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH block
                CASE 0 RETURN SP2_PSTAT_BOOL0 BREAK
                CASE 1 RETURN SP2_PSTAT_BOOL1 BREAK
                CASE 2 RETURN SP2_PSTAT_BOOL2 BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN SP0_PSTAT_BOOL0
ENDFUNC

FUNC STATSENUM PERSIST_INT_STAT(INT character, INT block)
    SWITCH character
        CASE 0
            SWITCH block
                CASE 0 RETURN SP0_PSTAT_INT0 BREAK
                CASE 1 RETURN SP0_PSTAT_INT1 BREAK
                CASE 2 RETURN SP0_PSTAT_INT2 BREAK
                CASE 3 RETURN SP0_PSTAT_INT3 BREAK
                CASE 4 RETURN SP0_PSTAT_INT4 BREAK
                CASE 5 RETURN SP0_PSTAT_INT5 BREAK
                CASE 6 RETURN SP0_PSTAT_INT6 BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH block
                CASE 0 RETURN SP1_PSTAT_INT0 BREAK
                CASE 1 RETURN SP1_PSTAT_INT1 BREAK
                CASE 2 RETURN SP1_PSTAT_INT2 BREAK
                CASE 3 RETURN SP1_PSTAT_INT3 BREAK
                CASE 4 RETURN SP1_PSTAT_INT4 BREAK
                CASE 5 RETURN SP1_PSTAT_INT5 BREAK
                CASE 6 RETURN SP1_PSTAT_INT6 BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH block
                CASE 0 RETURN SP2_PSTAT_INT0 BREAK
                CASE 1 RETURN SP2_PSTAT_INT1 BREAK
                CASE 2 RETURN SP2_PSTAT_INT2 BREAK
                CASE 3 RETURN SP2_PSTAT_INT3 BREAK
                CASE 4 RETURN SP2_PSTAT_INT4 BREAK
                CASE 5 RETURN SP2_PSTAT_INT5 BREAK
                CASE 6 RETURN SP2_PSTAT_INT6 BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN SP0_PSTAT_INT1
ENDFUNC

FUNC STATSENUM PERSIST_HEADER_STAT(INT character)
    RETURN PERSIST_INT_STAT(character, 1)
ENDFUNC

FUNC STATSENUM PERSIST_INT_SLOT_STAT(INT character, INT slot)
    INT block = (slot / PERSIST_INT_SLOTS_PER_STAT) + 2
    RETURN PERSIST_INT_STAT(character, block)
ENDFUNC

FUNC INT PERSIST_INT_SLOT_BYTE(INT slot)
    INT block = slot / PERSIST_INT_SLOTS_PER_STAT
    RETURN slot - (block * PERSIST_INT_SLOTS_PER_STAT)
ENDFUNC

FUNC STATSENUM PERSIST_BOOL_SLOT_STAT(INT character, INT slot)
    RETURN PERSIST_BOOL_STAT(character, slot / PERSIST_BOOL_BITS_PER_STAT)
ENDFUNC

FUNC INT PERSIST_BOOL_SLOT_BIT(INT slot)
    INT block = slot / PERSIST_BOOL_BITS_PER_STAT
    RETURN slot - (block * PERSIST_BOOL_BITS_PER_STAT)
ENDFUNC

FUNC BOOL PERSIST_READ_BOOL_SLOT(INT character, INT slot)
    INT raw = 0
    IF NOT STAT_GET_MASKED_INT(PERSIST_BOOL_SLOT_STAT(character, slot), raw, PERSIST_BOOL_SLOT_BIT(slot), 1)
        RETURN FALSE
    ENDIF
    IF raw != 0 RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

FUNC BOOL PERSIST_WRITE_BOOL_SLOT(INT character, INT slot, BOOL value)
    INT bitValue = 0
    IF value bitValue = 1 ENDIF
    RETURN STAT_SET_MASKED_INT(PERSIST_BOOL_SLOT_STAT(character, slot), bitValue, PERSIST_BOOL_SLOT_BIT(slot), 1, FALSE)
ENDFUNC

FUNC INT PERSIST_READ_INT_SLOT(INT character, INT slot)
    INT raw = 0
    IF NOT STAT_GET_MASKED_INT(PERSIST_INT_SLOT_STAT(character, slot), raw, PERSIST_INT_SLOT_BYTE(slot) * 8, 8)
        RETURN -1
    ENDIF
    IF raw < 0 raw = 0 ENDIF
    IF raw > 255 raw = 255 ENDIF
    RETURN raw
ENDFUNC

FUNC BOOL PERSIST_WRITE_INT_SLOT(INT character, INT slot, INT value)
    IF value < 0 value = 0 ENDIF
    IF value > 255 value = 255 ENDIF
    RETURN STAT_SET_MASKED_INT(PERSIST_INT_SLOT_STAT(character, slot), value, PERSIST_INT_SLOT_BYTE(slot) * 8, 8, FALSE)
ENDFUNC

FUNC INT PERSIST_READ_HEADER_BYTE(INT character, INT byteIndex)
    INT raw = 0
    IF NOT STAT_GET_MASKED_INT(PERSIST_HEADER_STAT(character), raw, byteIndex * 8, 8)
        RETURN -1
    ENDIF
    IF raw < 0 raw = 0 ENDIF
    IF raw > 255 raw = 255 ENDIF
    RETURN raw
ENDFUNC

FUNC BOOL PERSIST_WRITE_HEADER_BYTE(INT character, INT byteIndex, INT value)
    IF value < 0 value = 0 ENDIF
    IF value > 255 value = 255 ENDIF
    RETURN STAT_SET_MASKED_INT(PERSIST_HEADER_STAT(character), value, byteIndex * 8, 8, FALSE)
ENDFUNC

FUNC BOOL PERSIST_CONTAINER_AVAILABLE(INT character, INT block)
    INT probe = 0
    RETURN STAT_GET_INT(PERSIST_BOOL_STAT(character, block), probe)
ENDFUNC

FUNC BOOL PERSIST_INT_CONTAINER_AVAILABLE(INT character, INT block)
    INT probe = 0
    RETURN STAT_GET_INT(PERSIST_INT_STAT(character, block), probe)
ENDFUNC

FUNC INT PERSIST_COMPUTE_CHECKSUM(INT character)
    INT sum = 0
    INT raw = 0
    INT block = 0
    WHILE block < PERSIST_CHAR_COUNT
        raw = 0
        IF STAT_GET_INT(PERSIST_BOOL_STAT(character, block), raw)
            sum = sum + raw
        ENDIF
        block = block + 1
    ENDWHILE
    block = 2
    WHILE block <= 6
        raw = 0
        IF STAT_GET_INT(PERSIST_INT_STAT(character, block), raw)
            sum = sum + raw
        ENDIF
        block = block + 1
    ENDWHILE
    WHILE sum > 255
        sum = sum - 256
    ENDWHILE
    WHILE sum < 0
        sum = sum + 256
    ENDWHILE
    RETURN sum
ENDFUNC

PROC PERSIST_WRITE_HEADER(INT character)
    PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_A, PERSIST_MAGIC_A)
    PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_B, PERSIST_MAGIC_B)
    PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_VERSION, PERSIST_SCHEMA_VERSION)
    PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_CHECKSUM, PERSIST_COMPUTE_CHECKSUM(character))
ENDPROC

FUNC BOOL PERSIST_HEADER_VALID(INT character)
    IF PERSIST_READ_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_A) != PERSIST_MAGIC_A RETURN FALSE ENDIF
    IF PERSIST_READ_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_B) != PERSIST_MAGIC_B RETURN FALSE ENDIF
    IF PERSIST_READ_HEADER_BYTE(character, PERSIST_HEADER_BYTE_VERSION) != PERSIST_SCHEMA_VERSION RETURN FALSE ENDIF
    RETURN TRUE
ENDFUNC

FUNC INT PERSIST_FIND_VALID_CHARACTER()
    INT character = 0
    IF PERSIST_HEADER_VALID(g_persist_active_character) RETURN g_persist_active_character ENDIF
    WHILE character < PERSIST_CHAR_COUNT
        IF PERSIST_HEADER_VALID(character) RETURN character ENDIF
        character = character + 1
    ENDWHILE
    RETURN -1
ENDFUNC

PROC PERSIST_RESOLVE_ACTIVE_CHARACTER()
    g_persist_active_character = SLOT_FOR_MODEL(GET_ENTITY_MODEL(PLAYER_PED_ID()))
ENDPROC

FUNC BOOL PERSIST_GLOBAL_BOOL(INT slot)
    SWITCH slot
        CASE PERSIST_BOOL_GOD RETURN g_god BREAK
        CASE PERSIST_BOOL_NO_RAGDOLL RETURN g_no_ragdoll BREAK
        CASE PERSIST_BOOL_FAST_RUN RETURN g_fast_run BREAK
        CASE PERSIST_BOOL_FAST_SWIM RETURN g_fast_swim BREAK
        CASE PERSIST_BOOL_SUPER_JUMP RETURN g_super_jump BREAK
        CASE PERSIST_BOOL_UNLIMITED_OXYGEN RETURN g_unlimited_oxygen BREAK
        CASE PERSIST_BOOL_UNLIMITED_ABILITY RETURN g_unlimited_ability BREAK
        CASE PERSIST_BOOL_INFINITE_PARACHUTE RETURN g_infinite_parachute BREAK
        CASE PERSIST_BOOL_NEVER_WANTED RETURN g_never_wanted BREAK
        CASE PERSIST_BOOL_IGNORE_POLICE RETURN g_ignore_police BREAK
        CASE PERSIST_BOOL_DISPATCH RETURN g_dispatch BREAK
        CASE PERSIST_BOOL_CIVILIAN_REPORTS RETURN g_civilian_reports BREAK
        CASE PERSIST_BOOL_NIGHT_VISION RETURN g_night_vision BREAK
        CASE PERSIST_BOOL_THERMAL_VISION RETURN g_thermal_vision BREAK
        CASE PERSIST_BOOL_HUD_HIDDEN RETURN g_hud_hidden BREAK
        CASE PERSIST_BOOL_RADAR_HIDDEN RETURN g_radar_hidden BREAK
        CASE PERSIST_BOOL_FIRST_PERSON RETURN g_first_person BREAK
        CASE PERSIST_BOOL_LOW_POPULATION RETURN g_low_population BREAK
        CASE PERSIST_BOOL_SKIP_CUTSCENES RETURN g_skip_cutscenes BREAK
        CASE PERSIST_BOOL_VEHICLE_GOD RETURN g_vehicle_god BREAK
        CASE PERSIST_BOOL_VEHICLE_AUTO_REPAIR RETURN g_vehicle_auto_repair BREAK
        CASE PERSIST_BOOL_VEHICLE_ALWAYS_MAX RETURN g_vehicle_always_max BREAK
        CASE PERSIST_BOOL_VEHICLE_QUICK_ENTRY_EXIT RETURN g_vehicle_quick_entry_exit BREAK
        CASE PERSIST_BOOL_VEHICLE_HORN_BOOST RETURN g_vehicle_horn_boost BREAK
        CASE PERSIST_BOOL_VEHICLE_TURBO RETURN g_vehicle_turbo BREAK
        CASE PERSIST_BOOL_VEHICLE_BULLETPROOF_TYRES RETURN g_vehicle_bulletproof_tyres BREAK
        CASE PERSIST_BOOL_VEHICLE_SPEEDOMETER RETURN g_vehicle_speedometer BREAK
        CASE PERSIST_BOOL_VEHICLE_PREVIEW RETURN g_vehicle_preview_enabled BREAK
        CASE PERSIST_BOOL_SEATBELT RETURN g_seatbelt BREAK
        CASE PERSIST_BOOL_RESPAWN_AT_DEATH RETURN g_respawn_at_death BREAK
        CASE PERSIST_BOOL_AUTO_SAVE RETURN g_auto_save BREAK
        CASE PERSIST_BOOL_INFINITE_AMMO RETURN g_infinite_ammo BREAK
        CASE PERSIST_BOOL_INFINITE_CLIP RETURN g_infinite_clip BREAK
        CASE PERSIST_BOOL_AUTO_DISK_SAVE RETURN g_persist_save_disk BREAK
        CASE PERSIST_BOOL_ENABLED RETURN g_persist_enabled BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

PROC PERSIST_SET_GLOBAL_BOOL(INT slot, BOOL value)
    SWITCH slot
        CASE PERSIST_BOOL_GOD g_god = value BREAK
        CASE PERSIST_BOOL_NO_RAGDOLL g_no_ragdoll = value BREAK
        CASE PERSIST_BOOL_FAST_RUN g_fast_run = value BREAK
        CASE PERSIST_BOOL_FAST_SWIM g_fast_swim = value BREAK
        CASE PERSIST_BOOL_SUPER_JUMP g_super_jump = value BREAK
        CASE PERSIST_BOOL_UNLIMITED_OXYGEN g_unlimited_oxygen = value BREAK
        CASE PERSIST_BOOL_UNLIMITED_ABILITY g_unlimited_ability = value BREAK
        CASE PERSIST_BOOL_INFINITE_PARACHUTE g_infinite_parachute = value BREAK
        CASE PERSIST_BOOL_NEVER_WANTED g_never_wanted = value BREAK
        CASE PERSIST_BOOL_IGNORE_POLICE g_ignore_police = value BREAK
        CASE PERSIST_BOOL_DISPATCH g_dispatch = value BREAK
        CASE PERSIST_BOOL_CIVILIAN_REPORTS g_civilian_reports = value BREAK
        CASE PERSIST_BOOL_NIGHT_VISION g_night_vision = value BREAK
        CASE PERSIST_BOOL_THERMAL_VISION g_thermal_vision = value BREAK
        CASE PERSIST_BOOL_HUD_HIDDEN g_hud_hidden = value BREAK
        CASE PERSIST_BOOL_RADAR_HIDDEN g_radar_hidden = value BREAK
        CASE PERSIST_BOOL_FIRST_PERSON g_first_person = value BREAK
        CASE PERSIST_BOOL_LOW_POPULATION g_low_population = value BREAK
        CASE PERSIST_BOOL_SKIP_CUTSCENES g_skip_cutscenes = value BREAK
        CASE PERSIST_BOOL_VEHICLE_GOD g_vehicle_god = value BREAK
        CASE PERSIST_BOOL_VEHICLE_AUTO_REPAIR g_vehicle_auto_repair = value BREAK
        CASE PERSIST_BOOL_VEHICLE_ALWAYS_MAX g_vehicle_always_max = value BREAK
        CASE PERSIST_BOOL_VEHICLE_QUICK_ENTRY_EXIT g_vehicle_quick_entry_exit = value BREAK
        CASE PERSIST_BOOL_VEHICLE_HORN_BOOST g_vehicle_horn_boost = value BREAK
        CASE PERSIST_BOOL_VEHICLE_TURBO g_vehicle_turbo = value BREAK
        CASE PERSIST_BOOL_VEHICLE_BULLETPROOF_TYRES g_vehicle_bulletproof_tyres = value BREAK
        CASE PERSIST_BOOL_VEHICLE_SPEEDOMETER g_vehicle_speedometer = value BREAK
        CASE PERSIST_BOOL_VEHICLE_PREVIEW g_vehicle_preview_enabled = value BREAK
        CASE PERSIST_BOOL_SEATBELT g_seatbelt = value BREAK
        CASE PERSIST_BOOL_RESPAWN_AT_DEATH g_respawn_at_death = value BREAK
        CASE PERSIST_BOOL_AUTO_SAVE g_auto_save = value BREAK
        CASE PERSIST_BOOL_INFINITE_AMMO g_infinite_ammo = value BREAK
        CASE PERSIST_BOOL_INFINITE_CLIP g_infinite_clip = value BREAK
        CASE PERSIST_BOOL_AUTO_DISK_SAVE g_persist_save_disk = value BREAK
        CASE PERSIST_BOOL_ENABLED g_persist_enabled = value BREAK
    ENDSWITCH
ENDPROC

FUNC INT PERSIST_GLOBAL_INT(INT slot)
    SWITCH slot
        CASE PERSIST_INT_ACCENT RETURN g_accent_choice BREAK
        CASE PERSIST_INT_ACCENT_RGB_SPEED RETURN g_accent_rgb_speed_index BREAK
        CASE PERSIST_INT_RESPAWN_LOCATION RETURN g_respawn_location_choice BREAK
        CASE PERSIST_INT_MENU_X_STEPS
            RETURN ROUND((g_menu_x - 0.150) / 0.005)
        BREAK
        CASE PERSIST_INT_MENU_Y_STEPS
            RETURN ROUND((g_menu_y + 0.080) / 0.005)
        BREAK
        CASE PERSIST_INT_MENU_COMBO RETURN g_menu_combo BREAK
        CASE PERSIST_INT_TIME_CHOICE RETURN g_time_choice BREAK
        CASE PERSIST_INT_WEATHER_CHOICE RETURN g_weather_choice BREAK
        CASE PERSIST_INT_GRAVITY_CHOICE RETURN g_gravity_choice BREAK
        CASE PERSIST_INT_TIME_SCALE RETURN g_time_scale_level BREAK
        CASE PERSIST_INT_NPC_DENSITY RETURN g_npc_density_choice BREAK
        CASE PERSIST_INT_SPEED_UNIT RETURN g_vehicle_speed_unit BREAK
        CASE PERSIST_INT_AUTO_SAVE_INTERVAL RETURN g_auto_save_interval BREAK
        CASE PERSIST_INT_BODYGUARD_WEAPON RETURN g_bodyguard_weapon_choice BREAK
        CASE PERSIST_INT_BODYGUARD_FORMATION RETURN g_bodyguard_formation_choice BREAK
        CASE PERSIST_INT_ATTACKER_WEAPON RETURN g_attacker_weapon_choice BREAK
        CASE PERSIST_INT_VEHICLE_ACCEL RETURN g_vehicle_acceleration_level BREAK
        CASE PERSIST_INT_VEHICLE_GRIP
            RETURN g_vehicle_grip_level + 4
        BREAK
        CASE PERSIST_INT_LSC_PRIMARY RETURN g_lsc_primary_colour BREAK
        CASE PERSIST_INT_LSC_SECONDARY RETURN g_lsc_secondary_colour BREAK
        CASE PERSIST_INT_LSC_PEARLESCENT RETURN g_lsc_pearlescent_colour BREAK
        CASE PERSIST_INT_LSC_WHEEL_COLOUR RETURN g_lsc_wheel_colour BREAK
        CASE PERSIST_INT_LSC_XENON RETURN g_lsc_xenon_colour BREAK
        CASE PERSIST_INT_LSC_NEON RETURN g_lsc_neon_colour BREAK
        CASE PERSIST_INT_LSC_WHEEL_TYPE RETURN g_lsc_wheel_type BREAK
        CASE PERSIST_INT_LSC_WINDOW_TINT RETURN g_lsc_window_tint BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

PROC PERSIST_SET_GLOBAL_INT(INT slot, INT value)
    IF value < 0 value = 0 ENDIF
    SWITCH slot
        CASE PERSIST_INT_ACCENT
            IF value > PERSIST_MAX_ACCENT value = PERSIST_MAX_ACCENT ENDIF
            g_accent_choice = value
        BREAK
        CASE PERSIST_INT_ACCENT_RGB_SPEED
            IF value > PERSIST_MAX_ACCENT_RGB_SPEED value = PERSIST_MAX_ACCENT_RGB_SPEED ENDIF
            g_accent_rgb_speed_index = value
        BREAK
        CASE PERSIST_INT_RESPAWN_LOCATION
            IF value > PERSIST_MAX_RESPAWN_LOCATION value = PERSIST_MAX_RESPAWN_LOCATION ENDIF
            g_respawn_location_choice = value
        BREAK
        CASE PERSIST_INT_MENU_X_STEPS
            IF value > PERSIST_MAX_MENU_X_STEPS value = PERSIST_MAX_MENU_X_STEPS ENDIF
            g_menu_x = 0.150 + (TO_FLOAT(value) * 0.005)
        BREAK
        CASE PERSIST_INT_MENU_Y_STEPS
            IF value > PERSIST_MAX_MENU_Y_STEPS value = PERSIST_MAX_MENU_Y_STEPS ENDIF
            g_menu_y = -0.080 + (TO_FLOAT(value) * 0.005)
        BREAK
        CASE PERSIST_INT_MENU_COMBO
            IF value > PERSIST_MAX_MENU_COMBO value = PERSIST_MAX_MENU_COMBO ENDIF
            g_menu_combo = value
        BREAK
        CASE PERSIST_INT_TIME_CHOICE
            IF value > PERSIST_MAX_TIME_CHOICE value = PERSIST_MAX_TIME_CHOICE ENDIF
            g_time_choice = value
        BREAK
        CASE PERSIST_INT_WEATHER_CHOICE
            IF value > PERSIST_MAX_WEATHER value = PERSIST_MAX_WEATHER ENDIF
            g_weather_choice = value
        BREAK
        CASE PERSIST_INT_GRAVITY_CHOICE
            IF value > PERSIST_MAX_GRAVITY value = PERSIST_MAX_GRAVITY ENDIF
            g_gravity_choice = value
        BREAK
        CASE PERSIST_INT_TIME_SCALE
            IF value > PERSIST_MAX_TIME_SCALE value = PERSIST_MAX_TIME_SCALE ENDIF
            g_time_scale_level = value
        BREAK
        CASE PERSIST_INT_NPC_DENSITY
            IF value > PERSIST_MAX_NPC_DENSITY value = PERSIST_MAX_NPC_DENSITY ENDIF
            g_npc_density_choice = value
        BREAK
        CASE PERSIST_INT_SPEED_UNIT
            IF value > 1 value = 1 ENDIF
            g_vehicle_speed_unit = value
        BREAK
        CASE PERSIST_INT_AUTO_SAVE_INTERVAL
            IF value > 255 value = 255 ENDIF
            g_auto_save_interval = value
        BREAK
        CASE PERSIST_INT_BODYGUARD_WEAPON
            IF value > PERSIST_MAX_BODYGUARD_WEAPON value = PERSIST_MAX_BODYGUARD_WEAPON ENDIF
            g_bodyguard_weapon_choice = value
        BREAK
        CASE PERSIST_INT_BODYGUARD_FORMATION
            IF value > PERSIST_MAX_BODYGUARD_FORMATION value = PERSIST_MAX_BODYGUARD_FORMATION ENDIF
            g_bodyguard_formation_choice = value
        BREAK
        CASE PERSIST_INT_ATTACKER_WEAPON
            IF value > PERSIST_MAX_ATTACKER_WEAPON value = PERSIST_MAX_ATTACKER_WEAPON ENDIF
            g_attacker_weapon_choice = value
        BREAK
        CASE PERSIST_INT_VEHICLE_ACCEL
            IF value > PERSIST_MAX_VEHICLE_ACCEL value = PERSIST_MAX_VEHICLE_ACCEL ENDIF
            g_vehicle_acceleration_level = value
        BREAK
        CASE PERSIST_INT_VEHICLE_GRIP
            IF value > PERSIST_MAX_VEHICLE_GRIP value = PERSIST_MAX_VEHICLE_GRIP ENDIF
            g_vehicle_grip_level = value - 4
        BREAK
        CASE PERSIST_INT_LSC_PRIMARY
            IF value > PERSIST_MAX_VEHICLE_COLOUR value = PERSIST_MAX_VEHICLE_COLOUR ENDIF
            g_lsc_primary_colour = value
        BREAK
        CASE PERSIST_INT_LSC_SECONDARY
            IF value > PERSIST_MAX_VEHICLE_COLOUR value = PERSIST_MAX_VEHICLE_COLOUR ENDIF
            g_lsc_secondary_colour = value
        BREAK
        CASE PERSIST_INT_LSC_PEARLESCENT
            IF value > PERSIST_MAX_VEHICLE_COLOUR value = PERSIST_MAX_VEHICLE_COLOUR ENDIF
            g_lsc_pearlescent_colour = value
        BREAK
        CASE PERSIST_INT_LSC_WHEEL_COLOUR
            IF value > PERSIST_MAX_VEHICLE_COLOUR value = PERSIST_MAX_VEHICLE_COLOUR ENDIF
            g_lsc_wheel_colour = value
        BREAK
        CASE PERSIST_INT_LSC_XENON
            IF value > 12 value = 12 ENDIF
            g_lsc_xenon_colour = value
        BREAK
        CASE PERSIST_INT_LSC_NEON
            IF value > PERSIST_MAX_VEHICLE_COLOUR value = PERSIST_MAX_VEHICLE_COLOUR ENDIF
            g_lsc_neon_colour = value
        BREAK
        CASE PERSIST_INT_LSC_WHEEL_TYPE
            IF value > PERSIST_MAX_WHEEL_TYPE value = PERSIST_MAX_WHEEL_TYPE ENDIF
            g_lsc_wheel_type = value
        BREAK
        CASE PERSIST_INT_LSC_WINDOW_TINT
            IF value > PERSIST_MAX_WINDOW_TINT value = PERSIST_MAX_WINDOW_TINT ENDIF
            g_lsc_window_tint = value
        BREAK
    ENDSWITCH
ENDPROC

PROC PERSIST_REFRESH_SHADOW()
    INT slot = 0
    WHILE slot < PERSIST_BOOL_SLOTS
        IF PERSIST_GLOBAL_BOOL(slot)
            g_persist_shadow_bool[slot] = 1
        ELSE
            g_persist_shadow_bool[slot] = 0
        ENDIF
        slot = slot + 1
    ENDWHILE
    slot = 0
    WHILE slot < PERSIST_INT_SLOTS
        g_persist_shadow_int[slot] = PERSIST_GLOBAL_INT(slot)
        slot = slot + 1
    ENDWHILE
    g_persist_shadow_valid = TRUE
ENDPROC

FUNC BOOL PERSIST_STORAGE_MATCHES_GLOBALS()
    INT character = 0
    INT slot = 0
    INT value = 0
    INT boolInt = 0
    INT storedInt = 0
    BOOL storedBool = FALSE
    WHILE character < PERSIST_CHAR_COUNT
        slot = 0
        WHILE slot < PERSIST_BOOL_SLOTS
            boolInt = 0
            IF PERSIST_GLOBAL_BOOL(slot) boolInt = 1 ENDIF
            storedBool = PERSIST_READ_BOOL_SLOT(character, slot)
            storedInt = 0
            IF storedBool storedInt = 1 ENDIF
            IF storedInt != boolInt RETURN FALSE ENDIF
            slot = slot + 1
        ENDWHILE
        slot = 0
        WHILE slot < PERSIST_INT_SLOTS
            value = PERSIST_GLOBAL_INT(slot)
            IF PERSIST_READ_INT_SLOT(character, slot) != value RETURN FALSE ENDIF
            slot = slot + 1
        ENDWHILE
        character = character + 1
    ENDWHILE
    RETURN TRUE
ENDFUNC

PROC PERSIST_SAVE_ALL()
    INT character = 0
    INT slot = 0
    INT probeStart = GET_GAME_TIMER()
    INT probeElapsed = 0
    g_prof_persist_count = g_prof_persist_count + 1
    g_persist_written = 0
    g_persist_failed = 0
    WHILE character < PERSIST_CHAR_COUNT
        slot = 0
        WHILE slot < PERSIST_BOOL_SLOTS
            IF PERSIST_WRITE_BOOL_SLOT(character, slot, PERSIST_GLOBAL_BOOL(slot))
                g_persist_written = g_persist_written + 1
            ELSE
                g_persist_failed = g_persist_failed + 1
            ENDIF
            slot = slot + 1
        ENDWHILE
        slot = 0
        WHILE slot < PERSIST_INT_SLOTS
            IF PERSIST_WRITE_INT_SLOT(character, slot, PERSIST_GLOBAL_INT(slot))
                g_persist_written = g_persist_written + 1
            ELSE
                g_persist_failed = g_persist_failed + 1
            ENDIF
            slot = slot + 1
        ENDWHILE
        PERSIST_WRITE_HEADER(character)
        character = character + 1
    ENDWHILE
    PERSIST_REFRESH_SHADOW()
    probeElapsed = GET_GAME_TIMER() - probeStart
    IF probeElapsed > g_prof_worst_burst
        g_prof_worst_burst = probeElapsed
    ENDIF
ENDPROC

PROC PERSIST_SAVE_DELTA()
    INT character = 0
    INT slot = 0
    INT value = 0
    INT boolInt = 0
    BOOL boolValue = FALSE
    BOOL needsWrite = FALSE
    BOOL changed = FALSE
    INT probeStart = GET_GAME_TIMER()
    INT probeElapsed = 0
    g_prof_persist_count = g_prof_persist_count + 1
    g_persist_written = 0
    g_persist_failed = 0
    WHILE character < PERSIST_CHAR_COUNT
        slot = 0
        WHILE slot < PERSIST_BOOL_SLOTS
            boolValue = PERSIST_GLOBAL_BOOL(slot)
            boolInt = 0
            IF boolValue boolInt = 1 ENDIF
            needsWrite = FALSE
            IF NOT g_persist_shadow_valid
                needsWrite = TRUE
            ELIF g_persist_shadow_bool[slot] != boolInt
                needsWrite = TRUE
            ENDIF
            IF needsWrite
                IF PERSIST_WRITE_BOOL_SLOT(character, slot, boolValue)
                    g_persist_written = g_persist_written + 1
                ELSE
                    g_persist_failed = g_persist_failed + 1
                ENDIF
                changed = TRUE
            ENDIF
            slot = slot + 1
        ENDWHILE
        slot = 0
        WHILE slot < PERSIST_INT_SLOTS
            value = PERSIST_GLOBAL_INT(slot)
            needsWrite = FALSE
            IF NOT g_persist_shadow_valid
                needsWrite = TRUE
            ELIF g_persist_shadow_int[slot] != value
                needsWrite = TRUE
            ENDIF
            IF needsWrite
                IF PERSIST_WRITE_INT_SLOT(character, slot, value)
                    g_persist_written = g_persist_written + 1
                ELSE
                    g_persist_failed = g_persist_failed + 1
                ENDIF
                changed = TRUE
            ENDIF
            slot = slot + 1
        ENDWHILE
        IF changed PERSIST_WRITE_HEADER(character) ENDIF
        character = character + 1
    ENDWHILE
    PERSIST_REFRESH_SHADOW()
    probeElapsed = GET_GAME_TIMER() - probeStart
    IF probeElapsed > g_prof_worst_burst
        g_prof_worst_burst = probeElapsed
    ENDIF
ENDPROC

PROC PERSIST_APPLY_LOADED_SETTINGS()
    APPLY_ACCENT_CHOICE()
    SET_NIGHTVISION(g_night_vision)
    SET_SEETHROUGH(g_thermal_vision)
    SET_POLICE_IGNORE_PLAYER(PLAYER_ID(), g_ignore_police)
    SET_DISPATCH_COPS_FOR_PLAYER(PLAYER_ID(), g_civilian_reports)
    APPLY_DISPATCH_SERVICES_STATE()
    APPLY_NPC_DENSITY()
    APPLY_GRAVITY_CHOICE()
    APPLY_TIME_SCALE()
    SET_PED_CAN_RAGDOLL(PLAYER_PED_ID(), NOT g_no_ragdoll)
ENDPROC

FUNC BOOL PERSIST_LOAD_ALL()
    INT character = PERSIST_FIND_VALID_CHARACTER()
    INT slot = 0
    INT raw = 0
    IF character < 0
        RETURN FALSE
    ENDIF
    g_persist_enabled = PERSIST_READ_BOOL_SLOT(character, PERSIST_BOOL_ENABLED)
    IF NOT g_persist_enabled
        g_persist_boot_status = 2
        RETURN TRUE
    ENDIF
    slot = 0
    WHILE slot < PERSIST_BOOL_SLOTS
        PERSIST_SET_GLOBAL_BOOL(slot, PERSIST_READ_BOOL_SLOT(character, slot))
        slot = slot + 1
    ENDWHILE
    slot = 0
    WHILE slot < PERSIST_INT_SLOTS
        raw = PERSIST_READ_INT_SLOT(character, slot)
        IF raw >= 0
            PERSIST_SET_GLOBAL_INT(slot, raw)
        ENDIF
        slot = slot + 1
    ENDWHILE
    raw = PERSIST_READ_HEADER_BYTE(character, PERSIST_HEADER_BYTE_CHECKSUM)
    IF raw = PERSIST_COMPUTE_CHECKSUM(character)
        g_persist_checksum_ok = 1
    ELSE
        g_persist_checksum_ok = 0
    ENDIF
    PERSIST_APPLY_LOADED_SETTINGS()
    IF PERSIST_STORAGE_MATCHES_GLOBALS()
        PERSIST_REFRESH_SHADOW()
    ENDIF
    g_persist_boot_status = 0
    RETURN TRUE
ENDFUNC

PROC PERSIST_CLEAR_ALL()
    INT character = 0
    INT slot = 0
    WHILE character < PERSIST_CHAR_COUNT
        slot = 0
        WHILE slot < PERSIST_BOOL_SLOTS
            PERSIST_WRITE_BOOL_SLOT(character, slot, FALSE)
            slot = slot + 1
        ENDWHILE
        slot = 0
        WHILE slot < PERSIST_INT_SLOTS
            PERSIST_WRITE_INT_SLOT(character, slot, 0)
            slot = slot + 1
        ENDWHILE
        PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_A, 0)
        PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_MAGIC_B, 0)
        PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_VERSION, 0)
        PERSIST_WRITE_HEADER_BYTE(character, PERSIST_HEADER_BYTE_CHECKSUM, 0)
        character = character + 1
    ENDWHILE
    g_persist_dirty = FALSE
    g_persist_shadow_valid = FALSE
    g_persist_written = 0
    g_persist_failed = 0
    g_persist_checksum_ok = -1
ENDPROC

PROC PERSIST_SELF_TEST()
    INT character = 0
    INT block = 0
    BOOL bitValue = FALSE
    INT byteValue = 0
    g_persist_selftest_pass = 0
    g_persist_selftest_fail = 0
    g_persist_containers_missing = 0
    character = 0
    WHILE character < PERSIST_CHAR_COUNT
        block = 0
        WHILE block < 3
            IF PERSIST_CONTAINER_AVAILABLE(character, block)
                g_persist_selftest_pass = g_persist_selftest_pass + 1
            ELSE
                g_persist_containers_missing = g_persist_containers_missing + 1
            ENDIF
            block = block + 1
        ENDWHILE
        block = 1
        WHILE block <= 6
            IF PERSIST_INT_CONTAINER_AVAILABLE(character, block)
                g_persist_selftest_pass = g_persist_selftest_pass + 1
            ELSE
                g_persist_containers_missing = g_persist_containers_missing + 1
            ENDIF
            block = block + 1
        ENDWHILE
        character = character + 1
    ENDWHILE
    character = 0
    WHILE character < PERSIST_CHAR_COUNT
        PERSIST_WRITE_BOOL_SLOT(character, PERSIST_SCRATCH_BOOL_SLOT, TRUE)
        bitValue = PERSIST_READ_BOOL_SLOT(character, PERSIST_SCRATCH_BOOL_SLOT)
        IF bitValue
            g_persist_selftest_pass = g_persist_selftest_pass + 1
        ELSE
            g_persist_selftest_fail = g_persist_selftest_fail + 1
        ENDIF
        PERSIST_WRITE_BOOL_SLOT(character, PERSIST_SCRATCH_BOOL_SLOT, FALSE)
        bitValue = PERSIST_READ_BOOL_SLOT(character, PERSIST_SCRATCH_BOOL_SLOT)
        IF NOT bitValue
            g_persist_selftest_pass = g_persist_selftest_pass + 1
        ELSE
            g_persist_selftest_fail = g_persist_selftest_fail + 1
        ENDIF
        character = character + 1
    ENDWHILE
    character = 0
    WHILE character < PERSIST_CHAR_COUNT
        PERSIST_WRITE_INT_SLOT(character, PERSIST_SCRATCH_INT_SLOT, PERSIST_SELF_TEST_INT_A)
        byteValue = PERSIST_READ_INT_SLOT(character, PERSIST_SCRATCH_INT_SLOT)
        IF byteValue = PERSIST_SELF_TEST_INT_A
            g_persist_selftest_pass = g_persist_selftest_pass + 1
        ELSE
            g_persist_selftest_fail = g_persist_selftest_fail + 1
        ENDIF
        PERSIST_WRITE_INT_SLOT(character, PERSIST_SCRATCH_INT_SLOT, PERSIST_SELF_TEST_INT_B)
        byteValue = PERSIST_READ_INT_SLOT(character, PERSIST_SCRATCH_INT_SLOT)
        IF byteValue = PERSIST_SELF_TEST_INT_B
            g_persist_selftest_pass = g_persist_selftest_pass + 1
        ELSE
            g_persist_selftest_fail = g_persist_selftest_fail + 1
        ENDIF
        PERSIST_WRITE_INT_SLOT(character, PERSIST_SCRATCH_INT_SLOT, 0)
        character = character + 1
    ENDWHILE
    IF g_persist_selftest_fail = 0 AND g_persist_containers_missing = 0
        g_persist_status_text = "PASS - storage is writable"
    ELIF g_persist_containers_missing > 0
        g_persist_status_text = "FAIL - container missing"
    ELSE
        g_persist_status_text = "FAIL - write rejected"
    ENDIF
ENDPROC

PROC MARK_PERSIST_DIRTY()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_dirty
        g_persist_dirty_since = GET_GAME_TIMER()
    ENDIF
    g_persist_dirty = TRUE
    g_persist_next_write = GET_GAME_TIMER() + PERSIST_QUIET_MS
ENDPROC

PROC PERSIST_REQUEST_DISK_SAVE()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_save_disk EXIT ENDIF
    IF GET_GAME_TIMER() < g_persist_next_disk_save EXIT ENDIF
    IF NOT AUTO_SAVE_STATE_SAFE() EXIT ENDIF
    DO_AUTO_SAVE()
    g_persist_next_disk_save = GET_GAME_TIMER() + PERSIST_DISK_DEBOUNCE_MS
ENDPROC

PROC PERSIST_SEED_TIMERS_AFTER_LOAD()
    INT now = GET_GAME_TIMER()
    g_persist_next_write = now + PERSIST_QUIET_MS
    g_persist_next_disk_save = now + PERSIST_DISK_DEBOUNCE_MS
ENDPROC

PROC PERSIST_FLUSH_NOW()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_dirty EXIT ENDIF
    PERSIST_SAVE_DELTA()
    g_persist_dirty = FALSE
    PERSIST_REQUEST_DISK_SAVE()
ENDPROC

PROC PROCESS_PERSISTENCE()
    INT now = 0
    PERSIST_RESOLVE_ACTIVE_CHARACTER()
    IF NOT g_persist_load_done
        IF PERSIST_LOAD_ALL()
            g_persist_load_done = TRUE
            PERSIST_SEED_TIMERS_AFTER_LOAD()
        ELSE
            g_persist_load_attempts = g_persist_load_attempts + 1
            IF g_persist_load_attempts >= 120
                g_persist_load_done = TRUE
                g_persist_boot_status = 1
                PERSIST_SEED_TIMERS_AFTER_LOAD()
            ENDIF
        ENDIF
        EXIT
    ENDIF
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_dirty EXIT ENDIF
    now = GET_GAME_TIMER()
    IF now < g_persist_next_write
        IF now < g_persist_dirty_since + PERSIST_MAX_DEFER_MS EXIT ENDIF
    ENDIF
    PERSIST_SAVE_DELTA()
    g_persist_dirty = FALSE
    PERSIST_REQUEST_DISK_SAVE()
ENDPROC

FUNC INT PERSIST_ROW_COUNT()
    RETURN PERSIST_MENU_ROWS
ENDFUNC

FUNC STRING PERSIST_BOOT_STATUS_LABEL()
    IF NOT g_persist_load_done RETURN "Restoring..." ENDIF
    IF g_persist_boot_status = 0 RETURN "Restored" ENDIF
    IF g_persist_boot_status = 2 RETURN "Saved: off" ENDIF
    RETURN "No saved state"
ENDFUNC

FUNC STRING PERSIST_CHECKSUM_LABEL()
    IF g_persist_checksum_ok < 0 RETURN "Not checked" ENDIF
    IF g_persist_checksum_ok = 1 RETURN "Matched" ENDIF
    RETURN "Mismatch"
ENDFUNC

PROC DRAW_PERSIST_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_persist_enabled DRAW_OPTION(y, "Keep My Settings", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Keep My Settings", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, "Save Settings Now", "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, "Reset Saved Settings", "APPLY", g_item = index, 0) BREAK
        CASE 3 DRAW_OPTION(y, "Storage Self-Test", "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, "Self-Test Result", g_persist_status_text, g_item = index, 2) BREAK
        CASE 5 IF g_persist_save_disk DRAW_OPTION(y, "Save To Disk After Change", "ON", g_item = index, 1) ELSE DRAW_OPTION(y, "Save To Disk After Change", "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 DRAW_OPTION(y, "Last Boot", PERSIST_BOOT_STATUS_LABEL(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, "Checksum", PERSIST_CHECKSUM_LABEL(), g_item = index, 2) BREAK
        CASE 8 DRAW_NUMBER_OPTION(y, "Containers Missing", g_persist_containers_missing, g_item = index) BREAK
        CASE 9 DRAW_NUMBER_OPTION(y, "Writes Accepted", g_persist_written, g_item = index) BREAK
        CASE 10 DRAW_NUMBER_OPTION(y, "Writes Rejected", g_persist_failed, g_item = index) BREAK
        CASE 11 DRAW_NUMBER_OPTION(y, "Load Attempts", g_persist_load_attempts, g_item = index) BREAK
        CASE 12 DRAW_NUMBER_OPTION(y, "Self-Test Passed", g_persist_selftest_pass, g_item = index) BREAK
        CASE 13 DRAW_NUMBER_OPTION(y, "Self-Test Failed", g_persist_selftest_fail, g_item = index) BREAK
        CASE 14 DRAW_NUMBER_OPTION(y, "Worst Frame MS", g_prof_worst_frame, g_item = index) BREAK
        CASE 15 DRAW_NUMBER_OPTION(y, "Worst Script MS", g_prof_worst_work, g_item = index) BREAK
        CASE 16 DRAW_NUMBER_OPTION(y, "Worst Persist MS", g_prof_worst_persist, g_item = index) BREAK
        CASE 17 DRAW_NUMBER_OPTION(y, "Worst Save Burst", g_prof_worst_burst, g_item = index) BREAK
        CASE 18 DRAW_NUMBER_OPTION(y, "Worst Menu Sound", g_prof_worst_sound, g_item = index) BREAK
        CASE 19 DRAW_NUMBER_OPTION(y, "Worst Apply MS", g_prof_worst_apply, g_item = index) BREAK
        CASE 20 DRAW_NUMBER_OPTION(y, "Worst Draw MS", g_prof_worst_draw, g_item = index) BREAK
        CASE 21 DRAW_NUMBER_OPTION(y, "Worst Apply Loc", (g_prof_apply_tab * 100) + g_prof_apply_row, g_item = index) BREAK
        CASE 22 DRAW_NUMBER_OPTION(y, "Save Bursts", g_prof_persist_count, g_item = index) BREAK
        CASE 23 DRAW_NUMBER_OPTION(y, "Menu Sounds", g_prof_sound_count, g_item = index) BREAK
        CASE 24 DRAW_OPTION(y, "Reset Probe Counters", "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_PERSIST_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, "PERSISTENT SETTINGS")
    DRAW_MENU_VERSION_TAG()
    INT index = g_persist_scroll
    INT row = 0
    WHILE row < 8 AND index < PERSIST_ROW_COUNT()
        DRAW_PERSIST_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC PERSIST_HANDLE_ROW(INT index)
    SWITCH index
        CASE 0
            g_persist_enabled = NOT g_persist_enabled
            IF g_persist_enabled MARK_PERSIST_DIRTY() ENDIF
        BREAK
        CASE 1
            PERSIST_SAVE_ALL()
            g_persist_dirty = FALSE
            IF AUTO_SAVE_STATE_SAFE()
                DO_AUTO_SAVE()
                g_persist_status_text = "Saved to game"
            ELSE
                g_persist_status_text = "Saved in memory"
            ENDIF
        BREAK
        CASE 2
            PERSIST_CLEAR_ALL()
            g_persist_status_text = "Saved settings cleared"
        BREAK
        CASE 3 PERSIST_SELF_TEST() BREAK
        CASE 5 g_persist_save_disk = NOT g_persist_save_disk BREAK
        CASE 24
            g_prof_worst_frame = 0
            g_prof_worst_work = 0
            g_prof_worst_persist = 0
            g_prof_worst_burst = 0
            g_prof_worst_sound = 0
            g_prof_worst_apply = 0
            g_prof_worst_draw = 0
            g_prof_apply_tab = -1
            g_prof_apply_row = -1
            g_prof_persist_count = 0
            g_prof_sound_count = 0
        BREAK
    ENDSWITCH
ENDPROC
