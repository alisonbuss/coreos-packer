#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

# @descr: get parameter value
# @fonts: https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux
# @example:
#    $ util.getParameterValue "(--param3=|-p3=)" "$@"
function util.getParameterValue(){
    local exp=$1;
    local params=("$@");
    local valueEnd="";
    for value in "${params[@]:1:$#}"; do
        if grep -E -q "${exp}" <<< "${value}"; then
            valueEnd="${value#*=}";
            break;
        fi        
    done
    echo $valueEnd;
}

# @descr: Descrição da Função.
# @fonts: Fontes de referências
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function StartCompilation {
    # @descr: Descrição da Variavel.
    local cert_source_file=$(util.getParameterValue "(--cert-source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local cert_working_directory=$(util.getParameterValue "(--cert-working-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local cert_compiled_default_name=$(util.getParameterValue "(--cert-compiled-default-name=)" "$@");  
    # @descr: Descrição da Variavel.
    local cert_compiled_directory=$(util.getParameterValue "(--cert-compiled-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local WORKING_DIRECTORY=$(util.getParameterValue "(--working-directory=)" "$@");
    
 

} 

StartCompilation "$@";

exit 0;