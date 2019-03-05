#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartScript {

    printf '%b\n' "CoreOS already has (Rkt) installed on your system...";

    printf '%b\n' "--Execution path:";
    which rkt;
    printf '%b\n' "--Version:";
    rkt version;
    
} 

# @descr: Call of execution of the script's main function.
StartScript "$@";

# @descr: Finishing the script!!! :P
exit 0;