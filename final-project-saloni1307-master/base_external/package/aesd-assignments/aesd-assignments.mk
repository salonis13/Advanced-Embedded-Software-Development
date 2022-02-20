##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 0a0110875adeeaada1b811b65c4f118ec8302e41
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/final-project-Mich2899.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/ $(TARGET_DIR)/etc/project
	$(INSTALL) -m 0755 $(@D)/car.py $(TARGET_DIR)/etc/project/
	$(INSTALL) -m 0755 $(@D)/interface_test1.py $(TARGET_DIR)/etc/project
	$(INSTALL) -m 0755 $(@D)/sendSMS.py $(TARGET_DIR)/etc/project
	$(INSTALL) -m 0755 $(@D)/setdate.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/setdate-start-stop $(TARGET_DIR)/etc/init.d/S97setdate

endef

$(eval $(generic-package))
