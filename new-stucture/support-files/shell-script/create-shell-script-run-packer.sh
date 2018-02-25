#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for generating a startup Packer CLI. 
# @fonts: 
# @example:
#       bash create-shell-script-run-packer.sh \
#   		                  --source-file="./packer-new-model/coreos-all-platforms.json" \
#                             --output-file="./packer-builds/.../coreos-vagrant-template.json" \
#                             --new-model-build-path="./packer-builds/coreos-vagrant-packer" \
#                             --packer-modules="./packer-modules" \
#                             --packer-provisioner="./packer-modules" \
#                             --working-directory=="./" \
#                             --coreos-release="alpha" \
#                             --coreos-version="1632.0.0";
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

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartCompilation {
    local new_mode_source_file=$(util.getParameterValue "(--new-model-source-file=)" "$@");  
    local new_mode_output_file=$(util.getParameterValue "(--new-model-output-file=)" "$@");  
    local new_mode_build_path=$(util.getParameterValue "(--new-model-build-path=)" "$@");  
    local packer_modules=$(util.getParameterValue "(--packer-modules=)" "$@");  
    local packer_provisioner_path=$(util.getParameterValue "(--packer-provisioner=)" "$@");  
    local working_directory=$(util.getParameterValue "(--working-directory=)" "$@");  
    local coreos_release=$(util.getParameterValue "(--coreos-release=)" "$@");
    local coreos_version=$(util.getParameterValue "(--coreos-version=)" "$@"); 
    
    local packer_template=$(cat "${new_mode_source_file}" | jq -c ".packer_template"); 

    local compiled_template_name=$(basename "${new_mode_output_file}");  
    compiled_template_name="${compiled_template_name%.*}";

    local compiled_template_path=$(dirname "${new_mode_output_file}");

    echo -e "\nStarting script execution [create-shell-script-run-packer.sh]";

    echo "Processing the [override variables] of Makefile...";
    if [ "${coreos_release}" == "" ]; then
        coreos_release="stable";
    fi
    if [ "${coreos_version}" == "" ]; then
        coreos_version="current";
    fi

    echo "Processing the [variables list] module...";
    local list_variables="";   
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        echo "--processing variable:: '${packer_modules}${variableJSON}'"; 
        local nameVariableJSON=$(basename ${packer_modules}${variableJSON});
        list_variables+='\\n\t\t\t-var-file="${template_path}/'${nameVariableJSON}'" \';   
    done 

    echo "Starting the creation of the [start-packer.sh] for execution Packer CLI...";  
    echo "--generated file: '${new_mode_build_path}/start-packer.sh'"; 
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
        echo -e '    local working_directory="'${working_directory}'";';
        echo -e '    local build_path="'${new_mode_build_path}'";';
        echo -e '    local provisioner_path="'${packer_provisioner_path}'";';
        echo -e '    local template_path="'${compiled_template_path}'";';
        echo -e '    local template_file="${template_path}/'${compiled_template_name}'-min.json";';
        echo -e '    __run_packer() {';
        echo -e '        # FONT: https://www.packer.io/docs/templates/user-variables.html#from-a-file';
        echo -e '        packer "$@" \'$list_variables'';
        echo -e '            -var-file="${template_path}/vars-custom-variables.json" \';
        echo -e '            -var "os_release=${coreos_release}" \';
        echo -e '            -var "os_version=${coreos_version}" \';
        echo -e '            -var "os_iso_checksum_type=${coreos_iso_checksum_type}" \';
        echo -e '            -var "os_iso_checksum=${coreos_iso_checksum}" \';
        echo -e '            -var "global_working_directory=${working_directory}" \';
        echo -e '            -var "global_build_path=${build_path}" \';
        echo -e '            -var "global_provisioner_path=${provisioner_path}" \';
        echo -e '            "${template_file}";';
        echo -e '    }';
        echo -e '    case $params in';
        echo -e '        validate) { __run_packer $params; };;';
        echo -e '        inspect)  { packer inspect "${template_file}"; };;';
        echo -e '        *build*)  { __run_packer $params; };;';
        echo -e '        *)        { packer $params; };;';
        echo -e '    esac';
        echo -e '}';
        echo -e 'StartPacker "$@";';
        echo -e 'exit 0;';
    } > "${new_mode_build_path}/start-packer.sh";

} 

# @descr: Call of execution of the script's main function.
StartCompilation "$@";

# @descr: Finishing the script!!! :P
exit 0;