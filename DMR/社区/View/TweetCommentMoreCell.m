//
//  TweetCommentMoreCell.m
//  happigo
//
//  Created by fei on 15/12/25.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetCommentMoreCell.h"
#import "UIResponder+Router.h"
#import "Global.h"
NSString *const commentMoreButtonTap = @"commentMoreButtonTap";


@interface TweetCommentMoreCell ()

@property (nonatomic, strong) UIButton *commentMoreButton;

@end

@implementation TweetCommentMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
        [self setLayoutSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)initSubviews{
    [self.contentView addSubview:self.commentMoreButton];
}

- (void)setLayoutSubviews{
    __weak typeof(self) weekSelf = self;
    [self.commentMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weekSelf.contentView.center);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}
+ (CGFloat)hightForCell{
    return 30;
}

- (void)commentMoreButton:(UIButton *)sender{
    [self routerEventWithName:commentMoreButtonTap userInfo:@{}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(UIButton *)commentMoreButton{
    if (_commentMoreButton == nil) {
        _commentMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentMoreButton addTarget:self action:@selector(commentMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [_commentMoreButton setTitle:@"查看全部评论" forState:UIControlStateNormal];
    }
    return _commentMoreButton;
}


@end
