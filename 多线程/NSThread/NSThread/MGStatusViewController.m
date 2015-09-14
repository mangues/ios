//
//  MGMuViewController.m
//  NSThread
//
//  Created by TTS on 15/9/10.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGStatusViewController.h"
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT ROW_COUNT*COLUMN_COUNT
@interface MGStatusViewController (){
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
    NSMutableArray *_threads;
}

@end
@implementation MGStatusViewController
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
    
    //加载按钮
    UIButton *buttonStart=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonStart.frame=CGRectMake(50, 500, 100, 25);
    [buttonStart setTitle:@"加载图片" forState:UIControlStateNormal];
    [buttonStart addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStart];
    
    //停止按钮
    UIButton *buttonStop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonStop.frame=CGRectMake(160, 500, 100, 25);
    [buttonStop setTitle:@"停止加载" forState:UIControlStateNormal];
    [buttonStop addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];
    
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
     for (int i=0; i<IMAGE_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    
    
}



#pragma mark 多线程下载图片
- (void)loadImageWithMultiThread{
     _threads=[NSMutableArray array];
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
        
        [_threads addObject:thread];
    }
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        NSThread *thread=_threads[i];
        [thread start];
    }
    
}

#pragma mark 加载图片
- (void)loadImage:(NSNumber *)index{
    NSLog(@"%@",index);
    //currentThread方法可以获取当前操作线程
    int i = [index intValue];
    NSData *data= [self requestData:i];
    
    NSThread *currentThread=[NSThread currentThread];
     NSLog(@"currentThread：%@",currentThread);
    //    如果当前线程处于取消状态，则退出当前线程
    if (currentThread.isCancelled) {
        NSLog(@"thread(%@) will be cancelled!",currentThread);
       [NSThread exit];//取消当前线程
    }
    
    
    KCImageData *imageData=[[KCImageData alloc]init];
    imageData.index=i;
    imageData.data=data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}

#pragma mark 请求图片数据
- (NSData*)requestData:(int) index{
    //对非最后一张图片加载线程休眠2秒
    if (index!=(ROW_COUNT*COLUMN_COUNT-1)) {
        [NSThread sleepForTimeInterval:2.0];
    }
    NSURL *url=[NSURL URLWithString:_imageNames[index]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}
#pragma mark 将图片显示到界面
-(void)updateImage:(KCImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.data];
    UIImageView *imageView= _imageViews[imageData.index];
    imageView.image=image;
}

#pragma mark 停止加载图片
-(void)stopLoadImage{
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        NSThread *thread= _threads[i];
        //判断线程是否完成，如果没有完成则设置为取消状态
        //注意设置为取消状态仅仅是改变了线程状态而言，并不能终止线程
        if (!thread.isFinished) {
            [thread cancel];
            NSLog(@"cellen");
            
        }
    }
}
@end
