#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de inicialização para a construção de imagens 
#         CoreOS no Packer.     
# @fonts: 
# @example:
#    $ bash packer.sh [All Native Commands: --pkg-build, --pkg-version, --pkg-help];
#  OR
#    $ bash packer.sh [All Packer Commands (CLI)];
#  OR
#    $ bash packer.sh [All Packer Commands (CLI)] --pkg-file="./packages.json";
#  OR
#    $ bash packer.sh --pkg-build;
#  OR
#    $ bash packer.sh --pkg-build --pkg-file="./packages.json";
#  OR
#    $ bash packer.sh --pkg-build --pkg-file="https://www....com/.../packages.json";
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

function startBuilding {
    local fileJSON=$(util.getParameterValue "(--file=|-f=)" "$@");
    if [ ! -n "${fileJSON}" ]; then 
        fileJSON="./packages.json";
    fi

    # @descr: 
    __build() {
        echo "";
    }

    # @descr: 
    __buildPackages() {
        local packages=$(cat "${fileJSON}" | jq ". | length"); 
        for (( i=0; i<=$packages-1; i++ )); do
            local itemPackage=$(cat "${fileJSON}" | jq -r ".[${i}]");

            local package=$(echo "${itemPackage}" | jq -r ".package");
            local description=$(echo "${itemPackage}" | jq -r ".description");

            local variables="{}";
            local builders="";
            local provisioners="";
            local postProcessors="";            

            local size=$(echo "${itemPackage}" | jq ".builders | length");
            for item in $(echo "${itemPackage}" | jq -r '.builders[]'); do
                builders+=$(cat ${item}); 
                if [ $size -gt 1 ]; then
                    builders+=",";
                    size=$(($size-1)); 
                fi
            done 

            local size=$(echo "${itemPackage}" | jq ".provisioners | length");
            for item in $(echo "${itemPackage}" | jq -r '.provisioners[]'); do
                provisioners+=$(cat ${item}); 
                if [ $size -gt 1 ]; then
                    provisioners+=",";
                    size=$(($size-1)); 
                fi
            done 

            local size=$(echo "${itemPackage}" | jq ".postProcessors | length");
            for item in $(echo "${itemPackage}" | jq -r '.postProcessors[]'); do
                postProcessors+=$(cat ${item}); 
                if [ $size -gt 1 ]; then
                    postProcessors+=",";
                    size=$(($size-1)); 
                fi
            done 

            touch "./packer-templates/source-temp/${package}-min.json"
            {
                echo '{"variables":'$variables',"builders":['$builders'],"provisioners":['$provisioners'],"post-processors":['$postProcessors']}';
            } > "./packer-templates/source-temp/${package}-min.json"; 

            jq . "./packer-templates/source-temp/${package}-min.json" > "./packer-templates/source-temp/${package}.json"
        done
    }

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
        local firstArgument="$1";
        case $firstArgument in
            build) { 
                __convertConfigIntoIgnition;
                __build "$@"; 
            };;
            build-packages) { 
                __convertConfigIntoIgnition;
                __buildPackages "$@";
            };;
            *) { 
                util.print.warning "Aviso: O primeiro argumento não foi passado de acordo com [build ou build-packages]";
            };;
        esac
    }

    __initialize "$@"; 
} 

# SCRIPT INITIALIZE...
util.try; ( 

    startBuilding "$@" #Gerar Logs# | tee -a "./logs/${0##*/}.log";

); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;