//
//  MGMain4ViewController.m
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMain4ViewController.h"

@interface MGMain4ViewController ()

@end

@implementation MGMain4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSData *)requestData:(int )index{
    NSData *data;
    NSString *name;
    //线程同步
    @synchronized(self){
        if (_imageNames.count>0) {
            name=[_imageNames lastObject];
            [NSThread sleepForTimeInterval:0.001f];
            [_imageNames removeObject:name];
        }
    }
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}



@end
