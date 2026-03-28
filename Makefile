ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Tắt tự động ký tên
NO_CODESIGN = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# File nguồn
VanVinhPro_FILES = main.mm

# CÁC FRAMEWORK HỆ THỐNG (DÀN HÀNG NGANG ĐỂ FIX LỖI GIAO DIỆN)
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore CoreText WebKit CoreFoundation

# CẤU HÌNH LIÊN KẾT (THÊM -ObjC ĐỂ ÉP NẠP CATEGORY TRONG LIB TĨNH)
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -ObjC

# CỜ BIÊN DỊCH
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
