#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configurations and optimization of the operating
#         system(update, sysctl, log) and environment variables.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
# @fonts:
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
        printf '%b\n'   "### PACKER: Starting the Configurations and optimization of the Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-system.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n\n' "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
    }

    # Starting print of information.
    __print_debug;

    printf '%b\n' "### PACKER: --WARNING: Configuration not implemented!";
    printf '%b\n' "*********************************************************";

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-system.log";

# @descr: Finishing the script!!! :P
exit 0;
