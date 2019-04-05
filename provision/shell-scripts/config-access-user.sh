#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration of an admin user for deploying
#         resources in the system.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
# @fonts:
#     https://gist.github.com/thimbl/877090
#     http://eosrei.net/articles/2012/08/scripting-public-key-access-only-user-creation-linux
#     http://www.dicas-l.com.br/arquivo/comando_adduser_completo.php#.XJclyMtKhhE
#     http://manpages.ubuntu.com/manpages/bionic/man8/useradd.8.html
#     https://linuxize.com/post/how-to-list-users-in-linux/
#     https://www.computerhope.com/unix/useradd.htm
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
        printf '%b\n'   "### PACKER: Starting the configuration of an admin user for deploying...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-access-user.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n\n' "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
    }

    # @descr: Creation of the deployment user.
    __create_deployment_user() {
        printf '%b\n' "### PACKER: --INFO: Starting the creation of the deployment user!";
        printf '%b\n' "*********************************************************";

        local username="deploy";
        local password="lucifer";
        local home_dir="/home/${username}";
        local ssh_file="${VAR_DEPLOYMENT_DIR}/ssl-certificates/deploy_public_key.pub";

        # userdel --remove "${username}";

        useradd --user-group --create-home "${username}" \
                             --home-dir    "${home_dir}" \
                             --password    "${password}" \
                             --shell       "/bin/bash" \
                             --groups      "sudo";

        echo "${username} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${username}";
        chmod 644 "/etc/sudoers.d/${username}";

        mkdir -p "${home_dir}/.ssh";

        cp "${ssh_file}" "${home_dir}/.ssh/authorized_keys";

        chmod 700 "${home_dir}/.ssh";
        chmod 644 "${home_dir}/.ssh/authorized_keys";
    }

    # Starting print of information.
    __print_debug;

    # Starting the creation of the user.
    __create_deployment_user;
}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-access-user.log";

# @descr: Finishing the script!!! :P
exit 0;
