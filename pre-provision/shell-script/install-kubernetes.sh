#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://github.com/stylelab-io/kubernetes-coreos-packer/blob/master/scripts/kubernetes.sh
#         https://severalnines.com/blog/installing-kubernetes-cluster-minions-centos7-manage-pods-services
#         https://www.linuxtechi.com/install-kubernetes-1-7-centos7-rhel7/
#         https://www.upcloud.com/support/deploy-kubernetes-coreos/  
#         https://github.com/coreos/coreos-kubernetes/tree/master/multi-node/generic
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {

    printf '%b\n' "Starting the installation of (Kubernetes)...";

    # new version "v1.9.2"
    # https://github.com/kubernetes/kubernetes/releases/download/v1.9.2/kubernetes.tar.gz
    # SHA256: 7a922d49b1194cb1b59b22cecb4eb1197f7c37250d4326410dc71aa5dc5ec8a2



    ################################################
    #  Installs Kubernetes files to /opt/bin
    #  and adds the make-cert scripts

    #version=${KUBE_VERSION:-v1.0.6}

    #wget -q https://github.com/kubernetes/kubernetes/releases/download/${version}/kubernetes.tar.gz
    #tar -xf kubernetes.tar.gz
    #sudo mkdir -p /opt/kubernetes
    #tar -xvf ./kubernetes/server/kubernetes-salt.tar.gz
    #tar -xvf ./kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    #sudo cp ./kubernetes/server/bin/kubectl /opt/bin/kubectl
    #sudo cp ./kubernetes/server/bin/kubelet /opt/bin/kubelet
    #sudo cp ./kubernetes/server/bin/kube-proxy /opt/bin/kube-proxy
    #sudo cp ./kubernetes/server/bin/kube-apiserver /opt/bin/kube-apiserver
    #sudo cp ./kubernetes/server/bin/kube-controller-manager /opt/bin/kube-controller-manager
    #sudo cp ./kubernetes/server/bin/linkcheck /opt/bin/linkcheck
    #sudo cp ./kubernetes/server/bin/kube-scheduler /opt/bin/kube-scheduler
    #sudo cp ./kubernetes/saltbase/salt/generate-cert/make-ca-cert.sh ./make-ca-cert.sh
    #sudo cp ./kubernetes/saltbase/salt/generate-cert/make-cert.sh ./make-cert.sh

    #echo "export PATH=/opt/bin:\$PATH" > ~/.bashrc

    #rm -rf kubernetes kubernetes.tar.gz
    
} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;