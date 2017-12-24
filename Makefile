
# DEFAULT VARIABLES.
COREOS_RELEASE ?= alpha
PACKAGE_FILE ?= ./package-coreos-$(COREOS_RELEASE).json

IGNITION_NAME ?= coreos-vagrant-ignition.yml
IGNITION_PATH ?= ./support-files/container-linux-config/source
IGNITION_FILE ?= $(IGNITION_PATH)/$(IGNITION_NAME)

BUILD_IMAGES_CMD ?= ./support-files/shell-script/build-images.sh
WORKING_DIRECTORY ?= `pwd`

compile:
	bash $(BUILD_IMAGES_CMD) --action="compile" \
							 --package-file="$(PACKAGE_FILE)" \
							 --ignition-file="$(IGNITION_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";
	

build:
	bash $(BUILD_IMAGES_CMD) --action="compile" \
							 --package-file="$(PACKAGE_FILE)" \
							 --ignition-file="$(IGNITION_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";

	bash $(BUILD_IMAGES_CMD) --action="build" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";


build-force:
	bash $(BUILD_IMAGES_CMD) --action="clean" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";

	bash $(BUILD_IMAGES_CMD) --action="compile" \
							 --package-file="$(PACKAGE_FILE)" \
							 --ignition-file="$(IGNITION_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";

	bash $(BUILD_IMAGES_CMD) --action="build" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";

		
install: 
	bash $(BUILD_IMAGES_CMD) --action="install" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";


clean:
	bash $(BUILD_IMAGES_CMD) --action="clean" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";
		

test-vagrant:
	bash $(BUILD_IMAGES_CMD) --action="test-vagrant" \
							 --package-file="$(PACKAGE_FILE)" \
							 --working-directory="$(WORKING_DIRECTORY)";

