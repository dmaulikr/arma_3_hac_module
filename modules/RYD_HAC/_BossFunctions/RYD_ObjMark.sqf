/* Name: RYD_ObjMark.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_ObjMark")) then {
	RYD_ObjMark = {
		private ["_obj","_mark","_taken","_color","_txt","_AllV","_pos","_side","_alpha"];
		_obj = _this select 0;
		_mark = _this select 1;
		_side = _this select 2;
		while {((RydBB_Active) and (RydBB_Debug))} do {
			sleep 20;
			_pos = _obj select 0;
			_pos = [_pos select 0,_pos select 1,0];
			_taken = _obj select 2;
			_color = "ColorYellow";
			_alpha = 0.1;
			if ((_taken) and (_side == "A")) then {_color = "ColorBlue";_alpha = 0.5};
			if ((_taken) and (_side == "B")) then {_color = "ColorRed";_alpha = 0.5};
			//_AllV = _pos nearEntities [["AllVehicles"],300];
			//diag_log format ["obj: %1 col: %2",_obj,_color];
			//_txt = format [" status: %1",count _AllV];
			_mark setMarkerColor _color;
			_mark setMarkerAlpha _alpha;
			//_mark setMarkerText _txt;
		};
	};
};
