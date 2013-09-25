/* Name: RYD_Recon.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_Recon")) then {
	RYD_Recon =	{
		private ["_ammo","_gps","_IR","_garrA","_recAv","_flankAv","_AOnlyA","_exhA","_final","_pass","_trg","_lmt","_rcArr","_nCargo","_busy","_isRAir","_NCVeh"];
		_gps = _this select 0;
		_IR = _this select 1;
		_rcArr = _this select 2;
		_garrA = _rcArr select 0;
		_recAv = _rcArr select 1;
		_flankAv = _rcArr select 2;
		_AOnlyA = _rcArr select 3;
		_exhA = _rcArr select 4;
		_nCargo = _rcArr select 5;
		_trg = _rcArr select 6;
		_NCVeh = _rcArr select 7;
		_lmt = _this select 3;
		_isRAir = _this select 4;
		_final = [];
		{	_pass = true;
			if not ((_x in _recAv) or (_IR == "NR")) then {
				_pass = false;
			}else{
				if (_x in _AOnlyA) then	{
					_pass = false;
				}else{
					if (_x in _exhA) then {
						_pass = false;
					}else{
						if (_x in _garrA) then {
							_pass = false;
						}else{
							if ((_x in _nCargo) and ((count (units _x)) <= 1) and (((assignedvehicle (leader _x)) emptyPositions "Cargo") > 4)) then {
								_pass = false;
							}else{
								_ammo = [_x,_NCVeh] call RYD_AmmoCount;
								if ((_ammo == 0) and not (_isRAir)) then {
									_pass = false;
								}else{
									_busy = _x getvariable ("Busy" + (str _x));
									if (isNil ("_busy")) then {_busy = false};
									if (_busy) then	{
										_pass = false;
									}else{
										if (_x in _flankAv) then {
											_pass = false;
										};
									};
								};
							};
						};
					};
				};
			};
			if (_pass) then {_final set [(count _final),_x]};
		} foreach _gps;
		if ((count _final) > 0) then {[_final,_trg,_lmt] call RYD_DistOrd};
		_final
	};
};
