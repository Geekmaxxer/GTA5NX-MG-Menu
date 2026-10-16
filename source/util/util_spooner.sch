// ===========================================================================
// Object Spooner (Menu Settings tab Row 0).
//
// A Menyoo-style live-session entity spawner, player-matrix offset positioner,
// physics property controller, bone-indexed attachment manager, and Nintendo
// Switch entity pool cleaner.
//
// CRITICAL RESTRAINTS:
//   - Purely live-session memory: zero file I/O, XML/JSON parsing, map saving,
//     map loading, or persistent stat storage.
//   - Zero 3D transformation gizmos, raycasting selectors, or world markers.
//   - Asynchronous model loading polled via PROCESS_SPOONER_SPAWN_QUEUE() in
//     ragemenu.sc (no blocking WAIT calls inside menu handlers).
// ===========================================================================

// ---------------------------------------------------------------------------
// 1. ENTITY SPAWNING & RECOGNITION (314 CURATED PROPS ACROSS 4 PAGES)
// ---------------------------------------------------------------------------

FUNC MODEL_NAMES SPOONER_CATALOG_MODEL_PAGE_0(INT index)
    SWITCH index
        CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_work05"))
        CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
        CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_01"))
        CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_02"))
        CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_ramp_03"))
        CASE 5 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01a"))
        CASE 6 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_exp_01a"))
        CASE 7 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_boxpile_07d"))
        CASE 8 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_01a"))
        CASE 9 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_fire"))
        CASE 10 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fnclink_02gate1"))
        CASE 11 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_sec_barrier_ld_01a"))
        CASE 12 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_crate_01"))
        CASE 13 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_worklight_03b"))
        CASE 14 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gazebo_02"))
        CASE 15 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_air_lights_02a"))
        CASE 16 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_flatramp"))
        CASE 17 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_alien_egg_01"))
        CASE 18 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_conslift_base"))
        CASE 19 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_soda_01"))
        CASE 20 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_halfpipe"))
        CASE 21 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_quartpipe"))
        CASE 22 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_funbox"))
        CASE 23 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_kickers"))
        CASE 24 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_rail"))
        CASE 25 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skate_spiner"))
        CASE 26 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_jetski_ramp_01"))
        CASE 27 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_water_ramp_01"))
        CASE 28 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_water_ramp_02"))
        CASE 29 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_water_ramp_03"))
        CASE 30 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_byard_ramp"))
        CASE 31 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_byard_rampold"))
        CASE 32 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascyl_ramp_01"))
        CASE 33 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_boost_01"))
        CASE 34 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_0"))
        CASE 35 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_1"))
        CASE 36 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_2"))
        CASE 37 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_3"))
        CASE 38 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_4"))
        CASE 39 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_5"))
        CASE 40 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_6"))
        CASE 41 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_7"))
        CASE 42 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_8"))
        CASE 43 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_num_9"))
        CASE 44 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_basejump_target_01"))
        CASE 45 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_work01a"))
        CASE 46 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_work06a"))
        CASE 47 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_wat_01a"))
        CASE 48 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_wat_03a"))
        CASE 49 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_wat_03b"))
        CASE 50 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_wat_04a"))
        CASE 51 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrier_wat_04b"))
        CASE 52 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_barrier_01"))
        CASE 53 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_barrier_02b"))
        CASE 54 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_cone_01"))
        CASE 55 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_cone_02"))
        CASE 56 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_cone_03"))
        CASE 57 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone01a"))
        CASE 58 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone01b"))
        CASE 59 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cone_float_1"))
        CASE 60 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bollard_01a"))
        CASE 61 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bollard_02a"))
        CASE 62 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bollard_03a"))
        CASE 63 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_const_fence01a"))
        CASE 64 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_const_fence02a"))
        CASE 65 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ch2_wdfence_01"))
        CASE 66 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fncwood_01a"))
        CASE 67 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fncwood_01gate"))
        CASE 68 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("fnclink_02_gate"))
        CASE 69 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("farm_gate"))
        CASE 70 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_armenian_gate"))
        CASE 71 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_burto_gate_01"))
        CASE 72 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_broken_cell_gate_01"))
        CASE 73 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gold_vault_gate_01"))
        CASE 74 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bank_vaultdoor"))
        CASE 75 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_vault_door"))
        CASE 76 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vault_shutter"))
        CASE 77 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ch_prop_ch_vault_slide_door_lrg"))
        CASE 78 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ballistic_shield"))
        CASE 79 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_riot_shield"))
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
ENDFUNC

FUNC MODEL_NAMES SPOONER_CATALOG_MODEL_PAGE_1(INT index)
    SWITCH index
        CASE 80 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01b"))
        CASE 81 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01c"))
        CASE 82 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01d"))
        CASE 83 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01e"))
        CASE 84 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_01f"))
        CASE 85 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_03a"))
        CASE 86 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_container_05a"))
        CASE 87 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_portacabin01"))
        CASE 88 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_crate_01a"))
        CASE 89 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_crate_02a"))
        CASE 90 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_crate_07a"))
        CASE 91 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cons_crate"))
        CASE 92 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_drop_crate_01"))
        CASE 93 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mil_crate_01"))
        CASE 94 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mil_crate_02"))
        CASE 95 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ex_prop_crate_expl_bc"))
        CASE 96 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ba_prop_battle_crate_closed_bc"))
        CASE 97 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_boxpile_01a"))
        CASE 98 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_boxpile_02b"))
        CASE 99 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_boxpile_04a"))
        CASE 100 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_pallet_01a"))
        CASE 101 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_pallet_02"))
        CASE 102 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_pallet_pile_01"))
        CASE 103 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_rub_cage01a"))
        CASE 104 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dog_cage_01"))
        CASE 105 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dog_cage_02"))
        CASE 106 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascage01"))
        CASE 107 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("gr_prop_gr_cage_01a"))
        CASE 108 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_conslift_cage"))
        CASE 109 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_conslift_lift"))
        CASE 110 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_scafold_01a"))
        CASE 111 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_scafold_03a"))
        CASE 112 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_int_safe_01"))
        CASE 113 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_night_safe_01"))
        CASE 114 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("p_v_43_safe_s"))
        CASE 115 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ch_prop_ch_vaultdoor01x"))
        CASE 116 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_exp_01b"))
        CASE 117 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_exp_01c"))
        CASE 118 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_01a"))
        CASE 119 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_02a"))
        CASE 120 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_02b"))
        CASE 121 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrel_03a"))
        CASE 122 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascyl_01a"))
        CASE 123 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascyl_02a"))
        CASE 124 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascyl_03a"))
        CASE 125 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gascyl_04a"))
        CASE 126 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gas_tank_01a"))
        CASE 127 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gas_tank_02a"))
        CASE 128 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gas_tank_02b"))
        CASE 129 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gas_tank_04a"))
        CASE 130 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_storagetank_01"))
        CASE 131 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_storagetank_02"))
        CASE 132 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_oil_derrick_01"))
        CASE 133 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bomb_01"))
        CASE 134 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_bomb_01"))
        CASE 135 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("hei_prop_carrier_bombs_1"))
        CASE 136 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ind_prop_firework_01"))
        CASE 137 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ind_prop_firework_02"))
        CASE 138 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ind_prop_firework_03"))
        CASE 139 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ind_prop_firework_04"))
        CASE 140 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fire_exting_1a"))
        CASE 141 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fire_exting_2a"))
        CASE 142 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fire_hydrant_1"))
        CASE 143 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fire_hydrant_2"))
        CASE 144 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fire_hydrant_4"))
        CASE 145 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cablespool_01a"))
        CASE 146 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cablespool_03"))
        CASE 147 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_elecbox_01a"))
        CASE 148 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_generator_01a"))
        CASE 149 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_generator_03b"))
        CASE 150 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_streetlight_01"))
        CASE 151 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_streetlight_02"))
        CASE 152 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_streetlight_03"))
        CASE 153 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_snow_streetlight01"))
        CASE 154 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_traffic_01a"))
        CASE 155 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_traffic_01b"))
        CASE 156 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_traffic_02a"))
        CASE 157 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_busstop_02"))
        CASE 158 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_busstop_04"))
        CASE 159 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bus_stop_sign"))
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
ENDFUNC

