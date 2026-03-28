#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// KHAI BÁO BIẾN TOÀN CỤC (ÉP TRÌNH BIÊN DỊCH NHẬN)
// ==========================================
extern "C" {
    // Ép các biến này ra phạm vi công khai (Visibility Default)
    __attribute__((visibility("default"))) uint32_t KEYAUTH_MAX_DYLIBS = 3;
    __attribute__((visibility("default"))) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VanVinh Pro Menu";
    
    // Cấu hình Version: 1.0
    __attribute__((visibility("default"))) uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
    __attribute__((visibility("default"))) NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    // Cấu hình App ID: FjFllxcSj2 (Đã sửa 0x46 cho chữ F hoa)
    __attribute__((visibility("default"))) uint8_t KEYAUTH_ENC_APP_ID[] = {0x46, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
    __attribute__((visibility("default"))) NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    void __clear_cache(void *begin, void *end) {}
}

// ==========================================
// KHỞI CHẠY MENU
// ==========================================
__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Khởi tạo hệ thống KeyAuth
        [[KeyAuthSystem shared] start];
    });
}
