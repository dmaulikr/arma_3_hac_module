/* Name: RYD_ExecutePath.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_ExecutePath")) then {
	RYD_ExecutePath = {
		private ["_HQ","_areas","_o1","_o2","_o3","_o4","_allied","_HQpos","_sortedA","_i","_nObj","_actO","_nObj","_KnEn","_KnEnAct","_VLpos","_enX","_enY","_ct","_VHQpos","_front","_afront",
		"_frPos","_frDir","_frDim","_chosenPos","_maxTempt","_actTempt","_sectors","_ownKnEn","_ownForce","_ctOwn","_alliedForce","_alliedGarrisons","_alliedExhausted","_inFlank","_Garrisons","_exhausted",
		"_prop","_enPos","_dst","_val","_profile","_j","_pCnt","_m","_checkPos","_actPos","_indx","_check","_reserve","_garrPool","_fG","_garrison","_chosen","_dstMin","_actG","_actDst","_side",
		"_AllV","_Civs","_AllV2","_Civs2","_AllV0","_AllV20","_NearAllies","_NearEnemies","_actOPos","_mChange","_marksT","_firstP","_actP","_angleM","_centerPoint","_mr1","_mr2","_lM","_wp",
		"_varName","_HandledArray","_cSum","_reck","_cons","_limit","_lColor"];
		_HQ = _this select 0; //leader units
		_areas = _this select 1;
		_o1 = _this select 2;
		_o2 = _this select 3;
		_o3 = _this select 4;
		_o4 = _this select 5;
		_allied = (_this select 6) - [_HQ]; //leader units
		_HQpos = _this select 7;
		_front = _this select 8;
		_sectors = _this select 9;
		_reserve = _this select 10;
		_side = _this select 11;
		_varName = "HandledAreas" + _side;
		_HandledArray = missionNameSpace getVariable _varName;
		_frPos = position _front;
		_frDir = direction _front;
		_frDim = size _front;
		_profile = (group _HQ) getVariable "ForceProfile";
		_sortedA = [_areas,_HQpos,25000] call RYD_DistOrdB;
		_pCnt = 0;
		_m = "";
		_marksT = [];
		if (RydBB_Debug) then {
			{	_pCnt = _pCnt + 1;
				_j = [(_x select 0),(random 1000),"markBBPath","ColorBlack","ICON","mil_box",(str _pCnt),"",[0.35,0.35]] call RYD_Mark;
				_marksT set [(count _marksT),_j];
			} foreach _sortedA;
			for "_i" from 0 to ((count _sortedA) - 1) do {
				_firstP = _HQpos;
				if (_i > 0) then {_firstP = (_sortedA select (_i - 1)) select 0};
				_firstP = [_firstP select 0,_firstP select 1,0];
				_actP = (_sortedA select _i) select 0;
				_actP = [_actP select 0,_actP select 1,0];
				_angleM = [_firstP,_actP,0] call RYD_AngTowards;
				_centerPoint = [((_firstP select 0) + (_actP select 0))/2,((_firstP select 1) + (_actP select 1))/2,0];
				_mr1 = 1.5;
				_mr2 = _actP distance _centerPoint;
				_lM = [_centerPoint,(random 1000),"markBBline","ColorPink","RECTANGLE","Solid","","",[_mr1,_mr2],_angleM] call RYD_Mark;
				_marksT set [(count _marksT),_lM];
			};
		};
		(group _HQ) setVariable ["PathDone",false];
		for "_i" from 0 to ((count _sortedA) - 1) do {
			_actO = _sortedA select _i;
			_cSum = 0;
			{	_cSum = _cSum + _x;
			} foreach (_actO select 0);
			_actOPos = [(_actO select 0) select 0,(_actO select 0) select 1,0];
			_lColor = "ColorBlue";
			if (_Side == "B") then {_lColor = "ColorRed"};
			if ((RydBB_Debug) or ((RydBBa_SimpleDebug) and (_Side == "A")) or ((RydBBb_SimpleDebug) and (_Side == "B"))) then {
				if (_i == 0) then {
						_m = [(_actO select 0),_HQ,"markBBCurrent",_lColor,"ICON","mil_triangle","Current target for " + (str _HQ),"",[0.5,0.5]] call RYD_Mark;
				}else{
					_m setMarkerPos (_actO select 0);
				};
			};
			{	_x setPosATL _actOPos;
			} foreach [_o1,_o2,_o3,_o4];
			(group _HQ) setVariable ["ObjInit",true];
			switch (_HQ) do	{
				case (leaderHQ) : {RydHQ_NObj = 1};
				case (leaderHQB) : {RydHQB_NObj = 1};
				case (leaderHQC) : {RydHQC_NObj = 1};
				case (leaderHQD) : {RydHQD_NObj = 1};
				case (leaderHQE) : {RydHQE_NObj = 1};
				case (leaderHQF) : {RydHQF_NObj = 1};
				case (leaderHQG) : {RydHQG_NObj = 1};
				case (leaderHQH) : {RydHQH_NObj = 1};
			};
			waitUntil{
				sleep 120;
				_KnEn = [];
				_inFlank = (group _HQ) getVariable "inFlank";
				if (isNil "_inFlank") then {_inFlank = false};
				if not (_inFlank) then {
					_ownKnEn = RydHQ_KnEnemiesG;
					_ownForce = RydHQ_Friends;
					_Garrisons = RydHQ_Garrison;
					_exhausted = RydHQ_Exhausted;
					switch (_HQ) do	{
						case (leaderHQB) : {_ownKnEn = RydHQB_KnEnemiesG;_ownForce = RydHQB_Friends;_Garrisons = RydHQB_Garrison;_exhausted = RydHQB_Exhausted};
						case (leaderHQC) : {_ownKnEn = RydHQC_KnEnemiesG;_ownForce = RydHQC_Friends;_Garrisons = RydHQC_Garrison;_exhausted = RydHQC_Exhausted};
						case (leaderHQD) : {_ownKnEn = RydHQD_KnEnemiesG;_ownForce = RydHQD_Friends;_Garrisons = RydHQD_Garrison;_exhausted = RydHQD_Exhausted};
						case (leaderHQE) : {_ownKnEn = RydHQE_KnEnemiesG;_ownForce = RydHQE_Friends;_Garrisons = RydHQE_Garrison;_exhausted = RydHQE_Exhausted};
						case (leaderHQF) : {_ownKnEn = RydHQF_KnEnemiesG;_ownForce = RydHQF_Friends;_Garrisons = RydHQF_Garrison;_exhausted = RydHQF_Exhausted};
						case (leaderHQG) : {_ownKnEn = RydHQG_KnEnemiesG;_ownForce = RydHQG_Friends;_Garrisons = RydHQG_Garrison;_exhausted = RydHQG_Exhausted};
						case (leaderHQH) : {_ownKnEn = RydHQH_KnEnemiesG;_ownForce = RydHQH_Friends;_Garrisons = RydHQH_Garrison;_exhausted = RydHQH_Exhausted};
					};
					if (isNil "_exhausted") then {_exhausted = []};
					_ownForce = _ownForce - (_Garrisons + _exhausted);
					_ctOwn = 0;
					{	if ((position (vehicle (leader _x))) in _front) then {_ctOwn = _ctOwn + 1};
					} foreach _ownKnEn;
					_prop = 100;
					if (_ctOwn > 0) then {_prop = (count _ownForce)/_ctOwn};
					if (_prop > (8 * (0.5 + (random 1)))) then {
						{	_KnEnAct = RydHQ_KnEnemiesG;
							_afront = FrontA;
							_alliedForce = RydHQ_Friends;
							_alliedGarrisons = RydHQ_Garrison;
							_alliedExhausted = RydHQ_Exhausted;
							switch (_x) do {
								case (leaderHQB) : {_KnEnAct = RydHQB_KnEnemiesG;_afront = FrontB;_alliedForce = RydHQB_Friends;_alliedGarrisons = RydHQB_Garrison;_alliedExhausted = RydHQB_Exhausted};
								case (leaderHQC) : {_KnEnAct = RydHQC_KnEnemiesG;_afront = FrontC;_alliedForce = RydHQC_Friends;_alliedGarrisons = RydHQC_Garrison;_alliedExhausted = RydHQC_Exhausted};
								case (leaderHQD) : {_KnEnAct = RydHQD_KnEnemiesG;_afront = FrontD;_alliedForce = RydHQD_Friends;_alliedGarrisons = RydHQD_Garrison;_alliedExhausted = RydHQD_Exhausted};
								case (leaderHQE) : {_KnEnAct = RydHQE_KnEnemiesG;_afront = FrontE;_alliedForce = RydHQE_Friends;_alliedGarrisons = RydHQE_Garrison;_alliedExhausted = RydHQE_Exhausted};
								case (leaderHQF) : {_KnEnAct = RydHQF_KnEnemiesG;_afront = FrontF;_alliedForce = RydHQF_Friends;_alliedGarrisons = RydHQF_Garrison;_alliedExhausted = RydHQF_Exhausted};
								case (leaderHQG) : {_KnEnAct = RydHQG_KnEnemiesG;_afront = FrontG;_alliedForce = RydHQG_Friends;_alliedGarrisons = RydHQG_Garrison;_alliedExhausted = RydHQG_Exhausted};
								case (leaderHQH) : {_KnEnAct = RydHQH_KnEnemiesG;_afront = FrontH;_alliedForce = RydHQH_Friends;_alliedGarrisons = RydHQH_Garrison;_alliedExhausted = RydHQH_Exhausted};
							};
							if (isNil "_alliedExhausted") then {_alliedExhausted = []};
							_alliedForce =  _alliedForce - (_alliedGarrisons + _alliedExhausted);
							if ((count _KnEnAct) > 0) then {
								_ct = 0;
								{	_enX = 0;
									_enY = 0;
									_VLpos = getPosATL (vehicle (leader _x));
									if (_VLpos in _afront) then	{
										_ct = _ct + 1;
										_enX = _enX + (_VLpos select 0);
										_enY = _enY + (_VLpos select 1);
									};
								} foreach _KnEnAct;
								if (_ct > 0) then {
									_enX = _enX/_ct;
									_enY = _enY/_ct;
								};
								_KnEn set [(count _KnEn),[[_enX,_enY,0],_ct]];
							};
						} foreach _allied;
						if ((count _KnEn) > 0) then {
							_chosenPos = [];
							_maxTempt = 0;
							{	_VHQpos = getPosATL (vehicle (leader _HQ));
								_enPos = _x select 0;
								_dst = _VHQpos distance _enPos;
								_val = _x select 1;
								_actTempt = 0;
								if ((_dst > 0) and ((count _ownForce) > (_val * (0.1 + (random 1)))) and (_val > ((count _alliedForce) * (0.5 + (random 0.5))))) then {_actTempt = (1000 * (sqrt _val))/_dst};
								if (_actTempt > _maxTempt) then	{
									_maxTempt = _actTempt;
									_chosenPos = _enPos;
								};
							} foreach _KnEn;
							if ((count _chosenPos) > 1) then {_chosenPos = [(_chosenPos select 0),(_chosenPos select 1),0]};
							if (_maxTempt > (0.1 + (random 2))) then {
								(group _HQ) setVariable ["inFlank",true];
								[_front,_VHQpos,_chosenPos,2000] call RYD_LocLineTransform;
								{	_x setPosATL _chosenPos;
								} foreach [_o1,_o2,_o3,_o4];
								switch (_HQ) do	{
									case (leaderHQ) : {RydHQ_NObj = 1};
									case (leaderHQB) : {RydHQB_NObj = 1};
									case (leaderHQC) : {RydHQC_NObj = 1};
									case (leaderHQD) : {RydHQD_NObj = 1};
									case (leaderHQE) : {RydHQE_NObj = 1};
									case (leaderHQF) : {RydHQF_NObj = 1};
									case (leaderHQG) : {RydHQG_NObj = 1};
									case (leaderHQH) : {RydHQH_NObj = 1};
								};
								waitUntil{
									sleep 120;
									_nObj = RydHQ_NObj;
									_reck = RydHQ_Recklessness;
									_cons = RydHQ_Consistency;
									_limit = RydHQ_CaptLimit;
									switch (_HQ) do	{
										case (leaderHQB) : {_nObj = RydHQB_NObj;_reck = RydHQB_Recklessness;_cons = RydHQB_Consistency;_limit = RydHQB_CaptLimit};
										case (leaderHQC) : {_nObj = RydHQC_NObj;_reck = RydHQC_Recklessness;_cons = RydHQC_Consistency;_limit = RydHQC_CaptLimit};
										case (leaderHQD) : {_nObj = RydHQD_NObj;_reck = RydHQD_Recklessness;_cons = RydHQD_Consistency;_limit = RydHQD_CaptLimit};
										case (leaderHQE) : {_nObj = RydHQE_NObj;_reck = RydHQE_Recklessness;_cons = RydHQE_Consistency;_limit = RydHQE_CaptLimit};
										case (leaderHQF) : {_nObj = RydHQF_NObj;_reck = RydHQF_Recklessness;_cons = RydHQF_Consistency;_limit = RydHQF_CaptLimit};
										case (leaderHQG) : {_nObj = RydHQG_NObj;_reck = RydHQG_Recklessness;_cons = RydHQG_Consistency;_limit = RydHQG_CaptLimit};
										case (leaderHQH) : {_nObj = RydHQH_NObj;_reck = RydHQH_Recklessness;_cons = RydHQH_Consistency;_limit = RydHQH_CaptLimit};
									};
									if (isNil "_limit") then {_limit = 10};
									if (isNull (group _HQ)) then {_nObj = 100};
									if not (alive _HQ) then {_nObj = 100};
									_AllV = _chosenPos nearEntities [["AllVehicles"],300];
									_Civs = _chosenPos nearEntities [["Civilian"],300];
									_AllV2 = _chosenPos nearEntities [["AllVehicles"],500];
									_Civs2 = _chosenPos nearEntities [["Civilian"],500];
									_AllV = _AllV - _Civs;
									_AllV2 = _AllV2 - _Civs2;
									_AllV0 = _AllV;
									_AllV20 = _AllV2;
									{	if not (_x isKindOf "Man") then	{
											if ((count (crew _x)) == 0) then {_AllV = _AllV - [_x]};
										};
									} foreach _AllV0;
									{	if not (_x isKindOf "Man") then	{
											if ((count (crew _x)) == 0) then {_AllV2 = _AllV2 - [_x]};
										};
									} foreach _AllV20;
									_NearAllies = _HQ countfriendly _AllV;
									_NearEnemies = _HQ countenemy _AllV2;
									((_nObj > 1) or ((_NearAllies >= _limit) and (_NearEnemies <= ((_reck/(0.5 + _cons))*10))))
								};
								if not (isNull (group _HQ)) then {
									_front setPosition _frPos;
									_front setDirection _frDir;
									_front setSize _frDim;
									{	_x setPosATL _actOPos;
									} foreach [_o1,_o2,_o3,_o4];
									switch (_HQ) do	{
										case (leaderHQ) : {RydHQ_NObj = 1};
										case (leaderHQB) : {RydHQB_NObj = 1};
										case (leaderHQC) : {RydHQC_NObj = 1};
										case (leaderHQD) : {RydHQD_NObj = 1};
										case (leaderHQE) : {RydHQE_NObj = 1};
										case (leaderHQF) : {RydHQF_NObj = 1};
										case (leaderHQG) : {RydHQG_NObj = 1};
										case (leaderHQH) : {RydHQH_NObj = 1};
									};

									(group _HQ) setVariable ["inFlank",false]
								};
							};
						};
					};
				};
				(_actO select 2)
			};
			if (isNull (group _HQ)) exitWith {};
			if not (alive _HQ) exitWith {};
			_garrPool = 0;
			{	_fG = RydHQ_NCrewInfG - (RydHQ_Exhausted + RydHQ_Garrison);
				switch (_x) do {
					case (leaderHQB) : {_fG = RydHQB_NCrewInfG - (RydHQB_Exhausted + RydHQB_Garrison)};
					case (leaderHQC) : {_fG = RydHQC_NCrewInfG - (RydHQC_Exhausted + RydHQC_Garrison)};
					case (leaderHQD) : {_fG = RydHQD_NCrewInfG - (RydHQD_Exhausted + RydHQD_Garrison)};
					case (leaderHQE) : {_fG = RydHQE_NCrewInfG - (RydHQE_Exhausted + RydHQE_Garrison)};
					case (leaderHQF) : {_fG = RydHQF_NCrewInfG - (RydHQF_Exhausted + RydHQF_Garrison)};
					case (leaderHQG) : {_fG = RydHQG_NCrewInfG - (RydHQG_Exhausted + RydHQG_Garrison)};
					case (leaderHQH) : {_fG = RydHQH_NCrewInfG - (RydHQH_Exhausted + RydHQH_Garrison)};
				};
				if ((count _fG) > 2) then {_garrPool = _garrPool + 1};
			} foreach _reserve;
			if (_garrPool == 0) then {
				_fG = RydHQ_NCrewInfG - (RydHQ_Exhausted + RydHQ_Garrison);
				_garrison = RydHQ_Garrison;
				switch (_HQ) do {
					case (leaderHQB) : {_fG = RydHQB_NCrewInfG - (RydHQB_Exhausted + RydHQB_Garrison);_garrison = RydHQB_Garrison};
					case (leaderHQC) : {_fG = RydHQC_NCrewInfG - (RydHQC_Exhausted + RydHQC_Garrison);_garrison = RydHQC_Garrison};
					case (leaderHQD) : {_fG = RydHQD_NCrewInfG - (RydHQD_Exhausted + RydHQD_Garrison);_garrison = RydHQD_Garrison};
					case (leaderHQE) : {_fG = RydHQE_NCrewInfG - (RydHQE_Exhausted + RydHQE_Garrison);_garrison = RydHQE_Garrison};
					case (leaderHQF) : {_fG = RydHQF_NCrewInfG - (RydHQF_Exhausted + RydHQF_Garrison);_garrison = RydHQF_Garrison};
					case (leaderHQG) : {_fG = RydHQG_NCrewInfG - (RydHQG_Exhausted + RydHQG_Garrison);_garrison = RydHQG_Garrison};
					case (leaderHQH) : {_fG = RydHQH_NCrewInfG - (RydHQH_Exhausted + RydHQH_Garrison);_garrison = RydHQH_Garrison};
				};
				if (((count _fG)/10) >= 1) then	{
					_chosen = _fG select 0;
					_dstMin = (_actO select 0) distance (vehicle (leader _chosen));
					{	_actG = _x;
						_actDst = (_actO select 0) distance (vehicle (leader _actG));
						if (_actDst < _dstMin) then	{
							_dstMin = _actDst;
							_chosen = _actG;
						};
					} foreach _fG;
					_chosen setVariable ["Busy" + (str _chosen),true];
					_garrison set [(count _garrison),_chosen];
				};
			};
			switch (_HQ) do {
				case (leaderHQ) : {RydHQ_NObj = 5};
				case (leaderHQB) : {RydHQB_NObj = 5};
				case (leaderHQC) : {RydHQC_NObj = 5};
				case (leaderHQD) : {RydHQD_NObj = 5};
				case (leaderHQE) : {RydHQE_NObj = 5};
				case (leaderHQF) : {RydHQF_NObj = 5};
				case (leaderHQG) : {RydHQG_NObj = 5};
				case (leaderHQH) : {RydHQH_NObj = 5};
			};
			switch (_HQ) do {
				case (leaderHQ) : {_BBProg = (group leaderHQ) getVariable ["BBProgress",0];(group leaderHQ) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQB) : {_BBProg = (group leaderHQB) getVariable ["BBProgress",0];(group leaderHQB) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQC) : {_BBProg = (group leaderHQC) getVariable ["BBProgress",0];(group leaderHQC) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQD) : {_BBProg = (group leaderHQD) getVariable ["BBProgress",0];(group leaderHQD) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQE) : {_BBProg = (group leaderHQE) getVariable ["BBProgress",0];(group leaderHQE) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQF) : {_BBProg = (group leaderHQF) getVariable ["BBProgress",0];(group leaderHQF) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQG) : {_BBProg = (group leaderHQG) getVariable ["BBProgress",0];(group leaderHQG) setVariable ["BBProgress",_BBProg + 1]};
				case (leaderHQH) : {_BBProg = (group leaderHQH) getVariable ["BBProgress",0];(group leaderHQH) setVariable ["BBProgress",_BBProg + 1]};
			};
			_HandledArray = _HandledArray - [_cSum];
			missionNameSpace setVariable [_varName,_HandledArray];
			if (RydBB_LRelocating) then	{
				[(group _HQ)] call RYD_WPdel;
				_wp = [(group _HQ),_actOPos,"HOLD","AWARE","GREEN","LIMITED",["true",""],true,50,[0,0,0],"FILE"] call RYD_WPadd;
			};
		};
		if (RydBB_Debug) then {
			{	deleteMarker _x;
			} foreach (_marksT + [_m]);
		};
		if not (isNull (group _HQ)) then {(group _HQ) setVariable ["PathDone",true]};
	};
};
