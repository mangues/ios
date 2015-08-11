//
//  MGMainViewController.m
//  SimplifyUrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainViewController.h"
#import "MGStatus.h"
#import "MGUser.h"
#import "MGStatusTableViewCell.h"
#define kURL @"http://ios-simulation-9d63b.coding.io/index.html"
@interface MGMainViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_status;
    NSMutableArray *_statusCells;//存储cell，用于计算高度
    NSString *_userName;
    NSString *_password;
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _userName=@"KenshinCui";
    _password=@"123";
    
    [self layoutUI];
    
    [self sendRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
#pragma mark 界面布局
-(void)layoutUI{
    _tableView =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

//
//{
//    "statuses": [{
//        "Id": "1",
//        "profileImageUrl": "http://www.feizl.com/upload2007/2014_08/14082617231748.jpg",
//        "mbtype": "http://img4.imgtn.bdimg.com/it/u=535226650,2197306098&fm=21&gp=0.jpg",
//        "source": "iPhone 6",
//        "createdAt": "9:00 ",
//        "text": "当然，对于上面文件下载这种大数据响应的情况使用代理方法处理响应具有一定的优势（可以获得传输进度）。但是如果现响应数据不是文件而是一段字符串(注意web请求的数据可以是字符串或者二进制，上面文件下载示例中响应数据是二进制)",
//        "user": {
//            "Id": "1",
//            "name": "xutao",
//            "city": "北京"
//        }
//    }]
//}
#pragma mark 加载数据
-(void)loadData:(NSData *)data{
    _status=[[NSMutableArray alloc]init];
    _statusCells=[[NSMutableArray alloc]init];
    /*json序列化
     options:序列化选项，枚举类型，但是可以指定为枚举以外的类型，例如指定为0则可以返回NSDictionary或者NSArray
     a.NSJSONReadingMutableContainers:返回NSMutableDictionary或NSMutableArray
     b.NSJSONReadingMutableLeaves：返回NSMutableString字符串
     c.NSJSONReadingAllowFragments：可以解析JSON字符串的外层既不是字典类型（NSMutableDictionary、NSDictionary）又不是数组类型（NSMutableArray、NSArray）的数据,但是必须是有效的JSON字符串
     error:错误信息
     */
    NSError *error;
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *array = (NSArray *)dic[@"statuses"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MGStatus *status = [[MGStatus alloc]init];
        //通过KVC给对象赋值，只能赋值一层，不能深层次遍历，赋值
        [status setValuesForKeysWithDictionary:obj];
        
        
        MGUser *user=[[MGUser alloc]init];
        [user setValuesForKeysWithDictionary:obj[@"user"]];
        status.user=user;
        
        
        
        [_status addObject:status];
        
        //存储tableViewCell
        MGStatusTableViewCell *cell=[[MGStatusTableViewCell alloc]init];
        [_statusCells addObject:cell];
    }];
    
    

    }

#pragma mark 发送数据请求
-(void)sendRequest{
    NSString *urlStr=[NSString stringWithFormat:@"%@",kURL];
    //注意对于url中的中文是无法解析的，需要进行url编码(指定编码类型位utf-8)
    //另外注意url解码使用stringByRemovingPercentEncoding方法
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建url链接
    NSURL *url=[NSURL URLWithString:urlStr];
    
    /*创建可变请求*/
    NSMutableURLRequest *requestM=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    [requestM setHTTPMethod:@"GET"];//设置位post请求
    //创建post参数
  //  NSString *bodyDataStr=[NSString stringWithFormat:@"userName=%@&password=%@",_userName,_password];
  ///  NSData *bodyData=[bodyDataStr dataUsingEncoding:NSUTF8StringEncoding];
   // [requestM setHTTPBody:bodyData];
    
    //发送一个异步请求
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            //            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //            NSLog(@"jsonStr:%@",jsonStr);
            //加载数据
            [self loadData:data];
            
            //刷新表格
            [_tableView reloadData];
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
            }];
        }
    }];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _status.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    MGStatusTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[MGStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //在此设置微博，以便重新布局
    MGStatus *status=_status[indexPath.row];
    cell.status=status;
    return cell;
}


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MGStatusTableViewCell *cell= _statusCells[indexPath.row];
    cell.status=_status[indexPath.row];
    return cell.height;
}
@end
