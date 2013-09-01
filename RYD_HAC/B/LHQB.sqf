_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQB")};

while {not (isNull RydHQB)} do
	{
	_last = leaderHQB;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQB = leader RydHQB;
	RydHQB_LHQInit = true;
	if not (_last == leaderHQB) then
		{
		if not (isNull leaderHQB) then
			{
			if (alive leaderHQB) then
				{
				if not (isNull RydHQB) then
					{
					if not (_cycle == RydHQB_Cyclecount) then
						{
						if not (RydHQB_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQB];_cycle = RydHQB_Cyclecount;
							RydHQB_Personality = RydHQB_Personality + "-";
							RydHQB_Recklessness = RydHQB_Recklessness + (random 0.2);
							RydHQB_Consistency = RydHQB_Consistency - (random 0.2);
							RydHQB_Activity = RydHQB_Activity - (random 0.2);
							RydHQB_Reflex = RydHQB_Reflex - (random 0.2);
							RydHQB_Circumspection = RydHQB_Circumspection - (random 0.2);
							RydHQB_Fineness = RydHQB_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQB_Recklessness,RydHQB_Consistency,RydHQB_Activity,RydHQB_Reflex,RydHQB_Circumspection,RydHQB_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQB_Morale = RydHQB_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQB)) == 0) then {RydHQB = GrpNull};
	};

if (RydHQB_Debug) then {hintSilent "HQ of B forces has been destroyed!"};

RydHQB_Done = true;