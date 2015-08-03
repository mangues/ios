//
//  KCTransformViewController.m
//  transform
//
//  Created by TTS on 15/8/3.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCTransformViewController.h"
//定义rgb颜色
#define NORMAL_COLOR [UIColor colorWithRed:75/255.0 green:160/255.0 blue:253/255.0 alpha:1]
#define HIGHLIGHTED_COLOR [UIColor colorWithRed:197/255.0 green:221/225.0 blue:249/225.0 alpha:1]

typedef void(^ ButtonHandle)();
@interface KCTransformViewController (){
    UIImageView *_image;    //图片
    UIButton *_butten1;  //旋转按钮
    UIButton *_butten2;  //缩放按钮
    UIButton *_butten3;  //移动按钮
}

@end

@implementation KCTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initImageView];
    [self initButton1];
    [self initButton2];
    [self initButton3];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initImageView {
    //直接使用图片名称，系统会自动到资源文件中找到对应的文件
    UIImage *img = [UIImage imageNamed:@"image.jpg"];
    //如果使用initWithImage进行初始化则控件大小会自动设置成图片大小
    _image = [[UIImageView alloc] initWithImage:img];
    _image.frame = CGRectMake(20, 80, 280, 154);
    //设置内容填充模式为等比例填充
    _image.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:_image];

}
#pragma mark 添加旋转按钮
-(void)initButton1{
    _butten1 = [self getButton];
    _butten1.frame = CGRectMake(20, 400, 280, 30);
    [_butten1 setTitle:@"旋转" forState:UIControlStateNormal];
    //添加点击时间
    [_butten1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:_butten1];
}

#pragma mark 添加缩放按钮
-(void)initButton2{
    //在上面一个按钮位置的基础上确认当前位置
    CGRect scaleButtonFrame=_butten1.frame;
    scaleButtonFrame.origin.y+=40;
    _butten2 = [self getButton];
    _butten2.frame=scaleButtonFrame;
    [_butten2 setTitle:@"缩放" forState:UIControlStateNormal];
    [_butten2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_butten2];
}

#pragma mark 添加移动按钮
-(void)initButton3{
    CGRect button2_rect = _butten2.frame;
    button2_rect.origin.y+=40;
    _butten3 = [self getButton];
    _butten3.frame = button2_rect;
    [_butten3 setTitle:@"移动" forState:UIControlStateNormal];
    [_butten3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_butten3];
}


#pragma mark 图片旋转方法,注意参数中的btn表示当前点击按钮
-(void)button1Click:(UIButton *)btn{
    [self animation:^{
        //注意旋转角度必须是弧度，不是角度
        CGFloat angle=M_PI_4;//M开头的宏都是和数学（Math）相关的宏定义，M_PI_4表示四分之派，M_2_PI表示2派
        //使用CGAffineTransformMakeRotation获得一个旋转角度形变
        //但是需要注意tranform的旋转不会自动在原来的角度上进行叠加，所以下面的方法旋转一次以后再点击按钮不会旋转了
        //_imageView.transform=CGAffineTransformMakeRotation(angle);
        //利用CGAffineTransformRotate在原来的基础上产生一个新的角度(当然也可以定义一个全局变量自己累加)
         _image.transform=CGAffineTransformRotate(_image.transform, angle);
        
    }];
    
    
}

#pragma mark 缩放图片
-(void)button2Click:(UIButton *)btn{
//    [self animation:^{
//        CGFloat scalleOffset = 0.9;
//        //_image.transform = CGAffineTransformMakeScale(scalleOffset, scalleOffset);
//       _image.transform = CGAffineTransformScale(_image.transform, scalleOffset,scalleOffset);
//        
//
//    
//    }];
    
    
    //通常我们使用UIView的静态方法实现动画而不是自己写一个方法
    [UIView animateWithDuration:0.5 animations:^{
         CGFloat scalleOffset = 0.9;
        _image.transform = CGAffineTransformScale(_image.transform, scalleOffset,scalleOffset);
    }];
}

#pragma mark 图片移动方法
-(void)button3Click:(UIButton *)btn{
//    [self animation:^{
//    
//        CGFloat tr = 50;
//        _image.transform = CGAffineTransformTranslate(_image.transform, 0, tr);
//    
//    
//    
//    
//    }];
    [UIView animateWithDuration:0.5 animations:^{
    
        CGFloat rt = 50;
        _image.transform = CGAffineTransformMakeTranslation(0, rt);
    
    } ];
    
    
}



#pragma mark 动画执行方法，注意这里可以使用UIView的animateWithDuration方法代替这里只是为了演示
-(void) animation:(ButtonHandle)handle{
    //开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
    [UIView beginAnimations:@"animation" context:nil];
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    handle();
    //执行动画操作
    [UIView commitAnimations];
}


#pragma mark 取得一个按钮,统一按钮样式
-(UIButton *)getButton{
    UIButton *button = [[UIButton alloc] init];
    //设置正常状态下的字体颜色
    [button setTitleColor:NORMAL_COLOR forState:UIControlStateNormal];
    //设置高亮下得字体颜色
    [button setTitleColor:HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    return button;
}



@end
