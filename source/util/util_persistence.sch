//|=======================================================================================|
//|  util_persistence.sch - Direct SD Card Persistence for the MEGATARD Menu.            |
//|  Powered by ScriptHookV-NX (subsdk5) native filesystem bridge.                        |
//|=======================================================================================|
//
//  PURPOSE
//  -------
//  Previously, menu settings persistence relied on bit-packing settings into single-player
//  stat containers (SPx_PSTAT_BOOL0..2, SPx_PSTAT_INT1..6) and writing them into the
//  story save file (SGTA50000) via DO_AUTO_SAVE(). That caused savegame bloat, checksum
//  mismatches, and save file corruption across character swaps.
//
//  This module completely replaces game-stat writes with ScriptHookV-NX direct file
//  persistence:
//    - Saves settings to alternating checksummed files under switch/gtav-megatard/.
//    - Zero modifications to single-player progression stats or SGTA50000 save files.
//    - MEGASAVE / MEGALOAD require the ScriptHookV-NX compatibility bridge in subsdk5.
//    - Script INTs occupy 8-byte VM slots; the bridge packs their 32-bit values.
//    - Storage Self-Test uses separate files and cannot overwrite menu settings.
//
//|=======================================================================================|

// Bridge Natives declared for dev_ng compiler
NATIVE FUNC BOOL MEGASAVE(INT &buffer, INT size, INT testStorage = 0) = "0x4d45474153415645"
NATIVE FUNC INT MEGALOAD(INT &buffer, INT size, INT testStorage = 0) = "0x4d4547414c4f4144"

// Magic Header sentinel: 0x4D454741 ('MEGA')
CONST_INT PERSIST_MAGIC_HEADER 1296385857
CONST_INT PERSIST_SCHEMA_VERSION 2
CONST_INT PERSIST_TEST_SENTINEL 1413829460 // 'TEST' (0x54455354)

// Buffer word layout (128 words = 512 bytes, FAT32 sector aligned):
CONST_INT PERSIST_WORD_MAGIC 0
CONST_INT PERSIST_WORD_VERSION 1
CONST_INT PERSIST_WORD_CHECKSUM 2
CONST_INT PERSIST_WORD_STATUS 3
CONST_INT PERSIST_WORD_BOOL_BASE 4   // 37 bools: words 4..40
CONST_INT PERSIST_WORD_INT_BASE 41   // 27 ints: words 41..67
CONST_INT PERSIST_WORD_LANG 68       // Menu Language: word 68
CONST_INT PERSIST_WORD_NSC_BASE 69   // Custom NSC script names: words 69..126
CONST_INT PERSIST_BUFFER_WORDS 128

// ---- Bool slot ids (0..36) -------------------------------------------------
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
CONST_INT PERSIST_BOOL_LIVE_COORDS 14
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
CONST_INT PERSIST_BOOL_SIREN_MUTE 36

// ---- Int slot ids (0..26) --------------------------------------------------
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
CONST_INT PERSIST_INT_NSC_STACK 26

// Range clamps applied on load
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
CONST_INT PERSIST_MAX_WHEEL_TYPE 12
CONST_INT PERSIST_MAX_WINDOW_TINT 6
CONST_INT PERSIST_MAX_NSC_STACK 2

// Write-through pacing
CONST_INT PERSIST_QUIET_MS 1000
CONST_INT PERSIST_MAX_DEFER_MS 5000

// Reads the current value of a bool slot out of menu globals
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
        CASE PERSIST_BOOL_LIVE_COORDS RETURN g_show_live_coords BREAK
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
        CASE PERSIST_BOOL_SIREN_MUTE RETURN g_siren_mute_enabled BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

// Writes a bool slot back into menu globals
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
        CASE PERSIST_BOOL_LIVE_COORDS g_show_live_coords = value BREAK
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
        CASE PERSIST_BOOL_SIREN_MUTE g_siren_mute_enabled = value BREAK
    ENDSWITCH
ENDPROC

// Reads the current value of an int slot out of menu globals
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
        CASE PERSIST_INT_NSC_STACK RETURN g_nsc_stack_choice BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

