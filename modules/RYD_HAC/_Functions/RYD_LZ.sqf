/* Name: RYD_LZ.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_LZ")) then {
	RYD_LZ = {
		private ["_pos","_lz","_rds","_isFlat","_posX","_posY"];
		_pos = _this select 0;
		_posX = -1;
		_posY = -1;
		_rds = 50;
		_lz = objNull;
		_isFlat = [];
		while {_rds <= 250} do {
			_isFlat = _pos isFlatEmpty [30,_rds,1.5,30,0,false,objNull];
			if ((count _isFlat) > 1) exitWith {
				_posX = _isFlat select 0;
				_posY = _isFlat select 1;
			};
			_rds = _rds + 50;
		};
		if (_posX > 0) then	{
			_lz = createVehicle ["HeliHEmpty", [_posX,_posY,0], [], 0, "NONE"];
			//_i01 = [[_posX,_posY],str (random 100),"markLZ","ColorRed","ICON","mil_dot","LZ",""] call RYD_Mark;
		};
		_lz
	};
};
