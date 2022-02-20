################################################################################
#
# python-pyqt-builder
#
################################################################################

PYTHON_PYQT_BUILDER_VERSION = 1.12.2
PYTHON_PYQT_BUILDER_SOURCE = PyQt-builder-$(PYTHON_PYQT_BUILDER_VERSION).tar.gz
PYTHON_PYQT_BUILDER_SITE = https://files.pythonhosted.org/packages/8b/5f/1bd49787262ddce37b826ef49dcccf5a9970facf0ed363dee5ee233e681d
PYTHON_PYQT_BUILDER_SETUP_TYPE = setuptools
PYTHON_PYQT_BUILDER_LICENSE = FIXME: license id couldn't be detected, GPL-3.0
PYTHON_PYQT_BUILDER_LICENSE_FILES = LICENSE pyqtbuild/bundle/qt_wheel_distinfo/LICENSE

$(eval $(python-package))
