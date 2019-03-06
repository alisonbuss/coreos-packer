#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make --directory ../ ENVIRONMENT="staging" \
                     PLATFORM="google" \
                     CREDENTIAL="google" \
                     plan clear compile validate build \
                     2>&1 | tee "../builds/deploy-staging.log";

exit 0;
