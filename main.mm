#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// --- THÔNG SỐ CỦA VINH ---
extern "C" {
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
    const uint32_t KEYAUTH_MAX_DYLIBS = 100; 
}

// Hàm này chạy ngay khi dylib được load
__attribute__((constructor)) static void vinh_init() {
    // Để 10 giây cho Game load xong UI gốc
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Kiểm tra xem Class KeyAuth có tồn tại không trước khi gọi để tránh văng
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            id shared = [authClass performSelector:@selector(shared)];
            if (shared) {
                [shared performSelector:@selector(start)];
            }
        }
    });
}

// Theme tối giản để tránh lỗi vẽ giao diện gây văng
@implementation KeyAuthSystem (ThemeAPI)
- (BOOL)isDarkMode { return YES; }
- (UIColor *)accentColor { return [UIColor redColor]; }
- (UIColor *)backgroundColor { return [UIColor colorWithWhite:0.05 alpha:0.95]; }
- (UIColor *)textColor { return [UIColor whiteColor]; }
- (UIColor *)pillColor { return [UIColor colorWithWhite:0.1 alpha:1.0]; }
@end
