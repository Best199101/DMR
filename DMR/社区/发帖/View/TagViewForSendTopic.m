//
//  tagViewForSendTopic.m
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TagViewForSendTopic.h"
#import "Masonry.h"

#define kPadding            10

@interface TagViewForSendTopic ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *tagButtonArray;
@property (nonatomic, strong) NSMutableArray *cancelButtonArray;

@end

@implementation TagViewForSendTopic

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubViews];
        [self setLayouts];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews
{
    self.tagButtonArray = [NSMutableArray new];
    self.cancelButtonArray = [NSMutableArray new];
    self.tags = [NSMutableArray new];
    [self addSubview:self.scrollView];
    [self reuseButton];
}

-(void)setLayouts
{
    __weak typeof(self)weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

-(void)reuseButton{
    for (int i = 0; i < 3; i++) {
        // 新建两个button，并添加到scrollview
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:tagButton];
        [self.scrollView addSubview:cancelButton];
        
        // 设置属性
        tagButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [tagButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        tagButton.backgroundColor = [UIColor colorWithRed:252./255 green:242./255 blue:242./255 alpha:1.0f];
        tagButton.hidden = NO;
        tagButton.layer.cornerRadius = 12.5f;
        
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"btn_shequ_topic_tag_del"] forState:UIControlStateNormal];
        cancelButton.tag = 100 +i;
        [cancelButton addTarget:self
                         action:@selector(cancel:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.tagButtonArray addObject:tagButton];
        [self.cancelButtonArray addObject:cancelButton];
    }
}

#pragma mark - 事件

-(void)cancel:(UIButton *)sender
{
    [self.tags removeObjectAtIndex:(sender.tag - 100)];
    [self setContentWithTags:self.tags];
}

-(void)setContentWithTags:(NSArray *)array
{
    for (UIButton *button in self.tagButtonArray) {
        button.hidden = YES;
    }
    
    for (UIButton *button in self.cancelButtonArray) {
        button.hidden = YES;
    }
    
    __weak typeof(self)weakSelf = self;
    
    for (int i = 0; i<array.count; i++) {
        
        NSString *titleStr = [NSString stringWithFormat:@"  %@  ",array[i]];
        
        UIButton *tagButton = self.tagButtonArray[i];
        UIButton *cancelButton = self.cancelButtonArray[i];
        [tagButton setTitle:titleStr forState:UIControlStateNormal];
        [tagButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.scrollView).offset(kPadding);
            make.bottom.equalTo(weakSelf.scrollView).offset(-kPadding);
            if (i == 0) {
                make.left.mas_equalTo(kPadding);
            }else{
                make.left.equalTo(((UIButton *)self.tagButtonArray[i-1]).mas_right).offset(2*kPadding);
            }
            make.width.lessThanOrEqualTo(@(500));
        }];
        tagButton.hidden = NO;
        [cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tagButton.mas_right).offset(-3);
            make.centerY.equalTo(tagButton.mas_top).offset(3);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        cancelButton.tag = 100 + i;
        cancelButton.hidden = NO;
    }
}


#pragma mark - 公有方法

-(void)addTags:(NSArray *)tags{
    if (_tags.count == 3)
    {
        return;
    }
    BOOL isExsit = NO;
    for (NSString *tag in _tags)
    {
        if ([tag isEqualToString:tags.firstObject])
        {
            isExsit = YES;
        }
    }
    if (isExsit == NO)
    {
        [self.tags addObjectsFromArray:tags];
        [self setContentWithTags:self.tags];
    }
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

#pragma mark - 属性

-(UIScrollView *)scrollView{
    if (nil == _scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = NO;
    }
    
    return _scrollView;
}

@end
