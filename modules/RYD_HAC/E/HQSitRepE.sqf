
RydHQE = GrpNull;

RydHQE = group leaderHQE;

leaderHQE kbAddTopic ["orders","modules\RYD_HAC\topics.bikb",""];
waituntil {(leaderHQE kbHasTopic "orders")};

RydHQE_Cyclecount = 0;

waituntil {not (isNull RydHQE)};

RydHQE_PersDone = false;
[] spawn E_Personality;
waituntil {RydHQE_PersDone};

RydHQE_LHQInit = false;
[] spawn E_LHQ;
waituntil {RydHQE_LHQInit};

if (isNil ("RydHQE_Boxed")) then {RydHQE_Boxed = []};
if (isNil ("RydHQE_AmmoBoxes")) then
	{
	RydHQE_AmmoBoxes = [];

	if not (isNil "RydHQE_AmmoDepot") then
		{
		_rds = (triggerArea RydHQE_AmmoDepot) select 0;
		RydHQE_AmmoBoxes = (getPosATL RydHQE_AmmoDepot) nearObjects ["ReammoBox",_rds]
		}
	};

[] spawn E_HQReset;
[] spawn E_Rev;
[] spawn E_SuppMed;
[] spawn E_SuppFuel;
[] spawn E_SuppAmmo;
[] spawn E_SuppRep;
[] spawn E_SFIdleOrd;
[] spawn E_Reloc;
[] spawn E_LPos;

_specFor = RHQ_SpecFor + ["RUS_Soldier_Sab","RUS_Soldier_GL","RUS_Soldier_Marksman","RUS_Commander","RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_TL"] - RHQs_SpecFor;
_recon = RHQ_Recon + ["FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_SoldierS_Spotter","USMC_SoldierS","MQ9PredatorB","CDF_Soldier_Spotter","RU_Soldier_Spotter","RUS_Soldier3","Pchela1T","GUE_Soldier_Scout"] - RHQs_Recon;
_FO = RHQ_FO + ["USMC_SoldierS_Spotter","CDF_Soldier_Spotter","RU_Soldier_Spotter","Ins_Soldier_CO","GUE_Soldier_Scout"] - RHQs_FO;
_snipers = RHQ_Snipers + ["USMC_SoldierS_Sniper","USMC_SoldierS_SniperH","USMC_SoldierM_Marksman","FR_Marksman","CDF_Soldier_Sniper","CDF_Soldier_Marksman","RU_Soldier_Marksman","RU_Soldier_Sniper","RU_Soldier_SniperH","MVD_Soldier_Marksman","MVD_Soldier_Sniper","RUS_Soldier_Marksman","Ins_Soldier_Sniper","GUE_Soldier_Sniper"] - RHQs_Snipers;
_ATinf = RHQ_ATInf + ["USMC_Soldier_HAT","USMC_Soldier_AT","USMC_Soldier_LAT","HMMWV_TOW","CDF_Soldier_RPG","RU_Soldier_HAT","RU_Soldier_AT","RU_Soldier_LAT","MVD_Soldier_AT","Ins_Soldier_AT","GUE_Soldier_AT"] - RHQs_ATInf;
_AAinf = RHQ_AAInf + ["USMC_Soldier_AA","HMMWV_Avenger","CDF_Soldier_Strela","Ural_ZU23_CDF","RU_Soldier_AA","2S6M_Tunguska","Ins_Soldier_AA","ZSU_INS","Ural_ZU23_INS","GUE_Soldier_AA","Ural_ZU23_Gue"] - RHQs_AAInf;
_Inf = RHQ_Inf + ["GUE_Commander","GUE_Soldier_Scout","GUE_Soldier_Sab","GUE_Soldier_AA","GUE_Soldier_AT","GUE_Soldier_1","GUE_Soldier_2","GUE_Soldier_3","GUE_Soldier_Pilot","GUE_Soldier_Medic","GUE_Soldier_MG","GUE_Soldier_Sniper","GUE_Soldier_GL","GUE_Soldier_Crew","GUE_Soldier_CO","GUE_Soldier_AR","Ins_Woodlander1","Ins_Villager4","Ins_Worker2","Ins_Woodlander2","Ins_Woodlander3","Ins_Villager3","Ins_Soldier_Sniper","Ins_Soldier_Sapper","Ins_Soldier_Sab","Ins_Soldier_2","Ins_Soldier_1","Ins_Soldier_Pilot","Ins_Soldier_CO","Ins_Soldier_Medic","Ins_Soldier_MG","Ins_Bardak","Ins_Soldier_GL","Ins_Soldier_Crew","Ins_Commander","Ins_Lopotev","Ins_Soldier_AR","Ins_Soldier_AT","Ins_Soldier_AA","RUS_Soldier_TL","RUS_Soldier3","RUS_Soldier2","RUS_Soldier1","RUS_Commander","RUS_Soldier_Marksman","RUS_Soldier_GL","RUS_Soldier_Sab","MVD_Soldier_TL","MVD_Soldier_Sniper","MVD_Soldier_AT","MVD_Soldier_GL","MVD_Soldier","MVD_Soldier_Marksman","MVD_Soldier_MG","RU_Soldier_TL","RU_Soldier_SL","RU_Soldier_Spotter","RU_Soldier_SniperH","RU_Soldier_Sniper","RU_Soldier2","RU_Soldier_AT","RU_Soldier_LAT","RU_Soldier","RU_Soldier_Pilot","RU_Soldier_Officer","RU_Soldier_Medic","RU_Soldier_Marksman","RU_Soldier_MG","RU_Soldier_GL","RU_Commander","RU_Soldier_Crew","RU_Soldier_AR","RU_Soldier_HAT","RU_Soldier_AA","CDF_Soldier_TL","CDF_Soldier_Spotter","CDF_Soldier_Light","CDF_Soldier_Sniper","CDF_Soldier","CDF_Soldier_Pilot","CDF_Soldier_Officer","CDF_Soldier_Militia","CDF_Soldier_Medic","CDF_Soldier_Marksman","CDF_Soldier_MG","CDF_Soldier_GL","CDF_Commander","CDF_Soldier_Engineer","CDF_Soldier_Crew","CDF_Soldier_AR","CDF_Soldier_RPG","CDF_Soldier_Strela","FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_Soldier_SL","USMC_SoldierS_Spotter","USMC_SoldierS_SniperH","USMC_SoldierS_Sniper","USMC_SoldierS","USMC_Soldier_LAT","USMC_Soldier2","USMC_Soldier","USMC_Soldier_Pilot","USMC_Soldier_Officer","USMC_Soldier_MG","USMC_Soldier_GL","USMC_Soldier_TL","USMC_SoldierS_Engineer","USMC_SoldierM_Marksman","USMC_Soldier_Crew","USMC_Soldier_Medic","USMC_Soldier_AR","USMC_Soldier_AT","USMC_Soldier_HAT","USMC_Soldier_AA"] - RHQs_Inf;
_Art = RHQ_Art + ["2b14_82mm_GUE","2b14_82mm_INS","GRAD_INS","2b14_82mm","D30_RU","GRAD_RU","2b14_82mm_CDF","D30_CDF","GRAD_CDF","MLRS","M252","M119"] - RHQs_Art;
_HArmor = RHQ_HArmor + ["T72_Gue","T34","T72_INS","T90","T72_RU","T72_CDF","M1A1","M1A2_TUSK_MG"] - RHQs_HArmor;
_MArmor = RHQ_MArmor + ["T34","BMP2_Gue","BMP2_INS","BMP2_CDF","BMP3"] - RHQs_MArmor;
_LArmor = RHQ_LArmor + ["BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","ZSU_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","2S6M_Tunguska","ZSU_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","LAV25_HQ","LAV25","AAV"] - RHQs_LArmor;
_LArmorAT = RHQ_LArmorAT + ["BMP2_Gue","BRDM2_ATGM_INS","BMP2_INS","BTR90","BMP3","BRDM2_ATGM_CDF","BMP2_CDF"] - RHQs_LArmorAT;
_Cars = RHQ_Cars + ["Ural_ZU23_Gue","V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","TT650_Gue","UralRepair_INS","UralRefuel_INS","UralReammo_INS","BMP2_Ambul_INS","Ural_ZU23_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","TT650_Ins","GRAD_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","KamazReammo","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GRAD_RU","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","BMP2_Ambul_CDF","Ural_ZU23_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","GRAD_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance","TowingTractor","MTVR","MMT_USMC","M1030","HMMWV_Avenger","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV"] - RHQs_Cars;
_Air = RHQ_Air + ["Mi17_medevac_Ins","Su25_Ins","Mi17_Ins","Mi17_medevac_RU","Su34","Su39","Pchela1T","Mi17_rockets_RU","Mi24_V","Mi24_P","Ka52Black","Ka52","Mi17_medevac_CDF","Su25_CDF","Mi24_D","Mi17_CDF","MV22","C130J","MQ9PredatorB","AH64D","UH1Y","MH60S","F35B","AV8B","AV8B2","AH1Z","A10"] - RHQs_Air;
_BAir = RHQ_BAir + [] - RHQs_BAir;
_RAir = RHQ_RAir + ["Pchela1T","MQ9PredatorB"] - RHQs_RAir;
_NCAir = RHQ_NCAir + ["Mi17_medevac_Ins","Mi17_medevac_RU","Pchela1T","Mi17_medevac_CDF","MV22","C130J","MQ9PredatorB"] - RHQs_NCAir;
_Naval = RHQ_Naval + ["PBX","RHIB2Turret","RHIB","Zodiac"] - RHQs_Naval;
_Static = RHQ_Static + ["GUE_WarfareBMGNest_PK","ZU23_Gue","SPG9_Gue","2b14_82mm_GUE","DSHKM_Gue","Ins_WarfareBMGNest_PK","ZU23_Ins","SPG9_Ins","2b14_82mm_INS","DSHkM_Mini_TriPod","DSHKM_Ins","D30_Ins","AGS_Ins","RU_WarfareBMGNest_PK","CDF_WarfareBMGNest_PK","USMC_WarfareBMGNest_M240","2b14_82mm","Metis","KORD","KORD_high","D30_RU","AGS_RU","Igla_AA_pod_East","ZU23_CDF","SPG9_CDF","2b14_82mm_CDF","DSHkM_Mini_TriPod_CDF","DSHKM_CDF","D30_CDF","AGS_CDF","TOW_TriPod","MK19_TriPod","M2HD_mini_TriPod","M252","M2StaticMG","M119","Stinger_Pod","Fort_Nest_M240"] - RHQs_Static;
_StaticAA = RHQ_StaticAA + ["ZU23_Gue","ZU23_Ins","Igla_AA_pod_East","ZU23_CDF","Stinger_Pod"] - RHQs_StaticAA;
_StaticAT = RHQ_StaticAT + ["SPG9_Gue","SPG9_Ins","Metis","SPG9_CDF","TOW_TriPod"] - RHQs_StaticAT;
_Support = RHQ_Support + ["UralRepair_INS","UralRefuel_INS","UralReammo_INS","Mi17_medevac_Ins","BMP2_Ambul_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","Mi17_medevac_RU","KamazReammo","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","Mi17_medevac_CDF","BMP2_Ambul_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance","MH60S"] - RHQs_Support;
_Cargo = RHQ_Cargo + ["V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","Mi17_Ins","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","Mi17_rockets_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","Mi17_CDF","HMMWV_Ambulance","RHIB2Turret","RHIB","Zodiac","MTVR","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV","LAV25_HQ","LAV25","AAV","UH1Y","MH60S","MV22","C130J"] - RHQs_Cargo;
_NCCargo = RHQ_NCCargo + ["V3S_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_INS","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_CDF","HMMWV_Ambulance","Zodiac","MTVR","HMMWV","MV22","C130J"] - RHQs_NCCargo;
_Crew = RHQ_Crew + ["GUE_Soldier_Pilot","INS_Soldier_Pilot","RU_Soldier_Pilot","CDF_Soldier_Pilot","USMC_Soldier_Pilot","GUE_Soldier_Crew","INS_Soldier_Crew","RU_Soldier_Crew","CDF_Soldier_Crew","USMC_Soldier_Crew"] - RHQs_Crew;
_Other = RHQ_Other + [];
_NCrewInf = _Inf - _Crew;
_Cargo = _Cargo - (_Support - ["MH60S"]);
RydHQE_NCVeh = _NCCargo + (_Support - ["MH60S"]);

