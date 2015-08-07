//
//  KCImage.m
//  MultitouchEventDemo
//
//  Created by TTS on 15/8/7.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCImage.h"

@implementation KCImage

//这边是重写，不需要在.h中定义
-(instancetype) initWithFrame:(CGRect) frame{
    self = [super initWithFrame:frame];
    if(self){
        UIImage * img = [UIImage imageNamed:@"1.jpg"];
//        [self setBackgroundColor:[UIColor colorWithPatternImage:img]];
        [self setImage:img];
    }
    return self;
}

#pragma mark - UIView的触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIView start touch...");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"UIView moving...");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIView touch end.");
}
@end
