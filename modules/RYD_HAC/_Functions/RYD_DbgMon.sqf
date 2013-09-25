/* Name: RYD_DbgMon.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_DbgMon")) then {
	RYD_DbgMon = {
		private ["_txtArr","_dbgMon","_txt"];
		waitUntil{
			sleep 1;
			(not (isNull RydHQ))
		};
		if (RydBB_Active) then {
			waitUntil{
				sleep 1;
				not (isNil "RydBB_mapReady")
			};
		};
		_txtArr = [];
		while {((RydHQ_Debug) or (RydHQB_Debug) or (RydHQC_Debug) or (RydHQD_Debug) or (RydHQE_Debug) or (RydHQF_Debug) or (RydHQG_Debug) or (RydHQH_Debug))} do {
			_txtArr = [];
			{	if not (isNil "_x") then {
					if not (isNull _x) then	{
						_dbgMon = _x getVariable "DbgMon";
						if not (isNil "_dbgMon") then {
							_txtArr set [(count _txtArr),_dbgMon];
							_txtArr set [(count _txtArr),linebreak];
						};
					};
				};
			} foreach [RydHQ,RydHQB,RydHQC,RydHQD,RydHQE,RydHQF,RydHQG,RydHQH];
			if ((count _txtArr) > 0) then {
				_txt = composeText _txtArr;
				hintSilent _txt
			};
			sleep 15
		};
	};
};