FUNC MODEL_NAMES SPOONER_CATALOG_MODEL_PAGE_2(INT index)
    SWITCH index
        CASE 160 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dumpster_01a"))
        CASE 161 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dumpster_02a"))
        CASE 162 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dumpster_3a"))
        CASE 163 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cs_dumpster_01a"))
        CASE 164 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bin_01a"))
        CASE 165 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bin_02a"))
        CASE 166 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bin_05a"))
        CASE 167 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_recyclebin_01a"))
        CASE 168 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_postbox_01a"))
        CASE 169 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_postbox_ss_01a"))
        CASE 170 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_news_disp_01a"))
        CASE 171 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_parknmeter_01"))
        CASE 172 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_parknmeter_02"))
        CASE 173 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_parkingpay"))
        CASE 174 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_atm_01"))
        CASE 175 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_atm_02"))
        CASE 176 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_atm_03"))
        CASE 177 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fleeca_atm"))
        CASE 178 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_phonebox_01a"))
        CASE 179 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_phonebox_04"))
        CASE 180 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_02"))
        CASE 181 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_03"))
        CASE 182 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_04"))
        CASE 183 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bench_06"))
        CASE 184 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_table_para_comb_01"))
        CASE 185 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_sign_road_01a"))
        CASE 186 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_sign_road_02a"))
        CASE 187 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_sign_road_03a"))
        CASE 188 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ammunation_sign_01"))
        CASE 189 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_airport_sale_sign"))
        CASE 190 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_shopsign_01"))
        CASE 191 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_soda_02"))
        CASE 192 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_snak_01"))
        CASE 193 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_coffe_01"))
        CASE 194 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_water_01"))
        CASE 195 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_fridge01"))
        CASE 196 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_fags_01"))
        CASE 197 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_vend_condom_01"))
        CASE 198 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_watercooler"))
        CASE 199 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bar_fridge_01"))
        CASE 200 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bar_beerfridge_01"))
        CASE 201 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cs_fridge"))
        CASE 202 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bbq_1"))
        CASE 203 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bbq_2"))
        CASE 204 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bbq_3"))
        CASE 205 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bbq_5"))
        CASE 206 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_bbq"))
        CASE 207 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_burgerstand_01"))
        CASE 208 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_hotdogstand_01"))
        CASE 209 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_juicestand"))
        CASE 210 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_donut_01"))
        CASE 211 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cs_burger_01"))
        CASE 212 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bar_stool_01"))
        CASE 213 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beer_neon_01"))
        CASE 214 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beer_neon_02"))
        CASE 215 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_barrachneon"))
        CASE 216 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cockneon"))
        CASE 217 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_t_sofa"))
        CASE 218 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_t_sofa_02"))
        CASE 219 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_farm_couch01"))
        CASE 220 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_rub_couch01"))
        CASE 221 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_chair_01a"))
        CASE 222 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_chair_02"))
        CASE 223 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_chair_04a"))
        CASE 224 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_rock_chair_01"))
        CASE 225 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_wheelchair_01"))
        CASE 226 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_chateau_table_01"))
        CASE 227 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_astro_table_01"))
        CASE 228 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fbi3_coffee_table"))
        CASE 229 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_farm_table01"))
        CASE 230 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_toilet_01"))
        CASE 231 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_portaloo_01a"))
        CASE 232 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_birdbath1"))
        CASE 233 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_arcade_01"))
        CASE 234 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_arcade_02"))
        CASE 235 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bball_arcade_01"))
        CASE 236 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("sum_prop_arcade_qub3d_01a"))
        CASE 237 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_50s_jukebox"))
        CASE 238 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_jukebox_01"))
        CASE 239 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_jukebox_02"))
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
ENDFUNC

FUNC MODEL_NAMES SPOONER_CATALOG_MODEL_PAGE_3(INT index)
    SWITCH index
        CASE 240 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dj_deck_01"))
        CASE 241 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dj_deck_02"))
        CASE 242 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_speaker_01"))
        CASE 243 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_speaker_06"))
        CASE 244 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_out_door_speaker"))
        CASE 245 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_el_guitar_01"))
        CASE 246 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_el_guitar_03"))
        CASE 247 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_acc_guitar_01"))
        CASE 248 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bongos_01"))
        CASE 249 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_bong_01"))
        CASE 250 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cctv_cam_01a"))
        CASE 251 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_big_clock_01"))
        CASE 252 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_fan_01"))
        CASE 253 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_hotel_trolley"))
        CASE 254 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gold_bar"))
        CASE 255 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gold_cont_01"))
        CASE 256 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gold_trolly_full"))
        CASE 257 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("ch_prop_gold_trolly_01a"))
        CASE 258 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("bkr_prop_cashtrolley_01a"))
        CASE 259 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cash_crate_01"))
        CASE 260 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cash_case_01"))
        CASE 261 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cash_case_02"))
        CASE 262 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_anim_cash_pile_02"))
        CASE 263 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_money_bag_01"))
        CASE 264 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_weed_01"))
        CASE 265 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_weed_02"))
        CASE 266 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_weed_pallet"))
        CASE 267 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_weed_block_01"))
        CASE 268 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_coke_block_01"))
        CASE 269 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("bkr_prop_coke_pallet_01a"))
        CASE 270 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_meth_setup_01"))
        CASE 271 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("bkr_prop_meth_pallet_01a"))
        CASE 272 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("hei_prop_drug_statue_01"))
        CASE 273 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_range_target_01"))
        CASE 274 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_minigun_01"))
        CASE 275 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_surf_board_01"))
        CASE 276 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_surf_board_03"))
        CASE 277 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_lg_surf"))
        CASE 278 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_parasol_01"))
        CASE 279 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_parasol_04"))
        CASE 280 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_skid_tent_01"))
        CASE 281 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gazebo_01"))
        CASE 282 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beach_volball01"))
        CASE 283 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_beachball_02"))
        CASE 284 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_basketball_net"))
        CASE 285 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_table_tennis"))
        CASE 286 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_tennis_net_01"))
        CASE 287 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_golf_bag_01"))
        CASE 288 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_freeweight_01"))
        CASE 289 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_weight_20k"))
        CASE 290 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_wheelbarrow01a"))
        CASE 291 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_haybale_01"))
        CASE 292 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_haybale_stack_01"))
        CASE 293 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_prop_tree_01"))
        CASE 294 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_test_rocks01"))
        CASE 295 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_test_rocks04"))
        CASE 296 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_windmill_01"))
        CASE 297 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_rural_windmill"))
        CASE 298 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ld_ferris_wheel"))
        CASE 299 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_ferris_car_01"))
        CASE 300 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("p_spinning_anus_s"))
        CASE 301 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_mp_rocket_01"))
        CASE 302 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("xm_prop_x17_silo_rocket_01"))
        CASE 303 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("xm3_prop_xm3_snowman_01a"))
        CASE 304 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_xmas_tree_int"))
        CASE 305 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_xmas_ext"))
        CASE 306 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gnome1"))
        CASE 307 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_gnome2"))
        CASE 308 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_flamingo"))
        CASE 309 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dummy_01"))
        CASE 310 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dummy_car"))
        CASE 311 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_dummy_plane"))
        CASE 312 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_cs_rage_statue_p1"))
        CASE 313 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("p_cargo_chute_s"))
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("prop_roadcone02a"))
ENDFUNC

