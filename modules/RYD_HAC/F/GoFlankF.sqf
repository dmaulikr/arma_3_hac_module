_i1 = "";
_i2 = "";
_i3 = "";
_i4 = "";

_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(getPosATL (vehicle (leader _unitG))),true]};
_BEnemyPos = _this select 1;
_PosMidX = _this select 2;
_PosMidY = _this select 3;
_angle0 = _this select 4;
_MinSide = _this select 5;

if (_unitG in RydHQF_Garrison) exitwith {RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

_UL = leader _unitG;

_safeX1 = 0;
_safeY1 = 0;

_safeX2 = 0;
_safeY2 = 0;

_GposX = (getPosATL (leader _unitG)) select 0;
_GposY = (getPosATL (leader _unitG)) select 1;

_BEposX = _BEnemyPos select 0;
_BEposY = _BEnemyPos select 1;

_dX = _BEposX - ((getPosATL leaderHQF) select 0);
_dY = _BEposY - ((getPosATL leaderHQF) select 1);

_angle = _dX atan2 _dY;

if (_angle < 0) then {_angle = _angle + 360};
_h = 1;
if ((_angle0 > 45) and (_angle0 <= 225)) then {_h = - 1};

_BorHQD = leaderHQF distance _BEnemyPos;

_distanceSafe = 700;

_safeX1 = _h * _distanceSafe * (cos _angle);
_safeY1 = _h * _distanceSafe * (sin _angle);

_safeX2 = _distanceSafe * (sin _angle);
_safeY2 = _distanceSafe * (cos _angle);

if (_MinSide) then {_safeX1 = - _safeX1} else {_safeY1 = - _safeY1};

_FlankPosX = _BorHQD * (sin _angle);
_FlankPosY = _BorHQD * (cos _angle);

_posXWP1 = ((getPosATL leaderHQF) select 0) + _FlankPosX + _safeX1 + (random 200) - 100;
_posYWP1 = ((getPosATL leaderHQF) select 1) + _FlankPosY + _safeY1 + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

while {((_isWater) and (([_posXWP1,_posYWP1] distance _BEnemyPos) >= 200))} do
	{
	_posXWP1 = _posXWP1 - _safeX1/20;
	_posYWP1 = _posYWP1 - _safeY1/20;
	_isWater = surfaceIsWater [_posXWP1,_posYWP1];
	};

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false];RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

_posXWP2 = _posXWP1 + _safeX2 + (random 200) - 100;
_posYWP2 = _posYWP1 + _safeY2 + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 200))} do
	{
	_posXWP2 = _posXWP2 - _safeX2/20;
	_posYWP2 = _posYWP2 - _safeY2/20;
	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false];RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

_posXWP3 = _posXWP2 - (_safeX1/2) + (random 200) - 100;
_posYWP3 = _posYWP2 - (_safeY1/2) + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

while {((_isWater) and (([_posXWP3,_posYWP3] distance _BEnemyPos) >= 150))} do
	{
	_posXWP3 = (_posXWP3 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP3 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP3,_posYWP3];
	};

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false];RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

_posXWP4 = _PosMidX + (random 200) - 100;
_posYWP4 = _PosMidY + (random 200) - 100;

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

while {((_isWater) and (([_posXWP4,_posYWP4] distance _BEnemyPos) >= 150))} do
	{
	_posXWP3 = (_posXWP4 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP4 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP4,_posYWP4];
	};

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false];RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

if ((leaderHQF distance [_posXWP1,_posYWP1]) > (leaderHQF distance [_posXWP2,_posYWP2])) then
	{
	_posXWP2 = _posXWP1 - _safeX2;
	_posYWP2 = _posYWP1 - _safeY2;

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];

	while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 200))} do
		{
		_posXWP2 = _posXWP2 + _safeX2/20;
		_posYWP2 = _posYWP2 + _safeY2/20;
		_isWater = surfaceIsWater [_posXWP2,_posYWP2];
		};

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

if (_isWater) exitwith {_unitG setVariable [("Busy" + (str _unitG)),false];RydHQF_FlankAv = RydHQF_FlankAv - [_unitG]};

if (((leader _unitG) distance [_posXWP2,_posYWP2]) < ((leader _unitG) distance [_posXWP1,_posYWP1])) then {_posXWP1 = _GposX;_posYWP1 = _GposY};

_ammo = [_unitG,RydHQF_NCVeh] call RYD_AmmoCount;

