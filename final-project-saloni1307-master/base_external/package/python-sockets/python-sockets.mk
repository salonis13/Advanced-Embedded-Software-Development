################################################################################
#
# python-sockets
#
################################################################################

PYTHON_SOCKETS_VERSION = 1.0.0
PYTHON_SOCKETS_SOURCE = sockets-$(PYTHON_SOCKETS_VERSION).tar.gz
PYTHON_SOCKETS_SITE = https://files.pythonhosted.org/packages/c2/a7/6bc7eeefb624e03e5a34c2c0d8eff6525487b1af0ccfd62d0f83a62a5400
PYTHON_SOCKETS_SETUP_TYPE = setuptools

$(eval $(python-package))
