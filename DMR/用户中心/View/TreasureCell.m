//
//  TreasureCell.m
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TreasureCell.h"
#import "UIResponder+Router.h"

NSString *const TreasurelogoTap = @"TreasurelogoTap";

@interface TreasureCell ()

// 通知数
@property(nonatomic, strong) UIButton *notiNumber;
// 图标
@property(nonatomic, strong) UIImageView *logoView;
// 标题
@property(nonatomic, strong) UIButton *titleButton;

// 背景
@property(nonatomic, strong) UIView *bgView;


@end



@implementation TreasureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [self setLayout];
        self.backgroundColor = [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.0];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}


- (void)initSubViews{
    
    [self.bgView addSubview:self.logoView];
    [self.bgView addSubview:self.titleButton];
    [self.bgView addSubview:self.notiNumber];
    [self.bgView addSubview:self.arrowView];
    [self.contentView addSubview:self.bgView];
    
}

- (void)setLayout{
    
    WeakObject(weakSelf);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
    }];
    
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(weakSelf.contentView.mas_left).offset(17);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.logoView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.logoView.mas_centerY);
        make.height.equalTo(@25);
        make.width.greaterThanOrEqualTo(@0.1);
    }];
    [self.notiNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-17);
        make.centerY.equalTo(weakSelf.logoView.mas_centerY);
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@10);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-17);
        make.centerY.equalTo(weakSelf.logoView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];
    

}

// 配置内容
-(void)setContentWithModel:(NSString *)title img:(NSString *)img{
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    self.logoView.image = [UIImage imageNamed:img];
}
-(void)setNotifyNumberHidden:(BOOL)hidden number:(NSString *)str{
    self.notiNumber.hidden = hidden;
    self.arrowView.hidden = !hidden;
    if (!hidden) {
        
        NSString *numberStr;
        if (str.intValue > 99) {
            numberStr = [NSString stringWithFormat:@"  99+  "];
        } else{
            numberStr = str;
        }
        [self.notiNumber setTitle:numberStr forState:UIControlStateNormal];
        
        if (str.intValue < 10) {
            
            [self.notiNumber mas_updateConstraints:^(MASConstraintMaker *make){
                make.width.equalTo(@20);
            }];
        }
        
    }

}

-(void)logoTap{
    [self routerEventWithName:TreasurelogoTap userInfo:@{@"indexpath":self.indesPath}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(UIImageView *)logoView{
    if (_logoView == nil) {
        _logoView = [UIImageView new];
        UITapGestureRecognizer *logoTap = [[UITapGestureRecognizer alloc] init];
        [logoTap addTarget:self action:@selector(logoTap)];
        [_logoView addGestureRecognizer:logoTap];
        _logoView.userInteractionEnabled = YES;

    }
    return _logoView;
}
-(UIButton *)titleButton{
    if (_titleButton == nil) {
        _titleButton = [UIButton new];
        [_titleButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];

        [_titleButton addTarget:self action:@selector(logoTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}


-(UIImageView *)arrowView{
    if (_arrowView == nil) {
        _arrowView = [UIImageView new];
        _arrowView.image = [UIImage imageNamed:@"btn_personal_center_listarrow"];
         _arrowView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *arrowTap = [[UITapGestureRecognizer alloc] init];
        [arrowTap addTarget:self action:@selector(logoTap)];
        [_arrowView addGestureRecognizer:arrowTap];
        _arrowView.userInteractionEnabled = YES;
    }
    return _arrowView;
}
-(UIButton *)notiNumber{
    if (_notiNumber == nil) {
        _notiNumber = [UIButton new];
        _notiNumber.layer.cornerRadius = 10;
        _notiNumber.backgroundColor = [UIColor colorWithRed:255/255. green:110/255. blue:155/255. alpha:1.0f];
        [_notiNumber setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _notiNumber.titleLabel.font = [UIFont systemFontOfSize:12];
        [_notiNumber setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0] forState:UIControlStateNormal];
        [_notiNumber addTarget:self action:@selector(logoTap) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _notiNumber;
}


-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}

@end
