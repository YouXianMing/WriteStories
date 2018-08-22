//
//  AppDelegate.m
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "RootMenuViewController.h"
#import "FoldersManager.h"
#import "DBManager.h"
#import "DBTablesManager.h"
#import "ColorsManager.h"
#import "Values.h"
#import "IconFontsManager.h"
#import "ShowStyleTypeManager.h"
#import "PaymentObject.h"
#import "ZipsUnzip.h"
#import "PaymentsManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     Lateast no warning version : Xcode 9.4.1 (9F2000)
     
     QQ    705786299
     Email YouXianMing1987@126.com
     
     http://www.cnblogs.com/YouXianMing/
     https://github.com/YouXianMing
     https://github.com/YouXianMing/YoCelsius
     
     独立开发作品 (感兴趣的朋友支持一下^_^) : https://itunes.apple.com/cn/app/美记/id1390862464
     
     本人在项目中有使用中文文件夹,但在公司项目中请不要这么使用!
     */
    
    // 避免多个按钮同时点击
    UIButton.appearance.exclusiveTouch = YES;
    
    Values_prepare();
    [IconFontsManager prepare];
    [FoldersManager prepare];
    [DBManager prepare];
    [ColorsManager prepare];
    [ShowStyleTypeManager prepare];
    [DBTablesManager createTables];
    [DBTablesManager upateTableParams];
    [PaymentsManager prepare];
    [PaymentsManager update];
    [ZipsUnzip prepare];
    
    // Init window.
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[RootNavigationController alloc] initWithRootViewController:[RootMenuViewController new]
                                                                           setNavigationBarHidden:YES];
    self.window.backgroundColor    = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
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
