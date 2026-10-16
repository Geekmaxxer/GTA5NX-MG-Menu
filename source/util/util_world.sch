PROC PREPARE_NORTH_YANKTON()
    // North Yankton is streamed from the prologue IPL set.  Request it before
    // the coordinate move so the player does not arrive in an unloaded world.
    REQUEST_IPL("prologue01")
    REQUEST_IPL("prologue01c")
    REQUEST_IPL("prologue01d")
    REQUEST_IPL("prologue01e")
    REQUEST_IPL("prologue01f")
    REQUEST_IPL("prologue01g")
    REQUEST_IPL("prologue01h")
    REQUEST_IPL("prologue01i")
    REQUEST_IPL("prologue01j")
    REQUEST_IPL("prologue01k")
    REQUEST_IPL("prologue01z")
    REQUEST_IPL("prologue02")
    REQUEST_IPL("prologue03")
    REQUEST_IPL("prologue03b")
    REQUEST_IPL("prologue04")
    REQUEST_IPL("prologue04b")
    REQUEST_IPL("prologue05")
    REQUEST_IPL("prologue05b")
    REQUEST_IPL("prologue06")
    REQUEST_IPL("prologue06b")
    REQUEST_IPL("prologue06_int")
    REQUEST_IPL("prologue06_pannel")
    REQUEST_IPL("prologuerd")
    REQUEST_IPL("prologuerdb")
    SET_MINIMAP_IN_PROLOGUE(TRUE)
ENDPROC

PROC REQUEST_CAYO_IPLS_EARLY()
    REQUEST_IPL("h4_islandairstrip")
    REQUEST_IPL("h4_islandairstrip_props")
    REQUEST_IPL("h4_islandx")
    REQUEST_IPL("h4_islandtop_lod")
    REQUEST_IPL("h4_islandx_terrain")
    REQUEST_IPL("h4_islandx_sub_dtc")
    REQUEST_IPL("h4_islandx_disc_gnd")
    REQUEST_IPL("h4_islandx_props")
    REQUEST_IPL("h4_islandxdock")
    REQUEST_IPL("h4_islandxdock_props")
    REQUEST_IPL("h4_islandx_mansion")
    REQUEST_IPL("h4_islandx_mansion_props")
    REQUEST_IPL("h4_islandx_terrain_01")
    REQUEST_IPL("h4_islandx_terrain_02")
    REQUEST_IPL("h4_islandx_terrain_03")
    REQUEST_IPL("h4_islandx_terrain_04")
    REQUEST_IPL("h4_islandx_terrain_05")
    REQUEST_IPL("h4_islandx_terrain_06")
    REQUEST_IPL("h4_beach")
    REQUEST_IPL("h4_beach_props")
    REQUEST_IPL("h4_beach_bar_props")
    REQUEST_IPL("h4_islandx_party")
    REQUEST_IPL("h4_mph4_sub_det_boats")
    REQUEST_IPL("h4_mph4_terrain_01_aec")
    REQUEST_IPL("h4_mph4_terrain_02_aec")
    REQUEST_IPL("h4_mph4_terrain_03_aec")
    REQUEST_IPL("h4_mph4_terrain_04_aec")
    REQUEST_IPL("h4_mph4_terrain_05_aec")
    REQUEST_IPL("h4_mph4_terrain_06_aec")
    REQUEST_IPL("h4_mph4_terrain_07_aec")
    REQUEST_IPL("h4_mph4_terrain_08_aec")
    REQUEST_IPL("h4_mph4_terrain_09_aec")
    REQUEST_IPL("h4_islandx_barrack_props")
    REQUEST_IPL("h4_islandx_checkpoint_props")
    REQUEST_IPL("h4_islandx_mansion_office")
    REQUEST_IPL("h4_islandx_mansion_vault")
    REMOVE_IPL("h4_islandx_barrack_props_broken")
    REMOVE_IPL("h4_islandx_checkpoint_props_broken")
    REMOVE_IPL("h4_islandx_mansion_office_broken")
    REMOVE_IPL("h4_islandx_mansion_vault_broken")
ENDPROC

FUNC BOOL PREPARE_CAYO_PERICO()
    // The stripped Switch install may not include the Heist Island pack.
    // Never enable its IPLs unless the user's installed DLC advertises it.
    IF NOT IS_DLC_PRESENT(HASH("mpheist4")) RETURN FALSE ENDIF
    REQUEST_CAYO_IPLS_EARLY()
    SET_ISLAND_ENABLED("HeistIsland", TRUE)
    SET_ALLOW_STREAM_HEIST_ISLAND_NODES(TRUE)
    SET_USE_ISLAND_MAP(TRUE)
    LOAD_GLOBAL_WATER_FILE(1)
    SET_DEEP_OCEAN_SCALER(0.0)
    RETURN TRUE
ENDFUNC

// Cayo is made up of many small IPLs. Keep the complete local set together
// so a teleport cannot leave terrain, props, or collision half-streamed. The
// clean and damaged compound states are deliberately never requested at the
// same time.
PROC REQUEST_CAYO_IPLS(BOOL load, BOOL damaged)
    STRING islandIpls[40]
    islandIpls[0] = "h4_islandairstrip"
    islandIpls[1] = "h4_islandairstrip_props"
    islandIpls[2] = "h4_islandx"
    islandIpls[3] = "h4_islandtop_lod"
    islandIpls[4] = "h4_islandx_terrain"
    islandIpls[5] = "h4_islandx_sub_dtc"
    islandIpls[6] = "h4_islandx_disc_gnd"
    islandIpls[7] = "h4_islandx_props"
    islandIpls[8] = "h4_islandxdock"
    islandIpls[9] = "h4_islandxdock_props"
    islandIpls[10] = "h4_islandx_mansion"
    islandIpls[11] = "h4_islandx_mansion_props"
    islandIpls[12] = "h4_islandx_terrain_01"
    islandIpls[13] = "h4_islandx_terrain_02"
    islandIpls[14] = "h4_islandx_terrain_03"
    islandIpls[15] = "h4_islandx_terrain_04"
    islandIpls[16] = "h4_islandx_terrain_05"
    islandIpls[17] = "h4_islandx_terrain_06"
    islandIpls[18] = "h4_beach"
    islandIpls[19] = "h4_beach_props"
    islandIpls[20] = "h4_beach_bar_props"
    islandIpls[21] = "h4_islandx_party"
    islandIpls[22] = "h4_mph4_sub_det_boats"
    islandIpls[23] = "h4_islandx_barrack_props"
    islandIpls[24] = "h4_islandx_checkpoint_props"
    islandIpls[25] = "h4_islandx_mansion_office"
    islandIpls[26] = "h4_islandx_mansion_vault"
    islandIpls[27] = "h4_islandx_barrack_props_broken"
    islandIpls[28] = "h4_islandx_checkpoint_props_broken"
    islandIpls[29] = "h4_islandx_mansion_office_broken"
    islandIpls[30] = "h4_islandx_mansion_vault_broken"
    islandIpls[31] = "h4_mph4_terrain_01_aec"
    islandIpls[32] = "h4_mph4_terrain_02_aec"
    islandIpls[33] = "h4_mph4_terrain_03_aec"
    islandIpls[34] = "h4_mph4_terrain_04_aec"
    islandIpls[35] = "h4_mph4_terrain_05_aec"
    islandIpls[36] = "h4_mph4_terrain_06_aec"
    islandIpls[37] = "h4_mph4_terrain_07_aec"
    islandIpls[38] = "h4_mph4_terrain_08_aec"
    islandIpls[39] = "h4_mph4_terrain_09_aec"
    INT i = 0
    REPEAT 40 i
        IF i < 23 OR i > 30
            IF load REQUEST_IPL(islandIpls[i]) ELSE REMOVE_IPL(islandIpls[i]) ENDIF
        ENDIF
    ENDREPEAT
    IF load
        IF damaged
            REQUEST_IPL("h4_islandx_barrack_props_broken")
            REQUEST_IPL("h4_islandx_checkpoint_props_broken")
            REQUEST_IPL("h4_islandx_mansion_office_broken")
            REQUEST_IPL("h4_islandx_mansion_vault_broken")
        ELSE
            REQUEST_IPL("h4_islandx_barrack_props")
            REQUEST_IPL("h4_islandx_checkpoint_props")
            REQUEST_IPL("h4_islandx_mansion_office")
            REQUEST_IPL("h4_islandx_mansion_vault")
        ENDIF
    ELSE
        REMOVE_IPL("h4_islandx_barrack_props")
        REMOVE_IPL("h4_islandx_checkpoint_props")
        REMOVE_IPL("h4_islandx_mansion_office")
        REMOVE_IPL("h4_islandx_mansion_vault")
        REMOVE_IPL("h4_islandx_barrack_props_broken")
        REMOVE_IPL("h4_islandx_checkpoint_props_broken")
        REMOVE_IPL("h4_islandx_mansion_office_broken")
        REMOVE_IPL("h4_islandx_mansion_vault_broken")
    ENDIF
