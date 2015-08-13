//
//  MGMainViewController.m
//  NotificationCenterDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"

@interface MGMainViewController ()

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverToNotificationCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 添加监听
-(void)addObserverToNotificationCenter{
    /*添加应用程序进入后台监听
     *observer:坚监听者
     *selector:监听方法（监听者监听到通知后执行的方法）
     *name:监听的通知名称(下面的UIApplicationDidEnterBackgroundNotification是一个常量)
     *object ：通知的发送者（如果指定nil则监听任何对象发送的通知）
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    
    /* 添加应用程序获得焦点的通知监听
     * name:监听的通知名称
     * object:通知的发送者（如果指定nil则监听任何对象发送的通知）
     * queue:操作队列，如果制定非主队线程队列则可以异步执行block
     * block:监听到通知后执行的操作
     */
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication] queue:operationQueue usingBlock:^(NSNotification *note) {
        NSLog(@"Application become active.");
    }];
    
 
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication] queue:operationQueue usingBlock:^(NSNotification *note) {
//        NSLog(@"Application become background.");
//    }];
//    
    
}

#pragma mark 应用程序启动监听方法
-(void)applicationEnterBackground{
    NSLog(@"Application enter background.");
}
@end
