#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for compiling the "Container Linux Config" for CoreOS "Ignition". 
# @fonts: https://github.com/coreos/container-linux-config-transpiler
#         https://coreos.com/os/docs/latest/configuration.html
#         https://github.com/dyson/packer-qemu-coreos-container-linux/blob/master/Makefile
# @example:
#       bash compile-container-linux-config.sh \
#   		                  --source-file="source-ignition.yml" \
#                             --build-path="./folderX" \
#                             --compiled-name="ignitionX" \
#   		                  --platforms="'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure' 'packet'";
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
    local build_path=$(util.getParameterValue "(--build-path=)" "$@");  
    local compiled_name=$(util.getParameterValue "(--compiled-name=)" "$@");  
    local platforms=$(util.getParameterValue "(--platforms=)" "$@");  
    local compiled_file="${build_path}/${compiled_name}";  

    echo -e "\nStarting script execution [compile-container-linux-config.sh]";

    echo "Creating directory for the creation of ignitions...";  
    echo "--affected directory: '${build_path}'";  
    mkdir -p "${build_path}";

    echo 'Starting the compilation process from "Container Linux Config" to "ignition"...';  
    echo "--affected platforms: [${platforms[@]}]"; 

    echo "Converting to (no-platform)...";
    echo "--generated file: '${compiled_file}.json'";  
    ct -in-file "${source_file}" -out-file "${compiled_file}.json" --pretty;

    echo "Converting to (vagrant-virtualbox)...";
    echo "--generated file: '${compiled_file}-for-virtualbox.json'";
    ct --platform=vagrant-virtualbox -in-file "${source_file}" -out-file "${compiled_file}-for-virtualbox.json" --pretty;

    echo "Converting to (digitalocean)...";
    echo "--generated file: '${compiled_file}-for-digitalocean.json'";
    ct --platform=digitalocean -in-file "${source_file}" -out-file "${compiled_file}-for-digitalocean.json" --pretty;

    echo "Converting to (ec2)...";
    echo "--generated file: '${compiled_file}-for-ec2.json'";
    ct --platform=ec2 -in-file "${source_file}" -out-file "${compiled_file}-for-ec2.json" --pretty;

    echo "Converting to (gce)...";
    echo "--generated file: '${compiled_file}-for-gce.json'";
    ct --platform=gce -in-file "${source_file}" -out-file "${compiled_file}-for-gce.json" --pretty;

    echo "Converting to (azure)...";
    echo "--generated file: '${compiled_file}-for-azure.json'";
    ct --platform=azure -in-file "${source_file}" -out-file "${compiled_file}-for-azure.json" --pretty;

    echo "Converting to (packet)...";
    echo "--generated file: '${compiled_file}-for-packet.json'";
    ct --platform=packet -in-file "${source_file}" -out-file "${compiled_file}-for-packet.json" --pretty;

} 

# @descr: Call of execution of the script's main function.
StartCompilation "$@";

# @descr: Finishing the script!!! :P
exit 0;