ENDPROC

PROC TELEPORT_TO_NORTH_YANKTON()
    PREPARE_NORTH_YANKTON()
    TELEPORT_PLAYER_WITH_VEHICLE(<<5311.0, -5206.0, 83.0>>)
ENDPROC

PROC TELEPORT_TO_CAYO_PERICO()
    IF PREPARE_CAYO_PERICO()
        TELEPORT_PLAYER_WITH_VEHICLE(<<5014.21, -5134.19, 2.5>>)
    ENDIF
ENDPROC

PROC ENABLE_DLC_MAP_STREAMING()
    ON_ENTER_MP()
    REQUEST_IPL("hei_dt1_19_interior_0_heist_police_dlc_milo_")
ENDPROC

PROC PREPARE_TELEPORT_IPL(INT location)
    ENABLE_DLC_MAP_STREAMING()
    SWITCH location
        CASE 11
            // Trevor's Trailer uses a separate interior IPL from the exterior.
            REQUEST_IPL("TrevorsTrailer")
        BREAK
        CASE 14
            // Swap the Pillbox interior shell in before moving to the hospital.
            REQUEST_IPL("rc12b_hospitalinterior")
            REMOVE_IPL("rc12b_default")
        BREAK
        CASE 28
            IF IS_DLC_PRESENT(HASH("mpheist3")) REQUEST_IPL("vw_dlc_casino_door") ENDIF
        BREAK
        CASE 38
            // Salvage-yard exterior; collision streaming is enough on the
            // installed DLC set (the newer chop-shop pack is not present).
        BREAK
        CASE 39
            // Darnell Bros. exterior; no unavailable DLC IPL is requested.
        BREAK
        CASE 40
            IF IS_DLC_PRESENT(HASH("mpgunrunning"))
                REQUEST_IPL("xm_bunkerentrance_door")
                REQUEST_IPL("xm_hatches_terrain")
            ENDIF
        BREAK
        CASE 42
            // Dignity Party Yacht exterior; streamed via collision request.
        BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_IPL_PRESET(BOOL load)
    IF load
        ENABLE_DLC_MAP_STREAMING()
    ENDIF
    // These are conservative, story-mode IPL sets.  REQUEST_IPL and
    // REMOVE_IPL are idempotent, so pressing either action repeatedly is
    // harmless even when a stripped install does not contain one of them.
    IF g_ipl_preset = 0
        IF load REQUEST_IPL("TrevorsTrailer") ELSE REMOVE_IPL("TrevorsTrailer") ENDIF
    ELIF g_ipl_preset = 1
        IF load REQUEST_IPL("FIBlobby") ELSE REMOVE_IPL("FIBlobby") ENDIF
    ELIF g_ipl_preset = 2
        IF load REQUEST_IPL("FruitBB") ELSE REMOVE_IPL("FruitBB") ENDIF
    ELIF g_ipl_preset = 3
        IF load REQUEST_IPL("post_hiest_unload") ELSE REMOVE_IPL("post_hiest_unload") ENDIF
    ELIF g_ipl_preset = 4
        IF load REQUEST_IPL("farmint") ELSE REMOVE_IPL("farmint") ENDIF
    ELIF g_ipl_preset = 5
        IF load REQUEST_IPL("facelobby") ELSE REMOVE_IPL("facelobby") ENDIF
    ELIF g_ipl_preset = 6
        IF load REQUEST_IPL("Coroner_Int_on") ELSE REMOVE_IPL("Coroner_Int_on") ENDIF
    ELIF g_ipl_preset = 7
        IF load REQUEST_IPL("bh1_47_joshhse_unload") ELSE REMOVE_IPL("bh1_47_joshhse_unload") ENDIF
    ELIF g_ipl_preset = 8
        IF load REQUEST_IPL("apa_v_mp_h_01_a") ELSE REMOVE_IPL("apa_v_mp_h_01_a") ENDIF
    ELIF g_ipl_preset = 9
        IF load REQUEST_IPL("chopshop") ELSE REMOVE_IPL("chopshop") ENDIF
    ELIF g_ipl_preset = 10
        IF load REQUEST_IPL("prologue01") ELSE REMOVE_IPL("prologue01") ENDIF
    ELIF g_ipl_preset = 11
        IF load REQUEST_IPL("prologue02") ELSE REMOVE_IPL("prologue02") ENDIF
    ELIF g_ipl_preset = 12
        IF load
            PREPARE_NORTH_YANKTON()
        ELSE
            REMOVE_IPL("prologue01")
            REMOVE_IPL("prologue01c")
            REMOVE_IPL("prologue01d")
            REMOVE_IPL("prologue01e")
            REMOVE_IPL("prologue01f")
            REMOVE_IPL("prologue01g")
            REMOVE_IPL("prologue01h")
            REMOVE_IPL("prologue01i")
            REMOVE_IPL("prologue01j")
            REMOVE_IPL("prologue01k")
            REMOVE_IPL("prologue01z")
            REMOVE_IPL("prologue02")
            REMOVE_IPL("prologue03")
            REMOVE_IPL("prologue03b")
            REMOVE_IPL("prologue04")
            REMOVE_IPL("prologue04b")
            REMOVE_IPL("prologue05")
            REMOVE_IPL("prologue05b")
            REMOVE_IPL("prologue06")
            REMOVE_IPL("prologue06b")
            REMOVE_IPL("prologue06_int")
            REMOVE_IPL("prologue06_pannel")
            REMOVE_IPL("prologuerd")
            REMOVE_IPL("prologuerdb")
            SET_MINIMAP_IN_PROLOGUE(FALSE)
        ENDIF
    ELIF g_ipl_preset = 13
        IF load
            PREPARE_CAYO_PERICO()
        ELSE
            REQUEST_CAYO_IPLS(FALSE, FALSE)
            SET_ISLAND_ENABLED("HeistIsland", FALSE)
            SET_ALLOW_STREAM_HEIST_ISLAND_NODES(FALSE)
            SET_USE_ISLAND_MAP(FALSE)
            LOAD_GLOBAL_WATER_FILE(0)
            RESET_DEEP_OCEAN_SCALER()
        ENDIF
    ELIF g_ipl_preset = 22
        IF load
            IF IS_DLC_PRESENT(HASH("mpheist4"))
                REQUEST_CAYO_IPLS(TRUE, TRUE)
                SET_ISLAND_ENABLED("HeistIsland", TRUE)
                SET_ALLOW_STREAM_HEIST_ISLAND_NODES(TRUE)
                SET_USE_ISLAND_MAP(TRUE)
                LOAD_GLOBAL_WATER_FILE(1)
                SET_DEEP_OCEAN_SCALER(0.0)
            ENDIF
        ELSE
            REQUEST_CAYO_IPLS(FALSE, TRUE)
            SET_ISLAND_ENABLED("HeistIsland", FALSE)
            SET_ALLOW_STREAM_HEIST_ISLAND_NODES(FALSE)
            SET_USE_ISLAND_MAP(FALSE)
            LOAD_GLOBAL_WATER_FILE(0)
            RESET_DEEP_OCEAN_SCALER()
        ENDIF
    ELIF g_ipl_preset = 23
        IF load
            IF IS_DLC_PRESENT(HASH("mpheist3")) REQUEST_IPL("vw_dlc_casino_door") ENDIF
        ELSE
            REMOVE_IPL("vw_dlc_casino_door")
        ENDIF
    ELIF g_ipl_preset = 24
        IF load
            IF IS_DLC_PRESENT(HASH("mpgunrunning"))
                REQUEST_IPL("xm_bunkerentrance_door")
                REQUEST_IPL("xm_hatch_closed")
                REQUEST_IPL("xm_hatches_terrain")
                REQUEST_IPL("xm_siloentranceclosed_x17")
            ENDIF
        ELSE
            REMOVE_IPL("xm_bunkerentrance_door")
            REMOVE_IPL("xm_hatch_closed")
            REMOVE_IPL("xm_hatches_terrain")
            REMOVE_IPL("xm_siloentranceclosed_x17")
        ENDIF
    ELIF g_ipl_preset = 14
        IF load
            REQUEST_IPL("smboat")
            REQUEST_IPL("apa_smboat_lodlights")
            REQUEST_IPL("ba_sm_boat_window")
        ELSE
            REMOVE_IPL("smboat")
            REMOVE_IPL("apa_smboat_lodlights")
            REMOVE_IPL("ba_sm_boat_window")
        ENDIF
    ELIF g_ipl_preset = 15
        IF load
            REQUEST_IPL("hei_carrier_lodlights")
            REQUEST_IPL("hei_carrier")
            REQUEST_IPL("hei_carrier_int1")
            REQUEST_IPL("hei_carrier_int2")
            REQUEST_IPL("hei_carrier_int3")
            REQUEST_IPL("hei_carrier_int4")
            REQUEST_IPL("hei_carrier_int5")
            REQUEST_IPL("hei_carrier_int6")
        ELSE
            REMOVE_IPL("hei_carrier_lodlights")
            REMOVE_IPL("hei_carrier")
            REMOVE_IPL("hei_carrier_int1")
            REMOVE_IPL("hei_carrier_int2")
            REMOVE_IPL("hei_carrier_int3")
            REMOVE_IPL("hei_carrier_int4")
            REMOVE_IPL("hei_carrier_int5")
            REMOVE_IPL("hei_carrier_int6")
        ENDIF
    ELIF g_ipl_preset = 16
        IF load
            REQUEST_IPL("sunk_ship_fire")
            REQUEST_IPL("sunkcargoship")
            REMOVE_IPL("cargoship")
        ELSE
            REMOVE_IPL("sunk_ship_fire")
            REMOVE_IPL("sunkcargoship")
            REQUEST_IPL("cargoship")
        ENDIF
    ELIF g_ipl_preset = 17
        IF load
            REQUEST_IPL("rc12b_hospitalinterior")
            REMOVE_IPL("rc12b_default")
        ELSE
            REMOVE_IPL("rc12b_hospitalinterior")
            REQUEST_IPL("rc12b_default")
        ENDIF
    ELIF g_ipl_preset = 18
        IF load
            REQUEST_IPL("farm_burnt")
            REQUEST_IPL("farm_burnt_props")
        ELSE
            REMOVE_IPL("farm_burnt")
            REMOVE_IPL("farm_burnt_props")
        ENDIF
    ELIF g_ipl_preset = 19
        IF load
            REQUEST_IPL("facelobby")
            REQUEST_IPL("facelobbyfake")
        ELSE
            REMOVE_IPL("facelobby")
            REMOVE_IPL("facelobbyfake")
        ENDIF
    ELIF g_ipl_preset = 20
        IF load
            REQUEST_IPL("post_hiest_unload")
            REQUEST_IPL("jewel2fake")
            REQUEST_IPL("bh1_16_refurb")
        ELSE
            REMOVE_IPL("post_hiest_unload")
            REMOVE_IPL("jewel2fake")
            REMOVE_IPL("bh1_16_refurb")
        ENDIF
    ELIF g_ipl_preset = 21
        IF load
            REQUEST_IPL("coroner_int_on")
            REQUEST_IPL("coronertrash")
            REMOVE_IPL("coroner_int_off")
        ELSE
            REMOVE_IPL("coroner_int_on")
            REMOVE_IPL("coronertrash")
            REQUEST_IPL("coroner_int_off")
        ENDIF
    ELIF g_ipl_preset = 25
        IF load
            ENABLE_DLC_MAP_STREAMING()
            REQUEST_IPL("hei_dt1_19_interior_0_heist_police_dlc_milo_")
        ELSE
            REMOVE_IPL("hei_dt1_19_interior_0_heist_police_dlc_milo_")
        ENDIF
    ENDIF
