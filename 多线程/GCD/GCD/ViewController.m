//
//  ViewController.m
//  GCD
//
//  Created by TTS on 15/9/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "ViewController.h"
#import "KCMainViewController.h"
#import "MGMain2ViewController.h"
#import "MGMain3ViewController.h"
#import "MGMain4ViewController.h"
#import "MGMain5ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50,200, 220, 25);
    [button setTitle:@"串行队列" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(50, 300, 220, 25);
    [button2 setTitle:@"并发队列" forState:UIControlStateNormal];
    //添加方法
    [button2 addTarget:self action:@selector(loadImageWithMultiThread2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame=CGRectMake(50, 400, 220, 25);
    [button3 setTitle:@"NSLock" forState:UIControlStateNormal];
    //添加方法
    [button3 addTarget:self action:@selector(loadImageWithMultiThread3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame=CGRectMake(50, 500, 220, 25);
    [button4 setTitle:@"@synchronized" forState:UIControlStateNormal];
    //添加方法
    [button4 addTarget:self action:@selector(loadImageWithMultiThread4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    UIButton *button5=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button5.frame=CGRectMake(50, 600, 220, 25);
    [button5 setTitle:@"扩展--控制线程通信" forState:UIControlStateNormal];
    //添加方法
    [button5 addTarget:self action:@selector(loadImageWithMultiThread5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
}

- (void)loadImageWithMultiThread{
    KCMainViewController *all = [[KCMainViewController alloc ] init];
    [self.navigationController pushViewController:all animated:YES];
}

- (void)loadImageWithMultiThread2{
    MGMain2ViewController *all = [[MGMain2ViewController alloc ] init];
    [self.navigationController pushViewController:all animated:YES];
}

- (void)loadImageWithMultiThread3{
    MGMain3ViewController *all = [[MGMain3ViewController alloc ] init];
    [self.navigationController pushViewController:all animated:YES];
}

- (void)loadImageWithMultiThread4{
    MGMain4ViewController *all = [[MGMain4ViewController alloc ] init];
    [self.navigationController pushViewController:all animated:YES];
}

- (void)loadImageWithMultiThread5{
    MGMain5ViewController *all = [[MGMain5ViewController alloc ] init];
    [self.navigationController pushViewController:all animated:YES];
}
@end
