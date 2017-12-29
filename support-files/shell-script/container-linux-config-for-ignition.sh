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
    local compiled_name=$(util.getParameterValue "(--compiled-name=)" "$@");  
    # @descr: Descrição da Variavel.
    local compiled_directory=$(util.getParameterValue "(--compiled-directory=)" "$@");  
    # @descr: Descrição da Variavel.
    local platforms=$(util.getParameterValue "(--platforms=)" "$@");  
    # @descr: Descrição da Variavel.
    local compiled_file="${compiled_directory}/${compiled_name}";  

    echo "Criando diretorio de compilação do ignitions...";  
    echo "--diretorio: ${compiled_directory}";  
    mkdir -p "${compiled_directory}";

    echo "Compilando o 'Container Linux Config' para 'ignition'...";  
    echo "--Para as plataformas: [${platforms[@]}]"; 

    echo "Converting to (no-platform)...";
    ct -in-file "${source_file}" -out-file "${compiled_file}.json" --pretty;

    echo "Converting to (vagrant-virtualbox)...";
    ct --platform=vagrant-virtualbox -in-file "${source_file}" -out-file "${compiled_file}-for-virtualbox.json" --pretty;

    echo "Converting to (digitalocean)...";
    ct --platform=digitalocean -in-file "${source_file}" -out-file "${compiled_file}-for-digitalocean.json" --pretty;

    echo "Converting to (ec2)...";
    ct --platform=ec2 -in-file "${source_file}" -out-file "${compiled_file}-for-ec2.json" --pretty;

    echo "Converting to (gce)...";
    ct --platform=gce -in-file "${source_file}" -out-file "${compiled_file}-for-gce.json" --pretty;

    echo "Converting to (azure)...";
    ct --platform=azure -in-file "${source_file}" -out-file "${compiled_file}-for-azure.json" --pretty;

    echo "Converting to (packet)...";
    ct --platform=packet -in-file "${source_file}" -out-file "${compiled_file}-for-packet.json" --pretty;

} 

StartCompilation "$@";

exit 0;