ENDPROC

PROC LOAD_CUSTOM_IPL()
    IF NOT IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name)
        ENABLE_DLC_MAP_STREAMING()
        REQUEST_IPL(g_custom_ipl_name)
    ENDIF
ENDPROC

PROC UNLOAD_CUSTOM_IPL()
    IF NOT IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name)
        REMOVE_IPL(g_custom_ipl_name)
    ENDIF
ENDPROC

PROC APPLY_TIME_CHOICE()
    SWITCH g_time_choice
        CASE 0 SET_CLOCK_TIME(6, 0, 0) BREAK
        CASE 1 SET_CLOCK_TIME(12, 0, 0) BREAK
        CASE 2 SET_CLOCK_TIME(18, 0, 0) BREAK
        CASE 3 SET_CLOCK_TIME(0, 0, 0) BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_TIME_SCALE()
    FLOAT scale = 1.0
    IF g_time_scale_level = 0 scale = 0.0 ENDIF
    IF g_time_scale_level = 1 scale = 0.25 ENDIF
    IF g_time_scale_level = 2 scale = 0.5 ENDIF
    IF g_time_scale_level = 3 scale = 0.75 ENDIF
    IF g_time_scale_level = 4 scale = 1.0 ENDIF
    IF g_time_scale_level = 5 scale = 1.25 ENDIF
    IF g_time_scale_level = 6 scale = 1.5 ENDIF
    IF g_time_scale_level = 7 scale = 1.75 ENDIF
    IF g_time_scale_level = 8 scale = 2.0 ENDIF
    IF g_time_scale_level >= 9 scale = TO_FLOAT(g_time_scale_level) * 0.25 ENDIF
    SET_TIME_SCALE(scale)
ENDPROC

PROC APPLY_GRAVITY_CHOICE()
    IF g_gravity_choice = 1 SET_GRAVITY_LEVEL(GRAV_MOON) ENDIF
    IF g_gravity_choice = 2 SET_GRAVITY_LEVEL(GRAV_LOW) ENDIF
    IF g_gravity_choice = 3 SET_GRAVITY_LEVEL(GRAV_ZERO) ENDIF
    IF g_gravity_choice = 0 SET_GRAVITY_LEVEL(GRAV_EARTH) ENDIF
ENDPROC

PROC APPLY_EDITABLE_TIME()
    IF g_pause_time
        g_pause_time = FALSE
        PAUSE_CLOCK(FALSE)
    ENDIF
    SET_CLOCK_TIME(g_time_hour, g_time_minute, g_time_second)
ENDPROC

PROC APPLY_WEATHER_CHOICE()
    SWITCH g_weather_choice
        CASE 0 SET_WEATHER_TYPE_NOW_PERSIST("EXTRASUNNY") BREAK
        CASE 1 SET_WEATHER_TYPE_NOW_PERSIST("CLEAR") BREAK
        CASE 2 SET_WEATHER_TYPE_NOW_PERSIST("CLOUDS") BREAK
        CASE 3 SET_WEATHER_TYPE_NOW_PERSIST("OVERCAST") BREAK
        CASE 4 SET_WEATHER_TYPE_NOW_PERSIST("RAIN") BREAK
        CASE 5 SET_WEATHER_TYPE_NOW_PERSIST("THUNDER") BREAK
        CASE 6 SET_WEATHER_TYPE_NOW_PERSIST("CLEARING") BREAK
        CASE 7 SET_WEATHER_TYPE_NOW_PERSIST("SMOG") BREAK
        CASE 8 SET_WEATHER_TYPE_NOW_PERSIST("FOGGY") BREAK
        CASE 9 SET_WEATHER_TYPE_NOW_PERSIST("XMAS") BREAK
        CASE 10 SET_WEATHER_TYPE_NOW_PERSIST("SNOW") BREAK
        CASE 11 SET_WEATHER_TYPE_NOW_PERSIST("SNOWLIGHT") BREAK
        CASE 12 SET_WEATHER_TYPE_NOW_PERSIST("BLIZZARD") BREAK
        CASE 13 SET_WEATHER_TYPE_NOW_PERSIST("HALLOWEEN") BREAK
        CASE 14 SET_WEATHER_TYPE_NOW_PERSIST("NEUTRAL") BREAK
        CASE 15 SET_WEATHER_TYPE_NOW_PERSIST("RAIN_HALLOWEEN") BREAK
        CASE 16 SET_WEATHER_TYPE_NOW_PERSIST("SNOW_HALLOWEEN") BREAK
    ENDSWITCH
