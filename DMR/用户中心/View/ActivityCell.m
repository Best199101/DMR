//
//  ActivityCell.m
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+DMRLoading.h"
#import "UIResponder+Router.h"
#import "ThemeActivitiesModel.h"


NSString *const ActivitybgTap = @"ActivitybgTap";

@interface ActivityCell ()

// 活动背景图
@property(nonatomic, strong) UIImageView *bgView;

@end


@implementation ActivityCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [self setLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

-(void)initSubViews{
    [self.contentView addSubview:self.bgView];
}
-(void)setLayout{
    WeakObject(weakSelf);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.contentView.mas_top).offset(0);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(17);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-17);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-17);
    }];
}

// 配置内容
-(void)setContentWithModel:(ActivitiesModel *)model{
    
    [self.bgView loadImageWithRandomColorBySourceString:model.pic Header:KResoureURL width:0 Height:0];
    
}

-(void)bgTap{
    
    [self routerEventWithName:ActivitybgTap userInfo:@{@"indexPath":self.index}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIImageView new];
        _bgView.contentMode = UIViewContentModeScaleToFill;
//        _bgView.image = [UIImage imageNamed:@"view_common_loading"];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] init];
        [bgTap addTarget:self action:@selector(bgTap)];
        [_bgView addGestureRecognizer:bgTap];
        _bgView.userInteractionEnabled = YES;

    }
    return _bgView;
}


@end
