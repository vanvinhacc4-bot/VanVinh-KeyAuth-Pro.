# Thiết lập kiến trúc và phiên bản iOS mục tiêu
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Tắt tính năng tự động ký tên để tránh lỗi ldid trên GitHub Actions
NO_CODESIGN = 1

# Nhập thư viện Theos
include $(THEOS)/makefiles/common.mk

# Tên Tweak (Mày có thể đổi VanVinhPro thành tên tùy ý)
TWEAK_NAME = VanVinhPro

# Các file nguồn cần biên dịch (Phải có main.mm)
VanVinhPro_FILES = main.mm

# Các Framework hệ thống cần thiết cho KeyAuth và giao diện
VanVinhPro_FRAMEWORKS = UIKit Foundation Security CoreGraphics CoreTelephony AdSupport SystemConfiguration

# ĐƯỜNG DẪN THƯ VIỆN VÀ CẤU HÌNH LIÊN KẾT (QUAN TRỌNG NHẤT)
# -force_load: Ép nạp toàn bộ thư viện tĩnh để không bị lỗi "Symbol not found"
# -lsqlite3 -lz -lstdc++: Các thư viện nền tảng mà KeyAuth yêu cầu
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++

# Cờ biên dịch để nhận diện Objective-C++
VanVinhPro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-error

# Lệnh build Tweak
include $(THEOS_MAKE_PATH)/tweak.mk

# Lệnh sau khi build xong (dọn dẹp file thừa)
after-install::
	install.exec "killall -9 SpringBoard"
