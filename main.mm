#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// =============================================================
// KHAI BÁO BIẾN THEO ĐÚNG API (KHÔNG ĐƯỢC THAY ĐỔI TÊN BIẾN)
// =============================================================
extern "C" {
    // 1. Tên Menu hiển thị
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"Vinh Pro Menu";

    // 2. Version: 1.0 -> Mã Hex: {0x31, 0x2e, 0x30}
    const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
    const NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    // 3. ACCOUNT OWNER ID (fjFllxcSj2) -> Mã Hex chuẩn
    // API này dùng OWNER ID làm APP ID chính để định danh
    const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
    const NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    // 4. Các cấu hình bảo mật khác
    const uint32_t KEYAUTH_MAX_DYLIBS = 3; 
    void __clear_cache(void *begin, void *end) {}
}

// =============================================================
// HÀM KHỞI CHẠY - GỌI ĐÚNG THEO KEYAUTH.H
// =============================================================
__attribute__((constructor)) static void init() {
    // Đợi 10 giây để game load xong hoàn toàn
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Theo KeyAuth.h, chỉ cần gọi [shared start]
        // Thư viện sẽ tự động tìm các biến KEYAUTH_ENC_ ở trên để kết nối
        [[KeyAuthSystem shared] start];
        
    });
}
