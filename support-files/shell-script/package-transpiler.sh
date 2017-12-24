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
    local packageFile=$(util.getParameterValue "(--package-file=)" "$@");
    # @descr: Descrição da Variavel.
    local compilePath=$(util.getParameterValue "(--compile-path=)" "$@");

    echo "Criando diretorio de compilação do packer...";  
    echo "--diretorio: ${compilePath}";  
    mkdir -p "${compilePath}";

    local packerName=$(cat "${packageFile}" | jq -r ".package");
    local packerTemplate=$(cat "${packageFile}" | jq -c ".packer"); 

    local description=$(echo "${packerTemplate}" | jq -r ".description");
    local minPackerVersion=$(echo "${packerTemplate}" | jq -r ".min_packer_version");

    local variables="{}";
    local listVariables="";
    
    local builders="";
    local provisioners="";
    local postProcessors="";            

    echo "Processando módulo [variables]...";

    echo "Processando módulo [list_variables]..."; 

    echo "Processando módulo [builders]...";
    local size=$(echo "${packerTemplate}" | jq ".builders | length");
    for item in $(echo "${packerTemplate}" | jq -r '.builders[]'); do
        builders+=$(cat ${item}); 
        if [ $size -gt 1 ]; then
            builders+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [provisioners]...";
    local size=$(echo "${packerTemplate}" | jq ".provisioners | length");
    for item in $(echo "${packerTemplate}" | jq -r '.provisioners[]'); do
        provisioners+=$(cat ${item}); 
        if [ $size -gt 1 ]; then
            provisioners+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processando módulo [post_processors]...";
    local size=$(echo "${packerTemplate}" | jq ".post_processors | length");
    for item in $(echo "${packerTemplate}" | jq -r '.post_processors[]'); do
        postProcessors+=$(cat ${item}); 
        if [ $size -gt 1 ]; then
            postProcessors+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Iniciando a compilação do package para packer...";  
    echo "--para o diretorio: ${compilePath}"; 
    touch "${compilePath}/${packerName}-min.json"
    {
        echo '{"description":"'$description'","variables":'$variables',"builders":['$builders'],"provisioners":['$provisioners'],"post-processors":['$postProcessors'],"min_packer_version": "'${minPackerVersion}'"}';
    } > "${compilePath}/${packerName}-min.json"; 

    echo "Convertendo o template packer em modo [source]";  
    jq . "${compilePath}/${packerName}-min.json" > "${compilePath}/${packerName}.json";

    echo "Validando template packer [minified]";  
    packer validate "${compilePath}/${packerName}-min.json";

    echo "Validando template packer [source]";  
    packer validate "${compilePath}/${packerName}.json";
} 

transpiler "$@";

exit 0;