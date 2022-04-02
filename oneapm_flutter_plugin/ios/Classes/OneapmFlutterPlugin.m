#import "OneapmFlutterPlugin.h"
#import <objc/runtime.h>
#import <OneAPMUEM/OneAPM.h>
#import <OneAPMUEM/COneAPMAction.h>

static NSString *const OneAPMFlutterPluginMethodGetSDKVersion = @"getSDKVersion";
static NSString *const OneAPMFlutterPluginMethodStart = @"startWithApplicationToken";
static NSString *const OneAPMFlutterPluginMethodSetUserName = @"setUserName";
static NSString *const OneAPMFlutterPluginMethodSetCustomAction = @"setCustomAction";
static NSString *const OneAPMFlutterPluginMethodSetHostAndPortAndSecurity = @"setHostAndPortAndSecurity";

@implementation OneapmFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"oneapm_flutter_plugin"
                                     binaryMessenger:[registrar messenger]];
    OneapmFlutterPlugin* instance = [[OneapmFlutterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *method = call.method;
    NSDictionary *arguments = (NSDictionary *)call.arguments;
        
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodGetSDKVersion]){
        // [self getSDKVersion];
        result(self.getSDKVersion);
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodStart]){
        NSString *token = arguments[@"token"];
        [self startWithApplicationToken:token];
        result(token);
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodSetUserName]){
        NSString *userNameStr = arguments[@"userName"];
        [self setUserName:userNameStr];
        result(userNameStr);
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodSetCustomAction]){
        NSString *viewNameStr = arguments[@"viewName"];
        NSString *actionNameStr = arguments[@"actionName"];
        [self customAction:viewNameStr action:actionNameStr];
        result(actionNameStr);  
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodSetHostAndPortAndSecurity]){
        NSString *hostStr = arguments[@"host"];
        NSString *port = arguments[@"port"];
        NSString *security = arguments[@"security"];        
        [self setHostAndPortAndSecurity:hostStr port:port security:security];
        result(hostStr);  
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (NSString *)getSDKVersion {
   return [OneAPM getSDKVersion];
}

- (void)startWithApplicationToken:(NSString *)token {
    [OneAPM startWithApplicationToken:token];
}

- (void)setUserName:(NSString *)userNameStr {
    [OneAPM setUserName:userNameStr];
}

- (void)setHostAndPortAndSecurity:(NSString *)hostStr port:(NSString *)port security:(NSString *)security {
    [OneAPM setHost:hostStr port:port.integerValue withSecurity:security.boolValue];
}

- (void)customAction:(NSString *)viewNameStr action:(NSString *)actionNameStr {
    COneAPMAction *action = [COneAPMAction enterActionInView:viewNameStr actionName:actionNameStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [action endAction];
    });
    
}

@end
