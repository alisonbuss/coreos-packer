#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for finalization from provisioning of the Image.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
# @fonts:
#     https://blog.kingj.net/2017/04/22/how-to/upgrading-a-etcd-cluster-from-version-2-3-to-version-3-0-on-coreos-container-linux/
#     https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/interacting_v3.md
#     https://dzone.com/articles/upgrading-kubernetes-on-bare-metal-coreos-cluster-1
#     https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
#     https://github.com/coreos/flannel/issues/554
#     https://coreos.com/flannel/docs/latest/flannel-config.html
#     https://www.ostechnix.com/find-size-directory-linux/
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files.
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting configurations and adjustments final of the Image...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-finalize.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n\n' "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
    }

    # @descr: Configuration final function.
    __start_configuration() {
        printf '%b\n'   "### PACKER: --INFO: Starting the Configuration final of the Image!";
        printf '%b\n\n' "*********************************************************";

        # font: https://github.com/stylelab-io/kubernetes-coreos-packer/blob/master/scripts/cleanup.sh
        # remove the machine id. it will be regenerated on first boot.
        printf '%b\n'   "### PACKER: --WARNING: Remove the machine id, path: '/etc/machine-id'.";
        printf '%b\n\n' "*********************************************************";
        rm -rf /etc/machine-id;

        # Other codes for finalization of the image....
        # ...

        # Providing permissions to (deployment files).
        chmod -R 0755 "${VAR_DEPLOYMENT_DIR}";

        printf '%b\n'   "### PACKER: --INFO: List all the contents of the (deployment files).";
        printf '%b\n\n' "*********************************************************";
        du -ah "${VAR_DEPLOYMENT_DIR}/";
        du -ch "${VAR_DEPLOYMENT_DIR}/" | grep total;
        echo "In 33 seconds the system will finish..." && sleep 33s;
    }

    # Starting print of information.
    __print_debug;

    # Starting configuration final.
    __start_configuration;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-finalize.log";

# @descr: Finishing the script!!! :P
exit 0;
