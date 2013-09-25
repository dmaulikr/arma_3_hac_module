/* Name: RYD_RandomAroundB.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns: array [x,y]
 * Arguments:
 * Example:
 */
if (isNil("RYD_RandomAroundB")) then {
	RYD_RandomAroundB = {
		private ["_pos","_X","_Y","_radius","_radiusMax","_angle"];
		_pos = _this select 0;
		_radiusMax = _this select 1;
		_angle = random 360;
		_radius = random _radiusMax;
		_X = _radius * sin _angle;
		_Y = _radius * cos _angle;
		_pos = [(_pos select 0) + _X,(_pos select 1) + _Y,0];
		_pos
	};
};
