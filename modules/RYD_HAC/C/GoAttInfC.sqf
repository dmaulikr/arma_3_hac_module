_i = "";

_unitG = _this select 0;

_Spos = _unitG getvariable ("START" + (str _unitG));
if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))};

_Trg = _this select 1;

_isAttacked = (group _Trg) getvariable ("InfAttacked" + (str (group _Trg)));
if (isNil ("_isAttacked")) then {_isAttacked = 0};

_PosObj1 = position _Trg;
_unitvar = str (_unitG);

//if (_isAttacked > 2) exitwith {};

[_unitG] call RYD_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];

RydHQC_AttackAv = RydHQC_AttackAv - [_unitG];

_UL = leader _unitG;
_nothing = true;

_dX = (_PosObj1 select 0) - ((getPos leaderHQC) select 0);
_dY = (_PosObj1 select 1) - ((getPos leaderHQC) select 1);

_angle = _dX atan2 _dY;

_distance = leaderHQC distance _PosObj1;
_distance2 = 350;

_Armor = RydHQC_LArmorG + RydHQC_HArmorG;

if (_unitG in _Armor) then {_distance2 = 500};
if (_unitG in RydHQC_AirG) then {_distance2 = 750};

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

if (_isAttacked == 2) then {(group _Trg) setvariable [("InfAttacked" + (str (group _Trg))),3];_dYc = - _dYc};
if (_isAttacked == 1) then {(group _Trg) setvariable [("InfAttacked" + (str (group _Trg))),2];_dXc = - _dXc};
if (_isAttacked < 1) then {(group _Trg) setvariable [("InfAttacked" + (str (group _Trg))),1];_distance = _distance - _distance2;_dXc = 0;_dYc = 0};
if (_isAttacked > 2) then {_distance = _distance - _distance2;_dXc = 0;_dYc = 0};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getPos leaderHQC) select 0) + _dXb + _dXc + (random 200) - 100;
_posY = ((getPos leaderHQC) select 1) + _dYb + _dYc + (random 200) - 100;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 50))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith
	{
	RydHQC_AttackAv = RydHQC_AttackAv + [(_unitG)];
	_unitG setVariable [("Busy" + (str _unitG)),false];
	[_Trg,"InfAttacked"] call RYD_VarReductor
	};

if ((isPlayer (leader _unitG)) and (RydxHQ_GPauseActive)) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
RydHQC_VCDone = false;
if (isPlayer _UL) then {[_UL,leaderHQC] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(RydHQC_VCDone)}} else {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdConf,"OrdConf"] call RYD_AIChatter}};

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then
	{
	_i = [[_posX,_posY],_unitG,"markAttack","ColorRed","ICON","mil_dot","Inf C"," - ATTACK"] call RYD_Mark
	};

_CargoCheck = _unitG getvariable ("CC" + _unitvar);
if (isNil ("_CargoCheck")) then {_unitG setVariable [("CC" + _unitvar), false]};
_AV = assignedVehicle _UL;
if ((RydHQC_CargoFind > 0) and (isNull _AV) and (([_posX,_posY] distance (vehicle _UL)) > 1000)) then {[_unitG] spawn C_SCargo } else {_unitG setVariable [("CC" + _unitvar), true]};
if (RydHQC_CargoFind > 0) then
	{
	waituntil {sleep 0.05;(_unitG getvariable ("CC" + _unitvar))};
	_unitG setVariable [("CC" + _unitvar), false];
	};

_AV = assignedVehicle _UL;
_DAV = assigneddriver _AV;
_GDV = group _DAV;

_task = taskNull;
_timer = 0;

if (not (isNull _AV) and (RydHQC_CargoFind > 0)) then
	{
	_task = [(leader _unitG),["Wait and get into vehicle.", "GET IN", ""],(position (leader _unitG))] call RYD_AddTask;

	_wp = [_unitG,_AV,"GETIN"] call RYD_WPadd;
	_wp waypointAttachVehicle _AV;

	_cause = [_unitG,1,false,0,900,[],true,false,true,false,false,false] call RYD_Wait;
	if (RydHQC_LZ) then {deleteVehicle (_AV getVariable ["TempLZ",objNull])};
	_timer = _cause select 0;
	};

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
if ((isNull (leader (_this select 0))) or (_timer > 900)) exitwith {[_Trg,"InfAttacked"] call RYD_VarReductor;if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [position (vehicle (leader _GDV)), 0];_GDV setVariable [("Busy" + _unitvar), false];}};

_AV = assignedVehicle _UL;
_DAV = assigneddriver _AV;
_GDV = group _DAV;
_wp0 = [];_wp = [];
_nW = 1;

_LX1 = _posX;
_LY1 = _posY;
_EnNearTrg = false;
_NeNMode = false;
_halfway = false;
_mpl = 1;

_eClose1 = [[_posX,_posY],RydHQC_KnEnemiesG,400] call RYD_CloseEnemyB;

