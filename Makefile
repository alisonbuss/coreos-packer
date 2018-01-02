
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: https://pt.wikibooks.org/wiki/Programar_em_C/Makefiles
# 		  https://blog.pantuza.com/tutoriais/como-funciona-o-makefile
#		  http://mindbending.org/pt/makefile-para-java
#		  https://www.embarcados.com.br/introducao-ao-makefile/		
# @example:
#       $ make plan compile build install vagrant
#   OR
#       $ make plan
#   OR
#       $ make compile  
#   OR
#       $ make build  
#   OR
#       $ make build-force  
#   OR
#       $ make install  
#   OR
#       $ make clean  
#   OR
#       $ make vagrant  
#   OR
#       $ make vagrant VAGRANT_CLI="status"  
#   OR
#       $ make vagrant VAGRANT_CLI="ssh coreos01.example.com"   
#   OR
#       $ make vagrant VAGRANT_CLI="box list"   
#   OR
#       $ make vagrant VAGRANT_CLI="global-status"   
#   OR
#       $ make vagrant VAGRANT_CLI="destroy"   
#	OR
#		$ make plan compile build install vagrant \
#			  NEW_MODEL_NAME="coreos-vagrant" \
#			  NEW_MODEL_SOURCE_FILE="./packer-new-model/coreos-vagrant.json"
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
WORKING_DIRECTORY     ?= .
#WORKING_DIRECTORY    ?= `pwd`
PACKER_BUILD_PATH     ?= $(WORKING_DIRECTORY)/packer-builds
PACKER_MODULES_PATH   ?= $(WORKING_DIRECTORY)/packer-modules
PACKER_NEW_MODEL_PATH ?= $(WORKING_DIRECTORY)/packer-new-model
PACKER_ONLY           ?= virtualbox-iso

# VARIABLE MAN!!!!!
# DEFAULT VARIABLE - NEW NEW_MODEL!!! to be compiled!!!
NEW_MODEL_NAME ?= coreos-vagrant

NEW_MODEL_SOURCE_FILE   ?= $(PACKER_NEW_MODEL_PATH)/$(NEW_MODEL_NAME).json
NEW_MODEL_BUILD_PATH    ?= $(PACKER_BUILD_PATH)/$(NEW_MODEL_NAME)-packer
NEW_MODEL_COMPILED_NAME ?= $(NEW_MODEL_NAME)-template
NEW_MODEL_COMPILED_PATH ?= $(NEW_MODEL_BUILD_PATH)/packer-template
NEW_MODEL_OUTPUT_FILE   ?= $(NEW_MODEL_COMPILED_PATH)/$(NEW_MODEL_COMPILED_NAME).json

# DEFAULT VARIABLE - CoreOS!!!
COREOS_RELEASE ?= stable
COREOS_VERSION ?= current

# DEFAULT VARIABLES - Ignition For CoreOS
IGNITION_SOURCE_FILE   ?= $(WORKING_DIRECTORY)/support-files/container-linux-config/coreos-vagrant-ignition.yml
IGNITION_BUILD_PATH    ?= $(NEW_MODEL_BUILD_PATH)/files/ignitions
IGNITION_COMPILED_NAME ?= coreos-ignition

# DEFAULT VARIABLES - Certificates CFSSL
CFSSL_BUILD_PATH ?= $(NEW_MODEL_BUILD_PATH)/files/certificates

# DEFAULT VARIABLES - Building and compiling files for Packer 
#					 (Construção e compilação de arquivos para o Packer) 
COMPILE_NEW_MODEL_FOR_PACKER_CMD   ?= $(WORKING_DIRECTORY)/support-files/shell-script/compile-new-model-for-packer.sh
COMPILE_CONFIG_IGNITION_CMD        ?= $(WORKING_DIRECTORY)/support-files/shell-script/compile-container-linux-config.sh
COMPILE_CERTIFICATE_CMD            ?= $(WORKING_DIRECTORY)/support-files/shell-script/compile-cfssl-certificates.sh
CREATE_SHELL_SCRIPT_RUN_PACKER_CMD ?= $(WORKING_DIRECTORY)/support-files/shell-script/create-shell-script-run-packer.sh
CREATE_DOCUMENTATION_PACKER_CMD	   ?= $(WORKING_DIRECTORY)/support-files/shell-script/create-documentation-packer.sh
START_PACKER_CMD                   ?= $(NEW_MODEL_BUILD_PATH)/start-packer.sh

