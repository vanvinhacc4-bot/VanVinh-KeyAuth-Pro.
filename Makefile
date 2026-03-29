export TARGET = iphone:clang:latest:14.0
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm themeAPI.mm
# ĐÂY LÀ LỆNH ÉP CỤC LÕI KEYAUTH VÀO MENU ĐỂ KHÔNG BỊ VĂNG
VanVinhPro_OBJ_FILES = libKeyAuth.a

VanVinhPro_CFLAGS = -fobjc-arc -I.
VanVinhPro_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
