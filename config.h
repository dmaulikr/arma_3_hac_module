/* Name: config.h
 * Description: Holds configuration data abstracted from description.ext.
 * Author: vigil.vindex@gmail.com
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/08/29
 */
#include <modules\modules.h>

class Params { // http://community.bistudio.com/wiki/Description.ext#params_2
  #include <params.h>
};

#ifdef mod_btc_revive
  #include <modules\BTC_revive\BTC_respawn.h>
#endif

#ifdef mod_taw_vd
  #include <modules\taw_vd\dialog.hpp>
#endif
#ifdef mod_vas
  #include <modules\VAS\common.hpp>
  #include <modules\VAS\menu.hpp>
#endif

#ifdef mod_btc_logistic
  #include "modules\BTC_Logistic\config.h"
#endif

class RscTitles { // http://community.bistudio.com/wiki/Description.ext#rscTitles
#ifdef mod_btc_logistic
  #include "modules\BTC_Logistic\BTC_Lift\BTC_Hud.h"
#endif
};

class CfgSounds { // http://community.bistudio.com/wiki/Description.ext#cfgSounds
	sounds[] = {};
};

class CfgRadio { // http://community.bistudio.com/wiki/Description.ext#cfgRadio
  sounds[] = {};
#ifdef mod_ryd_hac
  #include "modules\ryd_hac\config.h"
#endif
};

class CfgFunctions {
#ifdef mod_taw_vd
	#include "modules\taw_vd\cfgfunctions.hpp"
#endif
#ifdef mod_vas
	#include "modules\VAS\cfgfunctions.hpp"
#endif
};
