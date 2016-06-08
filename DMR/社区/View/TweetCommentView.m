//
//  TweetCommentView.m
//  happigo
//
//  Created by 李海龙 on 15/12/28.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "TweetCommentView.h"
#import "MLLinkLabel.h"
#import "Masonry.h"
#import "UIResponder+Router.h"
#import "CommentModel.h"
#import "Global.h"

#define kPadding 0
#define kHeight 25
@interface TweetCommentView ()

@property (nonatomic, strong) MLLinkLabel *nickName_content_label;
@end

@implementation TweetCommentView

-(instancetype)init{
    if (self = [super init]) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    [self addSubview:self.nickName_content_label];
}

-(void)setLayouts{
    __weak typeof(self)weakSelf = self;
    [self.nickName_content_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(0);
    }];
}

#pragma mark - 公有方法

-(void)setContentWithArray:(NSArray *)array{
    WeakObject(weakSelf);
    for (UIView *view in self.subviews)
    {
        if (view == _nickName_content_label)
        {
            [self.nickName_content_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(weakSelf);
                make.height.mas_equalTo(0);
            }];
            continue;
        }
        [view removeFromSuperview];
    }    for (int i = 0; i < array.count; i++) {
        //设置linkLabel的属性
        MLLinkLabel *newLinkLabel = [[MLLinkLabel alloc]init];
        newLinkLabel.numberOfLines = 1;
        newLinkLabel.font = [UIFont systemFontOfSize:14.0];
        newLinkLabel.textAlignment = NSTextAlignmentLeft;
//        newLinkLabel.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        newLinkLabel.dataDetectorTypes = MLDataDetectorTypeAttributedLink;
        [newLinkLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            [weakSelf routerEventWithName:@"tapUserName" userInfo:array[i]];
        }];
        //填充数据
        CommentModel *model = array[i];
//        NSString *nickNameString = userDic[@"nickname"];
//        NSString *contentString = userDic[@"content"];
        NSString *nickNameString = model.nickname;
        NSString *contentString = model.content;

        NSString *nickName_content_string = [NSString stringWithFormat:@"%@: %@",nickNameString,contentString];
        NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:nickName_content_string];
        [attrStr addAttribute:NSLinkAttributeName
                        value:@"nickname"
                        range:NSMakeRange(0, nickNameString.length+1)];
        newLinkLabel.attributedText = attrStr;
        newLinkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
        //添加到父视图
        [self addSubview:newLinkLabel];
        //更新UI
        [newLinkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nickName_content_label.mas_bottom);
            make.left.mas_equalTo(kPadding);
            make.right.equalTo(weakSelf.mas_right).offset(-kPadding);
            make.height.mas_equalTo(kHeight);
        }];
        self.nickName_content_label = newLinkLabel;
    }
}

+(CGFloat)heightWithArray:(NSArray *)array{
    return array.count * kHeight ;
}

#pragma mark - 属性
-(MLLinkLabel *)nickName_content_label{
    if (nil == _nickName_content_label) {
        _nickName_content_label = [[MLLinkLabel alloc] init];
    }
    return _nickName_content_label;
}

@end
