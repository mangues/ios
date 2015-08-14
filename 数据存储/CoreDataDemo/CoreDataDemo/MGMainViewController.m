//
//  KCMainTableViewController.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "MGMainViewController.h"
#import "MGDbManager.h"
#import "MGUserService.h"
#import "MGStatusService.h"
#import "KCStatusTableViewCell.h"
#import "ObtainData.h"

@interface MGMainViewController (){
    NSArray *_status;
    NSMutableArray *_statusCells;
}

@end

@implementation MGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加数据
    ObtainData *ob = [ObtainData sharedObtainData];
    [ob addUsers];
    [ob addStatus];

    //    [self removeUser];
    //    [self modifyUserInfo];
    

    
    //    NSLog(@"status:%@",[[KCStatusService sharedKCStatusService]getStatusesByUserName:@"Binger"]);
    NSLog(@"users:%@",[[MGUserService sharedMGUserService]getUsersByStatusText:@"Watch" screenName:@"小娜"]);
    [self loadStatusData];
    
}



-(void)removeUser{
    //注意在SQLite中区分大小写
    [[MGUserService sharedMGUserService] removeUserByName:@"Yanyue"];
}

-(void)modifyUserInfo{
    User *user1= [[MGUserService sharedMGUserService]getUserByName:@"Xiaona"];
    user1.city=@"上海";
    [[MGUserService sharedMGUserService]modifyUser:user1];
    
    User *user2= [[MGUserService sharedMGUserService]getUserByName:@"Lily"];
    user2.city=@"深圳";
    [[MGUserService sharedMGUserService] modifyUser:user2];
}




#pragma mark 加载数据
-(void)loadStatusData{
    _statusCells=[[NSMutableArray alloc]init];
    _status=[[MGStatusService sharedMGStatusService]getAllStatus];
    [_status enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KCStatusTableViewCell *cell=[[KCStatusTableViewCell alloc]init];
        cell.status=(KCStatus *)obj;
        [_statusCells addObject:cell];
    }];
    NSLog(@"%@",[_status lastObject]);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _status.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identtityKey=@"myTableViewCellIdentityKey1";
    KCStatusTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identtityKey];
    if(cell==nil){
        cell=[[KCStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    cell.status=_status[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((KCStatusTableViewCell *)_statusCells[indexPath.row]).height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}
@end
