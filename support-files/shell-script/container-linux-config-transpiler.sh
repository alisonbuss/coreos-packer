#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

function transpiler {
    # @descr: Descrição da Variavel.
    local configSource=$(util.getParameterValue "(--ignition-source=)" "$@");
    # @descr: Descrição da Variavel.
    local name=$(util.getParameterValue "(--ignition-name=)" "$@");
    # @descr: Descrição da Variavel.
    local platforms=($(util.getParameterValue "(--platforms=)" "$@"));
    # @descr: Descrição da Variavel.
    local compilePath=$(util.getParameterValue "(--compile-path=)" "$@");

    echo "Criando diretorio de compilação do ignition...";  
    echo "--diretorio: ${compilePath}";  
    mkdir -p "${compilePath}";

    echo "Compilando o 'Container Linux Config' para 'ignition'...";  
    echo "--Para as plataformas: [${platforms[@]}]"; 

    sleep 1s;

    echo "Converting to (packet)...";
    ct --platform=packet < "${configSource}" > "${compilePath}/${name}-for-packet.json" --pretty;
    ct --platform=packet < "${configSource}" > "${compilePath}/${name}-for-packet.min.json";

    echo "Converting to (vagrant-virtualbox)...";
    ct --platform=vagrant-virtualbox < "${configSource}" > "${compilePath}/${name}-for-vagrant.json" --pretty;
    ct --platform=vagrant-virtualbox < "${configSource}" > "${compilePath}/${name}-for-vagrant.min.json";

    echo "Converting to (digitalocean)...";
    ct --platform=digitalocean < "${configSource}" > "${compilePath}/${name}-for-digitalocean.json" --pretty;
    ct --platform=digitalocean < "${configSource}" > "${compilePath}/${name}-for-digitalocean.min.json";

    echo "Converting to (ec2)...";
    ct --platform=ec2 < "${configSource}" > "${compilePath}/${name}-for-ec2.json" --pretty;
    ct --platform=ec2 < "${configSource}" > "${compilePath}/${name}-for-ec2.min.json";

    echo "Converting to (gce)...";
    ct --platform=gce < "${configSource}" > "${compilePath}/${name}-for-gce.json" --pretty;
    ct --platform=gce < "${configSource}" > "${compilePath}/${name}-for-gce.min.json";

    echo "Converting to (azure)...";
    ct --platform=azure < "${configSource}" > "${compilePath}/${name}-for-azure.json" --pretty;
    ct --platform=azure < "${configSource}" > "${compilePath}/${name}-for-azure.min.json";
} 

transpiler "$@";

exit 0;