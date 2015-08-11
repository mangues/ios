//
//  MGUser.h
//  SimplifyUrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUser : NSObject
#pragma mark 编号
@property (nonatomic,strong) NSNumber *Id;
#pragma mark 用户名
@property (nonatomic,copy) NSString *name;
#pragma mark 城市
@property (nonatomic,copy) NSString *city;
@end
