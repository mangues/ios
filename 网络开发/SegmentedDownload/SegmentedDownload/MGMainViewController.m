//
//  MGMainViewController.m
//  SegmentedDownload
//
//  Created by TTS on 15/8/12.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#define kUrl @"http://b.hiphotos.baidu.com/image/pic/item"
#define kFILE_BLOCK_SIZE (1024*5) //每次1KB

@interface MGMainViewController ()<NSURLConnectionDataDelegate>{
    UITextField *_textField;
    UIButton *_button;
    UIProgressView *_progressView;
    UILabel *_label;
    long long _totalLength;   //文件总大小
    long long _loadedLength;   //以下载大小
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    //地址栏
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 25)];
    _textField.borderStyle=UITextBorderStyleRoundedRect;
    _textField.textColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    _textField.text=@"d4628535e5dde711913af37aa4efce1b9c166155.jpg";
    //    _textField.text=@"1.jpg";
    [self.view addSubview:_textField];
    //进度条
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(10, 100, 300, 25)];
    [self.view addSubview:_progressView];
    //状态显示
    _label=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 300, 25)];
    _label.textColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    [self.view addSubview:_label];
    //下载按钮
    _button=[[UIButton alloc]initWithFrame:CGRectMake(10, 500, 300, 25)];
    [_button setTitle:@"下载" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(downloadFileAsync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
}

#pragma mark 更新进度
-(void)updateProgress{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (_loadedLength==_totalLength) {
            _label.text=@"下载完成";
        }else{
            _label.text=@"正在下载...";
        }
        [_progressView setProgress:(double)_loadedLength/_totalLength];
    }];
}

#pragma mark 获取请求地址
-(NSURL *) obtainDownloadUrl:(NSString *)fileName{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",kUrl,fileName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

#pragma mark 获取保存地址(保存在沙盒缓存目录)
-(NSString *)obtainSavePath:(NSString *)fileName{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *returnPath = [path stringByAppendingPathComponent:fileName];
    NSLog(returnPath);
    return returnPath;
}

#pragma mark 取得文件大小
-(long long)obtainFileTotallength:(NSString *)fileName{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self obtainDownloadUrl:fileName] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0f];
    //设置位头信息请求
    [request setHTTPMethod:@"HEAD"];
    
    NSURLResponse *response;
    NSError *error;
    //注意这里使用了同步请求，直接将文件大小返回
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if(connectionError){
//            NSLog(@"detail error:%@",error.localizedDescription);
//        }
//    }];
    if(error){
        NSLog(@"detail error:%@",error.localizedDescription);
    }
    //获取内容长度
    return response.expectedContentLength;
}
#pragma mark 文件下载
- (void)downloadFile{
    _totalLength = [self obtainFileTotallength:_textField.text];
    _loadedLength = 0;
    long long startSize = 0;
    long long endSize = 0;
    //分段下载
    while (startSize<_totalLength) {
        endSize = startSize + kFILE_BLOCK_SIZE - 1;
        if (endSize>_totalLength) {
            endSize = _totalLength - 1;
        }
        
        [self downloadFile:_textField.text startByte:startSize endByte:endSize];
  
    //更新进度
    _loadedLength+=(endSize-startSize)+1;
    [self updateProgress];
    
    
    startSize+=kFILE_BLOCK_SIZE;
    
      }
    
}

#pragma mark 下载指定大小快得数据
-(void)downloadFile:(NSString *)fileName startByte:(long long)start endByte:(long long)end{
    NSString *range = [NSString stringWithFormat:@"Bytes=%lld-%lld",start,end];
    NSLog(@"%@",range);
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[self obtainDownloadUrl:fileName] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0f];
    [request setValue:range forHTTPHeaderField:@"Range"];   //通过请求头设置数据请求范围
    
    NSURLResponse *respone;
    NSError *error;
    //这里通过使用同步请求，避免文件追加顺序错误
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&error];
    if(!error){
        NSLog(@"dataLength=%lld",(long long)data.length);
        [self fileAppend:[self obtainSavePath:fileName] data:data];
    }
    else{
        NSLog(@"detail error:%@",error.localizedDescription);
    }

}

#pragma mark 文件追加
-(void) fileAppend:(NSString *)filePath data:(NSData *)data{
 //以可写方式打开
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    //如果存在文件则追加，否则创建
    if (fileHandle) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }else{
        [data writeToFile:filePath atomically:YES];//创建文
    }
    
    
}
#pragma mark 异步下载文件
-(void)downloadFileAsync{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadFile];
    });
}

@end
