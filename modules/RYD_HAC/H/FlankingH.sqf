RydHQH_FlankingInit = true;

sleep 10;

waituntil {sleep 5;(RydHQH_FlankReady and ((count RydHQH_KnEnemies) > 0) and not (RydHQH_DefDone))};

_default = [];
_Epos0 = [];
_Epos1 = [];

if (isNil ("RydHQH_Obj")) then {_default = position leaderHQH} else {_default = position RydHQH_Obj};

sleep (60 * (1 + (leaderHQH distance _default)/1000));

if not ((count RydHQH_KnEnemies) == 0) then 
	{
		{
		_Epos0 = _Epos0 + [((getPosATL _x) select 0)];
		_Epos1 = _Epos1 + [((getPosATL _x) select 1)]
		}
	foreach RydHQH_KnEnemies
	};

_Epos0Max = _default select 0;
_Epos0Min = _default select 0;
_sel0Max = 0;
_sel0Min = 0;

for [{_a = 0},{_a < (count _Epos0)},{_a = _a + 1}] do 
	{
	_EposA = _Epos0 select _a;
	if (_a == 0) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_a == 0) then {_Epos0Max = _EposA;_sel0Max = _a};
	if (_Epos0Min >= _EposA) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_Epos0Max < _EposA) then {_Epos0Max = _EposA;_sel0Max = _a};
	};

_Epos1Max = _default select 1;
_Epos1Min = _default select 1;
_sel1Max = 1;
_sel1Min = 1;

for [{_b = 0},{_b < (count _Epos1)},{_b = _b + 1}] do 
	{
	_EposB = _Epos1 select _b;
	if (_b == 0) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_b == 0) then {_Epos1Max = _EposB;_sel1Max = _b};
	if (_Epos1Min >= _EposB) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_Epos1Max < _EposB) then {_Epos1Max = _EposB;_sel1Max = _b};
	};

_max0Enemy = leaderHQH;
_min0Enemy = leaderHQH;

_max1Enemy = leaderHQH;
_min1Enemy = leaderHQH;

if not (isNil ("RydHQH_Obj")) then 
	{
	_max0Enemy = RydHQH_Obj;
	_min0Enemy = RydHQH_Obj;

	_max1Enemy = RydHQH_Obj;
	_min1Enemy = RydHQH_Obj
	};

if not ((count RydHQH_KnEnemies) == 0) then 
	{
	_max0Enemy = RydHQH_KnEnemies select _sel0Max;
	_min0Enemy = RydHQH_KnEnemies select _sel0Min;

	_max1Enemy = RydHQH_KnEnemies select _sel1Max;
	_min1Enemy = RydHQH_KnEnemies select _sel1Min
	};

_PosMid0 = (_Epos0Min + _Epos0Max)/2;
_PosMid1 = (_Epos1Min + _Epos1Max)/2;

_dX = (_PosMid0) - ((getPosATL leaderHQH) select 0);
_dY = (_Posmid1) - ((getPosATL leaderHQH) select 1);

_angle0 = _dX atan2 _dY;

if (_angle0 < 0) then {_angle0 = _angle0 + 360}; 

_BEnemyPosA = [];
_BEnemyPosB = [];
_BEnemyPos = [];

if ((_angle0 <= 45) or ((_angle0 > 135) and (_angle0 <= 225)) or (_angle0 > 315)) then {_BEnemyPosA = position _min0Enemy;_BEnemyPosB = position _max0Enemy} else {_BEnemyPosA = position _min1Enemy;_BEnemyPosB = position _max1Enemy};

_rnd1 = random 100;_rnd2 = random 100;

_minF = false;
_maxF = false;
_bothF = false;

switch true do
	{
	case ((_rnd1 >= (10/(0.5 + RydHQH_Fineness))) and  (_rnd1 < (55/(0.5 + RydHQH_Fineness))) and (_rnd2 < 50)) : {_minF =  true};
	case ((_rnd1 >= (10/(0.5 + RydHQH_Fineness))) and  (_rnd1 < (55/(0.5 + RydHQH_Fineness))) and (_rnd2 >= 50)) : {_maxF = true};
	case (_rnd1 >= (55/(0.5 + RydHQH_Fineness))) : {_bothF = true};
	};

switch true do
	{
	case (_minF or _maxF) : 
		{
			{
			if (_minF) then {[_x,_BEnemyPosA,_PosMid0,_PosMid1,_angle0,true] spawn H_GoFlank } else {[_x,_BEnemyPosB,_PosMid0,_PosMid1,_angle0,false] spawn H_GoFlank };
			}
		foreach RydHQH_FlankAv;
		
		};
	case (_bothF) : 
		{

		for [{_b = 0},{_b < (count RydHQH_FlankAv)},{_b = _b + 1}] do
			{
			_FlankU = RydHQH_FlankAv select _b;
			if ((_b/2 - floor (_b/2)) == 0) then 
				{
				[_FlankU,_BEnemyPosA,_PosMid0,_PosMid1,_angle0,true] spawn H_GoFlank;
				} 
			else 
				{
				[_FlankU,_BEnemyPosB,_PosMid0,_PosMid1,_angle0,false] spawn H_GoFlank 
				}
			}		
		}
	};

RydHQH_FlankingDone = true;
RydHQH_FlankAv = [];