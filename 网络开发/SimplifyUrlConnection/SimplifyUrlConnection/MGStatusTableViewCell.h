//
//  MGStatusTableViewCell.h
//  SimplifyUrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGStatus.h"

@interface MGStatusTableViewCell : UITableViewCell
#pragma mark 微博对象
@property(nonatomic,strong) MGStatus *status;
#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;
@end
