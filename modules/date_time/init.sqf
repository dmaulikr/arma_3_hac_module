if (isServer) then {
  if (date_time_random == 1) then {
    setDate[2013,(floor random 12),(floor random 28),(floor random 23),(floor random 59)];
  }else{
    setDate[(date_time_year),(date_time_month),(date_time_day),(date_time_hour),(date_time_minute)];
  };
};
