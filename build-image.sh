#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: 
# @fonts: 	     
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
    # @example: 
    #     $ bash build-image.sh --action="validate" \
    #                           --template-file="./templates/coreos-virtualbox-template.json" \
	#						    --variables="vars-global.json vars-coreos.json vars-virtualbox.json vars-custom.json" \
	#   						--working-directory=".";
    #
    __validate_packer() {
        local template_file=$(util.getParameterValue "(--template-file=)" "$@");
        local variables=$(util.getParameterValue "(--variables=)" "$@");
        local working_directory=$(util.getParameterValue "(--working-directory=)" "$@");

        local variables_path="${working_directory}/variables";
        local variables_files_str="";

        for variable in ${variables}; do
            variables_files_str="${variables_files_str} -var-file=${variables_path}/${variable}";
        done

        packer validate ${variables_files_str} "${template_file}";
    }

    # @descr: ...
    # @example: 
    #     $ bash build-image.sh --action="inspect" \
    #                           --template-file="./templates/coreos-virtualbox-template.json";
    #
    __inspect_packer() {
        local template_file=$(util.getParameterValue "(--template-file=)" "$@");

        packer inspect "${template_file}";
    }

    # @descr: ...
    # @example: 
    #     $ bash build-image.sh --action="build" \
    #                           --template-file="./templates/coreos-virtualbox-template.json" \
	#						    --variables="vars-global.json vars-coreos.json vars-virtualbox.json vars-custom.json" \
    #                           --packer-only="virtualbox-iso" \
    #                           --coreos-release="stable" \
	#   						--coreos-version="1576.5.0" \
	#   						--working-directory=".";
    #
    __build_packer() {
        local template_file=$(util.getParameterValue "(--template-file=)" "$@");
        local variables=$(util.getParameterValue "(--variables=)" "$@");
        local packer_only=$(util.getParameterValue "(--packer-only=)" "$@");
        local working_directory=$(util.getParameterValue "(--working-directory=)" "$@");

        local coreos_release=$(util.getParameterValue "(--coreos-release=)" "$@");
        local coreos_version=$(util.getParameterValue "(--coreos-version=)" "$@");

        local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";
        local coreos_iso_checksum_type="SHA512";
        local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
      
        local variables_path="${working_directory}/variables";
        local variables_files_str="";

        for variable in ${variables}; do
            variables_files_str="${variables_files_str} -var-file=${variables_path}/${variable}";
        done

        packer build ${variables_files_str} \
              -var "os_release=${coreos_release}" \
              -var "os_version=${coreos_version}" \
              -var "os_iso_checksum_type=${coreos_iso_checksum_type}" \
              -var "os_iso_checksum=${coreos_iso_checksum}" \
              -var "global_working_directory=${working_directory}" \
              "${template_file}";
    }

    # @descr: ...
    # @example: 
    #     $ bash build-image.sh --action="compile" \
	#					        --source-file="./pre-provision/container-linux-config/keys-to-underworld.yml" \
	#						    --compilation-path="./pre-provision/ignitions" \
	#						    --platforms="'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure' 'packet'";
    #
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

    # --------------------------------------------------------------------------------------
    # THE THREE FUNCTIONS BELOW ARE INTENDED TO FUNCTION THE TOOLS (Vagrant and VirtualBox).
    # --------------------------------------------------------------------------------------

    # @descr: ...
    # @example: 
    #     $ bash build-image.sh --action="install-box" \
    #                           --box-name="lucifer/coreos-stable" \
	#						    --box-path="./builds/coreos-stable-1576.5.0.box";
    #
    __install_vagrant_box() {
        local box_name=$(util.getParameterValue "(--box-name=)" "$@");
        local box_path=$(util.getParameterValue "(--box-path=)" "$@");

        vagrant box add --force \
					    --provider="virtualbox" \
					    --name="${box_name}" "${box_path}";
    }

    # @descr: ...
    # @example: ...
    __publish_vagrant_box() {
        local source_file=$(util.getParameterValue "(--source-file=)" "$@");
        echo "...";
    }

    # @descr: ...
    # @example: 
    #     $ bash build-image.sh --action="uninstall-box" \
    #                           --box-name="lucifer/coreos-stable";
    #
    __uninstall_vagrant_box() {
        local box_name=$(util.getParameterValue "(--box-name=)" "$@");

        vagrant box remove --force "${box_name}";
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