// Writes an int slot back into menu globals, with range clamps
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
        CASE PERSIST_INT_NSC_STACK
            IF value > PERSIST_MAX_NSC_STACK value = PERSIST_MAX_NSC_STACK ENDIF
            g_nsc_stack_choice = value
        BREAK
    ENDSWITCH
ENDPROC

// Computes 32-bit checksum across payload words in g_persist_sd_data
FUNC INT PERSIST_COMPUTE_SD_CHECKSUM()
    INT sum = 0
    INT i = 4
    WHILE i < PERSIST_BUFFER_WORDS
        sum = sum + g_persist_sd_data[i]
        i = i + 1
    ENDWHILE
    IF sum < 0 sum = -sum ENDIF
    RETURN sum
ENDFUNC

// Loads custom NSC script filenames from SD buffer
PROC PERSIST_LOAD_CUSTOM_NSC_LIST()
    TEXT_LABEL_63 currentName = ""
    INT currentLen = 0
    INT nscIdx = 0
    INT code = 0
    STRING ch = ""

    g_nsc_discovered_count = 0
    WHILE nscIdx < 58
        code = g_persist_sd_data[PERSIST_WORD_NSC_BASE + nscIdx]
        IF code <= 0
            nscIdx = 58
        ELIF code = NSC_PERSIST_SEP_CODE
            IF currentLen > 0
                TRY_REGISTER_CUSTOM_NSC(currentName)
                currentName = ""
                currentLen = 0
            ENDIF
            nscIdx = nscIdx + 1
        ELSE
            ch = NSC_CODE_TO_CHAR(code)
            IF NOT IS_STRING_NULL_OR_EMPTY(ch)
                currentName += ch
                currentLen = currentLen + 1
            ENDIF
            nscIdx = nscIdx + 1
        ENDIF
    ENDWHILE
    IF currentLen > 0
        TRY_REGISTER_CUSTOM_NSC(currentName)
    ENDIF
    IF g_nsc_discovered_count > 0
        g_nsc_last_probed_name = g_nsc_script_names[g_nsc_discovered_count - 1]
    ENDIF
ENDPROC

// Refreshes write-shadow baseline from current globals
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

// Packs live menu globals into g_persist_sd_data buffer
PROC PERSIST_PACK_ALL_TO_BUFFER()
    INT slot = 0
    INT nscIdx = 0

    g_persist_sd_data[PERSIST_WORD_MAGIC] = PERSIST_MAGIC_HEADER
    g_persist_sd_data[PERSIST_WORD_VERSION] = PERSIST_SCHEMA_VERSION
    g_persist_sd_data[PERSIST_WORD_STATUS] = 0

    WHILE slot < PERSIST_BOOL_SLOTS
        IF PERSIST_GLOBAL_BOOL(slot)
            g_persist_sd_data[PERSIST_WORD_BOOL_BASE + slot] = 1
        ELSE
            g_persist_sd_data[PERSIST_WORD_BOOL_BASE + slot] = 0
        ENDIF
        slot = slot + 1
    ENDWHILE

    slot = 0
    WHILE slot < PERSIST_INT_SLOTS
        g_persist_sd_data[PERSIST_WORD_INT_BASE + slot] = PERSIST_GLOBAL_INT(slot)
        slot = slot + 1
    ENDWHILE

    g_persist_sd_data[PERSIST_WORD_LANG] = g_menu_language

    WHILE nscIdx < 58
        g_persist_sd_data[PERSIST_WORD_NSC_BASE + nscIdx] = NSC_PERSIST_CHAR_AT(nscIdx)
        nscIdx = nscIdx + 1
    ENDWHILE

    g_persist_sd_data[PERSIST_WORD_CHECKSUM] = PERSIST_COMPUTE_SD_CHECKSUM()
ENDPROC

// Applies loaded settings to active game subsystems
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