[(_snipers + _ATinf + _AAinf)] spawn E_Garrison;

RydHQE_ReconDone = false;
RydHQE_DefDone = false;
RydHQE_ReconStage = 1;
RydHQE_KnEnPos = [];
RydHQE_AirInDef = [];
if (isNil ("RydHQE_Excluded")) then {RydHQE_Excluded = []};
if (isNil ("RydHQE_Fast")) then {RydHQE_Fast = false};
if (isNil ("RydHQE_ExInfo")) then {RydHQE_ExInfo = false};
if (isNil ("RydHQE_ObjHoldTime")) then {RydHQE_ObjHoldTime = 600};
if (isNil "RydHQE_NObj") then {RydHQE_NObj = 1};

RydHQE_Init = true;

RydHQE_Inertia = 0;
RydHQE_Morale = 0;
RydHQE_CInitial = 0;
RydHQE_CLast = 0;
RydHQE_CCurrent = 0;
RydHQE_CIMoraleC = 0;
RydHQE_CLMoraleC = 0;
RydHQE_Surrender = false;

RydHQE_FirstEMark = true;
RydHQE_LastE = 0;
RydHQE_FlankingInit = false;
RydHQE_FlankingDone = false;
RydHQE_Progress = 0;

RydHQE_AAthreat = [];
RydHQE_ATthreat = [];
RydHQE_Airthreat = [];
RydHQE_Exhausted = [];

_lastHQ = leaderHQE;
_OLmpl = 0;
_cycleCap = 0;
_firstMC = 0;
_wp = [];

