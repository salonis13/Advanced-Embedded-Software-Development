   ################################################################################
#
# scikit-build
#
################################################################################

SCIKIT_BUILD_VERSION = 0.12.0
SCIKIT_BUILD_SOURCE = scikit-build-0.12.0.tar.gz
SCIKIT_BUILD_SITE = https://files.pythonhosted.org/packages/ab/8d/fc770eb732553ae0af68d276865524cc17efd667f9e71da6c5a2ac876817
SCIKIT_BUILD_LICENSE = Apache License
SCIKIT_BUILD_LICENSE_FILES = LICENSE
SCIKIT_BUILD_DEPENDENCIES:= packaging wheel distro pyparsing
SCIKIT_BUILD_SETUP_TYPE:= distutils

$(eval $(python-package))