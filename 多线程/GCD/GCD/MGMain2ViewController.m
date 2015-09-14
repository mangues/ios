//
//  MGMain2ViewController.m
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMain2ViewController.h"

@interface MGMain2ViewController ()

@end

@implementation MGMain2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    
    /*取得全局队列
     第一个参数：线程优先级
     第二个参数：标记参数，目前没有用，一般传入0
     */
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //并发队列同样是使用dispatch_queue_create()方法创建，只是最后一个参数指定为DISPATCH_QUEUE_CONCURRENT进行创
   // dispatch_queue_t global = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
        //同步执行队列
//        dispatch_sync(globalQueue, ^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        });
        
    }
}

@end
