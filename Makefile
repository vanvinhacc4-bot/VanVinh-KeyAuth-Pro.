ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro
VanVinhPro_FILES = main.mm
# Tắt mọi cảnh báo gây lỗi build
VanVinhPro_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-unused-const-variable -Wno-error
# Ép load thư viện và giữ nguyên các hàm hệ thống
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -lc++ -undefined dynamic_lookup
VanVinhPro_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics SystemConfiguration CoreTelephony AdSupport

include $(THEOS_MAKE_PATH)/tweak.mk
