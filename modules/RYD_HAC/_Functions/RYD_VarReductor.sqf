/* Name: RYD_VarReductor.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_VarReductor")) then {
	RYD_VarReductor = {
		private ["_trg","_kind","_HAC_Attacked","_infEnough","_armEnough","_airEnough","_isAttacked","_snpEnough"];
		_trg = _this select 0;
		_kind = _this select 1;
		_HAC_Attacked = (group _trg) getVariable "HAC_Attacked";
		if (isNil "_HAC_Attacked") then {_HAC_Attacked = [0,0,0,0];};
		_infEnough = _HAC_Attacked select 0;
		_armEnough = _HAC_Attacked select 1;
		_airEnough = _HAC_Attacked select 2;
		_snpEnough = _HAC_Attacked select 3;
		switch (_kind) do {
			case ("InfAttacked") : {_infEnough = _infEnough + 1};
			case ("SnpAttacked") : {_snpEnough = _snpEnough + 1};
			case ("ArmorAttacked") : {_armEnough = _armEnough + 1};
			case ("AirAttacked") : {_airEnough = _airEnough + 1};
		};
		(group _trg) setVariable ["HAC_Attacked",[_infEnough,_armEnough,_airEnough,_snpEnough]];
		if not (_kind == "AirAttacked") then {
			_isAttacked = (group _trg) getvariable (_kind + (str (group _trg)));
			if (isNil "_isAttacked") then {_isAttacked = 0;};
			if (_isAttacked > 0) then {(group _trg) setVariable [(_kind + (str (group _trg))),_isAttacked - 1];};
		};
	};
};
