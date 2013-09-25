
RydHQF_DefDone = false;

_distances = [];

_Trg = leaderHQF;

RydHQF_NearestE = ObjNull;

if (isNil ("RydHQF_Orderfirst")) then {RydHQF_Orderfirst = true;RydHQF_FlankReady = false};

if (RydHQF_NObj == 1) then {RydHQF_Obj = RydHQF_Obj1};
if (RydHQF_NObj == 2) then {RydHQF_Obj = RydHQF_Obj2};
if (RydHQF_NObj == 3) then {RydHQF_Obj = RydHQF_Obj3};
if (RydHQF_NObj >= 4) then {RydHQF_Obj = RydHQF_Obj4};

_Trg = RydHQF_Obj;

_landE = RydHQF_KnEnemiesG - (RydHQF_EnNavalG + RydHQF_EnAirG);
if ((count _landE) > 0) then 
	{

	for [{_a = 0},{_a < (count _landE)},{_a = _a + 1}] do
		{
		_enemy = leader (_landE select _a);
		_distance = leaderHQF distance _enemy;
		_distances = _distances + [_distance];
		};

	RydHQF_NearestE = _landE select 0;

		{
		for [{_r = 0},{_r < (count _distances)},{_r = _r + 1}] do
			{
			_distance = _distances select _r;
			if (isNil ("_distance")) then {_distance = 10000};
			if (_distance <= _x) then {RydHQF_NearestE = _landE select _r};
			if (isNull RydHQF_NearestE) then {RydHQF_NearestE = _landE select 0}
			}
		}
	foreach _distances;

	_Trg = (leader RydHQF_NearestE);
	};
_PosObj1 = position _Trg;
if (isNil ("RydHQF_ReconReserve")) then {RydHQF_ReconReserve = (0.3 * (0.5 + RydHQF_Circumspection))};

RydHQF_ReconAv = [];
_onlyL = RydHQF_LArmorG - RydHQF_MArmorG;

	{
	_unitvar = str _x;
	if (RydHQF_Orderfirst) then {_x setVariable ["Nominal" + _unitvar,(count (units _x)),true]};
	_busy = false;
	_busy = _x getvariable ("Busy" + _unitvar);
	if (isNil ("_busy")) then {_busy = false};
	_vehready = true;
	_solready = true;
	_effective = true;
	_ammo = true;
	_Gdamage = 0;
		{
		_Gdamage = _Gdamage + (damage _x);
		 if ((count (magazines _x)) == 0) exitWith {_ammo = false};
		//_ammo = _ammo + (count (magazines _x));
		if (((damage _x) > 0.5) or not (canStand _x)) exitWith {_effective = false};
		}
	foreach (units _x);
	_nominal = _x getVariable ("Nominal" + (str _x));
	_current = count (units _x);
	_Gdamage = _Gdamage + (_nominal - _current);

	if (((_Gdamage/(_current + 0.1)) > (0.4*((RydHQF_Recklessness/1.2) + 1))) or not (_effective) or not (_ammo)) then 
		{
		_solready = false;
		if not (_ammo) then
			{
			_x setVariable ["LackAmmo",true]
			}
		};

	_ammo = 0;
	_veh = ObjNull;

		{
		_veh = assignedvehicle _x;
		if (not (isNull _veh) and (not (canMove _veh) or ((fuel _veh) <= 0.1) or ((damage _veh) > 0.5) or (((group _x) in ((RydHQF_AirG - (RydHQF_NCAirG + RydHQF_RAirG)) + (RydHQF_HArmorG + RydHQF_LArmorG + (RydHQF_CarsG - (RydHQF_NCCargoG + RydHQF_SupportG))))) and ((count (magazines _veh)) == 0)))) exitwith {_vehready = false};
		}
	foreach (units _x);

	if (not (_x in (RydHQF_ReconAv + RydHQF_SpecForG)) and not (_busy) and (_vehready) and ((_solready) or (_x in RydHQF_RAirG))) then {RydHQF_ReconAv set [(count RydHQF_ReconAv),_x]};
	}
