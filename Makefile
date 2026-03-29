export TARGET = iphone:clang:latest:12.0
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# Gộp chung não và quần áo để Build
VanVinhPro_FILES = main.mm themeAPI.mm

# Bắt buộc phải có -fobjc-arc
VanVinhPro_CFLAGS = -fobjc-arc -I.

# ĐÂY LÀ CÂU THẦN CHÚ CỨU MẠNG (ÉP MÁY BỎ QUA LỖI THIẾU CLASS)
VanVinhPro_LDFLAGS = -undefined dynamic_lookup

VanVinhPro_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