ENDPROC

PROC DISABLE_PORTABLE_RADIO()
    g_mobile_radio = FALSE
    SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(FALSE)
    SET_MOBILE_PHONE_RADIO_STATE(FALSE)
    SET_USER_RADIO_CONTROL_ENABLED(FALSE)
ENDPROC

FUNC STRING GET_FALLBACK_RADIO_STATION_CODE(INT index)
    SWITCH index
        CASE 0 RETURN "RADIO_01_CLASS_ROCK" BREAK
        CASE 1 RETURN "RADIO_02_POP" BREAK
        CASE 2 RETURN "RADIO_03_HIPHOP_NEW" BREAK
        CASE 3 RETURN "RADIO_04_PUNK" BREAK
        CASE 4 RETURN "RADIO_05_TALK_01" BREAK
        CASE 5 RETURN "RADIO_06_COUNTRY" BREAK
        CASE 6 RETURN "RADIO_07_DANCE_01" BREAK
        CASE 7 RETURN "RADIO_08_MEXICAN" BREAK
        CASE 8 RETURN "RADIO_09_HIPHOP_OLD" BREAK
        CASE 9 RETURN "RADIO_11_TALK_02" BREAK
        CASE 10 RETURN "RADIO_12_REGGAE" BREAK
        CASE 11 RETURN "RADIO_13_JAZZ" BREAK
        CASE 12 RETURN "RADIO_14_DANCE_02" BREAK
        CASE 13 RETURN "RADIO_15_MOTOWN" BREAK
        CASE 14 RETURN "RADIO_16_SILVERLAKE" BREAK
        CASE 15 RETURN "RADIO_17_FUNK" BREAK
        CASE 16 RETURN "RADIO_18_90s_ROCK" BREAK
        CASE 17 RETURN "RADIO_20_THELAB" BREAK
        CASE 18 RETURN "RADIO_21_DLC_XM17" BREAK
        CASE 19 RETURN "RADIO_22_DLC_BATTLE_MIX1_RADIO" BREAK
        CASE 20 RETURN "RADIO_23_DLC_XM19_RADIO" BREAK
        CASE 21 RETURN "RADIO_27_DLC_PRHEI4" BREAK
        CASE 22 RETURN "RADIO_34_DLC_HEI4_KULT" BREAK
        CASE 23 RETURN "RADIO_35_DLC_HEI4_MLR" BREAK
        CASE 24 RETURN "RADIO_36_AUDIOPLAYER" BREAK
        CASE 25 RETURN "RADIO_37_MOTOMAMI" BREAK
    ENDSWITCH
    RETURN "RADIO_01_CLASS_ROCK"
ENDFUNC

FUNC BOOL IS_RADIO_STATION_ALLOWED(STRING code)
    IF IS_STRING_NULL_OR_EMPTY(code)
        RETURN FALSE
    ENDIF
    IF ARE_STRINGS_EQUAL(code, "RADIO_19_USER")
        RETURN FALSE
    ENDIF
    IF ARE_STRINGS_EQUAL(code, "OFF") OR ARE_STRINGS_EQUAL(code, "RADIO_OFF")
        RETURN FALSE
    ENDIF
    RETURN TRUE
ENDFUNC

FUNC INT GET_AVAILABLE_RADIO_STATION_COUNT()
    INT numUnlocked = GET_NUM_UNLOCKED_RADIO_STATIONS()
    IF numUnlocked <= 0
        RETURN 26
    ENDIF
    INT count = 0
    INT i = 0
    WHILE i < numUnlocked
        IF IS_RADIO_STATION_ALLOWED(GET_RADIO_STATION_NAME(i))
            count = count + 1
        ENDIF
        i = i + 1
    ENDWHILE
    IF count <= 0
        RETURN 26
    ENDIF
    RETURN count
ENDFUNC

FUNC INT RADIO_STATION_WHEEL_INDEX(INT logicalIndex)
    INT numUnlocked = GET_NUM_UNLOCKED_RADIO_STATIONS()
    IF numUnlocked <= 0
        RETURN logicalIndex
    ENDIF
    INT validIdx = 0
    INT i = 0
    WHILE i < numUnlocked
        IF IS_RADIO_STATION_ALLOWED(GET_RADIO_STATION_NAME(i))
            IF validIdx = logicalIndex
                RETURN i
            ENDIF
            validIdx = validIdx + 1
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN 0
ENDFUNC

FUNC STRING RADIO_STATION_CODE(INT logicalIndex)
    INT numUnlocked = GET_NUM_UNLOCKED_RADIO_STATIONS()
    IF numUnlocked <= 0
        RETURN GET_FALLBACK_RADIO_STATION_CODE(logicalIndex)
    ENDIF
    INT wheelIdx = RADIO_STATION_WHEEL_INDEX(logicalIndex)
    STRING stationCode = GET_RADIO_STATION_NAME(wheelIdx)
    IF NOT IS_RADIO_STATION_ALLOWED(stationCode)
        RETURN GET_FALLBACK_RADIO_STATION_CODE(logicalIndex)
    ENDIF
    RETURN stationCode
ENDFUNC

FUNC STRING RADIO_STATION_NAME(INT index)
    STRING code = RADIO_STATION_CODE(index)
    IF ARE_STRINGS_EQUAL(code, "RADIO_01_CLASS_ROCK")
        RETURN "Los Santos Rock"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_02_POP")
        RETURN "Non-Stop-Pop FM"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_03_HIPHOP_NEW")
        RETURN "Radio Los Santos"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_04_PUNK")
        RETURN "Channel X"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_05_TALK_01")
        RETURN "West Coast Talk"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_06_COUNTRY")
        RETURN "Rebel Radio"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_07_DANCE_01")
        RETURN "Soulwax FM"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_08_MEXICAN")
        RETURN "East Los FM"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_09_HIPHOP_OLD")
        RETURN "West Coast Classics"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_11_TALK_02")
        RETURN "Blaine County Radio"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_12_REGGAE")
        RETURN "Blue Ark"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_13_JAZZ")
        RETURN "Worldwide FM"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_14_DANCE_02")
        RETURN "FlyLo FM"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_15_MOTOWN")
        RETURN "The Lowdown 91.1"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_16_SILVERLAKE")
        RETURN "Radio Mirror Park"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_17_FUNK")
        RETURN "Space 103.2"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_18_90s_ROCK") OR ARE_STRINGS_EQUAL(code, "RADIO_18_90S_ROCK")
        RETURN "Vinewood Boulevard"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_20_THELAB")
        RETURN "The Lab"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_21_DLC_XM17")
        RETURN "Blonded Los Santos"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_22_DLC_BATTLE_MIX1_RADIO") OR ARE_STRINGS_EQUAL(code, "RADIO_22_DLC_BATTLE_MIX1")
        RETURN "LS Underground"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_23_DLC_XM19_RADIO")
        RETURN "iFruit Radio"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_27_DLC_PRHEI4") OR ARE_STRINGS_EQUAL(code, "RADIO_27_DLC_PRI_HEIST")
        RETURN "Still Slipping"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_34_DLC_HEI4_KULT")
        RETURN "KULT FM 99.1"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_35_DLC_HEI4_MLR")
        RETURN "The Music Locker"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_36_AUDIOPLAYER")
        RETURN "Media Player"
    ELIF ARE_STRINGS_EQUAL(code, "RADIO_37_MOTOMAMI") OR ARE_STRINGS_EQUAL(code, "RADIO_36_MOTOMAMI")
        RETURN "MOTOMAMI"
    ENDIF
    RETURN code
ENDFUNC

FUNC INT GET_PREV_RADIO_STATION_INDEX(INT curIndex)
    INT count = GET_AVAILABLE_RADIO_STATION_COUNT()
    IF count <= 1
        RETURN 0
    ENDIF
    IF curIndex <= 0
        RETURN count - 1
    ENDIF
    IF curIndex >= count
        RETURN count - 1
    ENDIF
    RETURN curIndex - 1
ENDFUNC