// Unpacks g_persist_sd_data buffer into live menu globals
PROC PERSIST_UNPACK_ALL_FROM_BUFFER()
    INT savedLang = g_persist_sd_data[PERSIST_WORD_LANG]
    INT slot = 0

    IF savedLang >= 0 AND savedLang <= 5
        g_menu_language = savedLang
    ENDIF

    IF g_persist_sd_data[PERSIST_WORD_BOOL_BASE + PERSIST_BOOL_ENABLED] = 1
        g_persist_enabled = TRUE
    ELSE
        g_persist_enabled = FALSE
    ENDIF

    IF NOT g_persist_enabled
        g_persist_boot_status = 2
        EXIT
    ENDIF

    WHILE slot < PERSIST_BOOL_SLOTS
        IF g_persist_sd_data[PERSIST_WORD_BOOL_BASE + slot] = 1
            PERSIST_SET_GLOBAL_BOOL(slot, TRUE)
        ELSE
            PERSIST_SET_GLOBAL_BOOL(slot, FALSE)
        ENDIF
        slot = slot + 1
    ENDWHILE

    slot = 0
    WHILE slot < PERSIST_INT_SLOTS
        PERSIST_SET_GLOBAL_INT(slot, g_persist_sd_data[PERSIST_WORD_INT_BASE + slot])
        slot = slot + 1
    ENDWHILE

    PERSIST_LOAD_CUSTOM_NSC_LIST()

    IF g_persist_sd_data[PERSIST_WORD_CHECKSUM] = PERSIST_COMPUTE_SD_CHECKSUM()
        g_persist_checksum_ok = 1
    ELSE
        g_persist_checksum_ok = 0
    ENDIF

    PERSIST_APPLY_LOADED_SETTINGS()
    PERSIST_REFRESH_SHADOW()
ENDPROC

// Saves all current settings directly to SD card via ScriptHookV-NX
PROC PERSIST_SAVE_ALL()
    INT probeStart = GET_GAME_TIMER()
    INT probeElapsed = 0
    g_prof_persist_count = g_prof_persist_count + 1

    PERSIST_PACK_ALL_TO_BUFFER()

    IF MEGASAVE(g_persist_sd_data[0], PERSIST_BUFFER_WORDS)
        g_persist_written = g_persist_written + 1
        g_persist_status_text = TR("Saved to SD (ScriptHookV-NX)", "Guardado en SD (ScriptHookV-NX)", "已保存到 SD 卡 (ScriptHookV-NX)", "Auf SD gespeichert (ScriptHookV-NX)", "SDに保存完了 (ScriptHookV-NX)", "Сохранено на SD (ScriptHookV-NX)", "Salvo no SD (ScriptHookV-NX)", "Sauvegardé sur SD (ScriptHookV-NX)")
    ELSE
        g_persist_failed = g_persist_failed + 1
        g_persist_status_text = TR("SD Write Failed / Bridge Inactive", "Fallo al escribir en SD / Bridge inactivo", "SD 卡写入失败 / Bridge 未激活", "SD-Schreiben fehlgeschlagen", "SD書き込み失敗 / ブリッジ停止", "Ошибка записи на SD / Мост неактивен", "Falha ao gravar no SD / Ponte inativa", "Échec écriture SD / Pont inactif")
    ENDIF

    PERSIST_REFRESH_SHADOW()
    g_persist_dirty = FALSE

    probeElapsed = GET_GAME_TIMER() - probeStart
    IF probeElapsed > g_prof_worst_burst
        g_prof_worst_burst = probeElapsed
    ENDIF
ENDPROC

