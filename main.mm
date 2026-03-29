#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuth.h"

// --- 1. THÔNG SỐ KEYAUTH CỦA VINH ---
extern "C" {
    // Tên hiển thị trên Menu
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";
    // Phiên bản app
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 
    // Owner ID từ bảng điều khiển KeyAuth
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";
    // App Secret từ bảng điều khiển KeyAuth
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
    
    // FIX LỖI BUILD: Thêm unused để GitHub không báo lỗi khi biến không trực tiếp được gọi
    __attribute__((unused)) static const uint32_t KEYAUTH_MAX_DYLIBS = 100; 
}

// --- 2. HÀM KHỞI CHẠY (FIX VĂNG & HIỆN MENU) ---
__attribute__((constructor)) static void vinh_pro_init() {
    // Chờ 10 giây để Game load xong bộ nhớ rồi mới gọi Menu (Tránh văng cực tốt)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Kiểm tra xem class KeyAuth có tồn tại trong dylib/game không
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            // Lấy đối tượng shared và bắt đầu chạy (start)
            id sharedAuth = [authClass performSelector:@selector(shared)];
            if (sharedAuth) {
                [sharedAuth performSelector:@selector(start)];
                NSLog(@"[Vinh Pro] Menu KeyAuth đã sẵn sàng!");
            }
        }
    });
}

// --- 3. GIAO DIỆN MENU (THEME TỐI GIẢN) ---
@implementation KeyAuthSystem (ThemeAPI)

- (BOOL)isDarkMode { 
    return YES; 
}

- (UIColor *)accentColor { 
    // Màu chủ đạo là Đỏ (Red)
    return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]; 
}

- (UIColor *)backgroundColor { 
    // Nền màu đen bóng đêm
    return [UIColor colorWithWhite:0.05 alpha:0.95]; 
}

- (UIColor *)textColor { 
    return [UIColor whiteColor]; 
}

- (UIColor *)pillColor { 
    return [UIColor colorWithWhite:0.15 alpha:1.0]; 
}

@end
