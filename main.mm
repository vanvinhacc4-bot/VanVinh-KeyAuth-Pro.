#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "API/KeyAuth.h"

// --- 1. THÔNG SỐ KEYAUTH CỦA VINH ---
extern "C" {
    NSString * const KEYAUTH_APP_DISPLAY_NAME = @"VAN VINH PRO";
    NSString * const KEYAUTH_APP_VERSION = @"1.0"; 
    NSString * const KEYAUTH_OWNER_ID = @"fjFllxcSj2";
    NSString * const KEYAUTH_APP_SECRET = @"81c6788b2918813bb0263c560f31962d6b8ae9248f9d898ae7f66f855175d68f";
    const uint32_t KEYAUTH_MAX_DYLIBS = 1;
}

// --- 2. HÀM KHỞI CHẠY (Hẹn giờ hiện Menu) ---
__attribute__((constructor)) static void vinh_setup() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Class authClass = NSClassFromString(@"KeyAuthSystem");
        if (authClass) {
            id auth = [authClass performSelector:@selector(shared)];
            [auth performSelector:@selector(start)];
            
            // Ép Menu nổi lên trên cùng (Fix lỗi bị Game che)
            UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
            if (keyWin) keyWin.windowLevel = UIWindowLevelStatusBar + 100;
            NSLog(@"[Vinh] Menu KeyAuth da khoi chay!");
        }
    });
}

// --- 3. TOÀN BỘ GIAO DIỆN THEME (BẢN GỐC 100%) ---
static const NSString *kThemeModeKey = @"ModMenuDarkMode";
static const NSString *kMenuColorThemeKey = @"ModMenuColorTheme";
static const NSString *kWinterThemeKey = @"ModMenuWinterTheme";
static const NSString *kLiquidThemeKey = @"ModMenuLiquidTheme";

@implementation KeyAuthSystem (ThemeAPI)

+ (NSInteger)themeMenuColorTheme {
    return [[NSUserDefaults standardUserDefaults] integerForKey:(NSString *)kMenuColorThemeKey];
}

+ (BOOL)themeIsDarkMode {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:(NSString *)kThemeModeKey]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:(NSString *)kThemeModeKey];
    }
    return YES;
}

+ (BOOL)themeIsWinter {
    return [[NSUserDefaults standardUserDefaults] boolForKey:(NSString *)kWinterThemeKey];
}

+ (BOOL)themeIsLiquid {
    return [[NSUserDefaults standardUserDefaults] boolForKey:(NSString *)kLiquidThemeKey];
}

- (BOOL)isDarkMode { return [KeyAuthSystem themeIsDarkMode]; }
- (BOOL)isWinterTheme { return [KeyAuthSystem themeIsWinter]; }
- (BOOL)isLiquidTheme { return [KeyAuthSystem themeIsLiquid]; }

- (UIColor *)accentColor {
    if ([KeyAuthSystem themeIsWinter]) {
        return [UIColor colorWithRed:0.4 green:0.7 blue:1.0 alpha:1.0];
    }
    switch ([KeyAuthSystem themeMenuColorTheme]) {
        case 1: return [UIColor colorWithRed:0.2 green:0.5 blue:1.0 alpha:1.0];
        case 2: return [UIColor colorWithRed:0.2 green:1.0 blue:0.2 alpha:1.0];
        case 3: return [UIColor colorWithRed:1.0 green:0.4 blue:0.8 alpha:1.0];
        default: return [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0];
    }
}

- (UIColor *)backgroundColor {
    BOOL dark = [KeyAuthSystem themeIsDarkMode];
    if ([KeyAuthSystem themeIsLiquid]) {
        return dark ? [UIColor colorWithWhite:0.05 alpha:0.85]
                    : [UIColor colorWithWhite:0.98 alpha:0.9];
    }
    if ([KeyAuthSystem themeIsWinter]) {
        return dark ? [UIColor colorWithRed:0.02 green:0.04 blue:0.08 alpha:1.0]
                    : [UIColor colorWithRed:0.92 green:0.95 blue:1.0 alpha:1.0];
    }
    NSInteger theme = [KeyAuthSystem themeMenuColorTheme];
    switch (theme) {
        case 1:
            return dark ? [UIColor colorWithRed:0.01 green:0.01 blue:0.05 alpha:1.0]
                        : [UIColor colorWithRed:0.95 green:0.95 blue:0.99 alpha:1.0];
        case 2:
            return dark ? [UIColor colorWithRed:0.01 green:0.05 blue:0.01 alpha:1.0]
                        : [UIColor colorWithRed:0.95 green:0.99 blue:0.95 alpha:1.0];
        case 3:
            return dark ? [UIColor colorWithRed:0.05 green:0.01 blue:0.03 alpha:1.0]
                        : [UIColor colorWithRed:0.99 green:0.95 blue:0.97 alpha:1.0];
        default:
            return dark ? [UIColor colorWithRed:0.05 green:0.01 blue:0.01 alpha:1.0]
                        : [UIColor colorWithRed:0.99 green:0.95 blue:0.95 alpha:1.0];
    }
}

- (UIColor *)textColor {
    return [KeyAuthSystem themeIsDarkMode] ? [UIColor whiteColor] : [UIColor blackColor];
}

- (UIColor *)secondaryTextColor {
    return [UIColor colorWithWhite:0.5 alpha:1.0];
}

- (UIColor *)pillColor {
    NSInteger theme = [KeyAuthSystem themeMenuColorTheme];
    BOOL dark = [KeyAuthSystem themeIsDarkMode];
    if ([KeyAuthSystem themeIsLiquid]) {
        return dark ? [UIColor colorWithWhite:0.12 alpha:0.7]
                    : [UIColor colorWithWhite:1.0 alpha:0.75];
    }
    if ([KeyAuthSystem themeIsWinter]) {
        return dark ? [UIColor colorWithRed:0.05 green:0.08 blue:0.15 alpha:1.0]
                    : [UIColor colorWithWhite:0.96 alpha:1.0];
    }
    if (dark) {
        switch (theme) {
            case 1: return [UIColor colorWithRed:0.03 green:0.03 blue:0.15 alpha:1.0];
            case 2: return [UIColor colorWithRed:0.03 green:0.15 blue:0.03 alpha:1.0];
            case 3: return [UIColor colorWithRed:0.15 green:0.03 blue:0.08 alpha:1.0];
            default: return [UIColor colorWithRed:0.15 green:0.03 blue:0.03 alpha:1.0];
        }
    }
    return [UIColor colorWithWhite:0.96 alpha:1.0];
}

- (UIColor *)checkboxOffColor {
    return [KeyAuthSystem themeIsDarkMode]
        ? [UIColor colorWithWhite:0.25 alpha:1.0]
        : [UIColor colorWithWhite:0.7 alpha:1.0];
}

- (UIColor *)glowColor { return [[self accentColor] colorWithAlphaComponent:0.6]; }
- (UIColor *)borderColor { return [[self accentColor] colorWithAlphaComponent:[KeyAuthSystem themeIsDarkMode] ? 0.3 : 0.35]; }
- (UIColor *)separatorColor { return [KeyAuthSystem themeIsDarkMode] ? [UIColor colorWithWhite:0.3 alpha:0.5] : [UIColor colorWithWhite:0.7 alpha:0.5]; }
- (UIColor *)pillBorderColor { return [KeyAuthSystem themeIsDarkMode] ? [UIColor colorWithWhite:1.0 alpha:0.08] : [UIColor colorWithWhite:0.0 alpha:0.05]; }

@end
