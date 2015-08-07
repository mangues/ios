//
//  KCWebChatViewController.m
//  UITabBarControllerDemo
//
//  Created by TTS on 15/8/5.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCWebChatViewController.h"

@interface KCWebChatViewController ()

@end

@implementation KCWebChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"Chat";
    //注意通过tabBarController或者parentViewController可以得到其俯视图控制器（也就是KCTabBarViewController）
    NSLog(@"%i",self.tabBarController==self.parentViewController);//对于当前应用二者相等
    self.tabBarItem.title = @"Web Chat";//注意如果这个标题不设置默认在页签上显示视图控制器标题
    
    //tabBarItem的image属性必须是png格式（建议大小32*32）并且打开alpha通道否则无法正常显示。ß
    self.tabBarItem.image = [UIImage imageNamed:@"web.png"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"caat.png"];
    
    
    
    
    
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
