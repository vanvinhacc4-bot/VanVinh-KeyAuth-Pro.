#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KeyAuthConfig.h"
#import "KeyAuth.h"

// Thêm đoạn này để fix lỗi ___clear_cache
extern "C" void __clear_cache(void *begin, void *end) {}

// ... giữ nguyên các dòng code phía dưới của mày ...

// Tên hiện trên menu login của mày
NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH FF PRO";

// Phiên bản: 1.0 (Dạng Hex)
const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
const NSUInteger KEYAUTH_ENC_VERSION_LEN = sizeof(KEYAUTH_ENC_VERSION);

// Owner ID của mày: fjFllxcSj2 (Dạng Hex đã chuyển sẵn)
const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
const NSUInteger KEYAUTH_ENC_APP_ID_LEN = sizeof(KEYAUTH_ENC_APP_ID);

const uint32_t KEYAUTH_MAX_DYLIBS = 3;

// Khi game load, lệnh này sẽ tự động chạy bảng nhập Key
__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[KeyAuthSystem shared] start]; 
    });
}
