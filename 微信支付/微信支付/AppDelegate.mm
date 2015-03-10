//
//  AppDelegate.m
//  微信支付
//
//  Created by bin.yan on 15-3-10.
//  Copyright (c) 2015年 bin.yan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Constant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 向微信注册app
    [WXApi registerApp:WXAppId];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController * vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 网络回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 支付宝回调接口
static inline NSString * errMsg(int errCode)
{
    NSString * result = @"";
    switch (errCode) {
        case WXErrCodeCommon:       result = @"普通错误类型";break;
        case WXErrCodeUserCancel:   result = @"用户点击取消并返回";break;
        case WXErrCodeSentFail:     result = @"发送失败";break;
        case WXErrCodeAuthDeny:     result = @"授权失败";break;
        case WXErrCodeUnsupport:    result = @"微信不支持";break;
    }
    
    return result;
}
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {

        int result = resp.errCode;
        if ( result == WXSuccess ) {
            NSLog(@"微信支付成功");
            [[NSNotificationCenter defaultCenter] postNotificationName:WXZFSuccess object:nil];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:WXZFFaild object:errMsg(result)];
        }
        
    } else {
        NSLog(@"支付结果类型错误,%@",resp);
    }
}
#pragma mark - 其他的app回调
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
