_i = "";

_timer = 0;
_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))};
_stage = _this select 2;

_PosObj1 = _this select 1;
_recvar = str (_unitG);

[_unitG] call RYD_WPdel;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];

RydHQH_ReconAv = RydHQH_ReconAv - [_unitG];

_UL = leader _unitG;
_PosLand = position _UL;
_nothing = true;
_End = [((position leaderHQH) select 0) + (random 400) - 200,((position leaderHQH) select 1) + (random 400) - 200];
_rd = 200;

_dX = (_PosObj1 select 0) - ((getPos leaderHQH) select 0);
_dY = (_PosObj1 select 1) - ((getPos leaderHQH) select 1);

_angle = _dX atan2 _dY;

_distance = leaderHQH distance _PosObj1;

_distance2 = 600;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

switch (_stage) do
	{
	case (6) : {_distance = _distance - _distance2/2;_dYc = - _dYc/2};
	case (5) : {_distance = _distance - _distance2/2;_dXc = - _dXc/2};
	case (4) : {_dYc = - _dYc};
	case (3) : {_dXc = - _dXc};
	case (2) : {_distance = _distance - _distance2;_dXc = 0;_dYc = 0};
	};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getPos leaderHQH) select 0) + _dXb + _dXc + (random 200) - 100;
_posY = ((getPos leaderHQH) select 1) + _dYb + _dYc + (random 200) - 100;

_MElevated = [_posX,_posY];
_MElev = (getPosATL (nearestObject [_posX,_posY,10])) select 2;

if (_unitG in RydHQH_FOG) then
	{
	for [{_a = 0},{_a <= 50},{_a = _a + 1}] do
		{
		_posX0 = _posX + (random 500) - 250;
		_posY0 = _posY + (random 500) - 250;
		_Elev = getTerrainHeightASL [_posX0,_posY0];
		if (_Elev > _MElev) then {_MElev = _Elev;_MElevated = [_posX0,_posY0]};
		}
	};

_posX = _MElevated select 0;
_posY = _MElevated select 1;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 250))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith {RydHQH_ReconAv = RydHQH_ReconAv + [(_unitG)];_unitG setVariable [("Busy" + (str _unitG)),false]};

if ((isPlayer (leader _unitG)) and (RydxHQ_GPauseActive)) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;
RydHQH_VCDone = false;
if (isPlayer _UL) then {[_UL,leaderHQH] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(RydHQH_VCDone)}} else {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdConf,"OrdConf"] call RYD_AIChatter}};

if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then
	{
	_i = [[_posX,_posY],_unitG,"markRecon","ColorRed","ICON","mil_dot","Rec H"," - NON-COMBAT RECON"] call RYD_Mark;
	};

_AV = assignedVehicle _UL;
_DAV = assigneddriver _AV;
_GDV = group _DAV;
_EnNearTrg = false;
_NeNMode = false;
_halfway = false;

_wp0 = [];
_wp = [];
_nW = 1;

_LX1 = _posX;
_LY1 = _posY;

_eClose1 = [[_posX,_posY],RydHQH_KnEnemiesG,400] call RYD_CloseEnemyB;

_tooC1 = _eClose1 select 0;
_dstEM1 = _eClose1 select 1;
_NeN = _eClose1 select 2;

if not (isNull _NeN) then
	{
	_eClose2 = [_UL,RydHQH_KnEnemiesG,400] call RYD_CloseEnemyB;
	_tooC2 = _eClose2 select 0;
	_dstEM2 = _eClose2 select 1;
	_eClose3 = [leaderHQH,RydHQH_KnEnemiesG,400] call RYD_CloseEnemyB;
	_tooC3 = _eClose3 select 0;

	if ((_tooC1) or (_tooC2) or (_tooC3) or (((_UL distance [_posX,_posY]) - _dstEM2) > _dstEM1)) then {_EnNearTrg = true}
	};

