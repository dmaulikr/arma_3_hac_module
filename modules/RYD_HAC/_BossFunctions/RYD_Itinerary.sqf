/* Name: RYD_Itinerary.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_Itinerary")) then {
	RYD_Itinerary = {
		private ["_sectors","_targets","_pos1","_pos2","_bound","_secIn","_tgtIn","_topoAn","_infF","_vehF","_side","_cSum","_varName","_HandledArray"];
		_sectors = _this select 0;
		_targets = _this select 1;
		_pos1 = _this select 2;
		_pos2 = _this select 3;
		_side = _this select 4;
		_bound = createLocation ["Name", _pos1, 1, 1];
		_bound setRectangular true;
		[_bound,_pos1,_pos2,1200] call RYD_LocLineTransform;
		_secIn = [];
		_tgtIn = [];
		{	if ((position _x) in _bound) then {_secIn set [(count _secIn),_x]};
		} foreach _sectors;
		{	if ((_x select 0) in _bound) then {
				_cSum = 0;
				{	_cSum = _cSum + _x;
				} foreach (_x select 0);
				_varName = "HandledAreas" + _side;
				_HandledArray = missionNameSpace getVariable _varName;
				if (isNil "_HandledArray") then	{
					missionNameSpace setVariable [_varName,[]];
					_HandledArray = missionNameSpace getVariable _varName;
				};
				if not (_cSum in _HandledArray) then {
					_tgtIn set [(count _tgtIn),_x];
					_HandledArray set [(count _HandledArray),_cSum];
					missionNameSpace setVariable [_varName,_HandledArray];
				};
			};
		}foreach _targets;
		deleteLocation _bound;
		_topoAn = [_secIn] call RYD_TopoAnalize;
		_secIn = _topoAn select 0;
		_topoAn = [_secIn] call RYD_TopoAnalize;
		_infF = _topoAn select 1;
		_vehF = _topoAn select 2;
		[_secIn,_tgtIn,_infF,_vehF]
	};
};
