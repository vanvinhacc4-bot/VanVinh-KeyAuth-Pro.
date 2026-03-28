# Kiến trúc và mục tiêu iOS
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Tắt ký tên tự động
NO_CODESIGN = 1

# Nhập thư viện Theos
include $(THEOS)/makefiles/common.mk

# Tên Project (Mày có thể đổi nếu thích)
TWEAK_NAME = VanVinhPro

# File nguồn
VanVinhPro_FILES = main.mm

# FRAMEWORKS HỆ THỐNG (Bổ sung QuartzCore và WebKit để fix lỗi giao diện ở dòng 30)
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore WebKit

# CẤU HÌNH LIÊN KẾT (Ép nạp thư viện và các link phụ)
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++

# CỜ BIÊN DỊCH (Tắt lỗi cảnh báo để build trơn tru)
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

# Lệnh build
include $(THEOS_MAKE_PATH)/tweak.mk

# Sau khi build
after-install::
	install.exec "killall -9 SpringBoard"
