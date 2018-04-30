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
#    $@ | array: (*)
function StartProvisioning {

    printf '%b\n' "Starting to downloads(files and binaries) for system support...";
    
    # Define default values - ActivePython.
    local versionActivePython="2.7.13";
    local folderActivePython="/support-files/active-python-v${versionActivePython}";
    local urlActivePython="http://downloads.activestate.com/ActivePython/releases/${versionActivePython}.2714";
    # Create a support folder for the files and binaries.
    mkdir -p "${folderActivePython}";
    # Starting downloading of ActivePython.
    wget -O "${folderActivePython}/active-python.tar.gz" "${urlActivePython}/ActivePython-${versionActivePython}.2714-linux-x86_64-glibc-2.12-402178.tar.gz";
    
    # Define default values - Kubernetes.
    local versionKubernetes="1.10.0";
    local folderKubernetes="/support-files/kubernetes-v${versionKubernetes}";
    local urlKubernetes="https://storage.googleapis.com/kubernetes-release/release/v${versionKubernetes}/bin/linux/amd64";
    # Create a support folder for the files and binaries.
    mkdir -p "${folderKubernetes}";
    # Starting downloading of Kubernetes.
    wget -O "${folderKubernetes}/kube-apiserver" "${urlKubernetes}/kube-apiserver";
    wget -O "${folderKubernetes}/kube-controller-manager" "${urlKubernetes}/kube-controller-manager";
    wget -O "${folderKubernetes}/kube-scheduler" "${urlKubernetes}/kube-scheduler";
    wget -O "${folderKubernetes}/kube-proxy" "${urlKubernetes}/kube-proxy";
    wget -O "${folderKubernetes}/kubelet" "${urlKubernetes}/kubelet";
    wget -O "${folderKubernetes}/kubectl" "${urlKubernetes}/kubectl";

    # Define default values - CNI Plugins.
    local versionCNIPlugins="0.7.1";
    local folderCNIPlugins="/support-files/cni-plugins-v${versionCNIPlugins}";
    local urlCNIPlugins="https://github.com/containernetworking/plugins/releases/download/v${versionCNIPlugins}";
    # Create a support folder for the files and binaries.
    mkdir -p "${folderCNIPlugins}";
    # Starting downloading of CNI Plugins.
    wget -O "${folderCNIPlugins}/cni-plugins.tgz" "${urlCNIPlugins}/cni-plugins-amd64-v${versionCNIPlugins}.tgz";

    # Define default values - Docker Compose.
    local versionDockerCompose="1.19.0";
    local folderDockerCompose="/support-files/docker-compose-v${versionDockerCompose}";
    local urlDockerCompose="https://github.com/docker/compose/releases/download/${versionDockerCompose}";
    # Create a support folder for the files and binaries.
    mkdir -p "${folderDockerCompose}";
    # Starting downloading of Docker Compose.
    wget -O "${folderDockerCompose}/docker-compose" "${urlDockerCompose}/docker-compose-Linux-x86_64";

    # Providing permissions to (support folder).
    chmod -R 0755 /support-files;

    printf '%b\n' "--INFO: List all the contents of the support folder, to install and assist in the future.";
    ls -R $folderActivePython;
    ls -R $folderKubernetes;
    ls -R $folderCNIPlugins;
    ls -R $folderDockerCompose;

} 

# @descr: Call of execution of the script's main function.
StartProvisioning "$@";

# @descr: Finishing the script!!! :P
exit 0;

