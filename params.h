/* Name: params.h
 * Description: Holds parameter data abstracted from description.ext.
 * Author: vigil.vindex@gmail.com
 * Licence: https://creativecommons.org/licenses/by-sa/3.0/
 * Last Updated: 2013/08/09
 */
#include <modules\modules.h>
#ifdef mod_date_time
  #include <modules\date_time\params.h>
#endif
#ifdef mod_core_time
  #include <modules\core_time\params.h>
#endif
#ifdef mod_btc_revive
  #include <modules\BTC_revive\params.h>
#endif
#ifdef mod_btc_logistic
  #include <modules\BTC_logistic\params.h>
#endif
#ifdef mod_vv_mod
  #include <modules\vv_mod\params.h>
#endif
#ifdef mod_tpw_houselights
  #include <modules\tpw_houselights\params.h>
#endif
class Spacer0 {
    title = " ";
    values[] = {0};
    texts[] = {" "};
    default = 0;
};