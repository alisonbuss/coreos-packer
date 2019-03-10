
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Makefile for automation in building and deploying CoreOS images using Packer.
# @fonts: https://vsupalov.com/packer-ami/
#         https://pt.wikibooks.org/wiki/Programar_em_C/Makefiles
#         https://blog.pantuza.com/tutoriais/como-funciona-o-makefile
#         http://mindbending.org/pt/makefile-para-java
#         https://www.embarcados.com.br/introducao-ao-makefile/
#         https://github.com/dyson/packer-qemu-coreos-container-linux/blob/master/Makefile
#         https://github.com/coreos/container-linux-config-transpiler
#         https://github.com/coreos/container-linux-config-transpiler/blob/master/doc/dynamic-data.md#supported-data-by-provider
#         https://coreos.com/os/docs/latest/configuration.html
#         https://www.packer.io/docs/templates/communicator.html
#         https://www.packer.io/docs/builders/virtualbox-iso.html
#
# @example:
#
#       $ make help;
#   OR
#       $ make plan clear compile validate build;
#   OR
#       $ make ENVIRONMENT="development" \ 
#              PLATFORM="virtualbox" \ 
#              plan clear compile validate build \ 
#              deploy-vagrant-box publish-vagrant-box \ 
#              2>&1 | tee "${PWD}/builds/deploy-development.log";
#
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
# --Possible values: [development, staging, production].
ENVIRONMENT                 ?= development

# --Possible values: [aws, google, digitalocean, virtualbox, all].
PLATFORM                    ?= all

WORKING_DIRECTORY           ?= `pwd`
BUILD_DIRECTORY             ?= $(WORKING_DIRECTORY)/builds/$(ENVIRONMENT)

# DEFAULT VARIABLES - Packer!!!
PACKER_TEMPLATE_FILE        ?= $(PLATFORM)-template.json
PACKER_TEMPLATES_PATH       ?= $(WORKING_DIRECTORY)/templates
PACKER_VARIABLES_PATH       ?= $(WORKING_DIRECTORY)/variables

# DEFAULT VARIABLES - Ignition For CoreOS
IGNITION_SOURCE_FILE        ?= $(WORKING_DIRECTORY)/environments/$(ENVIRONMENT)/container-linux-config/deployment-source.yml
IGNITION_COMPILATION_PATH   ?= $(BUILD_DIRECTORY)/coreos-ignitions
IGNITION_PLATFORMS          ?= vagrant-virtualbox digitalocean ec2 gce
IGNITION_TRANSPILER_URL     ?= https://github.com/coreos/container-linux-config-transpiler/releases/download
IGNITION_TRANSPILER_VERSION ?= 0.9.0

# DEFAULT VARIABLES - Vagrant
VAGRANT_BOX_NAME            ?= local/image/coreos-vagrant-v1
VAGRANT_BOX_FILE            ?= $(BUILD_DIRECTORY)/image-coreos-vagrant.box


plan: 
	@echo "The default values to be used by this Makefile:";
	@echo "";
	@echo "    --> MAKECMDGOALS: '$$ make $(MAKECMDGOALS)'";
	@echo "";
	@echo "    --> ENVIRONMENT: $(ENVIRONMENT)";
	@echo "    --> PLATFORM: $(PLATFORM)";

	@echo "    --> WORKING_DIRECTORY: $(WORKING_DIRECTORY)";
	@echo "    --> BUILD_DIRECTORY: $(BUILD_DIRECTORY)";
	@echo "";
	@echo "    --> PACKER_TEMPLATE_FILE: $(PACKER_TEMPLATE_FILE)";
	@echo "    --> PACKER_TEMPLATES_PATH: $(PACKER_TEMPLATES_PATH)";
	@echo "    --> PACKER_VARIABLES_PATH: $(PACKER_VARIABLES_PATH)";
	@echo "";
	@echo "    --> IGNITION_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
	@echo "    --> IGNITION_COMPILATION_PATH: $(IGNITION_COMPILATION_PATH)";
	@echo "    --> IGNITION_PLATFORMS: $(IGNITION_PLATFORMS)";
	@echo "    --> IGNITION_TRANSPILER_URL: $(IGNITION_TRANSPILER_URL)";
	@echo "    --> IGNITION_TRANSPILER_VERSION: $(IGNITION_TRANSPILER_VERSION)";
	@echo "";
	@echo "    --> VAGRANT_BOX_NAME: $(VAGRANT_BOX_NAME)";
	@echo "    --> VAGRANT_BOX_FILE: $(VAGRANT_BOX_FILE)";
	@echo "";


install-transpiler: 
	@echo "Starting the installation of Config Transpiler, the generator of ignition files for CoreOS..."; 

	# Creating directory for the binaries...
	@mkdir -p "$(WORKING_DIRECTORY)/builds";

	# Downloading the binary...
	@if ! [ $$(which "$(WORKING_DIRECTORY)/builds/ct") ] ; then \
        wget "$(IGNITION_TRANSPILER_URL)/v$(IGNITION_TRANSPILER_VERSION)/ct-v$(IGNITION_TRANSPILER_VERSION)-x86_64-unknown-linux-gnu" \
             -q --show-progress -O "$(WORKING_DIRECTORY)/builds/ct"; \
	else \
        echo "Container Linux Config Transpiler is installed!"; \
	fi

	@echo "Complete installation!"; 


