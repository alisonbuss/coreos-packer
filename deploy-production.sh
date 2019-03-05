#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

make ENVIRONMENT="production" \ 
     PLATFORM="aws" \ 
     CREDENTIAL="aws" \ 

     plan clear compile validate build \ 

     2>&1 | tee "${PWD}/builds/deploy-production.log";

exit 0;
