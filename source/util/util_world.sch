PROC PREPARE_NORTH_YANKTON()

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
    NEW_LOAD_SCENE_START_SPHERE(<<5311.0, -5206.0, 83.0>>, 1200.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
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

    IF NOT IS_DLC_PRESENT(HASH("mpheist4")) RETURN FALSE ENDIF
    REQUEST_CAYO_IPLS_EARLY()
    SET_ISLAND_ENABLED("HeistIsland", TRUE)
    SET_ALLOW_STREAM_HEIST_ISLAND_NODES(TRUE)
    SET_USE_ISLAND_MAP(TRUE)
    LOAD_GLOBAL_WATER_FILE(1)
    SET_DEEP_OCEAN_SCALER(0.0)
    NEW_LOAD_SCENE_START_SPHERE(<<5014.21, -5134.19, 2.5>>, 1400.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
    RETURN TRUE
ENDFUNC


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

PROC PREPARE_TELEPORT_IPL(INT location)
    SWITCH location
        CASE 11
            REQUEST_IPL("TrevorsTrailer")
        BREAK
        CASE 14
            REQUEST_IPL("rc12b_hospitalinterior")
            REMOVE_IPL("rc12b_default")
        BREAK
        CASE 28
            IF IS_DLC_PRESENT(HASH("mpheist3")) REQUEST_IPL("vw_dlc_casino_door") ENDIF
        BREAK
        CASE 38
        BREAK
        CASE 39
        BREAK
        CASE 40
            IF IS_DLC_PRESENT(HASH("mpgunrunning"))
                REQUEST_IPL("xm_bunkerentrance_door")
                REQUEST_IPL("xm_hatches_terrain")
            ENDIF
        BREAK
        CASE 42
        BREAK
    ENDSWITCH
ENDPROC

PROC APPLY_IPL_PRESET(BOOL load)
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
                NEW_LOAD_SCENE_START_SPHERE(<<5014.21, -5134.19, 2.5>>, 1400.0, NEWLOADSCENE_FLAG_REQUIRE_COLLISION | NEWLOADSCENE_FLAG_INTERIOR_AND_EXTERIOR)
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
    ENDIF
ENDPROC

PROC LOAD_CUSTOM_IPL()
    IF NOT IS_STRING_NULL_OR_EMPTY(g_custom_ipl_name)
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
