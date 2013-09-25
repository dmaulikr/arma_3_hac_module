/* Name: RYD_isOnMap.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_isOnMap")) then {
	RYD_isOnMap = {
		private ["_pos","_onMap","_pX","_pY","_mapMinX","_mapMinY"];
		_pos = _this select 0;
		_onMap = true;
		_pX = _pos select 0;
		_pY = _pos select 1;
		_mapMinX = 0;
		_mapMinY = 0;
		if not (isNil "RydBB_MC") then {
			_mapMinX = RydBB_MapXMin;
			_mapMinY = RydBB_MapYMin
		};
		if (_pX < _mapMinX) then {
			_onMap = false;
		}else{
			if (_pY < _mapMinY) then {
				_onMap = false;
			}else{
				if (_pX > RydBB_MapXMax) then {
					_onMap = false;
				}else{
					if (_pY > RydBB_MapYMax) then {
						_onMap = false;
					};
				};
			};
		};
		_onMap
	};
};
