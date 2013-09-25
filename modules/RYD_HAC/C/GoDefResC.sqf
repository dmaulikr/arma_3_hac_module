_i = "";

_unitG = _this select 0;_Spos = _unitG getvariable ("START" + (str _unitG));if (isNil ("_Spos")) then {_unitG setVariable [("START" + (str _unitG)),(position (vehicle (leader _unitG)))];_Spos = _unitG getVariable ("START" + (str _unitG))};
_DefPos = _this select 1;if (_unitG in RydHQC_Garrison) exitwith {RydHQC_DefSpot = RydHQC_DefSpot - [_unitG];RydHQC_GoodSpots = RydHQC_GoodSpots + [_DefPos];RydHQC_Roger = true};

_ammo = [_unitG,RydHQC_NCVeh] call RYD_AmmoCount;

if (_ammo == 0) exitwith {RydHQC_DefSpot = RydHQC_DefSpot - [_unitG];RydHQC_GoodSpots = RydHQC_GoodSpots + [_DefPos];RydHQC_Roger = true};

_unitvar = str _unitG;
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) and ((_unitG in RydHQC_DefSpot) or (_unitG in RydHQC_Def))) exitwith {RydHQC_Roger = true};

[_unitG] call RYD_WPdel;

_attackAllowed = attackEnabled _unitG;
_unitG enableAttack false;

_unitG setVariable [("Deployed" + (str _unitG)),false];_unitG setVariable [("Capt" + (str _unitG)),false];
_unitG setVariable [("Busy" + _unitvar), true];
_unitG setVariable ["Defending", true];

_posX = (_DefPos select 0) + (random 40) - 20;
_posY = (_DefPos select 1) + (random 40) - 20;
_DefPos = [_posX,_posY];

_isWater = surfaceIsWater _DefPos;

while {((_isWater) and (leaderHQC distance _DefPos >= 10))} do
	{
	_PosX = ((_DefPos select 0) + ((position leaderHQC) select 0))/2;
	_PosY = ((_DefPos select 1) + ((position leaderHQC) select 1))/2;
	_DefPos = [_posX,_posY]
	};

if ((_unitG in RydHQC_NCCargoG) and ((count (units _unitG)) <= 1)) then
	{
	_PosX = ((position leaderHQC) select 0) + (random 200) - 100;
	_PosY = ((position leaderHQC) select 1) + (random 200) - 100;
	_DefPos = [_posX,_posY]
	};

_isWater = surfaceIsWater _DefPos;

if (_isWater) exitwith {RydHQC_DefSpot = RydHQC_DefSpot - [_unitG];RydHQC_Roger = true;_unitG setVariable [("Busy" + (str _unitG)),false]};

if ((isPlayer (leader _unitG)) and (RydxHQ_GPauseActive)) then {hintC "New orders from HQ!";setAccTime 1};

_UL = leader _unitG;

RydHQC_Roger = true;

_nE = _UL findnearestenemy _UL;

if not (isNull _nE) then
	{
	if ((RydHQC_Smoke) and ((_nE distance (vehicle _UL)) <= 500) and not (isPlayer _UL)) then
		{
		_posSL = getPosASL _UL;
		_posSL2 = getPosASL _nE;

		_angle = [_posSL,_posSL2,15] call RYD_AngTowards;

		_dstB = _posSL distance _posSL2;
		_pos = [_posSL,_angle,_dstB/4 + (random 100) - 50] call RYD_PosTowards2D;

		_CFF = false;

		if (RydHQC_ArtyShells > 0) then
			{
			_CFF = ([_pos,RydHQC_ArtG,"SMOKE",9,_UL] call RYD_ArtyMission) select 0;
			if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_SmokeReq,"SmokeReq"] call RYD_AIChatter}};
			};

		if (_CFF) then
			{
			if (RydHQC_ArtyShells > 0) then {if ((random 100) < RydxHQ_AIChatDensity) then {[leaderHQC,RydxHQ_AIC_ArtAss,"ArtAss"] call RYD_AIChatter}};
			sleep 60
			}
		else
			{
			if (RydHQC_ArtyShells > 0) then {if ((random 100) < RydxHQ_AIChatDensity) then {[leaderHQC,RydxHQ_AIC_ArtDen,"ArtDen"] call RYD_AIChatter}};
			[_unitG] call RYD_Smoke;
			sleep 10;
			if ((vehicle _UL) == _UL) then {sleep 20}
			}
		}
	};

_UL = leader _unitG;
RydHQC_VCDone = false;
if (isPlayer _UL) then {[_UL,leaderHQC] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(RydHQC_VCDone)}} else {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdConf,"OrdConf"] call RYD_AIChatter}};

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then
	{
	_i = [_DefPos,_unitG,"markDef","ColorRedAlpha","ICON","mil_dot","DRes C"," - DEFEND POSITION"] call RYD_Mark
	};

_AV = assignedVehicle _UL;

_task = [(leader _unitG),["Take a defensive position as fast as possible. Be ready for reinforcement task. ", "Sentry", ""],_DefPos] call RYD_AddTask;

