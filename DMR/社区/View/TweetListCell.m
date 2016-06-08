//
//  TweetListCell.m
//  happigo
//
//  Created by shklxmac111 on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetListCell.h"
#import "PortraitView.h"
#import "MLLabel.h"
#import "ImagesBrowser.h"
#import "TweetListModel.h"
#import "UIResponder+Router.h"
#import "ColorTools.h"
#import "TagView.h"
#import "TweetUserInfoView.h"
#import "TweetCommentView.h"
#import "NSTextAttachment+Util.h"
#import "AppDelegate.h"
#import "ShareJoinView.h"
#import "StringTools.h"
#import "Global.h"

#define CommentButtonWidth              60
#define CollectButtonWidth              60
#define TweetUserInfoViewRightPadding   50
#define TweetUserInfoViewTopPadding     10
#define TweetUserInfoHeight             35
#define TitleLabelHeight                25
#define TagViewHeight                   20
#define AttentionButtonWidth            52
#define AttentionButtonHeight           25
#define JoinViewHeight                  50

NSString *const PraiseButtonTapped              = @"PraiseButtonTapped";
NSString *const CommentButtonTapped             = @"CommentButtonTapped";
NSString *const AttentionButtonTapped           = @"AttentionButtonTapped";
NSString *const CancelAttentionButtonTapped     = @"CancelAttentionButtonTapped";


@interface TweetListCell ()

@property (strong,nonatomic) TweetUserInfoView *tweetUserInfoView;
@property (strong,nonatomic) UIButton *attentionButton;
@property (strong,nonatomic) UIButton *cancelAttentionButton;
@property (strong,nonatomic) UIActivityIndicatorView *activityView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *contentLabel;
@property (strong,nonatomic) ImagesBrowser *imagesBrowser;
@property (strong,nonatomic) TagView *tagView;
@property (strong,nonatomic) TweetCommentView *tweetCommentView;
@property (strong,nonatomic) ShareJoinView *joinView;
@property (strong,nonatomic) UIButton *commentButton;
@property (strong,nonatomic) UIButton *praiseButton;

@property (strong,nonatomic) NSAttributedString *topAttachString;
@property (strong,nonatomic) NSAttributedString *commentAttachString;
@property (strong,nonatomic) NSAttributedString *praiseAttachString;


@property (strong,nonatomic) UIView *line;

@end

@implementation TweetListCell

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"login"
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"logOut"
                                                 object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:ConcernStateChanged
                                                  object:nil];
    
}

-(void)concernStateChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    //    if ([userInfo[@"uid"] isEqualToString:_model.uid])
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *array = [ApplicationDelegate.synchronizeManager findIssuesInTable:ConcernList
                                                                                 Match:_model.uid];
            dispatch_async(dispatch_get_main_queue(), ^{
                _model.attentionActionState = 0;
                [_activityView stopAnimating];
                _activityView.hidden = YES;
                if (array.count > 0)
                {
                    _cancelAttentionButton.hidden = NO;
                    _attentionButton.hidden = YES;
                }
                else
                {
                    _cancelAttentionButton.hidden = YES;
                    _attentionButton.hidden = NO;
                }
            });
        });
        
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self initSubViews];
        [self setLayouts];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(concernStateChange:)
                                                    name:@"login"
                                                  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(concernStateChange:)
                                                    name:@"logOut"
                                                  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(concernStateChange:)
                                                    name:ConcernStateChanged
                                                  object:nil];
        
    }
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.tweetUserInfoView];
    [self addSubview:self.attentionButton];
    [self addSubview:self.cancelAttentionButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.imagesBrowser];
    [self addSubview:self.tagView];
    [self addSubview:self.tweetCommentView];
    [self addSubview:self.joinView];
    [self addSubview:self.praiseButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.activityView];
    [self addSubview:self.line];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_tweetUserInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right).with.offset(-TweetUserInfoViewRightPadding);
        make.top.equalTo(weakSelf).with.offset(TweetUserInfoViewTopPadding);
        make.height.equalTo(@(TweetUserInfoHeight)).with.priorityHigh();
    }];
    [_attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.width.equalTo(@(AttentionButtonWidth));
        make.height.equalTo(@(AttentionButtonHeight));
        make.centerY.equalTo(_tweetUserInfoView.mas_centerY);
    }];
    
    [_cancelAttentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.width.equalTo(@(AttentionButtonWidth));
        make.height.equalTo(@(AttentionButtonHeight));
        make.centerY.equalTo(_tweetUserInfoView.mas_centerY);
    }];
    
    [_activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.width.equalTo(@(AttentionButtonWidth));
        make.height.equalTo(@(AttentionButtonHeight));
        make.centerY.equalTo(_tweetUserInfoView.mas_centerY);
        
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(52.5);
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(TweetUserInfoHeight + TweetUserInfoViewTopPadding);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(52.5);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(-3);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
    
    [_imagesBrowser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(2);
        make.left.equalTo(weakSelf.mas_left).with.offset(52.5);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imagesBrowser.mas_bottom).with.offset(2);
        make.left.equalTo(_imagesBrowser.mas_left);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
    [_tweetCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagView.mas_bottom).with.offset(2);
        make.left.equalTo(weakSelf.mas_left).with.offset(52.5);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
    
    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@(JoinViewHeight));
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-7);
        make.width.equalTo(@(CommentButtonWidth));
        make.height.equalTo(@20);
    }];
    
    //    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(_commentButton.mas_left);
    //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-7);
    //        make.width.equalTo(@(CollectButtonWidth));
    //        make.height.equalTo(@20);
    //    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-0.5);
        make.height.equalTo(@.5);
    }];
}

