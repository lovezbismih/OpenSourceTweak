#import <dlfcn.h>
#import <Foundation/Foundation.h>

#define YT_BUNDLE_ID @"com.google.ios.youtube"
#define YT_NAME @"YouTube"

@interface SSOConfiguration : NSObject
@end

%hook YTVersionUtils

+ (NSString *)appName {
    return YT_NAME;
}

+ (NSString *)appID {
    return YT_BUNDLE_ID;
}

%end

%hook GCKBUtils

+ (NSString *)appIdentifier {
    return YT_BUNDLE_ID;
}

%end

%hook GPCDeviceInfo

+ (NSString *)bundleId {
    return YT_BUNDLE_ID;
}

%end

%hook OGLBundle

+ (NSString *)shortAppName {
    return YT_NAME;
}

%end

%hook GVROverlayView

+ (NSString *)appName {
    return YT_NAME;
}

%end

%hook OGLPhenotypeFlagServiceImpl

- (NSString *)bundleId {
    return YT_BUNDLE_ID;
}

%end

%hook APMAEU

+ (BOOL)isFAS {
    return YES;
}

%end

%hook GULAppEnvironmentUtil

+ (BOOL)isFromAppStore {
    return YES;
}

%end

%hook SSOConfiguration

- (id)initWithClientID:(id)clientID supportedAccountServices:(id)supportedAccountServices {
    self = %orig;
    [self setValue:YT_NAME forKey:@"_shortAppName"];
    [self setValue:YT_BUNDLE_ID forKey:@"_applicationIdentifier"];
    return self;
}

%end

BOOL isSelf() {
    NSArray *address = [NSThread callStackReturnAddresses];
    Dl_info info = {0};
    if (dladdr((void *)[address[2] longLongValue], &info) == 0) return NO;
    NSString *path = [NSString stringWithUTF8String:info.dli_fname];
    return [path hasPrefix:NSBundle.mainBundle.bundlePath];
}

%hook NSBundle

- (NSString *)bundleIdentifier {
    return isSelf() ? YT_BUNDLE_ID : %orig;
}

- (NSDictionary *)infoDictionary {
    NSDictionary *dict = %orig;
    if (!isSelf())
        return %orig;
    NSMutableDictionary *info = [dict mutableCopy];
    if (info[@"CFBundleIdentifier"]) info[@"CFBundleIdentifier"] = YT_BUNDLE_ID;
    if (info[@"CFBundleDisplayName"]) info[@"CFBundleDisplayName"] = YT_NAME;
    if (info[@"CFBundleName"]) info[@"CFBundleName"] = YT_NAME;
    return info;
}

- (id)objectForInfoDictionaryKey:(NSString *)key {
    if (!isSelf())
        return %orig;
    if ([key isEqualToString:@"CFBundleIdentifier"])
        return YT_BUNDLE_ID;
    if ([key isEqualToString:@"CFBundleDisplayName"] || [key isEqualToString:@"CFBundleName"])
        return YT_NAME;
    return %orig;
}

%end
