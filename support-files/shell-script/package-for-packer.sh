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
    local package_source_file=$(util.getParameterValue "(--package-source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_working_directory=$(util.getParameterValue "(--package-working-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_compiled_default_name=$(util.getParameterValue "(--package-compiled-default-name=)" "$@");  
    # @descr: Descrição da Variavel.
    local package_compiled_directory=$(util.getParameterValue "(--package-compiled-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local WORKING_DIRECTORY=$(util.getParameterValue "(--working-directory=)" "$@");
    
    # @descr: Descrição da Variavel.
    local package_compiled_file="${package_compiled_directory}/${package_compiled_default_name}";  

    local packerTemplate=$(cat "${package_source_file}" | jq -c ".packer"); 
    local description=$(echo "${packerTemplate}" | jq -r ".description");
    local minPackerVersion=$(echo "${packerTemplate}" | jq -r ".min_packer_version");
    local overrideVariables="";
    local listVariables="";
    local builders="";
    local provisioners="";
    local postProcessors="";            

    echo "Criando diretorio de compilação do packer...";  
    echo "--diretorio: ${package_compiled_directory}";  
    mkdir -p "${package_compiled_directory}";

    echo "Processando módulo [override_variables]...";
    echo "${packerTemplate}" | jq -c '.override_variables' > "${package_compiled_directory}/OVERRIDE_VARIABLES.json"

    echo "Processando módulo [list_variables]..."; 
    for item in $(echo "${packerTemplate}" | jq -r '.list_variables[]'); do
        cp "${WORKING_DIRECTORY}${item}" "${package_compiled_directory}/";
        local nameVariable=$(basename ${WORKING_DIRECTORY}${item});
        listVariables+='\\n\t\t-var-file="${path}/'${nameVariable}'" \'; 
    done 

    echo "Processando módulo [builders]...";
    local size=$(echo "${packerTemplate}" | jq ".builders | length");
    for item in $(echo "${packerTemplate}" | jq -r '.builders[]'); do
        builders+=$(cat ${WORKING_DIRECTORY}${item}); 
        if [ $size -gt 1 ]; then
            builders+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [provisioners]...";
    local size=$(echo "${packerTemplate}" | jq ".provisioners | length");
    for item in $(echo "${packerTemplate}" | jq -r '.provisioners[]'); do
        provisioners+=$(cat ${WORKING_DIRECTORY}${item}); 
        if [ $size -gt 1 ]; then
            provisioners+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [post_processors]...";
    local size=$(echo "${packerTemplate}" | jq ".post_processors | length");
    for item in $(echo "${packerTemplate}" | jq -r '.post_processors[]'); do
        postProcessors+=$(cat ${WORKING_DIRECTORY}${item}); 
        if [ $size -gt 1 ]; then
            postProcessors+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Iniciando a compilação do package para packer...";  
    echo "--para o diretorio: ${package_compiled_directory}"; 
    touch "${package_compiled_file}-min.json"
    {
        echo '{"description":"'$description'","builders":['$builders'],"provisioners":['$provisioners'],"post-processors":['$postProcessors'],"min_packer_version": "'${minPackerVersion}'"}';
    } > "${package_compiled_file}-min.json"; 

    echo "Convertendo o template packer em modo [source]";  
    jq . "${package_compiled_file}-min.json" > "${package_compiled_file}.json";

    echo "Validando template packer [minified]";  
    packer validate "${package_compiled_file}-min.json";

    echo "Validando template packer [source]";  
    packer validate "${package_compiled_file}.json";

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${package_working_directory}"; 
    touch "${package_working_directory}/build.sh"
    {
        echo -e '#!/bin/bash';
        echo -e 'function StartBuilding {';
        echo -e '    local path="'${package_compiled_directory}'";';
        echo -e '    packer build \'$listVariables'';
        echo -e '        -var-file="${path}/OVERRIDE_VARIABLES.json" \';
        echo -e '        "${path}/'${package_compiled_default_name}'.json";';
        echo -e '}';
        echo -e 'StartBuilding "$@";';
        echo -e 'exit 0;';
    } > "${package_working_directory}/build.sh";

    echo "Iniciando a criação do arquivo README.md";  
    echo "--para o diretorio: ${package_working_directory}"; 
    touch "${package_working_directory}/README.md"
    {
        echo '# coreos-packer';
        echo '## Projero Gerado pelo Package';
        echo '   ';
        echo '### Projeto de criação de imagens CoreOS para múltiplas plataformas (Azure, Amazon EC2, Google GCE, DigitalOcean, Docker, VirtualBox).   ';
        echo '   ';
        echo '**Descrição:**';
        echo '#### '$description' ';
        echo '   ';
        echo '**Variaveis sobrescritas:** (OVERRIDE_VARIABLES.json)';
        echo '```json';
        cat ${package_compiled_directory}/OVERRIDE_VARIABLES.json
        echo '```   ';
        echo '   ';
        echo '**Script de execução:**';
        echo '```bash';
        cat ${package_working_directory}/build.sh
        echo '```   ';
        echo '   ';
    } > "${package_working_directory}/README.md";

} 

StartCompilation "$@";

exit 0;