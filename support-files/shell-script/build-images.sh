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

# @descr: Descrição da Função.
# @fonts: Fontes de referências
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function BuildImages {
    
    # @descr: Descrição da Variavel.
    local ACTION=$(util.getParameterValue "(--action=)" "$@");

    # @descr: Descrição da Variavel.
    local PACKAGE_FILE=$(util.getParameterValue "(--package-file=)" "$@");

    # @descr: Descrição da Variavel.
    local WORKING_DIRECTORY=$(util.getParameterValue "(--working-directory=)" "$@");

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __compile() {
        local IGNITION_FILE=$(util.getParameterValue "(--ignition-file=)" "$@");
        local package_name=$(cat "${PACKAGE_FILE}" | jq -r ".package");    
        local build_path=$(cat "${PACKAGE_FILE}" | jq -r ".build_path");     

        echo "Criando diretorio de construção da imagem...";  
        echo "--diretorio: ${build_path}";  
        mkdir -p "${build_path}";

        echo "Iniciando a compilação dos certificados pelo cfssl...";  
        echo "--para o diretorio: ${build_path}/files/certificates";  
        bash $WORKING_DIRECTORY/support-files/shell-script/cfssl-transpiler.sh \
            --compile-path="${build_path}/files/certificates";

        echo "Iniciando a compilação do 'Container Linux Config' para 'ignition'..."; 
        echo "--arquivo fonte: ${IGNITION_FILE}";  
        echo "--para o diretorio: ${build_path}/files";
        bash $WORKING_DIRECTORY/support-files/shell-script/container-linux-config-transpiler.sh \
            --ignition-source="${IGNITION_FILE}" \
            --ignition-name="coreos-ignition" \
            --platforms="'packet' 'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure'" \
            --compile-path="${build_path}/files/ignition";

        echo "Iniciando a compilação do package para packer...";  
        echo "--para o diretorio: ${build_path}/packer";  
        bash $WORKING_DIRECTORY/support-files/shell-script/package-transpiler.sh \
            --package-file="${PACKAGE_FILE}" \
            --compile-path="${build_path}/packer";

        echo "Compilação concluída com sucesso...";  
    }
    
    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __build() {
        echo "__build";
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __build_force() {
        echo "__build_force";
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __install() {
        echo "__install";
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __clean() {
        local build_path=$(cat "${PACKAGE_FILE}" | jq -r ".build_path"); 

        echo "Iniciando a limpeza dos arquivos...";  
        echo "--diretorio: ${build_path}/*";  
        rm -rf ${build_path}/*;
    }
    
    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __test_vagrant() {
        echo "__test_vagrant";
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __initialize() {
        case ${ACTION} in 
            compile) { 
                __compile "$@"; 
            };;
            build) { 
                __build "$@"; 
            };;
            build-force) { 
                __build_force "$@"; 
            };;
            install) { 
                __install "$@"; 
            };;
            clean) { 
                __clean "$@"; 
            };;
            test-vagrant) { 
                __test_vagrant "$@"; 
            };;
            *) {
               echo "...";
            };;
        esac
    }

    # @descr: Descrição da Chamada da Função.
    __initialize "$@";
}

# SCRIPT INITIALIZE...
util.try; ( BuildImages "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;