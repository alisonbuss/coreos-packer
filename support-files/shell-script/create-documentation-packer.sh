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

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${module_build_path}"; 
    touch "${new_mode_build_path}/README.md"
    {
        echo -e '# DOCUMENTATION:';

        echo -e '## [Packer Modules] usados para gerar o "Novo Modelo Packer"';
        echo -e '```text';
        tree -d "${packer_modules}"; echo "";
        echo -e '```';
        echo -e ' ';

        echo -e '## New Model for Packer';
        echo -e '##### '${new_mode_source_file}' ';
        echo -e '```bash';
        cat "${new_mode_source_file}"; echo "";
        echo -e '```';
        echo -e ' ';

        echo -e '## Arquivos Gerados pelo Novo Modelo Packer';
        echo -e '```text';
        tree "${new_mode_build_path}"; echo "";
        echo -e '```';
        echo -e ' ';

        echo -e '## vars-custom-variables.json';
        echo -e '##### '${compiled_template_path}'/vars-custom-variables.json';
        echo -e '```json';
        jq . "${compiled_template_path}/vars-custom-variables.json";
        echo -e '```';
        echo -e ' ';

        echo -e '## list_variables';
        echo -e '   ';
        for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
            local nameJSON=$(basename ${packer_modules}${variableJSON});
            echo -e '#### --- '${nameJSON}' ';
            echo -e '##### '${packer_modules}${variableJSON}' ';
            echo -e '```json';
            cat "${packer_modules}${variableJSON}"; echo "";
            echo -e '```';
            echo -e ' ';
        done 
        echo -e ' ';
       
        echo -e '## builders';
        echo -e '   ';
        for builderJSON in $(echo "${packer_template}" | jq -r '.builders[]'); do
            local nameJSON=$(basename ${packer_modules}${builderJSON});
            echo -e '#### --- '${nameJSON}' ';
            echo -e '##### '${packer_modules}${builderJSON}' ';
            echo -e '```json';
            cat "${packer_modules}${builderJSON}"; echo "";
            echo -e '```';
            echo -e ' ';
        done 
        echo -e ' ';

        echo -e '## provisioners';
        echo -e '   ';
        for provisionerJSON in $(echo "${packer_template}" | jq -r '.provisioners[]'); do
            local nameJSON=$(basename ${packer_modules}${provisionerJSON});
            echo -e '#### --- '${nameJSON}' ';
            echo -e '##### '${packer_modules}${provisionerJSON}' ';
            echo -e '```json';
            cat "${packer_modules}${provisionerJSON}"; echo "";
            echo -e '```';
            echo -e ' ';
        done 
        echo -e ' ';

        echo -e '## post_processors';
        echo -e '   ';
        for post_processorJSON in $(echo "${packer_template}" | jq -r '.post_processors[]'); do
            local nameJSON=$(basename ${packer_modules}${post_processorJSON});
            echo -e '#### --- '${nameJSON}' ';
            echo -e '##### '${packer_modules}${post_processorJSON}' ';
            echo -e '```json';
            cat "${packer_modules}${post_processorJSON}"; echo "";
            echo -e '```';
            echo -e ' ';
        done
        echo -e ' ';

        echo -e '## '${compiled_template_name}'.json';
        echo -e '##### '${compiled_template_path}'/'${compiled_template_name}'.json';
        echo -e '```json';
        cat "${compiled_template_path}/${compiled_template_name}.json"; echo "";
        echo -e '```';
        echo -e ' ';

        echo -e '## start-packer.sh';
        echo -e '##### '${new_mode_build_path}'/start-packer.sh';
        echo -e '```bash';
        cat "${new_mode_build_path}/start-packer.sh"; echo "";
        echo -e '```';
        echo -e ' ';

    } > "${new_mode_build_path}/README.md";

} 

StartCompilation "$@";

exit 0;