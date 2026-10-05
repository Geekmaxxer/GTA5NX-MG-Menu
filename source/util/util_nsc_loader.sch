FUNC INT STOCK_NSC_BASELINE_COUNT()
    RETURN 1026
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_0(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("abigail1") RETURN TRUE BREAK
        CASE HASH("abigail2") RETURN TRUE BREAK
        CASE HASH("achievement_controller") RETURN TRUE BREAK
        CASE HASH("act_cinema") RETURN TRUE BREAK
        CASE HASH("activity_creator_prototype_launcher") RETURN TRUE BREAK
        CASE HASH("af_intro_t_sandy") RETURN TRUE BREAK
        CASE HASH("agency_heist1") RETURN TRUE BREAK
        CASE HASH("agency_heist2") RETURN TRUE BREAK
        CASE HASH("agency_heist3a") RETURN TRUE BREAK
        CASE HASH("agency_heist3b") RETURN TRUE BREAK
        CASE HASH("agency_prep1") RETURN TRUE BREAK
        CASE HASH("agency_prep2amb") RETURN TRUE BREAK
        CASE HASH("aicover_test") RETURN TRUE BREAK
        CASE HASH("ainewengland_test") RETURN TRUE BREAK
        CASE HASH("altruist_cult") RETURN TRUE BREAK
        CASE HASH("am_agency_suv") RETURN TRUE BREAK
        CASE HASH("am_airstrike") RETURN TRUE BREAK
        CASE HASH("am_ammo_drop") RETURN TRUE BREAK
        CASE HASH("am_arena_shp") RETURN TRUE BREAK
        CASE HASH("am_armwrestling") RETURN TRUE BREAK
        CASE HASH("am_armwrestling_apartment") RETURN TRUE BREAK
        CASE HASH("am_armybase") RETURN TRUE BREAK
        CASE HASH("am_backup_heli") RETURN TRUE BREAK
        CASE HASH("am_beach_washup_cinematic") RETURN TRUE BREAK
        CASE HASH("am_boat_taxi") RETURN TRUE BREAK
        CASE HASH("am_bru_box") RETURN TRUE BREAK
        CASE HASH("am_car_mod_tut") RETURN TRUE BREAK
        CASE HASH("am_casino_limo") RETURN TRUE BREAK
        CASE HASH("am_casino_luxury_car") RETURN TRUE BREAK
        CASE HASH("am_casino_peds") RETURN TRUE BREAK
        CASE HASH("am_challenges") RETURN TRUE BREAK
        CASE HASH("am_contact_requests") RETURN TRUE BREAK
        CASE HASH("am_cp_collection") RETURN TRUE BREAK
        CASE HASH("am_crate_drop") RETURN TRUE BREAK
        CASE HASH("am_criminal_damage") RETURN TRUE BREAK
        CASE HASH("am_darts") RETURN TRUE BREAK
        CASE HASH("am_darts_apartment") RETURN TRUE BREAK
        CASE HASH("am_dead_drop") RETURN TRUE BREAK
        CASE HASH("am_destroy_veh") RETURN TRUE BREAK
        CASE HASH("am_distract_cops") RETURN TRUE BREAK
        CASE HASH("am_doors") RETURN TRUE BREAK
        CASE HASH("am_ferriswheel") RETURN TRUE BREAK
        CASE HASH("am_ga_pickups") RETURN TRUE BREAK
        CASE HASH("am_gang_call") RETURN TRUE BREAK
        CASE HASH("am_heist_int") RETURN TRUE BREAK
        CASE HASH("am_heli_taxi") RETURN TRUE BREAK
        CASE HASH("am_hi_plane_land_cinematic") RETURN TRUE BREAK
        CASE HASH("am_hi_plane_take_off_cinematic") RETURN TRUE BREAK
        CASE HASH("am_hold_up") RETURN TRUE BREAK
        CASE HASH("am_hot_property") RETURN TRUE BREAK
        CASE HASH("am_hot_target") RETURN TRUE BREAK
        CASE HASH("am_hs4_isd_take_vel") RETURN TRUE BREAK
        CASE HASH("am_hs4_lsa_land_nimb_arrive") RETURN TRUE BREAK
        CASE HASH("am_hs4_lsa_land_vel") RETURN TRUE BREAK
        CASE HASH("am_hs4_lsa_take_vel") RETURN TRUE BREAK
        CASE HASH("am_hs4_nimb_isd_lsa_leave") RETURN TRUE BREAK
        CASE HASH("am_hs4_nimb_lsa_isd_arrive") RETURN TRUE BREAK
        CASE HASH("am_hs4_nimb_lsa_isd_leave") RETURN TRUE BREAK
        CASE HASH("am_hs4_vel_lsa_isd") RETURN TRUE BREAK
        CASE HASH("am_hunt_the_beast") RETURN TRUE BREAK
        CASE HASH("am_imp_exp") RETURN TRUE BREAK
        CASE HASH("am_island_backup_heli") RETURN TRUE BREAK
        CASE HASH("am_joyrider") RETURN TRUE BREAK
        CASE HASH("am_kill_list") RETURN TRUE BREAK
        CASE HASH("am_king_of_the_castle") RETURN TRUE BREAK
        CASE HASH("am_launcher") RETURN TRUE BREAK
        CASE HASH("am_lester_cut") RETURN TRUE BREAK
        CASE HASH("am_lowrider_int") RETURN TRUE BREAK
        CASE HASH("am_lsia_take_off_cinematic") RETURN TRUE BREAK
        CASE HASH("am_luxury_showroom") RETURN TRUE BREAK
        CASE HASH("am_mission_launch") RETURN TRUE BREAK
        CASE HASH("am_mp_acid_lab") RETURN TRUE BREAK
        CASE HASH("am_mp_arc_cab_manager") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade_claw_crane") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade_fortune_teller") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade_love_meter") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade_peds") RETURN TRUE BREAK
        CASE HASH("am_mp_arcade_strength_test") RETURN TRUE BREAK
        CASE HASH("am_mp_arena_box") RETURN TRUE BREAK
        CASE HASH("am_mp_arena_garage") RETURN TRUE BREAK
        CASE HASH("am_mp_armory_aircraft") RETURN TRUE BREAK
        CASE HASH("am_mp_armory_truck") RETURN TRUE BREAK
        CASE HASH("am_mp_auto_shop") RETURN TRUE BREAK
        CASE HASH("am_mp_biker_warehouse") RETURN TRUE BREAK
        CASE HASH("am_mp_boardroom_seating") RETURN TRUE BREAK
        CASE HASH("am_mp_bunker") RETURN TRUE BREAK
        CASE HASH("am_mp_business_hub") RETURN TRUE BREAK
        CASE HASH("am_mp_car_meet_property") RETURN TRUE BREAK
        CASE HASH("am_mp_car_meet_sandbox") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_1(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("am_mp_carwash_launch") RETURN TRUE BREAK
        CASE HASH("am_mp_casino") RETURN TRUE BREAK
        CASE HASH("am_mp_casino_apartment") RETURN TRUE BREAK
        CASE HASH("am_mp_casino_nightclub") RETURN TRUE BREAK
        CASE HASH("am_mp_casino_valet_garage") RETURN TRUE BREAK
        CASE HASH("am_mp_creator_aircraft") RETURN TRUE BREAK
        CASE HASH("am_mp_creator_trailer") RETURN TRUE BREAK
        CASE HASH("am_mp_defunct_base") RETURN TRUE BREAK
        CASE HASH("am_mp_drone") RETURN TRUE BREAK
        CASE HASH("am_mp_fixer_hq") RETURN TRUE BREAK
        CASE HASH("am_mp_garage_control") RETURN TRUE BREAK
        CASE HASH("am_mp_hacker_truck") RETURN TRUE BREAK
        CASE HASH("am_mp_hangar") RETURN TRUE BREAK
        CASE HASH("am_mp_ie_warehouse") RETURN TRUE BREAK
        CASE HASH("am_mp_island") RETURN TRUE BREAK
        CASE HASH("am_mp_juggalo_hideout") RETURN TRUE BREAK
        CASE HASH("am_mp_multistorey_garage") RETURN TRUE BREAK
        CASE HASH("am_mp_music_studio") RETURN TRUE BREAK
        CASE HASH("am_mp_nightclub") RETURN TRUE BREAK
        CASE HASH("am_mp_orbital_cannon") RETURN TRUE BREAK
        CASE HASH("am_mp_peds") RETURN TRUE BREAK
        CASE HASH("am_mp_property_ext") RETURN TRUE BREAK
        CASE HASH("am_mp_property_int") RETURN TRUE BREAK
        CASE HASH("am_mp_rc_vehicle") RETURN TRUE BREAK
        CASE HASH("am_mp_shooting_range") RETURN TRUE BREAK
        CASE HASH("am_mp_simeon_showroom") RETURN TRUE BREAK
        CASE HASH("am_mp_smoking_activity") RETURN TRUE BREAK
        CASE HASH("am_mp_smpl_interior_ext") RETURN TRUE BREAK
        CASE HASH("am_mp_smpl_interior_int") RETURN TRUE BREAK
        CASE HASH("am_mp_solomon_office") RETURN TRUE BREAK
        CASE HASH("am_mp_submarine") RETURN TRUE BREAK
        CASE HASH("am_mp_vehicle_reward") RETURN TRUE BREAK
        CASE HASH("am_mp_vehicle_weapon") RETURN TRUE BREAK
        CASE HASH("am_mp_warehouse") RETURN TRUE BREAK
        CASE HASH("am_mp_yacht") RETURN TRUE BREAK
        CASE HASH("am_npc_invites") RETURN TRUE BREAK
        CASE HASH("am_pass_the_parcel") RETURN TRUE BREAK
        CASE HASH("am_penned_in") RETURN TRUE BREAK
        CASE HASH("am_penthouse_peds") RETURN TRUE BREAK
        CASE HASH("am_pi_menu") RETURN TRUE BREAK
        CASE HASH("am_plane_takedown") RETURN TRUE BREAK
        CASE HASH("am_prison") RETURN TRUE BREAK
        CASE HASH("am_prostitute") RETURN TRUE BREAK
        CASE HASH("am_rollercoaster") RETURN TRUE BREAK
        CASE HASH("am_rontrevor_cut") RETURN TRUE BREAK
        CASE HASH("am_taxi") RETURN TRUE BREAK
        CASE HASH("am_vehicle_spawn") RETURN TRUE BREAK
        CASE HASH("ambient_diving") RETURN TRUE BREAK
        CASE HASH("ambient_mrsphilips") RETURN TRUE BREAK
        CASE HASH("ambient_solomon") RETURN TRUE BREAK
        CASE HASH("ambient_sonar") RETURN TRUE BREAK
        CASE HASH("ambient_tonya") RETURN TRUE BREAK
        CASE HASH("ambient_tonyacall") RETURN TRUE BREAK
        CASE HASH("ambient_tonyacall2") RETURN TRUE BREAK
        CASE HASH("ambient_tonyacall5") RETURN TRUE BREAK
        CASE HASH("ambient_ufos") RETURN TRUE BREAK
        CASE HASH("ambientblimp") RETURN TRUE BREAK
        CASE HASH("animal_controller") RETURN TRUE BREAK
        CASE HASH("apartment_minigame_launcher") RETURN TRUE BREAK
        CASE HASH("apparcadebusiness") RETURN TRUE BREAK
        CASE HASH("apparcadebusinesshub") RETURN TRUE BREAK
        CASE HASH("appbikerbusiness") RETURN TRUE BREAK
        CASE HASH("appbroadcast") RETURN TRUE BREAK
        CASE HASH("appbunkerbusiness") RETURN TRUE BREAK
        CASE HASH("appbusinesshub") RETURN TRUE BREAK
        CASE HASH("appcamera") RETURN TRUE BREAK
        CASE HASH("appchecklist") RETURN TRUE BREAK
        CASE HASH("appcontacts") RETURN TRUE BREAK
        CASE HASH("appcovertops") RETURN TRUE BREAK
        CASE HASH("appemail") RETURN TRUE BREAK
        CASE HASH("appextraction") RETURN TRUE BREAK
        CASE HASH("appfixersecurity") RETURN TRUE BREAK
        CASE HASH("apphackertruck") RETURN TRUE BREAK
        CASE HASH("apphs_sleep") RETURN TRUE BREAK
        CASE HASH("appimportexport") RETURN TRUE BREAK
        CASE HASH("appinternet") RETURN TRUE BREAK
        CASE HASH("appjipmp") RETURN TRUE BREAK
        CASE HASH("appmedia") RETURN TRUE BREAK
        CASE HASH("appmpbossagency") RETURN TRUE BREAK
        CASE HASH("appmpemail") RETURN TRUE BREAK
        CASE HASH("appmpjoblistnew") RETURN TRUE BREAK
        CASE HASH("apporganiser") RETURN TRUE BREAK
        CASE HASH("apprepeatplay") RETURN TRUE BREAK
        CASE HASH("appsecurohack") RETURN TRUE BREAK
        CASE HASH("appsecuroserv") RETURN TRUE BREAK
        CASE HASH("appsettings") RETURN TRUE BREAK
        CASE HASH("appsidetask") RETURN TRUE BREAK
        CASE HASH("appsmuggler") RETURN TRUE BREAK
        CASE HASH("apptextmessage") RETURN TRUE BREAK
        CASE HASH("apptrackify") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_2(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("appvlsi") RETURN TRUE BREAK
        CASE HASH("appzit") RETURN TRUE BREAK
        CASE HASH("arcade_seating") RETURN TRUE BREAK
        CASE HASH("arena_box_bench_seats") RETURN TRUE BREAK
        CASE HASH("arena_carmod") RETURN TRUE BREAK
        CASE HASH("arena_workshop_seats") RETURN TRUE BREAK
        CASE HASH("armenian1") RETURN TRUE BREAK
        CASE HASH("armenian2") RETURN TRUE BREAK
        CASE HASH("armenian3") RETURN TRUE BREAK
        CASE HASH("armory_aircraft_carmod") RETURN TRUE BREAK
        CASE HASH("assassin_bus") RETURN TRUE BREAK
        CASE HASH("assassin_construction") RETURN TRUE BREAK
        CASE HASH("assassin_hooker") RETURN TRUE BREAK
        CASE HASH("assassin_multi") RETURN TRUE BREAK
        CASE HASH("assassin_rankup") RETURN TRUE BREAK
        CASE HASH("assassin_valet") RETURN TRUE BREAK
        CASE HASH("atm_trigger") RETURN TRUE BREAK
        CASE HASH("audiotest") RETURN TRUE BREAK
        CASE HASH("auto_shop_seating") RETURN TRUE BREAK
        CASE HASH("autosave_controller") RETURN TRUE BREAK
        CASE HASH("bailbond_launcher") RETURN TRUE BREAK
        CASE HASH("bailbond1") RETURN TRUE BREAK
        CASE HASH("bailbond2") RETURN TRUE BREAK
        CASE HASH("bailbond3") RETURN TRUE BREAK
        CASE HASH("bailbond4") RETURN TRUE BREAK
        CASE HASH("barry1") RETURN TRUE BREAK
        CASE HASH("barry2") RETURN TRUE BREAK
        CASE HASH("barry3") RETURN TRUE BREAK
        CASE HASH("barry3a") RETURN TRUE BREAK
        CASE HASH("barry3c") RETURN TRUE BREAK
        CASE HASH("barry4") RETURN TRUE BREAK
        CASE HASH("base_carmod") RETURN TRUE BREAK
        CASE HASH("base_corridor_seats") RETURN TRUE BREAK
        CASE HASH("base_entrance_seats") RETURN TRUE BREAK
        CASE HASH("base_heist_seats") RETURN TRUE BREAK
        CASE HASH("base_lounge_seats") RETURN TRUE BREAK
        CASE HASH("base_quaters_seats") RETURN TRUE BREAK
        CASE HASH("base_reception_seats") RETURN TRUE BREAK
        CASE HASH("basic_creator") RETURN TRUE BREAK
        CASE HASH("beach_exterior_seating") RETURN TRUE BREAK
        CASE HASH("benchmark") RETURN TRUE BREAK
        CASE HASH("bigwheel") RETURN TRUE BREAK
        CASE HASH("bj") RETURN TRUE BREAK
        CASE HASH("blackjack") RETURN TRUE BREAK
        CASE HASH("blimptest") RETURN TRUE BREAK
        CASE HASH("blip_controller") RETURN TRUE BREAK
        CASE HASH("bootycall_debug_controller") RETURN TRUE BREAK
        CASE HASH("bootycallhandler") RETURN TRUE BREAK
        CASE HASH("buddydeathresponse") RETURN TRUE BREAK
        CASE HASH("bugstar_mission_export") RETURN TRUE BREAK
        CASE HASH("building_controller") RETURN TRUE BREAK
        CASE HASH("buildingsiteambience") RETURN TRUE BREAK
        CASE HASH("business_battles") RETURN TRUE BREAK
        CASE HASH("business_battles_defend") RETURN TRUE BREAK
        CASE HASH("business_battles_sell") RETURN TRUE BREAK
        CASE HASH("business_hub_carmod") RETURN TRUE BREAK
        CASE HASH("business_hub_garage_seats") RETURN TRUE BREAK
        CASE HASH("cablecar") RETURN TRUE BREAK
        CASE HASH("cam_coord_sender") RETURN TRUE BREAK
        CASE HASH("camera_test") RETURN TRUE BREAK
        CASE HASH("camhedz_arcade") RETURN TRUE BREAK
        CASE HASH("candidate_controller") RETURN TRUE BREAK
        CASE HASH("car_meet_carmod") RETURN TRUE BREAK
        CASE HASH("car_meet_exterior_seating") RETURN TRUE BREAK
        CASE HASH("car_meet_interior_seating") RETURN TRUE BREAK
        CASE HASH("car_roof_test") RETURN TRUE BREAK
        CASE HASH("carmod_shop") RETURN TRUE BREAK
        CASE HASH("carsteal1") RETURN TRUE BREAK
        CASE HASH("carsteal2") RETURN TRUE BREAK
        CASE HASH("carsteal3") RETURN TRUE BREAK
        CASE HASH("carsteal4") RETURN TRUE BREAK
        CASE HASH("carwash1") RETURN TRUE BREAK
        CASE HASH("carwash2") RETURN TRUE BREAK
        CASE HASH("casino_bar_seating") RETURN TRUE BREAK
        CASE HASH("casino_exterior_seating") RETURN TRUE BREAK
        CASE HASH("casino_interior_seating") RETURN TRUE BREAK
        CASE HASH("casino_lucky_wheel") RETURN TRUE BREAK
        CASE HASH("casino_main_lounge_seating") RETURN TRUE BREAK
        CASE HASH("casino_nightclub_seating") RETURN TRUE BREAK
        CASE HASH("casino_penthouse_seating") RETURN TRUE BREAK
        CASE HASH("casino_slots") RETURN TRUE BREAK
        CASE HASH("casinoroulette") RETURN TRUE BREAK
        CASE HASH("celebration_editor") RETURN TRUE BREAK
        CASE HASH("celebrations") RETURN TRUE BREAK
        CASE HASH("cellphone_controller") RETURN TRUE BREAK
        CASE HASH("cellphone_flashhand") RETURN TRUE BREAK
        CASE HASH("charactergoals") RETURN TRUE BREAK
        CASE HASH("charanimtest") RETURN TRUE BREAK
        CASE HASH("cheat_controller") RETURN TRUE BREAK
        CASE HASH("chinese1") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_3(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("chinese2") RETURN TRUE BREAK
        CASE HASH("chop") RETURN TRUE BREAK
        CASE HASH("clothes_shop_mp") RETURN TRUE BREAK
        CASE HASH("clothes_shop_sp") RETURN TRUE BREAK
        CASE HASH("code_controller") RETURN TRUE BREAK
        CASE HASH("combat_test") RETURN TRUE BREAK
        CASE HASH("comms_controller") RETURN TRUE BREAK
        CASE HASH("completionpercentage_controller") RETURN TRUE BREAK
        CASE HASH("component_checker") RETURN TRUE BREAK
        CASE HASH("context_controller") RETURN TRUE BREAK
        CASE HASH("controller_ambientarea") RETURN TRUE BREAK
        CASE HASH("controller_races") RETURN TRUE BREAK
        CASE HASH("controller_taxi") RETURN TRUE BREAK
        CASE HASH("controller_towing") RETURN TRUE BREAK
        CASE HASH("controller_trafficking") RETURN TRUE BREAK
        CASE HASH("coordinate_recorder") RETURN TRUE BREAK
        CASE HASH("country_race") RETURN TRUE BREAK
        CASE HASH("country_race_controller") RETURN TRUE BREAK
        CASE HASH("creation_startup") RETURN TRUE BREAK
        CASE HASH("creator") RETURN TRUE BREAK
        CASE HASH("custom_config") RETURN TRUE BREAK
        CASE HASH("cutscene_test") RETURN TRUE BREAK
        CASE HASH("cutscenemetrics") RETURN TRUE BREAK
        CASE HASH("cutscenesamples") RETURN TRUE BREAK
        CASE HASH("darts") RETURN TRUE BREAK
        CASE HASH("debug") RETURN TRUE BREAK
        CASE HASH("debug_app_select_screen") RETURN TRUE BREAK
        CASE HASH("debug_clone_outfit_testing") RETURN TRUE BREAK
        CASE HASH("debug_launcher") RETURN TRUE BREAK
        CASE HASH("debug_ped_data") RETURN TRUE BREAK
        CASE HASH("degenatron_games") RETURN TRUE BREAK
        CASE HASH("density_test") RETURN TRUE BREAK
        CASE HASH("dialogue_handler") RETURN TRUE BREAK
        CASE HASH("director_mode") RETURN TRUE BREAK
        CASE HASH("docks_heista") RETURN TRUE BREAK
        CASE HASH("docks_heistb") RETURN TRUE BREAK
        CASE HASH("docks_prep1") RETURN TRUE BREAK
        CASE HASH("docks_prep2b") RETURN TRUE BREAK
        CASE HASH("docks_setup") RETURN TRUE BREAK
        CASE HASH("docks2asubhandler") RETURN TRUE BREAK
        CASE HASH("dont_cross_the_line") RETURN TRUE BREAK
        CASE HASH("dreyfuss1") RETURN TRUE BREAK
        CASE HASH("drf1") RETURN TRUE BREAK
        CASE HASH("drf2") RETURN TRUE BREAK
        CASE HASH("drf3") RETURN TRUE BREAK
        CASE HASH("drf4") RETURN TRUE BREAK
        CASE HASH("drf5") RETURN TRUE BREAK
        CASE HASH("drunk") RETURN TRUE BREAK
        CASE HASH("drunk_controller") RETURN TRUE BREAK
        CASE HASH("dynamixtest") RETURN TRUE BREAK
        CASE HASH("email_controller") RETURN TRUE BREAK
        CASE HASH("emergencycall") RETURN TRUE BREAK
        CASE HASH("emergencycalllauncher") RETURN TRUE BREAK
        CASE HASH("epscars") RETURN TRUE BREAK
        CASE HASH("epsdesert") RETURN TRUE BREAK
        CASE HASH("epsilon1") RETURN TRUE BREAK
        CASE HASH("epsilon2") RETURN TRUE BREAK
        CASE HASH("epsilon3") RETURN TRUE BREAK
        CASE HASH("epsilon4") RETURN TRUE BREAK
        CASE HASH("epsilon5") RETURN TRUE BREAK
        CASE HASH("epsilon6") RETURN TRUE BREAK
        CASE HASH("epsilon7") RETURN TRUE BREAK
        CASE HASH("epsilon8") RETURN TRUE BREAK
        CASE HASH("epsilontract") RETURN TRUE BREAK
        CASE HASH("epsrobes") RETURN TRUE BREAK
        CASE HASH("error_listener") RETURN TRUE BREAK
        CASE HASH("error_thrower") RETURN TRUE BREAK
        CASE HASH("event_controller") RETURN TRUE BREAK
        CASE HASH("exile_city_denial") RETURN TRUE BREAK
        CASE HASH("exile1") RETURN TRUE BREAK
        CASE HASH("exile2") RETURN TRUE BREAK
        CASE HASH("exile3") RETURN TRUE BREAK
        CASE HASH("extreme1") RETURN TRUE BREAK
        CASE HASH("extreme2") RETURN TRUE BREAK
        CASE HASH("extreme3") RETURN TRUE BREAK
        CASE HASH("extreme4") RETURN TRUE BREAK
        CASE HASH("fairgroundhub") RETURN TRUE BREAK
        CASE HASH("fake_interiors") RETURN TRUE BREAK
        CASE HASH("fame_or_shame_set") RETURN TRUE BREAK
        CASE HASH("fameorshame_eps") RETURN TRUE BREAK
        CASE HASH("fameorshame_eps_1") RETURN TRUE BREAK
        CASE HASH("family_scene_f0") RETURN TRUE BREAK
        CASE HASH("family_scene_f1") RETURN TRUE BREAK
        CASE HASH("family_scene_m") RETURN TRUE BREAK
        CASE HASH("family_scene_t0") RETURN TRUE BREAK
        CASE HASH("family_scene_t1") RETURN TRUE BREAK
        CASE HASH("family1") RETURN TRUE BREAK
        CASE HASH("family1taxi") RETURN TRUE BREAK
        CASE HASH("family2") RETURN TRUE BREAK
        CASE HASH("family3") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_4(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("family4") RETURN TRUE BREAK
        CASE HASH("family5") RETURN TRUE BREAK
        CASE HASH("family6") RETURN TRUE BREAK
        CASE HASH("fanatic1") RETURN TRUE BREAK
        CASE HASH("fanatic2") RETURN TRUE BREAK
        CASE HASH("fanatic3") RETURN TRUE BREAK
        CASE HASH("fbi1") RETURN TRUE BREAK
        CASE HASH("fbi2") RETURN TRUE BREAK
        CASE HASH("fbi3") RETURN TRUE BREAK
        CASE HASH("fbi4") RETURN TRUE BREAK
        CASE HASH("fbi4_intro") RETURN TRUE BREAK
        CASE HASH("fbi4_prep1") RETURN TRUE BREAK
        CASE HASH("fbi4_prep2") RETURN TRUE BREAK
        CASE HASH("fbi4_prep3") RETURN TRUE BREAK
        CASE HASH("fbi4_prep3amb") RETURN TRUE BREAK
        CASE HASH("fbi4_prep4") RETURN TRUE BREAK
        CASE HASH("fbi4_prep5") RETURN TRUE BREAK
        CASE HASH("fbi5a") RETURN TRUE BREAK
        CASE HASH("finale_choice") RETURN TRUE BREAK
        CASE HASH("finale_credits") RETURN TRUE BREAK
        CASE HASH("finale_endgame") RETURN TRUE BREAK
        CASE HASH("finale_heist_prepa") RETURN TRUE BREAK
        CASE HASH("finale_heist_prepb") RETURN TRUE BREAK
        CASE HASH("finale_heist_prepc") RETURN TRUE BREAK
        CASE HASH("finale_heist_prepd") RETURN TRUE BREAK
        CASE HASH("finale_heist_prepeamb") RETURN TRUE BREAK
        CASE HASH("finale_heist1") RETURN TRUE BREAK
        CASE HASH("finale_heist2_intro") RETURN TRUE BREAK
        CASE HASH("finale_heist2a") RETURN TRUE BREAK
        CASE HASH("finale_heist2b") RETURN TRUE BREAK
        CASE HASH("finale_intro") RETURN TRUE BREAK
        CASE HASH("finalea") RETURN TRUE BREAK
        CASE HASH("finaleb") RETURN TRUE BREAK
        CASE HASH("finalec1") RETURN TRUE BREAK
        CASE HASH("finalec2") RETURN TRUE BREAK
        CASE HASH("fixer_hq_carmod") RETURN TRUE BREAK
        CASE HASH("fixer_hq_seating") RETURN TRUE BREAK
        CASE HASH("fixer_hq_seating_op_floor") RETURN TRUE BREAK
        CASE HASH("fixer_hq_seating_pq") RETURN TRUE BREAK
        CASE HASH("floating_help_controller") RETURN TRUE BREAK
        CASE HASH("flow_autoplay") RETURN TRUE BREAK
        CASE HASH("flow_controller") RETURN TRUE BREAK
        CASE HASH("flow_help") RETURN TRUE BREAK
        CASE HASH("flowintrotitle") RETURN TRUE BREAK
        CASE HASH("flowstartaccept") RETURN TRUE BREAK
        CASE HASH("flyunderbridges") RETURN TRUE BREAK
        CASE HASH("fm_bj_race_controler") RETURN TRUE BREAK
        CASE HASH("fm_capture_creator") RETURN TRUE BREAK
        CASE HASH("fm_content_acid_lab_sell") RETURN TRUE BREAK
        CASE HASH("fm_content_acid_lab_setup") RETURN TRUE BREAK
        CASE HASH("fm_content_acid_lab_source") RETURN TRUE BREAK
        CASE HASH("fm_content_ammunation") RETURN TRUE BREAK
        CASE HASH("fm_content_auto_shop_delivery") RETURN TRUE BREAK
        CASE HASH("fm_content_bank_shootout") RETURN TRUE BREAK
        CASE HASH("fm_content_bar_resupply") RETURN TRUE BREAK
        CASE HASH("fm_content_bike_shop_delivery") RETURN TRUE BREAK
        CASE HASH("fm_content_business_battles") RETURN TRUE BREAK
        CASE HASH("fm_content_cargo") RETURN TRUE BREAK
        CASE HASH("fm_content_cerberus") RETURN TRUE BREAK
        CASE HASH("fm_content_club_management") RETURN TRUE BREAK
        CASE HASH("fm_content_club_odd_jobs") RETURN TRUE BREAK
        CASE HASH("fm_content_club_source") RETURN TRUE BREAK
        CASE HASH("fm_content_clubhouse_contracts") RETURN TRUE BREAK
        CASE HASH("fm_content_convoy") RETURN TRUE BREAK
        CASE HASH("fm_content_crime_scene") RETURN TRUE BREAK
        CASE HASH("fm_content_drug_lab_work") RETURN TRUE BREAK
        CASE HASH("fm_content_drug_vehicle") RETURN TRUE BREAK
        CASE HASH("fm_content_export_cargo") RETURN TRUE BREAK
        CASE HASH("fm_content_golden_gun") RETURN TRUE BREAK
        CASE HASH("fm_content_gunrunning") RETURN TRUE BREAK
        CASE HASH("fm_content_hsw_setup") RETURN TRUE BREAK
        CASE HASH("fm_content_hsw_time_trial") RETURN TRUE BREAK
        CASE HASH("fm_content_island_dj") RETURN TRUE BREAK
        CASE HASH("fm_content_island_heist") RETURN TRUE BREAK
        CASE HASH("fm_content_metal_detector") RETURN TRUE BREAK
        CASE HASH("fm_content_movie_props") RETURN TRUE BREAK
        CASE HASH("fm_content_mp_intro") RETURN TRUE BREAK
        CASE HASH("fm_content_parachuter") RETURN TRUE BREAK
        CASE HASH("fm_content_payphone_hit") RETURN TRUE BREAK
        CASE HASH("fm_content_phantom_car") RETURN TRUE BREAK
        CASE HASH("fm_content_security_contract") RETURN TRUE BREAK
        CASE HASH("fm_content_sightseeing") RETURN TRUE BREAK
        CASE HASH("fm_content_skydive") RETURN TRUE BREAK
        CASE HASH("fm_content_slasher") RETURN TRUE BREAK
        CASE HASH("fm_content_smuggler_plane") RETURN TRUE BREAK
        CASE HASH("fm_content_smuggler_trail") RETURN TRUE BREAK
        CASE HASH("fm_content_source_research") RETURN TRUE BREAK
        CASE HASH("fm_content_stash_house") RETURN TRUE BREAK
        CASE HASH("fm_content_taxi_driver") RETURN TRUE BREAK
        CASE HASH("fm_content_test") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_5(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("fm_content_tuner_robbery") RETURN TRUE BREAK
        CASE HASH("fm_content_vehicle_list") RETURN TRUE BREAK
        CASE HASH("fm_content_vip_contract_1") RETURN TRUE BREAK
        CASE HASH("fm_content_xmas_mugger") RETURN TRUE BREAK
        CASE HASH("fm_deathmatch_controler") RETURN TRUE BREAK
        CASE HASH("fm_deathmatch_creator") RETURN TRUE BREAK
        CASE HASH("fm_hideout_controler") RETURN TRUE BREAK
        CASE HASH("fm_hold_up_tut") RETURN TRUE BREAK
        CASE HASH("fm_horde_controler") RETURN TRUE BREAK
        CASE HASH("fm_impromptu_dm_controler") RETURN TRUE BREAK
        CASE HASH("fm_intro") RETURN TRUE BREAK
        CASE HASH("fm_intro_cut_dev") RETURN TRUE BREAK
        CASE HASH("fm_lts_creator") RETURN TRUE BREAK
        CASE HASH("fm_main_menu") RETURN TRUE BREAK
        CASE HASH("fm_maintain_cloud_header_data") RETURN TRUE BREAK
        CASE HASH("fm_maintain_transition_players") RETURN TRUE BREAK
        CASE HASH("fm_mission_controller") RETURN TRUE BREAK
        CASE HASH("fm_mission_controller_2020") RETURN TRUE BREAK
        CASE HASH("fm_mission_creator") RETURN TRUE BREAK
        CASE HASH("fm_race_controler") RETURN TRUE BREAK
        CASE HASH("fm_race_creator") RETURN TRUE BREAK
        CASE HASH("fm_street_dealer") RETURN TRUE BREAK
        CASE HASH("fm_survival_controller") RETURN TRUE BREAK
        CASE HASH("fm_survival_creator") RETURN TRUE BREAK
        CASE HASH("fmmc_launcher") RETURN TRUE BREAK
        CASE HASH("fmmc_playlist_controller") RETURN TRUE BREAK
        CASE HASH("forsalesigns") RETURN TRUE BREAK
        CASE HASH("fps_test") RETURN TRUE BREAK
        CASE HASH("fps_test_mag") RETURN TRUE BREAK
        CASE HASH("franklin0") RETURN TRUE BREAK
        CASE HASH("franklin1") RETURN TRUE BREAK
        CASE HASH("franklin2") RETURN TRUE BREAK
        CASE HASH("freemode") RETURN TRUE BREAK
        CASE HASH("freemode_clearglobals") RETURN TRUE BREAK
        CASE HASH("freemode_creator") RETURN TRUE BREAK
        CASE HASH("freemode_init") RETURN TRUE BREAK
        CASE HASH("friendactivity") RETURN TRUE BREAK
        CASE HASH("friends_controller") RETURN TRUE BREAK
        CASE HASH("friends_debug_controller") RETURN TRUE BREAK
        CASE HASH("fullmap_test") RETURN TRUE BREAK
        CASE HASH("fullmap_test_flow") RETURN TRUE BREAK
        CASE HASH("game_server_test") RETURN TRUE BREAK
        CASE HASH("gb_airfreight") RETURN TRUE BREAK
        CASE HASH("gb_amphibious_assault") RETURN TRUE BREAK
        CASE HASH("gb_assault") RETURN TRUE BREAK
        CASE HASH("gb_bank_job") RETURN TRUE BREAK
        CASE HASH("gb_bellybeast") RETURN TRUE BREAK
        CASE HASH("gb_biker_bad_deal") RETURN TRUE BREAK
        CASE HASH("gb_biker_burn_assets") RETURN TRUE BREAK
        CASE HASH("gb_biker_contraband_defend") RETURN TRUE BREAK
        CASE HASH("gb_biker_contraband_sell") RETURN TRUE BREAK
        CASE HASH("gb_biker_contract_killing") RETURN TRUE BREAK
        CASE HASH("gb_biker_criminal_mischief") RETURN TRUE BREAK
        CASE HASH("gb_biker_destroy_vans") RETURN TRUE BREAK
        CASE HASH("gb_biker_driveby_assassin") RETURN TRUE BREAK
        CASE HASH("gb_biker_free_prisoner") RETURN TRUE BREAK
        CASE HASH("gb_biker_joust") RETURN TRUE BREAK
        CASE HASH("gb_biker_last_respects") RETURN TRUE BREAK
        CASE HASH("gb_biker_race_p2p") RETURN TRUE BREAK
        CASE HASH("gb_biker_rescue_contact") RETURN TRUE BREAK
        CASE HASH("gb_biker_rippin_it_up") RETURN TRUE BREAK
        CASE HASH("gb_biker_safecracker") RETURN TRUE BREAK
        CASE HASH("gb_biker_search_and_destroy") RETURN TRUE BREAK
        CASE HASH("gb_biker_shuttle") RETURN TRUE BREAK
        CASE HASH("gb_biker_stand_your_ground") RETURN TRUE BREAK
        CASE HASH("gb_biker_steal_bikes") RETURN TRUE BREAK
        CASE HASH("gb_biker_target_rival") RETURN TRUE BREAK
        CASE HASH("gb_biker_unload_weapons") RETURN TRUE BREAK
        CASE HASH("gb_biker_wheelie_rider") RETURN TRUE BREAK
        CASE HASH("gb_carjacking") RETURN TRUE BREAK
        CASE HASH("gb_cashing_out") RETURN TRUE BREAK
        CASE HASH("gb_casino") RETURN TRUE BREAK
        CASE HASH("gb_casino_heist") RETURN TRUE BREAK
        CASE HASH("gb_casino_heist_planning") RETURN TRUE BREAK
        CASE HASH("gb_collect_money") RETURN TRUE BREAK
        CASE HASH("gb_contraband_buy") RETURN TRUE BREAK
        CASE HASH("gb_contraband_defend") RETURN TRUE BREAK
        CASE HASH("gb_contraband_sell") RETURN TRUE BREAK
        CASE HASH("gb_data_hack") RETURN TRUE BREAK
        CASE HASH("gb_deathmatch") RETURN TRUE BREAK
        CASE HASH("gb_delivery") RETURN TRUE BREAK
        CASE HASH("gb_finderskeepers") RETURN TRUE BREAK
        CASE HASH("gb_fivestar") RETURN TRUE BREAK
        CASE HASH("gb_fortified") RETURN TRUE BREAK
        CASE HASH("gb_fragile_goods") RETURN TRUE BREAK
        CASE HASH("gb_fully_loaded") RETURN TRUE BREAK
        CASE HASH("gb_gang_ops_planning") RETURN TRUE BREAK
        CASE HASH("gb_gangops") RETURN TRUE BREAK
        CASE HASH("gb_gunrunning") RETURN TRUE BREAK
        CASE HASH("gb_gunrunning_defend") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_6(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("gb_gunrunning_delivery") RETURN TRUE BREAK
        CASE HASH("gb_headhunter") RETURN TRUE BREAK
        CASE HASH("gb_hunt_the_boss") RETURN TRUE BREAK
        CASE HASH("gb_ie_delivery_cutscene") RETURN TRUE BREAK
        CASE HASH("gb_illicit_goods_resupply") RETURN TRUE BREAK
        CASE HASH("gb_infiltration") RETURN TRUE BREAK
        CASE HASH("gb_jewel_store_grab") RETURN TRUE BREAK
        CASE HASH("gb_ploughed") RETURN TRUE BREAK
        CASE HASH("gb_point_to_point") RETURN TRUE BREAK
        CASE HASH("gb_ramped_up") RETURN TRUE BREAK
        CASE HASH("gb_rob_shop") RETURN TRUE BREAK
        CASE HASH("gb_salvage") RETURN TRUE BREAK
        CASE HASH("gb_security_van") RETURN TRUE BREAK
        CASE HASH("gb_sightseer") RETURN TRUE BREAK
        CASE HASH("gb_smuggler") RETURN TRUE BREAK
        CASE HASH("gb_stockpiling") RETURN TRUE BREAK
        CASE HASH("gb_target_pursuit") RETURN TRUE BREAK
        CASE HASH("gb_terminate") RETURN TRUE BREAK
        CASE HASH("gb_transporter") RETURN TRUE BREAK
        CASE HASH("gb_vehicle_export") RETURN TRUE BREAK
        CASE HASH("gb_velocity") RETURN TRUE BREAK
        CASE HASH("gb_yacht_rob") RETURN TRUE BREAK
        CASE HASH("general_test") RETURN TRUE BREAK
        CASE HASH("ggsm_arcade") RETURN TRUE BREAK
        CASE HASH("globals_fmmc_struct_registration") RETURN TRUE BREAK
        CASE HASH("globals_fmmcstruct2_registration") RETURN TRUE BREAK
        CASE HASH("golf") RETURN TRUE BREAK
        CASE HASH("golf_ai_foursome") RETURN TRUE BREAK
        CASE HASH("golf_ai_foursome_putting") RETURN TRUE BREAK
        CASE HASH("golf_mp") RETURN TRUE BREAK
        CASE HASH("gpb_andymoon") RETURN TRUE BREAK
        CASE HASH("gpb_baygor") RETURN TRUE BREAK
        CASE HASH("gpb_billbinder") RETURN TRUE BREAK
        CASE HASH("gpb_clinton") RETURN TRUE BREAK
        CASE HASH("gpb_griff") RETURN TRUE BREAK
        CASE HASH("gpb_jane") RETURN TRUE BREAK
        CASE HASH("gpb_jerome") RETURN TRUE BREAK
        CASE HASH("gpb_jesse") RETURN TRUE BREAK
        CASE HASH("gpb_mani") RETURN TRUE BREAK
        CASE HASH("gpb_mime") RETURN TRUE BREAK
        CASE HASH("gpb_pameladrake") RETURN TRUE BREAK
        CASE HASH("gpb_superhero") RETURN TRUE BREAK
        CASE HASH("gpb_tonya") RETURN TRUE BREAK
        CASE HASH("gpb_zombie") RETURN TRUE BREAK
        CASE HASH("grid_arcade_cabinet") RETURN TRUE BREAK
        CASE HASH("gtest_airplane") RETURN TRUE BREAK
        CASE HASH("gtest_avoidance") RETURN TRUE BREAK
        CASE HASH("gtest_boat") RETURN TRUE BREAK
        CASE HASH("gtest_divingfromcar") RETURN TRUE BREAK
        CASE HASH("gtest_divingfromcarwhilefleeing") RETURN TRUE BREAK
        CASE HASH("gtest_helicopter") RETURN TRUE BREAK
        CASE HASH("gtest_nearlymissedbycar") RETURN TRUE BREAK
        CASE HASH("gunclub_shop") RETURN TRUE BREAK
        CASE HASH("gunfighttest") RETURN TRUE BREAK
        CASE HASH("gunslinger_arcade") RETURN TRUE BREAK
        CASE HASH("hacker_truck_carmod") RETURN TRUE BREAK
        CASE HASH("hairdo_shop_mp") RETURN TRUE BREAK
        CASE HASH("hairdo_shop_sp") RETURN TRUE BREAK
        CASE HASH("hangar_carmod") RETURN TRUE BREAK
        CASE HASH("hao1") RETURN TRUE BREAK
        CASE HASH("headertest") RETURN TRUE BREAK
        CASE HASH("heatmap_test") RETURN TRUE BREAK
        CASE HASH("heatmap_test_flow") RETURN TRUE BREAK
        CASE HASH("heist_ctrl_agency") RETURN TRUE BREAK
        CASE HASH("heist_ctrl_docks") RETURN TRUE BREAK
        CASE HASH("heist_ctrl_finale") RETURN TRUE BREAK
        CASE HASH("heist_ctrl_jewel") RETURN TRUE BREAK
        CASE HASH("heist_ctrl_rural") RETURN TRUE BREAK
        CASE HASH("heist_island_planning") RETURN TRUE BREAK
        CASE HASH("heli_gun") RETURN TRUE BREAK
        CASE HASH("heli_streaming") RETURN TRUE BREAK
        CASE HASH("hud_creator") RETURN TRUE BREAK
        CASE HASH("hunting_ambient") RETURN TRUE BREAK
        CASE HASH("hunting1") RETURN TRUE BREAK
        CASE HASH("hunting2") RETURN TRUE BREAK
        CASE HASH("idlewarper") RETURN TRUE BREAK
        CASE HASH("ingamehud") RETURN TRUE BREAK
        CASE HASH("initial") RETURN TRUE BREAK
        CASE HASH("item_ownership_output") RETURN TRUE BREAK
        CASE HASH("jewelry_heist") RETURN TRUE BREAK
        CASE HASH("jewelry_prep1a") RETURN TRUE BREAK
        CASE HASH("jewelry_prep1b") RETURN TRUE BREAK
        CASE HASH("jewelry_prep2a") RETURN TRUE BREAK
        CASE HASH("jewelry_setup1") RETURN TRUE BREAK
        CASE HASH("josh1") RETURN TRUE BREAK
        CASE HASH("josh2") RETURN TRUE BREAK
        CASE HASH("josh3") RETURN TRUE BREAK
        CASE HASH("josh4") RETURN TRUE BREAK
        CASE HASH("juggalo_hideout_carmod") RETURN TRUE BREAK
        CASE HASH("lamar1") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_7(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("landing_pre_startup") RETURN TRUE BREAK
        CASE HASH("laptop_trigger") RETURN TRUE BREAK
        CASE HASH("launcher_abigail") RETURN TRUE BREAK
        CASE HASH("launcher_barry") RETURN TRUE BREAK
        CASE HASH("launcher_basejumpheli") RETURN TRUE BREAK
        CASE HASH("launcher_basejumppack") RETURN TRUE BREAK
        CASE HASH("launcher_carwash") RETURN TRUE BREAK
        CASE HASH("launcher_darts") RETURN TRUE BREAK
        CASE HASH("launcher_dreyfuss") RETURN TRUE BREAK
        CASE HASH("launcher_epsilon") RETURN TRUE BREAK
        CASE HASH("launcher_extreme") RETURN TRUE BREAK
        CASE HASH("launcher_fanatic") RETURN TRUE BREAK
        CASE HASH("launcher_golf") RETURN TRUE BREAK
        CASE HASH("launcher_hao") RETURN TRUE BREAK
        CASE HASH("launcher_hunting") RETURN TRUE BREAK
        CASE HASH("launcher_hunting_ambient") RETURN TRUE BREAK
        CASE HASH("launcher_josh") RETURN TRUE BREAK
        CASE HASH("launcher_maude") RETURN TRUE BREAK
        CASE HASH("launcher_minute") RETURN TRUE BREAK
        CASE HASH("launcher_mrsphilips") RETURN TRUE BREAK
        CASE HASH("launcher_nigel") RETURN TRUE BREAK
        CASE HASH("launcher_offroadracing") RETURN TRUE BREAK
        CASE HASH("launcher_omega") RETURN TRUE BREAK
        CASE HASH("launcher_paparazzo") RETURN TRUE BREAK
        CASE HASH("launcher_pilotschool") RETURN TRUE BREAK
        CASE HASH("launcher_racing") RETURN TRUE BREAK
        CASE HASH("launcher_rampage") RETURN TRUE BREAK
        CASE HASH("launcher_range") RETURN TRUE BREAK
        CASE HASH("launcher_stunts") RETURN TRUE BREAK
        CASE HASH("launcher_tennis") RETURN TRUE BREAK
        CASE HASH("launcher_thelastone") RETURN TRUE BREAK
        CASE HASH("launcher_tonya") RETURN TRUE BREAK
        CASE HASH("launcher_triathlon") RETURN TRUE BREAK
        CASE HASH("launcher_yoga") RETURN TRUE BREAK
        CASE HASH("lester1") RETURN TRUE BREAK
        CASE HASH("lesterhandler") RETURN TRUE BREAK
        CASE HASH("letterscraps") RETURN TRUE BREAK
        CASE HASH("line_activation_test") RETURN TRUE BREAK
        CASE HASH("liverecorder") RETURN TRUE BREAK
        CASE HASH("locates_tester") RETURN TRUE BREAK
        CASE HASH("luxe_veh_activity") RETURN TRUE BREAK
        CASE HASH("magdemo") RETURN TRUE BREAK
        CASE HASH("magdemo2") RETURN TRUE BREAK
        CASE HASH("main") RETURN TRUE BREAK
        CASE HASH("main_install") RETURN TRUE BREAK
        CASE HASH("main_persistent") RETURN TRUE BREAK
        CASE HASH("maintransition") RETURN TRUE BREAK
        CASE HASH("martin1") RETURN TRUE BREAK
        CASE HASH("maude_postbailbond") RETURN TRUE BREAK
        CASE HASH("maude1") RETURN TRUE BREAK
        CASE HASH("me_amanda1") RETURN TRUE BREAK
        CASE HASH("me_jimmy1") RETURN TRUE BREAK
        CASE HASH("me_tracey1") RETURN TRUE BREAK
        CASE HASH("mg_race_to_point") RETURN TRUE BREAK
        CASE HASH("michael1") RETURN TRUE BREAK
        CASE HASH("michael2") RETURN TRUE BREAK
        CASE HASH("michael3") RETURN TRUE BREAK
        CASE HASH("michael4") RETURN TRUE BREAK
        CASE HASH("michael4leadout") RETURN TRUE BREAK
        CASE HASH("minigame_ending_stinger") RETURN TRUE BREAK
        CASE HASH("minigame_stats_tracker") RETURN TRUE BREAK
        CASE HASH("minute1") RETURN TRUE BREAK
        CASE HASH("minute2") RETURN TRUE BREAK
        CASE HASH("minute3") RETURN TRUE BREAK
        CASE HASH("mission_race") RETURN TRUE BREAK
        CASE HASH("mission_repeat_controller") RETURN TRUE BREAK
        CASE HASH("mission_stat_alerter") RETURN TRUE BREAK
        CASE HASH("mission_stat_watcher") RETURN TRUE BREAK
        CASE HASH("mission_triggerer_a") RETURN TRUE BREAK
        CASE HASH("mission_triggerer_b") RETURN TRUE BREAK
        CASE HASH("mission_triggerer_c") RETURN TRUE BREAK
        CASE HASH("mission_triggerer_d") RETURN TRUE BREAK
        CASE HASH("missioniaaturret") RETURN TRUE BREAK
        CASE HASH("mp_awards") RETURN TRUE BREAK
        CASE HASH("mp_bed_high") RETURN TRUE BREAK
        CASE HASH("mp_fm_registration") RETURN TRUE BREAK
        CASE HASH("mp_menuped") RETURN TRUE BREAK
        CASE HASH("mp_prop_global_block") RETURN TRUE BREAK
        CASE HASH("mp_prop_special_global_block") RETURN TRUE BREAK
        CASE HASH("mp_registration") RETURN TRUE BREAK
        CASE HASH("mp_save_game_global_block") RETURN TRUE BREAK
        CASE HASH("mp_unlocks") RETURN TRUE BREAK
        CASE HASH("mp_weapons") RETURN TRUE BREAK
        CASE HASH("mpstatsinit") RETURN TRUE BREAK
        CASE HASH("mptestbed") RETURN TRUE BREAK
        CASE HASH("mrsphilips1") RETURN TRUE BREAK
        CASE HASH("mrsphilips2") RETURN TRUE BREAK
        CASE HASH("murdermystery") RETURN TRUE BREAK
        CASE HASH("music_studio_seating") RETURN TRUE BREAK
        CASE HASH("music_studio_seating_external") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_8(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("music_studio_smoking") RETURN TRUE BREAK
        CASE HASH("navmeshtest") RETURN TRUE BREAK
        CASE HASH("net_activity_creator_ui") RETURN TRUE BREAK
        CASE HASH("net_apartment_activity") RETURN TRUE BREAK
        CASE HASH("net_apartment_activity_light") RETURN TRUE BREAK
        CASE HASH("net_bot_brain") RETURN TRUE BREAK
        CASE HASH("net_bot_simplebrain") RETURN TRUE BREAK
        CASE HASH("net_cloud_mission_loader") RETURN TRUE BREAK
        CASE HASH("net_combat_soaktest") RETURN TRUE BREAK
        CASE HASH("net_jacking_soaktest") RETURN TRUE BREAK
        CASE HASH("net_rank_tunable_loader") RETURN TRUE BREAK
        CASE HASH("net_session_soaktest") RETURN TRUE BREAK
        CASE HASH("net_test_drive") RETURN TRUE BREAK
        CASE HASH("net_tunable_check") RETURN TRUE BREAK
        CASE HASH("nigel1") RETURN TRUE BREAK
        CASE HASH("nigel1a") RETURN TRUE BREAK
        CASE HASH("nigel1b") RETURN TRUE BREAK
        CASE HASH("nigel1c") RETURN TRUE BREAK
        CASE HASH("nigel1d") RETURN TRUE BREAK
        CASE HASH("nigel2") RETURN TRUE BREAK
        CASE HASH("nigel3") RETURN TRUE BREAK
        CASE HASH("nightclub_ground_floor_seats") RETURN TRUE BREAK
        CASE HASH("nightclub_office_seats") RETURN TRUE BREAK
        CASE HASH("nightclub_vip_seats") RETURN TRUE BREAK
        CASE HASH("nightclubpeds") RETURN TRUE BREAK
        CASE HASH("nodemenututorial") RETURN TRUE BREAK
        CASE HASH("nodeviewer") RETURN TRUE BREAK
        CASE HASH("ob_abatdoor") RETURN TRUE BREAK
        CASE HASH("ob_abattoircut") RETURN TRUE BREAK
        CASE HASH("ob_airdancer") RETURN TRUE BREAK
        CASE HASH("ob_bong") RETURN TRUE BREAK
        CASE HASH("ob_cashregister") RETURN TRUE BREAK
        CASE HASH("ob_drinking_shots") RETURN TRUE BREAK
        CASE HASH("ob_foundry_cauldron") RETURN TRUE BREAK
        CASE HASH("ob_franklin_beer") RETURN TRUE BREAK
        CASE HASH("ob_franklin_tv") RETURN TRUE BREAK
        CASE HASH("ob_franklin_wine") RETURN TRUE BREAK
        CASE HASH("ob_huffing_gas") RETURN TRUE BREAK
        CASE HASH("ob_jukebox") RETURN TRUE BREAK
        CASE HASH("ob_mp_bed_high") RETURN TRUE BREAK
        CASE HASH("ob_mp_bed_low") RETURN TRUE BREAK
        CASE HASH("ob_mp_bed_med") RETURN TRUE BREAK
        CASE HASH("ob_mp_shower_med") RETURN TRUE BREAK
        CASE HASH("ob_mp_stripper") RETURN TRUE BREAK
        CASE HASH("ob_mr_raspberry_jam") RETURN TRUE BREAK
        CASE HASH("ob_poledancer") RETURN TRUE BREAK
        CASE HASH("ob_sofa_franklin") RETURN TRUE BREAK
        CASE HASH("ob_sofa_michael") RETURN TRUE BREAK
        CASE HASH("ob_telescope") RETURN TRUE BREAK
        CASE HASH("ob_tv") RETURN TRUE BREAK
        CASE HASH("ob_vend1") RETURN TRUE BREAK
        CASE HASH("ob_vend2") RETURN TRUE BREAK
        CASE HASH("ob_wheatgrass") RETURN TRUE BREAK
        CASE HASH("offroad_races") RETURN TRUE BREAK
        CASE HASH("omega1") RETURN TRUE BREAK
        CASE HASH("omega2") RETURN TRUE BREAK
        CASE HASH("paparazzo1") RETURN TRUE BREAK
        CASE HASH("paparazzo2") RETURN TRUE BREAK
        CASE HASH("paparazzo3") RETURN TRUE BREAK
        CASE HASH("paparazzo3a") RETURN TRUE BREAK
        CASE HASH("paparazzo3b") RETURN TRUE BREAK
        CASE HASH("paparazzo4") RETURN TRUE BREAK
        CASE HASH("paradise") RETURN TRUE BREAK
        CASE HASH("paradise2") RETURN TRUE BREAK
        CASE HASH("pausemenu") RETURN TRUE BREAK
        CASE HASH("pausemenu_example") RETURN TRUE BREAK
        CASE HASH("pausemenu_map") RETURN TRUE BREAK
        CASE HASH("pausemenu_multiplayer") RETURN TRUE BREAK
        CASE HASH("pausemenu_sp_repeat") RETURN TRUE BREAK
        CASE HASH("pb_busker") RETURN TRUE BREAK
        CASE HASH("pb_homeless") RETURN TRUE BREAK
        CASE HASH("pb_preacher") RETURN TRUE BREAK
        CASE HASH("pb_prostitute") RETURN TRUE BREAK
        CASE HASH("personal_carmod_shop") RETURN TRUE BREAK
        CASE HASH("photographymonkey") RETURN TRUE BREAK
        CASE HASH("photographywildlife") RETURN TRUE BREAK
        CASE HASH("physics_perf_test") RETURN TRUE BREAK
        CASE HASH("physics_perf_test_launcher") RETURN TRUE BREAK
        CASE HASH("pi_menu") RETURN TRUE BREAK
        CASE HASH("pickup_controller") RETURN TRUE BREAK
        CASE HASH("pickuptest") RETURN TRUE BREAK
        CASE HASH("pickupvehicles") RETURN TRUE BREAK
        CASE HASH("pilot_school") RETURN TRUE BREAK
        CASE HASH("pilot_school_mp") RETURN TRUE BREAK
        CASE HASH("placeholdermission") RETURN TRUE BREAK
        CASE HASH("placementtest") RETURN TRUE BREAK
        CASE HASH("planewarptest") RETURN TRUE BREAK
        CASE HASH("player_controller") RETURN TRUE BREAK
        CASE HASH("player_controller_b") RETURN TRUE BREAK
        CASE HASH("player_scene_f_lamgraff") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_9(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("player_scene_f_lamtaunt") RETURN TRUE BREAK
        CASE HASH("player_scene_f_taxi") RETURN TRUE BREAK
        CASE HASH("player_scene_ft_franklin1") RETURN TRUE BREAK
        CASE HASH("player_scene_m_cinema") RETURN TRUE BREAK
        CASE HASH("player_scene_m_fbi2") RETURN TRUE BREAK
        CASE HASH("player_scene_m_kids") RETURN TRUE BREAK
        CASE HASH("player_scene_m_shopping") RETURN TRUE BREAK
        CASE HASH("player_scene_mf_traffic") RETURN TRUE BREAK
        CASE HASH("player_scene_t_bbfight") RETURN TRUE BREAK
        CASE HASH("player_scene_t_chasecar") RETURN TRUE BREAK
        CASE HASH("player_scene_t_insult") RETURN TRUE BREAK
        CASE HASH("player_scene_t_park") RETURN TRUE BREAK
        CASE HASH("player_scene_t_tie") RETURN TRUE BREAK
        CASE HASH("player_timetable_scene") RETURN TRUE BREAK
        CASE HASH("playthrough_builder") RETURN TRUE BREAK
        CASE HASH("pm_defend") RETURN TRUE BREAK
        CASE HASH("pm_delivery") RETURN TRUE BREAK
        CASE HASH("pm_gang_attack") RETURN TRUE BREAK
        CASE HASH("pm_plane_promotion") RETURN TRUE BREAK
        CASE HASH("pm_recover_stolen") RETURN TRUE BREAK
        CASE HASH("postkilled_bailbond2") RETURN TRUE BREAK
        CASE HASH("postrc_barry1and2") RETURN TRUE BREAK
        CASE HASH("postrc_barry4") RETURN TRUE BREAK
        CASE HASH("postrc_epsilon4") RETURN TRUE BREAK
        CASE HASH("postrc_nigel3") RETURN TRUE BREAK
        CASE HASH("profiler_registration") RETURN TRUE BREAK
        CASE HASH("prologue1") RETURN TRUE BREAK
        CASE HASH("prop_drop") RETURN TRUE BREAK
        CASE HASH("puzzle") RETURN TRUE BREAK
        CASE HASH("racetest") RETURN TRUE BREAK
        CASE HASH("rampage_controller") RETURN TRUE BREAK
        CASE HASH("rampage1") RETURN TRUE BREAK
        CASE HASH("rampage2") RETURN TRUE BREAK
        CASE HASH("rampage3") RETURN TRUE BREAK
        CASE HASH("rampage4") RETURN TRUE BREAK
        CASE HASH("rampage5") RETURN TRUE BREAK
        CASE HASH("randomchar_controller") RETURN TRUE BREAK
        CASE HASH("range_modern") RETURN TRUE BREAK
        CASE HASH("range_modern_mp") RETURN TRUE BREAK
        CASE HASH("re_abandonedcar") RETURN TRUE BREAK
        CASE HASH("re_accident") RETURN TRUE BREAK
        CASE HASH("re_armybase") RETURN TRUE BREAK
        CASE HASH("re_arrests") RETURN TRUE BREAK
        CASE HASH("re_atmrobbery") RETURN TRUE BREAK
        CASE HASH("re_bikethief") RETURN TRUE BREAK
        CASE HASH("re_border") RETURN TRUE BREAK
        CASE HASH("re_burials") RETURN TRUE BREAK
        CASE HASH("re_bus_tours") RETURN TRUE BREAK
        CASE HASH("re_cartheft") RETURN TRUE BREAK
        CASE HASH("re_chasethieves") RETURN TRUE BREAK
        CASE HASH("re_crashrescue") RETURN TRUE BREAK
        CASE HASH("re_cultshootout") RETURN TRUE BREAK
        CASE HASH("re_dealgonewrong") RETURN TRUE BREAK
        CASE HASH("re_domestic") RETURN TRUE BREAK
        CASE HASH("re_drunkdriver") RETURN TRUE BREAK
        CASE HASH("re_duel") RETURN TRUE BREAK
        CASE HASH("re_gang_intimidation") RETURN TRUE BREAK
        CASE HASH("re_gangfight") RETURN TRUE BREAK
        CASE HASH("re_getaway_driver") RETURN TRUE BREAK
        CASE HASH("re_hitch_lift") RETURN TRUE BREAK
        CASE HASH("re_homeland_security") RETURN TRUE BREAK
        CASE HASH("re_lossantosintl") RETURN TRUE BREAK
        CASE HASH("re_lured") RETURN TRUE BREAK
        CASE HASH("re_monkey") RETURN TRUE BREAK
        CASE HASH("re_mountdance") RETURN TRUE BREAK
        CASE HASH("re_muggings") RETURN TRUE BREAK
        CASE HASH("re_paparazzi") RETURN TRUE BREAK
        CASE HASH("re_prison") RETURN TRUE BREAK
        CASE HASH("re_prisonerlift") RETURN TRUE BREAK
        CASE HASH("re_prisonvanbreak") RETURN TRUE BREAK
        CASE HASH("re_rescuehostage") RETURN TRUE BREAK
        CASE HASH("re_seaplane") RETURN TRUE BREAK
        CASE HASH("re_securityvan") RETURN TRUE BREAK
        CASE HASH("re_shoprobbery") RETURN TRUE BREAK
        CASE HASH("re_snatched") RETURN TRUE BREAK
        CASE HASH("re_stag_do") RETURN TRUE BREAK
        CASE HASH("re_yetarian") RETURN TRUE BREAK
        CASE HASH("replay_controller") RETURN TRUE BREAK
        CASE HASH("rerecord_recording") RETURN TRUE BREAK
        CASE HASH("respawn_controller") RETURN TRUE BREAK
        CASE HASH("restrictedareas") RETURN TRUE BREAK
        CASE HASH("rng_output") RETURN TRUE BREAK
        CASE HASH("road_arcade") RETURN TRUE BREAK
        CASE HASH("rollercoaster") RETURN TRUE BREAK
        CASE HASH("rural_bank_heist") RETURN TRUE BREAK
        CASE HASH("rural_bank_prep1") RETURN TRUE BREAK
        CASE HASH("rural_bank_setup") RETURN TRUE BREAK
        CASE HASH("save_anywhere") RETURN TRUE BREAK
        CASE HASH("savegame_bed") RETURN TRUE BREAK
        CASE HASH("sc_lb_global_block") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_10(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("scaleformgraphictest") RETURN TRUE BREAK
        CASE HASH("scaleformminigametest") RETURN TRUE BREAK
        CASE HASH("scaleformprofiling") RETURN TRUE BREAK
        CASE HASH("scaleformtest") RETURN TRUE BREAK
        CASE HASH("scene_builder") RETURN TRUE BREAK
        CASE HASH("sclub_front_bouncer") RETURN TRUE BREAK
        CASE HASH("script_metrics") RETURN TRUE BREAK
        CASE HASH("scripted_cam_editor") RETURN TRUE BREAK
        CASE HASH("scriptplayground") RETURN TRUE BREAK
        CASE HASH("scripttest1") RETURN TRUE BREAK
        CASE HASH("scripttest2") RETURN TRUE BREAK
        CASE HASH("scripttest3") RETURN TRUE BREAK
        CASE HASH("scripttest4") RETURN TRUE BREAK
        CASE HASH("scroll_arcade_cabinet") RETURN TRUE BREAK
        CASE HASH("sctv") RETURN TRUE BREAK
        CASE HASH("selector") RETURN TRUE BREAK
        CASE HASH("selector_example") RETURN TRUE BREAK
        CASE HASH("selling_short_1") RETURN TRUE BREAK
        CASE HASH("selling_short_2") RETURN TRUE BREAK
        CASE HASH("sh_intro_f_hills") RETURN TRUE BREAK
        CASE HASH("sh_intro_m_home") RETURN TRUE BREAK
        CASE HASH("shooting_camera") RETURN TRUE BREAK
        CASE HASH("shop_controller") RETURN TRUE BREAK
        CASE HASH("shoprobberies") RETURN TRUE BREAK
        CASE HASH("shot_bikejump") RETURN TRUE BREAK
        CASE HASH("shrinkletter") RETURN TRUE BREAK
        CASE HASH("simeon_showroom_seating") RETURN TRUE BREAK
        CASE HASH("smoketest") RETURN TRUE BREAK
        CASE HASH("social_controller") RETURN TRUE BREAK
        CASE HASH("solomon1") RETURN TRUE BREAK
        CASE HASH("solomon2") RETURN TRUE BREAK
        CASE HASH("solomon3") RETURN TRUE BREAK
        CASE HASH("sp_dlc_registration") RETURN TRUE BREAK
        CASE HASH("sp_editor_mission_instance") RETURN TRUE BREAK
        CASE HASH("sp_menuped") RETURN TRUE BREAK
        CASE HASH("sp_pilotschool_reg") RETURN TRUE BREAK
        CASE HASH("spaceshipparts") RETURN TRUE BREAK
        CASE HASH("spawn_activities") RETURN TRUE BREAK
        CASE HASH("speech_reverb_tracker") RETURN TRUE BREAK
        CASE HASH("spmc_instancer") RETURN TRUE BREAK
        CASE HASH("spmc_preloader") RETURN TRUE BREAK
        CASE HASH("standard_global_init") RETURN TRUE BREAK
        CASE HASH("standard_global_reg") RETURN TRUE BREAK
        CASE HASH("startup") RETURN TRUE BREAK
        CASE HASH("startup_install") RETURN TRUE BREAK
        CASE HASH("startup_locationtest") RETURN TRUE BREAK
        CASE HASH("startup_positioning") RETURN TRUE BREAK
        CASE HASH("startup_smoketest") RETURN TRUE BREAK
        CASE HASH("stats_controller") RETURN TRUE BREAK
        CASE HASH("stock_controller") RETURN TRUE BREAK
        CASE HASH("streaming") RETURN TRUE BREAK
        CASE HASH("stripclub") RETURN TRUE BREAK
        CASE HASH("stripclub_drinking") RETURN TRUE BREAK
        CASE HASH("stripclub_mp") RETURN TRUE BREAK
        CASE HASH("stripperhome") RETURN TRUE BREAK
        CASE HASH("stunt_plane_races") RETURN TRUE BREAK
        CASE HASH("tasklist_1") RETURN TRUE BREAK
        CASE HASH("tattoo_shop") RETURN TRUE BREAK
        CASE HASH("taxi_clowncar") RETURN TRUE BREAK
        CASE HASH("taxi_cutyouin") RETURN TRUE BREAK
        CASE HASH("taxi_deadline") RETURN TRUE BREAK
        CASE HASH("taxi_followcar") RETURN TRUE BREAK
        CASE HASH("taxi_gotyounow") RETURN TRUE BREAK
        CASE HASH("taxi_gotyourback") RETURN TRUE BREAK
        CASE HASH("taxi_needexcitement") RETURN TRUE BREAK
        CASE HASH("taxi_procedural") RETURN TRUE BREAK
        CASE HASH("taxi_takeiteasy") RETURN TRUE BREAK
        CASE HASH("taxi_taketobest") RETURN TRUE BREAK
        CASE HASH("taxilauncher") RETURN TRUE BREAK
        CASE HASH("taxiservice") RETURN TRUE BREAK
        CASE HASH("taxitutorial") RETURN TRUE BREAK
        CASE HASH("tempalpha") RETURN TRUE BREAK
        CASE HASH("temptest") RETURN TRUE BREAK
        CASE HASH("tennis") RETURN TRUE BREAK
        CASE HASH("tennis_ambient") RETURN TRUE BREAK
        CASE HASH("tennis_family") RETURN TRUE BREAK
        CASE HASH("tennis_network_mp") RETURN TRUE BREAK
        CASE HASH("test_startup") RETURN TRUE BREAK
        CASE HASH("thelastone") RETURN TRUE BREAK
        CASE HASH("three_card_poker") RETURN TRUE BREAK
        CASE HASH("timershud") RETURN TRUE BREAK
        CASE HASH("title_update_registration") RETURN TRUE BREAK
        CASE HASH("title_update_registration_2") RETURN TRUE BREAK
        CASE HASH("tonya1") RETURN TRUE BREAK
        CASE HASH("tonya2") RETURN TRUE BREAK
        CASE HASH("tonya3") RETURN TRUE BREAK
        CASE HASH("tonya4") RETURN TRUE BREAK
        CASE HASH("tonya5") RETURN TRUE BREAK
        CASE HASH("towing") RETURN TRUE BREAK
        CASE HASH("traffick_air") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_NSC_HASH_PAGE_11(INT scriptHash)
    SWITCH scriptHash
        CASE HASH("traffick_ground") RETURN TRUE BREAK
        CASE HASH("traffickingsettings") RETURN TRUE BREAK
        CASE HASH("traffickingteleport") RETURN TRUE BREAK
        CASE HASH("train_create_widget") RETURN TRUE BREAK
        CASE HASH("train_tester") RETURN TRUE BREAK
        CASE HASH("trevor1") RETURN TRUE BREAK
        CASE HASH("trevor2") RETURN TRUE BREAK
        CASE HASH("trevor3") RETURN TRUE BREAK
        CASE HASH("trevor4") RETURN TRUE BREAK
        CASE HASH("triathlonsp") RETURN TRUE BREAK
        CASE HASH("tunables_registration") RETURN TRUE BREAK
        CASE HASH("tuneables_processing") RETURN TRUE BREAK
        CASE HASH("tuner_planning") RETURN TRUE BREAK
        CASE HASH("tuner_property_carmod") RETURN TRUE BREAK
        CASE HASH("tuner_sandbox_activity") RETURN TRUE BREAK
        CASE HASH("turret_cam_script") RETURN TRUE BREAK
        CASE HASH("ufo") RETURN TRUE BREAK
        CASE HASH("ugc_global_registration") RETURN TRUE BREAK
        CASE HASH("ugc_global_registration_2") RETURN TRUE BREAK
        CASE HASH("underwaterpickups") RETURN TRUE BREAK
        CASE HASH("utvc") RETURN TRUE BREAK
        CASE HASH("veh_play_widget") RETURN TRUE BREAK
        CASE HASH("vehicle_ai_test") RETURN TRUE BREAK
        CASE HASH("vehicle_force_widget") RETURN TRUE BREAK
        CASE HASH("vehicle_gen_controller") RETURN TRUE BREAK
        CASE HASH("vehicle_plate") RETURN TRUE BREAK
        CASE HASH("vehicle_stealth_mode") RETURN TRUE BREAK
        CASE HASH("vehiclespawning") RETURN TRUE BREAK
        CASE HASH("walking_ped") RETURN TRUE BREAK
        CASE HASH("wardrobe_mp") RETURN TRUE BREAK
        CASE HASH("wardrobe_sp") RETURN TRUE BREAK
        CASE HASH("weapon_audio_widget") RETURN TRUE BREAK
        CASE HASH("wizard_arcade") RETURN TRUE BREAK
        CASE HASH("wp_partyboombox") RETURN TRUE BREAK
        CASE HASH("xml_menus") RETURN TRUE BREAK
        CASE HASH("yoga") RETURN TRUE BREAK
    ENDSWITCH
    RETURN FALSE
ENDFUNC

FUNC BOOL IS_STOCK_OR_CORE_NSC_HASH(INT scriptHash)
    IF scriptHash = 0 RETURN TRUE ENDIF
    IF scriptHash = HASH("ragemenu") RETURN TRUE ENDIF
    IF scriptHash = HASH("ragemenu.nsc") RETURN TRUE ENDIF
    IF scriptHash = HASH("ragemenu.pc") RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_0(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_1(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_2(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_3(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_4(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_5(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_6(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_7(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_8(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_9(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_10(scriptHash) RETURN TRUE ENDIF
    IF IS_STOCK_NSC_HASH_PAGE_11(scriptHash) RETURN TRUE ENDIF
    RETURN FALSE
ENDFUNC

FUNC INT GET_DISCOVERED_CANDIDATE_NSC_COUNT()
    RETURN 51
ENDFUNC

FUNC STRING GET_DISCOVERED_CANDIDATE_NSC_NAME(INT idx)
    SWITCH idx
        CASE 0 RETURN "custom_script" BREAK
        CASE 1 RETURN "custom_nsc" BREAK
        CASE 2 RETURN "test_script" BREAK
        CASE 3 RETURN "mod_menu" BREAK
        CASE 4 RETURN "addon_script" BREAK
        CASE 5 RETURN "trainer" BREAK
        CASE 6 RETURN "freecam" BREAK
        CASE 7 RETURN "map_loader" BREAK
        CASE 8 RETURN "heist_mod" BREAK
        CASE 9 RETURN "car_pack" BREAK
        CASE 10 RETURN "hud_mod" BREAK
        CASE 11 RETURN "custom_1" BREAK
        CASE 12 RETURN "custom_2" BREAK
        CASE 13 RETURN "custom_3" BREAK
        CASE 14 RETURN "custom_4" BREAK
        CASE 15 RETURN "custom_5" BREAK
        CASE 16 RETURN "custom_6" BREAK
        CASE 17 RETURN "custom_7" BREAK
        CASE 18 RETURN "custom_8" BREAK
        CASE 19 RETURN "custom_9" BREAK
        CASE 20 RETURN "custom_10" BREAK
        CASE 21 RETURN "custom_11" BREAK
        CASE 22 RETURN "custom_12" BREAK
        CASE 23 RETURN "custom_13" BREAK
        CASE 24 RETURN "custom_14" BREAK
        CASE 25 RETURN "custom_15" BREAK
        CASE 26 RETURN "custom_16" BREAK
        CASE 27 RETURN "autoload_1" BREAK
        CASE 28 RETURN "autoload_2" BREAK
        CASE 29 RETURN "autoload_3" BREAK
        CASE 30 RETURN "autoload_4" BREAK
        CASE 31 RETURN "autoload_5" BREAK
        CASE 32 RETURN "autoload_6" BREAK
        CASE 33 RETURN "autoload_7" BREAK
        CASE 34 RETURN "autoload_8" BREAK
        CASE 35 RETURN "mod_1" BREAK
        CASE 36 RETURN "mod_2" BREAK
        CASE 37 RETURN "mod_3" BREAK
        CASE 38 RETURN "mod_4" BREAK
        CASE 39 RETURN "mod_5" BREAK
        CASE 40 RETURN "mod_6" BREAK
        CASE 41 RETURN "mod_7" BREAK
        CASE 42 RETURN "mod_8" BREAK
        CASE 43 RETURN "script_1" BREAK
        CASE 44 RETURN "script_2" BREAK
        CASE 45 RETURN "script_3" BREAK
        CASE 46 RETURN "script_4" BREAK
        CASE 47 RETURN "script_5" BREAK
        CASE 48 RETURN "script_6" BREAK
        CASE 49 RETURN "script_7" BREAK
        CASE 50 RETURN "script_8" BREAK
    ENDSWITCH
    RETURN ""
ENDFUNC

PROC SET_NSC_FEEDBACK(INT code)
    g_nsc_feedback_code = code
    g_nsc_feedback_until = GET_GAME_TIMER() + NSC_FEEDBACK_MS
ENDPROC

FUNC BOOL HAS_ACTIVE_NSC_FEEDBACK(INT code)
    RETURN g_nsc_feedback_code = code AND GET_GAME_TIMER() < g_nsc_feedback_until
ENDFUNC

FUNC INT NSC_STACK_SIZE_FROM_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN 1424 BREAK
        CASE 1 RETURN 4096 BREAK
        CASE 2 RETURN 8192 BREAK
    ENDSWITCH
    RETURN 1424
ENDFUNC

FUNC STRING NSC_STACK_LABEL_FROM_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN "< 1424 (Default) >" BREAK
        CASE 1 RETURN "< 4096 (Medium) >" BREAK
        CASE 2 RETURN "< 8192 (Large) >" BREAK
    ENDSWITCH
    RETURN "< 1424 (Default) >"
ENDFUNC

FUNC TEXT_LABEL_63 NORMALIZE_NSC_SCRIPT_NAME(STRING rawName)
    TEXT_LABEL_63 cleaned = ""
    IF IS_STRING_NULL_OR_EMPTY(rawName)
        RETURN cleaned
    ENDIF
    INT len = GET_LENGTH_OF_LITERAL_STRING(rawName)
    IF len > 4
        STRING suffix = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(rawName, len - 4, len)
        IF COMPARE_STRINGS(suffix, ".nsc", FALSE, 4) = 0
            cleaned = GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME(rawName, 0, len - 4)
            RETURN cleaned
        ENDIF
    ENDIF
    cleaned = rawName
    RETURN cleaned
ENDFUNC

FUNC INT FIND_CUSTOM_NSC_SLOT_BY_HASH(INT scriptHash)
    IF scriptHash = 0 RETURN -1 ENDIF
    INT i = 0
    WHILE i < g_nsc_discovered_count
        IF g_nsc_script_hashes[i] = scriptHash
            RETURN i
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN -1
ENDFUNC

PROC SYNC_CUSTOM_NSC_THREAD_STATES()
    INT i = 0
    WHILE i < g_nsc_discovered_count
        BOOL activeNow = FALSE
        IF NATIVE_TO_INT(g_nsc_thread_ids[i]) <> 0
            IF IS_THREAD_ACTIVE(g_nsc_thread_ids[i])
                activeNow = TRUE
            ELSE
                g_nsc_thread_ids[i] = INT_TO_NATIVE(THREADID, 0)
            ENDIF
        ENDIF
        IF NOT activeNow
            IF GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(g_nsc_script_hashes[i]) > 0
                activeNow = TRUE
            ENDIF
        ENDIF
        g_nsc_is_active[i] = activeNow
        i = i + 1
    ENDWHILE
ENDPROC

FUNC INT COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
    SYNC_CUSTOM_NSC_THREAD_STATES()
    INT activeCount = 0
    INT i = 0
    WHILE i < g_nsc_discovered_count
        IF g_nsc_is_active[i]
            activeCount = activeCount + 1
        ENDIF
        i = i + 1
    ENDWHILE
    RETURN activeCount
ENDFUNC

FUNC BOOL TRY_REGISTER_CUSTOM_NSC(STRING candidateName)
    IF IS_STRING_NULL_OR_EMPTY(candidateName)
        RETURN FALSE
    ENDIF
    TEXT_LABEL_63 cleanName = NORMALIZE_NSC_SCRIPT_NAME(candidateName)
    IF IS_STRING_NULL_OR_EMPTY(cleanName)
        RETURN FALSE
    ENDIF
    INT scriptHash = GET_HASH_KEY(cleanName)
    IF IS_STOCK_OR_CORE_NSC_HASH(scriptHash)
        RETURN FALSE
    ENDIF
    IF NOT DOES_SCRIPT_EXIST(cleanName)
        RETURN FALSE
    ENDIF
    INT existingSlot = FIND_CUSTOM_NSC_SLOT_BY_HASH(scriptHash)
    IF existingSlot >= 0
        RETURN TRUE
    ENDIF
    IF g_nsc_discovered_count >= NSC_MAX_CUSTOM_SCRIPTS
        RETURN FALSE
    ENDIF
    INT slot = g_nsc_discovered_count
    g_nsc_script_names[slot] = cleanName
    g_nsc_script_hashes[slot] = scriptHash
    g_nsc_thread_ids[slot] = INT_TO_NATIVE(THREADID, 0)
    g_nsc_is_active[slot] = (GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(scriptHash) > 0)
    g_nsc_discovered_count = g_nsc_discovered_count + 1
    RETURN TRUE
ENDFUNC

PROC SCAN_CUSTOM_NSC_DIRECTORY()
    INT idx = 0
    INT candidateCount = GET_DISCOVERED_CANDIDATE_NSC_COUNT()
    WHILE idx < candidateCount
        STRING candidate = GET_DISCOVERED_CANDIDATE_NSC_NAME(idx)
        TRY_REGISTER_CUSTOM_NSC(candidate)
        idx = idx + 1
    ENDWHILE
    SCRIPT_THREAD_ITERATOR_RESET()
    THREADID tid = SCRIPT_THREAD_ITERATOR_GET_NEXT_THREAD_ID()
    WHILE NATIVE_TO_INT(tid) <> 0
        IF IS_THREAD_ACTIVE(tid)
            STRING runningName = GET_NAME_OF_SCRIPT_WITH_THIS_ID(tid)
            IF TRY_REGISTER_CUSTOM_NSC(runningName)
                TEXT_LABEL_63 cleanRunning = NORMALIZE_NSC_SCRIPT_NAME(runningName)
                INT slot = FIND_CUSTOM_NSC_SLOT_BY_HASH(GET_HASH_KEY(cleanRunning))
                IF slot >= 0
                    g_nsc_thread_ids[slot] = tid
                    g_nsc_is_active[slot] = TRUE
                ENDIF
            ENDIF
        ENDIF
        tid = SCRIPT_THREAD_ITERATOR_GET_NEXT_THREAD_ID()
    ENDWHILE
    SYNC_CUSTOM_NSC_THREAD_STATES()
    g_nsc_initial_scan_done = TRUE
    SET_NSC_FEEDBACK(1)
ENDPROC

PROC ENSURE_CUSTOM_NSC_INITIAL_SCAN()
    IF NOT g_nsc_initial_scan_done
        SCAN_CUSTOM_NSC_DIRECTORY()
    ELSE
        SYNC_CUSTOM_NSC_THREAD_STATES()
    ENDIF
ENDPROC

PROC PROBE_CUSTOM_NSC_FROM_KEYBOARD(STRING rawInput)
    TEXT_LABEL_63 cleanName = NORMALIZE_NSC_SCRIPT_NAME(rawInput)
    IF IS_STRING_NULL_OR_EMPTY(cleanName)
        EXIT
    ENDIF
    g_nsc_last_probed_name = cleanName
    INT scriptHash = GET_HASH_KEY(cleanName)
    IF IS_STOCK_OR_CORE_NSC_HASH(scriptHash)
        SET_NSC_FEEDBACK(2)
        EXIT
    ENDIF
    IF NOT DOES_SCRIPT_EXIST(cleanName)
        SET_NSC_FEEDBACK(3)
        EXIT
    ENDIF
    IF TRY_REGISTER_CUSTOM_NSC(cleanName)
        SET_NSC_FEEDBACK(4)
        INT slot = FIND_CUSTOM_NSC_SLOT_BY_HASH(scriptHash)
        IF slot >= 0 AND g_nsc_loader_open
            g_item = NSC_LOADER_HEADER_ROWS + slot
            IF g_item < g_scroll
                g_scroll = g_item
            ENDIF
            IF g_item >= g_scroll + 8
                g_scroll = g_item - 7
            ENDIF
        ENDIF
    ENDIF
ENDPROC

PROC TERMINATE_AND_UNLOAD_CUSTOM_NSC_SLOT(INT slot)
    IF slot < 0 OR slot >= g_nsc_discovered_count EXIT ENDIF
    IF NATIVE_TO_INT(g_nsc_thread_ids[slot]) <> 0
        IF IS_THREAD_ACTIVE(g_nsc_thread_ids[slot])
            TERMINATE_THREAD(g_nsc_thread_ids[slot])
        ENDIF
        g_nsc_thread_ids[slot] = INT_TO_NATIVE(THREADID, 0)
    ENDIF
    INT targetHash = g_nsc_script_hashes[slot]
    SCRIPT_THREAD_ITERATOR_RESET()
    THREADID tid = SCRIPT_THREAD_ITERATOR_GET_NEXT_THREAD_ID()
    WHILE NATIVE_TO_INT(tid) <> 0
        IF IS_THREAD_ACTIVE(tid)
            STRING tName = GET_NAME_OF_SCRIPT_WITH_THIS_ID(tid)
            IF NOT IS_STRING_NULL_OR_EMPTY(tName)
                TEXT_LABEL_63 cleanTName = NORMALIZE_NSC_SCRIPT_NAME(tName)
                IF GET_HASH_KEY(cleanTName) = targetHash
                    TERMINATE_THREAD(tid)
                ENDIF
            ENDIF
        ENDIF
        tid = SCRIPT_THREAD_ITERATOR_GET_NEXT_THREAD_ID()
    ENDWHILE
    SET_SCRIPT_AS_NO_LONGER_NEEDED(g_nsc_script_names[slot])
    g_nsc_is_active[slot] = FALSE
ENDPROC

PROC STOP_ALL_CUSTOM_NSC_SCRIPTS()
    IF g_nsc_async_stage <> NSC_STAGE_IDLE AND g_nsc_async_slot >= 0 AND g_nsc_async_slot < g_nsc_discovered_count
        SET_SCRIPT_AS_NO_LONGER_NEEDED(g_nsc_script_names[g_nsc_async_slot])
    ENDIF
    g_nsc_async_stage = NSC_STAGE_IDLE
    g_nsc_async_slot = -1
    INT i = 0
    WHILE i < g_nsc_discovered_count
        TERMINATE_AND_UNLOAD_CUSTOM_NSC_SLOT(i)
        i = i + 1
    ENDWHILE
    SET_NSC_FEEDBACK(9)
ENDPROC

PROC TRIGGER_LOAD_OR_RELOAD_CUSTOM_NSC(INT slot)
    IF slot < 0 OR slot >= g_nsc_discovered_count EXIT ENDIF
    SYNC_CUSTOM_NSC_THREAD_STATES()
    IF g_nsc_async_stage <> NSC_STAGE_IDLE AND g_nsc_async_slot >= 0 AND g_nsc_async_slot < g_nsc_discovered_count
        SET_SCRIPT_AS_NO_LONGER_NEEDED(g_nsc_script_names[g_nsc_async_slot])
        g_nsc_async_stage = NSC_STAGE_IDLE
    ENDIF
    IF NOT DOES_SCRIPT_EXIST(g_nsc_script_names[slot])
        SET_NSC_FEEDBACK(3)
        g_nsc_async_slot = -1
        EXIT
    ENDIF
    g_nsc_async_slot = slot
    IF g_nsc_is_active[slot]
        TERMINATE_AND_UNLOAD_CUSTOM_NSC_SLOT(slot)
        g_nsc_async_stage = NSC_STAGE_TERMINATING
        g_nsc_async_deadline = GET_GAME_TIMER() + NSC_TERMINATE_TIMEOUT_MS
    ELSE
        REQUEST_SCRIPT(g_nsc_script_names[slot])
        g_nsc_async_stage = NSC_STAGE_LOADING
        g_nsc_async_deadline = GET_GAME_TIMER() + NSC_LOAD_TIMEOUT_MS
    ENDIF
ENDPROC

PROC PROCESS_CUSTOM_NSC_LOADER()
    IF g_nsc_async_stage = NSC_STAGE_IDLE EXIT ENDIF
    INT slot = g_nsc_async_slot
    IF slot < 0 OR slot >= g_nsc_discovered_count
        g_nsc_async_stage = NSC_STAGE_IDLE
        g_nsc_async_slot = -1
        EXIT
    ENDIF
    IF g_nsc_async_stage = NSC_STAGE_TERMINATING
        INT runningCount = GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(g_nsc_script_hashes[slot])
        IF runningCount = 0 OR GET_GAME_TIMER() > g_nsc_async_deadline
            REQUEST_SCRIPT(g_nsc_script_names[slot])
            g_nsc_async_stage = NSC_STAGE_LOADING
            g_nsc_async_deadline = GET_GAME_TIMER() + NSC_LOAD_TIMEOUT_MS
        ENDIF
        EXIT
    ENDIF
    IF g_nsc_async_stage = NSC_STAGE_LOADING
        IF HAS_SCRIPT_LOADED(g_nsc_script_names[slot])
            INT stackSize = NSC_STACK_SIZE_FROM_CHOICE(g_nsc_stack_choice)
            THREADID newThread = START_NEW_SCRIPT(g_nsc_script_names[slot], stackSize)
            SET_SCRIPT_AS_NO_LONGER_NEEDED(g_nsc_script_names[slot])
            g_nsc_thread_ids[slot] = newThread
            g_nsc_is_active[slot] = (NATIVE_TO_INT(newThread) <> 0)
            g_nsc_async_stage = NSC_STAGE_IDLE
            g_nsc_async_slot = -1
            IF g_nsc_is_active[slot]
                SET_NSC_FEEDBACK(5)
            ELSE
                SET_NSC_FEEDBACK(7)
            ENDIF
            EXIT
        ENDIF
        IF GET_GAME_TIMER() > g_nsc_async_deadline
            SET_SCRIPT_AS_NO_LONGER_NEEDED(g_nsc_script_names[slot])
            g_nsc_async_stage = NSC_STAGE_IDLE
            g_nsc_async_slot = -1
            SET_NSC_FEEDBACK(8)
        ENDIF
    ENDIF
ENDPROC

FUNC INT NSC_LOADER_TOTAL_ROWS()
    IF g_nsc_discovered_count > 0
        RETURN NSC_LOADER_HEADER_ROWS + g_nsc_discovered_count
    ENDIF
    RETURN NSC_LOADER_HEADER_ROWS + 1
ENDFUNC

FUNC TEXT_LABEL_63 FORMAT_NSC_RESCAN_BADGE()
    TEXT_LABEL_63 badge = ""
    IF HAS_ACTIVE_NSC_FEEDBACK(1)
        badge = "SCANNED ("
        badge += g_nsc_discovered_count
        badge += ")"
        RETURN badge
    ENDIF
    badge = "SCAN ("
    badge += g_nsc_discovered_count
    badge += " FOUND)"
    RETURN badge
ENDFUNC

FUNC TEXT_LABEL_63 FORMAT_NSC_PROBE_BADGE()
    TEXT_LABEL_63 badge = ""
    IF HAS_ACTIVE_NSC_FEEDBACK(2)
        badge = "BLOCKED (STOCK/CORE)"
        RETURN badge
    ENDIF
    IF HAS_ACTIVE_NSC_FEEDBACK(3)
        badge = "NOT IN SCRIPT_REL"
        RETURN badge
    ENDIF
    IF HAS_ACTIVE_NSC_FEEDBACK(4)
        badge = "ADDED: "
        badge += g_nsc_last_probed_name
        RETURN badge
    ENDIF
    IF NOT IS_STRING_NULL_OR_EMPTY(g_nsc_last_probed_name)
        badge = g_nsc_last_probed_name
        badge += ".nsc"
        RETURN badge
    ENDIF
    badge = "INPUT NAME"
    RETURN badge
ENDFUNC

FUNC TEXT_LABEL_63 FORMAT_NSC_STOP_ALL_BADGE()
    TEXT_LABEL_63 badge = ""
    IF HAS_ACTIVE_NSC_FEEDBACK(9)
        badge = "ALL STOPPED"
        RETURN badge
    ENDIF
    INT activeCount = COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS()
    badge = "STOP ("
    badge += activeCount
    badge += " ACTIVE)"
    RETURN badge
ENDFUNC

FUNC TEXT_LABEL_63 FORMAT_CUSTOM_NSC_ROW_LABEL(INT slot)
    TEXT_LABEL_63 label = ""
    IF slot < 0 OR slot >= g_nsc_discovered_count
        label = "No Custom .nsc Detected"
        RETURN label
    ENDIF
    label = g_nsc_script_names[slot]
    label += ".nsc"
    RETURN label
ENDFUNC

FUNC TEXT_LABEL_63 FORMAT_CUSTOM_NSC_ROW_BADGE(INT slot, INT &outState)
    TEXT_LABEL_63 badge = ""
    outState = 2
    IF slot < 0 OR slot >= g_nsc_discovered_count
        badge = "SCAN / PROBE"
        outState = 0
        RETURN badge
    ENDIF
    IF g_nsc_async_slot = slot AND g_nsc_async_stage = NSC_STAGE_TERMINATING
        badge = "RELOADING..."
        outState = 2
        RETURN badge
    ENDIF
    IF g_nsc_async_slot = slot AND g_nsc_async_stage = NSC_STAGE_LOADING
        badge = "LOADING..."
        outState = 2
        RETURN badge
    ENDIF
    IF g_nsc_is_active[slot]
        badge = "ACTIVE [A: RELOAD]"
        outState = 1
    ELSE
        badge = "LOAD"
        outState = 2
    ENDIF
    RETURN badge
ENDFUNC
