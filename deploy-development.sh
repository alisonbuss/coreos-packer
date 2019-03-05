#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make ENVIRONMENT="development" \ 
     PLATFORM="virtualbox" \ 
     CREDENTIAL="vagrant" \ 

     plan clear compile validate build \ 

     deploy-vagrant-box publish-vagrant-box \ 

     2>&1 | tee "${PWD}/builds/deploy-development.log";

exit 0;
