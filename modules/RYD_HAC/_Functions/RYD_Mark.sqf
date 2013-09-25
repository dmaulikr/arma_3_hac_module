/* Name: RYD_Mark.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example: [_pos,_ref,_pfx,_cl,_shp,_tp,_dTxt,_ifPTxt,_sz,_dir] call RYD_Mark;
 */
if (isNil("RYD_Mark")) then {
	RYD_Mark = {
		private ["_pos","_ref","_pfx","_cl","_shp","_tp","_dTxt","_ifPTxt","_sz","_dir","_txt","_i"];
		_pos = _this select 0;
		_ref = _this select 1;
		_pfx = _this select 2;
		_cl = _this select 3;
		_shp = _this select 4;
		_tp = _this select 5;
		_dTxt = _this select 6;
		_ifPTxt = _this select 7;
		_sz = [1,1];
		if ((count _this) > 8) then {_sz = _this select 8};
		_dir = 0;
		if ((count _this) > 9) then {_dir = _this select 9};
		_txt = _dTxt;
		if (typeName _ref == "GROUP") then {
			if (isPlayer (leader _ref)) then {_txt = (str (leader _ref)) + _ifPTxt};
		};
		if ((typeName _pos) == "OBJECT") then {_pos = position _pos};
		if not ((typename _pos) == "ARRAY") exitWith {};
		if ((_pos select 0) == 0) exitWith {};
		if ((count _pos) < 2) exitWith {};
		//diag_log format ["mark: %1 pos: %2 col: %3 size: %4 dir: %5 text: %6",_pfx + (str _ref),_pos,_cl,_sz,_dir,_txt];
		if (isNil "_pos") exitWith {};
		_i = _pfx + (str _ref);
		_i = createMarker [_i,_pos];
		_i setMarkerColor _cl;
		_i setMarkerShape _shp;
		if (_shp =="ICON") then {_i setMarkerType _tp} else {_i setMarkerBrush _tp};
		_i setMarkerSize _sz;
		_i setMarkerDir _dir;
		_i setMarkerText _txt;
		_i
	};
};
