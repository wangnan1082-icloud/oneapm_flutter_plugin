#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <OneAPMUEM/OneAPM.h>

int main(int argc, char* argv[]) {
  @autoreleasepool {
      
      // #import <OneAPMUEM/OneAPM.h>
      [OneAPM setPrintLog:YES];
      [OneAPM setHost:@"10.128.7.13"
                 port:38081
         withSecurity:NO];
      
      // [OneAPM setHost:@"miv2dc.oneapm.com" withSecurity:YES];
      [OneAPM setUserName:@"Developer"];
      [OneAPM setSearchKey:@"keywords"];
      [OneAPM setCustomInfo:@{@"key1" : @"value1",
                              @"key2" : @"value2"
                            }];
      // 快手
      [OneAPM startWithApplicationToken:@"8d3b5d29-9025-43b4-976c-0579feb31e94"];
      
      
      
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
