//
//  TweetCommentCell.m
//  happigo
//
//  Created by fei on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetCommentCell.h"
#import "PortraitView.h"
#import "UIResponder+Router.h"
#import "Global.h"


NSString *const PraiseButtonTap = @"PraiseButtonTap";


@interface TweetCommentCell ()

// 头像
@property (nonatomic,strong) PortraitView *headerView;

// 昵称
@property (nonatomic,strong) UILabel *nickNameLabel;
// 时间位置
@property (nonatomic,strong) UILabel *timeAndLocationLabel;
// 评论内容
@property (nonatomic,strong) UILabel *contentLabel;
// 赞
@property (nonatomic,strong) UIButton *praiseButton;
@property (nonatomic,strong) UIView *lineView;

@end



@implementation TweetCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        [self setLayoutSubviews];
    }
    return self;
}

- (void)initSubviews{
    [self addSubview:self.headerView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.timeAndLocationLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.praiseButton];
    [self addSubview:self.lineView];
}

- (void)setLayoutSubviews{
    
    __weak typeof(self) weakSelf = self;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(5);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_top);
        make.left.equalTo(weakSelf.headerView.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(DeviceWidth,25));
        
    }];
    [self.timeAndLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nickNameLabel.mas_right);
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(DeviceWidth, 25));
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf.headerView.mas_bottom).with.offset((10));
        make.left.equalTo(weakSelf.timeAndLocationLabel.mas_right);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset((5));
    }];
    
    [self.praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom);
        make.height.equalTo(@(10));
        make.width.lessThanOrEqualTo(@(DeviceWidth));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.equalTo(@(1));
        make.bottom.equalTo(@(-1));
    }];
    
}
- (void)setContentWithModel:(TweetCommentModel *)model{
    
    NSMutableAttributedString *nick = [[NSMutableAttributedString alloc] initWithString:model.str2];
    NSTextAttachment *nickAttachment = [[NSTextAttachment alloc] init];
    nickAttachment.image = [UIImage imageNamed:@""];
    NSAttributedString *nickAttributedStr = [NSAttributedString attributedStringWithAttachment:nickAttachment];
    [nick insertAttributedString:nickAttributedStr atIndex:model.str5.length];
    
    NSMutableAttributedString *praise = [[NSMutableAttributedString alloc] initWithString:model.str5];
    NSTextAttachment *praiseAttachment = [[NSTextAttachment alloc] init];
    nickAttachment.image = [UIImage imageNamed:@""];
    
    NSAttributedString *praiseAttributedStr = [NSAttributedString attributedStringWithAttachment:praiseAttachment];
    [praise insertAttributedString:praiseAttributedStr atIndex:0];
    self.nickNameLabel.attributedText = nick;
    self.timeAndLocationLabel.text = model.str3;
    self.contentLabel.text = model.str4;
    self.praiseButton.titleLabel.attributedText = praise;
    
    
    
}
+ (CGFloat )heightForModel:(TweetCommentModel *)model{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    CGSize size = [model.str
                   boundingRectWithSize:CGSizeMake(DeviceWidth - 70, CGFLOAT_MAX)
                   options:NSStringDrawingUsesFontLeading|
                   NSStringDrawingUsesLineFragmentOrigin|
                   NSStringDrawingTruncatesLastVisibleLine
                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                NSParagraphStyleAttributeName:paragraphStyle}
                   context:nil].size;
    return size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)praise
{
    [self routerEventWithName:PraiseButtonTap
                     userInfo:@{}];
}

- (PortraitView *)headerView{
    if (_headerView == nil) {
        _headerView = [[PortraitView alloc] init];
        _headerView.cornerRadius = 30;
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.backgroundColor = [UIColor yellowColor];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _nickNameLabel;
}

- (UILabel *)timeAndLocationLabel{
    if (_timeAndLocationLabel == nil) {
        _timeAndLocationLabel = [UILabel new];
        _timeAndLocationLabel.backgroundColor = [UIColor yellowColor];
    }
    return _nickNameLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.backgroundColor = [UIColor yellowColor];
        
    }
    return _contentLabel;
}

- (UIButton *)praiseButton{
    if (_praiseButton == nil) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseButton addTarget:self
                          action:@selector(praise)
                forControlEvents:UIControlEventTouchUpInside];
        [_praiseButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _praiseButton.backgroundColor = [UIColor yellowColor];
        _praiseButton.titleLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _praiseButton;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor yellowColor];
    }
    return _lineView;
}

@end
