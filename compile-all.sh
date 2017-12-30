#!/bin/bash

make compile NEW_MODEL_NAME=coreos-all-platforms;

make compile NEW_MODEL_NAME=coreos-aws;

make compile NEW_MODEL_NAME=coreos-azure;

make compile NEW_MODEL_NAME=coreos-digitalocean;

make compile NEW_MODEL_NAME=coreos-google;

make compile NEW_MODEL_NAME=coreos-vagrant;

exit 0;