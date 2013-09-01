//A3 HAC config
RHQ_Recon = [];  

RHQ_FO = [];

RHQ_Snipers = [
"B_soldier_M_F",
"O_soldier_M_F"];

RHQ_ATInf = [
"B_soldier_LAT_F",
"O_Soldier_LAT_F"];

RHQ_AAInf = []; 

RHQ_Inf = [
"B_medic_F",
"B_soldier_AR_F",
"B_soldier_exp_F",
"B_Soldier_F",
"B_Soldier_GL_F",
"B_Soldier_lite_F",
"B_Soldier_SL_F",
"B_Soldier_TL_F",
"O_medic_F",
"O_Soldier_AR_F",
"O_soldier_exp_F",
"O_Soldier_F",
"O_Soldier_GL_F",
"O_Soldier_lite_F",
"O_Soldier_SL_F",
"O_Soldier_TL_F"];

RHQ_HArmor = [];

RHQ_MArmor = [];

RHQ_LArmor = [];  

RHQ_LarmorAT = [];  

RHQ_Cars = [
"B_Hunter_F",
"B_Hunter_RCWS_F",
"B_Hunter_HMG_F",
"O_Ifrit_F",
"O_Ifrit_GMG_F",
"O_Ifrit_MG_F",
"c_offroad",
"B_Quadbike_F",
"O_Quadbike_F"];  

RHQ_Air = [
"B_AH9_F",
"O_Ka60_F",
"O_Ka60_Unarmed_F",
"B_MH9_F"];

RHQ_NCAir = [
"O_Ka60_Unarmed_F",
"B_MH9_F"];

RHQ_BAir = [];
RHQ_RAir = [];
RHQ_Naval = [
"B_Assaultboat",
"O_Assaultboat",
"O_SpeedBoat",
"B_SpeedBoat"];

RHQ_Static = [];

RHQ_StaticAA = [];

RHQ_StaticAT = [];

RHQ_Support = [];

RHQ_Med = [];

RHQ_Ammo = [];

RHQ_Fuel = [];

RHQ_Rep = [];

RHQ_Cargo = [
"B_Hunter_HMG_F",
"B_Hunter_RCWS_F",
"O_Ifrit_GMG_F",
"O_Ifrit_MG_F",
"B_Hunter_F",
"O_Ifrit_F",
"O_Ka60_F",
"O_Ka60_Unarmed_F",
"B_MH9_F"]; 

RHQ_NCCargo = [
"O_Ka60_Unarmed_F",
"B_MH9_F",
"B_Hunter_F",
"O_Ifrit_F"];  

RHQ_Crew = [
"B_Helipilot_F",
"O_helipilot_F"];
//Init HAC
nul = [] execVM "RYD_HAC\RydHQInit.sqf";