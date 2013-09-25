/* Name: RYD_PosTowards2D.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_PosTowards2D")) then {
	RYD_PosTowards2D = {
		private ["_source","_distT","_angle","_dXb","_dYb","_px","_py","_pz"];
		_source = _this select 0;
		_angle = _this select 1;
		_distT = _this select 2;
		_dXb = _distT * (sin _angle);
		_dYb = _distT * (cos _angle);
		_px = (_source select 0) + _dXb;
		_py = (_source select 1) + _dYb;
		_pz = getTerrainHeightASL [_px,_py];
		[_px,_py,_pz]
	};
};