foreach ((RydHQF_RAirG + RydHQF_ReconG + RydHQF_FOG + RydHQF_SnipersG + RydHQF_NCrewInfG - (RydHQF_SupportG + RydHQF_NCCargoG) + _onlyL) - (RydHQF_AOnly + RydHQF_CargoOnly));

RydHQF_ReconAv = [RydHQF_ReconAv] call RYD_RandomOrd;

if (RydHQF_ReconReserve > 0) then 
	{
	_forRRes = (RydHQF_ReconAv - RydHQF_RAirG);
	for [{_b = 0},{_b < (floor ((count _forRRes)*RydHQF_ReconReserve))},{_b = _b + 1}] do
		{
		_RRp = _forRRes select _b;
		RydHQF_ReconAv = RydHQF_ReconAv - [_RRp];
		}
	};

RydHQF_AttackAv = [];
RydHQF_FlankAv = [];

if (isNil ("RydHQF_Exhausted")) then {RydHQF_Exhausted = []};
//if (isNil ("RydHQF_FlankAv")) then {RydHQF_FlankAv = []};

if (isNil ("RydHQF_AttackReserve")) then {RydHQF_AttackReserve = (0.5 * (0.5 + (RydHQF_Circumspection/1.5)))};

	{
	_unitvar = str _x;
	if (RydHQF_Orderfirst) then {_x setVariable [("Nominal" + _unitvar),(count (units _x)),true]};
	_busy = false;
	_busy = _x getvariable ("Busy" + _unitvar);
	if (isNil ("_busy")) then {_busy = false};
	_vehready = true;
	_solready = true;
	_effective = true;
	_ammo = true;
	_Gdamage = 0;
		{
		_Gdamage = _Gdamage + (damage _x);
		if ((count (magazines _x)) == 0) exitWith {_ammo = false};
		if (((damage _x) > 0.5) or not (canStand _x)) exitWith {_effective = false};
		}
	foreach (units _x);
	_nominal = _x getVariable ("Nominal" + (str _x));
	_current = count (units _x);
	_Gdamage = _Gdamage + (_nominal - _current);
	if (((_Gdamage/(_current + 0.1)) > (0.4*((RydHQF_Recklessness/1.2) + 1))) or not (_effective) or not (_ammo)) then {_solready = false};
	_ammo = 0;

		{
		_veh = assignedvehicle _x;
		if (not (isNull _veh) and (not (canMove _veh) or ((fuel _veh) <= 0.1) or ((damage _veh) > 0.5) or (((group _x) in ((RydHQF_AirG - RydHQF_NCAirG) + (RydHQF_HArmorG + RydHQF_LArmorG + (RydHQF_CarsG - (RydHQF_NCCargoG + RydHQF_SupportG))))) and ((count (magazines _veh)) == 0)))) exitwith {_vehready = false};
		}
	foreach (units _x);
	
	if (not (_x in RydHQF_AttackAv) and not (_busy) and not (_x in RydHQF_FlankAv) and (_vehready) and (_solready) and not (_x in (RydHQF_StaticG + RydHQF_ArtG + RydHQF_NavalG + RydHQF_SpecForG + RydHQF_CargoOnly))) then {RydHQF_AttackAv set [(count RydHQF_AttackAv),_x]};
	if (not (_x in RydHQF_Exhausted) and (not (_vehready) or not (_solready))) then {RydHQF_Exhausted = RydHQF_Exhausted + [_x]};
 
	if ((RydHQF_Withdraw > 0) and not (_x in (RydHQF_SpecForG + RydHQF_SnipersG))) then
		{
		_inD = _x getVariable "NearE";
		if (isNil "_inD") then {_inD = 0};
		if (not (_x in RydHQF_Exhausted) and ((random (2 + RydHQF_Recklessness)) < (_inD * RydHQF_Withdraw))) then {RydHQF_Exhausted set [(count RydHQF_Exhausted),_x]}; 
		};
	}
