#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartProvisioning {

    printf '%b\n' "Starting to provide Clean Image...";
    
    # font: https://github.com/stylelab-io/kubernetes-coreos-packer/blob/master/scripts/cleanup.sh
    # remove the machine id. it will be regenerated on first boot.
    rm -rf /etc/machine-id;

} 

# @descr: Call of execution of the script's main function.
StartProvisioning "$@";

# @descr: Finishing the script!!! :P
exit 0;