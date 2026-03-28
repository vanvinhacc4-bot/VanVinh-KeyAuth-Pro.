# CHỈ ĐỂ arm64, XÓA HẲN arm64e ĐI
ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Dùng target này cho ổn định
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
# Ép nó load thư viện và sửa lỗi cache (nếu đã thêm code vào main.mm)
VanVinhPro_LDFLAGS = -force_load libKeyAuth.a
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration CoreTelephony AdSupport
VanVinhPro_CFLAGS = -fobjc-arc -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
