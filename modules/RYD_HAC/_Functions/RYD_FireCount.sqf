/* Name: RYD_FireCount.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_FireCount")) then {
	RYD_FireCount = {
		private ["_unit","_count","_fEH"];
		_unit = _this select 0;
		_count = _unit getVariable "FireCount";
		if (isNil "_count") then {_count = 0};
		if (_count >= 2) exitWith {
			_fEH = _unit getVariable "HAC_FEH";
			if not (isNil "_fEH") then {
				_unit removeEventHandler ["Fired",_fEH];
				_unit setVariable ["HAC_FEH",nil];
			};
		};
		_unit setVariable ["FireCount",_count + 1];
	};
};
