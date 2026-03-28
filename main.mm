#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// CHỈ IMPORT HEADER, KHÔNG KHAI BÁO LẠI BIẾN TRONG MAIN
#import "KeyAuthConfig.h" 
#import "KeyAuth.h"

// Hàm thực thi chính
static void LaunchKeyAuth() {
    // Kiểm tra UIWindow - Nguyên nhân gây văng số 1 trên iOS
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            // Nếu App chưa load xong UI, đợi tiếp 2 giây
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LaunchKeyAuth();
            });
            return;
        }

        // Gọi instance từ thư viện .a
        KeyAuthSystem *auth = [KeyAuthSystem shared];
        if (auth) {
            [auth start];
            NSLog(@"[Vinh] KeyAuth Started!");
        }
    });
}

// Hàm khởi tạo dylib
__attribute__((constructor)) static void init() {
    // Lắng nghe sự kiện App đã load xong hoàn toàn (Launch Finished)
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification *note) {
        
        // Delay thêm 3 giây để đảm bảo các lớp bảo mật của App/Game đã chạy xong
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LaunchKeyAuth();
        });
    }];
}
