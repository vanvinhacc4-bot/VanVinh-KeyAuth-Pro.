# Thiết lập kiến trúc và phiên bản iOS mục tiêu
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Tắt tính năng tự động ký tên để tránh lỗi ldid trên GitHub Actions
NO_CODESIGN = 1

# Nhập thư viện nền tảng của Theos
include $(THEOS)/makefiles/common.mk

# Tên Project (Phải khớp với tên trong file control)
TWEAK_NAME = VanVinhPro

# Các file nguồn cần biên dịch
VanVinhPro_FILES = main.mm

# CÁC FRAMEWORK HỆ THỐNG (Dòng này cực kỳ quan trọng để fix lỗi giao diện)
# Thêm QuartzCore để fix lỗi "showKeyInfoLiquid" ở dòng 30 của mày
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration QuartzCore

# ĐƯỜNG DẪN THƯ VIỆN VÀ CẤU HÌNH LIÊN KẾT (FIX LỖI LINKER)
# -force_load: Ép nạp toàn bộ libKeyAuth.a
# -lsqlite3 -lz -lstdc++: Các thư viện nền tảng bắt buộc
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++

# Cờ biên dịch: Tắt các cảnh báo dư thừa và ép kiểu ARC
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

# Lệnh build Tweak
include $(THEOS_MAKE_PATH)/tweak.mk

# Lệnh sau khi cài đặt (dùng cho máy jailbreak)
after-install::
	install.exec "killall -9 SpringBoard"
