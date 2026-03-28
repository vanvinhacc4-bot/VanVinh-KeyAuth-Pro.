#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// --- KHÔNG KHAI BÁO BIẾN EXTERN NỮA ---
// Vì API của mày dùng cơ chế Gán (Setters) trực tiếp vào Object

static void StartVinhMenu() {
    // Lấy instance duy nhất
    KeyAuthSystem *vinhAuth = [KeyAuthSystem shared];
    
    if (vinhAuth) {
        // Gán thông tin (Dựa trên API mày gửi)
        vinhAuth.name = K_NAME;
        vinhAuth.ownerid = K_OWNER;
        vinhAuth.secret = K_SECRET;
        vinhAuth.version = K_VERSION;
        
        // Theo API mày gửi, phải gọi setup trước khi start
        if ([vinhAuth respondsToSelector:@selector(setup)]) {
            [vinhAuth setup];
        }
        
        // Hiện Menu Login
        [vinhAuth start];
        
        NSLog(@"[Vinh] KeyAuth initialized and started!");
    }
}

// Hàm khởi tạo dylib (Constructor)
__attribute__((constructor)) static void init() {
    // Đợi 10 giây để Game load xong UI (Chống văng UIWindow)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Kiểm tra xem App có Window chưa rồi mới chạy
        if ([UIApplication sharedApplication].keyWindow) {
            StartVinhMenu();
        } else {
            // Nếu chưa có, đợi thêm 5 giây nữa cho chắc
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                StartVinhMenu();
            });
        }
    });
}
