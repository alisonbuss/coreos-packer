#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

# @descr: The root directory of the Project. 
readonly ROOT_DIRECTORY="../../";

make --directory ${ROOT_DIRECTORY} \
                 ENVIRONMENT="production" \
                 PLATFORM="aws" \
                 plan clear compile validate build \
                 2>&1 | tee "${ROOT_DIRECTORY}/builds/production/deploy-image.log";

exit 0;
