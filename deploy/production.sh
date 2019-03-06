#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make --directory ../ ENVIRONMENT="production" \
                     PLATFORM="aws" \
                     CREDENTIAL="aws" \
                     plan clear compile validate build \
                     2>&1 | tee "../builds/deploy-production.log";

exit 0;
