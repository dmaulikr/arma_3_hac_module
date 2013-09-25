/* Name: RYD_AmmoCount.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns: float (0.0)
 * Arguments:
 *  0 - GROUP object
 * Example: [_gp] call RYD_AmmoCount;
 */
if (isNil("RYD_AmmoCount")) then {
	RYD_AmmoCount = {
		private ["_gp","_ct","_ncVeh"];
		_gp = _this select 0;
		_ncVeh = [];
		if ((count _this) > 1) then {_ncVeh = _this select 1};
		_ct = 0;
		{	_ct = _ct + (count (magazines (vehicle _x)));
			if ((typeOf (vehicle _x)) in _ncVeh) then {_ct = _ct + (count (magazines _x))};
		} foreach (units _gp);
		_ct
	};
};
