#ifndef KeyAuthConfig_h
#define KeyAuthConfig_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

extern NSString * const KEYAUTH_APP_DISPLAY_NAME;
extern const uint8_t KEYAUTH_ENC_VERSION[];
extern const NSUInteger KEYAUTH_ENC_VERSION_LEN;
extern const uint8_t KEYAUTH_ENC_OWNER_ID[];
extern const NSUInteger KEYAUTH_ENC_OWNER_ID_LEN;
extern const uint8_t KEYAUTH_ENC_APP_SECRET[];
extern const NSUInteger KEYAUTH_ENC_APP_SECRET_LEN;
extern const uint8_t KEYAUTH_ENC_APP_ID[];
extern const NSUInteger KEYAUTH_ENC_APP_ID_LEN;

#ifdef __cplusplus
}
#endif

#endif
