# Thiết lập kiến trúc
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Đường dẫn Theos cho GitHub Actions
THEOS_DEVICE_IP = localhost
THEOS_MAKE_PATH ?= $(THEOS)/makefiles

# Tên project
TWEAK_NAME = VanVinhPro
VanVinhPro_FILES = main.mm

# LIÊN KẾT THƯ VIỆN - THÊM SystemConfiguration VÀO ĐÂY
VanVinhPro_LDFLAGS = -force_load ./libKeyAuth.a -lsqlite3 -lz -lstdc++ -lc++ -Wl,-segalign,4000 -undefined dynamic_lookup
VanVinhPro_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics SystemConfiguration CoreTelephony AdSupport

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
