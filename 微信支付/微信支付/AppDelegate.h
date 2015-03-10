//
//  AppDelegate.h
//  微信支付
//
//  Created by bin.yan on 15-3-10.
//  Copyright (c) 2015年 bin.yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
