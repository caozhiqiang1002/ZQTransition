//
//  ZQAppDelegate.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQAppDelegate.h"
#import "ZQRootController.h"

@interface ZQAppDelegate ()

@end

@implementation ZQAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ZQRootController *rootVC = [[ZQRootController alloc] initWithNibName:@"ZQRootController"
                                                                    bundle:nil];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.isForceLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }else if (self.isForcePortrait) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

@end
