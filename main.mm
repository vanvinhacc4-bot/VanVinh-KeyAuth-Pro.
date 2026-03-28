#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// --- CẤU HÌNH BIẾN TĨNH (STATIC MEMORY) ---
extern "C" {
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"LE VINH VIP";

    // Version "1.0" -> Hex: {0x31, 0x2e, 0x30}
    const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
    const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

    // Owner ID "fjFllxcSj2" -> Hex
    const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
    const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

    const uint32_t KEYAUTH_MAX_DYLIBS = 1; 
    void __clear_cache(void *begin, void *end) {}
}

// --- HÀM KHỞI CHẠY AN TOÀN (ANTI-CRASH LOGIC) ---
static void SafeStartKeyAuth() {
    // 1. Kiểm tra xem Window của App đã sẵn sàng chưa
    // Nếu chưa có UIWindow, hiện Menu sẽ gây văng ngay lập tức
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        // Nếu chưa có window, đợi thêm 2 giây rồi thử lại (Recursive)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SafeStartKeyAuth();
        });
        return;
    }

    // 2. Kiểm tra Instance của thư viện
    KeyAuthSystem *auth = [KeyAuthSystem shared];
    if (auth != nil) {
        @try {
            [auth start];
            NSLog(@"[Vinh] Login Menu hiện thành công!");
        } @catch (NSException *e) {
            NSLog(@"[Vinh] Phát hiện lỗi tiềm ẩn, đã chặn văng: %@", e.reason);
        }
    }
}

// --- CONSTRUCTOR ---
__attribute__((constructor)) static void load_logic() {
    // Không chạy ngay, đợi App khởi động hoàn tất (DID_FINISH_LAUNCHING)
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        
        // Đợi thêm 3 giây sau khi vào hẳn màn hình chính cho chắc chắn
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SafeStartKeyAuth();
        });
    }];
}
