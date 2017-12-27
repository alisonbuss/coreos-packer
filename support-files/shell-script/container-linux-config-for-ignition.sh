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
    local ignition_source_file=$(util.getParameterValue "(--ignition-source-file=)" "$@");  
    # @descr: Descrição da Variavel.
    local ignition_working_directory=$(util.getParameterValue "(--ignition-working-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local ignition_compiled_default_name=$(util.getParameterValue "(--ignition-compiled-default-name=)" "$@");  
    # @descr: Descrição da Variavel.
    local ignition_compiled_directory=$(util.getParameterValue "(--ignition-compiled-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local ignition_platforms=$(util.getParameterValue "(--platforms=)" "$@");  
    
    # @descr: Descrição da Variavel.
    local ignition_compiled_file="${ignition_compiled_directory}/${ignition_compiled_default_name}";  

    echo "Criando diretorio de compilação do ignitions...";  
    echo "--diretorio: ${ignition_compiled_directory}";  
    mkdir -p "${ignition_compiled_directory}";

    echo "Compilando o 'Container Linux Config' para 'ignition'...";  
    echo "--Para as plataformas: [${ignition_platforms[@]}]"; 

    sleep 1s;

    echo "Converting to (packet)...";
    ct --platform=packet -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-packet.json" --pretty;
    ct --platform=packet -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-packet.min.json";

    echo "Converting to (vagrant-virtualbox)...";
    ct --platform=vagrant-virtualbox -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-virtualbox.json" --pretty;
    ct --platform=vagrant-virtualbox -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-virtualbox.min.json";

    echo "Converting to (digitalocean)...";
    ct --platform=digitalocean -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-digitalocean.json" --pretty;
    ct --platform=digitalocean -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-digitalocean.min.json";

    echo "Converting to (ec2)...";
    ct --platform=ec2 -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-ec2.json" --pretty;
    ct --platform=ec2 -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-ec2.min.json";

    echo "Converting to (gce)...";
    ct --platform=gce -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-gce.json" --pretty;
    ct --platform=gce -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-gce.min.json";

    echo "Converting to (azure)...";
    ct --platform=azure -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-azure.json" --pretty;
    ct --platform=azure -in-file "${ignition_source_file}" -out-file "${ignition_compiled_file}-for-azure.min.json";
} 

StartCompilation "$@";

exit 0;