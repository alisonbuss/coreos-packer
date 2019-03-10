#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script to execute downloads (files and binaries) to provide
#         support and performance in the provisioning the operating system.
# @fonts: https://www.packer.io/intro/why.html
#         https://www.tecmint.com/10-wget-command-examples-in-linux/
#         https://www.lifewire.com/uses-of-command-wget-2201085
#         https://www.maketecheasier.com/curl-vs-wget/  
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#     DEP_ACTIVE_PYTHON='2.7.13'
#     DEP_CNI_PLUGIN='0.7.1'
#     DEP_PEERVPN='0-044'
#     DEP_RKT='1.30.0'
#     DEP_DOCKER='18.04.0'
#     DEP_DOCKER_COMPOSE='1.19.0'
#     DEP_ETCD='3.2.15'
#     DEP_FLANNEL='0.10.0'
#     DEP_KUBERNETES='1.10.0'
function StartScript {

    __download_active_python() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="http://downloads.activestate.com/ActivePython/releases/${version}.2714";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of ActivePython.
        wget -O "${folder}/active-python.tar.gz" "${url}/ActivePython-${version}.2714-linux-x86_64-glibc-2.12-402178.tar.gz";
    }

    __download_cni_plugins() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://github.com/containernetworking/plugins/releases/download/v${version}";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of CNI Plugins.
        wget -O "${folder}/cni-plugins.tgz" "${url}/cni-plugins-amd64-v${version}.tgz";
    }

    __download_peervpn() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://peervpn.net/files";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of PeerVPN.
        wget -O "${folder}/peervpn.tar.gz" "${url}/peervpn-${version}-linux-x86.tar.gz";
    }

    __download_rkt() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://github.com/rkt/rkt/releases/download/v${version}";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Rkt.
        wget -O "${folder}/rkt.tar.gz" "${url}/rkt-v${version}.tar.gz";
    }

    __download_docker() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://download.docker.com/linux/static/stable/x86_64";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Docker.
        wget -O "${folder}/docker.tgz" "${url}/docker-${version}.tgz";
    }

    __download_docker_compose() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://github.com/docker/compose/releases/download/${version}";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Docker Compose.
        wget -O "${folder}/docker-compose" "${url}/docker-compose-Linux-x86_64";
    }

    __download_etcd() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://github.com/coreos/etcd/releases/download/v${version}";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Etcd.
        wget -O "${folder}/etcd.tar.gz" "${url}/etcd-v${version}-linux-amd64.tar.gz";
    }

    __download_flannel() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://github.com/coreos/flannel/releases/download/${version}";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Flannel.
        wget -O "${folder}/flanneld" "${url}/flanneld-amd64";
    }

    __download_kubernetes() {
        local version="${1}";
        local folder="${2}-v${version}";
        local url="https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64";
        # Create a support folder for the files and binaries.
        mkdir -p "${folder}";
        # Starting downloading of Kubernetes.
        wget -O "${folder}/kube-apiserver" "${url}/kube-apiserver";
        wget -O "${folder}/kube-controller-manager" "${url}/kube-controller-manager";
        wget -O "${folder}/kube-scheduler" "${url}/kube-scheduler";
        wget -O "${folder}/kube-proxy" "${url}/kube-proxy";
        wget -O "${folder}/kubelet" "${url}/kubelet";
        wget -O "${folder}/kubectl" "${url}/kubectl";
    }

    printf '%b\n' "Starting to downloads(files and binaries) for system support...";

    __download_activepython    "${DEP_ACTIVE_PYTHON:-2.7.13}"   "/support-files/active-python";
    __download_cni_plugins     "${DEP_CNI_PLUGIN:-0.7.1}"       "/support-files/cni-plugins";
    __download_peervpn         "${DEP_PEERVPN:-0-044}"          "/support-files/peervpn";
    __download_rkt             "${DEP_RKT:-1.30.0}"             "/support-files/rkt";
    __download_docker          "${DEP_DOCKER:-18.04.0}"         "/support-files/docker";
    __download_docker_compose  "${DEP_DOCKER_COMPOSE:-1.19.0}"  "/support-files/docker-compose";
    __download_etcd            "${DEP_ETCD:-3.2.15}"            "/support-files/etcd";
    __download_flannel         "${DEP_FLANNEL:-0.10.0}"         "/support-files/flannel";
    __download_kubernetes      "${DEP_KUBERNETES:-1.10.0}"      "/support-files/kubernetes";

    # Providing permissions to (support folder).
    chmod -R 0755 /support-files;

    printf '%b\n' "--INFO: List all the contents of the support folder, to install and assist in the future.";
    ls -R /support-files;

} 

# @descr: Call of execution of the script's main function.
StartScript "$@";

# @descr: Finishing the script!!! :P
exit 0;

