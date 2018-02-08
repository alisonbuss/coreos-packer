#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/interacting_v3.md
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartConfiguration {
    local HOSTNAME="${1}-etcd";
    local PRIVATE_IPV4="${2}";
    local CLUSTER_TOKEN=$(echo $(cat /etc/machine-id)-etcd);

    printf '%b\n' "Initializing the (ETCD) configuration on the system...";
    printf '%b\n' "--> Private IP: ${PRIVATE_IPV4}";
    printf '%b\n' "--> Name Server ETCD: ${HOSTNAME}";

    local etcdMemberPath="/etc/systemd/system/etcd-member.service.d";
    local etcdMemberConfFile="etcd-member.conf";

    mkdir -p "${etcdMemberPath}";
    touch "${etcdMemberPath}/${etcdMemberConfFile}"
    { 
        echo '[Service]';
        echo 'ExecStart=';
        echo 'ExecStart=/usr/lib/coreos/etcd-wrapper $ETCD_OPTS \';
        echo '  --name="'${HOSTNAME}'" \';
        echo '  --advertise-client-urls="http://'${PRIVATE_IPV4}':2379" \';
        echo '  --listen-client-urls="http://0.0.0.0:2379" \';
        echo '  --listen-peer-urls="http://'${PRIVATE_IPV4}':2380" \';
        echo '  --initial-advertise-peer-urls="http://'${PRIVATE_IPV4}':2380" \';
        echo '  --initial-cluster="'${HOSTNAME}'=http://'${PRIVATE_IPV4}':2380" \';
        echo '  --initial-cluster-token="'${CLUSTER_TOKEN}'" \';
        echo '  --initial-cluster-state="new"';

    } > "${etcdMemberPath}/${etcdMemberConfFile}";
    chmod 644 ${etcdMemberPath}/${etcdMemberConfFile};

    systemctl daemon-reload;
    systemctl enable etcd-member;
} 

# @descr: Call of execution of the script's main function.
StartConfiguration "$@";

# @descr: Finishing the script!!! :P
exit 0;
