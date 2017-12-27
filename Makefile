
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: https://pt.wikibooks.org/wiki/Programar_em_C/Makefiles
# 		  https://blog.pantuza.com/tutoriais/como-funciona-o-makefile
#		  http://mindbending.org/pt/makefile-para-java
#		  https://www.embarcados.com.br/introducao-ao-makefile/		
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
WORKING_DIRECTORY ?= .
#WORKING_DIRECTORY  ?= `pwd`
BUILD_DIRECTORY ?= $(WORKING_DIRECTORY)/packages

# VARIABLE MAN!!!!!
# DEFAULT VARIABLE - PACKAGE!!!
PACKAGE_PROJECT_NAME ?= coreos-alpha-packer
PACKAGE_SOURCE_FILE  ?= $(WORKING_DIRECTORY)/coreos-alpha-package.json

PACKAGE_WORKING_DIRECTORY ?= $(BUILD_DIRECTORY)/$(PACKAGE_PROJECT_NAME)
PACKAGE_COMPILED_DEFAULT_NAME ?= coreos-template
PACKAGE_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/packer

# DEFAULT VARIABLES - Ignition For CoreOS
IGNITION_SOURCE_FILE ?= $(WORKING_DIRECTORY)/support-files/container-linux-config/coreos-vagrant-ignition.yml
IGNITION_WORKING_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)
IGNITION_COMPILED_DEFAULT_NAME ?= coreos-ignition
IGNITION_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/files/ignitions

# DEFAULT VARIABLES - Certificates CFSSL
#CFSSL_SOURCE_FILE ?= $(WORKING_DIRECTORY)/support-files/certificates/setting.json
#CFSSL_WORKING_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)
#CFSSL_COMPILED_DEFAULT_NAME ?= coreos-cert
#CFSSL_COMPILED_DIRECTORY ?= $(PACKAGE_WORKING_DIRECTORY)/files/certificates

# DEFAULT VARIABLES - Building and compiling files for Packer 
#					 (Construção e compilação de arquivos para o Packer) 
BUILD_PACKAGE_CMD         ?= $(WORKING_DIRECTORY)/support-files/shell-script/package-for-packer.sh
BUILD_CERTIFICATE_CMD     ?= $(WORKING_DIRECTORY)/support-files/shell-script/cfssl-for-certificates.sh
BUILD_COREOS_IGNITION_CMD ?= $(WORKING_DIRECTORY)/support-files/shell-script/container-linux-config-for-ignition.sh
START_BUILDING_PACKER_CMD ?= $(PACKAGE_WORKING_DIRECTORY)/build.sh


# Doc:
# ......
plan: 
	@echo "Exibir plano de execução e seus valores:";
	@echo "";
	@echo "    --> WORKING_DIRECTORY: $(WORKING_DIRECTORY)";
	@echo "    --> BUILD_DIRECTORY: $(BUILD_DIRECTORY)";
	@echo "";
	@echo "    --> PACKAGE_SOURCE_FILE: $(PACKAGE_SOURCE_FILE)";
	@echo "    --> PACKAGE_WORKING_DIRECTORY: $(PACKAGE_WORKING_DIRECTORY)";
	@echo "    --> PACKAGE_COMPILED_DEFAULT_NAME: $(PACKAGE_COMPILED_DEFAULT_NAME)";
	@echo "    --> PACKAGE_COMPILED_DIRECTORY: $(PACKAGE_COMPILED_DIRECTORY)";
	@echo "";
	@echo "    --> IGNITION_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
	@echo "    --> IGNITION_WORKING_DIRECTORY: $(IGNITION_WORKING_DIRECTORY)";
	@echo "    --> IGNITION_COMPILED_DEFAULT_NAME: $(IGNITION_COMPILED_DEFAULT_NAME)";
	@echo "    --> IGNITION_COMPILED_DIRECTORY: $(IGNITION_COMPILED_DIRECTORY)";
	@echo "";
	#@echo "    --> CFSSL_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
	#@echo "    --> CFSSL_WORKING_DIRECTORY: $(IGNITION_WORKING_DIRECTORY)";
	#@echo "    --> CFSSL_COMPILED_DEFAULT_NAME: $(IGNITION_COMPILED_DEFAULT_NAME)";
	#@echo "    --> CFSSL_COMPILED_DIRECTORY: $(IGNITION_COMPILED_DIRECTORY)";
	#@echo "";
	@echo "    --> BUILD_PACKAGE_CMD: $(BUILD_PACKAGE_CMD)";
	@echo "    --> BUILD_CERTIFICATE_CMD: $(BUILD_CERTIFICATE_CMD)";
	@echo "    --> BUILD_COREOS_IGNITION_CMD: $(BUILD_COREOS_IGNITION_CMD)";
	@echo "    --> START_BUILDING_PACKER_CMD: $(START_BUILDING_PACKER_CMD)";
	@echo "";

