#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration and installation of a container platform(RKT).
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_RKT_VERSION='...'
# @fonts:
#     https://coreos.com/rkt/docs/latest/distributions.html
#     https://coreos.com/rkt/docs/latest/install-rkt-in-coreos.html
#     https://coreos.com/rkt/docs/latest/trying-out-rkt.html#using-rkt-on-linux
#     https://rocket.readthedocs.io/en/latest/Documentation/trying-out-rkt/
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of rkt. 
readonly VAR_RKT_VERSION="${PACKER_RKT_VERSION:-1.30.0}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Rkt in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-rkt.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_RKT_VERSION: ${VAR_RKT_VERSION}";
    }

    # @descr: Function to download rkt. 
    __download_rkt() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Rkt)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/rkt";
        local url="https://github.com/rkt/rkt/releases/download/v${VAR_RKT_VERSION}/rkt-v${VAR_RKT_VERSION}.tar.gz";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/rkt-v${VAR_RKT_VERSION}.tar.gz" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # @descr: Rkt installation function.
    __install_rkt() {
        printf '%b\n'   "### PACKER: --INFO: Starting the installation of (Rkt)!";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n'   "### PACKER: --WARNING: CoreOS already has (Rkt) installed on your system.";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n' "--Execution path:";
        which rkt;
        printf '%b\n' "--Version:";
        rkt version;
    }

    # Starting print of information.
    __print_debug;

    # Starting download of rkt.
    __download_rkt;

    # Starting installation of Rkt.
    __install_rkt;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-rkt.log";

# @descr: Finishing the script!!! :P
exit 0;
