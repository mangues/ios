//
//  KCTouchEvenViewController.m
//  MultitouchEventDemo
//
//  Created by TTS on 15/8/7.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCTouchEvenViewController.h"
#import "KCImage.h"

@interface KCTouchEvenViewController (){
    KCImage *_image;
    BOOL isTouchImageView;
}

@end

@implementation KCTouchEvenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _image = [[KCImage alloc] initWithFrame:CGRectMake(50, 50, 150, 169)];
    [self.view addSubview:_image];
    
    
    
}
#pragma mark 视图控制器的触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     //判断触摸位置是否在图片上
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    CGPoint imagePoint = _image.center;
    CGSize imageSize = _image.frame.size;
    float imageViewX = imagePoint.x - imageSize.width / 2;
    float imageViewY = imagePoint.y - imageSize.height / 2;
    
   
    if((imageViewX<current.x)&&(current.x<imageViewX+imageSize.width)&&
       (imageViewY<current.y)&&(current.y<imageViewY+imageSize.height)){
        isTouchImageView = true;
        
    }else{
        isTouchImageView = false;
    }
    
    
    NSLog(@"UIViewController start touch");
    
}
#pragma mark 持续触发触摸事件
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //取得一个触摸对象
    UITouch *touhc = [touches anyObject];
    //取得当前位置
    CGPoint current = [touhc locationInView:self.view];
    //取得前一个位置
    CGPoint previous = [touhc previousLocationInView:self.view];
    
    //移动前的中心位置
    CGPoint center = _image.center;
   
    if(isTouchImageView){
        //移动偏移量
        CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
        
        //重新设置新位置
        _image.center = CGPointMake(center.x+offset.x, center.y+offset.y);
    }
    
   
    NSLog(@"UIViewController moving...");
    
    
}

#pragma mark 移动结束
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIViewController touch end.");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
