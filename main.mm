#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// ==========================================
// CẤU HÌNH API - THÔNG TIN TỪ DASHBOARD CỦA VINH
// ==========================================
extern "C" {
    // Tên hiển thị trên Menu của mày
    __attribute__((visibility("default"), used)) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"Vinh Pro Menu";
    
    // 1. Version: 1.0 (Dạng Hex: 0x31, 0x2e, 0x30)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    // 2. ACCOUNT OWNER ID: fjFllxcSj2 (Đã chuyển sang Hex để chống văng)
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    // Các biến phụ trợ hệ thống
    __attribute__((visibility("default"), used)) uint32_t KEYAUTH_MAX_DYLIBS = 3;
    void __clear_cache(void *begin, void *end) {}
}

// ==========================================
// HÀM KHỞI CHẠY - KẾT NỐI SERVER KEYAUTH
// ==========================================
__attribute__((constructor)) static void init() {
    // Đợi 10 giây để game load ổn định rồi mới hiện bảng Login
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Gán thông tin API của Vinh vào hệ thống
        [KeyAuthSystem shared].name = @"Yamatevinh123's Application";
        [KeyAuthSystem shared].ownerid = @"fjFllxcSj2";
        [KeyAuthSystem shared].secret = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
        [KeyAuthSystem shared].version = @"1.0";
        
        // Bắt đầu hiện Menu Login
        [[KeyAuthSystem shared] start];
    });
}
