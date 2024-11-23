ifeq ($(ROOTLESS),1)
THEOS_DEVICE_IP = 192.168.1.8
THEOS_DEVICE_PORT = 22
THEOS_PACKAGE_SCHEME = rootless
else ifeq ($(ROOTHIDE),1)
THEOS_PACKAGE_SCHEME = roothide
else
THEOS_DEVICE_IP = 192.168.1.9
THEOS_DEVICE_PORT = 22
endif

DEBUG = 0
FINALPACKAGE = 1
ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CC18
$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
