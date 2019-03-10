#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration and installation of an Flannel service.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_FLANNEL_VERSION='...'
# @fonts:
#     https://github.com/coreos/flannel/issues/554
#     https://coreos.com/flannel/docs/latest/flannel-config.html
#     https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Flannel. 
readonly VAR_FLANNEL_VERSION="${PACKER_FLANNEL_VERSION:-0.10.0}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Flannel in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-flannel.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_FLANNEL_VERSION: ${VAR_FLANNEL_VERSION}";
    }

    # @descr: Function to download Flannel. 
    __download_flannel() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Flannel)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/flannel";
        local url="https://github.com/coreos/flannel/releases/download/v${VAR_FLANNEL_VERSION}/flanneld-amd64";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/flanneld-v${VAR_FLANNEL_VERSION}" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # @descr: Flannel installation function.
    __install_flannel() {
        printf '%b\n'   "### PACKER: --INFO: Starting the installation of (Flannel)!";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n'   "### PACKER: --WARNING: Configuration not implemented!";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n'   "### PACKER: --WARNING: However, it will be installed in the future as a Container(Rkt).";
        printf '%b\n\n' "*********************************************************";

        # Download and verify an ACI Flannel
        # Using the fetch subcommand you can download and verify an ACI without immediately
        # running a pod. This can be useful to precache ACIs on a large number of hosts:
        # https://coreos.com/releases/#1632.3.0
        # https://quay.io/repository/coreos/flannel?tab=tags
        # https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
        printf '%b\n'   "### PACKER: --INFO: Starting downloading of the image(Flannel:v${VAR_FLANNEL_VERSION}) to be used in the (Rkt).";
        printf '%b\n\n' "*********************************************************";
        rkt fetch "quay.io/coreos/flannel:v${VAR_FLANNEL_VERSION}" --insecure-options=image;
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Flannel.
    __download_flannel;

    # Starting installation of Flannel.
    __install_flannel;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-flannel.log";

# @descr: Finishing the script!!! :P
exit 0;
