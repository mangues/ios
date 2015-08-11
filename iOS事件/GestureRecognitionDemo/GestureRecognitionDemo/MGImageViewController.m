//
//  MGImageViewController.m
//  GestureRecognitionDemo
//
//  Created by TTS on 15/8/10.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGImageViewController.h"

@interface MGImageViewController (){
    UIImageView *_imageView;
}
@end

@implementation MGImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加图片控件
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat topPadding = 20;
    CGFloat y = 22 + 44 + topPadding, height = screenSize.height - y -topPadding;
    
    CGRect imageFrame = CGRectMake(0, y, screenSize.width, height);

    _imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    _imageView.contentMode = UIViewContentModeScaleToFill;   //设置内容模式为缩放填充
    _imageView.userInteractionEnabled = YES;//这里必须设置YES，否则无法接接收手势操作
    [self.view addSubview:_imageView];
    _imageView.image = _image;

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
