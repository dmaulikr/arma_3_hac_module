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
#ifdef mod_ryd_hac
  #include <modules\RYD_HAC\params.h>
#endif
class Spacer0 {
    title = " ";
    values[] = {0};
    texts[] = {" "};
    default = 0;
};