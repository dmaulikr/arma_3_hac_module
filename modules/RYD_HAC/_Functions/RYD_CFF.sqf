/* Name: RYD_CFF.sqf
 * Description:
 * Author: Rydygier
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example: [RydHQ_ArtG,RydHQ_KnEnemies,(RydHQ_EnHArmor + RydHQ_EnMArmor + RydHQ_EnLArmor),RydHQ_Friends,RydHQ_Debug] call RYD_CFF;
 */
if (isNil("RYD_CFF")) then {
	RYD_CFF = {
		private ["_artG","_knEnemies","_enArmor","_friends","_Debug","_CFFMissions","_tgt","_ammo","_bArr","_possible","_UL","_ldr"];
		_artG = _this select 0;
		_knEnemies = _this select 1;
		_enArmor = _this select 2;
		_friends = _this select 3;
		_Debug = _this select 4;
		_ldr = _this select 5;
		_CFFMissions = ceil (random (count _artG));
		for "_i" from 1 to _CFFMissions do {
			_tgt = [_knEnemies] call RYD_CFF_TGT;
			if not (isNull _tgt) then {
				_ammo = "HE";
				if ((random 100) > 75) then {_ammo = "WP"};
				if (_tgt in _enArmor) then {_ammo = "SADARM"};
				_bArr = [(getPosATL _tgt),_artG,_ammo,6,objNull] call RYD_ArtyMission;
				_possible = _bArr select 0;
				_UL = leader (_friends select (floor (random (count _friends))));
				if not (isPlayer _UL) then {if ((random 100) < RydxHQ_AIChatDensity) then {[_UL,RydxHQ_AIC_ArtyReq,"ArtyReq"] call RYD_AIChatter}};
				if (_possible) then	{
					if ((random 100) < RydxHQ_AIChatDensity) then {[_ldr,RydxHQ_AIC_ArtAss,"ArtAss"] call RYD_AIChatter};
					[_bArr select 1,_tgt,_bArr select 2,_ammo,_friends,_Debug] spawn RYD_CFF_FFE;
				}else{
					switch (true) do {
						case (_ammo in ["SADARM","WP"]) : {_ammo = "HE"};
						case (_ammo in ["HE"]) : {_ammo = "WP"};
					};
					_bArr = [(getPosATL _tgt),_artG,_ammo,6,objNull] call RYD_ArtyMission;
					_possible = _bArr select 0;
					if (_possible) then	{
						if ((random 100) < RydxHQ_AIChatDensity) then {[_ldr,RydxHQ_AIC_ArtAss,"ArtAss"] call RYD_AIChatter};
						[_bArr select 1,_tgt,_bArr select 2,_ammo,_friends,_Debug] spawn RYD_CFF_FFE
					}else{
						if ((random 100) < RydxHQ_AIChatDensity) then {[_ldr,RydxHQ_AIC_ArtDen,"ArtDen"] call RYD_AIChatter};
					};
				};
			};
			sleep (5 + (random 5));
		};
	};
};
