//
//  TweetNoticeCell.m
//  happigo
//
//  Created by shklxmac111 on 15/12/29.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetNoticeCell.h"
#import "MLLabel.h"
#import "UIColor+HEX.h"
#import "ColorTools.h"
#import "Global.h"

#define IconWidth           40
#define IconHeight          40

#define ArrowWidth          25
#define ArrowHeight         25
#define IconLeftPadding     10
#define ContentLeftPadding  5
#define ContentLabelHeight  30
#define ArrowRightPadding   10

@interface TweetNoticeCell ()


@end

@implementation TweetNoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self setLayouts];
    }
    return self;
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(IconLeftPadding);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.equalTo(@(IconWidth));
        make.height.equalTo(@(IconHeight));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).with.offset(ContentLeftPadding);
        make.right.lessThanOrEqualTo(_arrowImageView.mas_left);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@(ContentLabelHeight));
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-ArrowRightPadding);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@(ArrowHeight));
        make.width.equalTo(@(ArrowWidth));
    }];
}

#pragma mark - 属性

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeCenter;
    }
    return _arrowImageView;
}

-(MLLabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [MLLabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [ColorTools themePinkColor];
    }
    return _contentLabel;
}

-(UIImageView *)iconImageView
{
    if (_iconImageView == nil)
    {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

@end
