ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TransparentDock

TransparentDock_FILES = $(shell find Sources/TransparentDock -name '*.swift') $(shell find Sources/TransparentDockC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
TransparentDock_SWIFTFLAGS = -ISources/TransparentDockC/include
TransparentDock_CFLAGS = -fobjc-arc -ISources/TransparentDockC/include

include $(THEOS_MAKE_PATH)/tweak.mk
