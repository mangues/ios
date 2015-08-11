//
//  KCShakeViewController.m
//  SportsEventDemo
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGShakeViewController.h"
#import "MGImageView.h"

@interface MGShakeViewController (){
     MGImageView *_imageView;
}

@end

@implementation MGShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 视图显示时让控件变成第一响应者
-(void)viewDidAppear:(BOOL)animated{
    _imageView=[[MGImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _imageView.userInteractionEnabled=true;
    [self.view addSubview:_imageView];
    [_imageView becomeFirstResponder];
}

#pragma mark 视图不显示时注销控件第一响应者的身份
-(void)viewDidDisappear:(BOOL)animated{
    [_imageView resignFirstResponder];
}

@end
