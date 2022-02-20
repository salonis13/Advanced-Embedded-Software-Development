################################################################################
#
# python-queuelib
#
################################################################################

PYTHON_QUEUELIB_VERSION = 1.6.2
PYTHON_QUEUELIB_SOURCE = queuelib-$(PYTHON_QUEUELIB_VERSION).tar.gz
PYTHON_QUEUELIB_SITE = https://files.pythonhosted.org/packages/4d/11/94d3a5c1a03fa984b3f793ceecfac4b685ca9fc7a3af03f806dbb973555b
PYTHON_QUEUELIB_SETUP_TYPE = setuptools
PYTHON_QUEUELIB_LICENSE = BSD-3-Clause
PYTHON_QUEUELIB_LICENSE_FILES = LICENSE

$(eval $(python-package))
