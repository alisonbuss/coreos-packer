#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://gist.github.com/jason-riddle/b88db998c3cceede4f7879c439bf8186
#         https://github.com/ziozzang/python-on-coreos/blob/master/install-python-on-coreos.sh
#         https://github.com/holms/ansible-coreos/blob/master/roles/coreos/tasks/coreos.yml
#         https://vadosware.io/post/installing-python-on-coreos-with-ansible/
# @example:
#
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    local VERSION="2.7.13.2714"
    local PACKAGE="ActivePython-${VERSION}-linux-x86_64-glibc-2.12-402178"

    mkdir -p /opt/bin/;
    mkdir -p /opt/python/;
    cd /opt;

    wget "http://downloads.activestate.com/ActivePython/releases/${VERSION}/${PACKAGE}.tar.gz";
    tar -xzvf ${PACKAGE}.tar.gz;

    mv ${PACKAGE} apy && cd apy && ./install.sh -I /opt/python/;

    ln -sf /opt/python/bin/easy_install /opt/bin/easy_install
    ln -sf /opt/python/bin/pip /opt/bin/pip
    ln -sf /opt/python/bin/python /opt/bin/python
    ln -sf /opt/python/bin/python /opt/bin/python2
    ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv

    #local activePython="2.7.13.2714/ActivePython-2.7.13.2714-linux-x86_64-glibc-2.12-402178.tar.gz";
    #printf '%b\n' "Starting the installation of (Active Python).";

    #printf '%b\n' "--> Creating installation directories...";
    #mkdir -p /opt/bin/;
    #mkdir -p /opt/python/;

    #printf '%b\n' "--> Starting download: ActivePython-2.7...tar.gz...";
    #wget -nc -O /tmp/ActivePython.tar.gz "http://downloads.activestate.com/ActivePython/releases/${activePython}";

    #ls /tmp/;

    #printf '%b\n' "--> Extracting files: '/tmp/ActivePython.tar.gz -C /tmp'...";
    #tar -xzvf /tmp/ActivePython.tar.gz -C /tmp;

    #ls /tmp/;

    #printf '%b\n' "--> Starting installation...";
    #bash /tmp/ActivePython-*/install.sh -I /opt/python/;

    #ls /opt/;
    #ls /opt/python/;

    #ln -s /opt/python/bin/easy_install /opt/bin/easy_install;
    #ln -s /opt/python/bin/pip /opt/bin/pip;
    #ln -s /opt/python/bin/python /opt/bin/python;
    #ln -s /opt/python/bin/virtualenv /opt/bin/virtualenv;
    #rm -rf /tmp/*   
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;