FUNC MODEL_NAMES SPOONER_CATALOG_MODEL(INT index)
    IF index < 80 RETURN SPOONER_CATALOG_MODEL_PAGE_0(index) ENDIF
    IF index < 160 RETURN SPOONER_CATALOG_MODEL_PAGE_1(index) ENDIF
    IF index < 240 RETURN SPOONER_CATALOG_MODEL_PAGE_2(index) ENDIF
    RETURN SPOONER_CATALOG_MODEL_PAGE_3(index)
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL_PAGE_0(INT index)
    SWITCH index
        CASE 0 RETURN "< Work Barrier >"
        CASE 1 RETURN "< Traffic Cone >"
        CASE 2 RETURN "< Stunt Ramp S >"
        CASE 3 RETURN "< Stunt Ramp M >"
        CASE 4 RETURN "< Stunt Ramp L >"
        CASE 5 RETURN "< Cargo Container >"
        CASE 6 RETURN "< Explosive Barrel >"
        CASE 7 RETURN "< Wooden Crate Pile >"
        CASE 8 RETURN "< Park Bench >"
        CASE 9 RETURN "< Campfire >"
        CASE 10 RETURN "< Chainlink Gate >"
        CASE 11 RETURN "< Security Boom >"
        CASE 12 RETURN "< Military Crate >"
        CASE 13 RETURN "< Floodlight Stand >"
        CASE 14 RETURN "< Gazebo Tent >"
        CASE 15 RETURN "< Runway Light >"
        CASE 16 RETURN "< Skate Ramp >"
        CASE 17 RETURN "< Alien Egg >"
        CASE 18 RETURN "< Lift Base >"
        CASE 19 RETURN "< Soda Machine >"
        CASE 20 RETURN "< Skate Halfpipe >"
        CASE 21 RETURN "< Skate Quarterpipe >"
        CASE 22 RETURN "< Skate Funbox >"
        CASE 23 RETURN "< Skate Kickers >"
        CASE 24 RETURN "< Skate Grind Rail >"
        CASE 25 RETURN "< Skate Spine Ramp >"
        CASE 26 RETURN "< Jetski Water Ramp >"
        CASE 27 RETURN "< Wooden Water Ramp >"
        CASE 28 RETURN "< Floating Ramp M >"
        CASE 29 RETURN "< Floating Ramp L >"
        CASE 30 RETURN "< Backyard Ramp >"
        CASE 31 RETURN "< Old Wood Ramp >"
        CASE 32 RETURN "< Gas Cylinder Ramp >"
        CASE 33 RETURN "< Speed Boost Pad >"
        CASE 34 RETURN "< Stunt Number 0 >"
        CASE 35 RETURN "< Stunt Number 1 >"
        CASE 36 RETURN "< Stunt Number 2 >"
        CASE 37 RETURN "< Stunt Number 3 >"
        CASE 38 RETURN "< Stunt Number 4 >"
        CASE 39 RETURN "< Stunt Number 5 >"
        CASE 40 RETURN "< Stunt Number 6 >"
        CASE 41 RETURN "< Stunt Number 7 >"
        CASE 42 RETURN "< Stunt Number 8 >"
        CASE 43 RETURN "< Stunt Number 9 >"
        CASE 44 RETURN "< Parachute Target >"
        CASE 45 RETURN "< Striped Work Barrier >"
        CASE 46 RETURN "< Heavy Roadblock >"
        CASE 47 RETURN "< Plastic Road Barrier >"
        CASE 48 RETURN "< Water Barrier Red >"
        CASE 49 RETURN "< Water Barrier White >"
        CASE 50 RETURN "< Highway Crash Barrel >"
        CASE 51 RETURN "< Yellow Crash Barrel >"
        CASE 52 RETURN "< Race Barrier Red >"
        CASE 53 RETURN "< Race Barrier Blue >"
        CASE 54 RETURN "< Race Cone Tall >"
        CASE 55 RETURN "< Race Cone Wide >"
        CASE 56 RETURN "< Race Marker Cone >"
        CASE 57 RETURN "< Large Traffic Cone >"
        CASE 58 RETURN "< Striped Road Cone >"
        CASE 59 RETURN "< Floating Buoy Cone >"
        CASE 60 RETURN "< Steel Bollard >"
        CASE 61 RETURN "< Concrete Bollard >"
        CASE 62 RETURN "< Yellow Post Bollard >"
        CASE 63 RETURN "< Site Fence Panel >"
        CASE 64 RETURN "< Tall Site Fence >"
        CASE 65 RETURN "< Ranch Wood Fence >"
        CASE 66 RETURN "< Wood Picket Fence >"
        CASE 67 RETURN "< Wood Fence Gate >"
        CASE 68 RETURN "< Chainlink Yard Gate >"
        CASE 69 RETURN "< Country Farm Gate >"
        CASE 70 RETURN "< Mansion Iron Gate >"
        CASE 71 RETURN "< Estate Gate >"
        CASE 72 RETURN "< Prison Cell Gate >"
        CASE 73 RETURN "< Gold Vault Cage Gate >"
        CASE 74 RETURN "< Bank Vault Door >"
        CASE 75 RETURN "< Heavy Vault Door >"
        CASE 76 RETURN "< Security Shutter >"
        CASE 77 RETURN "< Casino Slide Vault >"
        CASE 78 RETURN "< Ballistic Shield >"
        CASE 79 RETURN "< Police Riot Shield >"
    ENDSWITCH
    RETURN "< Work Barrier >"
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL_PAGE_1(INT index)
    SWITCH index
        CASE 80 RETURN "< Container Red >"
        CASE 81 RETURN "< Container Blue >"
        CASE 82 RETURN "< Container Green >"
        CASE 83 RETURN "< Container White >"
        CASE 84 RETURN "< Container Orange >"
        CASE 85 RETURN "< Half Container >"
        CASE 86 RETURN "< Open Cargo Container >"
        CASE 87 RETURN "< Site Portacabin >"
        CASE 88 RETURN "< Shipping Crate S >"
        CASE 89 RETURN "< Slatted Wood Crate >"
        CASE 90 RETURN "< Shipping Crate L >"
        CASE 91 RETURN "< Construction Crate >"
        CASE 92 RETURN "< Airdrop Supply Crate >"
        CASE 93 RETURN "< Olive Military Case >"
        CASE 94 RETURN "< Long Ammo Crate >"
        CASE 95 RETURN "< Explosive Supply Crate >"
        CASE 96 RETURN "< Nightclub Cargo Crate >"
        CASE 97 RETURN "< Cardboard Box Stack >"
        CASE 98 RETURN "< Warehouse Box Stack >"
        CASE 99 RETURN "< Wrapped Pallet Boxes >"
        CASE 100 RETURN "< Wooden Pallet >"
        CASE 101 RETURN "< Heavy Freight Pallet >"
        CASE 102 RETURN "< Stacked Wood Pallets >"
        CASE 103 RETURN "< Roll Cage Cart >"
        CASE 104 RETURN "< Metal Dog Cage >"
        CASE 105 RETURN "< Large Kennel Cage >"
        CASE 106 RETURN "< Gas Bottle Cage >"
        CASE 107 RETURN "< Bunker Storage Cage >"
        CASE 108 RETURN "< Elevator Lift Cage >"
        CASE 109 RETURN "< Construction Hoist >"
        CASE 110 RETURN "< Scaffold Tower Frame >"
        CASE 111 RETURN "< Wide Scaffold Stage >"
        CASE 112 RETURN "< Office Floor Safe >"
        CASE 113 RETURN "< Bank Night Safe >"
        CASE 114 RETURN "< Heavy Combination Safe >"
        CASE 115 RETURN "< Casino Vault Door >"
        CASE 116 RETURN "< Explosive Drum Red >"
        CASE 117 RETURN "< Flammable Drum >"
        CASE 118 RETURN "< Metal Oil Drum >"
        CASE 119 RETURN "< Blue Plastic Barrel >"
        CASE 120 RETURN "< Sealed Chemical Drum >"
        CASE 121 RETURN "< Rusty Steel Drum >"
        CASE 122 RETURN "< Tall Gas Cylinder >"
        CASE 123 RETURN "< Welding Gas Bottle >"
        CASE 124 RETURN "< Twin Oxygen Tanks >"
        CASE 125 RETURN "< Pressurized Gas Tank >"
        CASE 126 RETURN "< Large Industrial Tank >"
        CASE 127 RETURN "< Propane Storage Tank >"
        CASE 128 RETURN "< Horizontal Gas Tank >"
        CASE 129 RETURN "< Vertical Fuel Tank >"
        CASE 130 RETURN "< Refinery Oil Tank >"
        CASE 131 RETURN "< Huge Chemical Silo >"
        CASE 132 RETURN "< Oil Pumpjack >"
        CASE 133 RETURN "< C4 Explosive Pack >"
        CASE 134 RETURN "< Time Bomb Case >"
        CASE 135 RETURN "< Naval Bomb Rack >"
        CASE 136 RETURN "< Firework Mortar >"
        CASE 137 RETURN "< Firework Rocket >"
        CASE 138 RETURN "< Firework Fountain >"
        CASE 139 RETURN "< Firework Box >"
        CASE 140 RETURN "< Fire Extinguisher >"
        CASE 141 RETURN "< CO2 Extinguisher >"
        CASE 142 RETURN "< Red Fire Hydrant >"
        CASE 143 RETURN "< Silver Fire Hydrant >"
        CASE 144 RETURN "< Yellow Fire Hydrant >"
        CASE 145 RETURN "< Giant Cable Spool >"
        CASE 146 RETURN "< Wooden Wire Spool >"
        CASE 147 RETURN "< Transformer Box >"
        CASE 148 RETURN "< Portable Generator >"
        CASE 149 RETURN "< Heavy Site Generator >"
        CASE 150 RETURN "< Street Lamp Post >"
        CASE 151 RETURN "< Double Street Lamp >"
        CASE 152 RETURN "< Modern Highway Lamp >"
        CASE 153 RETURN "< Snowy Streetlight >"
        CASE 154 RETURN "< Traffic Light Pole >"
        CASE 155 RETURN "< Overhead Traffic Signal >"
        CASE 156 RETURN "< Crosswalk Signal >"
        CASE 157 RETURN "< Bus Stop Shelter >"
        CASE 158 RETURN "< Glass Bus Shelter >"
        CASE 159 RETURN "< Bus Stop Sign >"
    ENDSWITCH
    RETURN "< Work Barrier >"
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL_PAGE_2(INT index)
    SWITCH index
        CASE 160 RETURN "< Green Dumpster >"
        CASE 161 RETURN "< Blue Dumpster >"
        CASE 162 RETURN "< Industrial Skip Bin >"
        CASE 163 RETURN "< Overflowing Dumpster >"
        CASE 164 RETURN "< Street Trash Bin >"
        CASE 165 RETURN "< Park Waste Bin >"
        CASE 166 RETURN "< Recycling Bin >"
        CASE 167 RETURN "< Blue Wheelie Bin >"
        CASE 168 RETURN "< Blue Mail Postbox >"
        CASE 169 RETURN "< Sidewalk Mail Drop >"
        CASE 170 RETURN "< Newspaper Box >"
        CASE 171 RETURN "< Single Parking Meter >"
        CASE 172 RETURN "< Double Parking Meter >"
        CASE 173 RETURN "< Parking Pay Station >"
        CASE 174 RETURN "< Wall ATM Terminal >"
        CASE 175 RETURN "< Freestanding ATM >"
        CASE 176 RETURN "< Lobby Cash Machine >"
        CASE 177 RETURN "< Fleeca Bank ATM >"
        CASE 178 RETURN "< Payphone Booth >"
        CASE 179 RETURN "< Street Payphone >"
        CASE 180 RETURN "< Iron Park Bench >"
        CASE 181 RETURN "< Bus Stop Bench >"
        CASE 182 RETURN "< Concrete Bench >"
        CASE 183 RETURN "< Picnic Bench >"
        CASE 184 RETURN "< Patio Table & Umbrella >"
        CASE 185 RETURN "< Stop Sign >"
        CASE 186 RETURN "< Yield Sign >"
        CASE 187 RETURN "< No Entry Sign >"
        CASE 188 RETURN "< Ammu-Nation Sign >"
        CASE 189 RETURN "< Flight School Sign >"
        CASE 190 RETURN "< Storefront Sign >"
        CASE 191 RETURN "< eCola Machine >"
        CASE 192 RETURN "< Snack Vending Machine >"
        CASE 193 RETURN "< Coffee Vending Machine >"
        CASE 194 RETURN "< Water Bottle Machine >"
        CASE 195 RETURN "< Drink Cooler Fridge >"
        CASE 196 RETURN "< Cigarette Machine >"
        CASE 197 RETURN "< Bathroom Vending Box >"
        CASE 198 RETURN "< Office Water Cooler >"
        CASE 199 RETURN "< Bar Beer Fridge >"
        CASE 200 RETURN "< Tall Glass Beer Fridge >"
        CASE 201 RETURN "< Kitchen Refrigerator >"
        CASE 202 RETURN "< Kettle BBQ Grill >"
        CASE 203 RETURN "< Charcoal Grill >"
        CASE 204 RETURN "< Brick Backyard BBQ >"
        CASE 205 RETURN "< Deluxe Gas Grill >"
        CASE 206 RETURN "< Public Park Grill >"
        CASE 207 RETURN "< Street Burger Cart >"
        CASE 208 RETURN "< Hotdog Street Cart >"
        CASE 209 RETURN "< Giant Orange Stand >"
        CASE 210 RETURN "< Cardboard Donut Box >"
        CASE 211 RETURN "< Bleeder Burger >"
        CASE 212 RETURN "< Chrome Bar Stool >"
        CASE 213 RETURN "< Pisswasser Neon Sign >"
        CASE 214 RETURN "< Logger Beer Neon >"
        CASE 215 RETURN "< Barracho Neon Sign >"
        CASE 216 RETURN "< Cockatoos Neon Sign >"
        CASE 217 RETURN "< Leather Sofa >"
        CASE 218 RETURN "< Lounge Couch >"
        CASE 219 RETURN "< Worn Farmhouse Couch >"
        CASE 220 RETURN "< Abandoned Street Couch >"
        CASE 221 RETURN "< Patio Plastic Chair >"
        CASE 222 RETURN "< Dining Wood Chair >"
        CASE 223 RETURN "< Modern Cafe Chair >"
        CASE 224 RETURN "< Porch Rocking Chair >"
        CASE 225 RETURN "< Hospital Wheelchair >"
        CASE 226 RETURN "< Round Garden Table >"
        CASE 227 RETURN "< Diner Table >"
        CASE 228 RETURN "< Glass Coffee Table >"
        CASE 229 RETURN "< Rustic Wood Table >"
        CASE 230 RETURN "< Porcelain Toilet >"
        CASE 231 RETURN "< Portable Site Toilet >"
        CASE 232 RETURN "< Stone Birdbath >"
        CASE 233 RETURN "< Retro Arcade Cabinet >"
        CASE 234 RETURN "< Racing Arcade Machine >"
        CASE 235 RETURN "< Basketball Arcade Game >"
        CASE 236 RETURN "< QUB3D Arcade Cabinet >"
        CASE 237 RETURN "< Classic 50s Jukebox >"
        CASE 238 RETURN "< Digital Bar Jukebox >"
        CASE 239 RETURN "< Neon Wurlitzer Jukebox >"
    ENDSWITCH
    RETURN "< Work Barrier >"
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL_PAGE_3(INT index)
    SWITCH index
        CASE 240 RETURN "< DJ Turntable Deck >"
        CASE 241 RETURN "< Club Mixer Console >"
        CASE 242 RETURN "< Stage PA Speaker >"
        CASE 243 RETURN "< Subwoofer Tower >"
        CASE 244 RETURN "< Outdoor Horn Speaker >"
        CASE 245 RETURN "< Electric Guitar Red >"
        CASE 246 RETURN "< V-Shape Rock Guitar >"
        CASE 247 RETURN "< Acoustic Guitar >"
        CASE 248 RETURN "< Bongo Drums >"
        CASE 249 RETURN "< Glass Water Bong >"
        CASE 250 RETURN "< Security CCTV Camera >"
        CASE 251 RETURN "< Wall Station Clock >"
        CASE 252 RETURN "< Pedestal Room Fan >"
        CASE 253 RETURN "< Brass Bellhop Trolley >"
        CASE 254 RETURN "< Solid Gold Bar >"
        CASE 255 RETURN "< Gold Bullion Crate >"
        CASE 256 RETURN "< Full Gold Bar Trolley >"
        CASE 257 RETURN "< Casino Gold Trolley >"
        CASE 258 RETURN "< Stacked Cash Trolley >"
        CASE 259 RETURN "< Pallet of Cash >"
        CASE 260 RETURN "< Open Cash Briefcase >"
        CASE 261 RETURN "< Metal Money Case >"
        CASE 262 RETURN "< Cash Bundle Stack >"
        CASE 263 RETURN "< Bank Loot Duffel Bag >"
        CASE 264 RETURN "< Tall Cannabis Plant >"
        CASE 265 RETURN "< Budding Weed Plant >"
        CASE 266 RETURN "< Weed Bale Pallet >"
        CASE 267 RETURN "< Wrapped Weed Brick >"
        CASE 268 RETURN "< Kilo Coke Brick >"
        CASE 269 RETURN "< Cocaine Pallet >"
        CASE 270 RETURN "< Meth Lab Glassware >"
        CASE 271 RETURN "< Meth Crate Pallet >"
        CASE 272 RETURN "< Contraband Statue >"
        CASE 273 RETURN "< Firing Range Target >"
        CASE 274 RETURN "< Mounted Minigun Prop >"
        CASE 275 RETURN "< Classic Surfboard >"
        CASE 276 RETURN "< Striped Longboard >"
        CASE 277 RETURN "< Lifeguard Rescue Board >"
        CASE 278 RETURN "< Beach Sun Umbrella >"
        CASE 279 RETURN "< Striped Beach Parasol >"
        CASE 280 RETURN "< Camping Tent >"
        CASE 281 RETURN "< Red Party Gazebo >"
        CASE 282 RETURN "< Volleyball Net >"
        CASE 283 RETURN "< Inflatable Beach Ball >"
        CASE 284 RETURN "< Basketball Hoop Stand >"
        CASE 285 RETURN "< Ping Pong Table >"
        CASE 286 RETURN "< Tennis Court Net >"
        CASE 287 RETURN "< Pro Golf Club Bag >"
        CASE 288 RETURN "< Gym Barbell Weight >"
        CASE 289 RETURN "< 20kg Gym Plate >"
        CASE 290 RETURN "< Site Wheelbarrow >"
        CASE 291 RETURN "< Farm Hay Bale >"
        CASE 292 RETURN "< Stacked Hay Bales >"
        CASE 293 RETURN "< Decorative Potted Tree >"
        CASE 294 RETURN "< Desert Boulders >"
        CASE 295 RETURN "< Large Canyon Boulder >"
        CASE 296 RETURN "< Giant Wind Turbine >"
        CASE 297 RETURN "< Farm Windmill Tower >"
        CASE 298 RETURN "< Pier Ferris Wheel >"
        CASE 299 RETURN "< Ferris Wheel Gondola >"
        CASE 300 RETURN "< Flying Saucer UFO >"
        CASE 301 RETURN "< Stunt Booster Rocket >"
        CASE 302 RETURN "< Nuclear Silo Rocket >"
        CASE 303 RETURN "< Holiday Snowman >"
        CASE 304 RETURN "< Decorated Xmas Tree >"
        CASE 305 RETURN "< Giant Outdoor Xmas Tree >"
        CASE 306 RETURN "< Garden Gnome >"
        CASE 307 RETURN "< Fishing Garden Gnome >"
        CASE 308 RETURN "< Pink Lawn Flamingo >"
        CASE 309 RETURN "< Crash Test Mannequin >"
        CASE 310 RETURN "< Crash Test Car Rig >"
        CASE 311 RETURN "< Movie Stunt Plane Rig >"
        CASE 312 RETURN "< Impotent Rage Statue >"
        CASE 313 RETURN "< Cargo Drop Parachute >"
    ENDSWITCH
    RETURN "< Work Barrier >"
