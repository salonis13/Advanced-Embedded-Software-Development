################################################################################
#
# python-qtpy
#
################################################################################

PYTHON_QTPY_VERSION = 1.11.2
PYTHON_QTPY_SOURCE = QtPy-$(PYTHON_QTPY_VERSION).tar.gz
PYTHON_QTPY_SITE = https://files.pythonhosted.org/packages/a5/aa/661c4ce9bed57ea80e1692ff66bfa27d116cbbf7952362c45ceb0282a7a2
PYTHON_QTPY_SETUP_TYPE = setuptools
PYTHON_QTPY_LICENSE = MIT
PYTHON_QTPY_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
