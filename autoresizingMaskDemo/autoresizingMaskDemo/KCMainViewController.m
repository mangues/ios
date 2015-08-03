//
//  KCMainViewController.m
//  autoresizingMaskDemo
//
//  Created by TTS on 15/7/31.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCMainViewController.h"

@interface KCMainViewController (){
    UIButton *_btn; //私有变量
}
@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdate];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    }


//typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
//    UIViewAutoresizingNone                 = 0,      //不进行自动调整
//    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0, //自动调整与superview左侧距离，右侧距离保持不变
//    UIViewAutoresizingFlexibleWidth        = 1 << 1, //自动调整控件自身宽度，保证与superview左右距离不变
//    UIViewAutoresizingFlexibleRightMargin  = 1 << 2, //自动调整与superview右侧距离，左侧距离保持不变
//    UIViewAutoresizingFlexibleTopMargin    = 1 << 3, //自动调整与superview顶部距离，底部距离保持不变
//    UIViewAutoresizingFlexibleHeight       = 1 << 4, //自动调整控件自身高度，保证与superview上下距离不变
//    UIViewAutoresizingFlexibleBottomMargin = 1 << 5  //自动调整与superview底部距离，顶部距离保持不变
//};




-(void) initdate{
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 100, 200, 50)];
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn setTitle:@"登陆" forState:UIControlStateNormal];
    _btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:_btn];
    
}


#pragma mark 屏幕旋转事件
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"%@",NSStringFromCGRect(_btn.frame));
}

@end
