#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts:
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfiguration {
    local dockerServicePath="/etc/systemd/system";
    local dockerTCPSocketFile="docker-tcp.socket";

    printf '%b\n' "Initializing the (Docker) configuration on the system...";

    mkdir -p "${dockerServicePath}";
    touch "${dockerServicePath}/${dockerTCPSocketFile}"
    { 
        echo '[Unit]';
        echo 'Description=Docker Socket for the API';
        echo '';
        echo '[Socket]';
        echo 'ListenStream=2375';
        echo 'Service=docker.service';
        echo 'BindIPv6Only=both';
        echo '';
        echo '[Install]';
        echo 'WantedBy=sockets.target';

    } > "${dockerServicePath}/${dockerTCPSocketFile}";
    chmod 644 ${dockerServicePath}/${dockerTCPSocketFile};

    systemctl daemon-reload;

    systemctl enable docker;
    systemctl enable docker-tcp.socket;
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;