_tooC1 = _eClose1 select 0;
_dstEM1 = _eClose1 select 1;
_NeN = _eClose1 select 2;

if not (isNull _NeN) then
	{
	_eClose2 = [_UL,RydHQC_KnEnemiesG,400] call RYD_CloseEnemyB;
	_tooC2 = _eClose2 select 0;
	_dstEM2 = _eClose2 select 1;
	_eClose3 = [leaderHQC,RydHQC_KnEnemiesG,400] call RYD_CloseEnemyB;
	_tooC3 = _eClose3 select 0;

	if ((_tooC1) or (_tooC2) or (_tooC3) or (((_UL distance [_posX,_posY]) - _dstEM2) > _dstEM1)) then {_EnNearTrg = true}
	};

if (_EnNearTrg) then {_NeNMode = true};
if (not (isNull _GDV) and (_GDV in (RydHQC_NCCargoG + RydHQC_AirG)) and (_NeNMode) and not (isPlayer (leader _GDV))) then {_LX1 = (position _UL) select 0;_LY1 = (position _UL) select 1;_halfway = true};

if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1500) and not (isPlayer (leader _unitG))) then
	{
	_LX = (position _UL) select 0;
	_LY = (position _UL) select 1;

	_spd = "LIMITED";
	_TO = [0,0,0];
	if (_NeNMode) then {_spd = "NORMAL";_TO = [40, 45, 50]};

	_wp0 = [_unitG,[(_posX + _LX)/2,(_posY + _LY)/2],"MOVE","SAFE","YELLOW",_spd,["true","deletewaypoint [(group this), 0];"],true,0,_TO] call RYD_WPadd;
	_nW = 2;
	};

_task = [(leader _unitG),["Search and destroy enemy.", "S&D", ""],[_posX,_posY]] call RYD_AddTask;

_Ctask = [(leader _GDV),["Disembark group at designated position.", "Move", ""],[(_posX + _LX1)/2,(_posY + _LY1)/2]] call RYD_AddTask;

_gp = _unitG;
if not (isNull _AV) then {_gp = _GDV;_posX = (_posX + _LX1)/2;_posY = (_posY + _LY1)/2};
_pos = [_posX,_posY];
_tp = "MOVE";
//if (not (isNull _AV) and (_unitG in RydHQC_NCrewInfG) and not ((_GDV == _unitG) or (_GDV in RydHQC_AirG))) then {_tp = "UNLOAD"};
_beh = "SAFE";
_lz = objNull;
if (not (isNull _AV) and (_GDV in RydHQC_AirG)) then
	{
	_beh = "CARELESS";
	if (RydHQC_LZ) then
		{
		_lz = [[_posX,_posY]] call RYD_LZ;
		if not (isNull _lz) then
			{
			_pos = getPosATL _lz;
			_posX = _pos select 0;
			_posY = _pos select 1
			}
		}
	};

_spd = "NORMAL";
if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1000) and not (_NeNMode)) then {_spd = "LIMITED"};
_TO = [0,0,0];
if ((isNull _AV) and (([_posX,_posY] distance _UL) <= 1000) or ((_NeNMode) and (isNull _AV))) then {_TO = [40, 45, 50]};
_crr = false;
if ((_nW == 1) and (isNull _AV)) then {_crr = true};
if not (isNull _AV) then {_crr = true};
_sts = ["true","deletewaypoint [(group this), 0];"];
//if (((group (assigneddriver _AV)) in RydHQC_AirG) and (_unitG in RydHQC_NCrewInfG)) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};

_wp = [_gp,_pos,_tp,_beh,"YELLOW",_spd,_sts,_crr,0,_TO] call RYD_WPadd;

if ((RydxHQ_SynchroAttack) and not (_halfway)) then
	{
	[_wp,_Trg] call RYD_WPSync;


	};

_DAV = assigneddriver _AV;
_OtherGroup = false;
_GDV = group _DAV;
_alive = false;
_enemy = false;
_timer = 0;

if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then
	{
	_OtherGroup = true;

	_cause = [_GDV,6,true,400,30,[RydHQC_AirG,RydHQC_KnEnemiesG],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;
	_enemy = _cause select 2
	}
else
	{
	_cause = [_unitG,6,true,400,30,[RydHQC_AirG,RydHQC_KnEnemiesG],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;
	_enemy = _cause select 2
	};

_DAV = assigneddriver _AV;
if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [position (vehicle (leader _GDV)), 0]}};
if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
if (not (_alive) and not (_OtherGroup)) exitwith
	{
	if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"InfAttacked"] call RYD_VarReductor
	};

if (isNull (leader (_this select 0))) exitwith
	{
	if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [position (vehicle (leader _GDV)), 0];_GDV setVariable [("Busy" + _unitvar), false];};
	[_Trg,"InfAttacked"] call RYD_VarReductor
	};

_UL = leader _unitG;if not (isPlayer _UL) then {if (not (_halfway) and (_timer <= 30) and not (_enemy)) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}}};