FUNC INT GET_NEXT_RADIO_STATION_INDEX(INT curIndex)
    INT count = GET_AVAILABLE_RADIO_STATION_COUNT()
    IF count <= 1
        RETURN 0
    ENDIF
    IF curIndex >= (count - 1)
        RETURN 0
    ENDIF
    IF curIndex < 0
        RETURN 0
    ENDIF
    RETURN curIndex + 1
ENDFUNC

PROC SYNC_RADIO_STATION_INDEX()
    INT count = GET_AVAILABLE_RADIO_STATION_COUNT()
    IF count <= 0
        EXIT
    ENDIF

    TEXT_LABEL_63 curStation = GET_PLAYER_RADIO_STATION_NAME()
    IF NOT IS_STRING_NULL_OR_EMPTY(curStation) AND IS_RADIO_STATION_ALLOWED(curStation)
        INT i = 0
        WHILE i < count
            IF ARE_STRINGS_EQUAL(curStation, RADIO_STATION_CODE(i))
                g_radio_station_index = i
                EXIT
            ENDIF
            i = i + 1
        ENDWHILE
    ENDIF

    // Safety clamp to active wheel bounds:
    IF g_radio_station_index >= count
        g_radio_station_index = 0
    ENDIF
    IF g_radio_station_index < 0
        g_radio_station_index = 0
    ENDIF
ENDPROC
// ---------------------------------------------------------------------------
// "Open Closest Door" (World and Weather tab).
//
// There is no nearest-door native.  The whole door API takes a MODEL plus a
// POSITION, so finding the closest door means probing every candidate model in
// util_door_catalog.sch with its own spatial query and keeping the nearest hit.
// That is far too much work for one frame, so the scan is staged across frames
// from the main loop and always terminates: g_door_scan_index only ever moves
// towards DOOR_MODEL_COUNT(), and DOOR_SCAN_PER_FRAME models are probed per tick.
// ---------------------------------------------------------------------------

PROC PROBE_DOOR_MODEL(INT modelIndex, VECTOR searchCoords)
    MODEL_NAMES doorModel = DOOR_MODEL_FOR_CHOICE(modelIndex)
    VECTOR foundCoords = <<0.0, 0.0, 0.0>>
    VECTOR foundRotation = <<0.0, 0.0, 0.0>>
    FLOAT distance = 0.0
    // The native returns the closest instance of this model inside the sphere,
    // which is what gives a real distance rather than a first-match result.
    IF NOT GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE(searchCoords, DOOR_SEARCH_RADIUS, doorModel, foundCoords, foundRotation)
        EXIT
    ENDIF
    distance = GET_DISTANCE_BETWEEN_COORDS(searchCoords, foundCoords, TRUE)
    IF distance < g_door_candidate_distance
        g_door_candidate_distance = distance
        g_door_candidate_model_index = modelIndex
        g_door_candidate_coords = foundCoords
    ENDIF
ENDPROC

// Arms a fresh scan.  Called on every press so the probe always starts from
// where the player is standing right now and a previous result cannot leak.
// mode: 0 = Open Closest Door, 1 = Close Closest Door.
PROC START_DOOR_SCAN(INT mode)
    g_door_scan_active = TRUE
    g_door_scan_mode = mode
    g_door_scan_index = 0
    g_door_candidate_model_index = -1
    g_door_candidate_distance = 9999.0
    g_door_feedback = 0
    g_door_feedback_until = 0
ENDPROC

FUNC BOOL OPEN_DOOR_AT_COORDS(MODEL_NAMES doorModel, VECTOR doorCoords)
    BOOL readLockState = FALSE
    FLOAT readOpenRatio = 0.0
    INT doorHash = 0

    // bLockState FALSE is a release, never a lock, so this call can only open a
    // door or leave it exactly as it was - it can never leave one stuck shut.
    // bRemoveSpring TRUE drops the return spring so the door stays open instead
    // of swinging closed again the moment the player steps away.
    SET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, FALSE, 1.0, TRUE)

    // Doors owned by the door system (most map doors and every script/mission
    // door) ignore the call above and need the door-system ratio pushed as well.
    IF DOOR_SYSTEM_FIND_EXISTING_DOOR(doorCoords, doorModel, doorHash)
        DOOR_SYSTEM_SET_DOOR_STATE(doorHash, DOORSTATE_FORCE_UNLOCKED_THIS_FRAME, TRUE, TRUE)
        DOOR_SYSTEM_SET_OPEN_RATIO(doorHash, 1.0, TRUE, TRUE)
        DOOR_SYSTEM_SET_HOLD_OPEN(doorHash, TRUE)
        DOOR_SYSTEM_SET_SPRING_REMOVED(doorHash, TRUE, TRUE, TRUE)
    ENDIF

    // Verified readback rather than an assumption: success is reported only when
    // the door actually reads as open.
    GET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, readLockState, readOpenRatio)
    IF readOpenRatio > 0.5 OR readOpenRatio < -0.5
        RETURN TRUE
    ENDIF
    IF DOOR_SYSTEM_FIND_EXISTING_DOOR(doorCoords, doorModel, doorHash)
        readOpenRatio = DOOR_SYSTEM_GET_OPEN_RATIO(doorHash)
        IF readOpenRatio > 0.5 OR readOpenRatio < -0.5
            RETURN TRUE
        ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

FUNC BOOL CLOSE_DOOR_AT_COORDS(MODEL_NAMES doorModel, VECTOR doorCoords)
    BOOL readLockState = FALSE
    FLOAT readOpenRatio = 1.0
    INT doorHash = 0

    // Snap the door shut to ratio 0.0, then release the hard lock with its
    // return spring restored so the door stays closed naturally.
    SET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, TRUE, 0.0, FALSE)
    SET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, FALSE, 0.0, FALSE)

    IF DOOR_SYSTEM_FIND_EXISTING_DOOR(doorCoords, doorModel, doorHash)
        DOOR_SYSTEM_SET_HOLD_OPEN(doorHash, FALSE)
        DOOR_SYSTEM_SET_SPRING_REMOVED(doorHash, FALSE, TRUE, TRUE)
        DOOR_SYSTEM_SET_OPEN_RATIO(doorHash, 0.0, TRUE, TRUE)
        DOOR_SYSTEM_SET_DOOR_STATE(doorHash, DOORSTATE_FORCE_CLOSED_THIS_FRAME, TRUE, TRUE)
    ENDIF

    GET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, readLockState, readOpenRatio)
    IF readOpenRatio > -0.25 AND readOpenRatio < 0.25
        RETURN TRUE
    ENDIF
    IF DOOR_SYSTEM_FIND_EXISTING_DOOR(doorCoords, doorModel, doorHash)
        readOpenRatio = DOOR_SYSTEM_GET_OPEN_RATIO(doorHash)
        IF readOpenRatio > -0.25 AND readOpenRatio < 0.25
            RETURN TRUE
        ENDIF
    ENDIF
    RETURN FALSE
ENDFUNC

PROC FINISH_DOOR_SCAN()
    g_door_scan_active = FALSE
    IF g_door_candidate_model_index < 0
        g_door_feedback = 1
    ELIF g_door_scan_mode = 1
        IF CLOSE_DOOR_AT_COORDS(DOOR_MODEL_FOR_CHOICE(g_door_candidate_model_index), g_door_candidate_coords)
            g_door_feedback = 2
        ELSE
            g_door_feedback = 3
        ENDIF
    ELSE
        IF OPEN_DOOR_AT_COORDS(DOOR_MODEL_FOR_CHOICE(g_door_candidate_model_index), g_door_candidate_coords)
            g_door_feedback = 2
        ELSE
            g_door_feedback = 3
        ENDIF
    ENDIF
    // The window is measured from result time, not press time, so the message is
    // always readable for its full duration even though the scan took a moment.
    g_door_feedback_until = GET_GAME_TIMER() + DOOR_FEEDBACK_MS
ENDPROC

// Called from the main loop every frame, including while the menu is closed, so
// a scan started from the menu always completes and always clears its own state.
PROC PROCESS_DOOR_SCAN()
    INT probes = 0
    VECTOR searchCoords = <<0.0, 0.0, 0.0>>
    IF NOT g_door_scan_active EXIT ENDIF
    searchCoords = GET_ENTITY_COORDS(PLAYER_PED_ID())
    WHILE g_door_scan_index < DOOR_MODEL_COUNT() AND probes < DOOR_SCAN_PER_FRAME
        PROBE_DOOR_MODEL(g_door_scan_index, searchCoords)
        g_door_scan_index = g_door_scan_index + 1
        probes = probes + 1
    ENDWHILE
    IF g_door_scan_index >= DOOR_MODEL_COUNT() FINISH_DOOR_SCAN() ENDIF
