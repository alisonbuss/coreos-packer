
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
#			  PACKAGE_NAME="coreos-stable-packer" \
#			  PACKAGE_SOURCE_FILE="./coreos-stable-package.json"
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
#MAIN_WORKING_DIRECTORY ?= .
MAIN_WORKING_DIRECTORY ?= `pwd`
BUILD_DIRECTORY ?= $(MAIN_WORKING_DIRECTORY)/packages

# VARIABLE MAN!!!!!
# DEFAULT VARIABLE - PACKAGE!!!
PACKAGE_NAME ?= coreos-aws
PACKAGE_SOURCE_FILE ?= $(MAIN_WORKING_DIRECTORY)/$(PACKAGE_NAME).json
PACKAGE_WORKING_DIRECTORY ?= $(BUILD_DIRECTORY)/$(PACKAGE_NAME)-packer
PACKAGE_COMPILED_NAME ?= $(PACKAGE_NAME)-template
PACKAGE_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/packer-template

# DEFAULT VARIABLES - Ignition For CoreOS
IGNITION_SOURCE_FILE ?= $(MAIN_WORKING_DIRECTORY)/support-files/container-linux-config/coreos-vagrant-ignition.yml
IGNITION_WORKING_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)
IGNITION_COMPILED_NAME ?= coreos-ignition
IGNITION_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/files/ignitions

# DEFAULT VARIABLES - Certificates CFSSL
CFSSL_SOURCE_FILE ?= $(MAIN_WORKING_DIRECTORY)/support-files/certificates/setting.json
CFSSL_WORKING_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)
CFSSL_COMPILED_NAME ?= coreos-cert
CFSSL_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/files/certificates

# DEFAULT VARIABLES - Building and compiling files for Packer 
#					 (Construção e compilação de arquivos para o Packer) 
COMPILE_PACKAGE_CMD                ?= $(MAIN_WORKING_DIRECTORY)/support-files/shell-script/package-for-packer.sh
COMPILE_CERTIFICATE_CMD            ?= $(MAIN_WORKING_DIRECTORY)/support-files/shell-script/cfssl-for-certificates.sh
COMPILE_COREOS_IGNITION_CMD        ?= $(MAIN_WORKING_DIRECTORY)/support-files/shell-script/container-linux-config-for-ignition.sh
CREATE_SHELL_SCRIPT_RUN_PACKER_CMD ?= $(MAIN_WORKING_DIRECTORY)/support-files/shell-script/create-shell-script-run-packer.sh
CREATE_DOCUMENTATION_PACKER_CMD	   ?= $(MAIN_WORKING_DIRECTORY)/support-files/shell-script/create-documentation-packer.sh
START_PACKER_CMD                   ?= $(PACKAGE_WORKING_DIRECTORY)/start-packer.sh

# DEFAULT VARIABLES - Vagrant Command-Line Interface (CLI) 
VAGRANT_CLI ?= up
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
	@echo "    --> MAIN_WORKING_DIRECTORY: $(MAIN_WORKING_DIRECTORY)";
	@echo "    --> BUILD_DIRECTORY: $(BUILD_DIRECTORY)";
	@echo "";
	@echo "    --> PACKAGE_NAME: $(PACKAGE_NAME)";
	@echo "    --> PACKAGE_SOURCE_FILE: $(PACKAGE_SOURCE_FILE)";
	@echo "    --> PACKAGE_WORKING_DIRECTORY: $(PACKAGE_WORKING_DIRECTORY)";
	@echo "    --> PACKAGE_COMPILED_NAME: $(PACKAGE_COMPILED_NAME)";
	@echo "    --> PACKAGE_COMPILED_DIRECTORY: $(PACKAGE_COMPILED_DIRECTORY)";
	@echo "";
	@echo "    --> IGNITION_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
	@echo "    --> IGNITION_WORKING_DIRECTORY: $(IGNITION_WORKING_DIRECTORY)";
	@echo "    --> IGNITION_COMPILED_NAME: $(IGNITION_COMPILED_NAME)";
	@echo "    --> IGNITION_COMPILED_DIRECTORY: $(IGNITION_COMPILED_DIRECTORY)";
	@echo "";
	@echo "    --> CFSSL_SOURCE_FILE: $(CFSSL_SOURCE_FILE)";
	@echo "    --> CFSSL_WORKING_DIRECTORY: $(CFSSL_WORKING_DIRECTORY)";
	@echo "    --> CFSSL_COMPILED_NAME: $(CFSSL_COMPILED_NAME)";
	@echo "    --> CFSSL_COMPILED_DIRECTORY: $(CFSSL_COMPILED_DIRECTORY)";
	@echo "";
	@echo "    --> COMPILE_PACKAGE_CMD: $(COMPILE_PACKAGE_CMD)";
	@echo "    --> COMPILE_CERTIFICATE_CMD: $(COMPILE_CERTIFICATE_CMD)";
	@echo "    --> COMPILE_COREOS_IGNITION_CMD: $(COMPILE_COREOS_IGNITION_CMD)";
	@echo "    --> CREATE_SHELL_SCRIPT_RUN_PACKER_CMD: $(CREATE_SHELL_SCRIPT_RUN_PACKER_CMD)";
	@echo "    --> START_PACKER_CMD: $(START_PACKER_CMD)";
	@echo "";


