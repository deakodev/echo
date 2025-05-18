#include "echo.h"

void dummie_c_fn() 
{
    echo_trace("%s", "message");
    echo_info("%s", "message");
    echo_warn("%s", "message");
    echo_error("%s", "message");
    echo_fatal("%s", "message");
}
 