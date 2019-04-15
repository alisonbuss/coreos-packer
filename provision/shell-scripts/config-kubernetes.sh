#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Configuration and downloading of an Kubernetes service.
# @param-global:
#     PACKER_DEPLOYMENT_DIR='...'
#     PACKER_LOG_FILES_DIR='...'
#     PACKER_KUBERNETES_VERSION='...'
# @fonts:
#     
#-------------------------------------------------------------#

# @descr: Variable Local: Directory of deployment files. 
readonly VAR_DEPLOYMENT_DIR="${PACKER_DEPLOYMENT_DIR:-/deployment-files}";

# @descr: Variable Local: Directory of log files. 
readonly VAR_LOG_FILES_DIR="${PACKER_LOG_FILES_DIR:-/var/log}";

# @descr: Variable Local: Version of Kubernetes. 
readonly VAR_KUBERNETES_VERSION="${PACKER_KUBERNETES_VERSION:-1.13.0}";


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
    #wget -q --show-progress -O "${path}/${file}" "${url}";
    wget -O "${path}/${file}" "${url}" -nv && echo "Download completed!" || echo "Download not completed!";
}

# @descr: Main function of the script, it runs automatically on the script call.
function StartScript {

    # @descr: Print of system debugging information.
    __print_debug() {
        printf '%b\n'   "### PACKER: Run: $(date)...";
        printf '%b\n'   "### PACKER: Starting the Configurations of Kubernetes in Operating System...";
        printf '%b\n'   "### PACKER: --SHELl:";
        printf '%b\n'   "###           |-- config-kubernetes.sh";
        printf '%b\n'   "### PACKER: --VARS:";
        printf '%b\n'   "###           +-- VAR_DEPLOYMENT_DIR: ${VAR_DEPLOYMENT_DIR}";
        printf '%b\n'   "###           +-- VAR_LOG_FILES_DIR: ${VAR_LOG_FILES_DIR}";
        printf '%b\n\n' "###           +-- VAR_KUBERNETES_VERSION: ${VAR_KUBERNETES_VERSION}";
    }

    # @descr: Function to download Kubernetes. 
    __download_kubernetes() {
        printf '%b\n'   "### PACKER: --INFO: Start download (Kubernetes)!";
        printf '%b\n\n' "*********************************************************";

        local path="${VAR_DEPLOYMENT_DIR}/kubernetes";
        local url="https://storage.googleapis.com/kubernetes-release/release/v${VAR_KUBERNETES_VERSION}/bin/linux/amd64";

        # Starting downloading of Kubernetes.
        echo "kubectl..." && download "kubectl-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kubectl";
        echo "kubelet..." && download "kubelet-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kubelet";
        echo "kube-proxy..." && download "kube-proxy-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kube-proxy";
        echo "kube-scheduler..." && download "kube-scheduler-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kube-scheduler";
        echo "kube-apiserver..." && download "kube-apiserver-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kube-apiserver";
        echo "kube-controller-manager..." && download "kube-controller-manager-v${VAR_KUBERNETES_VERSION}" "${path}" "${url}/kube-controller-manager";
    }

    # Starting print of information.
    __print_debug;

    # Starting download of Kubernetes.
    __download_kubernetes;

}

# @descr: Call of execution of the script's main function.
StartScript "$@" 2>&1 | tee "${VAR_LOG_FILES_DIR}/packer-config-kubernetes.log";

# @descr: Finishing the script!!! :P
exit 0;