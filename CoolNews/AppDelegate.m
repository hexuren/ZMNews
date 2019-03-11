//
//  AppDelegate.m
//  CoolNews
//
//  Created by Zhimi on 2018/2/5.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "AppDelegate.h"
#import "CNBaseTarBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[CNBaseTarBarController new]];
    [self.window makeKeyAndVisible];
    if ([YLWUserLoginModel sharedUserLoginModel].isLogin) {
        NSLog(@"登录");
    }else{
        
        NSLog(@"没有登录");
    }
    [self monitoringNetwork];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma makr - Utilities
- (void)monitoringNetwork{
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [SVProgressHUD showInfoWithStatus:@"未识别的网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showErrorWithStatus:@"不可达的网络(未连接)"];
                //                if (self.showOfflineData) {
                //                    self.showOfflineData();
                //                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [SVProgressHUD showSuccessWithStatus:@"2G,3G,4G...的网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [SVProgressHUD showSuccessWithStatus:@"wifi的网络"];
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}

@end
