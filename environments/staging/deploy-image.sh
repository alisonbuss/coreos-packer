#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

# @descr: The root directory of the Project. 
readonly ROOT_DIRECTORY="../../";

make --directory ${ROOT_DIRECTORY} \
                 ENVIRONMENT="staging" \
                 PLATFORM="google" \
                 plan clear validate build \
                 2>&1 | tee "${ROOT_DIRECTORY}/builds/staging/deploy-image.log";

exit 0;
