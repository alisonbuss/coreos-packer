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
    local source_file=$(util.getParameterValue "(--source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local output_file=$(util.getParameterValue "(--output-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local packer_modules=$(util.getParameterValue "(--packer-modules=)" "$@");  

    # @descr: Descrição da Variavel.
    local packer_template=$(cat "${source_file}" | jq -c ".packer_template"); 
    # @descr: Descrição da Variavel.
    local description=$(echo "${packer_template}" | jq -r ".description");
    # @descr: Descrição da Variavel.
    local min_packer_version=$(echo "${packer_template}" | jq -r ".min_packer_version");

    # @descr: Descrição da Variavel.
    local compiled_template_name=$(basename "${output_file}");  
    compiled_template_name="${compiled_template_name%.*}";

    # @descr: Descrição da Variavel.
    local compiled_template_path=$(dirname "${output_file}");

    echo "Criando diretorio de construção packer...";  
    echo "--diretorio: ${compiled_template_path}";  
    mkdir -p "${compiled_template_path}";

    echo "Processando módulo de [variables]...";
    echo "${packer_template}" | jq -c '.variables' > "${compiled_template_path}/vars-custom-variables.json";

    echo "Processando módulo de [list_variables]..."; 
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        cp "${packer_modules}${variableJSON}" "${compiled_template_path}/";
    done 

    echo "Processando módulo [builders]...";
    local builders="";
    local size=$(echo "${packer_template}" | jq ".builders | length");
    for builderJSON in $(echo "${packer_template}" | jq -r '.builders[]'); do
        builders+=$(cat ${packer_modules}${builderJSON}); 
        if [ $size -gt 1 ]; then
            builders+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [provisioners]...";
    local provisioners="";
    local size=$(echo "${packer_template}" | jq ".provisioners | length");
    for provisionerJSON in $(echo "${packer_template}" | jq -r '.provisioners[]'); do
        provisioners+=$(cat ${packer_modules}${provisionerJSON}); 
        if [ $size -gt 1 ]; then
            provisioners+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [post_processors]...";
    local post_processors="";      
    local size=$(echo "${packer_template}" | jq ".post_processors | length");
    for post_processorJSON in $(echo "${packer_template}" | jq -r '.post_processors[]'); do
        post_processors+=$(cat ${packer_modules}${post_processorJSON}); 
        if [ $size -gt 1 ]; then
            post_processors+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Iniciando a compilação e a criação do packer template...";  
    echo "--diretorio: ${compiled_template_path}"; 
    touch "${compiled_template_path}/${compiled_template_name}-min.json"
    {
        echo '{"description":"'$description'","builders":['$builders'],"provisioners":['$provisioners'],"post-processors":['$post_processors'],"min_packer_version": "'${min_packer_version}'"}';
    } > "${compiled_template_path}/${compiled_template_name}-min.json"; 

    echo "Convertendo o packer template em modo [source]";  
    jq . "${compiled_template_path}/${compiled_template_name}-min.json" > "${compiled_template_path}/${compiled_template_name}.json";

} 

StartCompilation "$@";

exit 0;