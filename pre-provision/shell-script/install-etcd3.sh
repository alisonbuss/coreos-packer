#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: 
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    printf '%b\n' "CoreOS already has (ETCD-3) installed on your system.";
    
    # Define default values.
    local profileEnvFile="/etc/profile.env";
    local bashrcEnvFile="/etc/bash/bashrc.env";
  
    # Add environment variable in file: '/etc/profile.env'
    touch "${profileEnvFile}"
    {
        echo '# Enabling (ETCD-3) on the system';
        echo 'export ETCDCTL_API=3';
    } >> "${profileEnvFile}";

    chmod 644 ${profileEnvFile};
    source ${profileEnvFile};

    # Add environment variable in file: '/etc/bash/bashrc.env'
    touch "${bashrcEnvFile}"
    {
        echo '# Enabling (ETCD-3) on the system';
        echo 'export ETCDCTL_API=3';
    } >> "${bashrcEnvFile}";

    chmod 644 ${bashrcEnvFile};
    source ${bashrcEnvFile};

    etcdctl v;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;