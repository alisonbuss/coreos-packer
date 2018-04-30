#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:
# @fonts: https://github.com/coreos/flannel/issues/554
#         https://coreos.com/flannel/docs/latest/flannel-config.html
#         https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartInstallation {

    printf '%b\n' "Starting the installation of (Flannel)...";
    
    printf '%b\n' "--WARNING: Configuration not implemented!!!...";

    printf '%b\n' "--WARNING: However, it will be installed in the future as a Container(Rkt).";

    # Download and verify an ACI Flannel
    # Using the fetch subcommand you can download and verify an ACI without immediately
    # running a pod. This can be useful to precache ACIs on a large number of hosts:
    # https://coreos.com/releases/#1632.3.0
    # https://quay.io/repository/coreos/flannel?tab=tags
    # https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
    printf '%b\n' "Starting downloading of the image(Flannel) to be used in the (Rkt)..";
    printf '%b\n' "--download image: flannel:v0.9.0";
    rkt fetch quay.io/coreos/flannel:v0.9.0 --insecure-options=image;
    
    printf '%b\n' "--download image: flannel:v0.9.1";
    rkt fetch quay.io/coreos/flannel:v0.9.1 --insecure-options=image;
    
    printf '%b\n' "--download image: flannel:v0.10.0";
    rkt fetch quay.io/coreos/flannel:v0.10.0 --insecure-options=image;

} 

# @descr: Call of execution of the script's main function.
StartInstallation "$@";

# @descr: Finishing the script!!! :P
exit 0;