_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);
if (isNil ("_busy")) then {_busy = false};
_task = taskNull;
if ((_ammo > 0) and not (_busy)) then
	{
	_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
	_unitG setVariable [("Busy" + (str _unitG)),true];
	_veh = str (typeOf (Vehicle (leader (_unitG))));

	[_unitG] call RYD_WPdel;

	if ((isPlayer (leader _unitG)) and (RydxHQ_GPauseActive)) then {hintC "New orders from HQ!";setAccTime 1};

	_UL = leader _unitG;
	RydHQF_VCDone = false;
	if (isPlayer _UL) then {[_UL,leaderHQF] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(RydHQF_VCDone)}} else {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdConf,"OrdConf"] call RYD_AIChatter}};


	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then
		{
		_i1 = [[_posXWP1,_posYWP1],_unitG,"markFlank1","ColorOrange","ICON","mil_dot","Fl1 F"," - FLANK 1"] call RYD_Mark;
		_i2 = [[_posXWP2,_posYWP2],_unitG,"markFlank2","ColorOrange","ICON","mil_dot","Fl2 F"," - FLANK 2"] call RYD_Mark;
		_i3 = [[_posXWP3,_posYWP3],_unitG,"markFlank3","ColorOrange","ICON","mil_dot","Fl3 F"," - FLANK 3"] call RYD_Mark;
		_i4 = [[_posXWP4,_posYWP4],_unitG,"markFlank4","ColorOrange","ICON","mil_dot","Fl4 F"," - FLANKING ATTACK"] call RYD_Mark
		};

	_CargoCheck = _unitG getvariable ("CC" + _unitvar);
	if (isNil ("_CargoCheck")) then {_unitG setVariable [("CC" + _unitvar), false]};
	_AV = assignedVehicle _UL;
	if ((RydHQF_CargoFind > 0) and (isNull _AV) and (([_posXWP4,_posYWP4] distance (vehicle _UL)) > 1000)) then {[_unitG] spawn F_SCargo } else {_unitG setVariable [("CC" + _unitvar), true]};
	if (RydHQF_CargoFind > 0) then
		{
		waituntil {sleep 0.05;(_unitG getvariable ("CC" + _unitvar))};
		_unitG setVariable [("CC" + _unitvar), false];
		};

	_AV = assignedVehicle _UL;
	_DAV = assigneddriver _AV;
	_GDV = group _DAV;
	_alive = false;
	_timer = 0;

	if (not (isNull _AV) and (RydHQF_CargoFind > 0)) then
		{
		_task = [(leader _unitG),["Wait and get into vehicle.", "GET IN", ""],(getPosATL (leader _unitG))] call RYD_AddTask;

		_wp = [_unitG,_AV,"GETIN"] call RYD_WPadd;
		_wp waypointAttachVehicle _AV;
		_cause = [_unitG,1,false,0,900,[],true,false,true,false,false,false] call RYD_Wait;
		if (RydHQF_LZ) then {deleteVehicle (_AV getVariable ["TempLZ",objNull])};
		_timer = _cause select 0
		};

	if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
	if ((isNull (leader (_this select 0))) or (_timer > 900)) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	_AV = assignedVehicle _UL;
	_DAV = assigneddriver _AV;
	_GDV = group _DAV;
	_wp1 = [];
	_wp2 = [];
	_wp3 = [];

	_task = [(leader _unitG),["Reach designated position. Try to avoid engaging in combat.", "Move", ""],[_posXWP1,_posYWP1]] call RYD_AddTask;

	_Ctask = taskNull;
	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		_Ctask = [(leader _GDV),["Reach designated position. Try to avoid engaging in combat.", "Move", ""],[_posXWP1,_posYWP1]] call RYD_AddTask
		};

	[_unitG] call RYD_WPdel;

	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "SAFE";
	if (not (isNull _AV) and (_GDV in RydHQF_AirG)) then {_beh = "CARELESS"};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP1,_posYWP1] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_wp1 = [_grp,[_posXWP1,_posYWP1],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,_TO] call RYD_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then
		{
		_OtherGroup = true;

		_cause = [_GDV,6,true,300,30,[RydHQF_AirG,RydHQF_KnEnemiesG],true] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else
		{
		_cause = [_unitG,6,true,300,30,[RydHQF_AirG,RydHQF_KnEnemiesG],false] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	_DAV = assigneddriver _AV;
	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle _UL), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getPosATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_task setSimpleTaskDestination [_posXWP2,_posYWP2]
			}
		else
			{
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP2,_posYWP2]] call RE;
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		if not (isMultiplayer) then
			{
			_Ctask setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_Ctask setSimpleTaskDestination [_posXWP2,_posYWP2]
			}
		else
			{
			//[(leader _GDV),nil, "per", rSETSIMPLETASKDESTINATION, _Ctask,[_posXWP2,_posYWP2]] call RE;
			//[(leader _GDV),nil, "per", rSETSIMPLETASKDESCRIPTION, _Ctask,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	[_unitG] call RYD_WPdel;

	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {_i1 setMarkerColor "ColorBlue"};

	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "AWARE";
	if (not (isNull _AV) and (_GDV in RydHQF_AirG)) then {_beh = "CARELESS"};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP2,_posYWP2] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_frm = formation _grp;
	if not (isPlayer (leader _grp)) then {_frm = "STAG COLUMN"};

	_wp2 = [_grp,[_posXWP2,_posYWP2],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,_TO,_frm] call RYD_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then
		{
		_OtherGroup = true;

		_cause = [_GDV,6,true,300,30,[RydHQF_AirG,RydHQF_KnEnemiesG],true] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else
		{
		_cause = [_unitG,6,true,300,30,[RydHQF_AirG,RydHQF_KnEnemiesG],false] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	_DAV = assigneddriver _AV;
	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle _UL), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getPosATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Reach designated position. Try to avoid engaging in combat.", "Move", ""];
			_task setSimpleTaskDestination [_posXWP3,_posYWP3]
			}
		else
			{
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP3,_posYWP3]] call RE;
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Reach designated position. Try to avoid engaging in combat.", "Move", ""]] call RE
			}
		};

	if ((isPlayer (leader _GDV)) and not ((leader _GDV) == (leader _unitG))) then
		{
		if not (isMultiplayer) then
			{
			_Ctask setSimpleTaskDescription ["Disembark group at designated position.", "Move", ""];
			_Ctask setSimpleTaskDestination [_posXWP3,_posYWP3]
			}
		else
			{
			//[(leader _GDV),nil, "per", rSETSIMPLETASKDESTINATION, _Ctask,[_posXWP3,_posYWP3]] call RE;
			//[(leader _GDV),nil, "per", rSETSIMPLETASKDESCRIPTION, _Ctask,["Disembark group at designated position.", "Move", ""]] call RE
			}
		};

	[_unitG] call RYD_WPdel;

	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {_i2 setMarkerColor "ColorBlue"};

	_tp = "MOVE";
	//if (not (isNull _AV) and (_unitG in RydHQF_NCrewInfG) and not ((_GDV == _unitG) or (_GDV in RydHQF_AirG))) then {_tp = "UNLOAD"};
	_grp = _unitG;
	if not (isNull _AV) then {_grp = _GDV};
	_beh = "AWARE";
	_lz = objNull;
	if (not (isNull _AV) and (_GDV in RydHQF_AirG)) then
		{
		_beh = "CARELESS";
		if (RydHQF_LZ) then
			{
			_lz = [[_posXWP3,_posYWP3]] call RYD_LZ;
			if not (isNull _lz) then
				{
				_lzPos = getPosATL _lz;
				_posXWP3 = _lzPos select 0;
				_posYWP3 = _lzPos select 1
				}
			}
		};

	_sts = ["true","deletewaypoint [(group this), 0];"];
	//if (((group (assigneddriver _AV)) in RydHQF_AirG) and (_unitG in RydHQF_NCrewInfG)) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};
	_TO = [0,0,0];
	if ((isNull _AV) and (([_posXWP3,_posYWP3] distance _UL) > 1000)) then {_TO = [40, 45, 50]};
	_frm = formation _grp;
	if not (isPlayer (leader _grp)) then {_frm = "STAG COLUMN"};

	_wp3 = [_grp,[_posXWP3,_posYWP3],_tp,_beh,"GREEN","NORMAL",_sts,true,0,_TO,_frm] call RYD_WPadd;

	_DAV = assigneddriver _AV;
	_OtherGroup = false;
	_GDV = group _DAV;
	_enemy = false;

	if not (((group _DAV) == (group _UL)) or (isNull (group _DAV))) then
		{
		_OtherGroup = true;

		_cause = [_GDV,6,true,400,30,[RydHQF_AirG,RydHQF_KnEnemiesG],false] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		}
	else
		{
		_cause = [_unitG,6,true,400,30,[RydHQF_AirG,RydHQF_KnEnemiesG],false] call RYD_Wait;
		_timer = _cause select 0;
		_alive = _cause select 1;
		_enemy = _cause select 2
		};

	_DAV = assigneddriver _AV;
	if (((_timer > 30) or (_enemy)) and (_OtherGroup)) then {if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1]}};
	if (((_timer > 30) or (_enemy)) and not (_OtherGroup)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [getPosATL (vehicle _UL), 1]};
	if (not (_alive) and not (_OtherGroup)) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]}};
	if (isNull (leader (_this select 0))) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];}};

	_UL = leader _unitG;if not (isPlayer _UL) then {if ((_timer <= 30) and not (_enemy)) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}}};

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
		if (_unitG in RydHQF_NCrewInfG) then {_pass orderGetIn false};
		};

	_DAV = assigneddriver _AV;
	_GDV = group _DAV;

	if (not (isNull _AV) and (RydHQF_CargoFind > 0) and (_unitG in RydHQF_NCrewInfG)) then
		{
		_cause = [_unitG,1,false,0,240,[],true,true,false,false,false,false] call RYD_Wait;
		_timer = _cause select 0
		};

	if not (_allowed) then {(units _unitG) allowGetIn true};

	if (RydHQF_LZ) then {deleteVehicle _lz};

	if not ((_GDV == _unitG) or (isNull _GDV)) then
		{
		{unassignVehicle _x} foreach (units _unitG);
		};

	if ((isPlayer (leader _GDV)) and not (isMultiplayer)) then {(leader _GDV) removeSimpleTask _Ctask};
	if ((isNull (leader (_this select 0))) or (_timer > 240)) exitwith {if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {{deleteMarker _x} foreach [_i1,_i2,_i3,_i4]};if not (isNull _GDV) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1];_GDV setVariable [("Busy" + _unitvar), false];_pass orderGetIn true}};

	_unitvar = str _GDV;
	_timer = 0;
	if (not (isNull _GDV) and (_GDV in RydHQF_AirG) and not (isPlayer (leader _GDV))) then
		{
		_wp = [_GDV,[((position _AV) select 0) + (random 200) - 100,((position _AV) select 1) + (random 200) - 100,1000],"MOVE","CARELESS","GREEN","NORMAL"] call RYD_WPadd;

		_cause = [_GDV,3,true,0,8,[],false] call RYD_Wait;
		_timer = _cause select 0;

		if (_timer > 8) then {[_GDV, (currentWaypoint _GDV)] setWaypointPosition [getPosATL (vehicle (leader _GDV)), 1]};
		};

	_GDV setVariable [("CargoM" + _unitvar), false];

	if (isPlayer (leader _unitG)) then
		{
		if not (isMultiplayer) then
			{
			_task setSimpleTaskDescription ["Engage any hostile unit at designated position.", "SAD", ""];
			_task setSimpleTaskDestination [_posXWP4,_posYWP4]
			}
		else
			{
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,[_posXWP4,_posYWP4]] call RE;
			//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Engage any hostile unit at designated position.", "SAD", ""]] call RE
			}
		};

	[_unitG] call RYD_WPdel;

	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {_i3 setMarkerColor "ColorBlue"};

	_beh = "AWARE";
	_spd = "NORMAL";
	if ((_enemy) and (((vehicle (leader _unitG)) distance [_posXWP4,_posYWP4]) > 1000)) then {_spd = "LIMITED";_beh = "SAFE"};
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

	_wp4 = [_unitG,[_posXWP4,_posYWP4],"SAD",_beh,"RED",_spd,["true","deletewaypoint [(group this), 0];"],true,200,[0,0,0],_frm] call RYD_WPadd;

	_cause = [_unitG,6,true,0,30,[],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith
		{
		if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then
			{
				{
				deleteMarker _x
				}
			foreach [_i1,_i2,_i3,_i4]
			}
		};

	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};

	if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
	RydHQF_FlankAv = RydHQF_FlankAv - [_unitG];
	_unitG setVariable [("Busy" + _unitvar), false];

	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then {_i4 setMarkerColor "ColorBlue"};
	sleep 30;
	if ((RydHQF_Debug) or (isPlayer (leader _unitG))) then
		{
			{
			deleteMarker _x
			}
		foreach [_i1,_i2,_i3,_i4]
		};

	_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdEnd,"OrdEnd"] call RYD_AIChatter}};
	};

