//
//  KCStatus.m
//  CustomTableViewDemo
//
//  Created by TTS on 15/7/24.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCStatus.h"

@implementation KCStatus
-(KCStatus *) initWithDictionary:(NSDictionary *) dic{
    if (self=[super init]) {
        self.Id = [dic[@"Id"] longLongValue];
        self.profileImageUrl = dic[@"profileImageUrl"];
        self.userName = dic[@"userName"];
        self.mbtype = dic[@"mbtype"];
        self.createAt = dic[@"createdAt"];
        self.source = dic[@"source"];
        self.text = dic[@"text"];
    }
    return self;
}

+(KCStatus *) initWithDictionary:(NSDictionary *) dic{
    KCStatus  *status = [[KCStatus alloc] initWithDictionary: dic];
    return status;
}


-(NSString *) source{
    return [NSString stringWithFormat:@"来自 %@",_source];
}

@end
