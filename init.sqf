/* Name: init.sqf
 * Description: Initialises the mission.
 * Authors: vigil.vindex@gmail.com
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/08/09
 */
diag_log format ["#%1# Initialising Mission.",time];
#include <modules\modules.h>
#ifndef execNow
  #define execNow call compile preprocessfilelinenumbers
#endif
MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};
diag_log format ["#%1# MISSION_ROOT = %2.",time,MISSION_ROOT];
enableSaving[false,false];
//execNow "briefing.sqf";
execNow "scripts\get_params.sqf";
#ifdef mod_date_time
  if ((date_time_switch) == 1) then {
    diag_log format ["#%1# Initialising Date Time...",time];
    execNow "modules\date_time\init.sqf";
  };
#endif
#ifdef mod_core_time
  if ((core_time_switch) == 1) then {
    diag_log format ["#%1# Initialising Core Time...",time];
    execNow "modules\core_time\init.sqf";
  };
#endif
#ifdef mod_btc_revive
  if ((btc_revive_switch) == 1) then {
    diag_log format ["#%1# Initialising BTC Revive...",time];
    execNow "modules\BTC_revive\init.sqf";
  };
#endif
#ifdef mod_btc_logistic
  if ((btc_logistic_switch) == 1) then {
    diag_log format ["#%1# Initialising BTC Logistic...",time];
    execNow "modules\BTC_logistic\init.sqf";
  };
#endif
#ifdef mod_tpw_houselights
  if ((tpw_houselights_switch) == 1) then {
    diag_log format ["#%1# Initialising TPW Houselights...",time];
    execNow "modules\tpw_houselights\init.sqf";
  };
#endif
if(isServer) then { // Server Scope
  diag_log format ["#%1# Initialising server.",time];
#ifdef mod_vv_mod
  if ((vv_mod_switch) == 1) then {
    diag_log format ["#%1# Initialising VV Module...",time];
    execNow "modules\vv_mod\init.sqf";
  };
#endif
#ifdef mod_ryd_hac
  if ((ryd_hac_switch) == 1) then {
    diag_log format ["#%1# Initialising RYD HAC...",time];
    execNow "modules\ryd_hac\init.sqf";
  };
#endif
  //execNow "init-server.sqf";
};
if(!(hasInterface) && !(isServer)) then { // Headless Client Scope
  diag_log format ["# %1 # Initialising headless client.",time];
};
if(isNull player) then { // JIP Client Scope
  diag_log format ["# %1 # Initialising JIP client.",time];
  waitUntil {!isNull player};
};
if(!isDedicated) then { // Client Scope
  diag_log format ["# %1 # Initialising client.",time];
  //execNow "scripts\jump.sqf";
  //fun = [] execVM "scripts\restrict_view.sqf";
  //execNow "init-client.sqf";
};
diag_log format ["# %1 # Mission initialisation complete.",time];
