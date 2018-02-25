#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartProvisioning {

    printf '%b\n' "Starting to provide Basic Security...";
    
} 

# @descr: Call of execution of the script's main function.
StartProvisioning "$@";

# @descr: Finishing the script!!! :P
exit 0;