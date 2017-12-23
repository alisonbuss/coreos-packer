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
    local WORKING_DIRECTORY=$(util.getParameterValue "(--working-directory=)" "$@");

    echo "${ACTION}";
    echo "${WORKING_DIRECTORY}";
    echo "";

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __compile() {
        echo "__compile";
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
        echo "__clean";
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
                __compile; 
            };;
            build) { 
                __build; 
            };;
            build-force) { 
                __build_force; 
            };;
            install) { 
                __install; 
            };;
            clean) { 
                __clean; 
            };;
            test-vagrant) { 
                __test_vagrant; 
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