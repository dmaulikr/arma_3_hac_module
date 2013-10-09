waitUntil 
	{
	sleep 1;
	(RydHQF_Cyclecount > 1)
	};

while {not (isNull RydHQF)} do
	{
	if (isNil ("RydHQF_ResetNow")) then {RydHQF_ResetNow = false};
	if (isNil ("RydHQF_ResetOnDemand")) then {RydHQF_ResetOnDemand = false};
	if (isNil ("RydHQF_ResetTime")) then {RydHQF_ResetTime = 600};
	if not (RydHQF_ResetOnDemand) then {sleep RydHQF_ResetTime} else {waituntil {sleep 1; (RydHQF_ResetNow)};RydHQF_ResetNow = false};
	_Edistance = false;
	
		{
		if ((_x distance leaderHQF) < 2000) exitwith {_Edistance = true};
		}
	foreach RydHQF_KnEnemies;
	RydHQF_ReconDone = false;
	RydHQF_ReconStage = 1;
	if (_Edistance) then
		{
			{
			_LE = (leader _x);
			_LEvar = str _LE;
			_LE setVariable [("Checked" + _LEvar), false]
			}
		foreach (RydHQF_Enemies - RydHQF_KnEnemiesG)
		};

	RydHQF_DefDone = false;

	if (not (RydHQF_Order == "DEFEND") or ((random 100) > 95)) then 
		{
			{
			_x setVariable ["Defending", false];
			_x setvariable ["SPRTD",0];
			_x setvariable ["Reinforcing",GrpNull];
			}
		foreach RydHQF_Friends
		};

	_trg = leaderHQF;
	if (RydHQF_NObj == 1) then {_trg = RydHQF_Obj};
	if (RydHQF_NObj == 2) then {_trg = RydHQF_Obj2};
	if (RydHQF_NObj == 3) then {_trg = RydHQF_Obj3};
	if (RydHQF_NObj >= 4) then {_trg = RydHQF_Obj4};

	if (isNil ("RydHQF_ObjRadius1")) then {RydHQF_ObjRadius1 = 300};
	if (isNil ("RydHQF_ObjRadius2")) then {RydHQF_ObjRadius2 = 500};

	_mLoss = 10;
	if (leaderHQF in (RydBBa_HQs + RydBBb_HQs)) then {_mLoss = 0};

	_lastObj = RydHQF_NObj;

	_lost = ObjNull;
		{
		_AllV20 = _x nearEntities [["AllVehicles"], RydHQF_ObjRadius1];
		_Civs20 = _x nearEntities [["Civilian"], RydHQF_ObjRadius1];

		_AllV2 = [];

			{
			_AllV2 = _AllV2 + (crew _x)
			}
		foreach _AllV20;

		_Civs20 = _trg nearEntities [["Civilian"],RydHQF_ObjRadius2];

		_Civs2 = [];

			{
			_Civs2 = _Civs2 + (crew _x)
			}
		foreach _Civs20;

		_AllV2 = _AllV2 - _Civs2;

		_AllV20 = +_AllV2;

			{
			if not (_x isKindOf "Man") then
				{
				if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]}
				}
			}
		foreach _AllV20;

		_NearEnemies = leaderHQF countenemy _AllV2;
		_AllV0 = _x nearEntities [["AllVehicles"], RydHQF_ObjRadius2];
		_Civs0 = _x nearEntities [["Civilian"], RydHQF_ObjRadius2];

		_AllV = [];

			{
			_AllV = _AllV + (crew _x)
			}
		foreach _AllV0;

		_Civs = [];

			{
			_Civs = _Civs + (crew _x)
			}
		foreach _Civs0;

		_AllV = _AllV - _Civs;
		_AllV0 = +_AllV;

			{
			if not (_x isKindOf "Man") then
				{
				if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]}
				}
			}
		foreach _AllV0;

		_NearAllies = leaderHQF countfriendly _AllV;

		if (_x == _trg) then
			{
			_captLimit = RydHQF_CaptLimit * (1 + (RydHQF_Circumspection/(2 + RydHQF_Recklessness)));
			_enRoute = 0;

				{
				if not (isNull _x) then
					{
					if (_x getVariable [("Capt" + (str _x)),false]) then
						{
						_enRoute = _enRoute + (count (units _x))
						}
					}
				}
			foreach RydHQF_Friends;

			_captDiff = _captLimit - _enRoute;

			if (_captDiff > 0) then
				{	
				_isC = _trg getVariable ("Capturing" + (str _trg));if (isNil "_isC") then {_isC = [0,0]};

				_amountC = _isC select 1;
				_isC = _isC select 0;
				if (_isC > 3) then {_isC = 3};
				_trg setVariable [("Capturing" + (str _trg)),[_isC,_amountC - _captDiff]];
				}
			};

		if (_NearEnemies > _NearAllies) exitwith {_lost = _x};
		}
	foreach [RydHQF_Obj1,RydHQF_Obj2,RydHQF_Obj3,RydHQF_Obj4];
	if (isNull _lost)	then {RydHQF_NObj = RydHQF_NObj} else {
		if (_lost == RydHQF_Obj1) then {RydHQF_NObj = 1;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQF_Obj1,RydHQF_Obj2,RydHQF_Obj3,RydHQF_Obj4])} else {
			if ((_lost == RydHQF_Obj2) and (RydHQF_NObj > 2)) then {RydHQF_NObj = 2;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQF_Obj2,RydHQF_Obj3,RydHQF_Obj4])} else {
				if ((_lost == RydHQF_Obj3) and (RydHQF_NObj > 3)) then {RydHQF_NObj = 3;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQF_Obj3,RydHQF_Obj4])} else {
					if ((_lost == RydHQF_Obj4) and (RydHQF_NObj >= 4)) then {RydHQF_NObj = 4;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQF_Obj4])}}}}};

	if (RydHQF_NObj < 1) then {RydHQF_NObj = 1};
	if (RydHQF_NObj > 5) then {RydHQF_NObj = 5};
	
	RydHQF_Progress = 0;
	if (_lastObj > RydHQF_NObj) then {RydHQF_Progress = -1;RydHQF_Morale = RydHQF_Morale - _mLoss};	
	if (_lastObj < RydHQF_NObj) then {RydHQF_Progress = 1};

	_reserve = RydHQF_Friends - (RydHQF_ArtG + (RydHQF_AirG - RydHQF_SupportG) + RydHQF_NavalG + RydHQF_StaticG + RydHQF_CargoOnly);

		{
		_x setVariable [("Deployed" + (str _x)),false];
		}
	foreach _reserve;

		{
		if ((random 100) > 95) then {_x setVariable [("Garrisoned" + (str _x)),false]};
		}
	foreach RydHQF_Garrison;

	if (isNil ("RydHQF_Combining")) then {RydHQF_Combining = false};
	if (RydHQF_Combining) then 
		{
		_exhausted = +RydHQF_Exhausted;
			{
			if (not (isNull _x) and ((count (units _x)) >= 1)) then 
				{
				_unitvar = str _x;
				_nominal = _x getVariable ("Nominal" + (str _x));if (isNil "_nominal") then {_x setVariable ["Nominal" + _unitvar,(count (units _x))];_nominal = _x getVariable ("Nominal" + (str _x))};
				if (isNil ("_nominal")) then {_x setVariable [("Nominal" + _unitvar),(count (units _x))];_nominal = _x getVariable ("Nominal" + (str _x))};
				_current = count (units _x);
				if (((_nominal/(_current + 0.1)) > 2) and (isNull (assignedVehicle (leader _x)))) then 
					{
					_ex = (RydHQF_Exhausted - [_x]);
					for [{_a = 0},{(_a < (count _ex))},{_a = _a + 1}] do
						{
						_Aex = _ex select _a;
						_unitvarA = str _Aex;
						_nominalA = _Aex getVariable ("Nominal" + (str _Aex));
						if (isNil ("_nominal")) then {_Aex setVariable [("Nominal" + _unitvarA),(count (units _Aex)),true];_nominalA = _Aex getVariable ("Nominal" + (str _Aex))};
						_currentA = count (units _Aex);
						if (((_nominalA/(_currentA + 0.1)) > 2) and (isNull (assignedVehicle (leader _Aex))) and (((vehicle (leader _x)) distance (vehicle (leader _Aex))) < 200)) then 
							{
							(units _x) joinsilent _Aex;
							sleep 0.05;
							_Aex setVariable [("Nominal" + (str _Aex)),(count (units _Aex)),true];
							};
						};
					};
				}
			else
				{
				_exhausted = _exhausted - [_x]
				};
			}
		foreach RydHQF_Exhausted;
		RydHQF_Exhausted = _exhausted;
		};
	};