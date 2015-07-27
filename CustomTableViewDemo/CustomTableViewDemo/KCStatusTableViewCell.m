//
//  KCStatusTableViewCell.m
//  CustomTableViewDemo
//
//  Created by TTS on 15/7/24.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "KCStatusTableViewCell.h"
#import "KCStatus.h"

#define KCColor(r,g,b) [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1] //颜色宏定义
#define kStatusTableViewCellControlSpacing 10 //控件间距
#define kStatusTableViewCellBackgroundColor KCColor(251,251,251)
#define kStatusGrayColor KCColor(50,50,50)
#define kStatusLightGrayColor KCColor(120,120,120)

#define kStatusTableViewCellAvatarWidth 40 //头像宽度
#define kStatusTableViewCellAvatarHeight    kStatusTableViewCellAvatarWidth
#define kStatusTableViewCellUserNameFontSize 14
#define kStatusTableViewCellMbTypeWidth 13 //会员图标宽度
#define kStatusTableViewCellMbTypeHeight kStatusTableViewCellMbTypeWidth
#define kStatusTableViewCellCreateAtFontSize 12
#define kStatusTableViewCellSourceFontSize 12
#define kStatusTableViewCellTextFontSize 14

@interface KCStatusTableViewCell(){
    UIImageView *_avatar;//头像
    UIImageView *_mbType;//会员类型
    UILabel *_userName;
    UILabel *_createAt;
    UILabel *_source;
    UILabel *_text;
}
@end

@implementation KCStatusTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];   //初始化视图
    }
    return self;
}

#pragma mark 初始化视图
-(void)initSubView{
    //头像控件
    _avatar=[[UIImageView alloc]init];
    [self addSubview:_avatar];
    //用户名
    _userName=[[UILabel alloc]init];
    _userName.textColor=kStatusGrayColor;
    _userName.font=[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize];
    [self addSubview:_userName];
    //会员类型
    _mbType=[[UIImageView alloc]init];
    [self addSubview:_mbType];
    //日期
    _createAt=[[UILabel alloc]init];
    _createAt.textColor=kStatusLightGrayColor;
    _createAt.font=[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize];
    [self addSubview:_createAt];
    //设备
    _source=[[UILabel alloc]init];
    _source.textColor=kStatusLightGrayColor;
    _source.font=[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize];
    [self addSubview:_source];
    //内容
    _text=[[UILabel alloc]init];
    _text.textColor=kStatusGrayColor;
    _text.font=[UIFont systemFontOfSize:kStatusTableViewCellTextFontSize];
    _text.numberOfLines=0;
    //    _text.lineBreakMode=NSLineBreakByWordWrapping;
    [self addSubview:_text];
}

//设置微博 的排布
-(void) setStatus:(KCStatus *)status{
    #pragma mark 设置头像和大小
    CGFloat avatarX = 10,avatarY = 10;
    CGRect avatarRect = CGRectMake(avatarX, avatarY, kStatusTableViewCellAvatarWidth, kStatusTableViewCellAvatarHeight);
    _avatar.image =[UIImage imageNamed:status.profileImageUrl];
    _avatar.frame=avatarRect;
    
    
    
    #pragma mark 设置会员名称大小和位置
    CGFloat userNameX = CGRectGetMaxX(_avatar.frame)+kStatusTableViewCellControlSpacing;
    CGFloat userNameY=avatarY;
    
    //根据文本内容取得用户名占用空间大小
    CGSize userNameSize = [status.userName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize]}];
    CGRect userNameRect=CGRectMake(userNameX, userNameY, userNameSize.width,userNameSize.height);
    _userName.text=status.userName;
    _userName.frame=userNameRect;
    
    
    #pragma mark 设置会员图标大小和位置
    CGFloat mbTypeX = CGRectGetMaxX(_userName.frame)+kStatusTableViewCellControlSpacing;
    CGFloat mbtypeY = avatarY;
    CGRect  mbTyperect = CGRectMake(mbTypeX, mbtypeY, kStatusTableViewCellMbTypeWidth, kStatusTableViewCellMbTypeHeight);
    _mbType.image = [UIImage imageNamed:status.mbtype];
    _mbType.frame = mbTyperect;
    
     #pragma mark 设置发布日期大小和位置
    CGSize createAtSize = [status.createAt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize]}];
    CGFloat createAtX=userNameX;
    CGFloat createAtY=CGRectGetMaxY(_avatar.frame)-createAtSize.height;
    CGRect createAtRect=CGRectMake(createAtX, createAtY, createAtSize.width, createAtSize.height);
    _createAt.text=status.createAt;
    _createAt.frame=createAtRect;
    
    #pragma mark 设置设备信息大小和位置
    CGSize sourceSize=[status.source sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize]}];
    CGFloat sourceX=CGRectGetMaxX(_createAt.frame)+kStatusTableViewCellControlSpacing;
    CGFloat sourceY=createAtY;
    CGRect sourceRect=CGRectMake(sourceX, sourceY, sourceSize.width,sourceSize.height);
    _source.text=status.source;
    _source.frame=sourceRect;
    
    #pragma mark 设置微博内容大小和位置
    CGFloat textX=avatarX;
    CGFloat textY=CGRectGetMaxY(_avatar.frame)+kStatusTableViewCellControlSpacing;
    CGFloat textWidth=self.frame.size.width-kStatusTableViewCellControlSpacing*2;
    CGSize textSize=[status.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kStatusTableViewCellTextFontSize]} context:nil].size;
    CGRect textRect=CGRectMake(textX, textY, textSize.width, textSize.height);
    _text.text=status.text;
    _text.frame=textRect;
    
    _height=CGRectGetMaxY(_text.frame)+kStatusTableViewCellControlSpacing;
}






- (void)awakeFromNib {
    // Initialization code
}

#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
