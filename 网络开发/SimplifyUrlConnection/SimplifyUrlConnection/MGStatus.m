//
//  MGStatus.m
//  SimplifyUrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGStatus.h"

@implementation MGStatus
//返回设备来源
-(NSString *)source{
    return [NSString stringWithFormat:@"来源%@",_source];
}
@end
