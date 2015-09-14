//
//  MGMain3ViewController.m
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMain3ViewController.h"

@interface MGMain3ViewController ()

@end

@implementation MGMain3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化锁对象
    _lock=[[NSLock alloc]init];
   
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    NSData *data;
    NSString *name;
    //加锁
    [_lock lock];
    if (_imageNames.count>0) {
        name=[_imageNames lastObject];
        [_imageNames removeObject:name];
    }
    //使用完解锁
    [_lock unlock];
    if (name) {
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}


@end
