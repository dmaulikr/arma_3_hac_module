/* get_params.sqf
 * Updated: 2013/02/15
 * Description: Creates variables for all values in paramsArray.
 */
private["_debug"];
_debug = false;
if (_debug) then {
  diag_log format ["#%1# Initialising Get Params...",time];
};
for [{_i = 0},{_i < count(paramsArray)},{_i = _i + 1}] do {
  call compile format ["%1 = %2;",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)];
  if (_debug) then {
    diag_log format ["%1 = %2",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)];
  };
};
if (_debug) then {
  diag_log format ["#%1# Completed Get Params.",time];
};
