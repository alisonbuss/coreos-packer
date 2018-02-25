#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: 
# @fonts: 	
# @example:
#       
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
function BuildImagePacker {

    # @descr: ...
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: ...
    __compile_ignition() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local compilation_path=$(util.getParameterValue "(--compilation-path=)" "$@");
        local platforms=$(util.getParameterValue "(--platforms=)" "$@");

        local compiled_name=$(basename "${source_file}");  
        compiled_name="${compiled_name%.*}";
        local compiled_file="${compilation_path}/${compiled_name}";

        echo "Creating directory for the creation of ignitions...";  
        echo "--affected directory: '${compilation_path}'";  
        mkdir -p "${compilation_path}";

        echo 'Starting the compilation process from "Container Linux Config" to "ignition"...';  
        echo "--affected platforms: [${platforms[@]}]"; 

        echo "Converting to (no-platform)...";
        echo "--generated file: '${compiled_name}.json'";  
        ct -in-file "${source_file}" -out-file "${compiled_file}.json" --pretty;

        echo "Converting to (vagrant-virtualbox)...";
        echo "--generated file: '${compiled_name}-for-virtualbox.json'";
        ct --platform=vagrant-virtualbox -in-file "${source_file}" -out-file "${compiled_file}-for-virtualbox.json" --pretty;

        echo "Converting to (digitalocean)...";
        echo "--generated file: '${compiled_name}-for-digitalocean.json'";
        ct --platform=digitalocean -in-file "${source_file}" -out-file "${compiled_file}-for-digitalocean.json" --pretty;

        echo "Converting to (ec2)...";
        echo "--generated file: '${compiled_name}-for-ec2.json'";
        ct --platform=ec2 -in-file "${source_file}" -out-file "${compiled_file}-for-ec2.json" --pretty;

        echo "Converting to (gce)...";
        echo "--generated file: '${compiled_name}-for-gce.json'";
        ct --platform=gce -in-file "${source_file}" -out-file "${compiled_file}-for-gce.json" --pretty;

        echo "Converting to (azure)...";
        echo "--generated file: '${compiled_name}-for-azure.json'";
        ct --platform=azure -in-file "${source_file}" -out-file "${compiled_file}-for-azure.json" --pretty;

        echo "Converting to (packet)...";
        echo "--generated file: '${compiled_name}-for-packet.json'";
        ct --platform=packet -in-file "${source_file}" -out-file "${compiled_file}-for-packet.json" --pretty;
    }

    # @descr: ...
    __validate_packer() {
        local template_file=$(util.getParameterValue "(--template-file=)" "$@");
        local variables=$(util.getParameterValue "(--variables=)" "$@");

        echo "--variables: [${variables[@]}]"; 


    }

    # @descr: ...
    __inspect_packer() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    # @descr: ...
    __build_packer() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");


    }

    # --------------------------------------------------------------------------------------
    # THE THREE FUNCTIONS BELOW ARE INTENDED TO FUNCTION THE TOOLS (Vagrant and VirtualBox).
    # --------------------------------------------------------------------------------------

    # @descr: ...
    __install_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    # @descr: ...
    __publish_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        echo "...";
    }

    # @descr: ...
    __uninstall_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    # @descr: Main function of the script "constructor"
    __initialize() {
        case ${ACTION} in
            compile) { 
                __compile_ignition "$@"; 
            };;
            validate) { 
                __validate_packer "$@"; 
            };;
            inspect) { 
                __inspect_packer "$@"; 
            };;
            build) { 
                __build_packer "$@"; 
            };;
            install-box) { 
                __install_vagrant_box "$@"; 
            };;
            publish-box) { 
                __publish_vagrant_box "$@"; 
            };;
            uninstall-box) { 
                __uninstall_vagrant_box "$@"; 
            };;
            *) {
                echo "Error: ...";
            };;
        esac
    }

    # @descr: Call of execution of the main function
    __initialize "$@";
}

# @descr: Create folder for log.
mkdir -p "${PWD}/builds";

# @descr: Call of execution of the script's main function.
BuildImagePacker "$@" 2>&1 | tee "${PWD}/builds/build-image.sh.log";

# @descr: Finishing the script!!! :P
exit 0;