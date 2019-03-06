#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuring a PeerVPN, secure, encrypted virtual network with shared key authentication.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_PEERVPN_VERSION='...'
# @fonts:
#     https://peervpn.net/
#     https://peervpn.net/tutorial/
#     https://lauri.xn--vsandi-pxa.com/lan/peervpn.html
#     https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-at-scaleway-part-3/
#     https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-at-scaleway-part-7/
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of PeerVPN. 
readonly VAR_PEERVPN_VERSION="${PACKER_PEERVPN_VERSION:-0-044}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of PeerVPN in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- ${0}";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_PEERVPN_VERSION: ${VAR_PEERVPN_VERSION}";
    }

    # @descr: Function to download PeerVPN. 
    __download_peervpn() {
        printf '%b\n'   "### PACKER: --INFO: Start download (PeerVPN)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/peervpn";
        local url="https://peervpn.net/files/peervpn-${VAR_PEERVPN_VERSION}-linux-x86.tar.gz";
        wget -O "${path}/peervpn-v${VAR_PEERVPN_VERSION}.tar.gz" "${url}";
    }

    # Starting print of information.
    __print_debug;

    # Starting download of PeerVPN.
    __download_peervpn;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-peervpn.log";

# @descr: Finishing the script!!! :P
exit 0;