compile: 
	@bash $(COMPILE_PACKAGE_CMD) \
		--source-file="$(PACKAGE_SOURCE_FILE)" \
		--compiled-name="$(PACKAGE_COMPILED_NAME)" \
		--compiled-directory="$(PACKAGE_COMPILED_DIRECTORY)" \
		--package-working-directory="$(PACKAGE_WORKING_DIRECTORY)" \
		--main-working-directory="$(MAIN_WORKING_DIRECTORY)";

	@bash $(CREATE_SHELL_SCRIPT_RUN_PACKER_CMD) \
		--package-source-file="$(PACKAGE_SOURCE_FILE)" \
		--package-compiled-name="$(PACKAGE_COMPILED_NAME)" \
		--package-compiled-directory="$(PACKAGE_COMPILED_DIRECTORY)" \
		--package-working-directory="$(PACKAGE_WORKING_DIRECTORY)" \
		--main-working-directory="$(MAIN_WORKING_DIRECTORY)";

	@bash $(CREATE_DOCUMENTATION_PACKER_CMD) \
		--package-source-file="$(PACKAGE_SOURCE_FILE)" \
		--package-compiled-name="$(PACKAGE_COMPILED_NAME)" \
		--package-compiled-directory="$(PACKAGE_COMPILED_DIRECTORY)" \
		--package-working-directory="$(PACKAGE_WORKING_DIRECTORY)" \
		--main-working-directory="$(MAIN_WORKING_DIRECTORY)";

	@bash $(COMPILE_COREOS_IGNITION_CMD) \
		--source-file="$(IGNITION_SOURCE_FILE)" \
		--compiled-name="$(IGNITION_COMPILED_NAME)" \
		--compiled-directory="$(IGNITION_COMPILED_DIRECTORY)" \
		--platforms="'packet' 'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure'";

	@echo "Copiando arquivo do Vagrantfile..."; 
	@echo "--fonte:   $(MAIN_WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile"; 
	@echo "--destino: $(PACKAGE_WORKING_DIRECTORY)/Vagrantfile"; 
	@cp "$(MAIN_WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile" "$(PACKAGE_WORKING_DIRECTORY)/"; 

	@echo "Copiando chave privada SSH do Vagrant..."; 
	@echo "--fonte:   $(MAIN_WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key"; 
	@echo "--destino: $(PACKAGE_WORKING_DIRECTORY)/files/vagrant_insecure_private_key"; 
	@cp "$(MAIN_WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key" "$(PACKAGE_WORKING_DIRECTORY)/files";

	@echo "Compilação concluída!!!...";  


build:
	@echo "Iniciando o BUILD do projeto packer $(PACKAGE_NAME)..."; 
	@echo "--script: $(START_PACKER_CMD)"; 

	@bash $(START_PACKER_CMD) validate;

	@bash $(START_PACKER_CMD) inspect \
		$(PACKAGE_COMPILED_DIRECTORY)/$(PACKAGE_COMPILED_NAME).json;

	@bash $(START_PACKER_CMD) build;

	@echo "Construção concluída!!!...";  


build-force: clean compile build
	
		
install: 
	@echo "Iniciando a instalação do Vagrant Box do projeto packer $(PACKAGE_NAME)..."; 
	@echo "--box: $(PACKAGE_WORKING_DIRECTORY)/$(PACKAGE_NAME).box"; 

	@vagrant box list;

	@vagrant box add --force --provider="virtualbox" --name="lucifer/$(PACKAGE_NAME)" \
		$(PACKAGE_WORKING_DIRECTORY)/coreos-vagrant.box;

	@echo "Instalação do box vagrant concluída!!!...";  


clean: 
	@echo "Iniciando a exclusão dos arquivos do projeto packer $(PACKAGE_NAME)...";
	@echo "--diretorio: $(PACKAGE_WORKING_DIRECTORY)";
	
	@vagrant box remove lucifer/$(PACKAGE_NAME);

	@rm -rf $(PACKAGE_WORKING_DIRECTORY);
	
	@echo "Exclusão concluída!!!..."; 


vagrant: 
	@echo "Iniciando teste da VM do projeto packer $(PACKAGE_NAME)..."; 
	@echo "--Vagrantfile: $(PACKAGE_WORKING_DIRECTORY)/Vagrantfile"; 

	VAGRANT_CWD=$(PACKAGE_WORKING_DIRECTORY)/ vagrant $(VAGRANT_CLI);

	@echo "Teste executado!!!...";  

