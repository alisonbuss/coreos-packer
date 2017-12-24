
# DEFAULT VARIABLES.
COREOS_RELEASE ?= alpha
PACKAGE_FILE ?= ./package-coreos-$(COREOS_RELEASE).json

SHELL_SCRIPT_FOLDER ?= ./support-files/shell-script
WORKING_DIRECTORY ?= `pwd`

compile:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="compile" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;
	

build:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="compile" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;

	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="build" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;


build-force:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="clean" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \\;

	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="compile" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;

	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="build" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;

		
install: 
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="install" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;


clean:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="clean" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \\;
		

test-vagrant:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="test-vagrant" \
		--package-file="$(PACKAGE_FILE)" \
		--working-directory="$(WORKING_DIRECTORY)" \;

