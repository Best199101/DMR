//
//  AtUserCell.m
//  happigo
//
//  Created by fei on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "AtUserCell.h"
#import "NSString+Size.h"

#import "ColorTools.h"

#import "UIImageView+DMRLoading.h"
#import "Global.h"


@interface AtUserCell ()

@property(nonatomic,strong) UIImageView *userHeader;
@property(nonatomic,strong) UIImageView *levelIMG;
@property(nonatomic,strong) UILabel *nickName;
@property(nonatomic,strong) UILabel *Userdescription;
@property(nonatomic, strong) UIView *lineView;


@end



@implementation AtUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
        [self setLayoutSubviews];
    }
    return self;
}

- (void)initSubviews{
    [self.contentView addSubview:self.userHeader];
    [self.contentView addSubview:self.levelIMG];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.Userdescription];
    [self.contentView addSubview:self.lineView];
}

- (void)setLayoutSubviews{
    
    __weak typeof(self) weakself = self;
    [self.userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).offset(15);
        make.left.equalTo(weakself.contentView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        
    }];
    [self.levelIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userHeader.mas_top).offset(30);
        make.left.equalTo(weakself.userHeader.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.userHeader.mas_right).offset(10);
        make.top.equalTo(weakself.userHeader.mas_top);
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@0.1);
    }];
    [self.Userdescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nickName.mas_left);
        make.top.equalTo(weakself.nickName.mas_bottom);
        make.height.greaterThanOrEqualTo(@20);
        make.right.equalTo(weakself.contentView.mas_right).offset(-10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.bottom.right.equalTo(weakself.contentView);
    }];
    
}

-(void)setcontentWithModel1:(AtUserModel *)model{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", KResoureURL, model.head_img_url];
    
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"load_avatar_size80"] completed:nil];
    
    self.nickName.text = model.nickname;
    
    
    if (model.desc != nil || ![model.desc isKindOfClass:[NSNull class]]) {
        
        model.desc.length > 0 ? (self.Userdescription.text = model.desc) : (self.Userdescription.text = @"这人有点神秘,关注才能解密~~");
        
    } else{
        self.Userdescription.text = @"这人有点神秘,关注才能解密~~";
    }
    
    if (model.ismaster.intValue == 1) {
        [self.levelIMG setImage:[UIImage imageNamed:@"icon_rank_v"]];
    }

    
}


-(void)loadImageWithOutRandomColorBySourceString:(NSString *)string IMG:(UIImageView *)image
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
        else if ([string rangeOfString:@".jpeg"].location != NSNotFound)  {
            key = @".jpeg";
            str = [NSString stringWithFormat:@"_%d-%d.jpeg", width, height];
        }
        else if ([string rangeOfString:@".JPG"].location != NSNotFound)  {
            key = @".JPG";
            str = [NSString stringWithFormat:@"_%d-%d.JPG", width, height];
        }
        else if ([string rangeOfString:@".jpg"].location != NSNotFound)  {
            key = @".jpg";
            str = [NSString stringWithFormat:@"_%d-%d.jpg", width, height];
        }
    }
    NSString *temStr = [string stringByReplacingOccurrencesOfString:key withString:str];
    NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",header, temStr];
    //     处理placeHolder图片和加载失败的图片
    //        int imageValue = (arc4random() % 9) + 1;
    //        [self loadRandomColor:imageValue];
    //去服务器请求图片
    [image sd_setImageWithURL:[NSURL URLWithString:imgURLStr]
            placeholderImage:[UIImage imageNamed:@"avatar_shequ_left_unlogin"]];
}

-(void)setcontentWithModel2:(AtUserModel *)model{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", KResoureURL, model.head_img_url];
    
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"load_avatar_size80"] completed:nil];
    
    
    self.nickName.text = model.nickname;
    
    
    if (model.desc != nil || ![model.desc isKindOfClass:[NSNull class]]) {
        
        model.desc.length > 0 ? (self.Userdescription.text = model.desc) : (self.Userdescription.text = @"");
        
    } else{
        self.Userdescription.text = @"";
    }
    
    
    if (model.ismaster.intValue == 1) {
        [self.levelIMG setImage:[UIImage imageNamed:@"icon_rank_v"]];
    }
    
}


+(CGFloat)heightForCell:(AtUserModel *)model{
//    CGFloat height = [model.desc SizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(WindowSize.width - 30, CGFLOAT_MAX) ].height;
//    if (height < 20) {
//        return 60;
//    } else{
//       height = height + 40;
//    }
    CGFloat height = 70;
    
    return height;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(UIImageView *)userHeader{
    if (_userHeader == nil) {
        _userHeader = [UIImageView new];
        _userHeader.cornerRadius = 20;
    }
    return _userHeader;
}

-(UIImageView *)levelIMG{
    if (_levelIMG == nil) {
        _levelIMG = [UIImageView new];
        
        
    }
    return _levelIMG;
}

-(UILabel *)nickName{
    if (_nickName == nil) {
        _nickName = [UILabel new];
        _nickName.textColor = [ColorTools nickNameColor];
        _nickName.font = [UIFont systemFontOfSize:14];
        
    }
    return _nickName;
}


- (UILabel *)Userdescription{
    if (_Userdescription == nil) {
        _Userdescription = [UILabel new];
        _Userdescription.numberOfLines = 0;
        _Userdescription.textColor = [ColorTools titleColor];
        _Userdescription.font = [UIFont systemFontOfSize:14];
        _Userdescription.numberOfLines = 1;
    }
    return _Userdescription;
}

-(UIView *)lineView{
    if (nil == _lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [ColorTools lineColor];
    }
    return _lineView;
}

@end
