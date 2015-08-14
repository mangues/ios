//
//  User.m
//  CoreDataDemo
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "User.h"
#import "Status.h"


@implementation User

@dynamic city;
@dynamic mbtype;
@dynamic name;
@dynamic profileImageUrl;
@dynamic screenName;
@dynamic status;
-(void)setUser:(User *)user{
    self.name=user.name;
    self.screenName=user.screenName;
    self.profileImageUrl=user.profileImageUrl;
    self.mbtype=user.mbtype;
    self.city=user.city;
}
@end
