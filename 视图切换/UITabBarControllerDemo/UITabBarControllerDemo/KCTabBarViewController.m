//
//  KCTabBarViewController.m
//  UITabBarControllerDemo
//
//  Created by TTS on 15/8/5.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCTabBarViewController.h"
#import "KCContactViewController.h"
#import "KCWebChatViewController.h"

@interface KCTabBarViewController ()

@end

@implementation KCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    KCContactViewController *conwiew = [[KCContactViewController alloc] init];
    KCWebChatViewController *wenview = [[KCWebChatViewController alloc] init];
    //如果要显示视图则必须设置其viewControllers属性（它默认显示viewControllers[0]）。这个属性是一个数组，它维护了所有UITabBarController的子视图。
    self.viewControllers = @[conwiew,wenview];
    
    //注意默认情况下UITabBarController在加载子视图时是懒加载的，所以这里调用一次contactController，否则在第一次展示时只有第一个控制器tab图标，contactController的tab图标不会显示
    for (UIViewController *controller in self.viewControllers) {
        UIViewController *view = controller.view;
    }

    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
