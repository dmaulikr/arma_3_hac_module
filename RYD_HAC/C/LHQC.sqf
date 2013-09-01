_cycle = 0;

waitUntil {sleep 1; not (isNil "RydHQC")};

while {not (isNull RydHQC)} do
	{
	_last = leaderHQC;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	leaderHQC = leader RydHQC;
	RydHQC_LHQInit = true;
	if not (_last == leaderHQC) then
		{
		if not (isNull leaderHQC) then
			{
			if (alive leaderHQC) then
				{
				if not (isNull RydHQC) then
					{
					if not (_cycle == RydHQC_Cyclecount) then
						{
						if not (RydHQC_Cyclecount < 2) then 
							{
							RydxHQ_AllLeaders = RydxHQ_AllLeaders - [_last];RydxHQ_AllLeaders set [(count RydxHQ_AllLeaders),leaderHQC];_cycle = RydHQC_Cyclecount;
							RydHQC_Personality = RydHQC_Personality + "-";
							RydHQC_Recklessness = RydHQC_Recklessness + (random 0.2);
							RydHQC_Consistency = RydHQC_Consistency - (random 0.2);
							RydHQC_Activity = RydHQC_Activity - (random 0.2);
							RydHQC_Reflex = RydHQC_Reflex - (random 0.2);
							RydHQC_Circumspection = RydHQC_Circumspection - (random 0.2);
							RydHQC_Fineness = RydHQC_Fineness - (random 0.2);

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [RydHQC_Recklessness,RydHQC_Consistency,RydHQC_Activity,RydHQC_Reflex,RydHQC_Circumspection,RydHQC_Fineness];

							[] spawn
								{
								sleep (60 + (random 120));
								RydHQC_Morale = RydHQC_Morale - (10 + round (random 10));
								}
							}
						}
					}
				}
			}
		};

	if (({alive _x} count (units RydHQC)) == 0) then {RydHQC = GrpNull};
	};

if (RydHQC_Debug) then {hintSilent "HQ of C forces has been destroyed!"};

RydHQC_Done = true;