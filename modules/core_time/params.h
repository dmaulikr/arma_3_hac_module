class core_time_switch { 
  title = "Time Sync Settings:";
  values[] = {0,1};
  texts[] = {"Disabled","Enabled"};
  default = 1;
};
class core_time_skip_time { 
  title = "Time Sync Settings - Day Cycle Time To Skip:";
  values[] = {1,10,20,30};
  texts[] = {"1 Minute","10 Minutes","20 Minutes","30 Minutes"};
  default = 1;
};
class core_time_method { 
  title = "Time Sync Settings - Method:";
  values[] = {0,1};
  texts[] = {"SkipTime","SetDate"};
  default = 1;
};
class core_time_sync_interval { 
  title = "Time Sync Settings - Sync Interval:";
  values[] = {1,10,20,30};
  texts[] = {"1 Minute","10 Minutes","20 Minutes","30 Minutes"};
  default = 10;
};
class core_time_skip_interval { 
  title = "Time Sync Settings - Skip Interval:";
  values[] = {1,10,20,30};
  texts[] = {"1 Minute","10 Minutes","20 Minutes","30 Minutes"};
  default = 1;
};
class core_time_night_cycle { 
  title = "Time Sync Settings - Custom Night Cycle:";
  values[] = {0,1};
  texts[] = {"Disabled","Enabled"};
  default = 0;
};
class core_time_night_cycle_skip_time { 
  title = "Time Sync Settings - Custom Night Cycle Time To Skip:";
  values[] = {1,10,20,30};
  texts[] = {"1 Minute","10 Minutes","20 Minutes","30 Minutes"};
  default = 1;
};
