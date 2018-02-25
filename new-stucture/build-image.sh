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
     
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    __compile_ignition() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local compilation_path=$(util.getParameterValue "(--compilation-path=)" "$@");
        local platforms=$(util.getParameterValue "(--platforms=)" "$@");

    }

    __validate_packer() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    __inspect_packer() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    __build_packer() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");


    }

    __install_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

    __publish_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        echo "...";
    }

    __uninstall_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");

    }

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

# @descr: Call of execution of the script's main function.
BuildImagePacker "$@" 2>&1 | tee build-image.sh.log;

# @descr: Finishing the script!!! :P
exit 0;