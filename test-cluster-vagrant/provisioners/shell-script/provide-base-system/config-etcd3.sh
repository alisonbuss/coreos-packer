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
function StartConfiguration {
    local nameServerETCD="${1}";
    local privateIP="${2}";

    printf '%b\n' "Initializing the (ETCD-3) configuration on the system.";

    printf '%b\n' "--> Name Server ETCD: ${nameServerETCD}";
    printf '%b\n' "--> Private IP: ${privateIP}";

    etcdctl v;

    echo "Name Server ETCD: ${nameServerETCD} | Private IP: ${privateIP}" >> data_etcd.txt;
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;