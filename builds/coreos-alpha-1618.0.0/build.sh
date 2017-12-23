#!/bin/bash

function startBuilding {

    packer build \
        -var-file="./packer/variables-basic.json" \
        -var-file="./packer/variables-vagrant.json" \
        ./packer/template-coreos.json;
    
    #vagrant box add ./box/coreos-alpha-vagrant.box --name "coreos" --box-version "0.0.1";

    #vagrant init coreos;

    #vagrant box remove coreos --box-version=0.0.1  
} 

startBuilding "$@" | tee -a "./logs/${0##*/}.log";

exit 0;