if (core_time_method == 1) then {
  if (core_time_night_cycle == 1) then {
    [core_time_skip_time,true,core_time_sync_interval,core_time_skip_interval,true,core_time_night_cycle_skip_time] execFSM "modules\core_time\core_time.fsm";
  }else{
    [core_time_skip_time,true,core_time_sync_interval,core_time_skip_interval,false,core_time_night_cycle_skip_time] execFSM "modules\core_time\core_time.fsm";
  };
}else{
  if (core_time_night_cycle == 1) then {
    [core_time_skip_time,false,core_time_sync_interval,core_time_skip_interval,true,core_time_night_cycle_skip_time] execFSM "modules\core_time\core_time.fsm";
  }else{
    [core_time_skip_time,false,core_time_sync_interval,core_time_skip_interval,false,core_time_night_cycle_skip_time] execFSM "modules\core_time\core_time.fsm";
  };
};
