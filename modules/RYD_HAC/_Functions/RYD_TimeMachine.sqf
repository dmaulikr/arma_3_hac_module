/* Name: RYD_TimeMachine.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_TimeMachine")) then {
	RYD_TimeMachine = {
		private ["_units","_id"];
		_units = _this select 0;
		{	_id = _x addAction ["Time: x2","modules\RYD_HAC\TimeM\TimeFaster.sqf","",-50,false,true,"","true"];
			_id = _x addAction ["Time: x0.5","modules\RYD_HAC\TimeM\TimeSlower.sqf","",-60,false,true,"","true"];
			_id = _x addAction ["Order pause enabled","modules\RYD_HAC\TimeM\EnOP.sqf","",-70,false,true,"","not RydHQ_GPauseActive"];
			_id = _x addAction ["Order pause disabled","modules\RYD_HAC\TimeM\DisOP.sqf","",-80,false,true,"","RydHQ_GPauseActive"];
		} foreach _units;
		true
	};
};