_AV = assignedVehicle _UL;
_pass = assignedCargo _AV;
_allowed = true;
if not ((_GDV == _unitG) or (isNull _GDV)) then
	{
	//{unassignVehicle _x} foreach (units _unitG);
	_pass orderGetIn false;
	_allowed = false;
	(units _unitG) allowGetIn false
	}
else
	{
	if (_unitG in RydHQC_NCrewInfG) then {_pass orderGetIn false};
	};

_DAV = assigneddriver _AV;
_GDV = group _DAV;

if (not (isNull _AV) and (RydHQC_CargoFind > 0) and (_unitG in RydHQC_NCrewInfG)) then
	{
	_cause = [_unitG,1,false,0,240,[],true,true,false,false,false,false] call RYD_Wait;
	_timer = _cause select 0
	};

if not ((_GDV == _unitG) or (isNull _GDV)) then
	{
	{unassignVehicle _x} foreach (units _unitG);
	};

if not (_allowed) then {(units _unitG) allowGetIn true};

if (RydHQC_LZ) then {deleteVehicle _lz};

if ((isPlayer (leader _GDV)) and not (isMultiplayer)) then {(leader _GDV) removeSimpleTask _Ctask};

_unitvar = str _GDV;

if ((isNull (leader (_this select 0))) or (_timer > 240)) exitwith
	{
	if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [position (vehicle (leader _GDV)), 0];_GDV setVariable [("Busy" + _unitvar), false];_pass orderGetIn true};
	[_Trg,"InfAttacked"] call RYD_VarReductor
	};

if (not (isNull _GDV) and (_GDV in RydHQC_AirG) and not (isPlayer (leader _GDV))) then
	{
	_wp = [_GDV,[((position _AV) select 0) + (random 200) - 100,((position _AV) select 1) + (random 200) - 100,1000],"MOVE","CARELESS","YELLOW","NORMAL"] call RYD_WPadd;

	_cause = [_GDV,3,true,0,8,[],false] call RYD_Wait;
	_timer = _cause select 0;
	if (_timer > 8) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [position (vehicle (leader _GDV)), 0]};
	};

_GDV setVariable [("CargoM" + _unitvar), false];
_alive = true;
if (_halfway) then
	{
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "STAG COLUMN"};

	_wp = [_unitG,[_posX,_posY],"MOVE","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,[0,0,0],_frm] call RYD_WPadd;

	if (RydxHQ_SynchroAttack) then
		{
		[_wp,_Trg] call RYD_WPSync;


		};

	_cause = [_unitG,6,true,0,30,[],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith
		{
		if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
		};

	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
	};

if not (_alive) exitwith {[_Trg,"InfAttacked"] call RYD_VarReductor};

if (isPlayer (leader _unitG)) then
	{
	if not (isMultiplayer) then
		{
		_task setSimpleTaskDescription ["Search and destroy enemy.", "S&D", ""];
		_task setSimpleTaskDestination (position _Trg)
		}
	else
		{
		//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,(position _Trg)] call RE;
		//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Search and destroy enemy.", "S&D", ""]] call RE
		}
	};

_beh = "AWARE";
_spd = "NORMAL";
if ((_enemy) and not (_halfway) and (((vehicle (leader _unitG)) distance _Trg) > 1000) and not (_NeNMode)) then {_spd = "LIMITED";_beh = "SAFE"};
_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};
_cur = true;
if (RydxHQ_SynchroAttack) then {_cur = false};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((_halfway) and (_timer <= 30)) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}}};

 _wp = [_unitG,_Trg,"SAD",_beh,"YELLOW",_spd,["true","deletewaypoint [(group this), 0];"],_cur,0,[0,0,0],_frm] call RYD_WPadd;

_cause = [_unitG,6,true,0,30,[],false] call RYD_Wait;
_timer = _cause select 0;
_alive = _cause select 1;

if not (_alive) exitwith
	{
	if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};
	[_Trg,"InfAttacked"] call RYD_VarReductor
	};

if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {_i setMarkerColor "ColorBlue"};

if (_unitG in RydHQC_Garrison) then
	{
	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Return.", "Move", ""];
			_task setSimpleTaskDestination _Spos
			}
		else
			{
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_Spos] call RE;
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
			}
		};

	_wp = [_unitG,_Spos,"MOVE","SAFE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,5] call RYD_WPadd;

	_cause = [_unitG,6,true,0,30,[],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith {if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
	_unitG setVariable ["Garrisoned" + (str _unitG),false];
	};

sleep 60;

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))};

_pass orderGetIn true;//_countAv = count RydHQC_AttackAv;
RydHQC_AttackAv = RydHQC_AttackAv + [(_unitG)];
_unitG setVariable [("Busy" + (str _unitG)),false];

[_Trg,"InfAttacked"] call RYD_VarReductor;

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdEnd,"OrdEnd"] call RYD_AIChatter}};