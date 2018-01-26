#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
# @example:
#
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfig {

    printf '%b\n' "Start Config - Basic Security";
    
} 

# @descr: Call of execution of the script's main function.
StartConfig "$@";

# @descr: Finishing the script!!! :P
exit 0;