/* Name: RYD_FindBiggest.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_FindBiggest")) then {
	RYD_FindBiggest = {
	private ["_array","_biggest","_valMax","_valAct","_index","_clIndex"];
	_array = _this select 0;
	_biggest = grpNull;
	if ((count _array) > 0) then {
		_biggest = _array select 0;
		_index = 0;
		_clIndex = 0;
		_valMax = count (units _biggest);
		{	_valAct = count (units _x);
			if (_valAct > _valMax) then	{
				_biggest = _x;
				_valMax = _valAct;
				_clIndex = _index;
			};
			_index = _index + 1;
		} foreach _array;
	};
	[_biggest,_clIndex]
	};
};
