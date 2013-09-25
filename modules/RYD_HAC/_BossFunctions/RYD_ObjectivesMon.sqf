/* Name: RYD_ObjectivesMon.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_ObjectivesMon")) then {
	RYD_ObjectivesMon = {
		private ["_area","_BBSide","_isTaken","_HQ","_AllV","_Civs","_AllV2","_Civs2","_NearAllies","_NearEnemies","_trg","_AllV0","_AllV20","_mChange","_HQs","_enArea","_enPos","_BBProg"];
		_area = _this select 0;
		_BBSide = _this select 1;
		_HQ = _this select 2;
		while {(RydBB_Active)} do {
			sleep 60;
			{	_isTaken = _x select 2;
				_trg = _x select 0;
				_trg = [_trg select 0,_trg select 1,0];
				if (_isTaken) then {
					_AllV = _trg nearEntities [["AllVehicles"],500];
					_Civs = _trg nearEntities [["Civilian"],500];
					_AllV2 = _trg nearEntities [["AllVehicles"],300];
					_Civs2 = _trg nearEntities [["Civilian"],300];
					_AllV = _AllV - _Civs;
					_AllV2 = _AllV2 - _Civs2;
					_AllV0 = _AllV;
					_AllV20 = _AllV2;
					{	if not (_x isKindOf "Man") then	{
							if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]};
						};
					} foreach _AllV0;
					{	if not (_x isKindOf "Man") then	{
							if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]};
						};
					} foreach _AllV20;
					_NearAllies = _HQ countfriendly _AllV;
					_NearEnemies = _HQ countenemy _AllV2;
					if (_NearAllies < _NearEnemies) then {
						_x set [2,false];
						_HQs = RydBBa_HQs;
						if (_BBSide == "A") then {RydBBa_Urgent = true} else {RydBBb_Urgent = true;_HQs = RydBBb_HQs};
						_mChange = 10/(count _HQs);
						{	switch (_x) do {
								case (leaderHQ) : {RydHQ_Morale = RydHQ_Morale - _mChange};
								case (leaderHQB) : {RydHQB_Morale = RydHQB_Morale - _mChange};
								case (leaderHQC) : {RydHQC_Morale = RydHQC_Morale - _mChange};
								case (leaderHQD) : {RydHQD_Morale = RydHQD_Morale - _mChange};
								case (leaderHQE) : {RydHQE_Morale = RydHQE_Morale - _mChange};
								case (leaderHQF) : {RydHQF_Morale = RydHQF_Morale - _mChange};
								case (leaderHQG) : {RydHQG_Morale = RydHQG_Morale - _mChange};
								case (leaderHQH) : {RydHQH_Morale = RydHQH_Morale - _mChange};
							};
						} foreach _HQs;
					};
				}else{
					_AllV = _trg nearEntities [["AllVehicles"],300];
					_Civs = _trg nearEntities [["Civilian"],300];
					_AllV2 = _trg nearEntities [["AllVehicles"],500];
					_Civs2 = _trg nearEntities [["Civilian"],500];
					_AllV = _AllV - _Civs;
					_AllV2 = _AllV2 - _Civs2;
					_AllV0 = _AllV;
					_AllV20 = _AllV2;
					{	if not (_x isKindOf "Man") then	{
							if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]};
						};
					} foreach _AllV0;
					{	if not (_x isKindOf "Man") then	{
							if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]};
						};
					} foreach _AllV20;
					_NearAllies = _HQ countfriendly _AllV;
					_NearEnemies = _HQ countenemy _AllV2;
					if ((_NearAllies >= 10) and (_NearEnemies <= 5)) then {
						_x set [2,true];
						_enArea = missionNameSpace getVariable ["B_SAreas",[]];
						if (_BBSide == "B") then {_enArea = missionNameSpace getVariable ["A_SAreas",[]]};
						{	_enPos = _x select 0;
							_enPos = [_enPos select 0,_enPos select 1,0];
							if ((_enPos distance _trg) < 50) exitWith{_x set [2,false]};
						} foreach _enArea;
						_HQs = RydBBa_HQs;
						if (_BBSide == "A") then {RydBBb_Urgent = true} else {RydBBa_Urgent = true;_HQs = RydBBb_HQs};
						_mChange = 20/(count _HQs);
						{	switch (_x) do {
								case (leaderHQ) : {RydHQ_Morale = RydHQ_Morale + _mChange};
								//_BBProg = (group leaderHQ) getVariable ["BBProgress",0];(group leaderHQ) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQB) : {RydHQB_Morale = RydHQB_Morale + _mChange};
								//_BBProg = (group leaderHQB) getVariable ["BBProgress",0];(group leaderHQB) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQC) : {RydHQC_Morale = RydHQC_Morale + _mChange};
								//_BBProg = (group leaderHQC) getVariable ["BBProgress",0];(group leaderHQC) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQD) : {RydHQD_Morale = RydHQD_Morale + _mChange};
								//_BBProg = (group leaderHQD) getVariable ["BBProgress",0];(group leaderHQD) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQE) : {RydHQE_Morale = RydHQE_Morale + _mChange};
								//_BBProg = (group leaderHQE) getVariable ["BBProgress",0];(group leaderHQE) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQF) : {RydHQF_Morale = RydHQF_Morale + _mChange};
								//_BBProg = (group leaderHQF) getVariable ["BBProgress",0];(group leaderHQF) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQG) : {RydHQG_Morale = RydHQG_Morale + _mChange};
								//_BBProg = (group leaderHQG) getVariable ["BBProgress",0];(group leaderHQG) setVariable ["BBProgress",_BBProg + 1]};
								case (leaderHQH) : {RydHQH_Morale = RydHQH_Morale + _mChange};
								//_BBProg = (group leaderHQH) getVariable ["BBProgress",0];(group leaderHQH) setVariable ["BBProgress",_BBProg + 1]};
							};
						} foreach _HQs;
					};
				};
			} foreach _area;
		};
	};
};
