//
//  KCContactViewController.m
//  UITabBarControllerDemo
//
//  Created by TTS on 15/8/5.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCContactViewController.h"

@interface KCContactViewController ()

@end

@implementation KCContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"contect";
    self.tabBarItem.title = @"contect";
    self.tabBarItem.image = [UIImage imageNamed:@"caat.png"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"web.png"];
    
     
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
