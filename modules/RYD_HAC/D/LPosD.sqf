waituntil {sleep 15; (RydHQD_Cyclecount > 2)};

if (isNil "RydHQD_AirDist") then {RydHQD_AirDist = 4000};

while {not (isNull RydHQD)} do 
	{
	sleep 61;
		{
		_veh = vehicle (leader _x);
		_pos = getPosATL _veh;
		_start = _x getvariable ("START" + str (_x));
		if (isNil ("_start")) then {_x setVariable [("START" + str (_x)),_pos];sleep 0.05;_start = _x getvariable ("START" + str (_x))};
		_ammo = count (magazines _veh);
		if not (isPlayer (leader _x)) then 
			{
			if (not (_x in (RydHQD_RAirG + RydHQD_NCAirG)) and (_ammo == 0) and (((getposATL _veh) select 2) > 5)) then
				{
				_rest = _x getVariable ("Resting" + (str _x));
				if (isNil ("_rest")) then {_rest = false};
				if not (_rest) then {_x setVariable [("Busy" + (str _x)),false]};
				[_x] call RYD_WPdel;

				_wp = [_x,_start,"MOVE","CARELESS","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"]] call RYD_WPadd;

				RydHQD_Exhausted = RydHQD_Exhausted + [_x];
				}
			else
				{
				if (RydHQD_LZ) then
					{
					if not (_x getVariable [("Resting" + (str _x)),false]) then
						{
						if not (_x getVariable [("Busy" + (str _x)),false]) then
							{
							_dst = (leader RydHQD) distance _start;
							if (_dst > RydHQD_AirDist) then
								{
								_newPos = [getPosATL (leader RydHQD),300] call RYD_RandomAround;
								_lz = [_newPos] call RYD_LZ;
								if not (isNull _lz) then
									{
									_start = getPosATL _lz;
									_x setVariable [("START" + str (_x)),_start];
									_x getVariable [("Busy" + (str _x)),true];
									_wp = [_x,_start,"MOVE","CARELESS","GREEN","NORMAL",["true", "{(vehicle _x) land 'LAND'} foreach (units (group this)); deletewaypoint [(group this), 0]"]] call RYD_WPadd;

									[(vehicle (leader _x)),_lz,_x] spawn
										{
										_heli = _this select 0;
										_lz = _this select 1;
										_gp = _this select 2;

										_cause = [_gp,6,true,0,24,[],false] call RYD_Wait;
										_timer = _cause select 0;
										_alive = _cause select 1;

										if (_alive) then
											{
											sleep 5;
											_ct = 0;

											waitUntil
												{
												sleep 1;
												_ct = _ct + 1;
												if (isNull _gp) then {_alive = false};
												if not (alive (leader _gp)) then {_alive = false};
												(not (landResult (vehicle (leader _gp)) in ["NotReady"]) or not (_alive) or (_ct > 60))
												};

											sleep 30;

											if (_alive) then {_gp getVariable [("Busy" + (str _gp)),false]}
											};

										deleteVehicle _lz
										}
									}
								}
							}
						}
					}
				}
			}
		else
			{
			if (RydHQD_LZ) then
				{
				_dst = (leader RydHQD) distance _start;
				if (_dst > RydHQD_AirDist) then
					{
					_lz = [getPosATL (leader RydHQD)] call RYD_LZ;
					if not (isNull _lz) then
						{
						_start = getPosATL _lz;
						_x setVariable [("START" + str (_x)),_start]
						}
					}
				}
			};

		sleep 0.05;
		}
	foreach RydHQD_AirG;
	}