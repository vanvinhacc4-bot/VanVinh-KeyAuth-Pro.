#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// --- FIX VĂNG: ÉP BIẾN VÀO PHÂN ĐOẠN DỮ LIỆU CỐ ĐỊNH ---
extern "C" {
    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH IOS";

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

    __attribute__((visibility("default"))) __attribute__((used)) 
    void __clear_cache(void *begin, void *end) { 
        // Để trống nhưng phải có để thư viện không văng khi gọi xóa cache
    }
}

// --- HÀM KHỞI CHẠY SIÊU AN TOÀN ---
static void __Vinh_Safe_Launch() {
    // Đảm bảo chạy trên Main Thread và UI đã sẵn sàng
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        if (!win) {
            // Nếu chưa có cửa sổ, đợi tiếp (Tránh văng UIWindow)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __Vinh_Safe_Launch();
            });
            return;
        }

        @try {
            // Kiểm tra Class trước khi gọi
            Class authClass = NSClassFromString(@"KeyAuthSystem");
            if (authClass) {
                id auth = [authClass performSelector:@selector(shared)];
                [auth performSelector:@selector(start)];
                NSLog(@"[Vinh] Success: Menu is up!");
            }
        } @catch (NSException *e) {
            NSLog(@"[Vinh] Exception Blocked: %@", e.reason);
        }
    });
}

// --- CONSTRUCTOR: ĐIỂM KÍCH HOẠT ---
__attribute__((constructor)) static void vinh_entry() {
    // Tăng delay lên 15 giây để vượt qua mọi màn hình Loading/Anti-cheat ban đầu
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __Vinh_Safe_Launch();
    });
}
