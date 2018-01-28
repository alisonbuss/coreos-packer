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
    printf '%b\n' "Starting the installation of (Docker Compose).";

    printf '%b\n' "--> Creating installation directory: '/opt/bin/'...";
    mkdir -p /opt/bin/;

    printf '%b\n' "--> Starting download: docker-compose from github...";
    # -nc don't fetch if file already exists (return 0)
    wget -nc -O /opt/bin/docker-compose "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-linux-x86_64";

    printf '%b\n' "--> set execution rights...";
    chmod +x /opt/bin/docker-compose;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;