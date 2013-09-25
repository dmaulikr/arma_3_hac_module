/* Name: RYD_DistOrdB.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_DistOrdB")) then {
	RYD_DistOrdB = {
		private ["_array","_first","_point","_dst","_limit","_final","_VL"];
		_array = _this select 0;//BB strategic areas
		_point = _this select 1;
		_limit = _this select 2;
		_first = [];
		_final = [];
		{	_dst = round ((_x select 0) distance _point);
			if (_dst <= _limit) then {_first set [_dst,_x]};
		} foreach _array;
		{	if not (isNil "_x") then {_final set [(count _final),_x]};
		} foreach _first;
		_first = nil;
		_final
	};
};
