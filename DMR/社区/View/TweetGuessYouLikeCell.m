//
//  TweetGuessYouLikeCell.m
//  happigo
//
//  Created by fei on 15/12/25.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetGuessYouLikeCell.h"
#import "Global.h"
#define weightMargin 100

@interface TweetGuessYouLikeCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *goodsView;

@end


@implementation TweetGuessYouLikeCell

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

    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.goodsView];
}

- (void)setLayoutSubviews{
    
    __weak typeof(self) weekSelf = self;
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekSelf.contentView.mas_top).with.offset(5);
        make.right.equalTo(weekSelf.contentView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekSelf.contentView.mas_top).with.offset(25);
        make.left.equalTo(weekSelf.contentView.mas_left).with.offset(10);
        make.right.equalTo(weekSelf.goodsView.mas_left).with.offset(10);
        make.bottom.equalTo(weekSelf.contentView.mas_bottom).with.offset(-25);
    }];
    
}


- (void)setContentWithModel:(TweetGuessYouLikeModel *)model{
    
    self.contentLabel.text = model.str;
    [self.goodsView sd_setImageWithURL:nil placeholderImage:nil completed:nil];
}
+ (CGFloat)heightForModel:(TweetGuessYouLikeModel *)model{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    CGSize size = [model.str
                   boundingRectWithSize:CGSizeMake(DeviceWidth - weightMargin, CGFLOAT_MAX)
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

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 1;
    }
    return _contentLabel;
}

- (UIImageView *)goodsView{
    if (_goodsView == nil) {
        _goodsView = [UIImageView new];
    }
    return _goodsView;
}


@end