# Doc:
# ......
compile: 
	# Doc:
	# ......
	@bash $(BUILD_PACKAGE_CMD) \
		--package-source-file="$(PACKAGE_SOURCE_FILE)" \
		--package-working-directory="$(PACKAGE_WORKING_DIRECTORY)" \
		--package-compiled-default-name="$(PACKAGE_COMPILED_DEFAULT_NAME)" \
		--package-compiled-directory="$(PACKAGE_COMPILED_DIRECTORY)" \
		--working-directory="$(WORKING_DIRECTORY)";

	# Doc:
	# ......
	#@bash $(BUILD_CERTIFICATE_CMD) \
	#	--cert-source-file="$(CFSSL_SOURCE_FILE)" \
	#	--cert-working-directory="$(CFSSL_WORKING_DIRECTORY)" \
	#	--cert-compiled-default-name="$(CFSSL_COMPILED_DEFAULT_NAME)" \
	#	--cert-compiled-directory="$(CFSSL_COMPILED_DIRECTORY)" \
	#	--working-directory="$(WORKING_DIRECTORY)";

	# Doc:
	# ......
	@bash $(BUILD_COREOS_IGNITION_CMD) \
		--ignition-source-file="$(IGNITION_SOURCE_FILE)" \
		--ignition-working-directory="$(IGNITION_WORKING_DIRECTORY)" \
		--ignition-compiled-default-name="$(IGNITION_COMPILED_DEFAULT_NAME)" \
		--ignition-compiled-directory="$(IGNITION_COMPILED_DIRECTORY)" \
		--platforms="'packet' 'vagrant-virtualbox' 'digitalocean' 'ec2' 'gce' 'azure'";

	@echo "Copiando arquivo do Vagrantfile..."; 
	@echo "--fonte:   $(WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile"; 
	@echo "--destino: $(PACKAGE_WORKING_DIRECTORY)/Vagrantfile"; 
	@cp "$(WORKING_DIRECTORY)/support-files/vagrant/Vagrantfile" "$(PACKAGE_WORKING_DIRECTORY)/"; 

	@echo "Copiando chave privada SSH do Vagrant..."; 
	@echo "--fonte:   $(WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key"; 
	@echo "--destino: $(PACKAGE_WORKING_DIRECTORY)/files/vagrant_insecure_private_key"; 
	@cp "$(WORKING_DIRECTORY)/support-files/vagrant/vagrant_insecure_private_key" "$(PACKAGE_WORKING_DIRECTORY)/files";

	@echo "Compilação concluída!!!...";  


# Doc:
# ......
build:
	@echo "Iniciando o BUILD do projeto packer $(PACKAGE_PROJECT_NAME)..."; 
	@echo "--script: $(PACKAGE_WORKING_DIRECTORY)/build.sh"; 
	@cat "$(PACKAGE_WORKING_DIRECTORY)/build.sh"; 

	@bash $(START_BUILDING_PACKER_CMD);

	@echo "Construção concluída!!!...";  


# Doc:
# ......
build-force: clean compile build
	

# Doc:
# ......		
install: 
	@echo "Iniciando a instalação do Vagrant Box do projeto packer $(PACKAGE_PROJECT_NAME)..."; 
	@echo "--box: $(PACKAGE_WORKING_DIRECTORY)/$(PACKAGE_PROJECT_NAME).box"; 

	@vagrant box add --force --provider=virtualbox \
		--name lucifer/$(PACKAGE_PROJECT_NAME) \
		$(PACKAGE_WORKING_DIRECTORY)/$(PACKAGE_PROJECT_NAME).box;

	@echo "Instalação do box vagrant concluída!!!...";  


# Doc:
# ......
clean: 
	@echo "Iniciando a exclusão dos arquivos do projeto packer $(PACKAGE_PROJECT_NAME)..."; 
	@echo "--diretorio: $(PACKAGE_WORKING_DIRECTORY)/*"; 

    #@rm -rf $(PACKAGE_WORKING_DIRECTORY);
	
	@echo "Exclusão concluída!!!...";  


# Doc:
# ......
test-vagrant: 
	@echo "Iniciando teste da VM do projeto packer $(PACKAGE_PROJECT_NAME)..."; 
	@echo "--Vagrantfile: $(PACKAGE_WORKING_DIRECTORY)/Vagrantfile"; 

	VAGRANT_CWD=$(PACKAGE_WORKING_DIRECTORY)/ vagrant up;

	@echo "Teste executado!!!...";  

