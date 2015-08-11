


//
//  KCMainViewController.m
//  ModalWindowDemo
//
//  Created by TTS on 15/8/6.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCLoginViewController.h"
#import "KCMeViewController.h"

@interface KCMainViewController ()<KCMainDelegate,UIActionSheetDelegate>{
    UILabel *_loginInfo;
    UIBarButtonItem *_loginButton;
    BOOL _isLogon;
    
}

@end




@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addNavigationBar];
     [self addLoginInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 添加信息显示
-(void)addLoginInfo{
    _loginInfo =[[UILabel alloc]initWithFrame:CGRectMake(0, 100,320 ,30)];
    _loginInfo.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_loginInfo];
}

#pragma mark 添加导航栏
-(void)addNavigationBar{
    UINavigationBar *navi = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44+20)];
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    //创建导航控件内容
    UINavigationItem *navm = [[UINavigationItem alloc] initWithTitle:@"web Chat"];
    //左侧添加登陆按钮
     _loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    navm.leftBarButtonItem = _loginButton;
    //添加内容到导航栏
    [navi pushNavigationItem:navm animated:NO];
    
    //右侧添加按钮
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"我" style:UIBarButtonItemStyleDone target:self action:@selector(showInfo)];
    navm.rightBarButtonItem = myButton;
    
    
}

#pragma mark 登录操作
-(void)login{
    if (!_isLogon) {
        KCLoginViewController *loginController=[[KCLoginViewController alloc]init];
        loginController.delegate=self;//设置代理
        //调用此方法显示模态窗口
        [self presentViewController:loginController animated:YES completion:nil];
    }else{
        //如果登录之后则处理注销的情况
        //注意当前视图控制器必须实现UIActionSheet代理才能进行操作
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"系统信息" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles: nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark 点击查看我的信息
-(void)showInfo{
    if (_isLogon) {
        KCMeViewController *meController=[[KCMeViewController alloc]init];
        meController.userInfo=_loginInfo.text;
        [self presentViewController:meController animated:YES completion:nil];
    }
}


#pragma mark 实现代理方法
-(void)showUserInfoWithUserName:(NSString *)userName{
    _isLogon=YES;
    //显示登录用户的信息
    _loginInfo.text=[NSString stringWithFormat:@"Hello,%@!",userName];
    //登录按钮内容改为“注销”
    _loginButton.title=@"注销";
}

#pragma mark 实现注销方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//注销按钮
        _isLogon=NO;
        _loginButton.title=@"登录";
        _loginInfo.text=@"";
    }
}

@end
