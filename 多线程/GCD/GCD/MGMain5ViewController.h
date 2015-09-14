//
//  MGMain5ViewController.h
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGMain5ViewController : UIViewController
#pragma mark 图片资源存储容器
@property (atomic,strong) NSMutableArray *imageNames;

#pragma mark 当前加载的图片索引（图片链接地址连续）
@property (atomic,assign) int currentIndex;
@end
