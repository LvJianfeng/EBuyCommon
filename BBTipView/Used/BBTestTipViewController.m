//
//  BBTestTipViewController.m
//  EBuyCommon
//
//  Created by LvJianfeng on 15/9/28.
//  Copyright © 2015年 coderjianfeng. All rights reserved.
//

#import "BBTestTipViewController.h"
#import "UIView+ActivityIndicator.h"

@interface BBTestTipViewController ()
{
    NSTimer *timer;
}
@end

@implementation BBTestTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)testTip1:(id)sender {
    [self.view showTipViewAtCenter:@"出现提示内容，触摸消失！"];
}

- (IBAction)testTip2:(id)sender {
    [self.view showTipViewAtCenter:@"出现提示内容，倒计时消失！" timer:2];
}

- (IBAction)testTip3:(id)sender {
    [self.view showTipViewAtCenter:@"出现提示内容" message:@"我是消息体,我真是消息体"];
}

- (IBAction)testTip4:(id)sender {
    [self.view showTipViewAtCenter:@"出现提示内容，只是Y位置自定义" posY:50];
}
- (IBAction)testTip5:(id)sender {
    [self.view showActivityViewAtCenter];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(tip5) userInfo:nil repeats:NO];
}
- (IBAction)testTip6:(id)sender {
    [self.view showHUDIndicatorViewAtCenter:@"走起来"];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(tip6) userInfo:nil repeats:NO];
}


- (void)tip5{
    [self.view hideActivityViewAtCenter];
    [timer invalidate];
}

- (void)tip6{
    [self.view hideHUDIndicatorViewAtCenter];
    [timer invalidate];
}
@end
