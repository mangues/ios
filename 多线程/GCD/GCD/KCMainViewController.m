//
//  KCMainViewController.m
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCMainViewController.h"

@interface KCMainViewController ()

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    
}


#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    int count = ROW_COUNT*COLUMN_COUNT;
    /**
     *  @author mangues, 15-09-14 09:09:43
     *
     *  创建一个串行队列
     *  第一个参数：队列名称
     *  第二个参数：队列类型
     */
    dispatch_queue_t serialQueue = dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);  //注意queue对象 不是指针类型
    //创建多个线程填充图片
    for (int i = 0 ; i<count;i++) {
        //异步执行队列任务
        dispatch_async(serialQueue, ^{
             [self loadImage:[NSNumber numberWithInt:i]];
        });
     }
    
    //非ARC环境请释放
    //    dispatch_release(seriQueue);
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    
    //如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
    NSLog(@"thread is :%@",[NSThread currentThread]);
    
    int i=[index intValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //UI界面的更新最好采用同步方法，其他操作采用异步方法
    dispatch_sync(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
    
//    dispatch_async(mainQueue, ^{
//        [self updateImageWithData:data andIndex:i];
//    });
    
}



#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    NSURL *url=[NSURL URLWithString:_imageNames[index]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    return data;
}
@end
