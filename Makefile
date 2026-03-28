ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Giữ nguyên để khớp với thư viện iOS 18 của mày
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
# Thêm -lgcc để sửa lỗi ___clear_cache
VanVinhPro_LDFLAGS = -force_load libKeyAuth.a -lgcc
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration CoreTelephony AdSupport
VanVinhPro_CFLAGS = -fobjc-arc -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