-(void)setContentWithModel:(TweetListModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array;
        array =
        [ApplicationDelegate.synchronizeManager findIssuesInTable:ConcernList
                                                            Match:_model.uid];
        NSMutableAttributedString *titleAttr = [NSMutableAttributedString new];
        if (model.isTop.integerValue == 1)
        {
            [titleAttr appendAttributedString:self.topAttachString];
            [titleAttr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
        }
        [titleAttr appendAttributedString:[[NSAttributedString alloc]initWithString:model.title]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _titleLabel.attributedText = titleAttr;
            if (_model.attentionActionState == 1)
            {
                _cancelAttentionButton.hidden = YES;
                _attentionButton.hidden = YES;
                _activityView.hidden = NO;
                [_activityView startAnimating];
            }
            else if (array.count > 0)
            {
                _cancelAttentionButton.hidden = NO;
                _attentionButton.hidden = YES;
                [_activityView stopAnimating];
                _activityView.hidden = YES;
            }
            else
            {
                _cancelAttentionButton.hidden = YES;
                _attentionButton.hidden = NO;
                [_activityView stopAnimating];
                _activityView.hidden = YES;
            }
        });
    });
    WeakObject(weakSelf);
    if (model.type.integerValue == 3)
    {
        _commentButton.hidden = YES;
        _joinView.hidden = NO;
        //        [_praiseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        //            make.top.equalTo(_imagesBrowser.mas_bottom).with.offset(3);
        //            make.width.equalTo(@(CollectButtonWidth));
        //            make.height.equalTo(@20);
        //        }];
        _praiseButton.frame = CGRectMake(DeviceWidth - 10 - CollectButtonWidth, model.totalHeight - 93, CollectButtonWidth, 20);
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-80);
        }];
        [_joinView setContentWithArray:model.headIcons
                withNumberOfJoinPeople:[NSString stringWithFormat:@"%d",model.commentCount.intValue]];
    }
    else
    {
        _commentButton.hidden = NO;
        _joinView.hidden = YES;
        //        [_praiseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(_commentButton.mas_left);
        //            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-7);
        //            make.width.equalTo(@(CollectButtonWidth));
        //            make.height.equalTo(@20);
        //        }];
        _praiseButton.frame = CGRectMake(DeviceWidth - 10 - CollectButtonWidth*2, model.totalHeight - 27, CollectButtonWidth, 20);
        
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        }];
        
    }
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(model.titleHeight));
    }];
    if (model.titleHeight == 0)
    {
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(model.contentHeight));
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
        }];
    }
    else
    {
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(model.contentHeight));
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(-3);
        }];
    }
    [_imagesBrowser mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(model.imagesHeight));
    }];
    if (model.imagesHeight == 0) {
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(model.tagHeight));
            make.top.equalTo(_imagesBrowser.mas_bottom).with.offset(-3);
        }];
    }
    else
    {
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(model.tagHeight));
            make.top.equalTo(_imagesBrowser.mas_bottom).with.offset(2);
        }];
    }
    
    if (_model.tagHeight == 0)
    {
        _tagView.hidden = YES;
    }
    else
    {
        _tagView.hidden = NO;
    }
    
    [_tweetCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(model.commentHeight));
    }];
    
    [self setContent:model];
    [_tweetUserInfoView setContentWithUserInfo:@{   @"url":model.headurl ,
                                                    @"uid":model.uid ,
                                                    @"nickname":model.nickname,
                                                    @"level":model.level,
                                                    @"location":model.location ,
                                                    @"time":model.createTime,
                                                    @"isMaster":model.ismaster.stringValue}];
    [self setCommentButtonAndPraiseButton:model];
    [_imagesBrowser setContentWithArray:model.pics];
    [_tagView setContentWithTags:model.tags];
    
    if (model.type.integerValue != 3)
    {
        [_tweetCommentView setContentWithArray:model.commentList];
        _tweetCommentView.hidden = NO;
    }
    else
    {
        _tweetCommentView.hidden = YES;
    }
    
}