while {not ((isNull RydHQE) or (RydHQE_Surrender))} do
	{
	if not (RydHQE_Fast) then {waituntil {sleep 0.1;((RydxHQ_Done) and (RydxHQB_Done) and (RydxHQC_Done) and (RydxHQD_Done) and (RydxHQE_Done) and (RydxHQF_Done) and (RydxHQG_Done) and (RydxHQH_Done))}};
	if (isNil ("RydHQE_SupportWP")) then {RydHQE_SupportWP = false};

	if (RydHQE_Cyclecount > 1) then
		{
		if not (_lastHQ == leaderHQE) then {sleep (60 + (random 60))};
		};

	_lastHQ = leaderHQE;
	RydHQE_Cyclecount = RydHQE_Cyclecount + 1;
	RydxHQ_Done = false;

	RydHQE_SpecFor = [];
	RydHQE_recon = [];
	RydHQE_FO = [];
	RydHQE_snipers = [];
	RydHQE_ATinf = [];
	RydHQE_AAinf = [];
	RydHQE_Inf = [];
	RydHQE_Art = [];
	RydHQE_HArmor = [];
	RydHQE_MArmor = [];
	RydHQE_LArmor = [];
	RydHQE_LArmorAT = [];
	RydHQE_Cars = [];
	RydHQE_Air = [];
	RydHQE_BAir = [];
	RydHQE_RAir = [];
	RydHQE_NCAir = [];
	RydHQE_Naval = [];
	RydHQE_Static = [];
	RydHQE_StaticAA = [];
	RydHQE_StaticAT = [];
	RydHQE_Support = [];
	RydHQE_Cargo = [];
	RydHQE_NCCargo = [];
	RydHQE_Other = [];
	RydHQE_Crew = [];
	RydHQE_NCrewInf = [];

	RydHQE_SpecForG = [];
	RydHQE_reconG = [];
	RydHQE_FOG = [];
	RydHQE_snipersG = [];
	RydHQE_ATinfG = [];
	RydHQE_AAinfG = [];
	RydHQE_InfG = [];
	RydHQE_ArtG = [];
	RydHQE_HArmorG = [];
	RydHQE_MArmorG = [];
	RydHQE_LArmorG = [];
	RydHQE_LArmorATG = [];
	RydHQE_CarsG = [];
	RydHQE_AirG = [];
	RydHQE_BAirG = [];
	RydHQE_RAirG = [];
	RydHQE_NCAirG = [];
	RydHQE_NavalG = [];
	RydHQE_StaticG = [];
	RydHQE_StaticAAG = [];
	RydHQE_StaticATG = [];
	RydHQE_SupportG = [];
	RydHQE_CargoG = [];
	RydHQE_NCCargoG = [];
	RydHQE_OtherG = [];
	RydHQE_CrewG = [];
	RydHQE_NCrewInfG = [];

	RydHQE_EnSpecFor = [];
	RydHQE_Enrecon = [];
	RydHQE_EnFO = [];
	RydHQE_Ensnipers = [];
	RydHQE_EnATinf = [];
	RydHQE_EnAAinf = [];
	RydHQE_EnInf = [];
	RydHQE_EnArt = [];
	RydHQE_EnHArmor = [];
	RydHQE_EnMArmor = [];
	RydHQE_EnLArmor = [];
	RydHQE_EnLArmorAT = [];
	RydHQE_EnCars = [];
	RydHQE_EnAir = [];
	RydHQE_EnBAir = [];
	RydHQE_EnRAir = [];
	RydHQE_EnNCAir = [];
	RydHQE_EnNaval = [];
	RydHQE_EnStatic = [];
	RydHQE_EnStaticAA = [];
	RydHQE_EnStaticAT = [];
	RydHQE_EnSupport = [];
	RydHQE_EnCargo = [];
	RydHQE_EnNCCargo = [];
	RydHQE_EnOther = [];
	RydHQE_EnCrew = [];
	RydHQE_EnNCrewInf = [];

	RydHQE_EnSpecForG = [];
	RydHQE_EnreconG = [];
	RydHQE_EnFOG = [];
	RydHQE_EnsnipersG = [];
	RydHQE_EnATinfG = [];
	RydHQE_EnAAinfG = [];
	RydHQE_EnInfG = [];
	RydHQE_EnArtG = [];
	RydHQE_EnHArmorG = [];
	RydHQE_EnMArmorG = [];
	RydHQE_EnLArmorG = [];
	RydHQE_EnLArmorATG = [];
	RydHQE_EnCarsG = [];
	RydHQE_EnAirG = [];
	RydHQE_EnBAirG = [];
	RydHQE_EnRAirG = [];
	RydHQE_EnNCAirG = [];
	RydHQE_EnNavalG = [];
	RydHQE_EnStaticG = [];
	RydHQE_EnStaticAAG = [];
	RydHQE_EnStaticATG = [];
	RydHQE_EnSupportG = [];
	RydHQE_EnCargoG = [];
	RydHQE_EnNCCargoG = [];
	RydHQE_EnOtherG = [];
	RydHQE_EnCrewG = [];
	RydHQE_EnNCrewInfG = [];

	RydHQE_LastE = count RydHQE_KnEnemies;
	RydHQE_LastFriends = RydHQE_Friends;

	if (isNil ("RydHQE_NoAirCargo")) then {RydHQE_NoAirCargo = false};
	if (isNil ("RydHQE_NoLandCargo")) then {RydHQE_NoLandCargo = false};
	if (isNil ("RydHQE_LastFriends")) then {RydHQE_LastFriends = []};
	if (isNil ("RydHQE_CargoFind")) then {RydHQE_CargoFind = 0};
	if (isNil ("RydHQE_Subordinated")) then {RydHQE_Subordinated = []};
	if (isNil ("RydHQE_Included")) then {RydHQE_Included = []};
	if (isNil ("RydHQE_ExcludedG")) then {RydHQE_ExcludedG = []};
	if (isNil ("RydHQE_SubAll")) then {RydHQE_SubAll = true};
	if (isNil ("RydHQE_SubSynchro")) then {RydHQE_SubSynchro = false};
	if (isNil ("RydHQE_SubNamed")) then {RydHQE_SubNamed = false};
	if (isNil ("RydHQE_SubZero")) then {RydHQE_SubZero = false};
	if (isNil ("RydHQE_ReSynchro")) then {RydHQE_ReSynchro = true};
	if (isNil ("RydHQE_NameLimit")) then {RydHQE_NameLimit = 100};
	if (isNil ("RydHQE_Surr")) then {RydHQE_Surr = false};
	if (isNil ("RydHQE_AOnly")) then {RydHQE_AOnly = []};
	if (isNil ("RydHQE_ROnly")) then {RydHQE_ROnly = []};
	if (isNil ("RydHQE_CargoOnly")) then {RydHQE_CargoOnly = []};
	if (isNil ("RydHQE_NoCargo")) then {RydHQE_NoCargo = []};
	if (isNil ("RydHQE_NoFlank")) then {RydHQE_NoFlank = []};
	if (isNil ("RydHQE_NoDef")) then {RydHQE_NoDef = []};
	if (isNil ("RydHQE_FirstToFight")) then {RydHQE_FirstToFight = []};
	if (isNil ("RydHQE_VoiceComm")) then {RydHQE_VoiceComm = true};
	if (isNil ("RydHQE_Front")) then {RydHQE_Front = false};
	if (isNil ("RydHQE_LRelocating")) then {RydHQE_LRelocating = false};
	if (isNil ("RydHQE_Flee")) then {RydHQE_Flee = true};
	if (isNil ("RydHQE_GarrR")) then {RydHQE_GarrR = 500};
	if (isNil ("RydHQE_Rush")) then {RydHQE_Rush = false};
	if (isNil ("RydHQE_GarrVehAb")) then {RydHQE_GarrVehAb = false};
	if (isNil ("RydHQE_DefendObjectives")) then {RydHQE_DefendObjectives = 4};
	if (isNil ("RydHQE_DefSpot")) then {RydHQE_DefSpot = []};
	if (isNil ("RydHQE_RecDefSpot")) then {RydHQE_RecDefSpot = []};
	if (isNil "RydHQE_Flare") then {RydHQE_Flare = true};
	if (isNil "RydHQE_Smoke") then {RydHQE_Smoke = true};
	if (isNil "RydHQE_NoRec") then {RydHQE_NoRec = 1};
	if (isNil "RydHQE_RapidCapt") then {RydHQE_RapidCapt = 10};
	if (isNil "RydHQE_Muu") then {RydHQE_Muu = 1};
	if (isNil "RydHQE_ArtyShells") then {RydHQE_ArtyShells = 120};
	if (isNil "RydHQE_Withdraw") then {RydHQE_Withdraw = 1};
	if (isNil "RydHQE_Berserk") then {RydHQE_Berserk = false};
	if (isNil "RydHQE_IDChance") then {RydHQE_IDChance = 100};
	if (isNil "RydHQE_RDChance") then {RydHQE_RDChance = 100};
	if (isNil "RydHQE_SDChance") then {RydHQE_SDChance = 100};
	if (isNil "RydHQE_AmmoDrop") then {RydHQE_AmmoDrop = []};
	if (isNil "RydHQE_SFTargets") then {RydHQE_SFTargets = []};
	if (isNil "RydHQE_LZ") then {RydHQE_LZ = false};
	if (isNil "RydHQE_SFBodyGuard") then {RydHQE_SFBodyGuard = []};
	if (isNil "RydHQE_DynForm") then {RydHQE_DynForm = false};
	if (isNil "RydHQE_UnlimitedCapt") then {RydHQE_UnlimitedCapt = false};
	if (isNil "RydHQE_CaptLimit") then {RydHQE_CaptLimit = 10};
	if (isNil "RydHQE_GetHQInside") then {RydHQE_GetHQInside = false};

	RydHQE_Friends = [];
	RydHQE_Enemies = [];
	RydHQE_KnEnemies = [];
	RydHQE_KnEnemiesG = [];
	RydHQE_FValue = 0;
	RydHQE_EValue = 0;

	if (RydxHQ_AIChatDensity > 0) then
		{
		_varName1 = "HAC_AIChatRep";
		_varName2 = "_West";

		switch ((side RydHQE)) do
			{
			case (east) : {_varName2 = "_East"};
			case (resistance) : {_varName2 = "_Guer"};
			};

		missionNamespace setVariable [_varName1 + _varName2,0];

		_varName1 = "HAC_AIChatLT";

		missionNamespace setVariable [_varName1 + _varName2,[0,""]]
		};

	if (RydHQE_NObj == 1) then {RydHQE_Obj = RydHQE_Obj1};
	if (RydHQE_NObj == 2) then {RydHQE_Obj = RydHQE_Obj2};
	if (RydHQE_NObj == 3) then {RydHQE_Obj = RydHQE_Obj3};
	if (RydHQE_NObj >= 4) then {RydHQE_Obj = RydHQE_Obj4};

	RydHQE_LastSub = RydHQE_Subordinated;
	RydHQE_Subordinated = [];

	_civF = ["CIV","CIV_RU","BIS_TK_CIV","BIS_CIV_special"];
	if not (isNil ("RydHQE_CivF")) then {_civF = RydHQE_CivF};

		{
		_isCaptive = _x getVariable ("isCaptive" + (str _x));
		if (isNil "_isCaptive") then {_isCaptive = false};

		_isCiv = false;
		if ((faction (leader _x)) in _civF) then {_isCiv = true};
		if not ((isNull (leaderHQE)) and not (isNull _x) and (alive (leaderHQE)) and (alive (leader _x)) and not (_isCaptive)) then
			{
			if (not (RydHQE_Front) and ((side _x) getFriend (side RydHQE) < 0.6) and not (_isCiv)) then {if not (_x in RydHQE_Enemies) then {RydHQE_Enemies set [(count RydHQE_Enemies), _x]}};
			_front = true;
			if not (isNil "FrontE") then {_front = ((getPosATL (vehicle (leader _x))) in FrontE)};
			if ((RydHQE_Front) and ((side _x) getFriend (side RydHQE) < 0.6) and (_front) and not (_isCiv)) then {if not (_x in RydHQE_Enemies) then {RydHQE_Enemies set [(count RydHQE_Enemies), _x]}};
			if (RydHQE_SubAll) then
				{
				if not ((side _x) getFriend (side RydHQE) < 0.6) then
					{
					if (not (_x in RydHQE_Friends) and not (((leader _x) in RydHQE_Excluded) or (_isCiv))) then {RydHQE_Friends set [(count RydHQE_Friends), _x]}
					};
				};
			}
		}
	foreach allGroups;

	RydHQE_Excl = [];

		{
		if not ((group _x) in RydHQE_Excl) then {RydHQE_Excl set [(count RydHQE_Excl),group _x]}
		}
	foreach RydHQE_Excluded;

	if (RydHQE_SubSynchro) then
		{
			{
			if ((_x in RydHQE_LastSub) and not ((leader _x) in (synchronizedObjects leaderHQE)) and (RydHQE_ReSynchro)) then {RydHQE_Subordinated set [(count RydHQE_Subordinated),_x]};
			if (not (_x in RydHQE_Subordinated) and ((leader _x) in (synchronizedObjects leaderHQE))) then {RydHQE_Subordinated set [(count RydHQE_Subordinated),_x]};
			}
		foreach allGroups;
		};

	if (RydHQE_SubNamed) then
		{
			{
			for [{_i = 1},{_i <= RydHQE_NameLimit},{_i = _i + 1}] do
				{
				if (not (_x in RydHQE_Subordinated) and ((str (leader _x)) == ("RydE" + str (_i)))) then {RydHQE_Subordinated set [(count RydHQE_Subordinated),_x]};
				};
			}
		foreach allGroups;
		};

	if (RydHQE_SubZero) then
		{
			{
			if (((random 100) >= 50) and not (_x in RydHQE_Subordinated)) then {RydHQE_Subordinated set [(count RydHQE_Subordinated),_x]} else {if (not (_x in RydHQEB_Subordinated)) then {RydHQEB_Subordinated set [(count RydHQEB_Subordinated),_x]}};
			}
		foreach allGroups;
		};

	RydHQE_Friends = RydHQE_Friends + RydHQE_Subordinated + RydHQE_Included - (RydHQE_ExcludedG + RydHQE_Excl);
	RydHQE_Friends = RydHQE_Friends - [RydHQE];
	RydHQE_NoWayD = allGroups - RydHQE_LastFriends;

	RydHQE_Friends = [RydHQE_Friends] call RYD_RandomOrd;

		{
		[_x] call RYD_WPdel;
		}
	foreach ((RydHQE_Excl + RydHQE_ExcludedG) - RydHQE_NoWayD);

	if (RydHQE_Init) then
		{
			{
			RydHQE_CInitial = RydHQE_CInitial + (count (units _x))
			}
		foreach RydHQE_Friends + [RydHQE]
		};

	RydHQE_CLast = RydHQE_CCurrent;
	RydHQE_CCurrent = 0;
		{
		RydHQE_CCurrent = RydHQE_CCurrent + (count (units _x))
		}
	foreach RydHQE_Friends + [RydHQE];

	RydHQE_Ex = [];

	if (RydHQE_ExInfo) then
		{
		RydHQE_Ex = RydHQE_Excl + RydHQE_ExcludedG
		};

		{
		for [{_a = 0},{_a < count (units _x)},{_a = _a + 1}] do
			{
			_enemyU = vehicle ((units _x) select _a);
				{
				if ((_x knowsAbout _enemyU) >= 0.05) exitwith
					{
					if not (_enemyU in RydHQE_KnEnemies) then
						{
						RydHQE_KnEnemies set [(count RydHQE_KnEnemies),_enemyU];
						};

					if not ((group _enemyU) in RydHQE_KnEnemiesG) then
						{
						_already = missionnameSpace getVariable ["AlreadySpotted",[]];
						RydHQE_KnEnemiesG set [(count RydHQE_KnEnemiesG),(group _enemyU)];
						if not ((group _enemyU) in _already) then
							{
							_UL = (leader _x);if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_EnemySpot,"EnemySpot"] call RYD_AIChatter}};
							}
						}
					}
				}
			foreach (RydHQE_Friends + [RydHQE] + RydHQE_Ex)
			}
		}
	foreach RydHQE_Enemies;

	_already = missionnameSpace getVariable ["AlreadySpotted",[]];

		{
		if not (_x in _already) then
			{
			_already set [(count _already),_x]
			}
		}
	foreach RydHQE_KnEnemiesG;

	missionnameSpace setVariable ["AlreadySpotted",_already];

	_lossFinal = RydHQE_CInitial - RydHQE_CCurrent;
	if (_lossFinal < 0) then {_lossFinal = 0;RydHQE_CInitial = RydHQE_CCurrent};

	if not (RydHQE_Init) then
		{
		_lossP = _lossFinal/RydHQE_CInitial;

		if ((_OLmpl == 0) and ((count RydHQE_KnEnemies) > 0)) then
			{
			_OLmpl = 0.01;
			_firstMC = RydHQE_Cyclecount - 1
			};

		if ((_cycleCap < (50 / (1.01 - _lossP))) and ((count RydHQE_KnEnemies) == 0) and (_OLmpl == 0.01)) then
			{
			_cycleCap = _cycleCap + 1;
			if ((random 1) < _lossP) then {_firstMC = _firstMC + 1}
			}
		else
			{
			if not ((count RydHQE_KnEnemies) == 0) then
				{
				_cycleCap = 0;
				}
			};


		_lossPerc = _lossP * 100;
		_cycle = RydHQE_Cyclecount - _firstMC;

		_OLF = _OLmpl * (((-(_lossPerc * _lossPerc))/(1.1^_cycle)) + ((15 + (random 5) + (random 5))/(1 + _lossP)) - (_lossP * 10) + (_cycle ^ ((10 * (1 - _lossP))/_cycle)));

		_mplLU = 1;
		_lostU = RydHQE_CLast - RydHQE_CCurrent;
		if (_lostU < 0) then {_lostU = - _lostU;_mplLU = -1};

		_lossL = _mplLU * ((100 * _lostU/RydHQE_CInitial)^(1.55 + (random 0.05) + (random 0.05)))/10;

		_balanceF = 0.5 + (random 0.5) + (random 0.5) - _lossP - (count RydHQE_KnEnemies)/RydHQE_CCurrent;

		RydHQE_Morale = RydHQE_Morale + (_OLF - _lossL + _balanceF);
		//RydHQE_Morale = RydHQE_Morale + (((RydHQE_CCurrent - RydHQE_CInitial) * (6/(1 + (RydHQE_Cyclecount/25)))) + (6 * ((random 0.5) + RydHQE_CCurrent - RydHQE_CLast)))/((1 + (10*RydHQE_CInitial))/(1 + ((count RydHQE_KnEnemies) * 0.5)));
		//diag_log format ["Init: %2, Last: %3, Current: %3,Zmiana morale: %1",(((RydHQE_CCurrent - RydHQE_CInitial) * (6/(1 + (RydHQE_Cyclecount/25)))) + (6 * ((random 0.5) + RydHQE_CCurrent - RydHQE_CLast)))/((1 + (10*RydHQE_CInitial))/(1 + ((count RydHQE_KnEnemies) * 0.5))),RydHQE_CInitial,RydHQE_CLast,RydHQE_CCurrent];
		};

	if (RydHQE_Morale < -50) then {RydHQE_Morale = -50};
	if (RydHQE_Morale > 0) then {RydHQE_Morale = 0};
	if (RydHQE_Debug) then
		{
		_mdbg = format ["Morale E (%2): %1 - losses: %3 percent (%4)",RydHQE_Morale,RydHQE_Personality,(round (((_lossFinal/RydHQE_CInitial) * 100) * 10)/10),_lossFinal];
		diag_log _mdbg;
		leaderHQE globalChat _mdbg;

		_cl = "<t color='#007f00'>E -> M: %1 - L: %2%3</t>";

		switch (side RydHQE) do
			{
			case (west) : {_cl = "<t color='#0d81c4'>E -> M: %1 - L: %2%3</t>"};
			case (east) : {_cl = "<t color='#ff0000'>E -> M: %1 - L: %2%3</t>"};
			};

		_dbgMon = parseText format [_cl,(round (RydHQE_Morale * 10))/10,(round (((_lossFinal/RydHQE_CInitial) * 100) * 10)/10),"%"];

		RydHQE setVariable ["DbgMon",_dbgMon];
		};

	if (RydHQE_Init) then {[RydHQE] spawn Desperado};

	RydHQE_Init = false;

		{
			{
			_SpecForcheck = false;
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_MArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_BAircheck = false;
			_RAircheck = false;
			_NCAircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			_Crewcheck = false;
			_NCrewInfcheck = false;

			_tp = typeOf _x;
			_grp = group _x;
			_vh = vehicle _x;
			_asV = assignedvehicle _x;
			_grpD = group (assignedDriver _asV);
			_grpG = group (assignedGunner _asV);
			if (isNull _grpD) then {_grpD = _grpG};
			_Tvh = typeOf _vh;
			_TasV = typeOf _asV;

				if (((_grp == _grpD) and (_TasV in _specFor)) or (_tp in _specFor)) then {_SpecForcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _recon)) or (_tp in _recon)) then {_reconcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _FO)) or (_tp in _FO)) then {_FOcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _snipers)) or (_tp in _snipers)) then {_sniperscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _ATinf)) or (_tp in _ATinf)) then {_ATinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _AAinf)) or (_tp in _AAinf)) then {_AAinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Inf)) or (_tp in _Inf)) then {_Infcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Art)) or (_tp in _Art)) then {_Artcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _HArmor)) or (_tp in _HArmor)) then {_HArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _MArmor)) or (_tp in _MArmor)) then {_MArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmor)) or (_tp in _LArmor)) then {_LArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmorAT)) or (_tp in _LArmorAT)) then {_LArmorATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cars)) or (_tp in _Cars)) then {_Carscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Air)) or (_tp in _Air)) then {_Aircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _BAir)) or (_tp in _BAir)) then {_BAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _RAir)) or (_tp in _RAir)) then {_RAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCAir)) or (_tp in _NCAir)) then {_NCAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Naval)) or (_tp in _Naval)) then {_Navalcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _Static)) or (_tp in _Static)) then {_Staticcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAA)) or (_tp in _StaticAA)) then {_StaticAAcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAT)) or (_tp in _StaticAT)) then {_StaticATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cargo)) or (_tp in _Cargo)) then {_Cargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCCargo)) or (_tp in _NCCargo)) then {_NCCargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Crew)) or (_tp in _Crew)) then {_Crewcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCrewInf)) or (_tp in _NCrewInf)) then {_NCrewInfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Support)) or (_tp in _Support)) then {_Supportcheck = true;_NCrewInfcheck = false;_Othercheck = false};

				if ((_TasV in _NCCargo) and (_x == (assignedDriver _asV)) and ((count (units (group _x))) == 1) and not ((_ATinfcheck) or (_AAinfcheck) or (_reconcheck) or (_FOcheck) or (_sniperscheck))) then {_NCrewInfcheck = false;_Othercheck = false};

				if (_SpecForcheck) then {if not (_vh in RydHQE_SpecFor) then {RydHQE_SpecFor set [(count RydHQE_SpecFor),_vh]};if not (_grp in RydHQE_SpecForG) then {RydHQE_SpecForG set [(count RydHQE_SpecForG),_grp]}};
				if (_reconcheck) then {if not (_vh in RydHQE_recon) then {RydHQE_recon set [(count RydHQE_recon),_vh]};if not (_grp in RydHQE_reconG) then {RydHQE_reconG set [(count RydHQE_reconG),_grp]}};
				if (_FOcheck) then {if not (_vh in RydHQE_FO) then {RydHQE_FO set [(count RydHQE_FO),_vh]};if not (_grp in RydHQE_FOG) then {RydHQE_FOG set [(count RydHQE_FOG),_grp]}};
				if (_sniperscheck) then {if not (_vh in RydHQE_snipers) then {RydHQE_snipers set [(count RydHQE_snipers),_vh]};if not (_grp in RydHQE_snipersG) then {RydHQE_snipersG set [(count RydHQE_snipersG),_grp]}};
				if (_ATinfcheck) then {if not (_vh in RydHQE_ATinf) then {RydHQE_ATinf set [(count RydHQE_ATinf),_vh]};if not (_grp in RydHQE_ATinfG) then {RydHQE_ATinfG set [(count RydHQE_ATinfG),_grp]}};
				if (_AAinfcheck) then {if not (_vh in RydHQE_AAinf) then {RydHQE_AAinf set [(count RydHQE_AAinf),_vh]};if not (_grp in RydHQE_AAinfG) then {RydHQE_AAinfG set [(count RydHQE_AAinfG),_grp]}};
				if (_Infcheck) then {if not (_vh in RydHQE_Inf) then {RydHQE_FValue = RydHQE_FValue + 1;RydHQE_Inf set [(count RydHQE_Inf),_vh]};if not (_grp in RydHQE_InfG) then {RydHQE_InfG set [(count RydHQE_InfG),_grp]}};
				if (_Artcheck) then {if not (_vh in RydHQE_Art) then {RydHQE_FValue = RydHQE_FValue + 3;RydHQE_Art set [(count RydHQE_Art),_vh]};if not (_grp in RydHQE_ArtG) then {RydHQE_ArtG set [(count RydHQE_ArtG),_grp]}};
				if (_HArmorcheck) then {if not (_vh in RydHQE_HArmor) then {RydHQE_FValue = RydHQE_FValue + 10;RydHQE_HArmor set [(count RydHQE_HArmor),_vh]};if not (_grp in RydHQE_HArmorG) then {RydHQE_HArmorG set [(count RydHQE_HArmorG),_grp]}};
				if (_MArmorcheck) then {if not (_vh in RydHQE_MArmor) then {RydHQE_MArmor set [(count RydHQE_MArmor),_vh]};if not (_grp in RydHQE_MArmorG) then {RydHQE_MArmorG set [(count RydHQE_MArmorG),_grp]}};
				if (_LArmorcheck) then {if not (_vh in RydHQE_LArmor) then {RydHQE_FValue = RydHQE_FValue + 5;RydHQE_LArmor set [(count RydHQE_LArmor),_vh]};if not (_grp in RydHQE_LArmorG) then {RydHQE_LArmorG set [(count RydHQE_LArmorG),_grp]}};
				if (_LArmorATcheck) then {if not (_vh in RydHQE_LArmorAT) then {RydHQE_LArmorAT set [(count RydHQE_LArmorAT),_vh]};if not (_grp in RydHQE_LArmorATG) then {RydHQE_LArmorATG set [(count RydHQE_LArmorATG),_grp]}};
				if (_Carscheck) then {if not (_vh in RydHQE_Cars) then {RydHQE_FValue = RydHQE_FValue + 3;RydHQE_Cars set [(count RydHQE_Cars),_vh]};if not (_grp in RydHQE_CarsG) then {RydHQE_CarsG set [(count RydHQE_CarsG),_grp]}};
				if (_Aircheck) then {if not (_vh in RydHQE_Air) then {RydHQE_FValue = RydHQE_FValue + 15;RydHQE_Air set [(count RydHQE_Air),_vh]};if not (_grp in RydHQE_AirG) then {RydHQE_AirG set [(count RydHQE_AirG),_grp]}};
				if (_BAircheck) then {if not (_vh in RydHQE_BAir) then {RydHQE_BAir set [(count RydHQE_BAir),_vh]};if not (_grp in RydHQE_BAirG) then {RydHQE_BAirG set [(count RydHQE_BAirG),_grp]}};
				if (_RAircheck) then {if not (_vh in RydHQE_RAir) then {RydHQE_RAir set [(count RydHQE_RAir),_vh]};if not (_grp in RydHQE_RAirG) then {RydHQE_RAirG set [(count RydHQE_RAirG),_grp]}};
				if (_NCAircheck) then {if not (_vh in RydHQE_NCAir) then {RydHQE_NCAir set [(count RydHQE_NCAir),_vh]};if not (_grp in RydHQE_NCAirG) then {RydHQE_NCAirG set [(count RydHQE_NCAirG),_grp]}};
				if (_Navalcheck) then {if not (_vh in RydHQE_Naval) then {RydHQE_Naval set [(count RydHQE_Naval),_vh]};if not (_grp in RydHQE_NavalG) then {RydHQE_NavalG set [(count RydHQE_NavalG),_grp]}};
				if (_Staticcheck) then {if not (_vh in RydHQE_Static) then {RydHQE_FValue = RydHQE_FValue + 1;RydHQE_Static set [(count RydHQE_Static),_vh]};if not (_grp in RydHQE_StaticG) then {RydHQE_StaticG set [(count RydHQE_StaticG),_grp]}};
				if (_StaticAAcheck) then {if not (_vh in RydHQE_StaticAA) then {RydHQE_StaticAA set [(count RydHQE_StaticAA),_vh]};if not (_grp in RydHQE_StaticAAG) then {RydHQE_StaticAAG set [(count RydHQE_StaticAAG),_grp]}};
				if (_StaticATcheck) then {if not (_vh in RydHQE_StaticAT) then {RydHQE_StaticAT set [(count RydHQE_StaticAT),_vh]};if not (_grp in RydHQE_StaticATG) then {RydHQE_StaticATG set [(count RydHQE_StaticATG),_grp]}};
				if (_Supportcheck) then {if not (_vh in RydHQE_Support) then {RydHQE_Support set [(count RydHQE_Support),_vh]};if not (_grp in RydHQE_SupportG) then {RydHQE_SupportG set [(count RydHQE_SupportG),_grp]}};
				if (_Cargocheck) then {if not (_vh in RydHQE_Cargo) then {RydHQE_Cargo set [(count RydHQE_Cargo),_vh]};if not (_grp in RydHQE_CargoG) then {RydHQE_CargoG set [(count RydHQE_CargoG),_grp]}};
				if (_NCCargocheck) then {if not (_vh in RydHQE_NCCargo) then {RydHQE_NCCargo set [(count RydHQE_NCCargo),_vh]};if not (_grp in RydHQE_NCCargoG) then {RydHQE_NCCargoG set [(count RydHQE_NCCargoG),_grp]}};
				if (_Crewcheck) then {if not (_vh in RydHQE_Crew) then {RydHQE_Crew set [(count RydHQE_Crew),_vh]};if not (_grp in RydHQE_CrewG) then {RydHQE_CrewG set [(count RydHQE_CrewG),_grp]}};
				if (_NCrewInfcheck) then {if not (_vh in RydHQE_NCrewInf) then {RydHQE_NCrewInf set [(count RydHQE_NCrewInf),_vh]};if not (_grp in RydHQE_NCrewInfG) then {RydHQE_NCrewInfG set [(count RydHQE_NCrewInfG),_grp]}};

			}
		foreach (units _x)
		}
	foreach RydHQE_Friends;

	RydHQE_NCrewInfG = RydHQE_NCrewInfG - (RydHQE_RAirG + RydHQE_StaticG);
	RydHQE_NCrewInf = RydHQE_NCrewInf - (RydHQE_RAir + RydHQE_Static);
	RydHQE_InfG = RydHQE_InfG - (RydHQE_RAirG + RydHQE_StaticG);
	RydHQE_Inf = RydHQE_Inf - (RydHQE_RAir + RydHQE_Static);

	RydHQE_CargoAirEx = [];
	RydHQE_CargoLandEx = [];
	if (RydHQE_NoAirCargo) then {RydHQE_CargoAirEx = RydHQE_AirG};
	if (RydHQE_NoLandCargo) then {RydHQE_CargoLandEx = (RydHQE_CargoG - RydHQE_AirG)};
	RydHQE_CargoG = RydHQE_CargoG - (RydHQE_CargoAirEx + RydHQE_CargoLandEx + RydHQE_AmmoDrop);

		{
		if not (_x in RydHQE_SupportG) then
			{
			RydHQE_SupportG set [(count RydHQE_SupportG),_x]
			}
		}
	foreach RydHQE_AmmoDrop;

		{
			{
			_SpecForcheck = false;
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_MArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_BAircheck = false;
			_RAircheck = false;
			_NCAircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			_Crewcheck = false;
			_NCrewInfcheck = false;

			_tp = typeOf _x;
			_grp = group _x;
			_vh = vehicle _x;
			_asV = assignedvehicle _x;
			_grpD = group (assignedDriver _asV);
			_grpG = group (assignedGunner _asV);
			if (isNull _grpD) then {_grpD = _grpG};
			_Tvh = typeOf _vh;
			_TasV = typeOf _asV;

				if (((_grp == _grpD) and (_TasV in _specFor)) or (_tp in _specFor)) then {_SpecForcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _recon)) or (_tp in _recon)) then {_reconcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _FO)) or (_tp in _FO)) then {_FOcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _snipers)) or (_tp in _snipers)) then {_sniperscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _ATinf)) or (_tp in _ATinf)) then {_ATinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _AAinf)) or (_tp in _AAinf)) then {_AAinfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Inf)) or (_tp in _Inf)) then {_Infcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Art)) or (_tp in _Art)) then {_Artcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _HArmor)) or (_tp in _HArmor)) then {_HArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _MArmor)) or (_tp in _MArmor)) then {_MArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmor)) or (_tp in _LArmor)) then {_LArmorcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _LArmorAT)) or (_tp in _LArmorAT)) then {_LArmorATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cars)) or (_tp in _Cars)) then {_Carscheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Air)) or (_tp in _Air)) then {_Aircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _BAir)) or (_tp in _BAir)) then {_BAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _RAir)) or (_tp in _RAir)) then {_RAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCAir)) or (_tp in _NCAir)) then {_NCAircheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Naval)) or (_tp in _Naval)) then {_Navalcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _Static)) or (_tp in _Static)) then {_Staticcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAA)) or (_tp in _StaticAA)) then {_StaticAAcheck = true;_Othercheck = false};
				if (((_grp == _grpG) and (_TasV in _StaticAT)) or (_tp in _StaticAT)) then {_StaticATcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Cargo)) or (_tp in _Cargo)) then {_Cargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCCargo)) or (_tp in _NCCargo)) then {_NCCargocheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Crew)) or (_tp in _Crew)) then {_Crewcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _NCrewInf)) or (_tp in _NCrewInf)) then {_NCrewInfcheck = true;_Othercheck = false};
				if (((_grp == _grpD) and (_TasV in _Support)) or (_tp in _Support)) then {_Supportcheck = true;_NCrewInfcheck = false;_Othercheck = false};

				if ((_TasV in _NCCargo) and (_x == (assignedDriver _asV)) and ((count (units (group _x))) == 1) and not ((_ATinfcheck) or (_AAinfcheck) or (_reconcheck) or (_FOcheck) or (_sniperscheck))) then {_NCrewInfcheck = false;_Othercheck = false};

				if (_SpecForcheck) then {if not (_vh in RydHQE_EnSpecFor) then {RydHQE_EnSpecFor set [(count RydHQE_EnSpecFor),_vh]};if not (_grp in RydHQE_EnSpecForG) then {RydHQE_EnSpecForG set [(count RydHQE_EnSpecForG),_grp]}};
				if (_reconcheck) then {if not (_vh in RydHQE_Enrecon) then {RydHQE_Enrecon set [(count RydHQE_Enrecon),_vh]};if not (_grp in RydHQE_EnreconG) then {RydHQE_EnreconG set [(count RydHQE_EnreconG),_grp]}};
				if (_FOcheck) then {if not (_vh in RydHQE_EnFO) then {RydHQE_EnFO set [(count RydHQE_EnFO),_vh]};if not (_grp in RydHQE_EnFOG) then {RydHQE_EnFOG set [(count RydHQE_EnFOG),_grp]}};
				if (_sniperscheck) then {if not (_vh in RydHQE_Ensnipers) then {RydHQE_Ensnipers set [(count RydHQE_Ensnipers),_vh]};if not (_grp in RydHQE_EnsnipersG) then {RydHQE_EnsnipersG set [(count RydHQE_EnsnipersG),_grp]}};
				if (_ATinfcheck) then {if not (_vh in RydHQE_EnATinf) then {RydHQE_EnATinf set [(count RydHQE_EnATinf),_vh]};if not (_grp in RydHQE_EnATinfG) then {RydHQE_EnATinfG set [(count RydHQE_EnATinfG),_grp]}};
				if (_AAinfcheck) then {if not (_vh in RydHQE_EnAAinf) then {RydHQE_EnAAinf set [(count RydHQE_EnAAinf),_vh]};if not (_grp in RydHQE_EnAAinfG) then {RydHQE_EnAAinfG set [(count RydHQE_EnAAinfG),_grp]}};
				if (_Infcheck) then {if not (_vh in RydHQE_EnInf) then {RydHQE_EValue = RydHQE_EValue + 1;RydHQE_EnInf set [(count RydHQE_EnInf),_vh]};if not (_grp in RydHQE_EnInfG) then {RydHQE_EnInfG set [(count RydHQE_EnInfG),_grp]}};
				if (_Artcheck) then {if not (_vh in RydHQE_EnArt) then {RydHQE_EValue = RydHQE_EValue + 3;RydHQE_EnArt set [(count RydHQE_EnArt),_vh]};if not (_grp in RydHQE_EnArtG) then {RydHQE_EnArtG set [(count RydHQE_EnArtG),_grp]}};
				if (_HArmorcheck) then {if not (_vh in RydHQE_EnHArmor) then {RydHQE_EValue = RydHQE_EValue + 10;RydHQE_EnHArmor set [(count RydHQE_EnHArmor),_vh]};if not (_grp in RydHQE_EnHArmorG) then {RydHQE_EnHArmorG set [(count RydHQE_EnHArmorG),_grp]}};
				if (_MArmorcheck) then {if not (_vh in RydHQE_EnMArmor) then {RydHQE_EnMArmor set [(count RydHQE_EnMArmor),_vh]};if not (_grp in RydHQE_EnMArmorG) then {RydHQE_EnMArmorG set [(count RydHQE_EnMArmorG),_grp]}};
				if (_LArmorcheck) then {if not (_vh in RydHQE_EnLArmor) then {RydHQE_EValue = RydHQE_EValue + 5;RydHQE_EnLArmor set [(count RydHQE_EnLArmor),_vh]};if not (_grp in RydHQE_EnLArmorG) then {RydHQE_EnLArmorG set [(count RydHQE_EnLArmorG),_grp]}};
				if (_LArmorATcheck) then {if not (_vh in RydHQE_EnLArmorAT) then {RydHQE_EnLArmorAT set [(count RydHQE_EnLArmorAT),_vh]};if not (_grp in RydHQE_EnLArmorATG) then {RydHQE_EnLArmorATG set [(count RydHQE_EnLArmorATG),_grp]}};
				if (_Carscheck) then {if not (_vh in RydHQE_EnCars) then {RydHQE_EValue = RydHQE_EValue + 3;RydHQE_EnCars set [(count RydHQE_EnCars),_vh]};if not (_grp in RydHQE_EnCarsG) then {RydHQE_EnCarsG set [(count RydHQE_EnCarsG),_grp]}};
				if (_Aircheck) then {if not (_vh in RydHQE_EnAir) then {RydHQE_EValue = RydHQE_EValue + 15;RydHQE_EnAir set [(count RydHQE_EnAir),_vh]};if not (_grp in RydHQE_EnAirG) then {RydHQE_EnAirG set [(count RydHQE_EnAirG),_grp]}};
				if (_BAircheck) then {if not (_vh in RydHQE_EnBAir) then {RydHQE_EnBAir set [(count RydHQE_EnBAir),_vh]};if not (_grp in RydHQE_EnBAirG) then {RydHQE_EnBAirG set [(count RydHQE_EnBAirG),_grp]}};
				if (_RAircheck) then {if not (_vh in RydHQE_EnRAir) then {RydHQE_EnRAir set [(count RydHQE_EnRAir),_vh]};if not (_grp in RydHQE_EnRAirG) then {RydHQE_EnRAirG set [(count RydHQE_EnRAirG),_grp]}};
				if (_NCAircheck) then {if not (_vh in RydHQE_EnNCAir) then {RydHQE_EnNCAir set [(count RydHQE_EnNCAir),_vh]};if not (_grp in RydHQE_EnNCAirG) then {RydHQE_EnNCAirG set [(count RydHQE_EnNCAirG),_grp]}};
				if (_Navalcheck) then {if not (_vh in RydHQE_EnNaval) then {RydHQE_EnNaval set [(count RydHQE_EnNaval),_vh]};if not (_grp in RydHQE_EnNavalG) then {RydHQE_EnNavalG set [(count RydHQE_EnNavalG),_grp]}};
				if (_Staticcheck) then {if not (_vh in RydHQE_EnStatic) then {RydHQE_EValue = RydHQE_EValue + 1;RydHQE_EnStatic set [(count RydHQE_EnStatic),_vh]};if not (_grp in RydHQE_EnStaticG) then {RydHQE_EnStaticG set [(count RydHQE_EnStaticG),_grp]}};
				if (_StaticAAcheck) then {if not (_vh in RydHQE_EnStaticAA) then {RydHQE_EnStaticAA set [(count RydHQE_EnStaticAA),_vh]};if not (_grp in RydHQE_EnStaticAAG) then {RydHQE_EnStaticAAG set [(count RydHQE_EnStaticAAG),_grp]}};
				if (_StaticATcheck) then {if not (_vh in RydHQE_EnStaticAT) then {RydHQE_EnStaticAT set [(count RydHQE_EnStaticAT),_vh]};if not (_grp in RydHQE_EnStaticATG) then {RydHQE_EnStaticATG set [(count RydHQE_EnStaticATG),_grp]}};
				if (_Supportcheck) then {if not (_vh in RydHQE_EnSupport) then {RydHQE_EnSupport set [(count RydHQE_EnSupport),_vh]};if not (_grp in RydHQE_EnSupportG) then {RydHQE_EnSupportG set [(count RydHQE_EnSupportG),_grp]}};
				if (_Cargocheck) then {if not (_vh in RydHQE_EnCargo) then {RydHQE_EnCargo set [(count RydHQE_EnCargo),_vh]};if not (_grp in RydHQE_EnCargoG) then {RydHQE_EnCargoG set [(count RydHQE_EnCargoG),_grp]}};
				if (_NCCargocheck) then {if not (_vh in RydHQE_EnNCCargo) then {RydHQE_EnNCCargo set [(count RydHQE_EnNCCargo),_vh]};if not (_grp in RydHQE_EnNCCargoG) then {RydHQE_EnNCCargoG set [(count RydHQE_EnNCCargoG),_grp]}};
				if (_Crewcheck) then {if not (_vh in RydHQE_EnCrew) then {RydHQE_EnCrew set [(count RydHQE_EnCrew),_vh]};if not (_grp in RydHQE_EnCrewG) then {RydHQE_EnCrewG set [(count RydHQE_EnCrewG),_grp]}};
				if (_NCrewInfcheck) then {if not (_vh in RydHQE_EnNCrewInf) then {RydHQE_EnNCrewInf set [(count RydHQE_EnNCrewInf),_vh]};if not (_grp in RydHQE_EnNCrewInfG) then {RydHQE_EnNCrewInfG set [(count RydHQE_EnNCrewInfG),_grp]}};

			}
		foreach (units _x)
		}
	foreach RydHQE_KnEnemiesG;

	RydHQE_EnNCrewInfG = RydHQE_EnNCrewInfG - (RydHQE_EnRAirG + RydHQE_EnStaticG);
	RydHQE_EnNCrewInf = RydHQE_EnNCrewInf - (RydHQE_EnRAir + RydHQE_EnStatic);
	RydHQE_EnInfG = RydHQE_EnInfG - (RydHQE_EnRAirG + RydHQE_EnStaticG);
	RydHQE_EnInf = RydHQE_EnInf - (RydHQE_EnRAir + RydHQE_EnStatic);

	if (RydHQE_Flee) then
		{
		_AllCow = 0;
		_AllPanic = 0;

			{
			_cow = _x getVariable ("Cow" + (str _x));
			if (isNil ("_cow")) then {_cow = 0};

			_AllCow = _AllCow + _cow;

			_panic = _x getVariable ("inPanic" + (str _x));
			if (isNil ("_panic")) then {_panic = false};

			if (_panic) then {_AllPanic = _AllPanic + 1};
			}
		foreach RydHQE_Friends;

		if (_AllPanic == 0) then {_AllPanic = 1};
		_midCow = 0;
		if not ((count RydHQE_Friends) == 0) then {_midCow = _AllCow/(count RydHQE_Friends)};

			{
			_cowF = ((- RydHQE_Morale)/(50 + (random 25))) + (random (2 * _midCow)) - _midCow;
			_cowF = _cowF * RydHQE_Muu;
			if (_x in RydHQE_SpecForG) then {_cowF = _cowF - 0.8};
			if (_cowF < 0) then {_cowF = 0};
			if (_cowF > 1) then {_cowF = 1};
			_i = "";
			if (_cowF > 0.5) then
				{
				_UL = leader _x;
				if not (isPlayer _UL) then
					{
					_inDanger = _x getVariable ["NearE",0];
					if (_inDanger > 0.05) then
						{
						if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_InFear,"InFear"] call RYD_AIChatter}
						}
					}
				};

			if (((random ((20 + (RydHQE_Morale/5))/_AllPanic)) < _cowF) and ((random 100) > (100/(_AllPanic + 1)))) then
				{
				[_x] call RYD_WPdel;
				_x setVariable [("inPanic" + (str _x)), true];
				if (RydHQE_DebugII) then {_i = [(getPosATL (vehicle (leader _x))),_x,"markPanic","ColorYellow","ICON","DOT","E!","E!",[0.5,0.5]] call RYD_Mark};
				_x setVariable [("Busy" + (str _x)), true];

				_UL = leader _x;
				if not (isPlayer _UL) then
					{
					if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_InPanic,"InPanic"] call RYD_AIChatter}
					};

				if (RydHQE_Surr) then
					{
					if ((random 100) > 50) then
						{
						if (RydHQE_DebugII) then {_i setMarkerColor "ColorPink";_i setMarkerText "E!!!"};
						_isCaptive = _x getVariable ("isCaptive" + (str _x));
						if (isNil "_isCaptive") then {_isCaptive = false};
						if not (_isCaptive) then
							{
							[_x] spawn
								{
								_gp = _this select 0;

								_gp setVariable [("isCaptive" + (str _gp)), true];

								(units _gp) orderGetIn false;
								(units _gp) allowGetin false;

									{
									[_x] spawn
										{
										_unit = _this select 0;

										sleep (random 1);
										if (isPlayer _unit) exitWith {};

										_unit setCaptive true;
										unassignVehicle _unit;

										for [{_a = 0},{_a < (count (weapons _unit))},{_a = _a + 1}] do
											{
											_weapon = (weapons _unit) select _a;
											_unit Action ["dropWeapon", _unit, _weapon]
											};

										_unit PlayAction "Surrender"
										}
									}
								foreach (units _gp)
								}
							}
						}
					}
				};

			_panic = _x getVariable ("inPanic" + (str _x));
			if (isNil ("_panic")) then {_panic = false};

			if not (_panic) then
				{
				_x allowFleeing _cowF;
				_x setVariable [("Cow" + (str _x)),_cowF,true];
				}
			else
				{
				_x allowFleeing 1;
				_x setVariable [("Cow" + (str _x)),1,true];
				if ((random 1.1) > _cowF) then
					{
					_isCaptive = _x getVariable ("isCaptive" + (str _x));
					if (isNil "_isCaptive") then {_isCaptive = false};
					_x setVariable [("inPanic" + (str _x)), false];
					if not (_isCaptive) then {_x setVariable [("Busy" + (str _x)), false]};
					}
				}
			}
		foreach RydHQE_Friends
		};

		{
		RydHQE_KnEnPos set [(count RydHQE_KnEnPos),getPosATL (vehicle (leader _x))];
		if ((count RydHQE_KnEnPos) >= 100) then {RydHQE_KnEnPos = RydHQE_KnEnPos - [RydHQE_KnEnPos select 0]};
		}
	foreach RydHQE_KnEnemiesG;

	for [{_z = 0},{_z < (count RydHQE_KnEnemies)},{_z = _z + 1}] do
		{
		_KnEnemy = RydHQE_KnEnemies select _z;
			{
			if ((_x knowsAbout _KnEnemy) > 0.01) then {RydHQE reveal [_KnEnemy,2]}
			}
		foreach RydHQE_Friends
		};

	if ((RydBB_Active) and (leaderHQE in (RydBBa_HQs + RydBBb_HQs))) then {[] call RYD_BBArrRefresh};

	if (RydHQE_Cyclecount == 1) then
		{
		[] spawn E_EnemyScan;
		if (RydHQE_ArtyShells > 0) then
			{
			[RydHQE_ArtG,RydHQE_ArtyShells] call RYD_ArtyPrep;
			};

		if ((RydBB_Active) and (leaderHQE in (RydBBa_HQs + RydBBb_HQs))) then
			{
			RydHQE_readyForBB = true;
			RydxHQ_Done = true;
			if (leaderHQE in RydBBa_HQs) then
				{
				waitUntil {sleep 0.1;(RydBBa_InitDone)}
				};

			if (leaderHQE in RydBBb_HQs) then
				{
				waitUntil {sleep 0.1;(RydBBb_InitDone)}
				}
			}
		};

	if (((count RydHQE_KnEnemies) > 0) and ((count RydHQE_ArtG) > 0) and (RydHQE_ArtyShells > 0)) then {[RydHQE_ArtG,RydHQE_KnEnemies,(RydHQE_EnHArmor + RydHQE_EnMArmor + RydHQE_EnLArmor),RydHQE_Friends,RydHQE_Debug,leaderHQE] call RYD_CFF};

	if (isNil ("RydHQE_Order")) then {RydHQE_Order = "ATTACK"};
	_gauss100 = (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10);
	if ((((_gauss100 + RydHQE_Inertia + RydHQE_Morale) > ((RydHQE_EValue/(RydHQE_FValue + 0.1)) * 60)) and not (isNil ("RydHQE_Obj")) and not (RydHQE_Order == "DEFEND")) or (RydHQE_Berserk)) then
		{
		_lastS = RydHQE getVariable ["LastStance","At"];
		if ((_lastS == "De") or (RydHQE_CycleCount == 1)) then
			{
			if ((random 100) < RydxHQ_AIChatDensity) then {[leaderHQE,RydxHQ_AIC_OffStance,"OffStance"] call RYD_AIChatter};
			};

		RydHQE setVariable ["LastStance","At"];
		RydHQE_Inertia = 30 * (0.5 + RydHQE_Consistency)*(0.5 + RydHQE_Activity);
		[] spawn E_HQOrders
		}
	else
		{
		_lastS = RydHQE getVariable ["LastStance","De"];
		if ((_lastS == "At") or (RydHQE_CycleCount == 1)) then
			{
			if ((random 100) < RydxHQ_AIChatDensity) then {[leaderHQE,RydxHQ_AIC_DefStance,"DefStance"] call RYD_AIChatter};
			};

		RydHQE setVariable ["LastStance","De"];
		RydHQE_Inertia = - (30  * (0.5 + RydHQE_Consistency))/(0.5 + RydHQE_Activity);
		[] spawn E_HQOrdersDef
		};


	if ((((RydHQE_Circumspection + RydHQE_Fineness)/2) + 0.1) > (random 1.2)) then
		{
		_SFcount = {not (_x getVariable ["Busy" + (str _x),false]) and not (_x getVariable ["Resting" + (str _x),false])} count (RydHQE_SpecForG - RydHQE_SFBodyGuard);

		if (_SFcount > 0) then
			{
			_isNight = [] call RYD_isNight;
			_SFTgts = [];
			_chance = 40 + (60 * RydHQE_Activity);

				{
				_HQ = group _x;
				if (_HQ in RydHQE_KnEnemiesG) then
					{
					_SFTgts set [(count _SFTgts),_HQ]
					}
				}
			foreach (RydxHQ_AllLeaders - [leaderHQE]);

			if ((count _SFTgts) == 0) then
				{
				_chance = _chance/2;
				_SFTgts = RydHQE_EnArtG
				};

			if ((count _SFTgts) == 0) then
				{
				_chance = _chance/3;
				_SFTgts = RydHQE_EnStaticG
				};

			if (_isNight) then
				{
				_chance = _chance + 25
				};

			if ((count _SFTgts) > 0) then
				{
				_chance = _chance + (((2 * _SFcount) - (8/(0.75 + (RydHQE_Recklessness/2)))) * 20);
				_trgG = _SFTgts select (floor (random (count _SFTgts)));
				_alreadyAttacked = {_x == _trgG} count RydHQE_SFTargets;
				_chance = _chance/(1 + _alreadyAttacked);
				if (_chance  < _SFcount) then
					{
					_chance = _SFcount
					}
				else
					{
					if (_chance > (85 + _SFcount)) then
						{
						_chance = 85 + _SFcount
						}
					};

				if ((random 100) < _chance) then
					{
					_SFAv = [];

						{
						_isBusy = _x getVariable ["Busy" + (str _x),false];

						if not (_isBusy) then
							{
							_isResting = _x getVariable ["Resting" + (str _x),false];

							if not (_isResting) then
								{
								if not (_x in RydHQE_SFBodyGuard) then
									{
									_SFAv set [(count _SFAv),_x]
									}
								}
							}
						}
					foreach RydHQE_SpecForG;

					_team = _SFAv select (floor (random (count _SFAv)));
					_trg = vehicle (leader _trgG);
					if (not ((typeOf _trg) in (_HArmor + _LArmor)) or ((random 100) > (90 - (RydHQE_Recklessness * 10)))) then {[_team,_trg,_trgG] spawn E_GoSFAttack}
					}
				}
			}
		};

	if (RydHQE_LRelocating) then
		{
		if ((abs (speed (vehicle leaderHQE))) < 0.1) then {RydHQE setVariable ["onMove",false]};
		_onMove = RydHQE getVariable ["onMove",false];

		if not (_onMove) then
			{
			if (not (isPlayer leaderHQE) and ((RydHQE_Cyclecount == 1) or not (RydHQE_Progress == 0))) then
				{
				[RydHQE] call RYD_WPdel;

				_Lpos = position leaderHQE;
				if (RydHQE_Cyclecount == 1) then {RydHQE_Fpos = _Lpos};

				_rds = 0;

				if (RydHQE_LRelocating) then
					{
					_rds = 0;
					if (RydHQE_NObj == 1) then {_Lpos = RydHQE_Fpos;if (leaderHQE in (RydBBa_HQs + RydBBb_HQs)) then {_Lpos = position leaderHQE};_rds = 0};
					if (RydHQE_NObj == 2) then {_Lpos = position RydHQE_Obj1};
					if (RydHQE_NObj == 3) then {_Lpos = position RydHQE_Obj2};
					if (RydHQE_NObj >= 4) then {_Lpos = position RydHQE_Obj3};
					};

				_spd = "LIMITED";
				if (RydHQE_Progress == -1) then {_spd = "NORMAL"};
				RydHQE_Progress = 0;
				_enemyN = false;

					{
					_eLdr = vehicle (leader _x);
					_eDst = _eLdr distance _Lpos;

					if (_eDst < 600) exitWith {_enemyN = true}
					}
				foreach RydHQE_KnEnemiesG;

				if not (_enemyN) then
					{
					_wp = [RydHQE,_Lpos,"HOLD","AWARE","GREEN",_spd,["true",""],true,_rds,[0,0,0],"FILE"] call RYD_WPadd;
					if (isNull (assignedVehicle leaderHQE)) then
						{
						if (RydHQE_GetHQInside) then {[_wp] call RYD_GoInside}
						};

					if ((RydHQE_LRelocating) and (RydHQE_NObj > 1) and (RydHQE_Cyclecount > 1)) then
						{
						[_Lpos] spawn
							{
							_Lpos = _this select 0;

							_eDst = 1000;
							_onPlace = false;
							_getBack = false;

							waitUntil
								{
								sleep 10;

									{
									_eLdr = vehicle (leader _x);
									_eDst = _eLdr distance _Lpos;

									if (_eDst < 600) exitWith {_getBack = true}
									}
								foreach RydHQE_KnEnemiesG;

								if (isNull RydHQE) then
									{
									_onPlace = true
									}
								else
									{
									if not (_getBack) then
										{
										if (((vehicle leaderHQE) distance _LPos) < 30) then {_onPlace = true}
										}
									};


								((_getback) or (_onPlace))
								};

							if not (_onPlace) then
								{
								_rds = 30;
								if (RydHQE_NObj <= 2) then {_Lpos = getPosATL (vehicle leaderHQE);_rds = 0};
								if (RydHQE_NObj == 3) then {_Lpos = position RydHQE_Obj1};
								if (RydHQE_NObj >= 4) then {_Lpos = position RydHQE_Obj2};

								_getBack = false;

									{
									_eLdr = vehicle (leader _x);
									_eDst = _eLdr distance _Lpos;

									if (_eDst < 600) exitWith {_getBack = true}
									}
								foreach RydHQE_KnEnemiesG;

								if (_getBack) then {_Lpos = getPosATL (vehicle leaderHQE);_rds = 0};

								[RydHQE] call RYD_WPdel;

								_spd = "NORMAL";
								if not (((vehicle leaderHQE) distance _LPos) < 50) then {_spd = "FULL"};

								_wp = [RydHQE,_Lpos,"HOLD","AWARE","GREEN",_spd,["true",""],true,_rds,[0,0,0],"FILE"] call RYD_WPadd;
								if (isNull (assignedVehicle leaderHQE)) then
									{
									if (RydHQE_GetHQInside) then {[_wp] call RYD_GoInside}
									};

								RydHQE setVariable ["onMove",true];
								}
							}
						}
					}
				}
			}
		};

	if (isNil ("RydHQE_CommDelay")) then {RydHQE_CommDelay = 1};
	_delay = (((22.5 + (count RydHQE_Friends))/(0.5 + RydHQE_Reflex)) * RydHQE_CommDelay);
	sleep _delay;

		{
		RydHQE reveal vehicle (leader _x)
		}
	foreach RydHQE_Friends;

	for [{_z = 0},{_z < (count RydHQE_KnEnemies)},{_z = _z + 1}] do
		{
		_KnEnemy = RydHQE_KnEnemies select _z;

			{
			if ((_x knowsAbout _KnEnemy) > 0.01) then {RydHQE reveal [_KnEnemy,2]}
			}
		foreach RydHQE_Friends
		}
	};