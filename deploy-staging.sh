#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make ENVIRONMENT="staging" \ 
     PLATFORM="google" \ 
     CREDENTIAL="google" \ 

     plan clear compile validate build \ 

     2>&1 | tee "${PWD}/builds/deploy-staging.log";

exit 0;
