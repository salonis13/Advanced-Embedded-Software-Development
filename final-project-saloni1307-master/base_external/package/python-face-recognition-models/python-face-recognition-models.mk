################################################################################
#
# python-face-recognition-models
#
################################################################################

PYTHON_FACE_RECOGNITION_MODELS_VERSION = 0.3.0
PYTHON_FACE_RECOGNITION_MODELS_SOURCE = face_recognition_models-$(PYTHON_FACE_RECOGNITION_MODELS_VERSION).tar.gz
PYTHON_FACE_RECOGNITION_MODELS_SITE = https://files.pythonhosted.org/packages/cf/3b/4fd8c534f6c0d1b80ce0973d01331525538045084c73c153ee6df20224cf
PYTHON_FACE_RECOGNITION_MODELS_SETUP_TYPE = setuptools
PYTHON_FACE_RECOGNITION_MODELS_LICENSE = MIT
PYTHON_FACE_RECOGNITION_MODELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
