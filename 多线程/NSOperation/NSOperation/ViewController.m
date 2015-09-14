//
//  ViewController.m
//  NSOperation
//
//  Created by TTS on 15/9/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "ViewController.h"
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *_imageViews;
NSMutableArray *_imageNames;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<15; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }    
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operatoion = [[NSOperationQueue alloc] init];
    operatoion.maxConcurrentOperationCount = 5;  //设置最大并发量
    
    NSBlockOperation *lastBlockOperation=[NSBlockOperation blockOperationWithBlock:^{
        [self loadImage:[NSNumber numberWithInt:(count-1)]];
    }];
    for (int i = 0; i<count-1; i++) {
        //方法一，创建操作块添加到队列
        //创建多线程操作
        NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
            [self loadImage:[NSNumber numberWithInt:i]];
        }];
         //设置依赖操作为最后一张图片加载操作
        [block addDependency:lastBlockOperation];
        
        [operatoion addOperation:block];
        
        //方法二
//        [operatoion addOperationWithBlock:^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        }];
    }
    
    //将最后一个图片的加载操作加入线程队列
    [operatoion addOperation:lastBlockOperation];
}




#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    NSURL *url=[NSURL URLWithString:_imageNames[index]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    return data;
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    int i=[index intValue];
    
    //请求数据
    NSData *data= [self requestData:i];
    NSLog(@"%@",[NSThread currentThread]);
    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程）
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateImageWithData:data andIndex:i];
    }];
}



#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}



@end
