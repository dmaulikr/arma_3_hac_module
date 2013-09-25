/* Name: RYD_ForceAnalyze.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_ForceAnalyze")) then {
	RYD_ForceAnalyze = {
		private ["_HQarr","_frArr","_enArr","_frG","_enG","_HQs","_arr"];
		_HQarr = _this select 0;
		_frArr = [];
		_enArr = [];
		_frG = [];
		_enG = [];
		_HQs = [];
		{	switch (true) do {
				case ((_x == leaderHQ) and not (isNull RydHQ)) : {
					_arr = (RydBB_arrA + [_frArr,_enArr,_enG,RydHQ]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQ_Friends - RydHQ_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQ_KnEnemiesG;
				};
				case ((_x == leaderHQB) and not (isNull RydHQB)) : {
					_arr = (RydBB_arrB + [_frArr,_enArr,_enG,RydHQB]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQB_Friends - RydHQB_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQB_KnEnemiesG;
				};
				case ((_x == leaderHQC) and not (isNull RydHQC)) : {
					_arr = (RydBB_arrC + [_frArr,_enArr,_enG,RydHQC]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQC_Friends - RydHQC_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQC_KnEnemiesG;
				};
				case ((_x == leaderHQD) and not (isNull RydHQD)) : {
					_arr = (RydBB_arrD + [_frArr,_enArr,_enG,RydHQD]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQD_Friends - RydHQD_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQD_KnEnemiesG;
				};
				case ((_x == leaderHQE) and not (isNull RydHQE)) : {
					_arr = (RydBB_arrE + [_frArr,_enArr,_enG,RydHQE]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQE_Friends - RydHQE_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQE_KnEnemiesG;
				};
				case ((_x == leaderHQF) and not (isNull RydHQF)) : {
					_arr = (RydBB_arrF + [_frArr,_enArr,_enG,RydHQF]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQF_Friends - RydHQF_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQF_KnEnemiesG;
				};
				case ((_x == leaderHQG) and not (isNull RydHQG)) : {
					_arr = (RydBB_arrG + [_frArr,_enArr,_enG,RydHQG]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQG_Friends - RydHQG_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQG_KnEnemiesG;
				};
				case ((_x == leaderHQH) and not (isNull RydHQH)) : {
					_arr = (RydBB_arrH + [_frArr,_enArr,_enG,RydHQH]) call RYD_ForceCount;
					_frArr = _arr select 0;
					_enArr = _arr select 1;
					_HQs set [(count _HQs),(group _x)];
					_frG = _frG + RydHQH_Friends - RydHQH_Exhausted;
					{	if not (_x in _enG) then {_enG set [(count _enG),_x]};
					} foreach RydHQH_KnEnemiesG;
				};
			};
		} foreach _HQarr;
		_frArr set [(count _frArr),_frG];
		_enArr set [(count _enArr),_enG];
		[_frArr,_enArr,_HQs]
	};
};
