ARCHS = arm64
TARGET = iphone:clang:latest:14.0

NO_CODESIGN = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# File nguồn
VanVinhPro_FILES = main.mm

# FRAMEWORKS HỆ THỐNG - ÉP ĐỦ BỘ ĐỂ VẼ GIAO DIỆN
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore CoreText WebKit CoreFoundation

# LDFLAGS CỰC MẠNH: 
# -all_load: Ép nạp mọi thứ từ libKeyAuth.a, không cho phép sót symbol nào.
# -ObjC: Để nạp các class/category vẽ giao diện Liquid.
VanVinhPro_LDFLAGS = -all_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -ObjC

VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