-(void)setCommentButtonAndPraiseButton:(TweetListModel *)model
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableAttributedString *commentAttr = [NSMutableAttributedString new];
        [commentAttr appendAttributedString:self.commentAttachString];
        [commentAttr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
        [commentAttr appendAttributedString:[[NSAttributedString alloc]initWithString:[StringTools number:model.commentCount.floatValue]]];
        [commentAttr addAttributes:@{NSForegroundColorAttributeName:[ColorTools timeColor],
                                     NSFontAttributeName:[UIFont systemFontOfSize:12]}
                             range:NSMakeRange(0, commentAttr.length)];
        
        NSMutableAttributedString *praiseAttr = [NSMutableAttributedString new];
        [praiseAttr appendAttributedString:self.praiseAttachString];
        [praiseAttr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
        [praiseAttr appendAttributedString:[[NSAttributedString alloc]initWithString:[StringTools number:model.praiseCount.floatValue]]];
        [praiseAttr addAttributes:@{NSForegroundColorAttributeName:[ColorTools timeColor],
                                    NSFontAttributeName:[UIFont systemFontOfSize:12]}
                            range:NSMakeRange(0, praiseAttr.length)];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_commentButton setAttributedTitle:commentAttr
                                      forState:UIControlStateNormal];
            [_praiseButton setAttributedTitle:praiseAttr
                                     forState:UIControlStateNormal];
        });
    });
}

-(void)setContent:(TweetListModel *)model
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableAttributedString *contentAttr = [NSMutableAttributedString new];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        if (IOS_SYSTEM < 9.0) {
            [paragraphStyle1 setLineSpacing:4];
        }
        else
        {
            [paragraphStyle1 setLineSpacing:0.1];
        }
        if (model.isTop.integerValue == 1 && model.title.length == 0)
        {
            [contentAttr appendAttributedString:self.topAttachString];
        }
        [contentAttr appendAttributedString:[[NSAttributedString alloc]initWithString:model.content]];
        [contentAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentAttr.string length])];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_contentLabel setAttributedText:contentAttr];
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        });
    });
    
}

#pragma mark - 事件

-(void)attention
{
//    if ([MainTabBar.currentUser.uid isEqualToString:_model.uid])
//    {
//        [TNToast showWithText:@"不能关注自己"];
//        return;
//    }
//    
//    if (MainTabBar.currentUser.uid.length > 0)
//    {
//        [self routerEventWithName:AttentionButtonTapped
//                         userInfo:@{@"model":_model}];
//        [_activityView startAnimating];
//        _activityView.hidden = NO;
//        _attentionButton.hidden = YES;
//        _cancelAttentionButton.hidden = YES;
//        _model.attentionActionState = 1;
//    }
//    
//    else
//    {
//        [LiJumpOBJ jumpToLoginViewControllerWithNavigationController:MainTabBar.navigationController];
//    }
}

-(void)cancelAttention
{
    
//    if (MainTabBar.currentUser.uid.length > 0)
//    {
//        [self routerEventWithName:CancelAttentionButtonTapped
//                         userInfo:@{@"model":_model}];
//        [_activityView startAnimating];
//        _activityView.hidden = NO;
//        _attentionButton.hidden = YES;
//        _cancelAttentionButton.hidden = YES;
//        _model.attentionActionState = 1;
//    }
//    else
//    {
//        [LiJumpOBJ jumpToLoginViewControllerWithNavigationController:MainTabBar.navigationController];
//    }
//    
}

