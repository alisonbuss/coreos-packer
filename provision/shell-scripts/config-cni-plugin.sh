#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: CNI (Container Network Interface), consists of a specification and 
#         libraries for writing plugins to configure network interfaces in 
#         Linux containers, along with a number of supported plugins.
#         The Kubelet can use CNI (the Container Network Interface) to 
#         manage machine level networking requirements.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_CNI_PLUGIN_VERSION='...'
# @fonts:
#     https://github.com/containernetworking/cni
#     https://github.com/containernetworking/plugins
#     https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-at-scaleway-part-7/
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of CNI Plugin. 
readonly VAR_CNI_PLUGIN_VERSION="${PACKER_CNI_PLUGIN_VERSION:-0.7.4}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of CNI Plugin in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-cni-plugin.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_CNI_PLUGIN_VERSION: ${VAR_CNI_PLUGIN_VERSION}";
    }

    # @descr: Function to download CNI Plugin. 
    __download_cni_plugin() {
        printf '%b\n'   "### PACKER: --INFO: Start download (CNI Plugin)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/cni-plugins";
        local url="https://github.com/containernetworking/plugins/releases/download/v${VAR_CNI_PLUGIN_VERSION}/cni-plugins-amd64-v${VAR_CNI_PLUGIN_VERSION}.tgz";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/cni-plugins-v${VAR_CNI_PLUGIN_VERSION}.tgz" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # Starting print of information.
    __print_debug;

    # Starting download of CNI Plugin.
    __download_cni_plugin;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-cni-plugin.log";

# @descr: Finishing the script!!! :P
exit 0;
