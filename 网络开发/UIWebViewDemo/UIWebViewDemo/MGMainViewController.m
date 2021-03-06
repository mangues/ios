//
//  MGMainViewController.m
//  UIWebViewDemo
//
//  Created by TTS on 15/8/12.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#define kFILEPOTOCOL @"file://"
@interface MGMainViewController ()<UISearchBarDelegate,UIWebViewDelegate>{
    UIWebView *_webView;
    UIToolbar *_toolbar;
    UISearchBar *_searchBar;
    UIBarButtonItem *_barButtonBack;
    UIBarButtonItem *_barButtonForward;
    
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
-(void) layoutUI{
    /********添加地址栏*****/
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    /******添加浏览器插件********/
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, 460)];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;//数据监测，例如内容中又邮件地址，点击之后可以打开邮件软件
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    /******添加下方工具栏***********/
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 524, 320, 44)];
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.bounds = CGRectMake(0, 0, 32, 32);
    [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"back_disable"] forState:UIControlStateDisabled];
    [btnBack addTarget:self action:@selector(webViewBack) forControlEvents:UIControlEventTouchUpInside];
    _barButtonBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    _barButtonBack.enabled=NO;
    
    UIBarButtonItem *btnSpacing=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIButton *btnForward=[UIButton buttonWithType:UIButtonTypeCustom];
    btnForward.bounds=CGRectMake(0, 0, 32, 32);
    [btnForward setImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
    [btnForward setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateDisabled];
    [btnForward addTarget:self action:@selector(webViewForward) forControlEvents:UIControlEventTouchUpInside];
    _barButtonForward=[[UIBarButtonItem alloc]initWithCustomView:btnForward];
    _barButtonForward.enabled=NO;
    
    _toolbar.items=@[_barButtonBack,btnSpacing,_barButtonForward];
    [self.view addSubview:_toolbar];
    
    
}

#pragma mark 设置前进后退按钮状态
-(void)setBarButtonStatus{
    if (_webView.canGoBack) {
        _barButtonBack.enabled=YES;
    }else{
        _barButtonBack.enabled=NO;
    }
    if(_webView.canGoForward){
        _barButtonForward.enabled=YES;
    }else{
        _barButtonForward.enabled=NO;
    }
}

#pragma mark 后退
-(void)webViewBack{
    [_webView goBack];
}
#pragma mark 前进
-(void)webViewForward{
    [_webView goForward];
}

#pragma mark 浏览器请求
-(void)request:(NSString *)urlStr{
    //创建url
    NSURL *url;
    //如果file://开头的字符串则加载bundle中的文件
    if([urlStr hasPrefix:kFILEPOTOCOL]){
        //取得文件名
        NSRange range  = [urlStr rangeOfString:kFILEPOTOCOL];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    }else{
        //如果是http请则直接打开网站
        if([urlStr hasPrefix:@"http"]){
            url = [NSURL URLWithString:urlStr];
        }else{//如果不符合任何协议则进行搜索
             urlStr=[NSString stringWithFormat:@"http://m.bing.com/search?q=%@",urlStr];
        }
        urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//url编码
        url=[NSURL URLWithString:urlStr];
    }
    //创建请求连接
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求页面
    //加载请求页面
    [_webView loadRequest:request];
    
}


#pragma mark - WebView 代理方法
#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载
   [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
}



#pragma mark 加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏网络请求加载图标
   [UIApplication sharedApplication].networkActivityIndicatorVisible=false;
    //设置按钮状态
    [self setBarButtonStatus];
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error detail:%@",error.localizedDescription);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"系统提示" message:@"网络连接发生错误!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}


#pragma mark - SearchBar 代理方法
#pragma mark 点击搜索按钮或回车
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self request:_searchBar.text];
}


@end
