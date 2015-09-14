//
//  KCLoginViewController.h
//  ModalWindowDemo
//
//  Created by TTS on 15/8/6.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark 定义一个协议用于参数传递
@protocol KCMainDelegate
-(void)showUserInfoWithUserName:(NSString *)userName;
@end

@interface KCLoginViewController : UIViewController
#pragma mark 定义代理
@property (nonatomic,strong) id<KCMainDelegate> delegate;
@end
