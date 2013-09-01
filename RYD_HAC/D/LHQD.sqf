_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQD")};

while {not (isNull RydHQD)} do
	{
	_last = leaderHQD;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQD = leader RydHQD;
	RydHQD_LHQInit = true;
	if not (_last == leaderHQD) then
		{
		if not (isNull leaderHQD) then
			{
			if (alive leaderHQD) then
				{
				if not (isNull RydHQD) then
					{
					if not (_cycle == RydHQD_Cyclecount) then
						{
						if not (RydHQD_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQD];_cycle = RydHQD_Cyclecount;
							RydHQD_Personality = RydHQD_Personality + "-";
							RydHQD_Recklessness = RydHQD_Recklessness + (random 0.2);
							RydHQD_Consistency = RydHQD_Consistency - (random 0.2);
							RydHQD_Activity = RydHQD_Activity - (random 0.2);
							RydHQD_Reflex = RydHQD_Reflex - (random 0.2);
							RydHQD_Circumspection = RydHQD_Circumspection - (random 0.2);
							RydHQD_Fineness = RydHQD_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQD_Recklessness,RydHQD_Consistency,RydHQD_Activity,RydHQD_Reflex,RydHQD_Circumspection,RydHQD_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQD_Morale = RydHQD_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQD)) == 0) then {RydHQD = GrpNull};
	};

if (RydHQD_Debug) then {hintSilent "HQ of D forces has been destroyed!"};

RydHQD_Done = true;