_tp = "MOVE";
//if ((_unitG in (RydHQC_CargoG)) or (not (isNull _AV) and not (_unitG == (group (assigneddriver _AV))))) then {_tp = "UNLOAD"};

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "FILE"};

_wp = [_unitG,_DefPos,_tp,"AWARE","GREEN","FULL",["true","deletewaypoint [(group this), 0];"],true,0,[0,0,0],_frm] call RYD_WPadd;

if not (RydHQC_Order == "DEFEND") then {_unitG setVariable [("Busy" + _unitvar), false];};

_cause = [_unitG,6,true,0,24,[],false] call RYD_Wait;
_alive = _cause select 1;

if not (_alive) exitwith {if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + str (_unitG))};RydHQC_DefSpot = RydHQC_DefSpot - [_unitG]};

if ((_unitG in (RydHQC_CargoG - (RydHQC_HArmorG + RydHQC_LArmorG + RydHQC_SupportG + (RydHQC_CarsG - RydHQC_NCCargoG)))) or (not (isNull _AV) and not (_unitG == (group (assigneddriver _AV))))) then {(units _unitG) orderGetIn false};

_frm = formation _unitG;
if not (isPlayer (leader _unitG)) then {_frm = "WEDGE"};

_wp = [_unitG,_DefPos,"SENTRY","COMBAT","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],true,0,[0,0,0],_frm] call RYD_WPadd;

_TED = position leaderHQC;

_dX = 2000 * (sin RydHQC_Angle);
_dY = 2000 * (cos RydHQC_Angle);

_posX = ((getPos leaderHQC) select 0) + _dX + (random 2000) - 1000;
_posY = ((getPos leaderHQC) select 1) + _dY + (random 2000) - 1000;

_TED = [_posX,_posY];

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then
	{
	_i = [_TED,_unitG,"markWatch","ColorGreenAlpha","ICON","mil_dot","C","C",[0.2,0.2]] call RYD_Mark
	};

_dir = [(getPosATL (vehicle (leader _unitG))),_TED,10] call RYD_AngTowards;
if (_dir < 0) then {_dir = _dir + 360};

_unitG setFormDir _dir;

(units _unitG) doWatch _TED;

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdFinal,"OrdFinal"] call RYD_AIChatter}};

_unitG setVariable ["Reinforcing",GrpNull];

if (_attackAllowed) then {_unitG enableAttack true};

[_unitG,RydHQC_Flare,RydHQC_ArtG,RydHQC_ArtyShells,leaderHQC] spawn RYD_Flares;

_alive = true;
_endThis = false;
_suppHQ = false;

_chosen = GrpNull;
_mpl = 1;

