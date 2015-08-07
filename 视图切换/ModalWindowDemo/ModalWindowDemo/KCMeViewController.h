//
//  KCMeViewController.h
//  ModalWindowDemo
//
//  Created by TTS on 15/8/7.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCMeViewController : UIViewController

#pragma mark 需要传递的属性参数（很多时候它是一个数据模型）
@property (nonatomic,copy) NSString *userInfo;
@end
