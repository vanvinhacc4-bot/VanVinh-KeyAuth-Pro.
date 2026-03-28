# Thiết lập kiến trúc và target
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Đường dẫn Theos (Quan trọng cho GitHub Actions)
THEOS_DEVICE_IP = localhost
THEOS_MAKE_PATH ?= $(THEOS)/makefiles

# Tên project và file nguồn
TWEAK_NAME = VanVinhPro
VanVinhPro_FILES = main.mm

# Liên kết thư viện và frameworks
# Đảm bảo file libKeyAuth.a nằm cùng thư mục với Makefile
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -lc++ -Wl,-segalign,4000
VanVinhPro_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics

# Bao gồm các tệp cấu trúc của Theos
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
