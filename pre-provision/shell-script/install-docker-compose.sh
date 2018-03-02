#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://docs.docker.com/compose/install/#install-compose
#         https://github.com/docker/compose/releases/
#         https://gist.github.com/jonatanblue/e6c319aa95673eaf8acc475f92e961d5
#         https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html
#         https://www.safaribooksonline.com/library/view/docker-cookbook/9781491919705/ch04.html#usingdockerpy
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    
    printf '%b\n' "Starting the installation of (Docker Compose)...";

    # Creating installation directory: '/opt/bin/'
    mkdir -p /opt/bin/;

    # Starting download: docker-compose from github
    wget -O /opt/bin/docker-compose "https://github.com/docker/compose/releases/download/1.19.0/docker-compose-Linux-x86_64";

    # set execution rights
    chmod +x /opt/bin/docker-compose;

    # BUG: 
    # Run shell -> $ docker-compose version
    # WARNING: Dependency conflict: an older version of the 'docker-py' package may be polluting the namespace. If you're experiencing crashes, run the following command to remedy the issue:
    # pip uninstall docker-py; pip uninstall docker; pip install docker
    # docker-compose version 1.19.0, build 9e633ef

    # SOLUTION:
    pip uninstall -y docker-py;
    #pip uninstall -y docker;
    pip install docker;

    docker-compose version;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;