/* Name: RYD_GoLaunch.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_GoLaunch")) then {
	RYD_GoLaunch = {
		private ["_side","_kind","_code"];
		_side = _this select 0;
		_kind = _this select 1;
		_code = {};
		switch (_side) do {
			case ("A") : {
				switch (_kind) do {
					case ("INF") : {_code = A_GoAttInf};
					case ("ARM") : {_code = A_GoAttArmor};
					case ("SNP") : {_code = A_GoAttSniper};
					case ("AIR") : {_code = A_GoAttAir};
				};
			};
			case ("B") : {
				switch (_kind) do {
					case ("INF") : {_code = B_GoAttInf};
					case ("ARM") : {_code = B_GoAttArmor};
					case ("SNP") : {_code = B_GoAttSniper};
					case ("AIR") : {_code = B_GoAttAir};
				};
			};
			case ("C") : {
				switch (_kind) do {
					case ("INF") : {_code = C_GoAttInf};
					case ("ARM") : {_code = C_GoAttArmor};
					case ("SNP") : {_code = C_GoAttSniper};
					case ("AIR") : {_code = C_GoAttAir};
				};
			};
			case ("D") : {
				switch (_kind) do {
					case ("INF") : {_code = D_GoAttInf};
					case ("ARM") : {_code = D_GoAttArmor};
					case ("SNP") : {_code = D_GoAttSniper};
					case ("AIR") : {_code = D_GoAttAir};
				};
			};
			case ("E") : {
				switch (_kind) do {
					case ("INF") : {_code = E_GoAttInf};
					case ("ARM") : {_code = E_GoAttArmor};
					case ("SNP") : {_code = E_GoAttSniper};
					case ("AIR") : {_code = E_GoAttAir};
				};
			};
			case ("F") : {
				switch (_kind) do {
					case ("INF") : {_code = F_GoAttInf};
					case ("ARM") : {_code = F_GoAttArmor};
					case ("SNP") : {_code = F_GoAttSniper};
					case ("AIR") : {_code = F_GoAttAir};
				};
			};
			case ("G") : {
				switch (_kind) do {
					case ("INF") : {_code = G_GoAttInf};
					case ("ARM") : {_code = G_GoAttArmor};
					case ("SNP") : {_code = G_GoAttSniper};
					case ("AIR") : {_code = G_GoAttAir};
				};
			};
			case ("H") : {
				switch (_kind) do {
					case ("INF") : {_code = H_GoAttInf};
					case ("ARM") : {_code = H_GoAttArmor};
					case ("SNP") : {_code = H_GoAttSniper};
					case ("AIR") : {_code = H_GoAttAir};
				};
			};
		};
		_code
	};
};
