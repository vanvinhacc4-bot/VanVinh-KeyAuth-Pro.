ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Ép hẳn lên phiên bản cao nhất có thể trong SDK
TARGET = iphone:clang:latest:16.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
VanVinhPro_LDFLAGS = libKeyAuth.a
# Thêm dòng này để nó lờ đi mấy cái cảnh báo phiên bản cũ/mới
VanVinhPro_CFLAGS = -Wno-error
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration

include $(THEOS_MAKE_PATH)/tweak.mk
