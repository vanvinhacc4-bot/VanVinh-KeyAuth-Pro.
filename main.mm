#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// --- 1. THÔNG SỐ KEYAUTH CỦA VINH ---
extern "C" {
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
    __attribute__((unused)) static const uint32_t KEYAUTH_MAX_DYLIBS = 100; 
}

// --- 2. KHAI BÁO TRƯỚC (QUAN TRỌNG ĐỂ HIỆN MENU) ---
@interface KeyAuthSystem : NSObject
+ (id)shared;
- (void)start;
@end

// --- 3. HÀM KHỞI CHẠY ---
__attribute__((constructor)) static void vinh_pro_final() {
    // Chờ 10 giây cho Game ổn định
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            // Ép kiểu để gọi đúng hàm start của KeyAuth
            id sharedAuth = [authClass performSelector:@selector(shared)];
            if (sharedAuth) {
                [sharedAuth performSelector:@selector(start)];
                
                // Ép cửa sổ hiện lên trên cùng
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                if (window) window.windowLevel = UIWindowLevelStatusBar + 100.0;
                
                NSLog(@"[Vinh Pro] Menu KeyAuth da kich hoat!");
            }
        }
    });
}

// --- 4. GIAO DIỆN MENU (THEME API) ---
@implementation KeyAuthSystem (ThemeAPI)
- (BOOL)isDarkMode { return YES; }
- (UIColor *)accentColor { return [UIColor redColor]; }
- (UIColor *)backgroundColor { return [UIColor colorWithWhite:0.05 alpha:0.95]; }
- (UIColor *)textColor { return [UIColor whiteColor]; }
- (UIColor *)pillColor { return [UIColor colorWithWhite:0.15 alpha:1.0]; }
- (UIColor *)glowColor { return [[UIColor redColor] colorWithAlphaComponent:0.6]; }
@end
