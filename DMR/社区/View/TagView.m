//
//  tagView.m
//  happigo
//
//  Created by 李海龙 on 15/12/25.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "tagView.h"
#import "Masonry.h"

#define kPadding        10
#define kTagViewHeight  28

NSString *const TagLists = @"TagLists";

@interface TagView ()
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *indexButton;
@property (nonatomic, strong) NSArray *tags;
@end

@implementation TagView

-(instancetype)init{
    if (self = [super init]) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    [self addSubview:self.imageButton];
    [self addSubview:self.scrollView];
}

-(void)setLayouts{
    __weak typeof(self)weakSelf = self;
    self.indexButton = self.imageButton;
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.mas_equalTo(-3);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(weakSelf.imageButton.mas_right).offset(kPadding);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(weakSelf);
    }];
}

#pragma mark - 公有方法

-(void)setContentWithTags:(NSArray *)tags
{
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    _tags = tags;
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i < tags.count; i++) {
        UIButton *newButton = [UIButton new];
        [self.scrollView addSubview:newButton];
        newButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [newButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [newButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            if (i == 0) {
                make.left.mas_equalTo(0);
            }else{
                make.left.mas_equalTo(weakSelf.indexButton.mas_right).offset(kPadding);
            }
            make.bottom.mas_equalTo(0);
            make.width.lessThanOrEqualTo(@(200));
            newButton.tag = 100 +i;
        }];
        newButton.tag = 100 +i;
        [newButton setTitle:tags[i] forState:UIControlStateNormal];
        [newButton addTarget:self
                      action:@selector(tagLists:)
            forControlEvents:UIControlEventTouchUpInside];
        
        self.indexButton = newButton;
    }
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width , self.bounds.size.height);
}

#pragma mark - 点击

-(void)tagLists:(UIButton *)sender{
    NSString *tagString = _tags[sender.tag - 100];
    NSDictionary *dic = @{@"tagList":tagString};
}

#pragma mark - 属性

-(UIButton *)imageButton{
    if (nil == _imageButton) {
        _imageButton = [UIButton new];
        [_imageButton setImage:[UIImage imageNamed:@"ico_shequ_tag"]
                      forState:UIControlStateNormal];
        _imageButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageButton;
}

-(UIScrollView *)scrollView{
    if (nil == _scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = NO;
    }
    
    
    return _scrollView;
}

+(CGFloat)HeightWithTags:(NSArray *)tags
{
    if(tags && tags.count > 0)
    {
        return kTagViewHeight;
    }
    else
    {
        return 0.0;
    }
}

@end
