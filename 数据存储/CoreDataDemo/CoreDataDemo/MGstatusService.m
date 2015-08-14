//
//  KCStatusService.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MGDbManager.h"
#import "MGStatusService.h"
#import "Status.h"
#import "KCSingleton.h"


@interface MGStatusService(){
    
}

@end

@implementation MGStatusService
singleton_implementation(MGStatusService)

-(NSManagedObjectContext *)context{
    return [MGDbManager sharedMGDbManager].context;
}

-(void)addStatusWithCreatedAt:(NSDate *)createdAt source:(NSString *)source text:(NSString *)text user:(User *)user{
    Status *status= [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:self.context];
    status.createAt=createdAt;
    status.source=source;
    status.text=text;
    status.user=user;
    NSError *error;
    //保存上下文
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(void)addStatus:(Status *)status{
    [self addStatusWithCreatedAt:status.createAt source:status.source text:status.text user:status.user];
}

-(void)removeStatus:(Status *)status{
    [self.context deleteObject:status];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(NSArray *)getAllStatus{
    NSError *error;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Status"];
    NSArray *array=[self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
    return  array;
}

-(NSArray *)getStatusesByUserName:(NSString *)name{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Status"];
    request.predicate=[NSPredicate predicateWithFormat:@"user.name=%@",name];
    NSArray *array=[self.context executeFetchRequest:request error:nil];
    return  array;
}
@end
