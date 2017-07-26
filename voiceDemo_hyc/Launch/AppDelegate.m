//
//  AppDelegate.m
//  threeT
//
//  Created by Admin on 2016/12/18.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BootLogic.h"
#import "UIFont+custom.h"
#import "RequestManager.h"
#import "iflyMSC/iflyMSC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[kUserDefaults setBool:NO forKey:@"BOOTLOGIC_GUIDE"];
    
    //设置app基本外观样式
    [self setupAppShowStyle];
    
    //开启网络监控
    [[RequestManager sharedInstance]startMonitoring];
    
    //集成第三方
    [self setupThree];
    
    //检查加载启动逻辑
    self.oldRootController = self.window.rootViewController;
    [self checkLoadBootLogic];
    
    return YES;
}


#pragma mark - 设置统一外观
- (void) setupAppShowStyle
{
    // tabbar
    [[UITabBar appearance]setTintColor:kCOLOR_TABBAR_TITLE];
    [[UITabBar appearance]setBackgroundColor:kCOLOR_TABBAR_BACKGROUND];
    
    // navigation
    
    NSDictionary *navTitle = [NSDictionary dictionaryWithObjectsAndKeys:kCOLOR_NAVI_TITLE,NSForegroundColorAttributeName, [UIFont customFontWithSize:kFONT_SIZE_19],NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navTitle];
    
    [[UINavigationBar appearance]setTintColor:kCOLOR_NAVI_TITLE];
    [[UINavigationBar appearance]setBarTintColor:kCOLOR_TABBAR_BACKGROUND];
    
    
}

#pragma mark - 集成第三方
- (void) setupThree
{
    // 初始化开启讯飞
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"5964670c"];
    [IFlySpeechUtility createUtility:initString];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
