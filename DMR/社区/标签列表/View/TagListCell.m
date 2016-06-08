//
//  TagListCell.m
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TagListCell.h"
#import "ColorTools.h"
#import "UIImageView+DMRLoading.h"
#import "Global.h"

@interface TagListCell ()

@property (strong,nonatomic) UIImageView *tagImageView;
@property (strong,nonatomic) UILabel *tagLabel;
@property (strong,nonatomic) UILabel *lineLabel;

@end

@implementation TagListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        [self setLayouts];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.tagImageView];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.lineLabel];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagImageView.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(0);
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}

#pragma mark - 配置内容

//- (void)setContentWithArray:(NSArray *)array atIndex:(NSInteger)index{
//    if (!array.count) {
//        return;
//    }
//    _tagLabel.text = array[index];
//    [_tagImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //加载图片完成
//    }];
//}

- (void)setContentWithModel:(TagListModel *)model {
    _tagLabel.text = model.tag_name;
    int imageValue = (arc4random() % 9);
    [self loadRandomColor:imageValue];
    [self loadImageWithRandomColorBySourceString:model.icon
                                                   Header:KResoureURL
                                                    width:90
                                                   Height:90];
}

-(void)loadRandomColor:(int)randomValue
{
    if (randomValue == 0)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorA];
    }
    else if (randomValue == 1)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorB];
    }
    else if (randomValue == 2)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorC];
    }
    else if (randomValue == 3)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorD];
    }
    else if (randomValue == 4)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorF];
    }
    else if (randomValue == 5)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorG];
    }
    else if (randomValue == 6)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorH];
    }
    else if (randomValue == 7)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorI];
    }
    else if (randomValue == 8)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorJ];
    }
    else if (randomValue == 9)
    {
        _tagImageView.backgroundColor = [ColorTools randomColorJ];
    }
    
}



-(void)loadImageWithRandomColorBySourceString:(NSString *)string
                                       Header:(NSString *)header
                                        width:(int)width
                                       Height:(int)height
{
    // 图片urlString添加width和height参数
    if ([string isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    if (!string.length || !header.length)  {
        string = @"";
        return;
    }
    
    NSString *str = @"";
    NSString *key = @"";
    
    if (width > 0 && height > 0) {
        
        if ([string rangeOfString:@".png"].location != NSNotFound)  {
            key = @".png";
            str = [NSString stringWithFormat:@"_%d-%d.png", width, height];
        }
        if ([string rangeOfString:@".jpeg"].location != NSNotFound)  {
            key = @".jpeg";
            str = [NSString stringWithFormat:@"_%d-%d.jpeg", width, height];
        }
        if ([string rangeOfString:@".JPG"].location != NSNotFound)  {
            key = @".JPG";
            str = [NSString stringWithFormat:@"_%d-%d.JPG", width, height];
        }
        if ([string rangeOfString:@".jpg"].location != NSNotFound)  {
            key = @".jpg";
            str = [NSString stringWithFormat:@"_%d-%d.jpg", width, height];
        }
    }
    NSString *temStr = [string stringByReplacingOccurrencesOfString:key withString:str];
    NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",header, temStr];
    //去服务器请求图片
    [_tagImageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
}

#pragma mark - 属性

- (UIImageView *)tagImageView {
    if (_tagImageView == nil) {
        _tagImageView = [UIImageView new];
        _tagImageView.cornerRadius = 5;
        _tagImageView.clipsToBounds = YES;
    }
    return _tagImageView;
}

- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [UILabel new];
        _tagLabel.numberOfLines = 1;
        _tagLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tagLabel.textAlignment = NSTextAlignmentLeft;
        _tagLabel.font = [UIFont systemFontOfSize:15.0];
        _tagLabel.textColor = [ColorTools titleColor];
    }
    return _tagLabel;
}

- (UILabel *)lineLabel {
    if (_lineLabel == nil) {
        _lineLabel = [UILabel new];
        _lineLabel.backgroundColor = [ColorTools lineColor];
    }
    return _lineLabel;
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
