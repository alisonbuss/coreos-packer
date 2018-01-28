#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
# @example:
#
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    printf '%b\n' "CoreOS already has (ETCD-3) installed on your system.";
    printf '%b\n' "--> Enabling (ETCD-3) on the system...";

    printf '%b\n' "----> Add environment variable in file: '/etc/profile.env'";
    local profileEnvFile="/etc/profile.env"
    echo "# Enabling (ETCD-3) on the system." >  $profileEnvFile;
    echo "export ETCDCTL_API=3"               >> $profileEnvFile;
    chmod 644 $profileEnvFile;
    source $profileEnvFile;

    printf '%b\n' "----> Add environment variable in file: '/etc/bash/bashrc.env'";
    local bashrcEnvFile="/etc/bash/bashrc.env"
    echo "# Enabling (ETCD-3) on the system." >  $bashrcEnvFile;
    echo "export ETCDCTL_API=3"               >> $bashrcEnvFile;
    chmod 644 $bashrcEnvFile;
    source $bashrcEnvFile;

    etcdctl v;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;