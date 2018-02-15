#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://coreos.com/os/docs/latest/network-config-with-networkd.html
#         https://www.upcloud.com/support/configure-floating-ip-coreos/
#         http://www.devtech101.com/2017/11/01/configuring-kubernetes-3-node-cluster-coreos-without-tectonic-part-1/
#         http://www.ricardomartins.com.br/coreos-como-realizar-a-instalacao-basica/
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfiguration {
    local PRIVATE_IPV4="${1}";
    local INTERFACE="enp0s8";

    printf '%b\n' "Initializing the (Network) configuration on the system...";

    # add static network configuration in file: '/etc/systemd/network/static.network'
    local staticNetworkFile="/etc/systemd/network/static.network";
    touch ${staticNetworkFile}
    { 
        echo '[Match]';
        echo 'Name='$INTERFACE'';
        echo '';
        echo '[Network]';
        echo 'Address='$PRIVATE_IPV4'';
        echo '#Gateway=192.168.33.1';
        echo '#DNS=8.8.8.8';

    } > ${staticNetworkFile};
    chmod 644 ${staticNetworkFile};

    systemctl restart systemd-networkd;

    networkctl status;
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;