ENDFUNC

FUNC STRING SPOONER_CATALOG_LABEL(INT index)
    IF index < 80 RETURN SPOONER_CATALOG_LABEL_PAGE_0(index) ENDIF
    IF index < 160 RETURN SPOONER_CATALOG_LABEL_PAGE_1(index) ENDIF
    IF index < 240 RETURN SPOONER_CATALOG_LABEL_PAGE_2(index) ENDIF
    RETURN SPOONER_CATALOG_LABEL_PAGE_3(index)
ENDFUNC

// Packs frozen, collision, bone (0..9), and attach X/Y/Z (-5.00..5.00m in 0.05m steps)
// into a single 30-bit integer so 512 tracked objects cost minimal static words.
FUNC INT PACK_SPOONER_OBJ_FLAGS(BOOL frozen, BOOL collision, INT bone, FLOAT attX, FLOAT attY, FLOAT attZ)
    INT f = 0
    IF frozen f = f + 1 ENDIF
    IF collision f = f + 2 ENDIF
    INT b = bone
    IF b < 0 b = 0 ENDIF
    IF b > 15 b = 15 ENDIF
    INT ax = ROUND((attX + 5.0) * 20.0)
    IF ax < 0 ax = 0 ENDIF
    IF ax > 200 ax = 200 ENDIF
    INT ay = ROUND((attY + 5.0) * 20.0)
    IF ay < 0 ay = 0 ENDIF
    IF ay > 200 ay = 200 ENDIF
    INT az = ROUND((attZ + 5.0) * 20.0)
    IF az < 0 az = 0 ENDIF
    IF az > 200 az = 200 ENDIF
    RETURN f + (b * 4) + (ax * 64) + (ay * 16384) + (az * 4194304)
