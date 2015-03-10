//
//  ViewController.m
//  微信支付
//
//  Created by bin.yan on 15-3-10.
//  Copyright (c) 2015年 bin.yan. All rights reserved.
//

#import "ViewController.h"
#import "WXPayClient.h"
#import "Constant.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiXinZhiFuSuccess:) name:WXZFSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiXinZhiFuFailed:) name:WXZFFaild object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 微信支付结果回调
- (void)weiXinZhiFuSuccess:(NSNotification *)noti
{
    
}
- (void)weiXinZhiFuFailed:(NSNotification *)noti
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"错误" message:(NSString *)noti.object delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - 按钮点按处理
- (IBAction)payBtnPress {
    
    [[WXPayClient shareInstance] payProduct:@"爱医课试题" andFee:7];
}

@end
