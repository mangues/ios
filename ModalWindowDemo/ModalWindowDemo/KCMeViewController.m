//
//  KCMeViewController.m
//  ModalWindowDemo
//
//  Created by TTS on 15/8/7.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCMeViewController.h"

@interface KCMeViewController (){
    UILabel *_lbUserInfo;
}

@end

@implementation KCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lbUserInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 100,320 ,30)];
    _lbUserInfo.textAlignment = NSTextAlignmentCenter;
    _lbUserInfo.textColor = [UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
     [self.view addSubview:_lbUserInfo];
    
    //关闭按钮
    UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeSystem];
    btnClose.frame=CGRectMake(110, 200, 100, 30);
    [btnClose setTitle:@"关闭" forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
    
    //设置传值信息
    _lbUserInfo.text=_userInfo;
    
}

#pragma mark 关闭
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