ENDFUNC

// Packs attach Pitch, Roll, Yaw (-180..180 deg in 5 deg steps) into a 21-bit integer.
FUNC INT PACK_SPOONER_OBJ_ROT(FLOAT pitch, FLOAT roll, FLOAT yaw)
    INT p = ROUND((pitch + 180.0) / 5.0)
    IF p < 0 p = 0 ENDIF
    IF p > 72 p = 72 ENDIF
    INT r = ROUND((roll + 180.0) / 5.0)
    IF r < 0 r = 0 ENDIF
    IF r > 72 r = 72 ENDIF
    INT y = ROUND((yaw + 180.0) / 5.0)
    IF y < 0 y = 0 ENDIF
    IF y > 72 y = 72 ENDIF
    RETURN p + (r * 128) + (y * 16384)
ENDFUNC

// Prunes any handles that were destroyed externally so the tracking array
// stays contiguous and never indexes a dead entity slot.
PROC COMPACT_SPOONER_POOL()
    INT writeIdx = 0
    INT readIdx = 0
    WHILE readIdx < g_spooner_object_count
        IF DOES_ENTITY_EXIST(g_spooner_objects[readIdx])
            IF writeIdx != readIdx
                g_spooner_objects[writeIdx]   = g_spooner_objects[readIdx]
                g_spooner_obj_flags[writeIdx] = g_spooner_obj_flags[readIdx]
                g_spooner_obj_rot[writeIdx]   = g_spooner_obj_rot[readIdx]
            ENDIF
            writeIdx = writeIdx + 1
        ENDIF
        readIdx = readIdx + 1
    ENDWHILE
    WHILE writeIdx < g_spooner_object_count
        g_spooner_objects[writeIdx] = NULL
        writeIdx = writeIdx + 1
    ENDWHILE
    g_spooner_object_count = writeIdx
    IF g_spooner_selected_index >= g_spooner_object_count
        g_spooner_selected_index = g_spooner_object_count - 1
    ENDIF
    IF g_spooner_selected_index < 0
        g_spooner_selected_index = 0
    ENDIF
ENDPROC

// Restores the UI offset/physics/attachment sliders from the currently
// selected tracked object when cycling through the pool.
PROC SYNC_SPOONER_UI_FROM_SELECTED()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF DOES_ENTITY_EXIST(obj)
        PED_INDEX playerPed = PLAYER_PED_ID()
        VECTOR rel = GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(playerPed, GET_ENTITY_COORDS(obj))
        FLOAT fStep = TO_FLOAT(ROUND(rel.y * 4.0)) * 0.25
        FLOAT sStep = TO_FLOAT(ROUND(rel.x * 4.0)) * 0.25
        FLOAT hStep = TO_FLOAT(ROUND(rel.z * 4.0)) * 0.25
        IF fStep < -50.0 fStep = -50.0 ENDIF
        IF fStep > 50.0 fStep = 50.0 ENDIF
        IF sStep < -50.0 sStep = -50.0 ENDIF
        IF sStep > 50.0 sStep = 50.0 ENDIF
        IF hStep < -50.0 hStep = -50.0 ENDIF
        IF hStep > 50.0 hStep = 50.0 ENDIF
        g_spooner_forward_offset = fStep
        g_spooner_side_offset    = sStep
        g_spooner_height_offset  = hStep
        FLOAT hdgDiff = GET_ENTITY_HEADING(obj) - GET_ENTITY_HEADING(playerPed)
        WHILE hdgDiff < 0.0
            hdgDiff = hdgDiff + 360.0
        ENDWHILE
        WHILE hdgDiff >= 360.0
            hdgDiff = hdgDiff - 360.0
        ENDWHILE
        g_spooner_heading_offset = TO_FLOAT(ROUND(hdgDiff / 5.0) * 5)
        IF g_spooner_heading_offset >= 360.0 g_spooner_heading_offset = 0.0 ENDIF
    ENDIF

    INT rem = g_spooner_obj_flags[idx]
    INT az = rem / 4194304
    rem = rem - (az * 4194304)
    INT ay = rem / 16384
    rem = rem - (ay * 16384)
    INT ax = rem / 64
    rem = rem - (ax * 64)
    INT b = rem / 4
    rem = rem - (b * 4)
    g_spooner_collision = (rem >= 2)
    IF g_spooner_collision rem = rem - 2 ENDIF
    g_spooner_freeze_pos = (rem >= 1)
    g_spooner_bone_choice = b
    g_spooner_attach_x = (TO_FLOAT(ax) * 0.05) - 5.0
    g_spooner_attach_y = (TO_FLOAT(ay) * 0.05) - 5.0
    g_spooner_attach_z = (TO_FLOAT(az) * 0.05) - 5.0

    INT rotRem = g_spooner_obj_rot[idx]
    INT y = rotRem / 16384
    rotRem = rotRem - (y * 16384)
    INT r = rotRem / 128
    rotRem = rotRem - (r * 128)
    INT p = rotRem
    g_spooner_attach_pitch = (TO_FLOAT(p) * 5.0) - 180.0
    g_spooner_attach_roll  = (TO_FLOAT(r) * 5.0) - 180.0
    g_spooner_attach_yaw   = (TO_FLOAT(y) * 5.0) - 180.0
ENDPROC

// ---------------------------------------------------------------------------
// LIVE PROP PREVIEW & OPACITY (0..100)
// ---------------------------------------------------------------------------

FUNC MODEL_NAMES CURRENT_SPOONER_PREVIEW_MODEL()
    IF g_spooner_use_custom_preview AND g_spooner_custom_preview_model != DUMMY_MODEL_FOR_SCRIPT
        RETURN g_spooner_custom_preview_model
    ENDIF
    RETURN SPOONER_CATALOG_MODEL(g_spooner_catalog_index)
ENDFUNC

// Maps g_spooner_preview_opacity (0..100) to RAGE entity visibility and alpha:
//   0   -> completely transparent and hidden so the player cannot see it.
//   100 -> 100% opaque full texture (RESET_ENTITY_ALPHA).
//   1-99 -> scaled 1..254 alpha.
PROC APPLY_SPOONER_PREVIEW_OPACITY()
    IF NOT DOES_ENTITY_EXIST(g_spooner_preview_object) EXIT ENDIF
    IF g_spooner_preview_opacity <= 0
        SET_ENTITY_ALPHA(g_spooner_preview_object, 0, FALSE)
        SET_ENTITY_VISIBLE(g_spooner_preview_object, FALSE, FALSE)
    ELIF g_spooner_preview_opacity >= 100
        SET_ENTITY_VISIBLE(g_spooner_preview_object, TRUE, FALSE)
        RESET_ENTITY_ALPHA(g_spooner_preview_object)
    ELSE
        SET_ENTITY_VISIBLE(g_spooner_preview_object, TRUE, FALSE)
        INT alphaVal = (g_spooner_preview_opacity * 255) / 100
        IF alphaVal < 1 alphaVal = 1 ENDIF
        IF alphaVal > 254 alphaVal = 254 ENDIF
        SET_ENTITY_ALPHA(g_spooner_preview_object, alphaVal, FALSE)
    ENDIF
ENDPROC

PROC CLEANUP_SPOONER_PREVIEW()
    IF g_spooner_preview_object = NULL AND g_spooner_preview_model = DUMMY_MODEL_FOR_SCRIPT AND g_spooner_preview_request_time = 0
        EXIT
    ENDIF
    IF DOES_ENTITY_EXIST(g_spooner_preview_object)
        SET_ENTITY_AS_MISSION_ENTITY(g_spooner_preview_object, TRUE, TRUE)
        DELETE_OBJECT(g_spooner_preview_object)
    ENDIF
    g_spooner_preview_object = NULL
    IF g_spooner_preview_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_preview_model)
        g_spooner_preview_model = DUMMY_MODEL_FOR_SCRIPT
    ENDIF
    g_spooner_preview_request_time = 0
ENDPROC

PROC SYNC_SPOONER_PREVIEW_MODEL()
    MODEL_NAMES wantedModel = CURRENT_SPOONER_PREVIEW_MODEL()
    IF wantedModel != g_spooner_preview_model
        CLEANUP_SPOONER_PREVIEW()
        g_spooner_preview_model = wantedModel
    ENDIF
ENDPROC

