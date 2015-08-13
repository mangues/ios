//
//  MGMainViewController.m
//  NetWorkStatusDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#import "AFNetworking.h"
@interface MGMainViewController ()

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self checkNetWorkStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
#pragma mark 网络状态变化提示
-(void)alert:(NSString *)message{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"System Info" message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alertView show];
}



#pragma mark 网络状态监测
-(void)checkNetWorkStatus{
    //创建一个用于测试的url
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *operationManger = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    //根据不同的网络状态改变去做响应的处理
    [operationManger.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self alert:@"2G/3G/4G Connection."];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self alert:@"WiFi Connection."];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self alert:@"NetWork not found."];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [self alert:@"UnKnown."];
                break;
            default:
                break;
            
        }
    }];
    //开始监控
    [operationManger.reachabilityManager startMonitoring];
    
}

@end
