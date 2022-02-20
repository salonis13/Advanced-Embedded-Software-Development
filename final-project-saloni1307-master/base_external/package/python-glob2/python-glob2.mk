################################################################################
#
# python-glob2
#
################################################################################

PYTHON_GLOB2_VERSION = 0.7
PYTHON_GLOB2_SOURCE = glob2-$(PYTHON_GLOB2_VERSION).tar.gz
PYTHON_GLOB2_SITE = https://files.pythonhosted.org/packages/d7/a5/bbbc3b74a94fbdbd7915e7ad030f16539bfdc1362f7e9003b594f0537950
PYTHON_GLOB2_SETUP_TYPE = setuptools
PYTHON_GLOB2_LICENSE = BSD-2-Clause
PYTHON_GLOB2_LICENSE_FILES = LICENSE

$(eval $(python-package))
