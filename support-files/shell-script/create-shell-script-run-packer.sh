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
    local coreos_release=$(util.getParameterValue "(--coreos-release=)" "$@");  
    # @descr: Descrição da Variavel.
    local coreos_version=$(util.getParameterValue "(--coreos-version=)" "$@"); 
    
    # @descr: Descrição da Variavel.
    local compiled_template_name=$(basename "${new_mode_output_file}");  
    compiled_template_name="${compiled_template_name%.*}";

    # @descr: Descrição da Variavel.
    local compiled_template_path=$(dirname "${new_mode_output_file}");

    # @descr: Descrição da Variavel.
    local packer_template=$(cat "${new_mode_source_file}" | jq -c ".packer_template"); 

    echo "Processando módulo [variables]...";
    local variable_coreos_release=$(echo ${packer_template} | jq -r '.variables.coreos_release');
    if [ "${coreos_release}" == "" ] && [ "${variable_coreos_release}" == "null" ]; then
        coreos_release="stable";
    elif [ "${variable_coreos_release}" != "null" ]; then
        coreos_release="${variable_coreos_release}";
    fi
    local variable_coreos_version=$(echo ${packer_template} | jq -r '.variables.coreos_version');
    if [ "${coreos_version}" == "" ] && [ "${variable_coreos_version}" == "null" ]; then
        coreos_version="current";
    elif [ "${variable_coreos_version}" != "null" ]; then
        coreos_version="${variable_coreos_version}";
    fi

    echo "Processando módulo [list_variables]..."; 
    local list_variables="";   
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        local nameVariableJSON=$(basename ${packer_modules}${variableJSON});
        list_variables+='\\n\t\t\t-var-file="${template_path}/'${nameVariableJSON}'" \'; 
    done 

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${module_build_path}"; 
    touch "${new_mode_build_path}/start-packer.sh"
    {
        echo -e '#!/bin/bash';
        echo -e 'function StartPacker {';
        echo -e '    local params="$@";';
        echo -e '    local coreos_release="'${coreos_release}'";';
        echo -e '    local coreos_version="'${coreos_version}'";';
        echo -e '    local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";';
        echo -e '    local coreos_iso_checksum_type="SHA512";';
        echo   $'    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk \'{ print length, $1 | "sort -rg"}\' | awk \'NR == 1 { print $2 }\');';   
        echo -e '    local build_path="'${new_mode_build_path}'";';
        echo -e '    local template_path="'${compiled_template_path}'";';
        echo -e '    __run_packer() {';
        echo -e '        packer "$@" \'$list_variables'';
        echo -e '            -var "coreos_release=${coreos_release}" \';
        echo -e '            -var "coreos_version=${coreos_version}" \';
        echo -e '            -var "coreos_iso_checksum_type=${coreos_iso_checksum_type}" \';
        echo -e '            -var "coreos_iso_checksum=${coreos_iso_checksum}" \';
        echo -e '            -var "global_build_path=${build_path}" \';
        echo -e '            -var-file="${template_path}/vars-override-variables.json" \';
        echo -e '            "${template_path}/'${compiled_template_name}'-min.json";';
        echo -e '    }';
        echo -e '    case $params in';
        echo -e '        validate) { __run_packer validate; };;';
        echo -e '        build)    { __run_packer build;    };;';
        echo -e '        *)        { packer "$@";           };;';
        echo -e '    esac';
        echo -e '}';
        echo -e 'StartPacker "$@";';
        echo -e 'exit 0;';
    } > "${new_mode_build_path}/start-packer.sh";

} 

StartCompilation "$@";

exit 0;