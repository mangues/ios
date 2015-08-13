//
//  MGMainTableViewController.m
//  SQLiteDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGMainTableViewController.h"
#import "MGDatabaseCreator.h"
#import "ObtainData.h"
#import "KCUser.h"
#import "KCUserService.h"
#import "KCStatusService.h"
#import "KCStatusTableViewCell.h"

@interface MGMainTableViewController (){
NSArray *_status;
NSMutableArray *_statusCells;
}


@end

@implementation MGMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建数据库表
    [MGDatabaseCreator initDatabase];
    //加载数据源到数据库
   // [[ObtainData sharedObtainData] addUsers];
   // [[ObtainData sharedObtainData] addStatus];
    
    
    //加载数据到视图
    [self loadData];
    
    
}


-(void)loadData{
    _statusCells = [[NSMutableArray alloc] init];
    _status = [[KCStatusService sharedKCStatusService]getAllStatus];
    [_status enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KCStatusTableViewCell *cell = [[KCStatusTableViewCell alloc] init];
        cell.status = (KCStatus *)obj;
        [_statusCells addObject:cell];
    }];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _statusCells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *identtityKey=@"myTableViewCellIdentityKey1";
    KCStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identtityKey ];
    if (cell == nil) {
        cell=[[KCStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    cell.status=_status[indexPath.row];
    return cell;
}

#pragma mark cell 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((KCStatusTableViewCell *)_statusCells[indexPath.row]).height;
}


#pragma mark Section 高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)removeUser{
    //注意在SQLite中区分大小写
    [[KCUserService sharedKCUserService] removeUserByName:@"Yanyue"];
}

-(void)modifyUserInfo{
    KCUser *user1= [[KCUserService sharedKCUserService]getUserByName:@"Xiaona"];
    user1.city=@"上海";
    [[KCUserService sharedKCUserService] modifyUser:user1];
    
    KCUser *user2= [[KCUserService sharedKCUserService]getUserByName:@"Lily"];
    user2.city=@"深圳";
    [[KCUserService sharedKCUserService] modifyUser:user2];
}
@end
