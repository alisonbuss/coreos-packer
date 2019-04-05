#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

# @descr: The root directory of the Project. 
readonly ROOT_DIRECTORY="../../";

# make --directory ${ROOT_DIRECTORY} \
#                  ENVIRONMENT="development" \
#                  PLATFORM="virtualbox" \
#                  plan clear compile validate build \
#                  deploy-vagrant-box publish-vagrant-box \
#                  2>&1 | tee "${ROOT_DIRECTORY}/builds/development/deploy-image.log";

make --directory ${ROOT_DIRECTORY} \
                 ENVIRONMENT="development" \
                 PLATFORM="virtualbox" \
                 plan validate \
                 2>&1 | tee "${ROOT_DIRECTORY}/builds/development/deploy-image.log";

exit 0;
