//
//  AreaCell.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AreaCell.h"
#import "ColorTools.h"

@interface AreaCell ()

@property (nonatomic, strong) UILabel *areaNameLabel;
@property (nonatomic, strong) UILabel *areaNumberLabel;

@property (nonatomic, strong, readwrite) NSString *areaName;
@property (nonatomic, strong, readwrite) NSString *areaNumber;

@end
@implementation AreaCell

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.areaName = @"";
        self.areaNumber = @"";
        [self initSubviews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 初始化

- (void)initSubviews {
    [self.contentView addSubview:self.areaNameLabel];
    [self.contentView addSubview:self.areaNumberLabel];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_areaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(17);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.height.equalTo(weakSelf.contentView.mas_height);
        make.width.lessThanOrEqualTo(weakSelf.contentView.mas_width);
    }];
    [_areaNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-5);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.height.equalTo(weakSelf.contentView.mas_height);
        make.width.lessThanOrEqualTo(weakSelf.contentView.mas_width);
    }];
}

#pragma mark - 配置cell

- (void)configCellWithAreaName:(NSString *)areaName areaNumber:(NSString *)areaNumber {
    if (areaName.length && areaNumber.length) {
        self.areaNameLabel.text = areaName;
        self.areaNumberLabel.text = [NSString stringWithFormat:@"+%@",areaNumber];
        self.areaName = areaName;
        self.areaNumber = areaNumber;
    }
}

#pragma mark - 属性

- (UILabel *)areaNameLabel {
    if (_areaNameLabel == nil) {
        _areaNameLabel = [[UILabel alloc]init];
        _areaNameLabel.textAlignment = NSTextAlignmentLeft;
        _areaNameLabel.textColor = [ColorTools areaColor];
        _areaNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _areaNameLabel;
}

- (UILabel *)areaNumberLabel {
    if (_areaNumberLabel == nil) {
        _areaNumberLabel = [[UILabel alloc]init];
        _areaNumberLabel.textAlignment = NSTextAlignmentRight;
        _areaNumberLabel.textColor = [ColorTools areaColor];
        _areaNumberLabel.font = [UIFont systemFontOfSize:15];
    }
    return _areaNumberLabel;
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
