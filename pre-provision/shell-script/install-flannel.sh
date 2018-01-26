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
function StartInstallation {

    printf '%b\n' "Start Installation - Flannel";
    
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;