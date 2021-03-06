/* Name: RYD_GarrS.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_GarrS")) then {
	RYD_GarrS =	{
		private ["_unit","_pos","_timer","_alive","_dst","_taken","_gar","_i","_vel","_sum","_posLast","_dst2"];
		_unit = _this select 0;
		_pos = _this select 1;
		_taken = _this select 2;
		_unit doMove _pos;
		//_i = [_pos,_unit,"markPos","ColorBrown","ICON","mil_box","Pos","",[0.3,0.3]] call RYD_Mark;
		_timer = 0;
		_alive = true;
		_posLast = getPosASL _unit;
		waitUntil {
			_dst = 0;
			if not (isNull _unit) then {_dst = _unit distance _pos};
			sleep 0.1;
			_dst2 = 0;
			if not (isNull _unit) then {_dst2 = _unit distance _pos};
			if (isNull _unit) then {_alive = false};
			if not (alive _unit) then {_alive = false};
			if (_dst2 >= _dst) then {_timer = _timer + 1};
			((unitReady _unit) or (_timer > 240) or not (_alive))
		};
		if (_alive) then {doStop _unit};
		_unit doWatch ObjNull;
		sleep 0.1;
		_unit setDir (random 360);
		waitUntil {
			sleep 30;
			if (isNull _unit) then {_alive = false};
			if not (alive _unit) then {_alive = false};
			_gar = (group _unit) getVariable ("Garrisoned" + (str (group _unit)));
			if not (_gar) then {_alive = false};
			not (_alive)
		};
		_taken = _taken - [_pos]
	};
};
