// Switches
RYD_HAC_A1 = false;
RYD_HAC_A2 = false;
RYD_HAC_A3 = true;
RYD_HAC_ACR = false;
RYD_HAC_BAF = false;
RYD_HAC_OA = false;
RYD_HAC_PMC = false;
// Includes
if (RYD_HAC_A1) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\A1.sqf";
};
if (RYD_HAC_A2) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\A2.sqf";
};
if (RYD_HAC_A3) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\A3.sqf";
};
if (RYD_HAC_ACR) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\ACR.sqf";
};
if (RYD_HAC_BAF) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\BAF.sqf";
};
if (RYD_HAC_OA) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\OA.sqf";
};
if (RYD_HAC_PMC) then {
  call compile preprocessFileLineNumbers "modules\RYD_HAC\Libs\PMC.sqf";
};
