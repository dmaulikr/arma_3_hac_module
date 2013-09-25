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

class RscTitles { // http://community.bistudio.com/wiki/Description.ext#rscTitles
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
};
