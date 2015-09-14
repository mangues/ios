//
//  MGMuViewController.m
//  NSThread
//
//  Created by TTS on 15/9/10.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMuViewController.h"
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
@interface MGMuViewController (){
    NSMutableArray *_imageViews;
}

@end
@implementation MGMuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;   //取消导航栏影响
    [self layoutUI];
}
#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}



#pragma mark 多线程下载图片
- (void)loadImageWithMultiThread{
     NSMutableArray *threads=[NSMutableArray array];
    //创建多个线程用于填充图片
    for (int i =0; i<ROW_COUNT*COLUMN_COUNT; i++) {
//        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
        
        
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name = [NSString stringWithFormat:@"myThread%i",i];
        //设立优先级
        if (i==(ROW_COUNT*COLUMN_COUNT-1)) {
            thread.threadPriority = 1.0;
        }else{
            thread.threadPriority = 0.0;
        }
        [thread start];
    }
}

#pragma mark 加载图片
- (void)loadImage:(NSNumber *)index{
    NSLog(@"%@",index);
    //currentThread方法可以获取当前操作线程
    NSLog(@"currentThread：%@",[NSThread currentThread]);
    int i = [index intValue];
    NSData *data= [self requestData:i];
    
    KCImageData *imageData=[[KCImageData alloc]init];
    imageData.index=i;
    imageData.data=data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}





#pragma mark 请求图片数据
- (NSData*)requestData:(int) index{
    NSURL *url=[NSURL URLWithString:@"http://img.firefoxchina.cn/2015/09/8/201509100911110.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}
#pragma mark 将图片显示到界面
-(void)updateImage:(KCImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.data];
    UIImageView *imageView= _imageViews[imageData.index];
    imageView.image=image;
}


@end
