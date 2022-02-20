################################################################################
#
# python-face-recognition
#
################################################################################

PYTHON_FACE_RECOGNITION_VERSION = 1.3.0
PYTHON_FACE_RECOGNITION_SOURCE = face_recognition-$(PYTHON_FACE_RECOGNITION_VERSION).tar.gz
PYTHON_FACE_RECOGNITION_SITE = https://files.pythonhosted.org/packages/6c/49/75dda409b94841f01cbbc34114c9b67ec618265084e4d12d37ab838f4fd3
PYTHON_FACE_RECOGNITION_SETUP_TYPE = setuptools
PYTHON_FACE_RECOGNITION_LICENSE = MIT
PYTHON_FACE_RECOGNITION_LICENSE_FILES = LICENSE

$(eval $(python-package))
