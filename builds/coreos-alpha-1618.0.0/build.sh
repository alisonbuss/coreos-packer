#!/bin/bash

function startBuilding {

    packer build \
        -var-file="./packer/variables-basic.json" \
        -var-file="./packer/variables-vagrant.json" \
        ./packer/template-coreos.json;
    
    vagrant box add a./box/coreos-alpha-vagrant.box;
} 

startBuilding "$@" | tee -a "./logs/${0##*/}.log";

exit 0;