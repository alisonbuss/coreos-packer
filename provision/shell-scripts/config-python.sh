#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script of the installation of Python in CoreOS to enable provisioning with Ansible.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_PYTHON_VERSION='...'
# @fonts: 
#     https://gist.github.com/jason-riddle/b88db998c3cceede4f7879c439bf8186
#     https://makefile.blog/2017/06/02/install-python-on-coreos/
#     https://github.com/ziozzang/python-on-coreos/blob/master/install-python-on-coreos.sh
#     https://github.com/holms/ansible-coreos/blob/master/roles/coreos/tasks/coreos.yml
#     https://vadosware.io/post/installing-python-on-coreos-with-ansible/
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Python. 
readonly VAR_PYTHON_VERSION="${PACKER_PYTHON_VERSION:-2.7.14}";


# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Python in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-python.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_PYTHON_VERSION: ${VAR_PYTHON_VERSION}";
    }

    # @descr: Function to download Active Python. 
    #         WARNING: Fixed version(2.7.14), it is difficult to standardize the URL of this crap.
    __download_python() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Active Python)!";
        printf '%b\n\n' "*********************************************************";

        printf '%b\n'   "### PACKER: --WARNING: The download of Active Python is the fixed version(2.7.14), it is difficult to standardize the URL of this crap.";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/active-python";
        local url="https://downloads.activestate.com/ActivePython/releases/2.7.14.2717/ActivePython-2.7.14.2717-linux-x86_64-glibc-2.12-404899.tar.gz";
        # Create directories and download binaries...
        mkdir -p "${path}";
        wget -O "${path}/active-python-v2.7.14.tar.gz" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
    }

    # @descr: Active Python installation function.
    __install_python() {
        printf '%b\n'   "### PACKER: --INFO: Starting the installation of (ActivePython)!";
        printf '%b\n\n' "*********************************************************";

        # Creating installation directories.
        mkdir -p "/opt/bin";
        mkdir -p "/opt/python";
        
        # Extracting support files: 'active-python.tar.gz'.
        echo "Unpacking package: active-python-v2.7.14.tar.gz..."
        tar -zxf "${VAR_DEPLOYMENT_DIR}/active-python/active-python-v2.7.14.tar.gz" -C /opt;

        # Starting installation for '/opt/python/'...
        mv /opt/ActivePython-* /opt/apy && cd /opt/apy && ./install.sh -I /opt/python;

        ln -sf /opt/python/bin/easy_install /opt/bin/easy_install;
        ln -sf /opt/python/bin/pip /opt/bin/pip;
        ln -sf /opt/python/bin/python /opt/bin/python;
        ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv;

        /opt/bin/python --version;
        export PATH=$PATH:/opt/python/bin;

        # Remove the folder and files from the temporary installation.
        rm -rf /opt/apy;
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Python.
    __download_python;

    # Starting installation of Python.
    __install_python;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-python.log";

# @descr: Finishing the script!!! :P
exit 0;
