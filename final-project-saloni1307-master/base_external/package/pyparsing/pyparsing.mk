   ################################################################################
#
# pyparsing
#
################################################################################

PYPARSING_VERSION = 3.0.6
PYPARSING_SOURCE = pyparsing-3.0.6.tar.gz
PYPARSING_SITE = https://files.pythonhosted.org/packages/ab/61/1a1613e3dcca483a7aa9d446cb4614e6425eb853b90db131c305bd9674cb
PYPARSING_LICENSE = Apache License
PYPARSING_LICENSE_FILES = LICENSE
PYPARSING_DEPENDENCIES:=
PYPARSING_SETUP_TYPE:= distutils

$(eval $(python-package))