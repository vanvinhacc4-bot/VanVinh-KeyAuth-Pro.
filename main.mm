#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// CẤU HÌNH KEYAUTH - ÉP ĐỊNH NGHĨA BIẾN
// ==========================================
extern "C" {
    // Số lượng dylib tối đa
    __attribute__((visibility("default"), used)) uint32_t KEYAUTH_MAX_DYLIBS = 3;
    
    // Tên hiển thị trên Menu
    __attribute__((visibility("default"), used)) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VanVinh Pro Menu";
    
    // Version: 1.0 (Dạng Hex: 0x31, 0x2e, 0x30)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    // App ID: FjFllxcSj2 (Mã Hex chuẩn 100%)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_APP_ID[] = {0x46, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    // Fix lỗi bộ nhớ đệm cho arm64
    void __clear_cache(void *begin, void *end) {}
}

// ==========================================
// HÀM KHỞI CHẠY (CHỐNG VĂNG)
// ==========================================
__attribute__((constructor)) static void init() {
    // Đợi 8 giây để game load xong xuôi giao diện rồi mới hiện Menu
    // Nếu vẫn văng, mày hãy thử tăng số 8 lên 12
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[KeyAuthSystem shared] start];
    });
}
