/* Name: RYD_AngTowards.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_AngTowards")) then {
	RYD_AngTowards = {
		private ["_source0", "_target0", "_rnd0","_dX0","_dY0","_angleAzimuth0"];
		_source0 = _this select 0;
		_target0 = _this select 1;
		_rnd0 = _this select 2;
		_dX0 = (_target0 select 0) - (_source0 select 0);
		_dY0 = (_target0 select 1) - (_source0 select 1);
		_angleAzimuth0 = (_dX0 atan2 _dY0) + (random (2 * _rnd0)) - _rnd0;
		_angleAzimuth0
	};
};