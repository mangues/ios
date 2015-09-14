//
//  MGDatabaseCreator.m
//  SQLiteDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGDatabaseCreator.h"
#import "KCDbManager.h"

@implementation MGDatabaseCreator
+(void)initDatabase{
    NSString *key = @"IsCreateBase";   //标记表是否创建，不能一直创建表
    NSUserDefaults *userDefault = [[NSUserDefaults alloc]init]; if ([[userDefault valueForKey:key] intValue]!=1) {
        [self createUsertable];
        [self createStatustable];
        [userDefault setValue:@1 forKey:key];
    }
}

#pragma mark 创建User表
+(void)createUsertable{
    NSString *sql = @"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text, profileImageUrl text,mbtype text,city text)";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}
#pragma mark 创建Status表
+(void)createStatustable{
    NSString *sql = @"CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
    
}
@end
