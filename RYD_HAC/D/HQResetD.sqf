waitUntil 
	{
	sleep 1;
	(RydHQD_Cyclecount > 1)
	};

while {not (isNull RydHQD)} do
	{
	if (isNil ("RydHQD_ResetNow")) then {RydHQD_ResetNow = false};
	if (isNil ("RydHQD_ResetOnDemand")) then {RydHQD_ResetOnDemand = false};
	if (isNil ("RydHQD_ResetTime")) then {RydHQD_ResetTime = 600};
	if not (RydHQD_ResetOnDemand) then {sleep RydHQD_ResetTime} else {waituntil {sleep 1; (RydHQD_ResetNow)};RydHQD_ResetNow = false};
	_Edistance = false;
	
		{
		if ((_x distance leaderHQD) < 2000) exitwith {_Edistance = true};
		}
	foreach RydHQD_KnEnemies;
	RydHQD_ReconDone = false;
	RydHQD_ReconStage = 1;
	if (_Edistance) then
		{
			{
			_LE = (leader _x);
			_LEvar = str _LE;
			_LE setVariable [("Checked" + _LEvar), false]
			}
		foreach (RydHQD_Enemies - RydHQD_KnEnemiesG)
		};

	RydHQD_DefDone = false;

	if (not (RydHQD_Order == "DEFEND") or ((random 100) > 95)) then 
		{
			{
			_x setVariable ["Defending", false];
			_x setvariable ["SPRTD",0];
			_x setvariable ["Reinforcing",GrpNull];
			}
		foreach RydHQD_Friends
		};

	_trg = leaderHQD;
	if (RydHQD_NObj == 1) then {_trg = RydHQD_Obj};
	if (RydHQD_NObj == 2) then {_trg = RydHQD_Obj2};
	if (RydHQD_NObj == 3) then {_trg = RydHQD_Obj3};
	if (RydHQD_NObj >= 4) then {_trg = RydHQD_Obj4};

	if (isNil ("RydHQD_ObjRadius1")) then {RydHQD_ObjRadius1 = 300};
	if (isNil ("RydHQD_ObjRadius2")) then {RydHQD_ObjRadius2 = 500};

	_mLoss = 10;
	if (leaderHQD in (RydBBa_HQs + RydBBb_HQs)) then {_mLoss = 0};

	_lastObj = RydHQD_NObj;

	_lost = ObjNull;
		{
		_AllV20 = _x nearEntities [["AllVehicles"], RydHQD_ObjRadius1];
		_Civs20 = _x nearEntities [["Civilian"], RydHQD_ObjRadius1];

		_AllV2 = [];

			{
			_AllV2 = _AllV2 + (crew _x)
			}
		foreach _AllV20;

		_Civs20 = _trg nearEntities [["Civilian"],RydHQD_ObjRadius2];

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

		_NearEnemies = leaderHQD countenemy _AllV2;
		_AllV0 = _x nearEntities [["AllVehicles"], RydHQD_ObjRadius2];
		_Civs0 = _x nearEntities [["Civilian"], RydHQD_ObjRadius2];

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

		_NearAllies = leaderHQD countfriendly _AllV;

		if (_x == _trg) then
			{
			_captLimit = RydHQD_CaptLimit * (1 + (RydHQD_Circumspection/(2 + RydHQD_Recklessness)));
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
			foreach RydHQD_Friends;

			_captDiff = _captLimit - _enRoute;

			if (_captDiff > 0) then
				{	
				_isC = _trg getVariable ("Capturing" + (str _trg));

				_amountC = _isC select 1;
				_isC = _isC select 0;
				if (_isC > 3) then {_isC = 3};
				_trg setVariable [("Capturing" + (str _trg)),[_isC,_amountC - _captDiff]];
				}
			};

		if (_NearEnemies > _NearAllies) exitwith {_lost = _x};
		}
	foreach [RydHQD_Obj1,RydHQD_Obj2,RydHQD_Obj3,RydHQD_Obj4];
	if (isNull _lost)	then {RydHQD_NObj = RydHQD_NObj} else {
		if (_lost == RydHQD_Obj1) then {RydHQD_NObj = 1;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQD_Obj1,RydHQD_Obj2,RydHQD_Obj3,RydHQD_Obj4])} else {
			if ((_lost == RydHQD_Obj2) and (RydHQD_NObj > 2)) then {RydHQD_NObj = 2;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQD_Obj2,RydHQD_Obj3,RydHQD_Obj4])} else {
				if ((_lost == RydHQD_Obj3) and (RydHQD_NObj > 3)) then {RydHQD_NObj = 3;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQD_Obj3,RydHQD_Obj4])} else {
					if ((_lost == RydHQD_Obj4) and (RydHQD_NObj >= 4)) then {RydHQD_NObj = 4;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQD_Obj4])}}}}};

	if (RydHQD_NObj < 1) then {RydHQD_NObj = 1};
	if (RydHQD_NObj > 5) then {RydHQD_NObj = 5};
	
	RydHQD_Progress = 0;
	if (_lastObj > RydHQD_NObj) then {RydHQD_Progress = -1;RydHQD_Morale = RydHQD_Morale - _mLoss};	
	if (_lastObj < RydHQD_NObj) then {RydHQD_Progress = 1};

	_reserve = RydHQD_Friends - (RydHQD_ArtG + (RydHQD_AirG - RydHQD_SupportG) + RydHQD_NavalG + RydHQD_StaticG + RydHQD_CargoOnly);

		{
		_x setVariable [("Deployed" + (str _x)),false];
		}
	foreach _reserve;

		{
		if ((random 100) > 95) then {_x setVariable [("Garrisoned" + (str _x)),false]};
		}
	foreach RydHQD_Garrison;

	if (isNil ("RydHQD_Combining")) then {RydHQD_Combining = false};
	if (RydHQD_Combining) then 
		{
		_exhausted = +RydHQD_Exhausted;
			{
			if (not (isNull _x) and ((count (units _x)) >= 1)) then 
				{
				_unitvar = str _x;
				_nominal = _x getVariable ("Nominal" + (str _x));
				if (isNil ("_nominal")) then {_x setVariable [("Nominal" + _unitvar),(count (units _x)),true];_nominal = _x getVariable ("Nominal" + (str _x))};
				_current = count (units _x);
				if (((_nominal/(_current + 0.1)) > 2) and (isNull (assignedVehicle (leader _x)))) then 
					{
					_ex = (RydHQD_Exhausted - [_x]);
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
		foreach RydHQD_Exhausted;
		RydHQD_Exhausted = _exhausted;
		};
	};