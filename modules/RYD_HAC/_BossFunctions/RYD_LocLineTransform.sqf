/* Name: RYD_LocLineTransform.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_LocLineTransform")) then {
	RYD_LocLineTransform = {
		private ["_loc","_p1","_p2","_space","_center","_angle","_r1","_r2"];
		_loc = _this select 0;
		_p1 = _this select 1;//ATL
		_p2 = _this select 2;//ATL
		_space = _this select 3;
		_center = [((_p1 select 0) + (_p2 select 0))/2,((_p1 select 1) + (_p2 select 1))/2,0];
		_angle = [_p1,_p2,0] call RYD_AngTowards;
		_r1 = _space;
		_r2 = (_center distance _p1) + _space;
		_loc setPosition _center;
		_loc setDirection _angle;
		_loc setSize [_r1,_r2];
		true
	};
};
