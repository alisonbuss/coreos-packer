#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://blog.kingj.net/2017/04/22/how-to/upgrading-a-etcd-cluster-from-version-2-3-to-version-3-0-on-coreos-container-linux/
#         https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/interacting_v3.md
#         https://dzone.com/articles/upgrading-kubernetes-on-bare-metal-coreos-cluster-1    
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {
    
    printf '%b\n' "CoreOS already has (ETCD-3) installed on your system...";
    
    # Define default values.
    #local profileEnvFile="/etc/profile.env";
    #local bashrcEnvFile="/etc/bash/bashrc.env";
  
    # Add environment variable in file: '/etc/profile.env'
    #touch "${profileEnvFile}"
    # {
    #    echo '# Enabling (ETCD-3) on the system';
    #    echo 'export ETCDCTL_API=3';
    # } >> "${profileEnvFile}";

    #chmod 644 ${profileEnvFile};
    #source ${profileEnvFile};

    # Add environment variable in file: '/etc/bash/bashrc.env'
    #touch "${bashrcEnvFile}"
    # {
    #    echo '# Enabling (ETCD-3) on the system';
    #    echo 'export ETCDCTL_API=3';
    # } >> "${bashrcEnvFile}";

    #chmod 644 ${bashrcEnvFile};
    #source ${bashrcEnvFile};

    #etcdctl v;
    #curl -L http://127.0.0.1:2379/version;
    #etcdctl --write-out=table --endpoints=localhost:2379 member list;
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;