// Maintains a static, collisionless prop preview in front of the player while
// inside the Object Spooner submenu, and cleans it up immediately upon exit.
PROC PROCESS_SPOONER_PREVIEW()
    IF NOT g_open OR NOT g_spooner_open
        CLEANUP_SPOONER_PREVIEW()
        EXIT
    ENDIF
    IF g_spooner_spawn_pending EXIT ENDIF
    SYNC_SPOONER_PREVIEW_MODEL()
    IF NOT IS_MODEL_IN_CDIMAGE(g_spooner_preview_model) OR NOT IS_MODEL_VALID(g_spooner_preview_model)
        EXIT
    ENDIF

    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR previewPosition = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<g_spooner_side_offset, g_spooner_forward_offset, g_spooner_height_offset>>)
    FLOAT previewHeading = GET_ENTITY_HEADING(playerPed) + g_spooner_heading_offset
    WHILE previewHeading >= 360.0
        previewHeading = previewHeading - 360.0
    ENDWHILE
    WHILE previewHeading < 0.0
        previewHeading = previewHeading + 360.0
    ENDWHILE

    IF NOT DOES_ENTITY_EXIST(g_spooner_preview_object)
        IF NOT HAS_MODEL_LOADED(g_spooner_preview_model)
            IF g_spooner_preview_request_time = 0
                REQUEST_MODEL(g_spooner_preview_model)
                g_spooner_preview_request_time = GET_GAME_TIMER()
            ELIF GET_GAME_TIMER() > g_spooner_preview_request_time + 8000
                SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_preview_model)
                g_spooner_preview_request_time = 0
            ENDIF
            EXIT
        ENDIF
        g_spooner_preview_object = CREATE_OBJECT_NO_OFFSET(g_spooner_preview_model, previewPosition, FALSE, TRUE, FALSE)
        IF DOES_ENTITY_EXIST(g_spooner_preview_object)
            SET_ENTITY_AS_MISSION_ENTITY(g_spooner_preview_object, TRUE, TRUE)
            SET_ENTITY_HEADING(g_spooner_preview_object, previewHeading)
            SET_ENTITY_DYNAMIC(g_spooner_preview_object, FALSE)
            FREEZE_ENTITY_POSITION(g_spooner_preview_object, TRUE)
            SET_ENTITY_COLLISION(g_spooner_preview_object, FALSE, FALSE)
            SET_ENTITY_CAN_BE_DAMAGED(g_spooner_preview_object, FALSE)
            SET_ENTITY_PROOFS(g_spooner_preview_object, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
            APPLY_SPOONER_PREVIEW_OPACITY()
        ENDIF
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_preview_model)
        g_spooner_preview_request_time = 0
        EXIT
    ENDIF

    SET_ENTITY_COORDS_NO_OFFSET(g_spooner_preview_object, previewPosition, FALSE, FALSE, TRUE)
    SET_ENTITY_HEADING(g_spooner_preview_object, previewHeading)
    FREEZE_ENTITY_POSITION(g_spooner_preview_object, TRUE)
    SET_ENTITY_COLLISION(g_spooner_preview_object, FALSE, FALSE)
    APPLY_SPOONER_PREVIEW_OPACITY()
ENDPROC

// Requests the model into streaming memory and stages instantiation for the
// main script loop once HAS_MODEL_LOADED verifies readiness.
PROC QUEUE_SPOONER_OBJECT_SPAWN(MODEL_NAMES model)
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count >= SPOONER_MAX_OBJECTS
        g_spooner_feedback_code = 3
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
        EXIT
    ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(model) OR NOT IS_MODEL_VALID(model)
        g_spooner_feedback_code = 2
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
        EXIT
    ENDIF
    CLEANUP_SPOONER_PREVIEW()
    IF g_spooner_spawn_pending AND g_spooner_pending_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
    ENDIF
    REQUEST_MODEL(model)
    g_spooner_pending_model = model
    g_spooner_spawn_start_ms = GET_GAME_TIMER()
    g_spooner_spawn_pending = TRUE
ENDPROC

// ---------------------------------------------------------------------------
// 2. OFFSET POSITIONING VARIABLE SLIDERS
// ---------------------------------------------------------------------------

// Calculates placement relative to the player's matrix/coordinates using
// Side (X), Forward (Y), Height (Z), and Heading Rotation offsets and updates
// the active object in the world.
PROC APPLY_SPOONER_OFFSET_TO_SELECTED()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF

    IF IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
    ENDIF

    PED_INDEX playerPed = PLAYER_PED_ID()
    VECTOR targetPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<g_spooner_side_offset, g_spooner_forward_offset, g_spooner_height_offset>>)
    FLOAT targetHeading = GET_ENTITY_HEADING(playerPed) + g_spooner_heading_offset
    WHILE targetHeading >= 360.0
        targetHeading = targetHeading - 360.0
    ENDWHILE
    WHILE targetHeading < 0.0
        targetHeading = targetHeading + 360.0
    ENDWHILE

    SET_ENTITY_COORDS_NO_OFFSET(obj, targetPos, FALSE, FALSE, TRUE)
    SET_ENTITY_HEADING(obj, targetHeading)
    FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
    SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
ENDPROC

// Main-loop non-blocking streaming poll. Waits until HAS_MODEL_LOADED is true
// (with an 8000ms safety timeout), instantiates the object at the player-matrix
// offset, records it in g_spooner_objects, and releases the model reference.
PROC PROCESS_SPOONER_SPAWN_QUEUE()
    IF NOT g_spooner_spawn_pending EXIT ENDIF

    IF HAS_MODEL_LOADED(g_spooner_pending_model)
        COMPACT_SPOONER_POOL()
        IF g_spooner_object_count < SPOONER_MAX_OBJECTS
            PED_INDEX playerPed = PLAYER_PED_ID()
            VECTOR spawnPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, <<g_spooner_side_offset, g_spooner_forward_offset, g_spooner_height_offset>>)
            FLOAT spawnHeading = GET_ENTITY_HEADING(playerPed) + g_spooner_heading_offset
            WHILE spawnHeading >= 360.0
                spawnHeading = spawnHeading - 360.0
            ENDWHILE
            WHILE spawnHeading < 0.0
                spawnHeading = spawnHeading + 360.0
            ENDWHILE

            OBJECT_INDEX newObj = CREATE_OBJECT_NO_OFFSET(g_spooner_pending_model, spawnPos, FALSE, TRUE, FALSE)
            IF DOES_ENTITY_EXIST(newObj)
                SET_ENTITY_AS_MISSION_ENTITY(newObj, TRUE, TRUE)
                SET_ENTITY_HEADING(newObj, spawnHeading)
                SET_ENTITY_DYNAMIC(newObj, NOT g_spooner_freeze_pos)
                FREEZE_ENTITY_POSITION(newObj, g_spooner_freeze_pos)
                SET_ENTITY_COLLISION(newObj, g_spooner_collision, FALSE)

                INT slot = g_spooner_object_count
                g_spooner_objects[slot]   = newObj
                g_spooner_obj_flags[slot] = PACK_SPOONER_OBJ_FLAGS(g_spooner_freeze_pos, g_spooner_collision, g_spooner_bone_choice, g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z)
                g_spooner_obj_rot[slot]   = PACK_SPOONER_OBJ_ROT(g_spooner_attach_pitch, g_spooner_attach_roll, g_spooner_attach_yaw)

                g_spooner_object_count = g_spooner_object_count + 1
                g_spooner_selected_index = slot
                g_spooner_feedback_code = 1
                g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
            ENDIF
        ENDIF
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
    ELIF (GET_GAME_TIMER() - g_spooner_spawn_start_ms) > 8000
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
        g_spooner_feedback_code = 2
        g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
    ENDIF
ENDPROC

// ---------------------------------------------------------------------------
// 3. PHYSICS & PROPERTY TOGGLES
// ---------------------------------------------------------------------------

PROC TOGGLE_SPOONER_FREEZE_POSITION()
    g_spooner_freeze_pos = NOT g_spooner_freeze_pos
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF DOES_ENTITY_EXIST(obj)
        g_spooner_obj_flags[idx] = PACK_SPOONER_OBJ_FLAGS(g_spooner_freeze_pos, g_spooner_collision, g_spooner_bone_choice, g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z)
        SET_ENTITY_DYNAMIC(obj, NOT g_spooner_freeze_pos)
        FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
        IF NOT g_spooner_freeze_pos
            SET_ACTIVATE_OBJECT_PHYSICS_AS_SOON_AS_IT_IS_UNFROZEN(obj, TRUE)
        ENDIF
    ENDIF
ENDPROC

PROC TOGGLE_SPOONER_COLLISION()
    g_spooner_collision = NOT g_spooner_collision
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF DOES_ENTITY_EXIST(obj)
        g_spooner_obj_flags[idx] = PACK_SPOONER_OBJ_FLAGS(g_spooner_freeze_pos, g_spooner_collision, g_spooner_bone_choice, g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z)
        SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
    ENDIF
ENDPROC

PROC SNAP_SPOONER_OBJECT_TO_GROUND()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF

    IF IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
    ENDIF

    // Queries terrain collision height and snaps object cleanly to the surface
    IF NOT PLACE_OBJECT_ON_GROUND_PROPERLY(obj)
        VECTOR pos = GET_ENTITY_COORDS(obj)
        FLOAT groundZ = pos.z
        IF GET_GROUND_Z_FOR_3D_COORD(<<pos.x, pos.y, pos.z + 50.0>>, groundZ)
            SET_ENTITY_COORDS_NO_OFFSET(obj, <<pos.x, pos.y, groundZ>>, FALSE, FALSE, TRUE)
        ENDIF
    ENDIF

    VECTOR finalPos = GET_ENTITY_COORDS(obj)
    VECTOR playerPos = GET_ENTITY_COORDS(PLAYER_PED_ID())
    g_spooner_height_offset = finalPos.z - playerPos.z
    FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
