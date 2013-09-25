/* Name: RYD_NearestRoad.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_NearestRoad")) then {
	RYD_NearestRoad = {
		private ["_pos","_radius","_roads","_chosen","_dist","_distC"];
		_pos = _this select 0;
		_radius = _this select 1;
		_chosen = objNull;
		_roads = _pos nearRoads _radius;
		if ((count _roads) > 0) then {
			_chosen = _roads select 0;
			_distC = (getPosATL _chosen) distance _pos;
			{	_dist = (getPosATL _x) distance _pos;
				if (_dist <_distC) then {_chosen = _x;_distC = _dist};
			} foreach _roads;
		};
		_chosen
	};
};
