################################################################################
#
# python-scikit-build
#
################################################################################

PYTHON_SCIKIT_BUILD_VERSION = 0.12.0
PYTHON_SCIKIT_BUILD_SOURCE = scikit-build-$(PYTHON_SCIKIT_BUILD_VERSION).tar.gz
PYTHON_SCIKIT_BUILD_SITE = https://files.pythonhosted.org/packages/ab/8d/fc770eb732553ae0af68d276865524cc17efd667f9e71da6c5a2ac876817
PYTHON_SCIKIT_BUILD_SETUP_TYPE = setuptools
PYTHON_SCIKIT_BUILD_LICENSE = MIT
PYTHON_SCIKIT_BUILD_LICENSE_FILES = LICENSE

$(eval $(python-package))
