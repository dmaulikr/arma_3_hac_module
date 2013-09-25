/* Name: RYD_RandomAround.sqf
 * Description:
 * Author: Rydygier, Muzzleflash
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns: array [x,y]
 * Arguments:
 * Example:
 */
if (isNil("RYD_RandomAround")) then {
	RYD_RandomAround = {
		private ["_pos","_xPos","_yPos","_a","_dir","_angle","_mag","_nX","_nY","_temp"];
		_pos = _this select 0;
		_a = _this select 1;
		_xPos = _pos select 0;
		_yPos = _pos select 1;
		_dir = random 360;
		_mag = sqrt ((random _a) * _a);
		_nX = _mag * (sin _dir);
		_nY = _mag * (cos _dir);
		_pos = [_xPos + _nX, _yPos + _nY,0];
		_pos
	};
};
