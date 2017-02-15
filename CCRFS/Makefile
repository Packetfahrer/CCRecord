GO_EASY_ON_ME = 1
DEBUG = 0
TARGET = iphone:latest:9.3
PACKAGE_VERSION = 0.0.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ScreenRecordSwitch
ScreenRecordSwitch_FILES = Switch.xm
ScreenRecordSwitch_LIBRARIES = flipswitch substrate
ScreenRecordSwitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk