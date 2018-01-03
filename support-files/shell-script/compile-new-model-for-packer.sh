#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for compiling the "New Model Packer" for "Packer". 
# @fonts: 
# @example:
#       bash compile-new-model-for-packer.sh \
#   		                  --source-file="./packer-new-model/coreos-all-platforms.json" \
#                             --output-file="./packer-builds/.../coreos-vagrant-template.json" \
#   		                  --packer-modules="./packer-modules";
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
    local source_file=$(util.getParameterValue "(--source-file=)" "$@");  
    local output_file=$(util.getParameterValue "(--output-file=)" "$@");  
    local packer_modules=$(util.getParameterValue "(--packer-modules=)" "$@");  

    local packer_template=$(cat "${source_file}" | jq -c ".packer_template"); 

    local description=$(echo "${packer_template}" | jq -r ".description");
    local min_packer_version=$(echo "${packer_template}" | jq -r ".min_packer_version");

    local compiled_template_name=$(basename "${output_file}");  
    compiled_template_name="${compiled_template_name%.*}";

    local compiled_template_path=$(dirname "${output_file}");

    echo -e "\nStarting script execution [compile-new-model-for-packer.sh]";

    echo "Creating directory for the creation of packer template...";  
    echo "--affected directory: '${compiled_template_path}'";  
    mkdir -p "${compiled_template_path}";

    echo "Processing and compiling the [variables] module...";
    echo "--generated file: '${compiled_template_path}/vars-custom-variables.json'";  
    echo "${packer_template}" | jq -c '.variables' > "${compiled_template_path}/vars-custom-variables.json";

    echo "Processing and compiling the [variables list] module...";
    for variableJSON in $(echo "${packer_template}" | jq -r '.list_variables[]'); do
        echo "--generated file: '${packer_modules}${variableJSON}'";  
        cp "${packer_modules}${variableJSON}" "${compiled_template_path}/";
    done 

    echo "Processing and compiling the [builders] module...";
    local builders="";
    local size=$(echo "${packer_template}" | jq ".builders | length");
    for builderJSON in $(echo "${packer_template}" | jq -r '.builders[]'); do
        echo "--reading file: '${packer_modules}${builderJSON}'"; 
        builders+=$(cat ${packer_modules}${builderJSON}); 
        if [ $size -gt 1 ]; then
            builders+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processing and compiling the [provisioners] module...";
    local provisioners="";
    local size=$(echo "${packer_template}" | jq ".provisioners | length");
    for provisionerJSON in $(echo "${packer_template}" | jq -r '.provisioners[]'); do
        echo "--reading file: '${packer_modules}${provisionerJSON}'"; 
        provisioners+=$(cat ${packer_modules}${provisionerJSON}); 
        if [ $size -gt 1 ]; then
            provisioners+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Processing and compiling the [post processors] module...";
    local post_processors="";      
    local size=$(echo "${packer_template}" | jq ".post_processors | length");
    for post_processorJSON in $(echo "${packer_template}" | jq -r '.post_processors[]'); do
        echo "--reading file: '${packer_modules}${post_processorJSON}'"; 
        post_processors+=$(cat ${packer_modules}${post_processorJSON}); 
        if [ $size -gt 1 ]; then
            post_processors+=",";
            size=$(($size-1)); 
        fi
    done 

    echo "Starting the compilation of the [new model] for a Packer Template...";  
    echo "--affected directory: ${compiled_template_path}"; 
    echo "--generated file: '${compiled_template_name}-min.json'";  
    touch "${compiled_template_path}/${compiled_template_name}-min.json"
    {
        echo '{"description":"'$description'","builders":['$builders'],"provisioners":['$provisioners'],"post-processors":['$post_processors'],"min_packer_version": "'${min_packer_version}'"}';
    } > "${compiled_template_path}/${compiled_template_name}-min.json"; 

    echo "--generated file: '${compiled_template_name}.json'";  
    jq . "${compiled_template_path}/${compiled_template_name}-min.json" > "${compiled_template_path}/${compiled_template_name}.json";

} 

# @descr: Call of execution of the script's main function.
StartCompilation "$@";

# @descr: Finishing the script!!! :P
exit 0;