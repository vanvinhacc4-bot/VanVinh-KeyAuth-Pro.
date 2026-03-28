#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// Hàm kích hoạt an toàn
static void LaunchVinhMenu() {
    // Đảm bảo chạy trên Main Thread để không văng UI
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].keyWindow) {
            // Theo Header của mày, chỉ có duy nhất lệnh này là hợp lệ
            [[KeyAuthSystem shared] start];
            NSLog(@"[Vinh] Start success!");
        } else {
            // Nếu App chưa sẵn sàng, đợi thêm 2 giây
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LaunchVinhMenu();
            });
        }
    });
}

// Constructor khởi tạo dylib
__attribute__((constructor)) static void init() {
    // Lắng nghe lúc App load xong hoàn toàn mới chạy
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification 
                                                      object:nil 
                                                       queue:[NSOperationQueue mainQueue] 
                                                  usingBlock:^(NSNotification *note) {
        
        // Delay 5 giây để chắc chắn Game ổn định
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LaunchVinhMenu();
        });
    }];
}