compile: install-transpiler
	@echo "Starting the compilation of the 'Container Linux Config' for IGNITION the of CoreOS...";
	
	# Creating directory for the creation of ignitions...
	mkdir -p "$(IGNITION_COMPILATION_PATH)";

	# Converting to (no-platform)
	$(WORKING_DIRECTORY)/builds/ct \
	    --in-file "$(IGNITION_SOURCE_FILE)" \
	    --out-file "$(IGNITION_COMPILATION_PATH)/deployment.json" \
	    --pretty;
	
	# Platform to target. Accepted values: [
	#    azure digitalocean ec2 gce packet openstack-metadata vagrant-virtualbox cloudstack-configdrive
	# ]
	for platform in $(IGNITION_PLATFORMS); do \
		$(WORKING_DIRECTORY)/builds/ct \
		    --platform="$${platform}" \
		    --in-file="$(IGNITION_SOURCE_FILE)" \
		    --out-file="$(IGNITION_COMPILATION_PATH)/deployment-$${platform}.json" \
		    --pretty; \
	done

	@echo "Complete compilation!";


validate:
	@echo "Starting the validation of the template Packer...";
	@echo "--template file: $(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE_FILE)";

	packer inspect "$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE_FILE)";

	packer validate -var-file="$(PACKER_VARIABLES_PATH)/global.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/credential/aws.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/credential/google.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/credential/vagrant.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/credential/digitalocean.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/platform/aws.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/platform/google.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/platform/virtualbox.json" \
	                -var-file="$(PACKER_VARIABLES_PATH)/platform/digitalocean.json" \
	                -var-file="$(WORKING_DIRECTORY)/environments/$(ENVIRONMENT)/custom-variables/custom.json" \
	                -var="global_working_directory=$(WORKING_DIRECTORY)" \
	                -var="global_build_directory=$(BUILD_DIRECTORY)" \
	                "$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE_FILE)";

	@echo "Complete validate!";


build:
	@echo "Starting the BUILD of the template Packer..."; 
	@echo "--template file: $(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE_FILE)";

	packer build -parallel="true" \
                 -var-file="$(PACKER_VARIABLES_PATH)/global.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/credential/aws.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/credential/google.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/credential/vagrant.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/credential/digitalocean.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/platform/aws.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/platform/google.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/platform/virtualbox.json" \
	             -var-file="$(PACKER_VARIABLES_PATH)/platform/digitalocean.json" \
	             -var-file="$(WORKING_DIRECTORY)/environments/$(ENVIRONMENT)/custom-variables/custom.json" \
	             -var="global_working_directory=$(WORKING_DIRECTORY)" \
	             -var="global_build_directory=$(BUILD_DIRECTORY)" \
                 "$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE_FILE)";

	@echo "Complete build!";


build-force: plan clean compile validate build


clean:
	@echo "Starting the deletion of builds files from the Project...";
	@echo "--affected directory: $(BUILD_DIRECTORY)";

	# Removing generated files for Build
	@rm -rf $(BUILD_DIRECTORY); sleep 2s;

	# List all box and status
	vagrant box list;
	vagrant global-status;

	# Starting the uninstallation of the Vagrant Box
	-vagrant box remove --force "$(VAGRANT_BOX_NAME)";

	# List all box and status
	vagrant box list;
	vagrant global-status;
	
	@echo "cleaning completed!"; 


deploy-vagrant-box:
	@echo "Starting the installation of the Vagrant Box generated by Packer..."; 
	@echo "--box name: $(VAGRANT_BOX_NAME)"; 
	@echo "--box file: $(VAGRANT_BOX_FILE)"; 

	# List all box and status
	vagrant box list;
	vagrant global-status;

	# Vagrant Box Installation
	vagrant box add --force \
	                --provider="virtualbox" \
	                --name="$(VAGRANT_BOX_NAME)" "$(VAGRANT_BOX_FILE)";

	# List all box and status
	vagrant box list;
	vagrant global-status;

	@echo "Complete Vagrant Box installation!";  


publish-vagrant-box: 
	@echo "Starting the publish of the Vagrant Box on Vagrant Cloud generated by Packer..."; 
	@echo "--box name: $(VAGRANT_BOX_NAME)"; 
	@echo "--box file: $(VAGRANT_BOX_FILE)"; 

	@echo "--WARNING: Configuration not implemented!!!...";

	@echo "Complete Vagrant Box publish!";  


help:
	@echo ' '
	@echo 'Usage: make <TARGETS> ... [OPTIONS]'
	@echo ' '
	@echo 'TARGETS:'
	@echo ' '
	@echo '  Main:'
	@echo '     install-transpiler     Starts the installation of Config Transpiler the of CoreOS.'
	@echo '     compile                Starts the compilation of the (Container Linux Config) for IGNITION the of CoreOS'
	@echo '                              --> DEPENDENCY: install-transpiler.'
	@echo '     validate               Starts the validation of the template Packer.'
	@echo '     build                  Starts the BUILD of the template Packer.'
	@echo '     build-force            Starts one building forced, clean of the template Packer'
	@echo '                              --> DEPENDENCY: plan, clean, compile, validate, build.'
	@echo '     clean                  Starts the deletion of builds files from the Project.'
	@echo '     deploy-vagrant-box     Starts the installation of the Vagrant Box generated by Packer.'
	@echo '     publish-vagrant-box    Starts the publish of the Vagrant Box on Vagrant Cloud generated by Packer.'
	@echo ' '
	@echo '  View details:'
	@echo '     plan    The default values to be used by this Makefile.'
	@echo ' '
	@echo '  Help:'
	@echo '     help    Print this help message.'
	@echo ' '
	@echo 'OPTIONS:'
	@echo ' '
	@echo '   ENVIRONMENT          Specifies the type of environment variable for the Packer deployment,'
	@echo '                        the default is [development], possible values: [development, staging, production].'
	@echo '   PLATFORM             Specifies the type of platform variable for the Packer deployment,'
	@echo '                        the default is [virtualbox], possible values: [aws, google, digitalocean, virtualbox, all].'
	@echo '   WORKING_DIRECTORY    Specify the current working directory, the default is [`pwd`].'
	@echo ' '
