#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script of the installation of Python in CoreOS to enable provisioning with Ansible.
# @fonts: https://gist.github.com/jason-riddle/b88db998c3cceede4f7879c439bf8186
#         https://makefile.blog/2017/06/02/install-python-on-coreos/
#         https://github.com/ziozzang/python-on-coreos/blob/master/install-python-on-coreos.sh
#         https://github.com/holms/ansible-coreos/blob/master/roles/coreos/tasks/coreos.yml
#         https://vadosware.io/post/installing-python-on-coreos-with-ansible/
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    
    printf '%b\n' "Starting the installation of (ActivePython)...";

    # Creating installation directories.
    mkdir -p "/opt/bin";
    mkdir -p "/opt/python";
    
    # Extracting support files: 'active-python.tar.gz'.
    tar -zxf /support-files/active-python-v*/active-python.tar.gz -C /opt;

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

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;