# DEFAULT VARIABLES - Vagrant Command-Line Interface (CLI) 
VAGRANT_CLI ?= version
#VAGRANT_CLI ?= status
#VAGRANT_CLI ?= ssh coreos01.example.com
#VAGRANT_CLI ?= halt
#VAGRANT_CLI ?= reload
#VAGRANT_CLI ?= destroy
#VAGRANT_CLI ?= validate
#VAGRANT_CLI ?= box list
#VAGRANT_CLI ?= global-status

plan: 
	@echo "The default values to be used by this Makefile:";
	@echo "";
	@echo "    --> MAKECMDGOALS: 'make $(MAKECMDGOALS)'";
	@echo "    --> WORKING_DIRECTORY: $(WORKING_DIRECTORY)";
	@echo "";
	@echo "    --> PACKER_BUILD_PATH: $(PACKER_BUILD_PATH)";
	@echo "    --> PACKER_MODULES_PATH: $(PACKER_MODULES_PATH)";
	@echo "    --> PACKER_NEW_MODEL_PATH: $(PACKER_NEW_MODEL_PATH)";
	@echo "    --> PACKER_ONLY: $(PACKER_ONLY)";
	@echo "";
	@echo "    --> NEW_MODEL_NAME: $(NEW_MODEL_NAME)";
	@echo "    --> NEW_MODEL_SOURCE_FILE: $(NEW_MODEL_SOURCE_FILE)";
	@echo "    --> NEW_MODEL_BUILD_PATH: $(NEW_MODEL_BUILD_PATH)";
	@echo "    --> NEW_MODEL_COMPILED_NAME: $(NEW_MODEL_COMPILED_NAME)";
	@echo "    --> NEW_MODEL_COMPILED_PATH: $(NEW_MODEL_COMPILED_PATH)";
	@echo "    --> NEW_MODEL_OUTPUT_FILE: $(NEW_MODEL_OUTPUT_FILE)";
	@echo "";
	@echo "    --> COREOS_RELEASE: $(COREOS_RELEASE)";
	@echo "    --> COREOS_VERSION: $(COREOS_VERSION)";
	@echo "";
	@echo "    --> IGNITION_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
	@echo "    --> IGNITION_BUILD_PATH: $(IGNITION_BUILD_PATH)";
	@echo "    --> IGNITION_COMPILED_NAME: $(IGNITION_COMPILED_NAME)";
	@echo "";
	@echo "    --> CFSSL_BUILD_PATH: $(CFSSL_BUILD_PATH)";
	@echo "";
	@echo "    --> COMPILE_NEW_MODEL_FOR_PACKER_CMD: $(COMPILE_NEW_MODEL_FOR_PACKER_CMD)";
	@echo "    --> COMPILE_CONFIG_IGNITION_CMD: $(COMPILE_CONFIG_IGNITION_CMD)";
	@echo "    --> COMPILE_CERTIFICATE_CMD: $(COMPILE_CERTIFICATE_CMD)";
	@echo "    --> CREATE_SHELL_SCRIPT_RUN_PACKER_CMD: $(CREATE_SHELL_SCRIPT_RUN_PACKER_CMD)";
	@echo "    --> CREATE_DOCUMENTATION_PACKER_CMD: $(CREATE_DOCUMENTATION_PACKER_CMD)";
	@echo "    --> START_PACKER_CMD: $(START_PACKER_CMD)";
	@echo "";


