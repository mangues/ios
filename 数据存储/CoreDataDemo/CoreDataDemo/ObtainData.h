//
//  ObtainData.h
//  SQLiteDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//
//模拟获取数据
#import <Foundation/Foundation.h>
#import "KCSingleton.h"
@interface ObtainData : NSObject
singleton_interface(ObtainData);
-(void)addUsers;
-(void)addStatus;
@end
