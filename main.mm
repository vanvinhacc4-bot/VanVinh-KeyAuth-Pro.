#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// FIX LỖI LINKER (KHÔNG ĐƯỢC XOÁ)
// ==========================================
extern "C" void __clear_cache(void *begin, void *end) {}

// ==========================================
// CẤU HÌNH KEYAUTH (THAY THÔNG TIN CỦA MÀY)
// ==========================================
// Tên hiển thị trên Menu
NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VanVinh Pro Menu";

// Phiên bản (Dạng Hex, ví dụ: 1.0)
const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
const NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

// App ID của mày (Dạng Hex)
const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
const NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

// Giới hạn số lượng Dylib chạy cùng lúc
const uint32_t KEYAUTH_MAX_DYLIBS = 3;

// ==========================================
// KHỞI CHẠY MENU KHI LOAD GAME
// ==========================================
__attribute__((constructor)) static void init() {
    // Đợi 5 giây sau khi vào game để Menu hiện lên (tránh bị crash)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[KeyAuthSystem shared] start];
    });
}
