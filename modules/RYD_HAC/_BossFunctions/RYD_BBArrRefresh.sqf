/* Name: RYD_BBArrRefresh.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_BBArrRefresh")) then {
	RYD_BBArrRefresh = {
		RydBB_arrA = [
			RydHQ_Friends,
			RydHQ_NCrewInfG,
			RydHQ_CarsG,
			(RydHQ_HArmorG + RydHQ_LArmorG),
			RydHQ_AirG,
			RydHQ_NCAirG + (RydHQ_NCCargoG - RydHQ_NCAirG) + (RydHQ_SupportG - (RydHQ_NCAirG + (RydHQ_NCCargoG - RydHQ_NCAirG))),
			RydHQ_CCurrent,
			RydHQ_CInitial,
			RydHQ_FValue,
			RydHQ_Morale,
			RydHQ_KnEnemiesG,
			RydHQ_EnInfG,
			RydHQ_EnCarsG,
			(RydHQ_EnHArmorG + RydHQ_EnLArmorG),
			RydHQ_EnAirG,
			RydHQ_EnNCAirG + (RydHQ_EnNCCargoG - RydHQ_EnNCAirG) + (RydHQ_EnSupportG - (RydHQ_EnNCAirG + (RydHQ_EnNCCargoG - RydHQ_EnNCAirG))),
			RydHQ_EValue
		];
		if not (isNil "leaderHQB") then	{
			RydBB_arrB = [
				RydHQB_Friends,
				RydHQB_NCrewInfG,
				RydHQB_CarsG,
				(RydHQB_HArmorG + RydHQB_LArmorG),
				RydHQB_AirG,
				RydHQB_NCAirG + (RydHQB_NCCargoG - RydHQB_NCAirG) + (RydHQB_SupportG - (RydHQB_NCAirG + (RydHQB_NCCargoG - RydHQB_NCAirG))),
				RydHQB_CCurrent,
				RydHQB_CInitial,
				RydHQB_FValue,
				RydHQB_Morale,
				RydHQB_KnEnemiesG,
				RydHQB_EnInfG,
				RydHQB_EnCarsG,
				(RydHQB_EnHArmorG + RydHQB_EnLArmorG),
				RydHQB_EnAirG,
				RydHQB_EnNCAirG + (RydHQB_EnNCCargoG - RydHQB_EnNCAirG) + (RydHQB_EnSupportG - (RydHQB_EnNCAirG + (RydHQB_EnNCCargoG - RydHQB_EnNCAirG))),
				RydHQB_EValue
			];
		};
		if not (isNil "leaderHQC") then	{
			RydBB_arrC = [
				RydHQC_Friends,
				RydHQC_NCrewInfG,
				RydHQC_CarsG,
				(RydHQC_HArmorG + RydHQC_LArmorG),
				RydHQC_AirG,
				RydHQC_NCAirG + (RydHQC_NCCargoG - RydHQC_NCAirG) + (RydHQC_SupportG - (RydHQC_NCAirG + (RydHQC_NCCargoG - RydHQC_NCAirG))),
				RydHQC_CCurrent,
				RydHQC_CInitial,
				RydHQC_FValue,
				RydHQC_Morale,
				RydHQC_KnEnemiesG,
				RydHQC_EnInfG,
				RydHQC_EnCarsG,
				(RydHQC_EnHArmorG + RydHQC_EnLArmorG),
				RydHQC_EnAirG,
				RydHQC_EnNCAirG + (RydHQC_EnNCCargoG - RydHQC_EnNCAirG) + (RydHQC_EnSupportG - (RydHQC_EnNCAirG + (RydHQC_EnNCCargoG - RydHQC_EnNCAirG))),
				RydHQC_EValue
			];
		};
		if not (isNil "leaderHQD") then {
			RydBB_arrD = [
				RydHQD_Friends,
				RydHQD_NCrewInfG,
				RydHQD_CarsG,
				(RydHQD_HArmorG + RydHQD_LArmorG),
				RydHQD_AirG,
				RydHQD_NCAirG + (RydHQD_NCCargoG - RydHQD_NCAirG) + (RydHQD_SupportG - (RydHQD_NCAirG + (RydHQD_NCCargoG - RydHQD_NCAirG))),
				RydHQD_CCurrent,
				RydHQD_CInitial,
				RydHQD_FValue,
				RydHQD_Morale,
				RydHQD_KnEnemiesG,
				RydHQD_EnInfG,
				RydHQD_EnCarsG,
				(RydHQD_EnHArmorG + RydHQD_EnLArmorG),
				RydHQD_EnAirG,
				RydHQD_EnNCAirG + (RydHQD_EnNCCargoG - RydHQD_EnNCAirG) + (RydHQD_EnSupportG - (RydHQD_EnNCAirG + (RydHQD_EnNCCargoG - RydHQD_EnNCAirG))),
				RydHQD_EValue
			];
		};
		if not (isNil "leaderHQE") then {
			RydBB_arrE = [
				RydHQE_Friends,
				RydHQE_NCrewInfG,
				RydHQE_CarsG,
				(RydHQE_HArmorG + RydHQE_LArmorG),
				RydHQE_AirG,
				RydHQE_NCAirG + (RydHQE_NCCargoG - RydHQE_NCAirG) + (RydHQE_SupportG - (RydHQE_NCAirG + (RydHQE_NCCargoG - RydHQE_NCAirG))),
				RydHQE_CCurrent,
				RydHQE_CInitial,
				RydHQE_FValue,
				RydHQE_Morale,
				RydHQE_KnEnemiesG,
				RydHQE_EnInfG,
				RydHQE_EnCarsG,
				(RydHQE_EnHArmorG + RydHQE_EnLArmorG),
				RydHQE_EnAirG,
				RydHQE_EnNCAirG + (RydHQE_EnNCCargoG - RydHQE_EnNCAirG) + (RydHQE_EnSupportG - (RydHQE_EnNCAirG + (RydHQE_EnNCCargoG - RydHQE_EnNCAirG))),
				RydHQE_EValue
			];
		};
		if not (isNil "leaderHQF") then {
			RydBB_arrF = [
				RydHQF_Friends,
				RydHQF_NCrewInfG,
				RydHQF_CarsG,
				(RydHQF_HArmorG + RydHQF_LArmorG),
				RydHQF_AirG,
				RydHQF_NCAirG + (RydHQF_NCCargoG - RydHQF_NCAirG) + (RydHQF_SupportG - (RydHQF_NCAirG + (RydHQF_NCCargoG - RydHQF_NCAirG))),
				RydHQF_CCurrent,
				RydHQF_CInitial,
				RydHQF_FValue,
				RydHQF_Morale,
				RydHQF_KnEnemiesG,
				RydHQF_EnInfG,
				RydHQF_EnCarsG,
				(RydHQF_EnHArmorG + RydHQF_EnLArmorG),
				RydHQF_EnAirG,
				RydHQF_EnNCAirG + (RydHQF_EnNCCargoG - RydHQF_EnNCAirG) + (RydHQF_EnSupportG - (RydHQF_EnNCAirG + (RydHQF_EnNCCargoG - RydHQF_EnNCAirG))),
				RydHQF_EValue
			];
		};
		if not (isNil "leaderHQG") then	{
			RydBB_arrG = [
				RydHQG_Friends,
				RydHQG_NCrewInfG,
				RydHQG_CarsG,
				(RydHQG_HArmorG + RydHQG_LArmorG),
				RydHQG_AirG,
				RydHQG_NCAirG + (RydHQG_NCCargoG - RydHQG_NCAirG) + (RydHQG_SupportG - (RydHQG_NCAirG + (RydHQG_NCCargoG - RydHQG_NCAirG))),
				RydHQG_CCurrent,
				RydHQG_CInitial,
				RydHQG_FValue,
				RydHQG_Morale,
				RydHQG_KnEnemiesG,
				RydHQG_EnInfG,
				RydHQG_EnCarsG,
				(RydHQG_EnHArmorG + RydHQG_EnLArmorG),
				RydHQG_EnAirG,
				RydHQG_EnNCAirG + (RydHQG_EnNCCargoG - RydHQG_EnNCAirG) + (RydHQG_EnSupportG - (RydHQG_EnNCAirG + (RydHQG_EnNCCargoG - RydHQG_EnNCAirG))),
				RydHQG_EValue
			];
		};
		if not (isNil "leaderHQH") then	{
			RydBB_arrH = [
				RydHQH_Friends,
				RydHQH_NCrewInfG,
				RydHQH_CarsG,
				(RydHQH_HArmorG + RydHQH_LArmorG),
				RydHQH_AirG,
				RydHQH_NCAirG + (RydHQH_NCCargoG - RydHQH_NCAirG) + (RydHQH_SupportG - (RydHQH_NCAirG + (RydHQH_NCCargoG - RydHQH_NCAirG))),
				RydHQH_CCurrent,
				RydHQH_CInitial,
				RydHQH_FValue,
				RydHQH_Morale,
				RydHQH_KnEnemiesG,
				RydHQH_EnInfG,
				RydHQH_EnCarsG,
				(RydHQH_EnHArmorG + RydHQH_EnLArmorG),
				RydHQH_EnAirG,
				RydHQH_EnNCAirG + (RydHQH_EnNCCargoG - RydHQH_EnNCAirG) + (RydHQH_EnSupportG - (RydHQH_EnNCAirG + (RydHQH_EnNCCargoG - RydHQH_EnNCAirG))),
				RydHQH_EValue
			];
		};
	};
};
