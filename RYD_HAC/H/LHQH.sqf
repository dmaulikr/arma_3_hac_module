_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQH")};

while {not (isNull RydHQH)} do
	{
	_last = leaderHQH;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQH = leader RydHQH;
	RydHQH_LHQInit = true;
	if not (_last == leaderHQH) then
		{
		if not (isNull leaderHQH) then
			{
			if (alive leaderHQH) then
				{
				if not (isNull RydHQH) then
					{
					if not (_cycle == RydHQH_Cyclecount) then
						{
						if not (RydHQH_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQH];_cycle = RydHQH_Cyclecount;
							RydHQH_Personality = RydHQH_Personality + "-";
							RydHQH_Recklessness = RydHQH_Recklessness + (random 0.2);
							RydHQH_Consistency = RydHQH_Consistency - (random 0.2);
							RydHQH_Activity = RydHQH_Activity - (random 0.2);
							RydHQH_Reflex = RydHQH_Reflex - (random 0.2);
							RydHQH_Circumspection = RydHQH_Circumspection - (random 0.2);
							RydHQH_Fineness = RydHQH_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQH_Recklessness,RydHQH_Consistency,RydHQH_Activity,RydHQH_Reflex,RydHQH_Circumspection,RydHQH_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQH_Morale = RydHQH_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQH)) == 0) then {RydHQH = GrpNull};
	};

if (RydHQH_Debug) then {hintSilent "HQ of H forces has been destroyed!"};

RydHQH_Done = true;