// Frame-loop delta saver: only writes when globals differ from the shadow
PROC PERSIST_SAVE_DELTA()
    INT slot = 0
    INT value = 0
    INT boolInt = 0
    BOOL boolValue = FALSE
    BOOL needsWrite = FALSE

    slot = 0
    WHILE slot < PERSIST_BOOL_SLOTS
        boolValue = PERSIST_GLOBAL_BOOL(slot)
        boolInt = 0
        IF boolValue boolInt = 1 ENDIF
        IF NOT g_persist_shadow_valid OR g_persist_shadow_bool[slot] != boolInt
            needsWrite = TRUE
            slot = PERSIST_BOOL_SLOTS
        ELSE
            slot = slot + 1
        ENDIF
    ENDWHILE

    IF NOT needsWrite
        slot = 0
        WHILE slot < PERSIST_INT_SLOTS
            value = PERSIST_GLOBAL_INT(slot)
            IF NOT g_persist_shadow_valid OR g_persist_shadow_int[slot] != value
                needsWrite = TRUE
                slot = PERSIST_INT_SLOTS
            ELSE
                slot = slot + 1
            ENDIF
        ENDWHILE
    ENDIF

    IF NOT needsWrite AND g_menu_language != g_persist_sd_data[PERSIST_WORD_LANG]
        needsWrite = TRUE
    ENDIF

    IF needsWrite
        PERSIST_SAVE_ALL()
    ENDIF
ENDPROC

// Loads all saved settings from SD card file upon boot
FUNC BOOL PERSIST_LOAD_ALL()
    INT wordsRead = MEGALOAD(g_persist_sd_data[0], PERSIST_BUFFER_WORDS)
    IF wordsRead != PERSIST_BUFFER_WORDS
        g_persist_boot_status = 1
        RETURN FALSE
    ENDIF

    IF g_persist_sd_data[PERSIST_WORD_MAGIC] != PERSIST_MAGIC_HEADER OR g_persist_sd_data[PERSIST_WORD_VERSION] != PERSIST_SCHEMA_VERSION
        g_persist_boot_status = 1
        RETURN FALSE
    ENDIF

    // Reject damaged records before they can change globals or game state.
    IF g_persist_sd_data[PERSIST_WORD_CHECKSUM] != PERSIST_COMPUTE_SD_CHECKSUM()
        g_persist_checksum_ok = 0
        g_persist_boot_status = 1
        RETURN FALSE
    ENDIF

    PERSIST_UNPACK_ALL_FROM_BUFFER()
    g_persist_boot_status = 0
    g_persist_status_text = TR("Loaded from SD Card", "Cargado desde tarjeta SD", "已从 SD 卡加载", "Von SD geladen", "SDカードから読み込み完了", "Загружено с SD-карты", "Carregado do cartão SD", "Chargé depuis la carte SD")
    RETURN TRUE
ENDFUNC

// Clears saved settings on SD card and resets to menu defaults
PROC PERSIST_CLEAR_ALL()
    INT i = 0
    WHILE i < PERSIST_BUFFER_WORDS
        g_persist_sd_data[i] = 0
        i = i + 1
    ENDWHILE
    MEGASAVE(g_persist_sd_data[0], PERSIST_BUFFER_WORDS)
    g_persist_dirty = FALSE
    g_persist_shadow_valid = FALSE
    g_persist_written = 0
    g_persist_failed = 0
    g_persist_checksum_ok = -1
    g_persist_status_text = TR("Saved settings cleared from SD", "Ajustes borrados de la SD", "已从 SD 卡清除保存的设置", "Gespeicherte Einst. von SD gelöscht", "SDから保存設定を消去", "Настройки удалены с SD", "Ajustes salvos apagados do SD", "Paramètres effacés de la SD")
ENDPROC