compile: 
	@bash $(COMPILE_NEW_MODEL_FOR_PACKER_CMD) \
		--source-file="$(NEW_MODEL_SOURCE_FILE)" \
		--output-file="$(NEW_MODEL_OUTPUT_FILE)" \
		--packer-modules="$(PACKER_MODULES_PATH)";

	@bash $(CREATE_SHELL_SCRIPT_RUN_PACKER_CMD) \
		--new-model-source-file="$(NEW_MODEL_SOURCE_FILE)" \
		--new-model-output-file="$(NEW_MODEL_OUTPUT_FILE)" \
		--new-model-build-path="$(NEW_MODEL_BUILD_PATH)" \
		--packer-modules="$(PACKER_MODULES_PATH)" \
		--coreos-release="$(COREOS_RELEASE)" \
		--coreos-version="$(COREOS_VERSION)";

	@bash $(CREATE_DOCUMENTATION_PACKER_CMD) \
		--new-model-source-file="$(NEW_MODEL_SOURCE_FILE)" \
		--new-model-output-file="$(NEW_MODEL_OUTPUT_FILE)" \
		--new-model-build-path="$(NEW_MODEL_BUILD_PATH)" \
		--packer-modules="$(PACKER_MODULES_PATH)";

	@bash $(COMPILE_CONFIG_IGNITION_CMD) \
		--source-file="$(IGNITION_SOURCE_FILE)" \
		--build-path="$(IGNITION_BUILD_PATH)" \
		--compiled-name="$(IGNITION_COMPILED_NAME)" \
		--platforms="'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure' 'packet'";

	@echo "Copiando arquivos dos provisionadores..."; 
	@echo "--fonte..: $(WORKING_DIRECTORY)/provisioners"; 
	@echo "--destino: $(NEW_MODEL_BUILD_PATH)"; 
	@cp -r "$(WORKING_DIRECTORY)/provisioners" "$(NEW_MODEL_BUILD_PATH)/"; 

	@echo "Copiando arquivo do Vagrantfile..."; 
	@echo "--fonte..: $(WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile"; 
	@echo "--destino: $(NEW_MODEL_BUILD_PATH)/Vagrantfile"; 
	@cp "$(WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile" "$(NEW_MODEL_BUILD_PATH)/"; 

	@echo "Copiando chave privada SSH do Vagrant..."; 
	@echo "--fonte..: $(WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key"; 
	@echo "--destino: $(NEW_MODEL_BUILD_PATH)/files/vagrant_insecure_private_key"; 
	@cp "$(WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key" "$(NEW_MODEL_BUILD_PATH)/files";

	@echo "Compilação concluída!!!...";  


build:
	@echo "Iniciando o BUILD do projeto packer [$(NEW_MODEL_NAME)]..."; 
	@echo "--script: $(START_PACKER_CMD)"; 

	@bash $(START_PACKER_CMD) validate;
	@bash $(START_PACKER_CMD) inspect;
	@bash $(START_PACKER_CMD) build -only="$(PACKER_ONLY)";

	@echo "Construção concluída!!!...";  


build-force: clean compile build
	
		
install-box: 
	@echo "Iniciando a instalação do Vagrant Box do projeto packer [$(NEW_MODEL_NAME)]..."; 
	@echo "--box: $(NEW_MODEL_BUILD_PATH)/coreos-vagrant.box"; 

	@vagrant box list;
	@vagrant box add --force \
					 --provider="virtualbox" \
					 --name="lucifer/$(NEW_MODEL_NAME)" \
					 $(NEW_MODEL_BUILD_PATH)/coreos-vagrant.box;
	@vagrant box list;

	@echo "Instalação do vagrant box concluída!!!...";  


uninstall-box: 
	@echo "Iniciando a desinstalação do Vagrant Box do projeto packer [$(NEW_MODEL_NAME)]..."; 
	@echo "--box: $(NEW_MODEL_BUILD_PATH)/coreos-vagrant.box"; 

	@vagrant box list;
	@vagrant box remove lucifer/$(NEW_MODEL_NAME);
	@vagrant box list;

	@echo "Desinstalação do vagrant box concluída!!!...";


clean: 
	@echo "Iniciando a exclusão dos arquivos do projeto packer [$(NEW_MODEL_NAME)]...";
	@echo "--diretorio: $(NEW_MODEL_BUILD_PATH)";

	@rm -rf $(NEW_MODEL_BUILD_PATH); sleep 2s;
	
	@echo "Exclusão concluída!!!..."; 


clean-force: 
	@echo "Iniciando a exclusão dos arquivos de BUILDs";
	@echo "--diretorio: $(PACKER_BUILD_PATH)";

	@rm -rf $(PACKER_BUILD_PATH); sleep 2s;
	
	@echo "Exclusão concluída!!!..."; 


vagrant: 
	@echo "Iniciando teste vagrant do projeto packer [$(NEW_MODEL_NAME)]..."; 
	@echo "--Vagrantfile: $(NEW_MODEL_BUILD_PATH)/Vagrantfile"; 

	VAGRANT_CWD=$(NEW_MODEL_BUILD_PATH)/ vagrant $(VAGRANT_CLI);

	@echo "Teste executado!!!...";  


vagrant-up: 
	@echo "Iniciando teste vagrant do projeto packer [$(NEW_MODEL_NAME)]..."; 
	@echo "--Vagrantfile: $(NEW_MODEL_BUILD_PATH)/Vagrantfile"; 

	VAGRANT_CWD=$(NEW_MODEL_BUILD_PATH)/ vagrant up;

	@echo "Teste executado!!!...";  

