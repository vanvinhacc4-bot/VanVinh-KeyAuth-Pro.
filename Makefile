# Ép nó nhận diện iOS thấp để không văng
export TARGET = iphone:clang:latest:12.0
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# Đảm bảo file main.mm và các file API nằm đúng chỗ
VanVinhPro_FILES = main.mm themeAPI.mm $(wildcard API/*.mm)
VanVinhPro_CFLAGS = -fobjc-arc -I. -IAPI

# Cần thiết để hiện Menu UI
VanVinhPro_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
