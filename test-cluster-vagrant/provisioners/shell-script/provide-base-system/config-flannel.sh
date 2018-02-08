#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://github.com/coreos/flannel/issues/554
#         https://coreos.com/flannel/docs/latest/flannel-config.html  
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfiguration {
    local flanneldPath="/etc/systemd/system/flanneld.service.d";
    local flannelConfFile="flannel.conf";
    local networkConfigConfFile="network-config.conf";

    printf '%b\n' "Initializing the (Flannel) configuration on the system...";

    mkdir -p "${flanneldPath}";

    touch "${flanneldPath}/${flannelConfFile}"
    { 
        echo '[Service]';
        echo 'ExecStart=';
        echo 'ExecStart=/usr/lib/coreos/flannel-wrapper $FLANNEL_OPTS \';
        echo '  --etcd-prefix="/flannel/network"';

    } > "${flanneldPath}/${flannelConfFile}";
    chmod 644 ${flanneldPath}/${flannelConfFile};

    touch "${flanneldPath}/${networkConfigConfFile}"
    { 
        echo '[Service]';
        echo $'ExecStartPre=/usr/bin/etcdctl set /flannel/network/config \'{ "Network": "10.1.0.0/16" }\'';

    } > "${flanneldPath}/${networkConfigConfFile}";
    chmod 644 ${flanneldPath}/${networkConfigConfFile};

    systemctl daemon-reload;
    systemctl enable flanneld;
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;
