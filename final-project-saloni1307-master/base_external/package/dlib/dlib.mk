################################################################################
#
# dlib
#
################################################################################

DLIB_VERSION = v19.17
DLIB_SITE = $(call github,davisking,dlib,$(DLIB_VERSION))
DLIB_INSTALL_STAGING = YES
DLIB_LICENSE = BSL-1.0
DLIB_LICENSE_FILES = dlib/LICENSE.txt

DLIB_DEPENDENCIES += host-pkgconf jpeg libpng

# Disable cuda support.
# Don't use bundled version of libpng and jpeg
DLIB_CONF_OPTS = -DDLIB_USE_CUDA=OFF \
	-DDLIB_JPEG_SUPPORT=ON \
	-DDLIB_PNG_SUPPORT=ON \

# Set AVX_IS_AVAILABLE_ON_HOST to avoid using try_run while crosscompiling.
ifeq ($(BR2_X86_CPU_HAS_AVX),y)
DLIB_CONF_OPTS += -DUSE_AVX_INSTRUCTIONS=ON \
	-DAVX_IS_AVAILABLE_ON_HOST=ON
else
DLIB_CONF_OPTS += -DUSE_AVX_INSTRUCTIONS=OFF \
	-DAVX_IS_AVAILABLE_ON_HOST=OFF
endif

# Set SSE4_IS_AVAILABLE_ON_HOST to avoid using try_run while crosscompiling.
ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
DLIB_CONF_OPTS += -DUSE_SSE4_INSTRUCTIONS=ON \
	-DSSE4_IS_AVAILABLE_ON_HOST=ON
else
DLIB_CONF_OPTS += -DUSE_SSE4_INSTRUCTIONS=OFF \
	-DSSE4_IS_AVAILABLE_ON_HOST=OFF
endif

ifeq ($(BR2_ARM_ENABLE_NEON),y)
DLIB_CONF_OPTS += -DUSE_NEON_INSTRUCTIONS=ON \
	-DARM_NEON_IS_AVAILABLE=ON
else
DLIB_CONF_OPTS += -DUSE_NEON_INSTRUCTIONS=OFF \
	-DARM_NEON_IS_AVAILABLE=OFF
endif

ifeq ($(BR2_PACKAGE_DLIB_GUI_SUPPORT),y)
DLIB_DEPENDENCIES += xlib_libX11 xlib_libXext
DLIB_CONF_OPTS += -DDLIB_NO_GUI_SUPPORT=OFF
else
DLIB_CONF_OPTS += -DDLIB_NO_GUI_SUPPORT=ON
endif

ifeq ($(BR2_PACKAGE_GIFLIB),y)
DLIB_DEPENDENCIES += giflib
DLIB_CONF_OPTS += -DDLIB_GIF_SUPPORT=ON
else
DLIB_CONF_OPTS += -DDLIB_GIF_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
DLIB_DEPENDENCIES += sqlite
DLIB_CONF_OPTS += -DDLIB_LINK_WITH_SQLITE3=ON
else
DLIB_CONF_OPTS += -DDLIB_LINK_WITH_SQLITE3=OFF
endif

ifeq ($(BR2_PACKAGE_DLIB_PYTHON_MODULE),y)

DLIB_DEPENDENCIES += $(if $(BR2_PACKAGE_PYTHON3),python3,python) \
	$(if $(BR2_PACKAGE_PYTHON3),host-python3-setuptools,host-python-setuptools)

# python-dlib call cmake to build the python module library, so we have
# to provide at least CMAKE_TOOLCHAIN_FILE to crosscompile.
DLIB_PYTHON_BUILD_OPTS += \
	--set CMAKE_TOOLCHAIN_FILE="$(HOST_DIR)/share/buildroot/toolchainfile.cmake" \
	--set CMAKE_INSTALL_PREFIX="/usr" \
	--set CMAKE_COLOR_MAKEFILE=OFF \
	$(subst -D,--set ,$(DLIB_CONF_OPTS))

define DLIB_PYTHON_BUILD
	cd $(@D) && $(PKG_PYTHON_SETUPTOOLS_ENV) $(HOST_DIR)/bin/python \
		setup.py build $(DLIB_PYTHON_BUILD_OPTS)
endef
DLIB_POST_BUILD_HOOKS += DLIB_PYTHON_BUILD

define DLIB_PYTHON_INSTALL_STAGING
	cd $(@D) && $(PKG_PYTHON_SETUPTOOLS_ENV) $(HOST_DIR)/bin/python \
		setup.py install $(PKG_PYTHON_SETUPTOOLS_INSTALL_STAGING_OPTS)
endef
DLIB_POST_INSTALL_STAGING_HOOKS += DLIB_PYTHON_INSTALL_STAGING

define DLIB_PYTHON_INSTALL_TARGET
	cd $(@D) && $(PKG_PYTHON_SETUPTOOLS_ENV) $(HOST_DIR)/bin/python \
		setup.py install --no-compile $(PKG_PYTHON_SETUPTOOLS_INSTALL_TARGET_OPTS)
endef
DLIB_POST_INSTALL_TARGET_HOOKS += DLIB_PYTHON_INSTALL_TARGET

endif

$(eval $(cmake-package))