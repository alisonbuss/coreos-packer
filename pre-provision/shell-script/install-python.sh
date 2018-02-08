#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
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

    # Define default values.
    local VERSION="2.7.13.2714"
    local PACKAGE="ActivePython-${VERSION}-linux-x86_64-glibc-2.12-402178"

    # Creating installation directories.
    mkdir -p /opt/bin/;
    mkdir -p /opt/python/;
    cd /opt;

    # Starting download: 'ActivePython-2.7...tar.gz'.
    wget "http://downloads.activestate.com/ActivePython/releases/${VERSION}/${PACKAGE}.tar.gz";
    
    # Extracting files: 'ActivePython-2.7...tar.gz'.
    tar -xzvf ${PACKAGE}.tar.gz;

    # Starting installation for '/opt/python/'...
    mv ${PACKAGE} apy && cd apy && ./install.sh -I /opt/python/;

    ln -sf /opt/python/bin/easy_install /opt/bin/easy_install;
    ln -sf /opt/python/bin/pip /opt/bin/pip;
    ln -sf /opt/python/bin/python /opt/bin/python;
    ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv;

    /opt/bin/python --version;
    #export PATH=$PATH:/opt/python/bin;

    # Remove files.
    rm -rf /opt/${PACKAGE}.tar.gz;
    rm -rf /opt/apy;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;