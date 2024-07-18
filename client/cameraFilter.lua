--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------
--time cycle modifier zum suchen

-- list of available filters ( https://pastebin.com/kVPwMemE )
Config.filterList = {
    "None",                   
    "AP1_01_B_IntRefRange",
    "AP1_01_C_NoFog",
    "AirRaceBoost01",
    "AirRaceBoost02",
    "AmbientPUSH",
    "ArenaEMP",
    "ArenaEMP_Blend",
    "ArenaWheelPurple01",
    "ArenaWheelPurple02",
    "Bank_HLWD",
    "Barry1_Stoned",
    "BarryFadeOut",
    "BeastIntro01",
    "BeastIntro02",
    "BeastLaunch01",
    "BeastLaunch02",
    "BikerFilter",
    "BikerForm01",
    "BikerFormFlash",
    "Bikers",
    "BikersSPLASH",
    "BlackOut",
    "BleepYellow01",
    "BleepYellow02",
    "Bloom",
    "BloomLight",
    "BloomMid",
    "BombCam01",
    "BombCamFlash",
    "Broken_camera_fuzz",
    "BulletTimeDark",
    "BulletTimeLight",
    "CAMERA_BW",
    "CAMERA_secuirity",
    "CAMERA_secuirity_FUZZ",
    "CH3_06_water",
    "CHOP",
    "CS1_railwayB_tunnel",
    "CS3_rail_tunnel",
    "CUSTOM_streetlight",
    "Carpark_MP_exit",
    "CopsSPLASH",
    "CrossLine01",
    "CrossLine02",
    "DONT_overide_sunpos",
    "DRUG_2_drive",
    "DRUG_gas_huffin",
    "DeadlineNeon01",
    "DefaultColorCode",
    "Dont_tazeme_bro",
    "DrivingFocusDark",
    "DrivingFocusLight",
    "Drone_FishEye_Lens",
    "Drug_deadman",
    "Drug_deadman_blend",
    "Drunk",
    "EXTRA_bouncelight",
    "EXT_FULLAmbientmult_art",
    "ExplosionJosh",
    "FIB_5",
    "FIB_6",
    "FIB_A",
    "FIB_B",
    "FIB_interview",
    "FIB_interview_optimise",
    "FORdoron_delete",
    "FRANKLIN",
    "Facebook_NEW",
    "FinaleBank",
    "FinaleBankMid",
    "FinaleBankexit",
    "Forest",
    "FrankilinsHOUSEhills",
    "FranklinColorCode",
    "FranklinColorCodeBasic",
    "FranklinColorCodeBright",
    "FullAmbientmult_interior",
    "Glasses_BlackOut",
    "Hanger_INTmods",
    "Hicksbar",
    "HicksbarNEW",
    "Hint_cam",
    "IMpExt_Interior_02",
    "IMpExt_Interior_02_stair_cage",
    "INT_FULLAmbientmult_art",
    "INT_FULLAmbientmult_both",
    "INT_FullAmbientmult",
    "INT_NO_fogALPHA",
    "INT_NOdirectLight",
    "INT_NoAmbientmult",
    "INT_NoAmbientmult_art",
    "INT_NoAmbientmult_both",
    "INT_garage",
    "INT_mall",
    "INT_nowaterREF",
    "INT_posh_hairdresser",
    "INT_smshop",
    "INT_smshop_inMOD",
    "INT_smshop_indoor_bloom",
    "INT_smshop_outdoor_bloom",
    "INT_streetlighting",
    "INT_trailer_cinema",
    "ImpExp_Interior_01",
    "InchOrange01",
    "InchOrange02",
    "InchPickup01",
    "InchPickup02",
    "InchPurple01",
    "InchPurple02",
    "KT_underpass",
    "Kifflom",
    "LIGHTSreduceFALLOFF",
    "LODmult_HD_orphan_LOD_reduce",
    "LODmult_HD_orphan_reduce",
    "LODmult_LOD_reduce",
    "LODmult_SLOD1_reduce",
    "LODmult_SLOD2_reduce",
    "LODmult_SLOD3_reduce",
    "LODmult_global_reduce",
    "LODmult_global_reduce_NOHD",
    "LectroDark",
    "LectroLight",
    "LifeInvaderLOD",
    "LightPollutionHills",
    "LostTimeDark",
    "LostTimeFlash",
    "LostTimeLight",
    "METRO_Tunnels",
    "METRO_Tunnels_entrance",
    "METRO_platform",
    "MPApartHigh",
    "MPApartHigh_palnning",
    "MPApart_H_01",
    "MPApart_H_01_gym",
    "MP_Arena_VIP",
    "MP_Arena_theme_atlantis",
    "MP_Arena_theme_evening",
    "MP_Arena_theme_hell",
    "MP_Arena_theme_midday",
    "MP_Arena_theme_morning",
    "MP_Arena_theme_night",
    "MP_Arena_theme_saccharine",
    "MP_Arena_theme_sandstorm",
    "MP_Arena_theme_scifi_night",
    "MP_Arena_theme_storm",
    "MP_Arena_theme_toxic",
    "MP_Bull_tost",
    "MP_Bull_tost_blend",
    "MP_Garage_L",
    "MP_H_01_Bathroom",
    "MP_H_01_Bedroom",
    "MP_H_01_New",
    "MP_H_01_New_Bathroom",
    "MP_H_01_New_Bedroom",
    "MP_H_01_New_Study",
    "MP_H_01_Study",
    "MP_H_02",
    "MP_H_04",
    "MP_H_06",
    "MP_Killstreak",
    "MP_Killstreak_blend",
    "MP_Loser",
    "MP_Loser_blend",
    "MP_MedGarage",
    "MP_Powerplay",
    "MP_Powerplay_blend",
    "MP_Studio_Lo",
    "MP_corona_heist",
    "MP_corona_heist_BW",
    "MP_corona_heist_BW_night",
    "MP_corona_heist_DOF",
    "MP_corona_heist_blend",
    "MP_corona_heist_night",
    "MP_corona_heist_night_blend",
    "MP_corona_selection",
    "MP_corona_switch",
    "MP_corona_tournament",
    "MP_corona_tournament_DOF",
    "MP_death_grade",
    "MP_death_grade_blend01",
    "MP_death_grade_blend02",
    "MP_deathfail_night",
    "MP_heli_cam",
    "MP_intro_logo",
    "MP_job_end_night",
    "MP_job_load",
    "MP_job_load_01",
    "MP_job_load_02",
    "MP_job_lose",
    "MP_job_preload",
    "MP_job_preload_blend",
    "MP_job_preload_night",
    "MP_job_win",
    "MP_lowgarage",
    "MP_race_finish",
    "MP_select",
    "MichaelColorCode",
    "MichaelColorCodeBasic",
    "MichaelColorCodeBright",
    "MichaelsDarkroom",
    "MichaelsDirectional",
    "MichaelsNODirectional",
    "Mp_Stilts",
    "Mp_Stilts2",
    "Mp_Stilts2_bath",
    "Mp_Stilts_gym",
    "Mp_Stilts_gym2",
    "Mp_apart_mid",
    "Multipayer_spectatorCam",
    "NEW_abattoir",
    "NEW_jewel",
    "NEW_jewel_EXIT",
    "NEW_lesters",
    "NEW_ornate_bank",
    "NEW_ornate_bank_entrance",
    "NEW_ornate_bank_office",
    "NEW_ornate_bank_safe",
    "NEW_shrinksOffice",
    "NEW_station_unfinished",
    "NEW_trevorstrailer",
    "NEW_tunnels",
    "NEW_tunnels_ditch",
    "NEW_tunnels_hole",
    "NEW_yellowtunnels",
    "NG_blackout",
    "NG_deathfail_BW_base",
    "NG_deathfail_BW_blend01",
    "NG_deathfail_BW_blend02",
    "NG_filmic01",
    "NG_filmic02",
    "NG_filmic03",
    "NG_filmic04",
    "NG_filmic05",
    "NG_filmic06",
    "NG_filmic07",
    "NG_filmic08",
    "NG_filmic09",
    "NG_filmic10",
    "NG_filmic11",
    "NG_filmic12",
    "NG_filmic13",
    "NG_filmic14",
    "NG_filmic15",
    "NG_filmic16",
    "NG_filmic17",
    "NG_filmic18",
    "NG_filmic19",
    "NG_filmic20",
    "NG_filmic21",
    "NG_filmic22",
    "NG_filmic23",
    "NG_filmic24",
    "NG_filmic25",
    "NG_filmnoir_BW01",
    "NG_filmnoir_BW02",
    "NG_first",
    "NO_coronas",
    "NO_fog_alpha",
    "NO_streetAmbient",
    "NO_weather",
    "NOdirectLight",
    "NOrain",
    "NeutralColorCode",
    "NeutralColorCodeBasic",
    "NeutralColorCodeBright",
    "NeutralColorCodeLight",
    "NewMicheal",
    "NewMicheal_night",
    "NewMicheal_upstairs",
    "NewMichealgirly",
    "NewMichealstoilet",
    "NewMichealupstairs",
    "New_sewers",
    "NoAmbientmult",
    "NoAmbientmult_interior",
    "NoPedLight",
    "OrbitalCannon",
    "PERSHING_water_reflect",
    "PORT_heist_underwater",
    "PPFilter",
    "PPGreen01",
    "PPGreen02",
    "PPOrange01",
    "PPOrange02",
    "PPPink01",
    "PPPink02",
    "PPPurple01",
    "PPPurple02",
    "Paleto",
    "PennedInDark",
    "PennedInLight",
    "PlayerSwitchNeutralFlash",
    "PlayerSwitchPulse",
    "PoliceStation",
    "PoliceStationDark",
    "Prologue_shootout_opt",
    "REDMIST",
    "REDMIST_blend",
    "RaceTurboDark",
    "RaceTurboFlash",
    "RaceTurboLight",
    "ReduceDrawDistance",
    "ReduceDrawDistanceMAP",
    "ReduceDrawDistanceMission",
    "ReduceSSAO",
    "RemixDrone",
    "RemoteSniper",
    "SALTONSEA",
    "SAWMILL",
    "SP1_03_drawDistance",
    "STRIP_changing",
    "STRIP_nofog",
    "STRIP_office",
    "STRIP_stage",
    "SheriffStation",
    "Shop247",
    "Shop247_none",
    "SmugglerCheckpoint01",
    "SmugglerCheckpoint02",
    "SmugglerFlash",
    "Sniper",
    "StadLobby",
    "StreetLighting",
    "StreetLightingJunction",
    "StreetLightingtraffic",
    "StuntFastDark",
    "StuntFastLight",
    "StuntSlowDark",
    "StuntSlowLight",
    "TREVOR",
    "TUNNEL_green",
    "TUNNEL_green_ext",
    "TUNNEL_orange",
    "TUNNEL_orange_exterior",
    "TUNNEL_white",
    "TUNNEL_yellow",
    "TUNNEL_yellow_ext",
    "TinyGreen01",
    "TinyGreen02",
    "TinyPink01",
    "TinyPink02",
    "TinyRacerMoBlur",
    "TransformFlash",
    "TransformRaceFlash",
    "TrevorColorCode",
    "TrevorColorCodeBasic",
    "TrevorColorCodeBright",
    "Trevors_room",
    "Tunnel",
    "Tunnel_green1",
    "VAGOS_new_garage",
    "VAGOS_new_hangout",
    "VC_tunnel_entrance",
    "V_Abattoir_Cold",
    "V_CIA_Facility",
    "V_FIB_IT3",
    "V_FIB_IT3_alt",
    "V_FIB_IT3_alt5",
    "V_FIB_stairs",
    "V_Metro2",
    "V_Metro_station",
    "V_Office_smoke",
    "V_Office_smoke_Fire",
    "V_Office_smoke_ext",
    "V_Solomons",
    "V_recycle_dark",
    "V_recycle_light",
    "V_recycle_mainroom",
    "V_strip_nofog",
    "V_strip_office",
    "Vagos",
    "VagosSPLASH",
    "VolticBlur",
    "VolticFlash",
    "VolticGold",
    "WATER_lab_cooling",
    "WATER_CH2_06_01_03",
    "WATER_CH2_06_02",
    "WATER_CH2_06_04",
    "WATER_ID2_21",
    "WATER_REF_malibu",
    "WATER_RichmanStuntJump",
    "WATER_cove",
    "WATER_hills",
    "WATER_lab",
    "WATER_militaryPOOP",
    "WATER_muddy",
    "WATER_port",
    "WATER_refmap_high",
    "WATER_refmap_hollywoodlake",
    "WATER_refmap_low",
    "WATER_refmap_med",
    "WATER_refmap_off",
    "WATER_refmap_poolside",
    "WATER_refmap_silverlake",
    "WATER_refmap_venice",
    "WATER_refmap_verylow",
    "WATER_resevoir",
    "WATER_river",
    "WATER_salton",
    "WATER_salton_bottom",
    "WATER_shore",
    "WATER_silty",
    "WATER_silverlake",
    "WarpCheckpoint",
    "WeaponUpgrade",
    "WhiteOut",
    "baseTONEMAPPING",
    "blackNwhite",
    "buggy_shack",
    "buildingTOP",
    "cBank_back",
    "cBank_front",
    "canyon_mission",
    "carMOD_underpass",
    "carpark",
    "carpark_dt1_02",
    "carpark_dt1_03",
    "cashdepot",
    "cashdepotEMERGENCY",
    "ch2_tunnel_whitelight",
    "cinema",
    "cinema_001",
    "cops",
    "crane_cam",
    "crane_cam_cinematic",
    "damage",
    "default",
    "dont_tazeme_bro_b",
    "downtown_FIB_cascades_opt",
    "drug_drive_blend01",
    "drug_drive_blend02",
    "drug_flying_01",
    "drug_flying_02",
    "drug_flying_base",
    "drug_wobbly",
    "dying",
    "eatra_bouncelight_beach",
    "epsilion",
    "exile1_exit",
    "exile1_plane",
    "ext_int_extlight_large",
    "eyeINtheSKY",
    "facebook_serveroom",
    "fireDEPT",
    "fp_vig_black",
    "fp_vig_blue",
    "fp_vig_brown",
    "fp_vig_gray",
    "fp_vig_green",
    "fp_vig_red",
    "frankilnsAUNTS_SUNdir",
    "frankilnsAUNTS_new",
    "gallery_refmod",
    "garage",
    "gen_bank",
    "glasses_Darkblue",
    "glasses_Scuba",
    "glasses_VISOR",
    "glasses_black",
    "glasses_blue",
    "glasses_brown",
    "glasses_green",
    "glasses_orange",
    "glasses_pink",
    "glasses_purple",
    "glasses_red",
    "glasses_yellow",
    "gorge_reflection_gpu",
    "gorge_reflectionoffset",
    "gorge_reflectionoffset2",
    "graveyard_shootout",
    "grdlc_int_02",
    "grdlc_int_02_trailer_cave",
    "gunclub",
    "gunclubrange",
    "gunshop",
    "gunstore",
    "half_direct",
    "hangar_lightsmod",
    "heathaze",
    "heist_boat",
    "heist_boat_engineRoom",
    "heist_boat_norain",
    "heliGunCam",
    "helicamfirst",
    "hillstunnel",
    "hitped",
    "hud_def_Franklin",
    "hud_def_Michael",
    "hud_def_Trevor",
    "hud_def_blur",
    "hud_def_blur_switch",
    "hud_def_colorgrade",
    "hud_def_desat_Franklin",
    "hud_def_desat_Michael",
    "hud_def_desat_Neutral",
    "hud_def_desat_Trevor",
    "hud_def_desat_cold",
    "hud_def_desat_cold_kill",
    "hud_def_desat_switch",
    "hud_def_desatcrunch",
    "hud_def_flash",
    "hud_def_focus",
    "hud_def_lensdistortion",
    "hud_def_lensdistortion_subtle",
    "id1_11_tunnel",
    "impexp_interior_01_lift",
    "int_Barber1",
    "int_ClothesHi",
    "int_ControlTower_none",
    "int_ControlTower_small",
    "int_Farmhouse_none",
    "int_Farmhouse_small",
    "int_FranklinAunt_small",
    "int_GasStation",
    "int_Hospital2_DM",
    "int_Hospital_Blue",
    "int_Hospital_BlueB",
    "int_Hospital_DM",
    "int_Lost_none",
    "int_Lost_small",
    "int_amb_mult_large",
    "int_arena_01",
    "int_arena_Mod",
    "int_arena_Mod_garage",
    "int_arena_VIP",
    "int_carmod_small",
    "int_carrier_control",
    "int_carrier_control_2",
    "int_carrier_hanger",
    "int_carrier_rear",
    "int_carrier_stair",
    "int_carshowroom",
    "int_chopshop",
    "int_clean_extlight_large",
    "int_clean_extlight_none",
    "int_clean_extlight_small",
    "int_clotheslow_large",
    "int_cluckinfactory_none",
    "int_cluckinfactory_small",
    "int_dockcontrol_small",
    "int_extlght_sm_cntrst",
    "int_extlight_large",
    "int_extlight_large_fog",
    "int_extlight_none",
    "int_extlight_none_dark",
    "int_extlight_none_dark_fog",
    "int_extlight_none_fog",
    "int_extlight_small",
    "int_extlight_small_clipped",
    "int_extlight_small_fog",
    "int_hanger_none",
    "int_hanger_small",
    "int_hospital_dark",
    "int_hospital_small",
    "int_lesters",
    "int_methlab_small",
    "int_motelroom",
    "int_office_Lobby",
    "int_office_LobbyHall",
    "int_tattoo",
    "int_tattoo_B",
    "int_tunnel_none_dark",
    "interior_WATER_lighting",
    "introblue",
    "jewel_gas",
    "jewel_optim",
    "jewelry_entrance",
    "jewelry_entrance_INT",
    "jewelry_entrance_INT_fog",
    "lab_none",
    "lab_none_dark",
    "lab_none_dark_OVR",
    "lab_none_dark_fog",
    "lab_none_exit",
    "lab_none_exit_OVR",
    "li",
    "lightning",
    "lightning_cloud",
    "lightning_strong",
    "lightning_weak",
    "lightpolution",
    "lodscaler",
    "maxlodscaler",
    "metro",
    "micheal",
    "micheals_lightsOFF",
    "michealspliff",
    "michealspliff_blend",
    "michealspliff_blend02",
    "militarybase_nightlight",
    "mineshaft",
    "morebloom",
    "morgue_dark",
    "morgue_dark_ovr",
    "mp_battle_int01",
    "mp_battle_int01_dancefloor",
    "mp_battle_int01_dancefloor_OFF",
    "mp_battle_int01_entry",
    "mp_battle_int01_garage",
    "mp_battle_int01_office",
    "mp_battle_int02",
    "mp_battle_int03",
    "mp_battle_int03_tint1",
    "mp_battle_int03_tint2",
    "mp_battle_int03_tint3",
    "mp_battle_int03_tint4",
    "mp_battle_int03_tint5",
    "mp_battle_int03_tint6",
    "mp_battle_int03_tint7",
    "mp_battle_int03_tint8",
    "mp_battle_int03_tint9",
    "mp_bkr_int01_garage",
    "mp_bkr_int01_small_rooms",
    "mp_bkr_int01_transition",
    "mp_bkr_int02_garage",
    "mp_bkr_int02_hangout",
    "mp_bkr_int02_small_rooms",
    "mp_bkr_ware01",
    "mp_bkr_ware02_dry",
    "mp_bkr_ware02_standard",
    "mp_bkr_ware02_upgrade",
    "mp_bkr_ware03_basic",
    "mp_bkr_ware03_upgrade",
    "mp_bkr_ware04",
    "mp_bkr_ware05",
    "mp_exec_office_01",
    "mp_exec_office_02",
    "mp_exec_office_03",
    "mp_exec_office_03C",
    "mp_exec_office_03_blue",
    "mp_exec_office_04",
    "mp_exec_office_05",
    "mp_exec_office_06",
    "mp_exec_warehouse_01",
    "mp_gr_int01_black",
    "mp_gr_int01_grey",
    "mp_gr_int01_white",
    "mp_h_05",
    "mp_h_07",
    "mp_h_08",
    "mp_imx_intwaremed",
    "mp_imx_intwaremed_office",
    "mp_imx_mod_int_01",
    "mp_lad_day",
    "mp_lad_judgment",
    "mp_lad_night",
    "mp_nightshark_shield_fp",
    "mp_smg_int01_han",
    "mp_smg_int01_han_blue",
    "mp_smg_int01_han_red",
    "mp_smg_int01_han_yellow",
    "mp_x17dlc_base",
    "mp_x17dlc_base_dark",
    "mp_x17dlc_base_darkest",
    "mp_x17dlc_facility",
    "mp_x17dlc_facility2",
    "mp_x17dlc_facility_conference",
    "mp_x17dlc_in_sub",
    "mp_x17dlc_in_sub_no_reflection",
    "mp_x17dlc_int_01",
    "mp_x17dlc_int_01_tint1",
    "mp_x17dlc_int_01_tint2",
    "mp_x17dlc_int_01_tint3",
    "mp_x17dlc_int_01_tint4",
    "mp_x17dlc_int_01_tint5",
    "mp_x17dlc_int_01_tint6",
    "mp_x17dlc_int_01_tint7",
    "mp_x17dlc_int_01_tint8",
    "mp_x17dlc_int_01_tint9",
    "mp_x17dlc_int_02",
    "mp_x17dlc_int_02_hangar",
    "mp_x17dlc_int_02_outdoor_intro_camera",
    "mp_x17dlc_int_02_tint1",
    "mp_x17dlc_int_02_tint2",
    "mp_x17dlc_int_02_tint3",
    "mp_x17dlc_int_02_tint4",
    "mp_x17dlc_int_02_tint5",
    "mp_x17dlc_int_02_tint6",
    "mp_x17dlc_int_02_tint7",
    "mp_x17dlc_int_02_tint8",
    "mp_x17dlc_int_02_tint9",
    "mp_x17dlc_int_02_vehicle_avenger_camera",
    "mp_x17dlc_int_02_vehicle_workshop_camera",
    "mp_x17dlc_int_02_weapon_avenger_camera",
    "mp_x17dlc_int_silo",
    "mp_x17dlc_int_silo_escape",
    "mp_x17dlc_lab",
    "mp_x17dlc_lab_loading_bay",
    "mugShot",
    "mugShot_lineup",
    "multiplayer_ped_fight",
    "nervousRON_fog",
    "new_MP_Garage_L",
    "new_bank",
    "new_stripper_changing",
    "new_tunnels_entrance",
    "nextgen",
    "nightvision",
    "overwater",
    "paleto_nightlight",
    "paleto_opt",
    "phone_cam",
    "phone_cam1",
    "phone_cam10",
    "phone_cam11",
    "phone_cam12",
    "phone_cam13",
    "phone_cam2",
    "phone_cam3",
    "phone_cam3_REMOVED",
    "phone_cam4",
    "phone_cam5",
    "phone_cam6",
    "phone_cam7",
    "phone_cam8",
    "phone_cam8_REMOVED",
    "phone_cam9",
    "plane_inside_mode",
    "player_transition",
    "player_transition_no_scanlines",
    "player_transition_scanlines",
    "plaza_carpark",
    "polluted",
    "poolsidewaterreflection2",
    "powerplant_nightlight",
    "powerstation",
    "prison_nightlight",
    "projector",
    "prologue",
    "prologue_ending_fog",
    "prologue_ext_art_amb",
    "prologue_reflection_opt",
    "prologue_shootout",
    "pulse",
    "ranch",
    "reducelightingcost",
    "reducewaterREF",
    "refit",
    "reflection_correct_ambient",
    "resvoire_reflection",
    "rply_brightness",
    "rply_brightness_neg",
    "rply_contrast",
    "rply_contrast_neg",
    "rply_motionblur",
    "rply_saturation",
    "rply_saturation_neg",
    "rply_vignette",
    "rply_vignette_neg",
    "sandyshore_nightlight",
    "scanline_cam",
    "scanline_cam_cheap",
    "scope_zoom_in",
    "scope_zoom_out",
    "secret_camera",
    "services_nightlight",
    "shades_pink",
    "shades_yellow",
    "ship_explosion_underwater",
    "ship_lighting",
    "sleeping",
    "spectator1",
    "spectator10",
    "spectator2",
    "spectator3",
    "spectator4",
    "spectator5",
    "spectator6",
    "spectator7",
    "spectator8",
    "spectator9",
    "stc_coroners",
    "stc_deviant_bedroom",
    "stc_deviant_lounge",
    "stc_franklinsHouse",
    "stc_trevors",
    "stoned",
    "stoned_aliens",
    "stoned_cutscene",
    "stoned_monkeys",
    "subBASE_water_ref",
    "sunglasses",
    "superDARK",
    "switch_cam_1",
    "switch_cam_2",
    "telescope",
    "torpedo",
    "traffic_skycam",
    "trailer_explosion_optimise",
    "trevorspliff",
    "trevorspliff_blend",
    "trevorspliff_blend02",
    "tunnel_entrance",
    "tunnel_entrance_INT",
    "tunnel_id1_11",
    "ufo",
    "ufo_deathray",
    "underwater",
    "underwater_deep",
    "underwater_deep_clear",
    "v_abattoir",
    "v_bahama",
    "v_cashdepot",
    "v_dark",
    "v_foundry",
    "v_janitor",
    "v_jewel2",
    "v_metro",
    "v_michael",
    "v_michael_lounge",
    "v_recycle",
    "v_rockclub",
    "v_strip3",
    "v_strpchangerm",
    "v_sweat",
    "v_sweat_NoDirLight",
    "v_sweat_entrance",
    "v_torture",
    "vagos_extlight_small",
    "vehicle_subint",
    "venice_canal_tunnel",
    "vespucci_garage",
    "warehouse",
    "whitenightlighting",
    "winning_room",
    "yacht_DLC",
    "yell_tunnel_nodirect"
}