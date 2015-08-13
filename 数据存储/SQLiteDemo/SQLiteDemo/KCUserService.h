//
//  KCUserService.h
//  SQLiteDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//
//数据库操作部分
#import <Foundation/Foundation.h>
#import "KCUser.h"
#import "KCSingeton.h"

@interface KCUserService : NSObject
singleton_interface(KCUserService)
/**
 *  添加用户信息
 *
 *  @param status 用户对象
 */
-(void)addUser:(KCUser *)user;

/**
 *  删除用户
 *
 *  @param status 用户对象
 */
-(void)removeUser:(KCUser *)user;

/**
 *  根据用户名删除用户
 *
 *  @param name 用户名
 */
-(void)removeUserByName:(NSString *)name;

/**
 *  修改用户内容
 *
 *  @param status 用户对象
 */
-(void)modifyUser:(KCUser *)user;

/**
 *  根据用户编号取得用户
 *
 *  @param Id 用户编号
 *
 *  @return 用户对象
 */
-(KCUser *)getUserById:(int)Id;

/**
 *  根据用户名取得用户
 *
 *  @param name 用户名
 *
 *  @return 用户对象
 */
-(KCUser *)getUserByName:(NSString *)name;

@end
