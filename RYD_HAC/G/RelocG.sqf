_expression = "(1 + (2 * Meadow)) * (1 - Forest) * (1 - (0.5 * Trees)) * (1 - (10 * sea)) * (1 - (2 * Houses))";
_radius = 100;
_precision = 20;
_sourcesCount = 1;

waituntil {sleep 1;not (isNil ("RydHQG_NCCargoG"))};

while {not (isNull RydHQG)} do
	{
	sleep 60;
	if (isNull RydHQG) exitWith {};

		{
		sleep 1;
		_LU = leader _x;
		_lastpos = _x getvariable ("START" + (str _x));
		if (isNil ("_lastpos")) then {_x setVariable [("START" + (str _x)),(position (assignedvehicle _LU))]};
		_lastpos = _x getvariable ("START" + (str _x));
		_position = [((position leaderHQG) select 0) + (random 800) - 400,((position leaderHQG) select 1) + (random 800) - 400];
		_Spot = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];
		_Spot = _Spot select 0;
		_Spot = _Spot select 0;

		_posX = _Spot select 0;
		_posY = _Spot select 1;
		
		_isWater = surfaceIsWater [_posX,_posY];

		if (not (_x in RydHQG_AirG) and not
			(_iswater) and
				((_lastpos distance RydHQG_Obj) > 2000) and 
					((_lastpos distance leaderHQG) > 1000) and 
						((isNull (leaderHQG FindNearestEnemy [_posX,_posY])) or (((leaderHQG findNearestEnemy [_posX,_posY]) distance [_posX,_posY]) > 600)) or
							(not (isNull (_LU FindNearestEnemy _LU)) and (((_LU findNearestEnemy _LU) distance _LU) < 500))) then 
			{
			_x setVariable [("START" + (str _x)),[_posX,_posY]];
			};
		}   
	foreach RydHQG_NCCargoG;
	}