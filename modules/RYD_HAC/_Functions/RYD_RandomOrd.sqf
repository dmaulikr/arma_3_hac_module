/* Name: RYD_RandomOrd.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_RandomOrd")) then {
	RYD_RandomOrd =	{
		private ["_array","_final","_random","_select"];
		_array = _this select 0;
		_final = [];
		while {((count _array) > 0)} do	{
			_select = floor (random (count _array));
			_random = _array select _select;
			_final set [(count _final),_random];
			_array = _array - [_random];
			//_array set [_select,"Delete"];
			//_array = _array - ["Delete"]
		};
		_final
	};
};
