/* Name: RYD_WPSync.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_WPSync")) then {
	RYD_WPSync = {
		private ["_wp","_trg","_otherWP","_gp","_isRest","_pos","_alive","_cwp","_timer"];
		_wp = _this select 0;
		_trg = group (_this select 1);
		if (isNull _trg) exitWith {};
		_pos = waypointPosition _wp;
		_otherWP = _trg getVariable ["RYD_Attacks",[]];
		_wp synchronizeWaypoint _otherWP;
		_trg setVariable ["RYD_Attacks",_otherWP + [_wp]];
		_otherWP = _trg getVariable ["RYD_Attacks",[]];
		_gp = _wp select 0;
		_timer = 0;
		_alive = true;
		waitUntil{
			sleep 5;
			_isRest = _gp getVariable [("Resting" + (str _gp)),false];
			if (fleeing (leader _gp)) then {_isRest = true};
			_timer = _timer + 1;
			_cwp = [_gp,currentWaypoint _gp];
			if (isNull _trg) then {_alive = false};
			if ((((waypointPosition _cwp) distance _pos) > 1) and (((waypointPosition _cwp) distance (vehicle (leader _gp))) > 20)) then {_isRest = true};
			((_isRest) or (_timer > 360) or not (_alive))
		};
		_wp synchronizeWaypoint [];
	};
};
