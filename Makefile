ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Tắt tự động ký tên
NO_CODESIGN = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

# File nguồn
VanVinhPro_FILES = main.mm

# CÁC FRAMEWORK HỆ THỐNG (THÊM ĐỦ BỘ ĐỂ FIX LỖI GIAO DIỆN)
# Thêm QuartzCore, CoreText và WebKit để fix lỗi showKeyInfoLiquid
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore CoreText WebKit

# CẤU HÌNH LIÊN KẾT (CỰC KỲ QUAN TRỌNG)
# -force_load: Ép nạp thư viện
# -lsqlite3 -lz -lstdc++: Các thư viện nền tảng
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++

# CỜ BIÊN DỊCH
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
