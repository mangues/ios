//
//  MGMainViewController.m
//  UIWebView_JavaScriptDemo
//
//  Created by TTS on 15/8/12.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"

@interface MGMainViewController ()<UIWebViewDelegate>{
    UIWebView *_webView;
    
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    /*添加浏览器控件*/
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    _webView.dataDetectorTypes=UIDataDetectorTypeAll;//数据检测类型，例如内容中有邮件地址，点击之后可以打开邮件软件编写邮件
    _webView.delegate=self;
    [self.view addSubview:_webView];
}

-(void) request{
    //加载html内容
    NSString *htmlStr=@"<html>\
    <head><title>Kenshin Cui's Blog</title></head>\
    <body style=\"color:#0092FF;\">\
    <h1 id=\"header\">I am Kenshin Cui</h1>\
    <p>iOS 开发系列</p>\
    </body></html>";
    
    [_webView loadHTMLString:htmlStr baseURL:nil];  //baseURL 资源文件所在的文件
    
    
}

#pragma mark 显示actionsheet
#pragma mark 显示actionsheet
-(void)showSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitle{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [actionSheet showInView:self.view];
}

#pragma mark 代理方法
#pragma mark 页面加载前(此方法返回false 则页面不在请求）
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.scheme isEqual:@"kcactionsheet"]) {
        NSString *paramString = request.URL.query;
        NSArray *param = [[paramString stringByRemovingPercentEncoding] componentsSeparatedByString:@"&"];
        id otherButton = nil;
        if(param.count>3){
            otherButton = param[3];
        }
          [self showSheetWithTitle:param[0] cancelButtonTitle:param[1] destructiveButtonTitle:param[2] otherButtonTitles:otherButton];
         return false;
    }
    return true;
}




#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
#pragma mark 加载结束
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //获取html内容
    NSLog(@"%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
//    //修改页面内容
//    NSLog(@"%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('header').innerHTML='Kenshin Cui\\'s Blog'"]);
    //加载js文件
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MyJs.js" ofType:nil];
    NSString *jsStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js文件到页面
    [_webView stringByEvaluatingJavaScriptFromString:jsStr];
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error detail:%@",error.localizedDescription);
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接发生错误!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [aler show];
}


@end
