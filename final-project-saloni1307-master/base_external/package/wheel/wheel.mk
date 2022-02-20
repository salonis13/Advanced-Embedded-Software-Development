   ################################################################################
#
# wheel
#
################################################################################

WHEEL_VERSION = 0.37.0
WHEEL_SOURCE = wheel-0.37.0.tar.gz
WHEEL_SITE = https://files.pythonhosted.org/packages/4e/be/8139f127b4db2f79c8b117c80af56a3078cc4824b5b94250c7f81a70e03b
WHEEL_LICENSE = Apache License
WHEEL_LICENSE_FILES = LICENSE
WHEEL_DEPENDENCIES:=
WHEEL_SETUP_TYPE:= distutils

$(eval $(python-package))