foreach ((RydHQF_Friends - (RydHQF_reconG + RydHQF_FOG + (RydHQF_NCCargoG - RydHQF_NCrewInfG) + RydHQF_SupportG)) - RydHQF_ROnly);
RydHQF_AttackAv = [RydHQF_AttackAv] call RYD_RandomOrd;
if (RydHQF_AttackReserve > 0) then 
	{
	for [{_g = 0},{_g < floor ((count RydHQF_AttackAv)*RydHQF_AttackReserve)},{_g = _g + 1}] do
		{
		_ResC = RydHQF_AttackAv select _g;
		if not (_ResC in RydHQF_FirstToFight) then 
			{
			RydHQF_AttackAv = RydHQF_AttackAv - [_ResC];
			if not (RydHQF_FlankingDone) then {if ((random 100 > (30/(0.5 + RydHQF_Fineness))) and not (_ResC in RydHQF_FlankAv)) then {RydHQF_FlankAv set [(count RydHQF_FlankAv),_ResC]}}
			};
		}
	};

RydHQF_FlankAv = RydHQF_FlankAv - RydHQF_NoFlank;

if (not (RydHQF_FlankingInit) and not (RydHQF_Order == "DEFEND")) then {[] spawn F_Flanking};

_stages = 3;
if ([] call RYD_isNight) then {_stages = 5};

_rcheckArr = [RydHQF_Garrison,RydHQF_ReconAv,RydHQF_FlankAv,RydHQF_AOnly,RydHQF_Exhausted,RydHQF_NCCargoG,_Trg,RydHQF_NCVeh];

