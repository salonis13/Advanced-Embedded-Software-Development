   ################################################################################
#
# distro
#
################################################################################

DISTRO_VERSION = 1.6.0
DISTRO_SOURCE = distro-1.6.0.tar.gz
DISTRO_SITE = https://files.pythonhosted.org/packages/a5/26/256fa167fe1bf8b97130b4609464be20331af8a3af190fb636a8a7efd7a2
DISTRO_LICENSE = Apache License
DISTRO_LICENSE_FILES = LICENSE
DISTRO_DEPENDENCIES:= 
DISTRO_SETUP_TYPE:= distutils

$(eval $(python-package))