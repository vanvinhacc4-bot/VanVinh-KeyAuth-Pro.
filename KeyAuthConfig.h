#ifndef KeyAuthConfig_h
#define KeyAuthConfig_h

#import <Foundation/Foundation.h>

// Định nghĩa trực tiếp ở đây để thư viện .a đọc thẳng từ Header
static NSString * const KEYAUTH_APP_DISPLAY_NAME = @"LE VINH MENU";

// Version 1.0
static const uint8_t KEYAUTH_ENC_VERSION[] = {0x31, 0x2e, 0x30};
static const NSUInteger KEYAUTH_ENC_VERSION_LEN = 3;

// Owner ID: fjFllxcSj2
static const uint8_t KEYAUTH_ENC_APP_ID[] = {0x66, 0x6a, 0x46, 0x6c, 0x6c, 0x78, 0x63, 0x53, 0x6a, 0x32};
static const NSUInteger KEYAUTH_ENC_APP_ID_LEN = 10;

static const uint32_t KEYAUTH_MAX_DYLIBS = 1;

#endif
