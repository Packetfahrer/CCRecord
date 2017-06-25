GO_EASY_ON_ME = 1
DEBUG = 0
TARGET = iphone:latest
ARCHS = armv7 arm64

export THEOS_DEVICE_IP = ipad


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCRecord
CCRecord_FILES = Tweak.xm
CCRecord_FRAMEWORKS = UIKit
CCRecord_LIBRARIES = MobileGestalt


PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
_THEOS_INTERNAL_PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += CCRFS

include $(THEOS_MAKE_PATH)/aggregate.mk