//
//  MGDbManager.m
//  CoreDataDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGDbManager.h"

@implementation MGDbManager
singleton_implementation(MGDbManager)

#pragma mark 重写初始化方法
-(instancetype)init{
    MGDbManager *manager;
    if((manager = [super init])){
        _context = [manager createDbContext];
    }
    return manager;
}

-(NSManagedObjectContext *)createDbContext{
    NSManagedObjectContext *context;
    //打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //创建解析器
    NSPersistentStoreCoordinator *storeCoordimator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //创建数据库保存路径
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //添加SQLite持久化存储到解析器
    NSError *error;
    [storeCoordimator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (error) {
        NSLog(@"数据库打开失败！错误：%@",error.localizedDescription);
    }else{
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = storeCoordimator;
         NSLog(@"数据库打开成功！");
    }
      return context;
}

@end
