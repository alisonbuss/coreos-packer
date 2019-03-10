#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script of the installation(Docker Compose) for Docker on CoreOS.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_DOCKER_COMPOSE_VERSION='...'
# @fonts:
#     https://docs.docker.com/compose/install/#install-compose
#     https://github.com/docker/compose/releases/
#     https://gist.github.com/jonatanblue/e6c319aa95673eaf8acc475f92e961d5
#     https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html
#     https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html#usingdockerpy
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Docker Compose. 
readonly VAR_DOCKER_COMPOSE_VERSION="${PACKER_DOCKER_COMPOSE_VERSION:-1.23.2}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Docker Compose in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-docker-compose.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_DOCKER_COMPOSE_VERSION: ${VAR_DOCKER_COMPOSE_VERSION}";
    }

    # @descr: Function to download Docker Compose. 
    __download_docker_compose() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Docker Compose)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/docker-compose";
        local url="https://github.com/docker/compose/releases/download/${VAR_DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/docker-compose-v${VAR_DOCKER_COMPOSE_VERSION}" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # @descr: Docker Compose installation function.
    __install_docker_compose() {
        printf '%b\n'   "### PACKER: --INFO: Starting the installation of (Docker Compose)!";
        printf '%b\n\n' "*********************************************************";

        # Creating installation directory: '/opt/bin/'
        mkdir -p "/opt/bin";

        # Starting install from docker-compose
        cp "${VAR_DEPLOYMENT_DIR}/docker-compose/docker-compose-v${VAR_DOCKER_COMPOSE_VERSION}" "/opt/bin/docker-compose";

        # set execution rights
        chmod +x /opt/bin/docker-compose;

        # BUG: 
        # Run shell -> $ docker-compose version
        # WARNING: Dependency conflict: an older version of the 'docker-py' package may be polluting
        # the namespace. If you're experiencing crashes, run the following command to remedy the issue:
        # pip uninstall docker-py; pip uninstall docker; pip install docker
        # docker-compose version 1.19.0, build 9e633ef
        # SOLUTION:
        printf '%b\n' "--run pip upgrade...";
        pip install --upgrade pip;
        printf '%b\n' "--run pip uninstall docker-py...";
        pip uninstall -y docker-py;
        printf '%b\n' "--run pip install docker...";
        pip install docker;

        printf '%b\n' "--Execution path:";
        which docker-compose;
        printf '%b\n' "--Version:";
        docker-compose version;
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Docker Compose.
    __download_docker_compose;

    # Starting installation of Docker Compose.
    __install_docker_compose;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-docker-compose.log";

# @descr: Finishing the script!!! :P
exit 0;
