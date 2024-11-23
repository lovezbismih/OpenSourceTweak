TARGET := iphone:clang:13.7
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BHInsta

BHInsta_FILES = Tweak.x $(wildcard *.m JGProgressHUD/*.m)
BHInsta_FRAMEWORKS = UIKit Foundation CoreGraphics Photos CoreServices SystemConfiguration SafariServices Security QuartzCore
BHInsta_PRIVATE_FRAMEWORKS = Preferences
BHInsta_EXTRA_FRAMEWORKS = Cephei CepheiPrefs CepheiUI
BHInsta_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-unused-value -Wno-deprecated-declarations -Wno-nullability-completeness -Wno-unused-function -Wno-incompatible-pointer-types

include $(THEOS_MAKE_PATH)/tweak.mk