ENDPROC

// ---------------------------------------------------------------------------
// "Touch Opens Doors" (World and Weather tab).
//
// Two-tier design so touching a door, gate, barrier, garage or interior door
// opens it on the exact frame of physical contact without scanning all 746
// models in a single frame:
//   1. A rolling background radar sweeps TOUCH_DOOR_SCAN_PER_FRAME models per
//      frame within TOUCH_DOOR_RADAR_RADIUS (15m) and maintains a 4-slot cache
//      of the closest doors near the player before the player reaches them.
//   2. Every frame, each cached nearby door is tested for physical contact
//      using both IS_ENTITY_TOUCHING_MODEL and an exact 3D oriented bounding
//      box (OBB) surface check from GET_MODEL_DIMENSIONS + door heading.
// ---------------------------------------------------------------------------

PROC RESET_TOUCH_DOOR_CACHE()
    INT slot = 0
    WHILE slot < TOUCH_DOOR_CACHE_SLOTS
        g_touch_door_models[slot] = -1
        g_touch_door_coords[slot] = <<0.0, 0.0, 0.0>>
        slot = slot + 1
    ENDWHILE
    g_touch_door_cache_seeded = TRUE
ENDPROC

PROC CACHE_NEARBY_TOUCH_DOOR(INT modelIndex, VECTOR doorCoords, VECTOR playerCoords)
    INT slot = 0
    INT replaceSlot = -1
    FLOAT farthestDist = -1.0
    FLOAT slotDist = 0.0
    FLOAT newDist = GET_DISTANCE_BETWEEN_COORDS(playerCoords, doorCoords, TRUE)

    WHILE slot < TOUCH_DOOR_CACHE_SLOTS
        IF g_touch_door_models[slot] = modelIndex
            g_touch_door_coords[slot] = doorCoords
            EXIT
        ENDIF
        slot = slot + 1
    ENDWHILE

    slot = 0
    WHILE slot < TOUCH_DOOR_CACHE_SLOTS
        IF g_touch_door_models[slot] < 0
            g_touch_door_models[slot] = modelIndex
            g_touch_door_coords[slot] = doorCoords
            EXIT
        ENDIF
        slotDist = GET_DISTANCE_BETWEEN_COORDS(playerCoords, g_touch_door_coords[slot], TRUE)
        IF slotDist > farthestDist
            farthestDist = slotDist
            replaceSlot = slot
        ENDIF
        slot = slot + 1
    ENDWHILE

    IF replaceSlot >= 0 AND newDist < farthestDist
        g_touch_door_models[replaceSlot] = modelIndex
        g_touch_door_coords[replaceSlot] = doorCoords
    ENDIF
ENDPROC

FUNC BOOL IS_POINT_TOUCHING_DOOR_BOUNDS(VECTOR testPoint, MODEL_NAMES doorModel, VECTOR doorCoords, FLOAT doorHeading, FLOAT padXY)
    VECTOR minDim = <<0.0, 0.0, 0.0>>
    VECTOR maxDim = <<0.0, 0.0, 0.0>>
    FLOAT dx = testPoint.x - doorCoords.x
    FLOAT dy = testPoint.y - doorCoords.y
    FLOAT dz = testPoint.z - doorCoords.z
    FLOAT cosH = COS(doorHeading)
    FLOAT sinH = SIN(doorHeading)
    FLOAT localX = (dx * cosH) + (dy * sinH)
    FLOAT localY = (dy * cosH) - (dx * sinH)

    IF GET_DISTANCE_BETWEEN_COORDS(testPoint, doorCoords, TRUE) <= 1.20
        RETURN TRUE
    ENDIF

    GET_MODEL_DIMENSIONS(doorModel, minDim, maxDim)
    IF localX < (minDim.x - padXY) OR localX > (maxDim.x + padXY)
        RETURN FALSE
    ENDIF
    IF localY < (minDim.y - padXY) OR localY > (maxDim.y + padXY)
        RETURN FALSE
    ENDIF
    IF dz < (minDim.z - 1.15) OR dz > (maxDim.z + 1.05)
        RETURN FALSE
    ENDIF
    RETURN TRUE
ENDFUNC

FUNC BOOL IS_PLAYER_TOUCHING_DOOR(PED_INDEX playerPed, MODEL_NAMES doorModel, VECTOR doorCoords, FLOAT doorHeading)
    VEHICLE_INDEX playerVeh = NULL
    VECTOR playerCoords = GET_ENTITY_COORDS(playerPed)
    VECTOR vehMin = <<0.0, 0.0, 0.0>>
    VECTOR vehMax = <<0.0, 0.0, 0.0>>
    VECTOR frontPoint = <<0.0, 0.0, 0.0>>
    VECTOR rearPoint = <<0.0, 0.0, 0.0>>

    SET_ENTITY_RECORDS_COLLISIONS(playerPed, TRUE)
    IF IS_ENTITY_TOUCHING_MODEL(playerPed, doorModel)
        RETURN TRUE
    ENDIF

    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        playerVeh = GET_VEHICLE_PED_IS_IN(playerPed)
        IF DOES_ENTITY_EXIST(playerVeh) AND NOT IS_ENTITY_DEAD(playerVeh)
            SET_ENTITY_RECORDS_COLLISIONS(playerVeh, TRUE)
            IF IS_ENTITY_TOUCHING_MODEL(playerVeh, doorModel)
                RETURN TRUE
            ENDIF
            GET_MODEL_DIMENSIONS(GET_ENTITY_MODEL(playerVeh), vehMin, vehMax)
            frontPoint = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerVeh, <<0.0, vehMax.y, 0.0>>)
            rearPoint = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerVeh, <<0.0, vehMin.y, 0.0>>)
            IF IS_POINT_TOUCHING_DOOR_BOUNDS(frontPoint, doorModel, doorCoords, doorHeading, 0.78)
                RETURN TRUE
            ENDIF
            IF IS_POINT_TOUCHING_DOOR_BOUNDS(rearPoint, doorModel, doorCoords, doorHeading, 0.78)
                RETURN TRUE
            ENDIF
            IF IS_POINT_TOUCHING_DOOR_BOUNDS(GET_ENTITY_COORDS(playerVeh), doorModel, doorCoords, doorHeading, 0.90)
                RETURN TRUE
            ENDIF
        ENDIF
    ENDIF

    RETURN IS_POINT_TOUCHING_DOOR_BOUNDS(playerCoords, doorModel, doorCoords, doorHeading, 0.65)
ENDFUNC

PROC OPEN_TOUCHED_DOOR_AND_TWIN(MODEL_NAMES doorModel, VECTOR doorCoords)
    INT otherSlot = 0
    MODEL_NAMES otherModel = DUMMY_MODEL_FOR_SCRIPT
    OPEN_DOOR_AT_COORDS(doorModel, doorCoords)
    WHILE otherSlot < TOUCH_DOOR_CACHE_SLOTS
        IF g_touch_door_models[otherSlot] >= 0
            IF GET_DISTANCE_BETWEEN_COORDS(doorCoords, g_touch_door_coords[otherSlot], TRUE) <= 3.20
                otherModel = DOOR_MODEL_FOR_CHOICE(g_touch_door_models[otherSlot])
                OPEN_DOOR_AT_COORDS(otherModel, g_touch_door_coords[otherSlot])
            ENDIF
        ENDIF
        otherSlot = otherSlot + 1
    ENDWHILE
ENDPROC

