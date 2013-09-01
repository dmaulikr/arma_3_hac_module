_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQE")};

while {not (isNull RydHQE)} do
	{
	_last = leaderHQE;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQE = leader RydHQE;
	RydHQE_LHQInit = true;
	if not (_last == leaderHQE) then
		{
		if not (isNull leaderHQE) then
			{
			if (alive leaderHQE) then
				{
				if not (isNull RydHQE) then
					{
					if not (_cycle == RydHQE_Cyclecount) then
						{
						if not (RydHQE_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQE];_cycle = RydHQE_Cyclecount;
							RydHQE_Personality = RydHQE_Personality + "-";
							RydHQE_Recklessness = RydHQE_Recklessness + (random 0.2);
							RydHQE_Consistency = RydHQE_Consistency - (random 0.2);
							RydHQE_Activity = RydHQE_Activity - (random 0.2);
							RydHQE_Reflex = RydHQE_Reflex - (random 0.2);
							RydHQE_Circumspection = RydHQE_Circumspection - (random 0.2);
							RydHQE_Fineness = RydHQE_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQE_Recklessness,RydHQE_Consistency,RydHQE_Activity,RydHQE_Reflex,RydHQE_Circumspection,RydHQE_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQE_Morale = RydHQE_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQE)) == 0) then {RydHQE = GrpNull};
	};

if (RydHQE_Debug) then {hintSilent "HQ of E forces has been destroyed!"};

RydHQE_Done = true;