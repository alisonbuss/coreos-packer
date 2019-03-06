#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make --directory ../ ENVIRONMENT="development" \
                     PLATFORM="virtualbox" \
                     CREDENTIAL="vagrant" \

                     plan \

                     2>&1 | tee "../builds/deploy-development.log";



# make --directory ../ ENVIRONMENT="development" \
#                      PLATFORM="virtualbox" \
#                      CREDENTIAL="vagrant" \
#                      plan clear compile validate build \
#                      deploy-vagrant-box publish-vagrant-box \
#                      2>&1 | tee "../builds/deploy-development.log";

exit 0;
