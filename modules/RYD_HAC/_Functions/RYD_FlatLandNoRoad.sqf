/* Name: RYD_FlatLandNoRoad.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_FlatLandNoRoad")) then {
	RYD_FlatLandNoRoad = {
		private ["_pos","_radius","_final","_isGood","_isFlat","_noRoad","_nR","_ct"];
		_pos = _this select 0;
		_radius = _this select 1;
		_final = +_pos;
		_isGood = true;
		_isFlat = _pos isFlatEmpty [5,_radius/2,2,5,0,false,objNull];
		if ((count _isFlat) <= 1) then {
			_isGood = false;
		}else{
			_noRoad = true;
			_nR = [_pos,20] call RYD_NearestRoad;
			if (not (isNull _nR) or (isOnRoad _pos)) then {
				_isGood = false;
			};
		};
		_ct = 0;
		while {not (_isGood)} do {
			_ct = _ct + 1;
			if (_ct > 30) exitWith {};
			_pos = [_pos,_radius] call RYD_RandomAround;
			_isGood = true;
			_isFlat = _pos isFlatEmpty [5,_radius/2,2,5,0,false,objNull];
			if ((count _isFlat) <= 1) then {
				_isGood = false;
			}else{
				_noRoad = true;
				_nR = [_pos,20] call RYD_NearestRoad;
				if (not (isNull _nR) or (isOnRoad _pos)) then {
					_isGood = false;
				};
			};
		};
		if (_isGood) then {_final = _pos};
		_final
	};
};
