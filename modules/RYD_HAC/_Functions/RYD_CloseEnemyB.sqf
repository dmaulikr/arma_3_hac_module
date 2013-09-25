/* Name: RYD_CloseEnemyB.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_CloseEnemyB")) then {
	RYD_CloseEnemyB = {
		private ["_pos","_eG","_limit","_tooClose","_dstM","_dstAct","_closest"];
		_pos = _this select 0;
		_eG = _this select 1;
		_limit = _this select 2;
		if ((count _eG) == 0) exitWith {[false,100000,grpNull]};
		_tooClose = false;
		_dstM = 100000;
		_closest = _eG select 0;
		{	_dstAct = (vehicle (leader _x)) distance _pos;
			if (_dstAct < _dstM) then {_closest = _x;_dstM = _dstAct}
		} foreach _eG;
		if (_dstM < _limit) then {_tooClose = true};
		[_tooClose,_dstM,_closest]
	};
};
