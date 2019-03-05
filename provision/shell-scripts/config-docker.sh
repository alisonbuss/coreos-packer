#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_DOCKER_VERSION='...'
function StartScript {

    # @descr: Variable: Directory of deployment files. 
    local DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";
    
    # @descr: Variable: Version of Docker. 
    local DOCKER_VERSION="${PACKER_DOCKER_VERSION:-18.06.1}";

    # @descr: Function to download Docker. 
    __download_docker() {
        local path="${DEPLOYMENT_DIR}/docker";
        local url="https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz";
        printf '%b\n' "Starting the download of (Docker)...";
        wget -O "${path}/docker-v${DOCKER_VERSION}-ce.tgz" "${url}";
    }

    # @descr: Docker installation function.
    __install_docker() {
        printf '%b\n' "CoreOS already has (Docker) installed on your system...";
    
        printf '%b\n' "--Execution path:";
        which docker;
        printf '%b\n' "--Version:";
        docker version;
    }

    # Starting download of Docker.
    __download_docker;

    # Starting installation of Docker.
    __install_docker;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "/var/log/packer-config-docker.log";

# @descr: Finishing the script!!! :P
exit 0;
