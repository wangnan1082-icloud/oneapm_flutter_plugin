#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <OneAPMUEM/OneAPM.h>

int main(int argc, char* argv[]) {
  @autoreleasepool {

      // 可以在 main.m 中初始化 SDK，或者在 Flutter 中初始化 SDK。
      // [OneAPM setPrintLog:YES];
      // [OneAPM setHost:@"10.128.7.13"
      //            port:38081
      //    withSecurity:NO];
      
      // [OneAPM setHost:@"miv2dc.oneapm.com" withSecurity:YES];
      // [OneAPM setUserName:@"Developer"];
      // [OneAPM setSearchKey:@"keywords"];
      // [OneAPM setCustomInfo:@{@"key1" : @"value1",
      //                         @"key2" : @"value2"
      //                       }];
      // [OneAPM startWithApplicationToken:@"b50c882b-193f-4711-9a0f-998bb97fc412"];
      
      
      
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
