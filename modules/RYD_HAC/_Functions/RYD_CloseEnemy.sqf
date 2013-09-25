/* Name: RYD_CloseEnemy.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_CloseEnemy")) then {
	RYD_CloseEnemy = {
		private ["_pos","_eG","_limit","_tooClose","_dst"];
		_pos = _this select 0;
		_eG = _this select 1;
		_limit = _this select 2;
		if ((count _eG) == 0) exitWith {false};
		_tooClose = false;
		_dst = 100000;
		{	_dst = (vehicle (leader _x)) distance _pos;
			if (_dst < _limit) exitwith {_tooClose = true}
		} foreach _eG;
		_tooClose
	};
};