ENDPROC

// ---------------------------------------------------------------------------
// 4. ATTACHMENT MANAGER
// ---------------------------------------------------------------------------

FUNC PED_BONETAG SPOONER_BONE_TAG_FROM_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN BONETAG_PELVIS
        CASE 1 RETURN BONETAG_SPINE3
        CASE 2 RETURN BONETAG_HEAD
        CASE 3 RETURN BONETAG_PH_R_HAND
        CASE 4 RETURN BONETAG_PH_L_HAND
        CASE 5 RETURN BONETAG_R_FOOT
        CASE 6 RETURN BONETAG_L_FOOT
        CASE 7 RETURN BONETAG_NECK
        CASE 8 RETURN BONETAG_ROOT
    ENDSWITCH
    RETURN BONETAG_PELVIS
ENDFUNC

FUNC STRING SPOONER_BONE_CHOICE_LABEL(INT choice)
    SWITCH choice
        CASE 0 RETURN TR("< Pelvis (11816) >", "< Pelvis (11816) >", "< 骨盆 (11816) >", "< Becken (11816) >", "< 骨盤 (11816) >", "< Таз (11816) >", "< Pélvis (11816) >", "< Bassin (11816) >")
        CASE 1 RETURN TR("< Spine 3 (24818) >", "< Columna 3 (24818) >", "< 脊椎 3 (24818) >", "< Wirbelsäule 3 (24818) >", "< 背骨3 (24818) >", "< Позвоночник 3 (24818) >", "< Coluna 3 (24818) >", "< Colonne 3 (24818) >")
        CASE 2 RETURN TR("< Head (31086) >", "< Cabeza (31086) >", "< 头部 (31086) >", "< Kopf (31086) >", "< 頭 (31086) >", "< Голова (31086) >", "< Cabeça (31086) >", "< Tête (31086) >")
        CASE 3 RETURN TR("< Right Hand (28422) >", "< Mano derecha (28422) >", "< 右手 (28422) >", "< Rechte Hand (28422) >", "< 右手 (28422) >", "< Правая рука (28422) >", "< Mão Direita (28422) >", "< Main droite (28422) >")
        CASE 4 RETURN TR("< Left Hand (60309) >", "< Mano izquierda (60309) >", "< 左手 (60309) >", "< Linke Hand (60309) >", "< 左手 (60309) >", "< Левая рука (60309) >", "< Mão Esquerda (60309) >", "< Main gauche (60309) >")
        CASE 5 RETURN TR("< Right Foot (52301) >", "< Pie derecho (52301) >", "< 右脚 (52301) >", "< Rechter Fuß (52301) >", "< 右足 (52301) >", "< Правая стопа (52301) >", "< Pé Direito (52301) >", "< Pied droit (52301) >")
        CASE 6 RETURN TR("< Left Foot (14201) >", "< Pie izquierdo (14201) >", "< 左脚 (14201) >", "< Linker Fuß (14201) >", "< 左足 (14201) >", "< Левая стопа (14201) >", "< Pé Esquerdo (14201) >", "< Pied gauche (14201) >")
        CASE 7 RETURN TR("< Neck (39317) >", "< Cuello (39317) >", "< 颈部 (39317) >", "< Hals (39317) >", "< 首 (39317) >", "< Шея (39317) >", "< Pescoço (39317) >", "< Cou (39317) >")
        CASE 8 RETURN TR("< Skeleton Root (0) >", "< Raíz del esqueleto (0) >", "< 骨骼根部 (0) >", "< Skelett-Wurzel (0) >", "< スケルトンルート (0) >", "< Корень скелета (0) >", "< Raiz do Esqueleto (0) >", "< Racine du squelette (0) >")
        CASE 9 RETURN TR("< Player Vehicle >", "< Vehículo del jugador >", "< 玩家载具 >", "< Spielerfahrzeug >", "< プレイヤー車両 >", "< Транспорт игрока >", "< Veículo do Jogador >", "< Véhicule du joueur >")
    ENDSWITCH
    RETURN TR("< Pelvis (11816) >", "< Pelvis (11816) >", "< 骨盆 (11816) >", "< Becken (11816) >", "< 骨盤 (11816) >", "< Таз (11816) >", "< Pélvis (11816) >", "< Bassin (11816) >")
ENDFUNC

// Pins the selected prop (or player vehicle if no prop is spawned) to the
// target entity/bone using relative X/Y/Z and Pitch/Roll/Yaw offsets, or
// detaches if already attached when forceAttach is FALSE.
PROC APPLY_SPOONER_ATTACHMENT(BOOL forceAttach)
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF
    INT idx = g_spooner_selected_index
    OBJECT_INDEX obj = g_spooner_objects[idx]
    IF NOT DOES_ENTITY_EXIST(obj) EXIT ENDIF

    g_spooner_obj_flags[idx] = PACK_SPOONER_OBJ_FLAGS(g_spooner_freeze_pos, g_spooner_collision, g_spooner_bone_choice, g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z)
    g_spooner_obj_rot[idx]   = PACK_SPOONER_OBJ_ROT(g_spooner_attach_pitch, g_spooner_attach_roll, g_spooner_attach_yaw)

    IF NOT forceAttach AND IS_ENTITY_ATTACHED(obj)
        DETACH_ENTITY(obj, FALSE, TRUE)
        FREEZE_ENTITY_POSITION(obj, g_spooner_freeze_pos)
        SET_ENTITY_COLLISION(obj, g_spooner_collision, FALSE)
        EXIT
    ENDIF

    PED_INDEX playerPed = PLAYER_PED_ID()
    ENTITY_INDEX targetEntity = playerPed
    INT boneIndex = 0

    IF g_spooner_bone_choice = 9
        IF NOT IS_PED_IN_ANY_VEHICLE(playerPed)
            EXIT
        ENDIF
        targetEntity = GET_VEHICLE_PED_IS_IN(playerPed)
        boneIndex = 0
    ELSE
        boneIndex = GET_PED_BONE_INDEX(playerPed, SPOONER_BONE_TAG_FROM_CHOICE(g_spooner_bone_choice))
    ENDIF

    ATTACH_ENTITY_TO_ENTITY(obj, targetEntity, boneIndex, <<g_spooner_attach_x, g_spooner_attach_y, g_spooner_attach_z>>, <<g_spooner_attach_pitch, g_spooner_attach_roll, g_spooner_attach_yaw>>, FALSE, FALSE, g_spooner_collision, TRUE, EULER_YXZ, TRUE)
ENDPROC

// ---------------------------------------------------------------------------
// 5. SWITCH MEMORY MANAGEMENT
// ---------------------------------------------------------------------------

// Pulls the latest entity pointer from g_spooner_objects, safely removes it
// from the active world pool, and decrements g_spooner_object_count.
PROC DELETE_SPOONER_LAST_OBJECT()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0 EXIT ENDIF

    INT lastIdx = g_spooner_object_count - 1
    OBJECT_INDEX obj = g_spooner_objects[lastIdx]
    IF DOES_ENTITY_EXIST(obj)
        IF IS_ENTITY_ATTACHED(obj)
            DETACH_ENTITY(obj, FALSE, FALSE)
        ENDIF
        SET_ENTITY_AS_MISSION_ENTITY(obj, TRUE, TRUE)
        DELETE_OBJECT(obj)
    ENDIF
    g_spooner_objects[lastIdx] = NULL
    g_spooner_object_count = lastIdx

    IF g_spooner_selected_index >= g_spooner_object_count
        g_spooner_selected_index = g_spooner_object_count - 1
    ENDIF
    IF g_spooner_selected_index < 0
        g_spooner_selected_index = 0
    ENDIF
    SYNC_SPOONER_UI_FROM_SELECTED()

    g_spooner_feedback_code = 4
    g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
ENDPROC

// Safely removes every tracked entity in g_spooner_objects and resets pool count.
PROC CLEAR_ALL_SPOONER_OBJECTS()
    INT i = g_spooner_object_count - 1
    WHILE i >= 0
        OBJECT_INDEX obj = g_spooner_objects[i]
        IF DOES_ENTITY_EXIST(obj)
            IF IS_ENTITY_ATTACHED(obj)
                DETACH_ENTITY(obj, FALSE, FALSE)
            ENDIF
            SET_ENTITY_AS_MISSION_ENTITY(obj, TRUE, TRUE)
            DELETE_OBJECT(obj)
        ENDIF
        g_spooner_objects[i] = NULL
        i = i - 1
    ENDWHILE
    g_spooner_object_count = 0
    g_spooner_selected_index = 0

    IF g_spooner_spawn_pending AND g_spooner_pending_model != DUMMY_MODEL_FOR_SCRIPT
        SET_MODEL_AS_NO_LONGER_NEEDED(g_spooner_pending_model)
        g_spooner_pending_model = DUMMY_MODEL_FOR_SCRIPT
        g_spooner_spawn_pending = FALSE
    ENDIF

    g_spooner_feedback_code = 5
    g_spooner_feedback_until = GET_GAME_TIMER() + SPOONER_FEEDBACK_MS