PROC PROCESS_TOUCH_OPENS_DOORS()
    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR playerCoords = <<0.0, 0.0, 0.0>>
    VECTOR foundCoords = <<0.0, 0.0, 0.0>>
    VECTOR foundRot = <<0.0, 0.0, 0.0>>
    MODEL_NAMES doorModel = DUMMY_MODEL_FOR_SCRIPT
    INT probes = 0
    INT slot = 0

    IF NOT g_touch_opens_doors
        IF g_touch_door_cache_seeded
            IF DOES_ENTITY_EXIST(playerPed)
                SET_ENTITY_RECORDS_COLLISIONS(playerPed, FALSE)
            ENDIF
            RESET_TOUCH_DOOR_CACHE()
            g_touch_door_cache_seeded = FALSE
        ENDIF
        EXIT
    ENDIF

    // Pause during "Casing the Jewel Store" (jewelry_setup1) because both Vangelico's
    // front door (P_JEWEL_DOOR_L) and Lester's Sweatshop office door (v_ilev_ss_door02)
    // are driven by PLAY_SYNCHRONIZED_MAP_ENTITY_ANIM / synchronized scenes.
    IF GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(HASH("jewelry_setup1")) > 0
        EXIT
    ENDIF

    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed)
        EXIT
    ENDIF

    IF NOT g_touch_door_cache_seeded
        RESET_TOUCH_DOOR_CACHE()
    ENDIF

    playerCoords = GET_ENTITY_COORDS(playerPed)

    // 1. Background proximity radar: sweep TOUCH_DOOR_SCAN_PER_FRAME models per
    //    frame so any door within 15m is cached before the player reaches it.
    WHILE probes < TOUCH_DOOR_SCAN_PER_FRAME
        IF g_touch_door_scan_index >= DOOR_MODEL_COUNT()
            g_touch_door_scan_index = 0
        ENDIF
        doorModel = DOOR_MODEL_FOR_CHOICE(g_touch_door_scan_index)
        IF GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE(playerCoords, TOUCH_DOOR_RADAR_RADIUS, doorModel, foundCoords, foundRot)
            CACHE_NEARBY_TOUCH_DOOR(g_touch_door_scan_index, foundCoords, playerCoords)
            IF IS_PLAYER_TOUCHING_DOOR(playerPed, doorModel, foundCoords, foundRot.z)
                OPEN_TOUCHED_DOOR_AND_TWIN(doorModel, foundCoords)
            ENDIF
        ENDIF
        g_touch_door_scan_index = g_touch_door_scan_index + 1
        probes = probes + 1
    ENDWHILE

    // 2. Every-frame instant contact check on all cached nearby doors (0ms delay).
    slot = 0
    WHILE slot < TOUCH_DOOR_CACHE_SLOTS
        IF g_touch_door_models[slot] >= 0
            doorModel = DOOR_MODEL_FOR_CHOICE(g_touch_door_models[slot])
            IF GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE(playerCoords, TOUCH_DOOR_RADAR_RADIUS + 2.0, doorModel, foundCoords, foundRot)
                g_touch_door_coords[slot] = foundCoords
                IF IS_PLAYER_TOUCHING_DOOR(playerPed, doorModel, foundCoords, foundRot.z)
                    OPEN_TOUCHED_DOOR_AND_TWIN(doorModel, foundCoords)
                ENDIF
            ELSE
                g_touch_door_models[slot] = -1
            ENDIF
        ENDIF
        slot = slot + 1
    ENDWHILE
ENDPROC

// ---------------------------------------------------------------------------
// World Mayhem submenu (World and Weather tab row 16).
// ---------------------------------------------------------------------------

PROC APPLY_BLACKOUT_STATE()
    SET_ARTIFICIAL_LIGHTS_STATE(g_blackout)
ENDPROC

PROC STOP_ARMED_PED_RIOT()
    PED_INDEX nearbyPeds[32]
    INT nearbyCount = GET_PED_NEARBY_PEDS(PLAYER_PED_ID(), nearbyPeds, PEDTYPE_INVALID)
    INT index = 0
    IF nearbyCount > COUNT_OF(nearbyPeds)
        nearbyCount = COUNT_OF(nearbyPeds)
    ENDIF
    WHILE index < nearbyCount
        IF DOES_ENTITY_EXIST(nearbyPeds[index]) AND nearbyPeds[index] != PLAYER_PED_ID() AND nearbyPeds[index] != g_chauffeur_driver AND NOT IS_PED_A_PLAYER(nearbyPeds[index]) AND NOT IS_PED_IN_GROUP(nearbyPeds[index]) AND GET_PED_RELATIONSHIP_GROUP_HASH(nearbyPeds[index]) != RELGROUPHASH_PLAYER
            CLEAR_PED_TASKS(nearbyPeds[index])
            SET_PED_KEEP_TASK(nearbyPeds[index], FALSE)
            SET_PED_AS_ENEMY(nearbyPeds[index], FALSE)
            SET_PED_COMBAT_ATTRIBUTES(nearbyPeds[index], CA_ALWAYS_FIGHT, FALSE)
        ENDIF
        index = index + 1
    ENDWHILE
ENDPROC

PROC RUN_ARMED_PED_RIOT_TICK(PED_INDEX playerPed)
    PED_INDEX nearbyPeds[32]
    INT nearbyCount = GET_PED_NEARBY_PEDS(playerPed, nearbyPeds, PEDTYPE_INVALID)
    INT index = 0
    PED_INDEX riotPed = NULL
    PED_INDEX otherPed = NULL
    WEAPON_TYPE riotWeapon = WEAPONTYPE_MICROSMG
    INT weaponRoll = 0
    IF nearbyCount > COUNT_OF(nearbyPeds)
        nearbyCount = COUNT_OF(nearbyPeds)
    ENDIF
    WHILE index < nearbyCount
        riotPed = nearbyPeds[index]
        IF DOES_ENTITY_EXIST(riotPed) AND riotPed != playerPed AND riotPed != g_chauffeur_driver AND NOT IS_PED_INJURED(riotPed) AND NOT IS_PED_A_PLAYER(riotPed) AND NOT IS_PED_IN_GROUP(riotPed) AND GET_PED_RELATIONSHIP_GROUP_HASH(riotPed) != RELGROUPHASH_PLAYER
            weaponRoll = GET_RANDOM_INT_IN_RANGE(0, 5)
            IF weaponRoll = 0 riotWeapon = WEAPONTYPE_MICROSMG ENDIF
            IF weaponRoll = 1 riotWeapon = WEAPONTYPE_ASSAULTRIFLE ENDIF
            IF weaponRoll = 2 riotWeapon = WEAPONTYPE_PUMPSHOTGUN ENDIF
            IF weaponRoll = 3 riotWeapon = WEAPONTYPE_PISTOL ENDIF
            IF weaponRoll = 4 riotWeapon = WEAPONTYPE_CARBINERIFLE ENDIF
            GIVE_WEAPON_TO_PED(riotPed, riotWeapon, 9999, TRUE, TRUE)
            SET_PED_COMBAT_ATTRIBUTES(riotPed, CA_ALWAYS_FIGHT, TRUE)
            SET_PED_FLEE_ATTRIBUTES(riotPed, FA_NEVER_FLEE, TRUE)
            SET_PED_COMBAT_ABILITY(riotPed, CAL_AVERAGE)
            SET_PED_AS_ENEMY(riotPed, TRUE)
            IF index + 1 < nearbyCount
                otherPed = nearbyPeds[index + 1]
                IF DOES_ENTITY_EXIST(otherPed) AND otherPed != riotPed AND NOT IS_PED_INJURED(otherPed) AND NOT IS_PED_IN_GROUP(otherPed) AND GET_PED_RELATIONSHIP_GROUP_HASH(otherPed) != RELGROUPHASH_PLAYER
                    TASK_COMBAT_PED(riotPed, otherPed)
                ELSE
                    TASK_COMBAT_HATED_TARGETS_AROUND_PED(riotPed, 100.0)
                ENDIF
            ELSE
                TASK_COMBAT_HATED_TARGETS_AROUND_PED(riotPed, 100.0)
            ENDIF
            SET_PED_KEEP_TASK(riotPed, TRUE)
        ENDIF
        index = index + 1
    ENDWHILE
ENDPROC

