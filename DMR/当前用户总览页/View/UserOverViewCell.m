//
//  UserOverViewCell.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UserOverViewCell.h"
#import "Global.h"

@interface UserOverViewCell ()

@property (strong,nonatomic) UIView *line;

@end

@implementation UserOverViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubViews];
        [self setLayouts];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)initSubViews
{
    [self.contentView addSubview:self.line];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.height.equalTo(@.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 属性

-(UIView *)line
{
    if (_line == nil)
    {
        _line = [UIView new];
        _line.backgroundColor = [ColorTools separatorLineColor];
    }
    return _line;
}

@end
