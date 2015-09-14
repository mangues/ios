//
//  MGMainViewController.m
//  NSThread
//
//  Created by TTS on 15/9/10.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#import "KCMainViewController.h"
#import "MGMuViewController.h"
#import "MGPriorityViewController.h"
#import "MGStatusViewController.h"

@implementation MGMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
}
#pragma mark 界面布局
-(void)layoutUI{

    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 400, 220, 25);
    [button setTitle:@"加载一张图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(push1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(50, 440, 220, 25);
    [button2 setTitle:@"加载好多张图片" forState:UIControlStateNormal];
    //添加方法
    [button2 addTarget:self action:@selector(push2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame=CGRectMake(50, 480, 220, 25);
    [button3 setTitle:@"加载好多张图片,优先级" forState:UIControlStateNormal];
    //添加方法
    [button3 addTarget:self action:@selector(push3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame=CGRectMake(50, 520, 220, 25);
    [button4 setTitle:@"加载好多张图片,线程状态" forState:UIControlStateNormal];
    //添加方法
    [button4 addTarget:self action:@selector(push4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}




- (void)push1{
    KCMainViewController *controller = [[KCMainViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)push2{
    MGMuViewController *controller = [[MGMuViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)push3{
    MGPriorityViewController *controller = [[MGPriorityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)push4{
    MGStatusViewController *controller = [[MGStatusViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
