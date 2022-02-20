################################################################################
#
# python-opencv-python
#
################################################################################

PYTHON_OPENCV_PYTHON_VERSION = 4.5.4.58
PYTHON_OPENCV_PYTHON_SOURCE = opencv-python-$(PYTHON_OPENCV_PYTHON_VERSION).tar.gz
PYTHON_OPENCV_PYTHON_SITE = https://files.pythonhosted.org/packages/b6/82/0519fdbbcaddc0fa8c2568327a8311477315a91b4513738ee1d35f0ce715
PYTHON_OPENCV_PYTHON_SETUP_TYPE = setuptools
PYTHON_OPENCV_PYTHON_LICENSE = MIT
PYTHON_OPENCV_PYTHON_LICENSE_FILES = LICENSE.txt opencv/LICENSE opencv/3rdparty/quirc/LICENSE opencv/3rdparty/ffmpeg/license.txt opencv/3rdparty/include/opencl/LICENSE.txt opencv/3rdparty/libpng/LICENSE opencv/3rdparty/openexr/LICENSE opencv/3rdparty/libwebp/COPYING opencv/3rdparty/protobuf/LICENSE opencv/3rdparty/libjasper/LICENSE opencv/3rdparty/openjpeg/LICENSE opencv/3rdparty/cpufeatures/LICENSE opencv/modules/core/3rdparty/SoftFloat/COPYING.txt

$(eval $(python-package))
