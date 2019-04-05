#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration and downloading of an Etcd.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_ETCD_VERSION='...'
# @fonts:
#     https://blog.kingj.net/2017/04/22/how-to/upgrading-a-etcd-cluster-from-version-2-3-to-version-3-0-on-coreos-container-linux/
#     https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/interacting_v3.md
#     https://dzone.com/articles/upgrading-kubernetes-on-bare-metal-coreos-cluster-1
#     https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci  
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Etcd. 
readonly VAR_ETCD_VERSION="${PACKER_ETCD_VERSION:-3.3.9}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Etcd in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-etcd.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_ETCD_VERSION: ${VAR_ETCD_VERSION}";
    }

    # @descr: Function to download Etcd. 
    __download_etcd() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Etcd)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/etcd";
        local url="https://github.com/coreos/etcd/releases/download/v${VAR_ETCD_VERSION}/etcd-v${VAR_ETCD_VERSION}-linux-amd64.tar.gz";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/etcd-v${VAR_ETCD_VERSION}.tar.gz" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Etcd.
    __download_etcd;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-etcd.log";

# @descr: Finishing the script!!! :P
exit 0;
