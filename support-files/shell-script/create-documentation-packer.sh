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
    local new_mode_source_file=$(util.getParameterValue "(--new-model-source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local new_mode_output_file=$(util.getParameterValue "(--new-model-output-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local new_mode_build_path=$(util.getParameterValue "(--new-model-build-path=)" "$@");  
    # @descr: Descrição da Variavel.
    local packer_modules=$(util.getParameterValue "(--packer-modules=)" "$@");  
    
    # @descr: Descrição da Variavel.
    local compiled_template_name=$(basename "${new_mode_output_file}");  
    compiled_template_name="${compiled_template_name%.*}";

    # @descr: Descrição da Variavel.
    local compiled_template_path=$(dirname "${new_mode_output_file}");

    # @descr: Descrição da Variavel.
    local packer_template=$(cat "${new_mode_source_file}" | jq -c ".packer_template"); 

    echo "Processando módulo [variables]...";


    echo "Processando módulo [list_variables]..."; 
    local list_variables="";   
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        local nameVariableJSON=$(basename ${packer_modules}${variableJSON});
        list_variables+='\\n\t\t\t-var-file="${module_build_path}/'${nameVariableJSON}'" \'; 
    done 

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${module_build_path}"; 
    touch "${new_mode_build_path}/README.md"
    {
        echo -e '...';
    } > "${new_mode_build_path}/README.md";

} 

StartCompilation "$@";

exit 0;