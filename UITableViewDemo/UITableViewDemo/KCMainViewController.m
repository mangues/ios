//
//  KCMainViewController.m
//  UITableViewDemo
//
//  Created by TTS on 15/7/21.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCContact.h"
#import "KCContactGroup.h"

@interface KCMainViewController ()<UITableViewDataSource>{
    UITableView * _tableView;
    NSMutableArray * _contacts;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    
    KCContact *contact1=[KCContact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    KCContact *contact2=[KCContact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    KCContactGroup *group1=[KCContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    KCContact *contact3=[KCContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    KCContact *contact4=[KCContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    KCContact *contact5=[KCContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    KCContactGroup *group2=[KCContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    
    
    
    KCContact *contact6=[KCContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    KCContact *contact7=[KCContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
    
    KCContactGroup *group3=[KCContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    KCContact *contact8=[KCContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    KCContact *contact9=[KCContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    KCContact *contact10=[KCContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    KCContact *contact11=[KCContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    KCContact *contact12=[KCContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    KCContactGroup *group4=[KCContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    KCContact *contact13=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    KCContact *contact14=[KCContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    KCContact *contact15=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    KCContactGroup *group5=[KCContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return _contacts.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%i)行数",section);
    KCContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    KCContactGroup *group=_contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    
  
    //************************************默认样式*********************************//
//    UITableViewCell  *cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    
   //***************************************************性能优化**************************************//
    
//     //    声明静态字符串型对象，用来标记重用单元格
//      static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
   // static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    
//    //    用TableSampleIdentifier表示需要重用的单元   //首先根据标识去缓存池取
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
//    //    如果如果没有多余单元，则需要创建新的单元 //如果缓存池没有到则重新创建并放到缓存池中
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
//    }
//    
//    else {
//        while ([cell.contentView.subviews lastObject ]!=nil) {
//            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
//        }
//    }
    
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell;
    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        if (indexPath.row==0) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw=[[UISwitch alloc]init];
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=sw;
            
        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
    }
    
    if(indexPath.row==0){
        ((UISwitch *)cell.accessoryView).tag=indexPath.section;
    }
    
    
   
    //cell.textLabel.backgroundColor= [UIColor greenColor];
    //设置cell的字体大小
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
   // tableView.editing=YES;
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView = backgroundView;
    
     //    设置单元格UILabel属性背景颜色
     // cell.textLabel.backgroundColor=[UIColor clearColor];
     //    正常情况下现实的图片
    UIImage *image = [UIImage imageNamed:@"1.png"];
    cell.imageView.image=image;
    //    被选中后高亮显示的照片
    UIImage *highLightImage = [UIImage imageNamed:@"2.png"];
    cell.imageView.highlightedImage = highLightImage;
    
    //改变换行线颜色
    
    tableView.separatorColor = [UIColor blueColor];
    
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
 

    
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%i）名称",section);
    KCContactGroup *group=_contacts[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSLog(@"生成尾部（组%i）详情",section);
    KCContactGroup *group=_contacts[section];
    return group.detail;
}
#pragma mark 返回每组标题索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSLog(@"生成每组索引");
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(KCContactGroup *group  in _contacts){
        [array addObject:group.name];
    }
    return array;
}

#pragma mark 设置单元格高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
}

#pragma mark 设置首行缩进
-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    //偶数行缩进
    if (row % 2==0) {
       return 0;
    }
    return 2;
}
//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     _selectedIndexPath=indexPath;
    //    首先是用indexPath获取当前行的内容
    KCContactGroup *group=_contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    
    
    //    从数组中取出当前行内容
    NSString *rowValue = [contact getName];
    //NSLog("（组@）详情",rowValue);
    NSString *message = [[NSString alloc]initWithFormat:@"You selected,%@",rowValue];
    //    弹出警告信息
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                   message:message
//                                                  delegate:self
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles: nil];
    
    
    //创建弹出窗口
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput; //设置窗口内容样式
    UITextField *textField= [alert textFieldAtIndex:0]; //取得文本框
    textField.text=contact.phoneNumber; //设置文本框内容
    [alert show];
}


//设置划动cell是否出现del按钮，可供删除数据里进行处理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//设置删除时编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//cell 的重绘，可以完成拖动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
// Return NO if you do not want the item to be re-orderable.
    return true;
}
//
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
   // [self.dataController.masterBirdSightingList exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

#pragma mark 窗口的代理方法，用户保存数据   //弹出框
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //当点击了第二个按钮（OK）
    if (buttonIndex==1) {
        UITextField *textField= [alertView textFieldAtIndex:0];
        //修改模型数据
        KCContactGroup *group=_contacts[_selectedIndexPath.section];
        KCContact *contact=group.contacts[_selectedIndexPath.row];
        contact.phoneNumber=textField.text;
        //刷新表格
        NSArray *indexPaths=@[_selectedIndexPath];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代码更新时的动画
    }
}


#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark 切换开关转化事件
-(void)switchValueChange:(UISwitch *)sw{
    NSLog(@"section:%i,switch:%i",sw.tag, sw.on);
}

@end
