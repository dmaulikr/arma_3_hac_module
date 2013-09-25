/* Name: RYD_WPdel.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns: nothing
 * Arguments:
 *  0 - GROUP object
 * Example: [_gp] call RYD_WPdel;
 */
if (isNil("RYD_WPdel")) then {
	RYD_WPdel =	{
		private ["_gp","_count"];
		_gp = _this select 0;
		if (isNil "_gp") exitWith {};
		if (isNull _gp) exitWith {};
		_count = (count (waypoints _gp)) - 1;
		if (_count < 0) exitWith {};
		[_gp, (currentWaypoint _gp)] setWaypointPosition [position (vehicle (leader _gp)), 0];
		while {(_count >= 0)} do {
			deleteWaypoint ((waypoints _gp) select _count);
			_count = (count (waypoints _gp)) - 1
		};
	};
};
