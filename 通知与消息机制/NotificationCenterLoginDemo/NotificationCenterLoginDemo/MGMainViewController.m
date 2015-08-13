//
//  MGMainViewController.m
//  NotificationCenterLoginDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#import "MGLoginViewController.h"
#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"
@interface MGMainViewController (){
    UILabel *_lbLoginInfo;
    UIButton *_btnLogin;
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100,320 ,30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor=[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    _lbLoginInfo = lable;
    [self.view addSubview:lable];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(60, 200, 200, 25);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    _btnLogin=button;
    
    [self.view addSubview:button];
}


-(void)loginOut{
    //添加监听
    [self addObserverToNotification];
    
    MGLoginViewController *loginController=[[MGLoginViewController alloc]init];
    
    [self presentViewController:loginController animated:YES completion:nil];
}

/**
 *  添加监听
 */
-(void)addObserverToNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoginInfo:) name:UPDATE_LGOGIN_INFO_NOTIFICATION object:nil];
}
/**
 *  更新登录信息,注意在这里可以获得通知对象并且读取附加信息
 */
-(void)updateLoginInfo:(NSNotification *)notification{
    NSDictionary *userInfo=notification.userInfo;
    _lbLoginInfo.text=userInfo[@"loginInfo"];
    _btnLogin.titleLabel.text=@"注销";
}

-(void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
