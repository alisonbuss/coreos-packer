#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script of the installation(Docker Compose) for Docker on CoreOS.
# @fonts: https://docs.docker.com/compose/install/#install-compose
#         https://github.com/docker/compose/releases/
#         https://gist.github.com/jonatanblue/e6c319aa95673eaf8acc475f92e961d5
#         https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html
#         https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html#usingdockerpy
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_DOCKER_COMPOSE_VERSION='...'
function StartScript {

    # @descr: Variable: Directory of deployment files. 
    local DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";
    
    # @descr: Variable: Version of Docker Compose. 
    local DOCKER_COMPOSE_VERSION="${PACKER_DOCKER_COMPOSE_VERSION:-1.23.2}";

    # @descr: Function to download Docker Compose. 
    __download_docker_compose() {
        local path="${DEPLOYMENT_DIR}/docker-compose";
        local url="https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64";
        printf '%b\n' "Starting the download of (Docker Compose)...";
        wget -O "${path}/docker-compose-v${DOCKER_COMPOSE_VERSION}.tgz" "${url}";
    }

    # @descr: Docker Compose installation function.
    __install_docker_compose() {
        printf '%b\n' "Starting the installation of (Docker Compose)...";

        # Creating installation directory: '/opt/bin/'
        mkdir -p "/opt/bin";

        # Starting install from docker-compose
        cp "${DEPLOYMENT_DIR}/docker-compose/docker-compose-v${DOCKER_COMPOSE_VERSION} /opt/bin/docker-compose";

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

    # Starting download of Docker Compose.
    __download_docker_compose;

    # Starting installation of Docker Compose.
    __install_docker_compose;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "/var/log/packer-config-docker-compose.log";

# @descr: Finishing the script!!! :P
exit 0;
