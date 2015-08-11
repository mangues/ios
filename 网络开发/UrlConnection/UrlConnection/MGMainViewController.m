//
//  MGMainViewController.m
//  UrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"

@interface MGMainViewController ()<NSURLConnectionDataDelegate>{
    NSMutableData *_data;//响应数据
    UITextField *_textField;
    UIButton *_button;
    UIProgressView *_progressView;
    UILabel *_label;
    long long _totalLength;
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

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    //地址栏
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 25)];
    _textField.borderStyle=UITextBorderStyleRoundedRect;
    _textField.textColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    _textField.text=@"8b82b9014a90f6038a9aa0cf3a12b31bb051ed14.jpg";
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
    [_button addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}
#pragma mark 发送数据请求
- (void) sendRequest{
    NSString *urlStr = [NSString stringWithFormat:@"http://b.hiphotos.baidu.com/image/pic/item/%@",_textField.text];
    //注意对于url中得中文是无法解析的，需要进行url编码（指定编码类型为utf-8）；
    //另外注意url解码使用stringByRemovingpercentEcoding方法
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建url连接
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request= [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0.5f];
    //创建连接
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //启动连接
    [con start];
    
}
#pragma  mark -连接代理方法
#pragma mark 开始响应
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"receive response.");

    _data = [[NSMutableData alloc]init];
    _progressView.progress = 0;
    
    //通过响应头中得Content-Length取得整个响应的总长度
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
    _totalLength = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
}


#pragma mark 接收响应数据（根据响应内容的大小此方法会被重复调用）
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"receive data.");
    //连续接收数据
    [_data appendData:data];
    //更新进度
    [self updateProgress];
}

#pragma mark 数据接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"loading finish..");
    //数据接收完保存文件（注意苹果官方要求：下载数据只能保存在缓冲目录）
    NSArray *sve = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) ;
    NSString *savePath=[sve objectAtIndex:0];//获取出路径地址
    ///NSString *savePath=[sve lastObject];
    savePath=[savePath stringByAppendingPathComponent:_textField.text];
    [_data writeToFile:savePath atomically:YES];
    NSLog(@"path:%@",savePath);
}

#pragma mark 请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //如果连接超时或者连接地址错误可能就会报错
    NSLog(@"connection error,error detail is:%@",error.localizedDescription);
}


#pragma mark 更新进度
-(void)updateProgress{
    //    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    if (_data.length==_totalLength) {
        _label.text=@"下载完成";
    }else{
        _label.text=@"正在下载...";
        [_progressView setProgress:(float)_data.length/_totalLength];
    }
    //    }];
}
@end
