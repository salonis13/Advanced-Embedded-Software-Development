################################################################################
#
# python-pyqtgraph
#
################################################################################

PYTHON_PYQTGRAPH_VERSION = 0.12.3
PYTHON_PYQTGRAPH_SOURCE = pyqtgraph-$(PYTHON_PYQTGRAPH_VERSION).tar.gz
PYTHON_PYQTGRAPH_SITE = https://files.pythonhosted.org/packages/36/8f/4893227da3d4825a48cc1ec67acfc19ad26444f78527b61d6ed22c926d10
PYTHON_PYQTGRAPH_SETUP_TYPE = setuptools
PYTHON_PYQTGRAPH_LICENSE = MIT, BSD-3-Clause
PYTHON_PYQTGRAPH_LICENSE_FILES = LICENSE.txt pyqtgraph/util/colorama/LICENSE.txt pyqtgraph/metaarray/license.txt

$(eval $(python-package))
