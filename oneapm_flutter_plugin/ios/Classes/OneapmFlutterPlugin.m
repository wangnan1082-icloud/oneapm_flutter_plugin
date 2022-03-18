#import "OneapmFlutterPlugin.h"
#import <objc/runtime.h>
#import <OneAPMUEM/OneAPM.h>

static NSString* const OneAPMFlutterPluginMethodGetSDKVersion = @"getSDKVersion";

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
    NSArray *arguments = (NSArray *)call.arguments;
    
    NSLog(@"method : %@",method);
    NSLog(@"arguments : %@",arguments);
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([method isEqualToString:OneAPMFlutterPluginMethodGetSDKVersion]){
        // [self getSDKVersion];
        result(self.getSDKVersion);
    }else {
        result(FlutterMethodNotImplemented);
    }
}

- (NSString *)getSDKVersion {
   return [OneAPM getSDKVersion];
}

@end
