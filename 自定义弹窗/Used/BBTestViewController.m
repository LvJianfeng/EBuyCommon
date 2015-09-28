//
//  BBTestViewController.m
//  EBuyCommon
//
//  Created by LvJianfeng on 15/9/28.
//  Copyright © 2015年 coderjianfeng. All rights reserved.
//

#import "BBTestViewController.h"
#import "BBAlertView.h"

@interface BBTestViewController () <BBAlertViewDelegate>

@end

@implementation BBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)alertOne:(id)sender {
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@"自定义弹窗一" message:@"自定义弹窗一" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert setCancelBlock:^{
        NSLog(@"Click Ok：弹窗一");
    }];
    [alert show];

}

- (IBAction)alertTwo:(id)sender {
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:@"自定义弹窗二"delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok"];
    
    [alertView setConfirmBlock:^{
        NSLog(@"Click Ok：弹窗二");
    }];
    
    [alertView show];
}

/*
 BBAlertViewStyleDefault,        //苏宁ebuy里面用
 BBAlertViewStyle1,              //图书里面用的
 BBAlertViewStyleCustomView,     //可放入自定义的view
 BBAlertViewStyleLottery,        //彩票里面使用
 BBAlertViewStyleMessageFilter   //精准营销
 */
- (IBAction)alertThree:(id)sender {
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyle1 Title:@"自定义弹窗三" message:@"自定义弹窗三" customView:nil delegate:nil cancelButtonTitle:@"Cancel"otherButtonTitles:@"Ok"];
    
    [alertView setConfirmBlock:^{
        NSLog(@"Click Ok：弹窗三");
    }];
    
    [alertView show];
}
@end
