_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQ")};

while {not (isNull RydHQ)} do
	{
	_last = leaderHQ;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQ = leader RydHQ;
	RydHQ_LHQInit = true;
	if not (_last == leaderHQ) then
		{
		if not (isNull leaderHQ) then
			{
			if (alive leaderHQ) then
				{
				if not (isNull RydHQ) then
					{
					if not (_cycle == RydHQ_Cyclecount) then
						{
						if not (RydHQ_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQ];_cycle = RydHQ_Cyclecount;
							RydHQ_Personality = RydHQ_Personality + "-";
							RydHQ_Recklessness = RydHQ_Recklessness + (random 0.2);
							RydHQ_Consistency = RydHQ_Consistency - (random 0.2);
							RydHQ_Activity = RydHQ_Activity - (random 0.2);
							RydHQ_Reflex = RydHQ_Reflex - (random 0.2);
							RydHQ_Circumspection = RydHQ_Circumspection - (random 0.2);
							RydHQ_Fineness = RydHQ_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQ_Recklessness,RydHQ_Consistency,RydHQ_Activity,RydHQ_Reflex,RydHQ_Circumspection,RydHQ_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQ_Morale = RydHQ_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQ)) == 0) then {RydHQ = GrpNull};
	};

if (RydHQ_Debug) then {hintSilent "HQ of A forces has been destroyed!"};

RydHQ_Done = true;