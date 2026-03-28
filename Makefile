ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Ép target để nó tự tìm thư viện chuẩn của iOS
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VanVinhPro

VanVinhPro_FILES = main.mm
# Thay -lgcc bằng cách link trực tiếp thư viện compiler-rt nếu cần
# Nhưng trước hết, thử dùng flag này để nó tự xử lý bộ nhớ đệm
VanVinhPro_LDFLAGS = -force_load libKeyAuth.a
VanVinhPro_FRAMEWORKS = UIKit Foundation Security SystemConfiguration CoreTelephony AdSupport
# Thêm flag này để giúp compiler nhận diện các hàm hệ thống tốt hơn
VanVinhPro_CFLAGS = -fobjc-arc -Wno-error -O2

include $(THEOS_MAKE_PATH)/tweak.mk
