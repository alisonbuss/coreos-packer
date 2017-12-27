#!/bin/bash
function StartBuilding {
    local path="./packages/coreos-alpha-packer/packer";
    packer build \
		-var-file="${path}/vars-global.json" \
		-var-file="${path}/vars-coreos.json" \
		-var-file="${path}/vars-machine-large.json" \
		-var-file="${path}/vars-vagrant.json" \
        -var-file="${path}/OVERRIDE_VARIABLES.json" \
        "${path}/coreos-template.json";
}
StartBuilding "$@";
exit 0;
