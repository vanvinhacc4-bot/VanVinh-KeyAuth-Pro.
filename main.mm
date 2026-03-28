#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// FIX LỖI LINKER - KHAI BÁO CÁC BIẾN TOÀN CỤC
// ==========================================
extern "C" void __clear_cache(void *begin, void *end) {}

// Ép kiểu cụ thể để thư viện tĩnh có thể tìm thấy các ký hiệu này
extern "C" {
    uint32_t KEYAUTH_MAX_DYLIBS = 3;
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VanVinh Pro Menu";
}

// ==========================================
// CẤU HÌNH KEYAUTH (CHÍNH CHỦ VINH)
// ==========================================
// Phiên bản: 1.0
const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
const NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

// App ID: FjFllxcSj2 (Đã sửa chữ F hoa 0x46)
const uint8_t KEYAUTH_ENC_APP_ID[] = {0x46, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
const NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

// ==========================================
// KHỞI CHẠY MENU
// ==========================================
__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Gọi khởi tạo hệ thống KeyAuth
        [[KeyAuthSystem shared] start];
    });
}
