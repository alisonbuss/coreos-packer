#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr:     
#-------------------------------------------------------------#

# @descr: The root directory of the Project. 
readonly ROOT_DIRECTORY="${1}";
# @descr: Directory of cloud access credentials
readonly CRED_DIRECTORY="${ROOT_DIRECTORY}/builds/credentials";

# Credential from Amazon
export PACKER_CRED_AWS_ACCESS_KEY=$(sed -n 's/^ *aws_access_key_id *= *//p' ${CRED_DIRECTORY}/platform/amazon/credential);
export PACKER_CRED_AWS_SECRET_KEY=$(sed -n 's/^ *aws_secret_access_key *= *//p' ${CRED_DIRECTORY}/platform/amazon/credential);
# Credential from Google Cloud
export PACKER_CRED_GOOGLE_ACCOUNT_FILE="${CRED_DIRECTORY}/platform/google/credential.json";
# Credential from DigitalOcean
export PACKER_CRED_DIGITALOCEAN_TOKEN=$(cat ${CRED_DIRECTORY}/platform/digitalocean/credential);
# Credential from VirtualBox
export PACKER_CRED_VBOX_SSH_PRIVATE_KEY_FILE="${CRED_DIRECTORY}/platform/virtualbox/credential";
# Credential from Vagrant Cloud
export PACKER_CRED_VAGRANT_CLOUD_TOKEN="$(cat ${CRED_DIRECTORY}/platform/vagrant-cloud/credential)";
# Credential from (Deployment User)
export PACKER_CRED_DEPLOY_SSH_PUBLIC_KEY_FILE="${CRED_DIRECTORY}/ssh-user/deploy_public_key.pub";

make --directory ${ROOT_DIRECTORY} PLATFORM="google" ENVIRONMENT="staging" \
       plan \
       validate \
       build \
       2>&1 | tee "${ROOT_DIRECTORY}/builds/staging/deploy.log";

exit 0;
