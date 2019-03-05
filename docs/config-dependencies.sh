#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script to execute downloads (files and binaries) to provide
#         support and performance in the provisioning the operating system.
# @fonts: https://www.packer.io/intro/why.html
#         https://www.tecmint.com/10-wget-command-examples-in-linux/
#         https://www.lifewire.com/uses-of-command-wget-2201085
#         https://www.maketecheasier.com/curl-vs-wget/  
#-------------------------------------------------------------#

# @descr: Function to download binaries.
# @param: 
#    file(1) | text: 'kubectl'
#    path(2) | text: '/deployment-files/...'
#    url(3)  | text: 'https://.../bin/linux/amd64/kubectl'
function download() {
    local file="${1}";
    local path="${2}";
    local url="${3}";
    # Create directory for the binaries of the Downloads.
    mkdir -p "${path}";
    # Starting downloading.
    wget -O "${path}/${file}" "${url}";
}

# @descr: Main function of the script, it runs automatically on the script call.
# @param:
#     DEP_DEPLOYMENT_DIR='/deployment-files'
#     DEP_ACTIVE_PYTHON='2.7.14'
#     DEP_CNI_PLUGIN='0.7.4'
#     DEP_PEERVPN='0-044'
#     DEP_RKT='1.30.0'
#     DEP_DOCKER='18.06.1'
#     DEP_DOCKER_COMPOSE='1.23.2'
#     DEP_ETCD='3.3.9'
#     DEP_FLANNEL='0.10.0'
#     DEP_KUBERNETES='1.13.0'
function StartScript {

    # @descr: Variable: Directory of deployment files. 
    local DEP_DEPLOYMENT_DIR="${DEP_DEPLOYMENT_DIR:-/deployment-files}";

    # @descr: Function to download Active Python. 
    #         WARNING: Fixed version(2.7.14), it is difficult to standardize the URL of this crap.
    # @param: 
    #    version | text: '2.7.14'
    __download_active_python() {
        local version="2.7.14";
        local path="${DEP_DEPLOYMENT_DIR}/active-python-v${version}";
        local url="https://downloads.activestate.com/ActivePython/releases/${version}.2717/ActivePython-${version}.2717-linux-x86_64-glibc-2.12-404899.tar.gz";
        echo "--WARNING: Active Python is the fixed version (2.7.14), it is difficult to standardize the URL of this crap.";
        download "active-python.tar.gz" "${path}" "${url}";
    }

    # @descr: Function to download CNI Plugins. 
    # @param: 
    #    version | text: '...'
    __download_cni_plugins() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/cni-plugins-v${version}";
        local url="https://github.com/containernetworking/plugins/releases/download/v${version}/cni-plugins-amd64-v${version}.tgz";

        download "cni-plugins.tgz" "${path}" "${url}";
    }

    # @descr: Function to download Peer VPN. 
    # @param: 
    #    version | text: '...'
    __download_peervpn() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/peervpn-v${version}";
        local url="https://peervpn.net/files/peervpn-${version}-linux-x86.tar.gz";

        download "peervpn.tar.gz" "${path}" "${url}";
    }

    # @descr: Function to download Rkt. 
    # @param: 
    #    version | text: '...'
    __download_rkt() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/rkt-v${version}";
        local url="https://github.com/rkt/rkt/releases/download/v${version}/rkt-v${version}.tar.gz";

        download "rkt.tar.gz" "${path}" "${url}";
    }

    # @descr: Function to download Docker. 
    # @param: 
    #    version | text: '...'
    __download_docker() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/docker-v${version}";
        local url="https://download.docker.com/linux/static/stable/x86_64/docker-${version}-ce.tgz";

        download "docker.tgz" "${path}" "${url}";
    }

    # @descr: Function to download Docker Compose. 
    # @param: 
    #    version | text: '...'
    __download_docker_compose() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/docker-compose-v${version}";
        local url="https://github.com/docker/compose/releases/download/${version}/docker-compose-Linux-x86_64";

        download "docker-compose" "${path}" "${url}";
    }

    # @descr: Function to download Etcd. 
    # @param: 
    #    version | text: '...'
    __download_etcd() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/etcd-v${version}";
        local url="https://github.com/coreos/etcd/releases/download/v${version}/etcd-v${version}-linux-amd64.tar.gz";

        download "etcd.tar.gz" "${path}" "${url}";
    }

    # @descr: Function to download Flannel. 
    # @param: 
    #    version | text: '...'
    __download_flannel() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/flannel-v${version}";
        local url="https://github.com/coreos/flannel/releases/download/v${version}/flanneld-amd64";

        download "flanneld" "${path}" "${url}";
    }

    # @descr: Function to download Kubernetes. 
    # @param: 
    #    version | text: '...'
    __download_kubernetes() {
        local version="${1}";
        local path="${DEP_DEPLOYMENT_DIR}/kubernetes-v${version}";
        local url="https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64";

        # Starting downloading of Kubernetes.
        download "kubectl"                 "${path}" "${url}/kubectl";
        download "kubelet"                 "${path}" "${url}/kubelet";
        download "kube-proxy"              "${path}" "${url}/kube-proxy";
        download "kube-scheduler"          "${path}" "${url}/kube-scheduler";
        download "kube-apiserver"          "${path}" "${url}/kube-apiserver";
        download "kube-controller-manager" "${path}" "${url}/kube-controller-manager";
    }
    
    printf '%b\n' "Starting to download the dependencies in the system...";

    # Starting downloads of the image dependencies.
    __download_active_python   "${DEP_ACTIVE_PYTHON:-2.7.14}";
    __download_cni_plugins     "${DEP_CNI_PLUGIN:-0.7.4}";
    __download_peervpn         "${DEP_PEERVPN:-0-044}";
    __download_rkt             "${DEP_RKT:-1.30.0}";
    __download_docker          "${DEP_DOCKER:-18.06.1}";
    __download_docker_compose  "${DEP_DOCKER_COMPOSE:-1.23.2}";
    __download_etcd            "${DEP_ETCD:-3.3.9}";
    __download_flannel         "${DEP_FLANNEL:-0.10.0}";
    __download_kubernetes      "${DEP_KUBERNETES:-1.13.0}";

    # Providing permissions to (deployment files).
    chmod -R 0755 "${DEP_DEPLOYMENT_DIR}";

    # List all the contents of the (deployment files).
    ls -R "${DEP_DEPLOYMENT_DIR}";
} 

# @descr: Call of execution of the script's main function.
StartScript "$@";

# @descr: Finishing the script!!! :P
exit 0;
