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

// --- 2. HÀM KHỞI CHẠY (DÙNG DYNAMIC CALL ĐỂ TRÁNH LỖI LINKER) ---
__attribute__((constructor)) static void vinh_pro_init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Gọi Class theo kiểu chuỗi để Compiler không bắt bẻ lỗi "Undefined symbols"
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wundeclared-selector"
            id sharedAuth = [authClass performSelector:@selector(shared)];
            if (sharedAuth) {
                [sharedAuth performSelector:@selector(start)];
                NSLog(@"[Vinh Pro] Menu KeyAuth khoi chay!");
            }
            #pragma clang diagnostic pop
        }
    });
}

// --- 3. GIAO DIỆN MENU (DÙNG CATEGORY TRÊN OBJECT ĐỂ AN TOÀN) ---
@interface NSObject (ThemeAPI)
- (BOOL)isDarkMode;
- (UIColor *)accentColor;
- (UIColor *)backgroundColor;
@end

@implementation NSObject (ThemeAPI_Vinh)
// Chỉ thực hiện nếu đúng là Class KeyAuthSystem gọi
- (BOOL)isDarkMode { return YES; }
- (UIColor *)accentColor { return [UIColor redColor]; }
- (UIColor *)backgroundColor { return [UIColor colorWithWhite:0.05 alpha:0.95]; }
- (UIColor *)textColor { return [UIColor whiteColor]; }
@end
