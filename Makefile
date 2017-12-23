
# VARIABLES.
COREOS_RELEASE ?= alpha

PACKAGE_NAME ?= coreos-$(COREOS_RELEASE)
PACKAGE_FILE ?= ./package-coreos-$(COREOS_RELEASE).json
PACKAGE_COMPILED_FOLDER ?= ./builds/$(PACKAGE_NAME)

BUILD_FOLDER ?= $(PACKAGE_COMPILED_FOLDER)
FILE_FOLDER ?= ./support-files
SHELL_SCRIPT_FOLDER ?= $(FILE_FOLDER)/shell-script
WORKING_DIRECTORY ?= `pwd`

compile:
	bash $(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="compile" \
		--working-directory="$(WORKING_DIRECTORY)" \
	

build:
	$(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="build" \
		--working-directory="$(WORKING_DIRECTORY)" \
		

build-force:
	$(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="build-force" \
		--working-directory="$(WORKING_DIRECTORY)" \
		

install:
	$(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="install" \
		--working-directory="$(WORKING_DIRECTORY)" \
		

clean:
	$(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="clean" \
		--working-directory="$(WORKING_DIRECTORY)" \
		

test-vagrant:
	$(SHELL_SCRIPT_FOLDER)/build-images.sh \
		--action="test-vagrant" \
		--working-directory="$(WORKING_DIRECTORY)" \
		

