//
//  String2Image.m
//  SimplifyUrlConnection
//
//  Created by TTS on 15/8/11.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "String2Image.h"


@implementation String2Image
+(UIImage *)returnImage:(NSString *)path{
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
@end
