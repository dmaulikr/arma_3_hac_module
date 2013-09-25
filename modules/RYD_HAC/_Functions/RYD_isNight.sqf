/* Name: RYD_isNight.sqf
 * Description:
 * Author: Rydygier, CarlGustaffa
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/09/24
 * Returns:
 * Arguments:
 * Example:
 */
if (isNil("RYD_isNight")) then {
	RYD_isNight = {
		private ["_lat","_day","_hour","_sunangle","_isNight"];
		_isNight = false;
		_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
		_day = 360 * (dateToNumber date);
		_hour = (daytime / 24) * 360;
		_sunangle = ((12 * (cos _day) - 78) * (cos _lat) * (cos _hour)) - (24 * (sin _lat) * (cos _day));
		if (_sunangle < -10) then {_isNight = true};
		_isNight
	};
};
