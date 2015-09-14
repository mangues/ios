//
//  KCMainViewController.h
//  GCD
//
//  Created by TTS on 15/9/14.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
@interface KCMainViewController : UIViewController{
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
}
-(void)layoutUI;
-(void)loadImageWithMultiThread;
-(void)loadImage:(NSNumber *)index;
-(void)updateImageWithData:(NSData *)data andIndex:(int )index;
-(NSData *)requestData:(int )index;
@end
