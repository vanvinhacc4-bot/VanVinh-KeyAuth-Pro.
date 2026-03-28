#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// Ép cấu hình vào bộ nhớ tĩnh
extern "C" {
    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VINH_MODS";

    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; // "1.0"
    
    __attribute__((visibility("default"))) __attribute__((used)) 
    const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; // "fjFllxcSj2"
    
    __attribute__((visibility("default"))) __attribute__((used)) 
    const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint32_t KEYAUTH_MAX_DYLIBS = 1;

    void __clear_cache(void *begin, void *end) {}
}

// Hàm khởi tạo dylib
__attribute__((constructor)) static void init() {
    // Không dùng Observer nữa, dùng delay thuần túy
    // Tăng lên 15 giây cho chắc chắn game vào đến sảnh
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @try {
            // Kiểm tra xem class có tồn tại không trước khi gọi để tránh crash
            if (NSClassFromString(@"KeyAuthSystem")) {
                [[KeyAuthSystem shared] start];
            }
        } @catch (NSException *e) {
            // Chặn đứng mọi lỗi ngoại lệ
        }
    });
}
