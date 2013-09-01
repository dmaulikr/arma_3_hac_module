waitUntil 
	{
	sleep 1;
	(RydHQC_Cyclecount > 1)
	};

while {not (isNull RydHQC)} do
	{
	if (isNil ("RydHQC_ResetNow")) then {RydHQC_ResetNow = false};
	if (isNil ("RydHQC_ResetOnDemand")) then {RydHQC_ResetOnDemand = false};
	if (isNil ("RydHQC_ResetTime")) then {RydHQC_ResetTime = 600};
	if not (RydHQC_ResetOnDemand) then {sleep RydHQC_ResetTime} else {waituntil {sleep 1; (RydHQC_ResetNow)};RydHQC_ResetNow = false};
	_Edistance = false;
	
		{
		if ((_x distance leaderHQC) < 2000) exitwith {_Edistance = true};
		}
	foreach RydHQC_KnEnemies;
	RydHQC_ReconDone = false;
	RydHQC_ReconStage = 1;
	if (_Edistance) then
		{
			{
			_LE = (leader _x);
			_LEvar = str _LE;
			_LE setVariable [("Checked" + _LEvar), false]
			}
		foreach (RydHQC_Enemies - RydHQC_KnEnemiesG)
		};

	RydHQC_DefDone = false;

	if (not (RydHQC_Order == "DEFEND") or ((random 100) > 95)) then 
		{
			{
			_x setVariable ["Defending", false];
			_x setvariable ["SPRTD",0];
			_x setvariable ["Reinforcing",GrpNull];
			}
		foreach RydHQC_Friends
		};

	_trg = leaderHQC;
	if (RydHQC_NObj == 1) then {_trg = RydHQC_Obj};
	if (RydHQC_NObj == 2) then {_trg = RydHQC_Obj2};
	if (RydHQC_NObj == 3) then {_trg = RydHQC_Obj3};
	if (RydHQC_NObj >= 4) then {_trg = RydHQC_Obj4};

	if (isNil ("RydHQC_ObjRadius1")) then {RydHQC_ObjRadius1 = 300};
	if (isNil ("RydHQC_ObjRadius2")) then {RydHQC_ObjRadius2 = 500};

	_mLoss = 10;
	if (leaderHQC in (RydBBa_HQs + RydBBb_HQs)) then {_mLoss = 0};

	_lastObj = RydHQC_NObj;

	_lost = ObjNull;
		{
		_AllV20 = _x nearEntities [["AllVehicles"], RydHQC_ObjRadius1];
		_Civs20 = _x nearEntities [["Civilian"], RydHQC_ObjRadius1];

		_AllV2 = [];

			{
			_AllV2 = _AllV2 + (crew _x)
			}
		foreach _AllV20;

		_Civs20 = _trg nearEntities [["Civilian"],RydHQC_ObjRadius2];

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

		_NearEnemies = leaderHQC countenemy _AllV2;
		_AllV0 = _x nearEntities [["AllVehicles"], RydHQC_ObjRadius2];
		_Civs0 = _x nearEntities [["Civilian"], RydHQC_ObjRadius2];

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

		_NearAllies = leaderHQC countfriendly _AllV;

		if (_x == _trg) then
			{
			_captLimit = RydHQC_CaptLimit * (1 + (RydHQC_Circumspection/(2 + RydHQC_Recklessness)));
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
			foreach RydHQC_Friends;

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
	foreach [RydHQC_Obj1,RydHQC_Obj2,RydHQC_Obj3,RydHQC_Obj4];
	if (isNull _lost)	then {RydHQC_NObj = RydHQC_NObj} else {
		if (_lost == RydHQC_Obj1) then {RydHQC_NObj = 1;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQC_Obj1,RydHQC_Obj2,RydHQC_Obj3,RydHQC_Obj4])} else {
			if ((_lost == RydHQC_Obj2) and (RydHQC_NObj > 2)) then {RydHQC_NObj = 2;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQC_Obj2,RydHQC_Obj3,RydHQC_Obj4])} else {
				if ((_lost == RydHQC_Obj3) and (RydHQC_NObj > 3)) then {RydHQC_NObj = 3;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQC_Obj3,RydHQC_Obj4])} else {
					if ((_lost == RydHQC_Obj4) and (RydHQC_NObj >= 4)) then {RydHQC_NObj = 4;{_x setVariable [("Capturing" + (str _x)),[0,0]]}foreach ([RydHQC_Obj4])}}}}};

	if (RydHQC_NObj < 1) then {RydHQC_NObj = 1};
	if (RydHQC_NObj > 5) then {RydHQC_NObj = 5};
	
	RydHQC_Progress = 0;
	if (_lastObj > RydHQC_NObj) then {RydHQC_Progress = -1;RydHQC_Morale = RydHQC_Morale - _mLoss};	
	if (_lastObj < RydHQC_NObj) then {RydHQC_Progress = 1};

	_reserve = RydHQC_Friends - (RydHQC_ArtG + (RydHQC_AirG - RydHQC_SupportG) + RydHQC_NavalG + RydHQC_StaticG + RydHQC_CargoOnly);

		{
		_x setVariable [("Deployed" + (str _x)),false];
		}
	foreach _reserve;

		{
		if ((random 100) > 95) then {_x setVariable [("Garrisoned" + (str _x)),false]};
		}
	foreach RydHQC_Garrison;

	if (isNil ("RydHQC_Combining")) then {RydHQC_Combining = false};
	if (RydHQC_Combining) then 
		{
		_exhausted = +RydHQC_Exhausted;
			{
			if (not (isNull _x) and ((count (units _x)) >= 1)) then 
				{
				_unitvar = str _x;
				_nominal = _x getVariable ("Nominal" + (str _x));
				if (isNil ("_nominal")) then {_x setVariable [("Nominal" + _unitvar),(count (units _x)),true];_nominal = _x getVariable ("Nominal" + (str _x))};
				_current = count (units _x);
				if (((_nominal/(_current + 0.1)) > 2) and (isNull (assignedVehicle (leader _x)))) then 
					{
					_ex = (RydHQC_Exhausted - [_x]);
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
		foreach RydHQC_Exhausted;
		RydHQC_Exhausted = _exhausted;
		};
	};