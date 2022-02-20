
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 1c54b5fccfe05b5baa9405b0702cfc00f7ea5c2c
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/final-project-saloni1307.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/python_socket/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
