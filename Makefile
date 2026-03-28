ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# Khai báo các file để build
VanVinhPro_FILES = main.mm
VanVinhPro_LDFLAGS = libKeyAuth.a
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration

include $(THEOS_MAKE_PATH)/tweak.mk
