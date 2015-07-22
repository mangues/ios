//
//  ViewController.m
//  codeLogin
//
//  Created by TTS on 15/7/17.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
CGRect screen ;
CGFloat screenHeight ;
CGFloat screenWidth ;
- (void)viewDidLoad {
    [super viewDidLoad];
     screen = [[UIScreen mainScreen] bounds];
     screenHeight = screen.size.height;
     screenWidth = screen.size.width;
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initUI{
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    //登陆
    UILabel *lableLogin = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 -50, 60, 100, 20)];
   // lableName.backgroundColor = [UIColor redColor];   //设置背景色
    lableLogin.font = [UIFont fontWithName:@"Helvetica" size:22];
    lableLogin.textColor = [UIColor greenColor];
    lableLogin.text=@"登陆界面";
    [self.view addSubview:lableLogin];
    [self initName:4 andName:@"邮箱"];
    [self initName:3 andName:@"密码"];
    [self initButton:@"登陆" andHeight:2];
  
}


-(void) initName:(int)heigth andName:(NSString *)name{
    //用户名
    UILabel *lableName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/4 -50, screenHeight/heigth+5, 100, 20)];
    
    // lableName.backgroundColor = [UIColor redColor];   //设置背景色
    lableName.font = [UIFont fontWithName:@"Helvetica" size:12];
    lableName.textColor = [UIColor blackColor];
    lableName.text=name;
    [self.view addSubview:lableName];
    
    
    UITextField *textName = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth/4, screenHeight/heigth, 200, 30)];
    textName.backgroundColor = [UIColor whiteColor];
    // [textName setBorderStyle:UITextBorderStyleBezel];             //边框设置
    textName.layer.backgroundColor = [[UIColor clearColor] CGColor];
    textName.layer.borderColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    textName.layer.borderWidth =1.0;
    textName.layer.cornerRadius =5.0;
    
    textName.placeholder = name;                          //默认显示的字
    [textName.layer setMasksToBounds:YES];
    [self.view addSubview:textName];
}

-(void) initButton:(NSString *) btnName andHeight:(int) height{
    UIButton *btn = [[UIButton alloc]  initWithFrame:CGRectMake(screenWidth/2 -50, screenHeight/height, 100, 20)];
    [btn setTitle: btnName forState: UIControlStateNormal];
   // btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn   setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 20 ]];
    [btn setBackgroundColor: [UIColor greenColor]];
    [self.view addSubview:btn];
    
    
    //设置点击事件
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    //在button的tag中添加你需要传递的参数，目前资料中只有这种方法
    //你可以传入任意类型的参数
    [btn setTag:100];
}

-(void)action:(id)sender{
    //这个sender其实就是UIButton，因此通过sender.tag就可以拿到刚才的参数
   // int i = [sender tag];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}



@end
