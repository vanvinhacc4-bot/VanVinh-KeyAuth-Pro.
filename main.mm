#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// --- THÔNG SỐ KEYAUTH CỦA VINH ---
extern "C" {
    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";

    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 

    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";

    __attribute__((visibility("default"))) __attribute__((used)) 
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";

    __attribute__((visibility("default"))) __attribute__((used)) 
    const uint32_t KEYAUTH_MAX_DYLIBS = 1;
}

// --- HÀM KHỞI CHẠY KHÔNG VĂNG ---
__attribute__((constructor)) static void vinh_setup() {
    // Đợi 10 giây để Game load xong hẳn mới hiện Menu
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            id auth = [authClass performSelector:@selector(shared)];
            [auth performSelector:@selector(start)];
            
            // Ép Menu nổi lên trên cùng (Fix lỗi bị Game che)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
                if (keyWin) keyWin.windowLevel = UIWindowLevelStatusBar + 100;
            });
            NSLog(@"[Vinh] KeyAuth Started with Success!");
        } else {
            NSLog(@"[Vinh] Error: KeyAuthSystem class not found!");
        }
    });
}