// Storage self-test: probes ScriptHookV-NX SD card bridge read/write
PROC PERSIST_SELF_TEST()
    INT probeBuf[4]
    INT readBuf[4]
    INT gotWords = 0

    g_persist_selftest_pass = 0
    g_persist_selftest_fail = 0

    probeBuf[0] = PERSIST_TEST_SENTINEL
    probeBuf[1] = 1337
    probeBuf[2] = 42
    probeBuf[3] = 999

    IF MEGASAVE(probeBuf[0], 4, 1)
        g_persist_selftest_pass = g_persist_selftest_pass + 1
    ELSE
        g_persist_selftest_fail = g_persist_selftest_fail + 1
    ENDIF

    readBuf[0] = 0
    readBuf[1] = 0
    readBuf[2] = 0
    readBuf[3] = 0

    gotWords = MEGALOAD(readBuf[0], 4, 1)
    IF gotWords > 0 AND readBuf[0] = PERSIST_TEST_SENTINEL AND readBuf[1] = 1337
        g_persist_selftest_pass = g_persist_selftest_pass + 1
    ELSE
        g_persist_selftest_fail = g_persist_selftest_fail + 1
    ENDIF

    IF g_persist_selftest_fail = 0
        g_persist_status_text = TR("PASS - ScriptHookV-NX SD Storage OK", "ÉXITO - Almacenamiento SD ScriptHookV-NX OK", "通过 - ScriptHookV-NX SD 存储正常", "OK - ScriptHookV-NX SD-Speicher OK", "合格 - ScriptHookV-NX SDストレージ正常", "ОК - Хранилище ScriptHookV-NX на SD в норме", "OK - Armazenamento SD ScriptHookV-NX OK", "OK - Stockage SD ScriptHookV-NX OK")
    ELSE
        g_persist_status_text = TR("FAIL - SD Bridge Offline / Check subsdk5", "FALLO - Bridge SD inactivo / Revisa subsdk5", "失败 - SD Bridge 离线 / 请检查 subsdk5", "FEHLER - SD-Bridge offline / subsdk5 prüfen", "失敗 - SDブリッジ停止 / subsdk5を確認", "СБОЙ - Мост SD отключен / Проверьте subsdk5", "FALHA - Ponte SD offline / Verifique subsdk5", "ÉCHEC - Pont SD hors ligne / Vérifier subsdk5")
    ENDIF
ENDPROC

// Coalesces rapid changes
PROC MARK_PERSIST_DIRTY()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_dirty
        g_persist_dirty_since = GET_GAME_TIMER()
    ENDIF
    g_persist_dirty = TRUE
    g_persist_next_write = GET_GAME_TIMER() + PERSIST_QUIET_MS
ENDPROC

// Direct SD Card Save request (replaces old game save file request)
PROC PERSIST_REQUEST_DISK_SAVE()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_save_disk EXIT ENDIF
    PERSIST_SAVE_DELTA()
ENDPROC

// Seeds timers after boot load
PROC PERSIST_SEED_TIMERS_AFTER_LOAD()
    INT now = GET_GAME_TIMER()
    g_persist_next_write = now + PERSIST_QUIET_MS
ENDPROC

// Flushes pending changes immediately to SD card on menu close
PROC PERSIST_FLUSH_NOW()
    IF NOT g_persist_enabled EXIT ENDIF
    IF NOT g_persist_dirty EXIT ENDIF
    PERSIST_SAVE_DELTA()
    g_persist_dirty = FALSE
ENDPROC

// Immediately saves selected menu language to SD card
PROC PERSIST_SAVE_LANGUAGE_NOW()
    IF g_persist_enabled
        g_persist_sd_data[PERSIST_WORD_LANG] = g_menu_language
        PERSIST_SAVE_ALL()
    ENDIF
ENDPROC

// Called once per frame from the main loop
PROC PROCESS_PERSISTENCE()
    INT now = 0

    IF NOT g_persist_load_done
        IF PERSIST_LOAD_ALL()
            g_persist_load_done = TRUE
            PERSIST_SEED_TIMERS_AFTER_LOAD()
        ELSE
            g_persist_load_attempts = g_persist_load_attempts + 1
            IF g_persist_load_attempts >= 60
                g_persist_load_done = TRUE
                g_persist_boot_status = 1
                PERSIST_SEED_TIMERS_AFTER_LOAD()
            ENDIF
        ENDIF
        EXIT
    ENDIF

    IF NOT g_persist_enabled
        EXIT
    ENDIF

    IF NOT g_persist_dirty
        EXIT
    ENDIF

    now = GET_GAME_TIMER()
    IF now < g_persist_next_write
        IF now < g_persist_dirty_since + PERSIST_MAX_DEFER_MS EXIT ENDIF
    ENDIF

    PERSIST_SAVE_DELTA()
ENDPROC

//|=======================================================================================|
//|  PERSISTENCE SUBMENU UI & RENDERING                                                   |
//|=======================================================================================|