ENDPROC

// ---------------------------------------------------------------------------
// UI ROW FORMATTERS & DRAW HELPERS
// ---------------------------------------------------------------------------

FUNC STRING SPOONER_SPAWN_STATUS_LABEL()
    IF g_spooner_spawn_pending
        RETURN TR("LOADING", "CARGANDO", "加载中", "LÄDT", "読込中", "ЗАГРУЗКА", "CARREGANDO", "CHARGEMENT")
    ENDIF
    IF GET_GAME_TIMER() < g_spooner_feedback_until
        IF g_spooner_feedback_code = 1 RETURN TR("SPAWNED", "GENERADO", "已生成", "GESPAWNT", "出現済", "СОЗДАНО", "GERADO", "CRÉÉ") ENDIF
        IF g_spooner_feedback_code = 2 RETURN TR("INVALID", "INVÁLIDO", "无效", "UNGÜLTIG", "無効", "НЕВЕРНО", "INVÁLIDO", "INVALIDE") ENDIF
        IF g_spooner_feedback_code = 3 RETURN TR("POOL FULL", "LÍMITE LLENO", "对象池已满", "LIMIT VOLL", "上限到達", "ПУЛ ПОЛОН", "LIMITE CHEIO", "LIMITE ATTEINTE") ENDIF
    ENDIF
    RETURN TR("APPLY", "APLICAR", "应用", "ANWENDEN", "適用", "ПРИМЕНИТЬ", "APLICAR", "APPLIQUER")
ENDFUNC

FUNC STRING SPOONER_CUSTOM_INPUT_LABEL()
    IF g_spooner_spawn_pending
        RETURN TR("LOADING", "CARGANDO", "加载中", "LÄDT", "読込中", "ЗАГРУЗКА", "CARREGANDO", "CHARGEMENT")
    ENDIF
    IF GET_GAME_TIMER() < g_spooner_feedback_until AND g_spooner_feedback_code = 2
        RETURN TR("NOT FOUND", "NO ENCONTRADO", "未找到", "NICHT GEFUNDEN", "見つかりません", "НЕ НАЙДЕНО", "NÃO ENCONTRADO", "INTROUVABLE")
    ENDIF
    IF NOT IS_STRING_NULL_OR_EMPTY(g_spooner_custom_model_input)
        RETURN TR("INPUT", "ENTRADA", "输入", "EINGABE", "入力", "ВВОД", "ENTRADA", "ENTRÉE")
    ENDIF
    RETURN TR("INPUT", "ENTRADA", "输入", "EINGABE", "入力", "ВВОД", "ENTRADA", "ENTRÉE")
ENDFUNC

FUNC STRING SPOONER_ATTACH_ACTION_LABEL()
    COMPACT_SPOONER_POOL()
    IF g_spooner_object_count <= 0
        RETURN TR("NO OBJECT", "SIN OBJETO", "无物体", "KEIN OBJEKT", "オブジェクトなし", "НЕТ ОБЪЕКТА", "SEM OBJETO", "AUCUN OBJET")
    ENDIF
    IF IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
        RETURN TR("ATTACHED", "ACOPLADO", "已附着", "BEFESTIGT", "装着中", "ПРИКРЕПЛЕНО", "ACOPLADO", "ATTACHÉ")
    ENDIF
    RETURN TR("DETACHED", "SUELTO", "已分离", "GELÖST", "分離済", "ОТКРЕПЛЕНО", "DESACOPLADO", "DÉTACHÉ")
ENDFUNC

FUNC INT SPOONER_ATTACH_ACTION_STATE()
    IF g_spooner_object_count <= 0
        RETURN -1
    ENDIF
    IF IS_ENTITY_ATTACHED(g_spooner_objects[g_spooner_selected_index])
        RETURN 1
    ENDIF
    RETURN 0
ENDFUNC

// Draws the "Selected Object" selector row (< #1 / 5 > or < None (0/32) >)
// using TEXT_LABEL_63 integer composition for Switch render safety.
PROC DRAW_SPOONER_SELECTED_OBJECT_ROW(FLOAT y, BOOL selected)
    COMPACT_SPOONER_POOL()
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        rr = g_accent_r
        gg = g_accent_g
        bb = g_accent_b
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, TR("Selected Object", "Objeto seleccionado", "所选物体", "Ausgewähltes Objekt", "選択中のオブジェクト", "Выбранный объект", "Objeto Selecionado", "Objet sélectionné"))

    TEXT_LABEL_63 valText = TR("< None (0/", "< Ninguno (0/", "< 无 (0/", "< Keins (0/", "< なし (0/", "< Нет (0/", "< Nenhum (0/", "< Aucun (0/")
    IF g_spooner_object_count > 0
        valText = "< #"
        valText += (g_spooner_selected_index + 1)
        valText += " / "
        valText += g_spooner_object_count
        valText += " >"
    ELSE
        valText += SPOONER_MAX_OBJECTS
        valText += ") >"
    ENDIF

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

// Draws a metre offset slider row (< 2.50m >, < -0.75m >) using integer
// TEXT_LABEL_63 composition so float values never render blank on Switch.
PROC DRAW_SPOONER_METRE_OPTION(FLOAT y, STRING label, FLOAT value, BOOL selected)
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

    INT totalCenti = ROUND(value * 100.0)
    BOOL isNeg = FALSE
    IF totalCenti < 0
        isNeg = TRUE
        totalCenti = 0 - totalCenti
    ENDIF
    INT wholeMetres = totalCenti / 100
    INT fracCenti = totalCenti - (wholeMetres * 100)

    TEXT_LABEL_63 valText = "< "
    IF isNeg
        valText += "-"
    ENDIF
    valText += wholeMetres
    valText += "."
    IF fracCenti < 10
        valText += "0"
    ENDIF
    valText += fracCenti
    valText += "m >"

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

// Draws a degree rotation slider row (< 90 deg > or < Pitch: 15 deg >).
PROC DRAW_SPOONER_DEGREE_OPTION(FLOAT y, STRING label, STRING prefix, FLOAT degrees, BOOL selected)
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

    INT degInt = ROUND(degrees)
    TEXT_LABEL_63 valText = "< "
    IF NOT IS_STRING_NULL_OR_EMPTY(prefix)
        valText += prefix
        valText += ": "
    ENDIF
    valText += degInt
    valText += " deg >"

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

// Draws the combined Pitch / Roll / Yaw rotational offset slider row.
PROC DRAW_SPOONER_ROT_AXIS_ROW(FLOAT y, BOOL selected)
    IF g_spooner_rot_axis = 0
        DRAW_SPOONER_DEGREE_OPTION(y, TR("Attach Rotation", "Rotación de acople", "附着旋转", "Befestigungsrotation", "装着回転", "Вращение крепления", "Rotação de Acoplamento", "Rotation d'attache"), TR("Pitch", "Cabeceo", "俯仰", "Nicken", "ピッチ", "Тангаж", "Arfagem", "Tangage"), g_spooner_attach_pitch, selected)
    ELIF g_spooner_rot_axis = 1
        DRAW_SPOONER_DEGREE_OPTION(y, TR("Attach Rotation", "Rotación de acople", "附着旋转", "Befestigungsrotation", "装着回転", "Вращение крепления", "Rotação de Acoplamento", "Rotation d'attache"), TR("Roll", "Alabeo", "横滚", "Rollen", "ロール", "Крен", "Rolagem", "Roulis"), g_spooner_attach_roll, selected)
    ELSE
        DRAW_SPOONER_DEGREE_OPTION(y, TR("Attach Rotation", "Rotación de acople", "附着旋转", "Befestigungsrotation", "装着回転", "Вращение крепления", "Rotação de Acoplamento", "Rotation d'attache"), TR("Yaw", "Guiñada", "偏航", "Gieren", "ヨー", "Рыскание", "Guinada", "Lacet"), g_spooner_attach_yaw, selected)
    ENDIF
ENDPROC

// Draws the "Preview Opacity" Left/Right selector row (< 0 > .. < 100 >).
PROC DRAW_SPOONER_PREVIEW_OPACITY_ROW(FLOAT y, BOOL selected)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        rr = g_accent_r
        gg = g_accent_g
        bb = g_accent_b
    ENDIF
    DRAW_RECT(g_menu_x - 0.015, y + g_menu_y, MENU_W - 0.012, ROW_H - 0.002, rr, gg, bb, 238)
    MENU_TEXT(g_menu_x - 0.130, y - 0.012, 0.315, 255, 255, 255, TR("Preview Opacity", "Opacidad de vista previa", "预览不透明度", "Vorschau-Deckkraft", "プレビュー不透明度", "Непрозрачность превью", "Opacidade da Prévia", "Opacité de l'aperçu"))

    TEXT_LABEL_63 valText = "< "
    valText += g_spooner_preview_opacity
    valText += " >"

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.290, 0.290)
    SET_TEXT_COLOUR(210, 230, 255, 255)
    SET_TEXT_WRAP(0.0, g_menu_x + 0.086)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(valText)
    END_TEXT_COMMAND_DISPLAY_TEXT(g_menu_x + 0.086, y - 0.012 + g_menu_y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC
