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
    local package_name=$(util.getParameterValue "(--package-name=)" "$@");  
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
    local packerTemplate=$(cat "${package_source_file}" | jq -c ".packer"); 

    echo "Processando módulo [override_variables]...";
    local coreos_release=$(echo ${packerTemplate} | jq -r '.override_variables.release');
    if [ "${coreos_release}" == "null" ]; then 
        coreos_release="stable";
    fi
    local coreos_version=$(echo ${packerTemplate} | jq -r '.override_variables.version');
    if [ "${coreos_version}" == "null" ]; then 
        coreos_version="current";
    fi

    echo "Processando módulo [list_variables]..."; 
    local listVariables="";   
    for item in $(echo "${packerTemplate}" | jq -r '.list_variables[]'); do
        local nameVariableJSON=$(basename ${WORKING_DIRECTORY}${item});
        listVariables+='\\n\t\t\t-var-file="${package_template_directory}/'${nameVariableJSON}'" \'; 
    done 

    echo "Iniciando a criação do arquivo build.sh para packer";  
    echo "--para o diretorio: ${package_working_directory}"; 
    touch "${package_working_directory}/start-packer.sh"
    {
        echo -e '#!/bin/bash';
        echo -e 'function StartPacker {';
        echo -e '    local params="$@";';
        echo -e '    local coreos_release="'${coreos_release}'";';
        echo -e '    local coreos_version="'${coreos_version}'";';
        echo -e '    local coreos_url_iso="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso";';
        echo -e '    local coreos_url_digests="${coreos_url_iso}.DIGESTS";';
        echo -e '    local coreos_iso_checksum_type="SHA512";';
        echo   $'    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk \'{ print length, $1 | "sort -rg"}\' | awk \'NR == 1 { print $2 }\');';   
        echo -e '    local package_working_directory="'${package_working_directory}'";';
        echo -e '    local package_template_directory="'${package_compiled_directory}'";';
        echo -e '    __run_packer() {';
        echo -e '        packer "$@" \'$listVariables'';
        echo -e '            -var "release=${coreos_release}" \';
        echo -e '            -var "version=${coreos_version}" \';
        echo -e '            -var "iso_checksum_type=${coreos_iso_checksum_type}" \';
        echo -e '            -var "iso_checksum=${coreos_iso_checksum}" \';
        echo -e '            -var "build_path=${package_working_directory}" \';
        echo -e '            -var "vagrant_box_name='${package_name}'" \';
        echo -e '            -var-file="${package_template_directory}/vars-override-variables.json" \';
        echo -e '            "${package_template_directory}/'${package_compiled_default_name}'-min.json";';
        echo -e '    }';
        echo -e '    case $params in';
        echo -e '        validate) { __run_packer validate; };;';
        echo -e '        inspect)  { packer inspect "${package_template_directory}/'${package_compiled_default_name}'-min.json"; };;';
        echo -e '        build)    { __run_packer build; };;';
        echo -e '        *)        { packer "$@"; };;';
        echo -e '    esac';
        echo -e '}';
        echo -e 'StartPacker "$@";';
        echo -e 'exit 0;';
    } > "${package_working_directory}/start-packer.sh";

} 

StartCompilation "$@";

exit 0;