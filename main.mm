#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// Ép trình biên dịch giữ nguyên tên biến, không được thay đổi (No Mangle)
extern "C" {
    __attribute__((visibility("default"))) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VINH_MODS";

    __attribute__((visibility("default"))) const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
    __attribute__((visibility("default"))) const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

    __attribute__((visibility("default"))) const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
    __attribute__((visibility("default"))) const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

    // Biến đang gây lỗi đây: thêm used để đảm bảo nó tồn tại trong file dylib xuất ra
    __attribute__((visibility("default"))) __attribute__((used)) const uint32_t KEYAUTH_MAX_DYLIBS = 1;

    __attribute__((visibility("default"))) void __clear_cache(void *begin, void *end) {}
}

__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (NSClassFromString(@"KeyAuthSystem")) {
            [[KeyAuthSystem shared] start];
        }
    });
}
