ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Ép phiên bản iOS mục tiêu lên cao để khớp với thư viện của mày
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
VanVinhPro_LDFLAGS = libKeyAuth.a
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration

include $(THEOS_MAKE_PATH)/tweak.mk
