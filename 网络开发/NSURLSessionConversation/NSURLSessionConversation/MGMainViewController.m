//
//  MGMainViewController.m
//  NSURLSessionConversation
//
//  Created by TTS on 15/8/12.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"

@interface MGMainViewController ()<NSURLSessionDownloadDelegate>{
    UITextField *_textField;
    UIProgressView *_progressView;
    UILabel *_label;
    UIButton *_btnDownload;
    UIButton *_btnCancel;
    UIButton *_btnSuspend;
    UIButton *_btnResume;
    NSURLSessionDownloadTask *_downloadTask;
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 界面布局
-(void)layoutUI{
    //地址栏
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 25)];
    _textField.borderStyle=UITextBorderStyleRoundedRect;
    _textField.textColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    _textField.text=@"p519.pdf";
    [self.view addSubview:_textField];
    //进度条
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(10, 100, 300, 25)];
    [self.view addSubview:_progressView];
    //状态显示
    _label=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 300, 25)];
    _label.textColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    [self.view addSubview:_label];
    //下载按钮
    _btnDownload=[[UIButton alloc]initWithFrame:CGRectMake(20, 500, 50, 25)];
    [_btnDownload setTitle:@"下载" forState:UIControlStateNormal];
    [_btnDownload setTitleColor:[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_btnDownload addTarget:self action:@selector(downloadFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnDownload];
    //取消按钮
    _btnCancel=[[UIButton alloc]initWithFrame:CGRectMake(100, 500, 50, 25)];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel setTitleColor:[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCancel];
    //挂起按钮
    _btnSuspend=[[UIButton alloc]initWithFrame:CGRectMake(180, 500, 50, 25)];
    [_btnSuspend setTitle:@"挂起" forState:UIControlStateNormal];
    [_btnSuspend setTitleColor:[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_btnSuspend addTarget:self action:@selector(suspendDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSuspend];
    //恢复按钮
    _btnResume=[[UIButton alloc]initWithFrame:CGRectMake(260, 500, 50, 25)];
    [_btnResume setTitle:@"恢复" forState:UIControlStateNormal];
    [_btnResume setTitleColor:[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_btnResume addTarget:self action:@selector(resumeDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnResume];
}
#pragma mark 设置界面状态
-(void)setUIStatus:(int64_t)totalBytesWritten expectedToWrite:(int64_t)totalBytesExpectedToWrite{
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress=(float)totalBytesWritten/totalBytesExpectedToWrite;
        if (totalBytesWritten==totalBytesExpectedToWrite) {
            _label.text=@"下载完成";
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            _btnDownload.enabled=YES;
        }else{
            _label.text=@"正在下载...";
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        }
    });
}
#pragma mark 文件下载
-(void)downloadFile{
    //1.创建url
    NSString *fileName=_textField.text;
    NSString *urlStr=[NSString stringWithFormat: @"http://www.ra.ethz.ch/cdstore/www10/papers/pdf/%@",fileName];
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //3.创建会话
    //默认会话
  //  NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
  //  sessionConfig.timeoutIntervalForRequest=5.0f;//请求超时时间
   // sessionConfig.allowsCellularAccess=true;//是否允许蜂窝网络下载（2G/3G/4G）
    //创建会话
   // NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];//指定配置和代理
    //_downloadTask=[session downloadTaskWithRequest:request];
    
    //后台会话
    _downloadTask=[[self backgroundSession] downloadTaskWithRequest:request];
  
    
    [_downloadTask resume];
}

#pragma mark 取消下载
-(void)cancelDownload{
    [_downloadTask cancel];
    
}
#pragma mark 挂起下载
-(void)suspendDownload{
    [_downloadTask suspend];
}
#pragma mark 恢复下载下载
-(void)resumeDownload{
    [_downloadTask resume];
}



#pragma mark -下载任务代理
#pragma mark 下载中（会多次调用，可以记录下载进度）
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    [self setUIStatus:totalBytesWritten expectedToWrite:totalBytesExpectedToWrite];
}


#pragma mark 下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSError *error;
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath=[cachePath stringByAppendingPathComponent:_textField.text];
    NSLog(@"%@",savePath);
    NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
    if (error) {
        NSLog(@"Error is:%@",error.localizedDescription);
    }
}

#pragma mark 任务完成，不管是否下载成功
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    [self setUIStatus:0 expectedToWrite:0];
    if (error) {
        NSLog(@"Error is:%@",error.localizedDescription);
    }
}



#pragma mark 取得一个后台会话（保证一个后台会话，这通常很有必要）
-(NSURLSession *)backgroundSession{
    static NSURLSession *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cmjstudio.URLSession"];
        sessionConfig.timeoutIntervalForRequest = 5.0f;//请求超时时间
        sessionConfig.discretionary = YES;//系统自动选择最佳网络下载
        sessionConfig.HTTPMaximumConnectionsPerHost = 5;//限制每次最多一个连接
        //创建会话
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil]; //指定配置和代理
    });
    return session;
    
    
}

@end