-(void)praise
{
//    if (MainTabBar.currentUser.uid.length > 0)
//    {
//        [self routerEventWithName:PraiseButtonTapped
//                         userInfo:@{@"model":_model}];
//    }
//    else
//    {
//        [LiJumpOBJ jumpToLoginViewControllerWithNavigationController:MainTabBar.navigationController];
//    }
}

-(void)comment
{
    [self routerEventWithName:CommentButtonTapped
                     userInfo:@{@"model":_model}];
}

#pragma mark - 属性

-(TweetUserInfoView *)tweetUserInfoView
{
    if (_tweetUserInfoView == nil)
    {
        _tweetUserInfoView = [TweetUserInfoView new];
    }
    return _tweetUserInfoView;
}

-(UIButton *)attentionButton
{
    if (_attentionButton == nil)
    {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton addTarget:self
                             action:@selector(attention)
                   forControlEvents:UIControlEventTouchUpInside];
        [_attentionButton setImage:[UIImage imageNamed:@"btn_shequ_unattent"]
                          forState:UIControlStateNormal];
        _attentionButton.hidden = YES;
    }
    return _attentionButton;
}

-(UIButton *)cancelAttentionButton
{
    if (_cancelAttentionButton == nil)
    {
        _cancelAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelAttentionButton addTarget:self
                                   action:@selector(cancelAttention)
                         forControlEvents:UIControlEventTouchUpInside];
        [_cancelAttentionButton setImage:[UIImage imageNamed:@"btn_shequ_attent"]
                                forState:UIControlStateNormal];
        _cancelAttentionButton.hidden = YES;
    }
    return _cancelAttentionButton;
}



-(ImagesBrowser *)imagesBrowser
{
    if (_imagesBrowser == nil)
    {
        _imagesBrowser = [ImagesBrowser new];
    }
    return _imagesBrowser;
}

-(TagView *)tagView
{
    if (_tagView == nil)
    {
        _tagView = [TagView new];
    }
    return _tagView;
}

-(UIButton *)praiseButton
{
    if (_praiseButton == nil)
    {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseButton addTarget:self
                          action:@selector(praise)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

-(UIButton *)commentButton
{
    if (_commentButton == nil)
    {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton addTarget:self
                           action:@selector(comment)
                 forControlEvents:UIControlEventTouchUpInside];
        //        [_commentButton setImage:[UIImage imageNamed:@"ico_shequ_comment_count"]
        //                        forState:UIControlStateNormal];
        //
    }
    return _commentButton;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _titleLabel.textColor = [ColorTools titleColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        _contentLabel.textColor = [ColorTools titleColor];
        _contentLabel.numberOfLines = 4;
    }
    return _contentLabel;
}


-(TweetCommentView *)tweetCommentView
{
    if (_tweetCommentView == nil)
    {
        _tweetCommentView = [TweetCommentView new];
    }
    return _tweetCommentView;
}

-(ShareJoinView *)joinView
{
    if (_joinView == nil)
    {
        _joinView = [ShareJoinView new];
        _joinView.hidden = YES;
    }
    return _joinView;
}

-(NSAttributedString *)topAttachString
{
    if (_topAttachString == nil)
    {
        NSTextAttachment *topAttach = [NSTextAttachment new];
        topAttach.image = [UIImage imageNamed:@"ico_shequ_zhiding"];
        [topAttach adjustY:-2];
        _topAttachString = [NSAttributedString attributedStringWithAttachment:topAttach];
    }
    return _topAttachString;
}

-(NSAttributedString *)praiseAttachString
{
    if (_praiseAttachString == nil)
    {
        NSTextAttachment *praiseAttach = [NSTextAttachment new];
        praiseAttach.image = [UIImage imageNamed:@"ico_shequ_praise_count_nor"];
        [praiseAttach adjustY:-4];
        _praiseAttachString = [NSAttributedString attributedStringWithAttachment:praiseAttach];
    }
    return _praiseAttachString;
}

-(NSAttributedString *)commentAttachString
{
    if (_commentAttachString == nil)
    {
        NSTextAttachment *commentAttach = [NSTextAttachment new];
        commentAttach.image = [UIImage imageNamed:@"ico_shequ_comment_count"];
        [commentAttach adjustY:-4];
        _commentAttachString = [NSAttributedString attributedStringWithAttachment:commentAttach];
    }
    return _commentAttachString;
}

-(UIActivityIndicatorView *)activityView
{
    if (_activityView == nil)
    {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

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
