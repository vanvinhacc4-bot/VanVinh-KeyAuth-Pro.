ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Giữ nguyên cái này để khớp với thư viện iOS 18 của mày
TARGET = iphone:clang:latest:16.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
VanVinhPro_LDFLAGS = libKeyAuth.a
# THÊM CoreTelephony VÀ AdSupport VÀO ĐÂY
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration CoreTelephony AdSupport
VanVinhPro_CFLAGS = -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