PROC PROCESS_WORLD_MAYHEM()
    PED_INDEX playerPed = NULL
    VECTOR playerCoords = <<0.0, 0.0, 0.0>>
    VECTOR skyOrigin = <<0.0, 0.0, 0.0>>
    VECTOR groundTarget = <<0.0, 0.0, 0.0>>
    FLOAT groundZ = 0.0
    INT now = 0
    INT index = 0
    VEHICLE_INDEX playerVeh = NULL
    VEHICLE_INDEX candVeh = NULL
    PED_INDEX driverPed = NULL
    DRIVINGMODE crazyMode = DF_SwerveAroundAllCars|DF_SteerAroundStationaryCars|DF_SteerAroundObjects|DF_GoOffRoadWhenAvoiding|DF_DriveIntoOncomingTraffic|DF_ChangeLanesAroundObstructions|DF_UseShortCutLinks|DF_UseSwitchedOffNodes|DF_UseStringPullingAtJunctions|DF_ForceJoinInRoadDirection|DF_UseWanderFallbackInsteadOfStraightLine

    IF NOT g_blackout AND NOT g_meteor_shower AND NOT g_riot_mode AND NOT g_crazy_drivers
        EXIT
    ENDIF

    IF g_blackout
        SET_ARTIFICIAL_LIGHTS_STATE(TRUE)
    ENDIF

    playerPed = PLAYER_PED_ID()
    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed)
        EXIT
    ENDIF

    now = GET_GAME_TIMER()
    playerCoords = GET_ENTITY_COORDS(playerPed)

    // 1. Meteor Shower: periodic flaming sky-to-ground impacts around player.
    IF g_meteor_shower AND now >= g_next_meteor_ms
        g_next_meteor_ms = now + GET_RANDOM_INT_IN_RANGE(550, 1100)
        groundTarget.x = playerCoords.x + GET_RANDOM_FLOAT_IN_RANGE(-55.0, 55.0)
        groundTarget.y = playerCoords.y + GET_RANDOM_FLOAT_IN_RANGE(-55.0, 55.0)
        groundTarget.z = playerCoords.z + 80.0
        IF GET_GROUND_Z_FOR_3D_COORD(groundTarget, groundZ)
            groundTarget.z = groundZ
        ELSE
            groundTarget.z = playerCoords.z
        ENDIF
        skyOrigin.x = groundTarget.x + GET_RANDOM_FLOAT_IN_RANGE(-25.0, 25.0)
        skyOrigin.y = groundTarget.y + GET_RANDOM_FLOAT_IN_RANGE(-25.0, 25.0)
        skyOrigin.z = groundTarget.z + 95.0
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(skyOrigin, groundTarget, 250, TRUE, WEAPONTYPE_RPG, playerPed, TRUE, FALSE, 180.0)
        ADD_EXPLOSION(groundTarget, EXP_TAG_HI_OCTANE, 1.0, TRUE, FALSE, 0.55)
    ENDIF

    // 2. Armed Ped Riot: arm nearby ambient peds and pit them against everyone.
    IF g_riot_mode AND now >= g_next_riot_ms
        g_next_riot_ms = now + 2400
        RUN_ARMED_PED_RIOT_TICK(playerPed)
    ENDIF

    // 3. Crazy Drivers: make nearby ambient traffic floor it and swerve recklessly.
    IF g_crazy_drivers AND now >= g_next_crazy_drivers_ms
        g_next_crazy_drivers_ms = now + 1800
        IF IS_PED_IN_ANY_VEHICLE(playerPed)
            playerVeh = GET_VEHICLE_PED_IS_IN(playerPed)
        ENDIF
        index = 0
        WHILE index < 12
            candVeh = GET_RANDOM_VEHICLE_IN_SPHERE(playerCoords, 130.0, DUMMY_MODEL_FOR_SCRIPT, VEHICLE_SEARCH_FLAG_RETURN_RANDOM_VEHICLES)
            IF DOES_ENTITY_EXIST(candVeh) AND NOT IS_ENTITY_DEAD(candVeh) AND candVeh != playerVeh AND candVeh != g_chauffeur_vehicle
                driverPed = GET_PED_IN_VEHICLE_SEAT(candVeh, VS_DRIVER, FALSE)
                IF DOES_ENTITY_EXIST(driverPed) AND driverPed != playerPed AND driverPed != g_chauffeur_driver AND NOT IS_PED_INJURED(driverPed) AND NOT IS_PED_IN_GROUP(driverPed) AND GET_PED_RELATIONSHIP_GROUP_HASH(driverPed) != RELGROUPHASH_PLAYER
                    SET_DRIVER_ABILITY(driverPed, 1.0)
                    SET_DRIVER_AGGRESSIVENESS(driverPed, 1.0)
                    SET_PED_FLEE_ATTRIBUTES(driverPed, FA_NEVER_FLEE, TRUE)
                    TASK_VEHICLE_DRIVE_WANDER(driverPed, candVeh, 40.0, crazyMode)
                    IF GET_ENTITY_SPEED(candVeh) < 18.0
                        SET_VEHICLE_FORWARD_SPEED(candVeh, 28.0)
                    ENDIF
                ENDIF
            ENDIF
            index = index + 1
        ENDWHILE
    ENDIF
ENDPROC

PROC DRAW_WORLD_MAYHEM_ENTRY(FLOAT y, BOOL selected)
    IF g_blackout OR g_meteor_shower OR g_riot_mode OR g_crazy_drivers
        DRAW_OPTION(y, TR("World Mayhem", "Caos mundial", "世界大乱", "Welt-Chaos", "ワールドメイヘム", "Мировой хаос", "Caos no mundo", "Chaos mondial"), TR("ACTIVE", "ACTIVO", "已激活", "AKTIV", "稼働中", "АКТИВЕН", "ATIVO", "ACTIF"), selected, 1)
    ELSE
        DRAW_OPTION(y, TR("World Mayhem", "Caos mundial", "世界大乱", "Welt-Chaos", "ワールドメイヘム", "Мировой хаос", "Caos no mundo", "Chaos mondial"), "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC DRAW_WORLD_MAYHEM_ROW(INT index, FLOAT y)
    SWITCH index
        CASE 0 IF g_blackout DRAW_OPTION(y, TR("City Blackout / EMP", "Apagón urbano / PEM", "全城停电 / 电磁脉冲", "Stadt-Blackout / EMP", "都市停電 / EMP", "Блэкаут / ЭМИ", "Apagão na cidade / PEM", "Blackout urbain / IEM"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("City Blackout / EMP", "Apagón urbano / PEM", "全城停电 / 电磁脉冲", "Stadt-Blackout / EMP", "都市停電 / EMP", "Блэкаут / ЭМИ", "Apagão na cidade / PEM", "Blackout urbain / IEM"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 1 IF g_meteor_shower DRAW_OPTION(y, TR("Meteor Shower", "Lluvia de meteoritos", "流星雨", "Meteoritenschauer", "隕石の雨", "Метеоритный дождь", "Chuva de meteoros", "Pluie de météores"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Meteor Shower", "Lluvia de meteoritos", "流星雨", "Meteoritenschauer", "隕石の雨", "Метеоритный дождь", "Chuva de meteoros", "Pluie de météores"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 2 IF g_riot_mode DRAW_OPTION(y, TR("Armed Ped Riot", "Disturbios armados", "武装市民暴乱", "Bewaffneter Aufstand", "武装市民暴動", "Вооружённый бунт", "Revolta armada", "Émeute armée"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Armed Ped Riot", "Disturbios armados", "武装市民暴乱", "Bewaffneter Aufstand", "武装市民暴動", "Вооружённый бунт", "Revolta armada", "Émeute armée"), "OFF", g_item = index, 0) ENDIF BREAK
        CASE 3 IF g_crazy_drivers DRAW_OPTION(y, TR("Crazy Drivers", "Conductores locos", "疯狂司机", "Verrückte Fahrer", "クレイジードライバー", "Безумные водители", "Motoristas loucos", "Conducteurs fous"), "ON", g_item = index, 1) ELSE DRAW_OPTION(y, TR("Crazy Drivers", "Conductores locos", "疯狂司机", "Verrückte Fahrer", "クレイジードライバー", "Безумные водители", "Motoristas loucos", "Conducteurs fous"), "OFF", g_item = index, 0) ENDIF BREAK
    ENDSWITCH
ENDPROC

PROC DRAW_WORLD_MAYHEM_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WORLD MAYHEM", "CAOS MUNDIAL", "世界大乱", "WELT-CHAOS", "ワールドメイヘム", "МИРОВОЙ ХАОС", "CAOS NO MUNDO", "CHAOS MONDIAL"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_mayhem_scroll
    INT row = 0
    WHILE row < 8 AND index < WORLD_MAYHEM_MENU_ROWS
        DRAW_WORLD_MAYHEM_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC
