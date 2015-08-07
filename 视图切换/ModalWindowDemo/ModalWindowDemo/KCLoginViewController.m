//
//  KCLoginViewController.m
//  ModalWindowDemo
//
//  Created by TTS on 15/8/6.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCLoginViewController.h"
#import "KCMainViewController.h"

@interface KCLoginViewController ()

@end

@implementation KCLoginViewController{
    UITextField *_txtUserName;
    UITextField *_txtPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLoginForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)addLoginForm{
    UILabel *lbUserName = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
    lbUserName.text = @"用户名：";
    [self.view addSubview:lbUserName];
    _txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(120, 150, 150, 30)];
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
    btnLogin.frame=CGRectMake(120, 270, 80, 30);
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    [btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];}
#pragma mark 登录操作
-(void)login{
    if ([_txtUserName.text isEqualToString:@"mangues"] && [_txtPassword.text isEqualToString:@"123"] ) {
        //调用代理方法传参
        [self.delegate showUserInfoWithUserName:_txtUserName.text];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        //登录失败弹出提示信息
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"系统信息" message:@"用户名或密码错误，请重新输入！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    }
    
}

#pragma mark 点击取消
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