if (_EnNearTrg) then {_NeNMode = true};
if (not (isNull _GDV) and (_GDV in (RydHQH_NCCargoG + RydHQH_AirG)) and (_NeNMode)) then {_LX1 = (position _UL) select 0;_LY1 = (position _UL) select 1;_halfway = true};

if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1500) and not (isPlayer (leader _unitG))) then
	{
	_LX = (position _UL) select 0;
	_LY = (position _UL) select 1;

	_beh = "SAFE";
	if (_unitG in RydHQH_RAirG) then {_beh = "CARELESS"};
	_spd = "LIMITED";
	_TO = [0,0,0];
	if (_NeNMode) then {_spd = "NORMAL";_TO = [40, 45, 50]};

	_wp0 = [_unitG,[(_posX + _LX)/2,(_posY + _LY)/2],"MOVE",_beh,"GREEN",_spd,["true","deletewaypoint [(group this), 0];"],true,0,_TO] call RYD_WPadd;

	_nW = 2;
	};

_task = [(leader _unitG),["Make a reconnaissance designated area. Identify enemy positions. Avoid detection and engaging in combat.", "Search", ""],[_posX,_posY]] call RYD_AddTask;

_gp = _unitG;
_pos = [_posX,_posY];
if not (isNull _AV) then {_gp = _GDV;_pos = [(_posX + _LX1)/2,(_posY + _LY1)/2]};
_tp = "MOVE";
//if (not (isNull _AV) and (_unitG in RydHQH_NCrewInfG)) then {_tp = "UNLOAD"};
_beh = "SAFE";
if (not (isNull _AV) and (_GDV in RydHQH_AirG) or (_unitG in RydHQH_RAirG)) then {_beh = "CARELESS"};
_spd = "NORMAL";
if ((isNull _AV) and (([_posX,_posY] distance _UL) > 1000) and not (_NeNMode)) then {_spd = "LIMITED"};
_TO = [0,0,0];
if ((isNull _AV) and (([_posX,_posY] distance _UL) <= 1000) or ((_NeNMode) and (isNull _AV))) then {_TO = [40, 45, 50]};
_crr = false;
if ((_nW == 1) and (isNull _AV)) then {_crr = true};
if not (isNull _AV) then {_crr = true};
_sts = ["true","deletewaypoint [(group this), 0];"];
if (((group (assigneddriver _AV)) in RydHQH_AirG) and (_unitG in RydHQH_NCrewInfG)) then {_sts = ["true","(vehicle this) land 'GET OUT';deletewaypoint [(group this), 0]"]};

_wp = [_gp,_pos,_tp,_beh,"GREEN",_spd,_sts,_crr,0.001,_TO] call RYD_WPadd;

_DAV = assigneddriver _AV;

_cause = [_unitG,6,true,600,50,[RydHQH_AirG,RydHQH_KnEnemiesG],false] call RYD_Wait;
_timer = _cause select 0;
_alive = _cause select 1;
_enemy = _cause select 2;

if ((_timer > 50) or (_enemy)) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
if not (_alive) exitwith {if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};

_UL = leader _unitG;if not (isPlayer _UL) then {if (not (_halfway) and (_timer <= 50) and not (_enemy)) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}}};

_pass = assignedCargo _AV;
if (_unitG in RydHQH_NCrewInfG) then {_pass orderGetIn false};
sleep 5;
_alive = true;
if (_halfway) then
	{
	_beh = "AWARE";
	if (_unitG in RydHQH_RAirG) then {_beh = "CARELESS"};
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "STAG COLUMN"};

	_wp = [_unitG,[_posX,_posY],"MOVE",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call RYD_WPadd;

	_cause = [_unitG,6,true,0,30,[],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;

	if not (_alive) exitwith {if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markAttack" + str (_unitG))}};
	if (_timer > 30) then {[_unitG, (currentWaypoint _unitG)] setWaypointPosition [position (vehicle _UL), 0]};
	};

if not (_alive) exitwith {};

_beh = "AWARE";
if (_unitG in RydHQH_RAirG) then {_beh = "CARELESS"};
_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((_halfway) and (_timer <= 30)) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}}};

