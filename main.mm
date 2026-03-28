#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// CẤU HÌNH API - THÔNG TIN TỪ DASHBOARD
// ==========================================
extern "C" {
    __attribute__((visibility("default"), used)) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"Vinh Pro Menu";
    
    // Version: 1.0 (Hex: 0x31, 0x2e, 0x30)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    // ACCOUNT OWNER ID: fjFllxcSj2 (Hex)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    __attribute__((visibility("default"), used)) uint32_t KEYAUTH_MAX_DYLIBS = 3;
    void __clear_cache(void *begin, void *end) {}
}

// ==========================================
// HÀM KHỞI CHẠY - DÙNG INIT CHUẨN ĐỂ KHÔNG LỖI
// ==========================================
__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Thay vì gán từng dòng .name, .owner, ta gọi thẳng hàm start. 
        // Thư viện sẽ tự lấy thông tin từ các biến KEYAUTH_ENC ở trên.
        [[KeyAuthSystem shared] start];
    });
}