FUNC INT PERSIST_ROW_COUNT()
    RETURN PERSIST_MENU_ROWS
ENDFUNC

FUNC STRING PERSIST_BOOT_STATUS_LABEL()
    IF NOT g_persist_load_done RETURN TR("Restoring...", "Restaurando...", "正在恢复...", "Wiederherstellen...", "復元中...", "Восстановление...", "Restaurando...", "Restauration...") ENDIF
    IF g_persist_boot_status = 0 RETURN TR("Restored (SD)", "Restaurado (SD)", "已恢复 (SD)", "Wiederhergestellt (SD)", "復元済 (SD)", "Восстановлено (SD)", "Restaurado (SD)", "Restauré (SD)") ENDIF
    IF g_persist_boot_status = 2 RETURN TR("Saved: off", "Guardado: no", "已保存: 关", "Gespeichert: aus", "保存: オフ", "Сохр.: выкл", "Salvo: desligado", "Sauvegardé : non") ENDIF
    RETURN TR("No saved state", "Sin estado guardado", "无保存状态", "Kein Speicherstand", "保存データなし", "Нет сохранения", "Sem estado salvo", "Aucun état sauvegardé")
ENDFUNC

FUNC STRING PERSIST_CHECKSUM_LABEL()
    IF g_persist_checksum_ok < 0 RETURN TR("Not checked", "No verificado", "未检查", "Nicht geprüft", "未確認", "Не проверено", "Não verificado", "Non vérifié") ENDIF
    IF g_persist_checksum_ok = 1 RETURN TR("Matched", "Coincide", "匹配", "Stimmt überein", "一致", "Совпадает", "Corresponde", "Conforme") ENDIF
    RETURN TR("Mismatch", "No coincide", "不匹配", "Abweichung", "不一致", "Не совпадает", "Incompatível", "Différent")
ENDFUNC

FUNC STRING PERSIST_STATUS_LABEL()
    IF ARE_STRINGS_EQUAL(g_persist_status_text, "Not tested")
        RETURN TR("Not tested", "No probado", "未测试", "Nicht getestet", "未テスト", "Не проверено", "Não testado", "Non testé")
    ENDIF
    RETURN g_persist_status_text
ENDFUNC