waituntil
	{
	sleep (60 + (random 60));

	_HQinDanger = false;

	_sumD = 0;
	_HQpos = position leaderHQC;
	_dstAv = 0;

		{
		_VLdr = vehicle (leader _x);
		_dstAct = _VLdr distance _HQpos;
		_sumD = _sumD + _dstAct
		}
	foreach RydHQC_Friends;

	if (_sumD > 0) then {_dstAv = _sumD/(count RydHQC_Friends)};

	_tooClose = [];

		{
		_VLdr = vehicle (leader _x);
		if ((_VLdr distance _HQpos) < _dstAv) then {_tooClose set [(count _tooClose),_x]}
		}
	foreach RydHQC_KnEnemiesG;

	_HQsupporting = 0;

	if ((count _tooClose) > 0) then
		{
		_HQinDanger = true;
		_HQsupporting = RydHQC getVariable "SPRTD";
		if (isNil "_HQsupporting") then {_HQsupporting = 0}
		};

	_HQchance = (80 - (_HQsupporting * 20))/(1 + (RydHQC_Recklessness * 0.5));
	if (_HQchance < 2) then {_HQchance = 2};

	if ((_HQinDanger) and ((random 100) < _HQchance)) then
		{
		_suppHQ = true;
		if ((random 100) > 50) then
			{
			_chosen = _tooClose select 0;
			_dstM = (vehicle (leader _chosen)) distance (vehicle _UL);
				{
				_dstAct = (vehicle (leader _x)) distance (vehicle _UL);
				if (_dstAct < _dstM) then {_dstM = _dstAct;_chosen = _x}
				}
			foreach _tooClose;
			}
		else
			{
			_chosen = _tooClose select (floor (random (count _tooClose)));
			};

		_unitG setVariable ["Reinforcing",RydHQC];
		RydHQC setVariable ["SPRTD",_HQsupporting + 1]
		}
	else
		{
		_ToReinf = RydHQC_Friends - (RydHQC_AirG + RydHQC_DefRes);

		_nE = _UL findNearestEnemy (vehicle _UL);
		_dstC = _nE distance (vehicle _UL);
		if ((_dstC > 750) or (_nE isKindOf "Air")) then {_nE = ObjNull};

		if not (isNull _nE) then
			{
			_mpl = (_mpl/1500) * _dstC
			}
		else
			{
			_mpl = _mpl + 0.1;
			if (_mpl > 1) then {_mpl = 1};
			};

		_chosen = GrpNull;
		_potential = GrpNull;
		_dngMx = 0;
		_danger = 0;

			{
			_danger = _x getVariable "NearE";
			if (isNil "_danger") then {_danger = 0;_x setVariable ["NearE",0]};
			_spt = _x getVariable "SPRTD";
			if (isNil "_spt") then {_spt = 0;_x setVariable ["SPRTD",0]};
			if (_spt < 0) then {_spt = 0;_x setVariable ["SPRTD",0]};
			_danger = _danger/(1 + _spt);

			if (_danger > 0.04) then
				{
				_dst = (vehicle (leader _x)) distance (vehicle _UL);
				_dngAct = _danger/(_dst + 1);
				if (_dngAct > _dngMx) then
					{
					_dngMx = _dngAct;
					_potential = _x
					}
				}
			}
		foreach _ToReinf;

		if (not (isNull _potential) and (alive (leader _potential))) then
			{
			_already = 1;
			_danger = _potential getVariable ["NearE",0];
			_spt = _potential getVariable ["SPRTD",0];
			_danger = _danger/(1 + _spt);
			_lastOne = _unitG getVariable ["Reinforcing",objNull];
			if (not (isNull _lastOne) and (alive (leader _lastOne))) then {_already = (0.2/(1 + (_lastOne getVariable ["NearE",0])))};
			_reinfChance = _mpl * _danger * 2 * _already;
			if (_reinfChance > 0.85) then {_reinfChance = 0.85};

			if ((random 1) < _reinfChance) then
				{
				_spt = _potential getVariable "SPRTD";
				_potential setVariable ["SPRTD",_spt + 1];
				_chosen = _potential;
				if not (isNull _lastOne) then {_lastOne setVariable ["SPRTD",(_lastOne getVariable "SPRTD") - 1]};
				_unitG setVariable ["Reinforcing",_chosen];
				}
			}
		};

	if not (isNull _chosen) then
		{
		[_unitG] call RYD_WPdel;

		(units _unitG) doWatch ObjNull;
		_RnfP = [((position (vehicle (leader _chosen))) select 0) + (random 100) - 50,((position (vehicle (leader _chosen))) select 1) + (random 100) - 50];

		if (isPlayer (leader _unitG)) then
			{
			if not (isMultiplayer) then
				{
				_task setSimpleTaskDescription ["Reinforce defense of designated position.", "Move", ""];
				_task setSimpleTaskDestination _RnfP
				}
			else
				{
				[(leader _unitG),nil, "per", rSETSIMPLETASKDESTINATION, _task,_RnfP] call RE;
				[(leader _unitG),nil, "per", rSETSIMPLETASKDESCRIPTION, _task,["Reinforce defense of designated position.", "Move", ""]] call RE
				}
			};

		_tp = "MOVE";
		if (_suppHQ) then {_tp = "SAD"};

		if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdConf,"OrdConf"] call RYD_AIChatter};

		_wp = [_unitG,_RnfP,_tp] call RYD_WPadd;

		if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then
			{
			_i = [_RnfP,_unitG,"markReinf","ColorRedAlpha","ICON","mil_dot","Reinf C"," - REINFORCE POSITION",[0.3,0.3]] call RYD_Mark
			}
		};


	if not (_unitG getVariable "Defending") then {_endThis = true};
	if ((isNull _unitG) or (isNull RydHQC)) then {_endThis = true;_alive = false};
	if not (alive (leader _unitG)) then {_endThis = true;_alive = false};

	(_endThis)
	};

if not (_alive) exitWith
	{
	if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then
		{
		deleteMarker ("markDef" + _unitVar);
		deleteMarker ("markWatch" + _unitVar);
		deleteMarker ("markReinf" + _unitVar)
		};

	RydHQC_Def = RydHQC_Def - [_unitG];
	if (not (isNull _chosen) and not ((_chosen getVariable "SPRTD") <= 0)) then {_chosen setVariable ["SPRTD",(_chosen getVariable "SPRTD") - 1]};
	};

if ((isPlayer (leader _unitG)) and not (isMultiplayer)) then {(leader _unitG) removeSimpleTask _task};

if ((RydHQC_Debug) or (isPlayer (leader _unitG))) then {deleteMarker ("markDef" + (str _unitG));deleteMarker ("markWatch" + (str _unitG));deleteMarker ("markReinf" + (str _unitG))};

(units _unitG) doWatch ObjNull;
(units _unitG) orderGetIn true;
RydHQC_Def = RydHQC_Def - [_unitG];

if (not (isNull _chosen) and not ((_chosen getVariable "SPRTD") <= 0)) then {_chosen setVariable ["SPRTD",(_chosen getVariable "SPRTD") - 1]};

_unitG setVariable [("Busy" + _unitvar), false];

_UL = leader _unitG;if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_OrdEnd,"OrdEnd"] call RYD_AIChatter}};