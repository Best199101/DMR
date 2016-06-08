//
//  TweetUserInfoView.m
//  happigo
//
//  Created by shklxmac111 on 15/12/28.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetUserInfoView.h"
#import "PortraitView.h"
#import "MLLabel.h"
#import "TweetListModel.h"
#import "ColorTools.h"
#import "TimeTools.h"
#import "Global.h"

#define PortraitViewLeftPadding     10
#define PortraitViewWidth           35
#define PortraitViewHeight          35
#define NameLabelLeftPadding        7.5
#define NameLabelHeight             20
#define NameLabelRightPadding       100
#define DateTimeLocationLabelHeight 15

@interface TweetUserInfoView ()

@property (strong,nonatomic) PortraitView *portraitView;
@property (strong,nonatomic) UILabel *name_level_Label;
@property (strong,nonatomic) UILabel *date_time_location_Label;

@property (strong,nonatomic) TweetListModel *model;

@end

@implementation TweetUserInfoView

-(instancetype)init
{
    if (self == [super init])
    {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.portraitView];
    [self addSubview:self.name_level_Label];
    [self addSubview:self.date_time_location_Label];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(PortraitViewLeftPadding);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(PortraitViewHeight));
        make.width.equalTo(@(PortraitViewWidth));
    }];
    
    [_name_level_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitView.mas_right).with.offset(NameLabelLeftPadding);
        make.right.lessThanOrEqualTo(weakSelf.mas_right).with.offset(-NameLabelRightPadding).with.priorityLow();
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(@(NameLabelHeight));
    }];
    
    [_date_time_location_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitView.mas_right).with.offset(NameLabelLeftPadding);
        make.right.lessThanOrEqualTo(weakSelf.mas_right).with.offset(-NameLabelRightPadding);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(DateTimeLocationLabelHeight));
    }];
}

-(void)setContentWithUserInfo:(NSDictionary *)userInfo
{
    [_portraitView setContentWithUserInfo:userInfo];
    
    NSTextAttachment *levelAttachment = [NSTextAttachment new];
    NSNumber *level = userInfo[@"level"];
//    levelAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_%ld",level.integerValue]];
    levelAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"btn_video_see"]];
    NSAttributedString *levelAttr = [NSAttributedString attributedStringWithAttachment:levelAttachment];
    NSMutableAttributedString *name_levelAttr = [[NSMutableAttributedString alloc]initWithString:userInfo[@"nickname"]];
    [name_levelAttr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
    [name_levelAttr appendAttributedString:levelAttr];
    [_name_level_Label setAttributedText:name_levelAttr];
    _name_level_Label.font = [UIFont systemFontOfSize:15];

    NSString *timeString = [TimeTools getTimeStringByTimeInterval:[userInfo[@"time"]longValue]];
    NSMutableAttributedString *date_locationAttr = [[NSMutableAttributedString alloc]
                                                    initWithString:
                                                    [NSString stringWithFormat:@"%@ %@",timeString,userInfo[@"location"]]];
    [_date_time_location_Label setAttributedText:date_locationAttr];
    _date_time_location_Label.font = [UIFont systemFontOfSize:13];
    _date_time_location_Label.textColor = [ColorTools timeColor];
}

#pragma mark - 属性

-(PortraitView *)portraitView
{
    if (_portraitView == nil)
    {
        _portraitView = [PortraitView new];
    }
    return _portraitView;
}

-(UILabel *)name_level_Label
{
    if (_name_level_Label == nil) {
        _name_level_Label = [UILabel new];
        _name_level_Label.textColor = [ColorTools nickNameColor];
    }
    return _name_level_Label;
}

-(UILabel *)date_time_location_Label
{
    if (_date_time_location_Label == nil){
        _date_time_location_Label = [UILabel new];
    }
    return _date_time_location_Label;
}

@end
