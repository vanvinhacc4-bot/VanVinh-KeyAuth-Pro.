ARCHS = arm64
TARGET = iphone:clang:latest:14.0

NO_CODESIGN = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# File nguồn (Dùng main.mm là chuẩn cho Obj-C++)
VanVinhPro_FILES = main.mm

# FRAMEWORKS HỆ THỐNG - ÉP NẠP ĐỦ BỘ ĐỂ VẼ GIAO DIỆN LIQUID
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore CoreText WebKit CoreFoundation

# LDFLAGS CỰC MẠNH: 
# -lc++ và -lstdc++: Để fix lỗi thiếu symbol của thư viện C++
# -ObjC: Để nạp các Category vẽ giao diện
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -Wl,-undefined,dynamic_lookup

# CỜ BIÊN DỊCH
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
