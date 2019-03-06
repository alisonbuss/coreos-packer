#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration and installation of a container platform(Docker).
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_DOCKER_VERSION='...'
# @fonts:
#     https://coreos.com/os/docs/latest/customizing-docker.html
#     https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-worker/
#     https://coreos.com/blog/toward-docker-17-in-container-linux
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Docker. 
readonly VAR_DOCKER_VERSION="${PACKER_DOCKER_VERSION:-18.06.1}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Docker in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- ${0}";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_DOCKER_VERSION: ${VAR_DOCKER_VERSION}";
    }

    # @descr: Function to download Docker. 
    __download_docker() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Docker)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/docker";
        local url="https://download.docker.com/linux/static/stable/x86_64/docker-${VAR_DOCKER_VERSION}-ce.tgz";
        wget -O "${path}/docker-v${VAR_DOCKER_VERSION}-ce.tgz" "${url}";
    }

    # @descr: docker installation function.
    __install_docker() {
        printf '%b\n'   "### PACKER: --INFO: Starting the installation of (Docker)!";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n'   "### PACKER: --WARNING: CoreOS already has (Docker) installed on your system.";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n' "--Execution path:";
        which docker;
        printf '%b\n' "--Version:";
        docker version;
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Docker.
    __download_docker;

    # Starting installation of Docker.
    __install_docker;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-docker.log";

# @descr: Finishing the script!!! :P
exit 0;
