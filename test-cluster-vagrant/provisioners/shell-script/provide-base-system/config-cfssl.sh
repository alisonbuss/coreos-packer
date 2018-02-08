#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://www.ibm.com/developerworks/library/l-flannel-overlay-network-VXLAN-docker-trs/
#         http://cloudgeekz.com/1016/configure-flannel-docker-power.html
#         http://docker-k8s-lab.readthedocs.io/en/latest/docker/docker-flannel.html
#         http://blog.shippable.com/docker-overlay-network-using-flannel
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfiguration {

    printf '%b\n' "Initializing the (CFSSL) configuration on the system...";
    
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;