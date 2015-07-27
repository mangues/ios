//
//  KCStatusTableViewCell.h
//  CustomTableViewDemo
//
//  Created by TTS on 15/7/24.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KCStatus;
@interface KCStatusTableViewCell : UITableViewCell
//微博对象
@property (nonatomic,strong) KCStatus *status;

//单元格高度
@property (assign,nonatomic) CGFloat height;
@end
