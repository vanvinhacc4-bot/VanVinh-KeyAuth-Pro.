#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h" 

// --- 1. THÔNG SỐ CỦA VINH ---
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
    const uint32_t KEYAUTH_MAX_DYLIBS = 50; // Tăng cái này lên để tránh bị Game quét dylib
}

// --- 2. HÀM FIX LỖI KHÔNG HIỆN MENU ---
__attribute__((constructor)) static void vinh_final_fix() {
    // Chờ 5 giây để Game hiện màn hình chính
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            id auth = [authClass performSelector:@selector(shared)];
            [auth performSelector:@selector(start)];
            
            // VÒNG LẶP ÉP HIỆN: Cứ mỗi 1 giây nó sẽ kiểm tra và lôi Menu lên trên cùng 1 lần
            // (Đề phòng Game nó tự đè hình nền lên Menu của mình)
            dispatch_async(dispatch_get_main_queue(), ^{
                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    for (UIWindow *window in [UIApplication sharedApplication].windows) {
                        // Tìm cái cửa sổ nào chứa Menu hoặc đang là cửa sổ chính
                        if (![window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                            window.windowLevel = UIWindowLevelStatusBar + 9999.0;
                            window.clipsToBounds = NO;
                        }
                    }
                }];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            });
            
            NSLog(@"[Vinh] Forced Menu appearance initialized!");
        }
    });
}

// --- 3. THEME GIAO DIỆN (GIỮ NGUYÊN) ---
@implementation KeyAuthSystem (ThemeAPI)
- (BOOL)isDarkMode { return YES; }
- (UIColor *)accentColor { return [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0]; }
- (UIColor *)backgroundColor { return [UIColor colorWithWhite:0.05 alpha:0.95]; }
- (UIColor *)textColor { return [UIColor whiteColor]; }
- (UIColor *)pillColor { return [UIColor colorWithWhite:0.15 alpha:1.0]; }
- (UIColor *)glowColor { return [[self accentColor] colorWithAlphaComponent:0.6]; }
@end
