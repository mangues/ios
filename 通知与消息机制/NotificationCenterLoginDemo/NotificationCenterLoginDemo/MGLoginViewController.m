//
//  MGLoginViewController.m
//  NotificationCenterLoginDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGLoginViewController.h"

#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"
@interface MGLoginViewController (){
    UITextField *_txtUserName;
    UITextField *_txtPassword;
}

@end

@implementation MGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  UI布局
 */
-(void)setupUI{
    //用户名
    UILabel *lbUserName=[[UILabel alloc]initWithFrame:CGRectMake(50, 150, 100, 30)];
    lbUserName.text=@"用户名：";
    [self.view addSubview:lbUserName];
    
    _txtUserName=[[UITextField alloc]initWithFrame:CGRectMake(120, 150, 150, 30)];
    _txtUserName.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:_txtUserName];
    
    //密码
    UILabel *lbPassword=[[UILabel alloc]initWithFrame:CGRectMake(50, 200, 100, 30)];
    lbPassword.text=@"密码：";
    [self.view addSubview:lbPassword];
    
    _txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(120, 200, 150, 30)];
    _txtPassword.secureTextEntry=YES;
    _txtPassword.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:_txtPassword];
    
    //登录按钮
    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeSystem];
    btnLogin.frame=CGRectMake(70, 270, 80, 30);
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    [btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //取消登录按钮
    UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeSystem];
    btnCancel.frame=CGRectMake(170, 270, 80, 30);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:btnCancel];
    [btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 登录操作
-(void)login{
    if ([_txtUserName.text isEqualToString:@"mangues"] && [_txtPassword.text isEqualToString:@"123"] ) {
        //发送通知
        [self postNotification];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //登录失败弹出提示信息
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"系统信息" message:@"用户名或密码错误，请重新输入！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    }
    
}

#pragma mark 点击取消
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 添加通知
-(void) postNotification{
    NSDictionary *userInfo=@{@"loginInfo":[NSString stringWithFormat:@"Hello,%@!",_txtUserName.text]};
    NSLog(@"%@",userInfo);
    
    NSNotification *notification = [NSNotification notificationWithName:UPDATE_LGOGIN_INFO_NOTIFICATION object:self userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //也可直接采用下面的方法
    //    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LGOGIN_INFO_NOTIFICATION object:self userInfo:userInfo];
}






@end
