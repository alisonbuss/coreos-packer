#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

# @descr: The root directory of the Project. 
readonly ROOT_DIRECTORY="../../";

make --directory ${ROOT_DIRECTORY} \
                 ENVIRONMENT="development" \
                 PLATFORM="virtualbox" \
                 plan deploy-vagrant-box \
                 2>&1 | tee "${ROOT_DIRECTORY}/builds/development/deploy-image1.log";


# ORIGINAL
# make --directory ../ ENVIRONMENT="development" \
#                      PLATFORM="virtualbox" \
#                      CREDENTIAL="vagrant" \
#                      plan clear compile validate build \
#                      deploy-vagrant-box publish-vagrant-box \
#                      2>&1 | tee "../builds/deploy-development.log";

exit 0;
