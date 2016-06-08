//
//  TweetTagCell.m
//  happigo
//
//  Created by 李海龙 on 15/12/25.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "TweetTagCell.h"
#import "TagView.h"
#import "Global.h"
#define kTagPadding 10

@interface TweetTagCell ()

@property (nonatomic, strong) TagView *tagView;
@end

@implementation TweetTagCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    [self.contentView addSubview:self.tagView];
}

-(void)setLayouts{
    __weak typeof(self)weakSelf = self;
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
}

#pragma mark - 公有方法

-(void)setContentWithTags:(NSArray *)tags{
    [self.tagView setContentWithTags:tags];
}

#pragma mark - 属性

-(TagView *)tagView{
    if (nil == _tagView) {
        _tagView = [TagView new];
    }
    return _tagView;
}


@end
