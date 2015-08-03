//
//  KCStatus.h
//  CustomTableViewDemo
//
//  Created by TTS on 15/7/24.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCStatus : NSObject
#pragma 属性
@property (nonatomic,assign) long long Id;  //微博Id
@property (nonatomic,copy) NSString *profileImageUrl; //头像
@property (nonatomic,copy) NSString *userName;//发送用户
@property (nonatomic,copy) NSString *mbtype; //会员类型
@property (nonatomic,copy) NSString *createAt; //创建时间
@property (nonatomic,copy) NSString *source; //设备来源
@property (nonatomic,copy) NSString *text; //微博内容

#pragma 构造方法
-(KCStatus *) initWithDictionary:(NSDictionary *) dic;

#pragma 构造方法 静态
+(KCStatus *) initWithDictionary:(NSDictionary *) dic;

@end
