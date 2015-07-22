//
//  ViewController.m
//  login
//
//  Created by TTS on 15/7/17.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *text;
@end

@implementation ViewController







- (IBAction)login:(id)sender {
    NSString *dd= _text.text;
    NSLog(dd);
    NSString *name = [NSString stringWithFormat:@"%@,登陆成功!",dd];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:name delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
- (IBAction)view:(id)sender {

       [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
