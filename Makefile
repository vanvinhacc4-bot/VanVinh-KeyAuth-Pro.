# Dùng lệnh export để ép toàn bộ hệ thống chỉ dùng arm64
export ARCHS = arm64
export TARGET = iphone:clang:latest:14.0

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
# -force_load để đảm bảo nó lấy đủ Class từ thư viện tĩnh
VanVinhPro_LDFLAGS = -force_load libKeyAuth.a
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration CoreTelephony AdSupport
VanVinhPro_CFLAGS = -fobjc-arc -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
