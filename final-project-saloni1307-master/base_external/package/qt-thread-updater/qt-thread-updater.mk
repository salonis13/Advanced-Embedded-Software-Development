   ################################################################################
#
# QT_THREAD_UPDATER
#
################################################################################

QT_THREAD_UPDATER_VERSION = 1.1.6
QT_THREAD_UPDATER_SOURCE = qt_thread_updater-1.1.6.tar.gz
QT_THREAD_UPDATER_SITE = https://files.pythonhosted.org/packages/82/3c/da9c327ef5eb17f21fb463e46672bbb8c86ceaf3447b584dbaf565a13fdb
QT_THREAD_UPDATER_LICENSE = Apache License
QT_THREAD_UPDATER_LICENSE_FILES = LICENSE
QT_THREAD_UPDATER_DEPENDENCIES:=
QT_THREAD_UPDATER_SETUP_TYPE:= distutils

$(eval $(python-package))