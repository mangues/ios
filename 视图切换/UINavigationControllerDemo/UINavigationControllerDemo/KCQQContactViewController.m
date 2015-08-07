//
//  KCQQContactViewController.m
//  UINavigationControllerDemo
//
//  Created by TTS on 15/8/6.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCQQContactViewController.h"
#import "KCPublicAccountViewController.h"

@interface KCQQContactViewController ()

@end

@implementation KCQQContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每次出栈都会销毁相应的子控制器
    NSLog(@"childViewControllers:%@",self.navigationController.childViewControllers);
    [self setTitle:@"QQ Contact"];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"QQ" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem=back;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Public Account" style:UIBarButtonItemStyleDone target:self action:@selector(gotoNextView)];

}

-(void)gotoNextView{
    KCPublicAccountViewController *publicAccountController=[[KCPublicAccountViewController alloc]init];
    [self.navigationController pushViewController:publicAccountController  animated:YES];
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
