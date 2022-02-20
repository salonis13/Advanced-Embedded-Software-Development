################################################################################
#
# python-obd
#
################################################################################

PYTHON_OBD_VERSION = 0.7.1
PYTHON_OBD_SOURCE = obd-$(PYTHON_OBD_VERSION).tar.gz
PYTHON_OBD_SITE = https://files.pythonhosted.org/packages/fc/7b/13ffeaefa5b2623263ba26d60ed12229cb1c9ceabdb50c880de9d77d2613
PYTHON_OBD_SETUP_TYPE = setuptools
PYTHON_OBD_LICENSE = GNU General Public License v2 (GPLv2)

$(eval $(python-package))
