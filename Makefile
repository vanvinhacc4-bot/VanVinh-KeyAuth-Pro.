# Tên project của mày
TWEAK_NAME = VanVinhPro

# Thêm đầy đủ các thư viện đệm này vào để dylib không bị "hụt" hàm
VanVinhPro_FILES = main.mm
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -lc++ -Wl,-segalign,4000
VanVinhPro_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics

# Đảm bảo build cho kiến trúc arm64 (iOS đời mới)
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS_MAKE_PATH)/tweak.mk
