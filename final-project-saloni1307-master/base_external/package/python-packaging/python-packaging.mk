################################################################################
#
# python-packaging
#
################################################################################

PYTHON_PACKAGING_VERSION = 21.3
PYTHON_PACKAGING_SOURCE = packaging-$(PYTHON_PACKAGING_VERSION).tar.gz
PYTHON_PACKAGING_SITE = https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c
PYTHON_PACKAGING_SETUP_TYPE = setuptools
PYTHON_PACKAGING_LICENSE = FIXME: license id couldn't be detected
PYTHON_PACKAGING_LICENSE_FILES = LICENSE

$(eval $(python-package))
