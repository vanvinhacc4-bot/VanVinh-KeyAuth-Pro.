#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// --- CHỈ ĐỂ THÔNG SỐ CỦA VINH Ở ĐÂY ---
extern "C" {
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
    __attribute__((unused)) static const uint32_t KEYAUTH_MAX_DYLIBS = 100; 
}

// --- LỆNH GỌI GIAO DIỆN HIỆN LÊN ---
__attribute__((constructor)) static void vinh_khoi_chay() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            id sharedAuth = [authClass performSelector:@selector(shared)];
            if (sharedAuth) {
                [sharedAuth performSelector:@selector(start)];
                NSLog(@"[Vinh Pro] Da goi Menu thanh cong!");
            }
        }
    });
}
