#!/bin/bash

# font: https://github.com/stylelab-io/kubernetes-coreos-packer/blob/master/scripts/cleanup.sh
# remove the machine id. it will be regenerated on first boot.
rm -fr /etc/machine-id;