if ((RydHQF_NoRec * (RydHQF_Recklessness + 0.01)) < (random 100)) then 
	{
	if ((count RydHQF_KnEnemiesG) == 0) then
		{
		if (not ((count RydHQF_RAirG) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [RydHQF_RAirG,"R",_rcheckArr,20000,true] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		if (not ((count RydHQF_reconG) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [RydHQF_ReconG,"R",_rcheckArr,5000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		if (not ((count RydHQF_FOG) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [RydHQF_FOG,"R",_rcheckArr,5000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		if (not ((count RydHQF_snipersG) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [RydHQF_snipersG,"R",_rcheckArr,5000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		_onlyL = RydHQF_LArmorG - RydHQF_MArmorG;
		if (not ((count _onlyL) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [_onlyL,"R",_rcheckArr,20000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		if (not ((count (RydHQF_NCrewInfG - RydHQF_SpecForG)) == 0) and ((count RydHQF_ReconAv) > 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [(RydHQF_NCrewInfG - RydHQF_SpecForG),"NR",_rcheckArr,10000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			};

		_LMCUA = RydHQF_Friends - (RydHQF_NavalG + RydHQF_StaticG + RydHQF_SupportG + RydHQF_ArtG + RydHQF_AOnly + RydHQF_SpecForG + RydHQF_CargoOnly);
		if (not ((count _LMCUA) == 0) and not (RydHQF_ReconDone) and not (RydHQF_ReconStage > _stages)) then
			{
			_gps = [_LMCUA,"NR",_rcheckArr,20000,false] call RYD_Recon;

				{
				if (RydHQF_ReconStage > _stages) exitWith {};
				RydHQF_ReconStage = RydHQF_ReconStage + 1;_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,RydHQF_ReconStage] spawn F_GoRecon;
				}
			foreach _gps
			}
		}
	}
else
	{
	RydHQF_ReconDone = true
	};

if (isNil ("RydHQF_IdleOrd")) then {RydHQF_IdleOrd = true};

_reserve = RydHQF_Friends - (RydHQF_SpecForG + RydHQF_CargoOnly + RydHQF_AOnly + RydHQF_ROnly + RydHQF_Exhausted + RydHQF_ArtG + RydHQF_AirG + RydHQF_NavalG + RydHQF_StaticG + RydHQF_SupportG + (RydHQF_NCCargoG - (RydHQF_NCrewInfG + RydHQF_SupportG)));
if (not (RydHQF_ReconDone) and ((count RydHQF_KnEnemies) == 0)) exitwith 
	{
	if (RydHQF_Orderfirst) then 
		{
		RydHQF_Orderfirst = false
		};

		{
		_recvar = str _x;
		_resting = false;
		_resting = _x getvariable ("Resting" + _recvar);
		if (isNil ("_resting")) then {_resting = false};
		if not (_resting) then {[_x] spawn F_GoRest }
		}
	foreach (RydHQF_Exhausted - (RydHQF_AirG + RydHQF_StaticG + RydHQF_ArtG + RydHQF_NavalG));

	if (RydHQF_IdleOrd) then
		{
			{
			_recvar = str _x;
			_busy = false;
			_deployed = false;
			_capturing = false;
			_capturing = _x getVariable ("Capt" + _recvar);
			if (isNil ("_capturing")) then {_capturing = false};
			_deployed = _x getvariable ("Deployed" + _recvar);
			_busy = _x getvariable ("Busy" + _recvar);
			if (isNil ("_busy")) then {_busy = false};
			if (isNil ("_deployed")) then {_deployed = false};
			if (not (_busy) and ((count (waypoints _x)) <= 1) and not (_deployed) and not (_capturing) and (not (_x in RydHQF_NCCargoG) or ((count (units _x)) > 1))) then {deleteWaypoint ((waypoints _x) select 0);[_x] spawn F_GoIdle }
			}
		foreach _reserve;
		};

	RydxHQ_Done = true;
	};

RydHQF_FlankReady = true;

_reconthreat = [];
_FOthreat = [];
_snipersthreat = [];
_ATinfthreat = [];
_AAinfthreat = [];
_Infthreat = [];
_Artthreat = [];
_HArmorthreat = [];
_LArmorthreat = [];
_LArmorATthreat = [];
_Carsthreat = [];
_Airthreat = [];
_Navalthreat = [];
_Staticthreat = [];
_StaticAAthreat = [];
_StaticATthreat = [];
_Supportthreat = [];
_Cargothreat = [];
_Otherthreat = [];


	{
	_GE = (group _x);
	_GEvar = str _GE;
	_checked = _GE getvariable ("Checked" + _GEvar);
	if (isNil ("_checked")) then {_GE setvariable [("Checked" + _GEvar),false]};
	_checked = false;

	if ((_x in RydHQF_Enrecon) and not (_GE in _reconthreat) and not (_checked)) then {_reconthreat set [(count _reconthreat),_GE]};
	if ((_x in RydHQF_EnFO) and not (_GE in _FOthreat) and not (_checked)) then {_FOthreat set [(count _FOthreat),_GE]};
	if ((_x in RydHQF_Ensnipers) and not (_GE in _snipersthreat) and not (_checked)) then {_snipersthreat set [(count _snipersthreat),_GE]};
	if ((_x in RydHQF_EnATinf) and not (_GE in _ATinfthreat) and not (_checked)) then {_ATinfthreat set [(count _ATinfthreat),_GE]};
	if ((_x in RydHQF_EnAAinf) and not (_GE in _AAinfthreat) and not (_checked)) then {_AAinfthreat set [(count _AAinfthreat),_GE]};
	if ((_x in RydHQF_EnInf) and not (_GE in _Infthreat) and not (_checked)) then {_Infthreat set [(count _Infthreat),_GE]};
	if ((_x in RydHQF_EnArt) and not (_GE in _Artthreat) and not (_checked)) then {_Artthreat set [(count _Artthreat),_GE]};
	if ((_x in RydHQF_EnHArmor) and not (_GE in _LArmorthreat) and not (_checked)) then {_LArmorthreat set [(count _LArmorthreat),_GE]};
	if ((_x in RydHQF_EnLArmor) and not (_GE in _reconthreat) and not (_checked)) then {_reconthreat set [(count _reconthreat),_GE]};
	if ((_x in RydHQF_EnLArmorAT) and not (_GE in _LArmorATthreat) and not (_checked)) then {_LArmorATthreat set [(count _LArmorATthreat),_GE]};
	if ((_x in RydHQF_EnCars) and not (_GE in _Carsthreat) and not (_checked)) then {_Carsthreat set [(count _Carsthreat),_GE]};
	if ((_x in RydHQF_EnAir) and not (_GE in _Airthreat) and not (_checked)) then {_Airthreat set [(count _Airthreat),_GE]};
	if ((_x in RydHQF_EnNaval) and not (_GE in _Navalthreat) and not (_checked)) then {_Navalthreat set [(count _Navalthreat),_GE]};
	if ((_x in RydHQF_EnStatic) and not (_GE in _Staticthreat) and not (_checked)) then {_Staticthreat set [(count _Staticthreat),_GE]};
	if ((_x in RydHQF_EnStaticAA) and not (_GE in _StaticAAthreat) and not (_checked)) then {_StaticAAthreat set [(count _StaticAAthreat),_GE]};
	if ((_x in RydHQF_EnStaticAT) and not (_GE in _StaticATthreat) and not (_checked)) then {_StaticATthreat set [(count _StaticATthreat),_GE]};
	if ((_x in RydHQF_EnSupport) and not (_GE in _Supportthreat) and not (_checked)) then {_Supportthreat set [(count _Supportthreat),_GE]};
	if ((_x in RydHQF_EnCargo) and not (_GE in _Cargothreat) and not (_checked)) then {_Cargothreat set [(count _Cargothreat),_GE]};

	if ((_x in RydHQF_EnInf) and ((vehicle _x) in RydHQF_EnCargo) and not (_x in RydHQF_EnCrew) and not (_GE in _Infthreat) and not (_checked)) then {_Infthreat set [(count _Infthreat),_GE]};

	if ((isNil ("_checked")) or not (_checked)) then {_GE setVariable [("Checked" + _GEvar), true]};
	}
foreach RydHQF_KnEnemies;

RydHQF_AAthreat = (_AAinfthreat + _StaticAAthreat);
RydHQF_ATthreat = (_ATinfthreat + _StaticATthreat + _HArmorthreat + _LArmorATthreat);
RydHQF_Airthreat = _Airthreat;
_reconthreat = _reconthreat - _Airthreat;

_FPool = 
	[
	RydHQF_snipersG,
	RydHQF_NCrewInfG - RydHQF_SpecForG,
	RydHQF_AirG - (RydHQF_NCAirG + RydHQF_NCrewInfG),
	RydHQF_LArmorG,
	RydHQF_HArmorG,
	RydHQF_CarsG - (RydHQF_ATInfG + RydHQF_AAInfG + RydHQF_SupportG + RydHQF_NCCargoG),
	RydHQF_LArmorATG,
	RydHQF_ATInfG,
	RydHQF_AAInfG,
	RydHQF_Recklessness,
	RydHQF_AttackAv,
	RydHQF_Garrison,
	RydHQF_GarrR,
	RydHQF_FlankAv,
	RydHQF_AirG,
	RydHQF_NCVeh
	];

_constant = [RydHQF_AAthreat,RydHQF_ATthreat,_HArmorthreat + _LArmorATthreat,_FPool];

if (count (_reconthreat + _FOthreat + _snipersthreat) > 0) then 
	{
	([_reconthreat + _FOthreat + _snipersthreat,"Recon","F",0,0,0] + _constant) call RYD_Dispatcher;
	};

if (count _ATinfthreat > 0) then 
	{
	([_ATinfthreat,"ATInf","F",0,0,85] + _constant) call RYD_Dispatcher;
	};

if (count _Infthreat > 0) then 
	{
	([_Infthreat,"Inf","F",75,80,85] + _constant) call RYD_Dispatcher;
	};

if (count (_LArmorthreat + _HArmorthreat) > 0) then 
	{
	([_LArmorthreat + _HArmorthreat,"Armor","F",50,0,85] + _constant) call RYD_Dispatcher;
	};

if (count _Carsthreat > 0) then 
	{
	([_Carsthreat,"Cars","F",75,80,85] + _constant) call RYD_Dispatcher;
	};

if (count _Artthreat > 0) then 
	{
	([_Artthreat,"Art","F",70,75,75] + _constant) call RYD_Dispatcher;
	};

if (count _Airthreat > 0) then 
	{
	([_Airthreat,"Air","F",0,0,75] + _constant) call RYD_Dispatcher;
	};

if (count (_Staticthreat - _Artthreat) > 0) then 
	{
	([_Staticthreat - _Artthreat,"Static","F",75,80,85] + _constant) call RYD_Dispatcher;
	};

/////////////////////////////////////////
// Capture Objective

_Trg = RydHQF_Obj;

	{
	_x setVariable [("Capturing" + (str _x)),[0,0]]
	}
foreach ([RydHQF_Obj1,RydHQF_Obj2,RydHQF_Obj3,RydHQF_Obj4] - [RydHQF_Obj]);

if (isNil ("_Trg")) then {_Trg = leaderHQF};

_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));

if (isNil ("_isAttacked")) then {_isAttacked = [0,0]};

_captCount = _isAttacked select 1;
_isAttacked = _isAttacked select 0;
_captLimit = RydHQF_CaptLimit * (1 + (RydHQF_Circumspection/(2 + RydHQF_Recklessness)));
if ((_isAttacked <= 3) or (_captCount < _captLimit)) then
	{	
	if ((not (RydHQF_NObj > 4) and ((random 100) > ((count RydHQF_KnEnemies)*(5/(0.5 + (2*RydHQF_Recklessness))))) and not 
		(RydHQF_Orderfirst) and 
			((random 100) < ((((count RydHQF_Friends)*(0.5 + RydHQF_Recklessness))/(5*(0.5 + count RydHQF_KnEnemiesG)))*((RydHQF_Cyclecount - 5)*2*(1 + RydHQF_Recklessness))))) or
				(((RydHQF_RapidCapt * (RydHQF_Recklessness + 0.01)) > (random 100)) and (RydHQF_NObj <= 4))) then   
		{
		_checked = [];
		_forCapt = RydHQF_NCrewInfG - (RydHQF_SupportG + RydHQF_SpecForG + RydHQF_CargoOnly + RydHQF_Garrison);
		_forCapt = [_forCapt] call RYD_SizeOrd;
		if (not ((count _forCapt) == 0) and ((count RydHQF_AttackAv) > 0)) then
			{
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
				if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
				_captCount = _isAttacked select 1;
				_isAttacked = _isAttacked select 0;
				if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

					{
					_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
					if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
					_captCount = _isAttacked select 1;
					_isAttacked = _isAttacked select 0;

					if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};
					if (_x in RydHQF_AttackAv) then
						{
						if (((leader _x) distance _Trg) <= _m) then
							{
							if (not (_x in RydHQF_NCCargoG) or ((count (units _x)) > 1)) then 
								{
								_ammo = [_x,RydHQF_NCVeh] call RYD_AmmoCount;
								if (_ammo > 0) then
									{
									_busy = _x getvariable [("Busy" + (str _x)),false];
									if not (_busy) then
										{
										_x setVariable [("Busy" + (str _x)),true];
										_checked set [(count _checked),_x];
										_groupCount = count (units _x);

										switch (_isAttacked) do
											{
											case (4) : {_Trg setvariable [("Capturing" + (str  _Trg)),[5,_captCount + _groupCount]]};
											case (3) : {_Trg setvariable [("Capturing" + (str  _Trg)),[4,_captCount + _groupCount]]};
											case (2) : {_Trg setvariable [("Capturing" + (str  _Trg)),[3,_captCount + _groupCount]]};
											case (1) : {_Trg setvariable [("Capturing" + (str  _Trg)),[2,_captCount + _groupCount]]};
											case (0) : {_Trg setVariable [("Capturing" + (str  _Trg)),[1,_captCount + _groupCount]]};
											};

										[_x,_isAttacked] spawn F_GoCapture;
										}
									}
								}
							}
						}
					}
				foreach _forCapt;
				_forCapt = _forCapt - _checked
				}
			};

		if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

		_LMCU = RydHQF_Friends - ((RydHQF_AirG - RydHQF_NCrewInfG) + RydHQF_SpecForG + RydHQF_CargoOnly + RydHQF_NavalG + RydHQF_StaticG + RydHQF_SupportG + RydHQF_ArtG + RydHQF_Garrison + (RydHQF_NCCargoG - (RydHQF_NCrewInfG - RydHQF_SupportG)));
		_LMCU = [_LMCU] call RYD_SizeOrd;
		if (not ((count _LMCU) == 0) and ((count RydHQF_AttackAv) > 0)) then
			{
			for [{_m = 1000},{_m <= 20000},{_m = _m + 1000}] do
				{
				_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
				if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
				_captCount = _isAttacked select 1;
				_isAttacked = _isAttacked select 0;
				if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

					{
					_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
					if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
					_captCount = _isAttacked select 1;
					_isAttacked = _isAttacked select 0;

					if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};
					if (_x in RydHQF_AttackAv) then
						{
						if (((leader _x) distance _Trg) <= _m) then
							{
							_ammo = [_x,RydHQF_NCVeh] call RYD_AmmoCount;
							if (_ammo > 0) then
								{
								_busy = _x getvariable [("Busy" + (str _x)),false];
								if not (_busy) then
									{
									_x setVariable [("Busy" + (str _x)),true];
									_checked set [(count _checked),_x];
									_groupCount = count (units _x);

									switch (_isAttacked) do
										{
										case (4) : {_Trg setvariable [("Capturing" + (str  _Trg)),[5,_captCount + _groupCount]]};
										case (3) : {_Trg setvariable [("Capturing" + (str  _Trg)),[4,_captCount + _groupCount]]};
										case (2) : {_Trg setvariable [("Capturing" + (str  _Trg)),[3,_captCount + _groupCount]]};
										case (1) : {_Trg setvariable [("Capturing" + (str  _Trg)),[2,_captCount + _groupCount]]};
										case (0) : {_Trg setVariable [("Capturing" + (str  _Trg)),[1,_captCount + _groupCount]]};
										};

									[_x,_isAttacked] spawn F_GoCapture;
									}
								}
							}
						}
					}
				foreach _LMCU;
				_LMCU = _LMCU - _checked
				}
			}
		}
	};

if (RydHQF_IdleOrd) then
	{
	_reserve = RydHQF_Friends - (RydHQF_SpecForG + RydHQF_CargoOnly + RydHQF_AOnly + RydHQF_ROnly + RydHQF_Exhausted + RydHQF_ArtG + RydHQF_AirG + RydHQF_NavalG + RydHQF_StaticG + (RydHQF_NCCargoG - (RydHQF_NCrewInfG + RydHQF_SupportG)));
		
		{
		_recvar = str _x;
		_busy = false;
		_deployed = false;
		_capturing = false;
		_capturing = _x getVariable ("Capt" + _recvar);
		if (isNil ("_capturing")) then {_capturing = false};
		_deployed = _x getvariable ("Deployed" + _recvar);
		_busy = _x getvariable ("Busy" + _recvar);
		if (isNil ("_busy")) then {_busy = false};
		if (isNil ("_deployed")) then {_deployed = false};
		if (not (_busy) and ((count (waypoints _x)) <= 1) and not (_deployed) and not (_capturing) and (not (_x in RydHQF_NCCargoG) or ((count (units _x)) > 1))) then {deleteWaypoint ((waypoints _x) select 0);[_x] spawn F_GoIdle};
		}
	foreach _reserve
	};

	{
	_recvar = str _x;
	_resting = false;
	_resting = _x getvariable ("Resting" + _recvar);
	if (isNil ("_resting")) then {_resting = false};
	if not (_resting) then {[_x] spawn F_GoRest }
	}
foreach (RydHQF_Exhausted - (RydHQF_AirG + RydHQF_StaticG + RydHQF_ArtG + RydHQF_NavalG));

	{
	_GE = (group _x);
	_GEvar = str _GE;
	_GE setvariable [("Checked" + _GEvar),false];
	}
foreach RydHQF_KnEnemies;

if (RydHQF_Orderfirst) then {RydHQF_Orderfirst = false};

RydxHQ_Done = true;