#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// =============================================================
// CẤU HÌNH BẮT BUỘC - ÉP TRÌNH BIÊN DỊCH KHÔNG ĐƯỢC XÓA (KEEP SYMBOLS)
// =============================================================
extern "C" {
    // Thuộc tính __attribute__((used)) cực kỳ quan trọng để chống văng
    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"LE VINH IOS";

    // Version "1.0"
    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
    
    __attribute__((visibility("default"))) __attribute__((used)) 
    const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

    // Owner ID "fjFllxcSj2"
    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
    
    __attribute__((visibility("default"))) __attribute__((used)) 
    const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint32_t KEYAUTH_MAX_DYLIBS = 1;

    __attribute__((visibility("default"))) __attribute__((used)) 
    void __clear_cache(void *begin, void *end) {}
}

// =============================================================
// LOGIC KHỞI CHẠY AN TOÀN
// =============================================================
static void StartMenu() {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Kiểm tra xem App đã có cửa sổ hiển thị chưa
        UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
        if (keyWin) {
            @try {
                // Gọi lệnh duy nhất từ Header của mày
                [[KeyAuthSystem shared] start];
                NSLog(@"[Vinh] KeyAuth Started!");
            } @catch (NSException *e) {
                NSLog(@"[Vinh] Chặn văng: %@", e.reason);
            }
        } else {
            // Nếu chưa có Window, đợi thêm 2 giây rồi thử lại
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                StartMenu();
            });
        }
    });
}

__attribute__((constructor)) static void init() {
    // Đợi App sẵn sàng hoàn toàn mới bắt đầu đếm ngược hiện Menu
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification *note) {
        
        // Delay 5 giây để tránh xung đột với Anti-cheat hoặc UI khởi đầu
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            StartMenu();
        });
    }];
}
