#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for finalization from provisioning of the Image.
# @fonts: https://blog.kingj.net/2017/04/22/how-to/upgrading-a-etcd-cluster-from-version-2-3-to-version-3-0-on-coreos-container-linux/
#         https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/interacting_v3.md
#         https://dzone.com/articles/upgrading-kubernetes-on-bare-metal-coreos-cluster-1
#         https://coreos.com/rkt/docs/latest/signing-and-verification-guide.html#download-and-verify-an-aci
#         https://github.com/coreos/flannel/issues/554
#         https://coreos.com/flannel/docs/latest/flannel-config.html  
#-------------------------------------------------------------#

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartScript {

    # font: https://github.com/stylelab-io/kubernetes-coreos-packer/blob/master/scripts/cleanup.sh
    # remove the machine id. it will be regenerated on first boot.
    printf '%b\n' "Remove the machine id, path: '/etc/machine-id'.";
    rm -rf /etc/machine-id;

    # Other codes for finalization of the image....
    # ...
    
} 

# @descr: Call of execution of the script's main function.
StartScript "$@";

# @descr: Finishing the script!!! :P
exit 0;