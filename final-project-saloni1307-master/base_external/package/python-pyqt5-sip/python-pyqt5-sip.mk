################################################################################
#
# python-pyqt5-sip
#
################################################################################

PYTHON_PYQT5_SIP_VERSION = 12.9.0
PYTHON_PYQT5_SIP_SOURCE = PyQt5_sip-$(PYTHON_PYQT5_SIP_VERSION).tar.gz
PYTHON_PYQT5_SIP_SITE = https://files.pythonhosted.org/packages/b1/40/dd8f081f04a12912b65417979bf2097def0af0f20c89083ada3670562ac5
PYTHON_PYQT5_SIP_SETUP_TYPE = setuptools

$(eval $(python-package))
