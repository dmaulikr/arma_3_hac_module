/* Name: RYD_ValueOrd.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_ValueOrd")) then {
	RYD_ValueOrd = {
		private ["_array","_final","_highest","_ix"];
		_array = _this select 0;
		_final = [];
		while {((count _array) > 0)} do	{
			_highest = [_array,3] call RYD_FindHighestWithIndex;
			_ix = _highest select 1;
			_highest = _highest select 0;
			_final set [(count _final),_highest];
			_array set [_ix,"Delete"];
			_array = _array - ["Delete"]
		};
		_final
	};
};
