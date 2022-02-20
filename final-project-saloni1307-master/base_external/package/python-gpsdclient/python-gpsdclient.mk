################################################################################
#
# python-gpsdclient
#
################################################################################

PYTHON_GPSDCLIENT_VERSION = 1.2.0
PYTHON_GPSDCLIENT_SOURCE = gpsdclient-$(PYTHON_GPSDCLIENT_VERSION).tar.gz
PYTHON_GPSDCLIENT_SITE = https://files.pythonhosted.org/packages/fe/96/facace3ce8f0d93e6f6c5a982328b31bb8c462db081f579e00ab24afb8b5
PYTHON_GPSDCLIENT_SETUP_TYPE = setuptools
PYTHON_GPSDCLIENT_LICENSE = MIT
PYTHON_GPSDCLIENT_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
