#import <Flutter/Flutter.h>

@interface UmengPushSdkPlugin : NSObject<FlutterPlugin>

+ (void)didReceiveUMessage:(NSDictionary *)userInfo;

+ (void)didOpenUMessage:(NSDictionary *)userInfo;

+ (void)didRegisterDeviceToken:(NSData *)deviceToken;

@end