_wp = [_unitG,[_posX,_posY],"SAD",_beh,"GREEN","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call RYD_WPadd;

_cause = [_unitG,6,true,250,30,[RydHQH_AirG,RydHQH_KnEnemiesG],false] call RYD_Wait;
_alive = _cause select 1;

if not (_alive) exitwith {if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
if ((count (waypoints _unitG)) >= 1) then {deleteWaypoint [_unitG, 1]};

if (_stage >= 4) then {RydHQH_ReconDone = true};

if (_unitG in RydHQH_FOG) then
	{
	_beh = "STEALTH";
	if (_unitG in RydHQH_RAirG) then {_beh = "CARELESS"};
	_frm = formation _unitG;
	if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

	_wp = [_unitG,[_posX,_posY],"MOVE",_beh,"GREEN","LIMITED",["true","deletewaypoint [(group this), 0];"],true,0.001,[0,0,0],_frm] call RYD_WPadd;

	_cause = [_unitG,6,true,150,120,[RydHQH_AirG,RydHQH_KnEnemiesG],false] call RYD_Wait;
	_timer = _cause select 0;
	_alive = _cause select 1;
	_enemy = _cause select 2
	};

if not (_alive) exitwith {if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {_i setMarkerColor "ColorBlue"};

[_unitG] call RYD_WPdel;

_timer2 = 0;

while {(_nothing)} do
	{
	_unitG = group (leader (_this select 0));
	if (((not (isNull (_UL findNearestEnemy _UL)) or (_timer2 > 4)) and not (isNull _unitG) and not (_unitG in RydHQH_FOG)) or ((_timer2 > 40) and not (isNull _unitG))) then
		{
		if (_unitG in RydHQH_NCrewInfG) then {_pass orderGetIn true};
		sleep 15;
		_rd = 0;
		if (_unitG in RydHQH_AirG) then {_End = _PosLand;_rd = 0} else {_End = [((position leaderHQH) select 0) + (random 400) - 200,((position leaderHQH) select 1) + (random 400) - 200];_isWater = surfaceIsWater _End;if (_isWater) then {_End = [((position leaderHQH) select 0) + (random 40) - 20,((position leaderHQH) select 1) + (random 40) - 20]}};

		if (isPlayer (leader _unitG)) then
			{
			if not (isMultiplayer) then
				{
				_task setSimpleTaskDescription ["Return.", "Move", ""];
				_task setSimpleTaskDestination _End
				}
			else
				{
				//[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_End] call RE;
				//[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Return.", "Move", ""]] call RE
				}
			};

		_beh = "SAFE";
		if (_unitG in RydHQH_RAirG) then {_beh = "CARELESS"};
		_sts = ["true", "deletewaypoint [(group this), 0];"];
		if (_unitG in RydHQH_AirG) then {_sts = ["true", "{(vehicle _x) land 'LAND'} foreach (units (group this));deletewaypoint [(group this), 0];"]};

		_wp = [_unitG,_End,"MOVE",_beh,"GREEN","NORMAL",_sts] call RYD_WPadd;

		_unitG setCurrentWaypoint _wp;
		if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))};
		_nothing = false;

		_cause = [_unitG,6,true,0,24,[],false] call RYD_Wait;
		_alive = _cause select 1;

		if (_alive) then
			{
			if (_unitG in (RydHQH_reconG + RydHQH_FOG + RydHQH_snipersG + RydHQH_InfG)) then {RydHQH_ReconAv = RydHQH_ReconAv + [_unitG];};
			_unitG setVariable [("Busy" + (str _unitG)), false];
			[_unitG] call RYD_WPdel;
			if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};
			}
		};

	sleep 15;
	if (isNull _unitG) then {_alive = false};
	if not (_alive) exitwith {if ((RydHQH_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markRecon" + str (_unitG))}};
	_timer2 = _timer2 + 1;
	};

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdEnd,"OrdEnd"] call RYD_AIChatter}};