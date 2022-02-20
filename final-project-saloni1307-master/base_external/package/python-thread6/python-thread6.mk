################################################################################
#
# python-thread6
#
################################################################################

PYTHON_THREAD6_VERSION = 0.2.0
PYTHON_THREAD6_SOURCE = thread6-$(PYTHON_THREAD6_VERSION).tar.gz
PYTHON_THREAD6_SITE = https://files.pythonhosted.org/packages/39/f2/cd7b53367c00a0e4a37c53c5b18007a50fb66f19331699c894c918230b8b
PYTHON_THREAD6_SETUP_TYPE = setuptools

$(eval $(python-package))