PROC DRAW_PERSIST_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_persist_enabled DRAW_OPTION(y, TR("Keep My Settings", "Conservar mis ajustes", "保留我的设置", "Einstellungen behalten", "設定を保持", "Сохранять настройки", "Manter meus ajustes", "Garder mes paramètres"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Keep My Settings", "Conservar mis ajustes", "保留我的设置", "Einstellungen behalten", "設定を保持", "Сохранять настройки", "Manter meus ajustes", "Garder mes paramètres"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 DRAW_OPTION(y, TR("Save Settings Now", "Guardar ajustes ahora", "立即保存设置", "Einstellungen jetzt speichern", "今すぐ設定を保存", "Сохранить настройки сейчас", "Salvar ajustes agora", "Sauvegarder maintenant"), "APPLY", g_item = index, 2) BREAK
        CASE 2 DRAW_OPTION(y, TR("Reset Saved Settings", "Restablecer ajustes guardados", "重置已保存设置", "Gespeicherte Einst. zurücksetzen", "保存設定をリセット", "Сбросить сохр. настройки", "Redefinir ajustes salvos", "Réinitialiser les paramètres"), "APPLY", g_item = index, 0) BREAK
        CASE 3 DRAW_OPTION(y, TR("Storage Self-Test", "Autoprueba de almacenamiento", "存储自检", "Speicher-Selbsttest", "ストレージ自己診断", "Самопроверка хранилища", "Autoteste de armazenamento", "Auto-test du stockage"), "APPLY", g_item = index, 2) BREAK
        CASE 4 DRAW_OPTION(y, TR("Self-Test Result", "Resultado de autoprueba", "自检结果", "Selbsttest-Ergebnis", "診断結果", "Результат проверки", "Resultado do autoteste", "Résultat de l'auto-test"), PERSIST_STATUS_LABEL(), g_item = index, 2) BREAK
        CASE 5 IF g_persist_save_disk DRAW_OPTION(y, TR("Save To SD After Change", "Guardar en SD tras cambio", "更改后写入 SD 卡", "Nach Änderung auf SD speichern", "変更後にSD保存", "Сохранять на SD после изм.", "Salvar no SD após mudar", "Sauver sur SD après modif."), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Save To SD After Change", "Guardar en SD tras cambio", "更改后写入 SD 卡", "Nach Änderung auf SD speichern", "変更後にSD保存", "Сохранять на SD после изм.", "Salvar no SD após mudar", "Sauver sur SD après modif."), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 6 DRAW_OPTION(y, TR("Last Boot", "Último inicio", "上次启动", "Letzter Start", "前回起動", "Последний запуск", "Última inicialização", "Dernier démarrage"), PERSIST_BOOT_STATUS_LABEL(), g_item = index, 2) BREAK
        CASE 7 DRAW_OPTION(y, TR("Checksum", "Suma de control", "校验和", "Prüfsumme", "チェックサム", "Контрольная сумма", "Soma de verificação", "Somme de contrôle"), PERSIST_CHECKSUM_LABEL(), g_item = index, 2) BREAK
        CASE 8 DRAW_OPTION(y, TR("Storage Medium", "Medio de almacenamiento", "存储介质", "Speichermedium", "保存メディア", "Носитель данных", "Mídia de armazenamento", "Support de stockage"), TR("< SD Card (ScriptHookV-NX) >", "< Tarjeta SD (ScriptHookV-NX) >", "< SD 卡 (ScriptHookV-NX) >", "< SD-Karte (ScriptHookV-NX) >", "< SDカード (ScriptHookV-NX) >", "< SD-карта (ScriptHookV-NX) >", "< Cartão SD (ScriptHookV-NX) >", "< Carte SD (ScriptHookV-NX) >"), g_item = index, 2) BREAK
        CASE 9 DRAW_NUMBER_OPTION(y, TR("Writes Accepted", "Escrituras aceptadas", "成功写入数", "Schreibvorgänge OK", "書き込み成功数", "Принято записей", "Gravações aceitas", "Écritures acceptées"), g_persist_written, g_item = index) BREAK
        CASE 10 DRAW_NUMBER_OPTION(y, TR("Writes Rejected", "Escrituras rechazadas", "拒绝写入数", "Schreibvorgänge abgelehnt", "書き込み拒否数", "Отклонено записей", "Gravações recusadas", "Écritures refusées"), g_persist_failed, g_item = index) BREAK
        CASE 11 DRAW_NUMBER_OPTION(y, TR("Load Attempts", "Intentos de carga", "加载尝试次数", "Ladeversuche", "読み込み試行回数", "Попыток загрузки", "Tentativas de carga", "Tentatives de chargement"), g_persist_load_attempts, g_item = index) BREAK
        CASE 12 DRAW_NUMBER_OPTION(y, TR("Self-Test Passed", "Autopruebas superadas", "自检通过项", "Selbsttest bestanden", "診断合格数", "Проверок пройдено", "Autotestes aprovados", "Auto-tests réussis"), g_persist_selftest_pass, g_item = index) BREAK
        CASE 13 DRAW_NUMBER_OPTION(y, TR("Self-Test Failed", "Autopruebas fallidas", "自检失败项", "Selbsttest fehlgeschlagen", "診断失敗数", "Проверок провалено", "Autotestes reprovados", "Auto-tests échoués"), g_persist_selftest_fail, g_item = index) BREAK
        CASE 14 DRAW_NUMBER_OPTION(y, TR("Worst Frame MS", "Peor fotograma (ms)", "最慢帧耗时 (ms)", "Schlechtester Frame MS", "最大フレーム時間 (ms)", "Худший кадр (мс)", "Pior quadro (ms)", "Pire image (ms)"), g_prof_worst_frame, g_item = index) BREAK
        CASE 15 DRAW_NUMBER_OPTION(y, TR("Worst Script MS", "Peor script (ms)", "最慢脚本耗时 (ms)", "Schlechtestes Skript MS", "最大スクリプト時間 (ms)", "Худший скрипт (мс)", "Pior script (ms)", "Pire script (ms)"), g_prof_worst_work, g_item = index) BREAK
        CASE 16 DRAW_NUMBER_OPTION(y, TR("Worst Persist MS", "Peor persistencia (ms)", "最慢持久化耗时 (ms)", "Schlechteste Persist. MS", "最大保存処理 (ms)", "Худшее сохр. (мс)", "Pior persistência (ms)", "Pire persistance (ms)"), g_prof_worst_persist, g_item = index) BREAK
        CASE 17 DRAW_NUMBER_OPTION(y, TR("Worst Save Burst", "Peor ráfaga guardado", "最慢保存突发 (ms)", "Schlechtester Save-Burst", "最大保存バースト", "Худший пакет сохр.", "Pior rajada de salvamento", "Pire rafale de sauv."), g_prof_worst_burst, g_item = index) BREAK
        CASE 18 DRAW_NUMBER_OPTION(y, TR("Worst Menu Sound", "Peor sonido menú", "最慢菜单音效 (ms)", "Schlechtester Menüton", "最大メニュー音", "Худший звук меню", "Pior som do menu", "Pire son du menu"), g_prof_worst_sound, g_item = index) BREAK
        CASE 19 DRAW_NUMBER_OPTION(y, TR("Worst Apply MS", "Peor aplicación (ms)", "最慢应用耗时 (ms)", "Schlechtestes Anwenden MS", "最大適用時間 (ms)", "Худшее примен. (мс)", "Pior aplicação (ms)", "Pire application (ms)"), g_prof_worst_apply, g_item = index) BREAK
        CASE 20 DRAW_NUMBER_OPTION(y, TR("Worst Draw MS", "Peor dibujado (ms)", "最慢绘制耗时 (ms)", "Schlechtestes Zeichnen MS", "最大描画時間 (ms)", "Худшая отрисовка (мс)", "Pior desenho (ms)", "Pire rendu (ms)"), g_prof_worst_draw, g_item = index) BREAK
        CASE 21 DRAW_NUMBER_OPTION(y, TR("Worst Apply Loc", "Ubic. peor aplicación", "最慢应用位置", "Schlechtester Anwend.-Ort", "最大適用位置", "Место худш. примен.", "Local da pior aplicação", "Empl. pire application"), (g_prof_apply_tab * 100) + g_prof_apply_row, g_item = index) BREAK
        CASE 22 DRAW_NUMBER_OPTION(y, TR("Save Bursts", "Ráfagas de guardado", "保存突发次数", "Save-Bursts", "保存バースト回数", "Пакетов сохранения", "Rajadas de salvamento", "Rafales de sauvegarde"), g_prof_persist_count, g_item = index) BREAK
        CASE 23 DRAW_NUMBER_OPTION(y, TR("Menu Sounds", "Sonidos de menú", "菜单音效次数", "Menütöne", "メニュー音回数", "Звуков меню", "Sons do menu", "Sons du menu"), g_prof_sound_count, g_item = index) BREAK
        CASE 24 DRAW_OPTION(y, TR("Reset Probe Counters", "Reiniciar contadores", "重置性能计数器", "Messzähler zurücksetzen", "計測カウンタをリセット", "Сбросить счётчики замеров", "Zerar contadores", "Réinitialiser compteurs"), "APPLY", g_item = index, 2) BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_PERSIST_PAGE()
    INT index = g_persist_scroll
    INT row = 0
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("PERSISTENT SETTINGS", "AJUSTES PERSISTENTES", "持久化设置", "DAUERHAFTE EINSTELLUNGEN", "設定の永続化", "СОХРАНЕНИЕ НАСТРОЕК", "AJUSTES PERSISTENTES", "PARAMÈTRES PERSISTANTS"))
    DRAW_MENU_VERSION_TAG()
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
        BREAK
        CASE 2
            PERSIST_CLEAR_ALL()
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
