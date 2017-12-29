#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

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
    local package_source_file=$(util.getParameterValue "(--package-source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_compiled_name=$(util.getParameterValue "(--package-compiled-name=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_compiled_directory=$(util.getParameterValue "(--package-compiled-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_working_directory=$(util.getParameterValue "(--package-working-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local main_working_directory=$(util.getParameterValue "(--main-working-directory=)" "$@"); 

     # @descr: Descrição da Variavel.
    local packer_modules=$(cat "${package_source_file}" | jq -r ".packer_modules"); 
    # @descr: Descrição da Variavel.
    local packer_template=$(cat "${package_source_file}" | jq -c ".packer_template"); 

    echo "Processando módulo [override_variables]...";
    local coreos_release=$(echo ${packer_template} | jq -r '.override_variables.release');
    if [ "${coreos_release}" == "null" ]; then 
        coreos_release="stable";
    fi
    local coreos_version=$(echo ${packer_template} | jq -r '.override_variables.version');
    if [ "${coreos_version}" == "null" ]; then 
        coreos_version="current";
    fi

    echo "Processando módulo [list_variables]..."; 
    local list_variables="";   
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        local nameVariableJSON=$(basename ${main_working_directory}${packer_modules}${variableJSON});
        list_variables+='\\n\t\t\t-var-file="${package_template_directory}/'${nameVariableJSON}'" \'; 
    done 

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${package_working_directory}"; 
    touch "${package_working_directory}/README.md"
    {
        echo "";
        echo "";
        echo "";
        echo "";
        echo "";
    } > "${package_working_directory}/README.md";

} 

StartCompilation "$@";

exit 0;