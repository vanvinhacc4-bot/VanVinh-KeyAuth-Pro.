#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// Đảm bảo trình biên dịch biết KeyAuthSystem là một Class
@class KeyAuthSystem;

extern "C" {
    __attribute__((visibility("default"), used)) uint32_t KEYAUTH_MAX_DYLIBS = 3;
    __attribute__((visibility("default"), used)) NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VanVinh Pro Menu";
    
    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

    __attribute__((visibility("default"), used)) uint8_t KEYAUTH_ENC_APP_ID[] = {0x46, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32}; 
    __attribute__((visibility("default"), used)) NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

    void __clear_cache(void *begin, void *end) {}
}

__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Gọi thẳng đến shared instance để kích hoạt thư viện
        [(id)NSClassFromString(@"KeyAuthSystem") performSelector:@selector(shared)];
        [[NSClassFromString(@"KeyAuthSystem") alloc] performSelector:@selector(start)];
    });
}
