#ifndef KeyAuthConfig_h
#define KeyAuthConfig_h

#import <Foundation/Foundation.h>

extern "C" {
    // Tên hiển thị
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"LE VINH VIP";

    // Version "1.0"
    const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
    const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

    // Owner ID "fjFllxcSj2"
    const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
    const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

    // Cấu hình phụ
    const uint32_t KEYAUTH_MAX_DYLIBS = 1;
    void __clear_cache(void *begin, void *end) {}
}

#endif
