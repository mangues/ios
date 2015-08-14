//
//  KCUserService.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "MGUserService.h"
#import "User.h"
#import "MGDbManager.h"
#import <CoreData/CoreData.h>

@implementation MGUserService
singleton_implementation(MGUserService)
-(NSManagedObjectContext *)context{
    return [MGDbManager sharedMGDbManager].context;
}

#pragma mark 添加用户到数据库
-(void)addUser:(User *)user{
//    [self addUserWithName:user.name screenName:user.screenName profileImageUrl:user.profileImageUrl mbtype:user.mbtype city:user.city];
    //添加一个对象
    User *us = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[self context]];
    [us setUser:user];
    NSError *error;
    //保存上下文
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    //添加一个对象
    User *us = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[self context]];
    us.name=name;
    us.screenName=screenName;
    us.profileImageUrl=profileImageUrl;
    us.mbtype=mbtype;
    us.city=city;
    NSError *error;
    //保存上下文
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

#pragma mark 根据用户名查询用户数据
-(User *)getUserByName:(NSString *)name{
    //实例化查询
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    //使用谓词查询基于Keypath 查询的，如果建是一个变量，格式化字符串时需要使用%k而不是%@
    request.predicate = [NSPredicate predicateWithFormat:@"%K=%@",@"name",name];
    NSError *error;
    User *user;
    //进行查询
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误，错误信息：%@！",error.localizedDescription);
    }else{
        user=[result firstObject];
    }
    return  user;
}

-(void)removeUser:(User *)user{
    [self.context deleteObject:user];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误，错误信息：%@!",error.localizedDescription);
    }
}

-(void)removeUserByName:(NSString *)name{
    User *user=[self getUserByName:name];
    [self removeUser:user];
}

-(void)modifyUser:(User *)user{
    [self modifyUserWithName:user.name screenName:user.screenName profileImageUrl:user.profileImageUrl mbtype:user.mbtype city:user.city];
}
-(void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    User *us=[self getUserByName:name];
    us.screenName=screenName;
    us.profileImageUrl=profileImageUrl;
    us.mbtype=mbtype;
    us.city=city;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"修改过程中发生错误,错误信息：%@",error.localizedDescription);
    }
    
}
-(NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Status"];
    request.predicate=[NSPredicate predicateWithFormat:@"text LIKE '*Watch*'",text];
    NSError *error;
    NSArray *status = [self.context executeFetchRequest:request error:&error];
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user.screenName=%@",screenName];
    NSArray *user = [status filteredArrayUsingPredicate:userPredicate];
    return user;
}
@end
