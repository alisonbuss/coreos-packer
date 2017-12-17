#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de inicialização para a construção de imagens 
#         CoreOS no Packer.     
# @fonts: 
# @example: 
#    $ bash build.sh
#-------------------------------------------------------------#

function startBuilding {

     # @descr: 
    __convertConfigIntoIgnition() {
        local configSource="./container-linux-config/source/ignition-source.yml";
        local convertedPath="./container-linux-config/ignition";

        echo "Convert a Container Linux Config into Ignition!!";

        rm -rf ${convertedPath}/*;

        sleep 1s;

        echo "Converting to (packet)...";
        ct --platform=packet < "${configSource}" > "${convertedPath}/ignition-packet.json" --pretty;
        ct --platform=packet < "${configSource}" > "${convertedPath}/ignition-packet.min.json";

        echo "Converting to (vagrant-virtualbox)...";
        ct --platform=vagrant-virtualbox < "${configSource}" > "${convertedPath}/ignition-vagrant.json" --pretty;
        ct --platform=vagrant-virtualbox < "${configSource}" > "${convertedPath}/ignition-vagrant.min.json";

        echo "Converting to (digitalocean)...";
        ct --platform=digitalocean < "${configSource}" > "${convertedPath}/ignition-digitalocean.json" --pretty;
        ct --platform=digitalocean < "${configSource}" > "${convertedPath}/ignition-digitalocean.min.json";

        echo "Converting to (ec2)...";
        ct --platform=ec2 < "${configSource}" > "${convertedPath}/ignition-ec2.json" --pretty;
        ct --platform=ec2 < "${configSource}" > "${convertedPath}/ignition-ec2.min.json";

        echo "Converting to (gce)...";
        ct --platform=gce < "${configSource}" > "${convertedPath}/ignition-gce.json" --pretty;
        ct --platform=gce < "${configSource}" > "${convertedPath}/ignition-gce.min.json";

        echo "Converting to (azure)...";
        ct --platform=azure < "${configSource}" > "${convertedPath}/ignition-azure.json" --pretty;
        ct --platform=azure < "${configSource}" > "${convertedPath}/ignition-azure.min.json";
    }

    # @descr: 
    __initialize() {
        __convertConfigIntoIgnition;

        # set parameters
        local _params="$@";
        case $_params in
            *--run*|*-r*) { 
                clear;
            };;
            *--list*|*-l*) { 
                clear;
            };;
            *--help*|*-help*|*-h*|*help*) {
                clear;
            };;
            *--version*|*-version*|*-v*|*version*) {
                clear;
            };;
        esac
    }

    __initialize "$@"; 
} 

startBuilding "$@" #Gerar Logs# | tee -a "./logs/${0##*/}.log";

exit 0;