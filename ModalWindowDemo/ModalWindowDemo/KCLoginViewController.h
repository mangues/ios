//
//  KCLoginViewController.h
//  ModalWindowDemo
//
//  Created by TTS on 15/8/6.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCMainDelegate;
@interface KCLoginViewController : UIViewController
#pragma mark 定义代理
@property (nonatomic,strong) id<KCMainDelegate> delegate;
@end
