#import <Flutter/Flutter.h>
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  // 1.获取FlutterViewController(是应用程序的默认Controller)
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  // 2.获取MethodChannel(方法通道)
  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"coderwhy.com/battery"
                                          binaryMessenger:controller.binaryMessenger];
  
  // 3.监听方法调用(会调用传入的回调函数)
  __weak typeof(self) weakSelf = self;
  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      
      
      UIDevice* device = UIDevice.currentDevice;
      device.batteryMonitoringEnabled = YES;
      NSLog(@"当前的电量为   %f",device.batteryLevel);
      
      
      NSLog(@"result -- %@",result);
      
   
      result(@(12));
      
  }];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (int)getBatteryLevel {
  // 获取信息的方法
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
