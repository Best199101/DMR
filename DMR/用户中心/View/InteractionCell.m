//
//  InteractionCell.m
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "InteractionCell.h"

#import "UIResponder+Router.h"
#import "PersonInfoModel.h"

NSString *const InteractionlogoTap = @"InteractionlogoTap";

@interface InteractionCell ()



// 通知数
@property(nonatomic, strong) UIButton *notiNumber;
// 指示
@property(nonatomic, strong) UIImageView *arrowView;
// 图标
@property(nonatomic, strong) UIImageView *logoIMG;
// 主题
@property(nonatomic, strong) UIButton *titlebutton;
// 线
@property(nonatomic, strong) UIView *line;

@end




@implementation InteractionCell

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

- (void)initSubViews{
    
    [self.contentView addSubview:self.logoIMG];
    [self.contentView addSubview:self.titlebutton];
    [self.contentView addSubview:self.notiNumber];
    [self.contentView addSubview:self.arrowView];
    [self.contentView addSubview:self.line];
    
}

- (void)setLayout{
    
    WeakObject(weakSelf);
    
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(weakSelf.contentView.mas_left).offset(17);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    [self.titlebutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.logoIMG.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.logoIMG.mas_centerY);
        make.height.equalTo(@30);
        make.width.greaterThanOrEqualTo(@0.1);
    }];

    [self.notiNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-17);
        make.centerY.equalTo(weakSelf.logoIMG.mas_centerY);
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@10);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-17);
        make.centerY.equalTo(weakSelf.logoIMG.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.top.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.mas_left).offset(17);
        make.height.equalTo(@0.5);
    }];
}


// 配置内容
-(void)setContentWithModel:(NSString *)title img:(NSString *)img{
    
    [self.titlebutton setTitle:title forState:UIControlStateNormal];
    self.logoIMG.image = [UIImage imageNamed:img];
    if (self.indesPath.section == 0 && self.indesPath.row == 0) {
        self.line.hidden = YES;
    } else{
        self.line.hidden = NO;
    }
    
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
    [self routerEventWithName:InteractionlogoTap userInfo:@{@"indexpath":self.indesPath}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UIImageView *)logoIMG{
    if (_logoIMG == nil) {
        _logoIMG = [UIImageView new];
//        _logoIMG.backgroundColor = [UIColor yellowColor];
        UITapGestureRecognizer *logoTap = [[UITapGestureRecognizer alloc] init];
        [logoTap addTarget:self action:@selector(logoTap)];
        [_logoIMG addGestureRecognizer:logoTap];
        _logoIMG.userInteractionEnabled = YES;
    }
    return _logoIMG;
}
-(UIButton *)titlebutton{
    if (_titlebutton == nil) {
        _titlebutton = [UIButton new];
        _titlebutton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titlebutton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
        _titlebutton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        _titlebutton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titlebutton addTarget:self action:@selector(logoTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titlebutton;
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

-(UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithRed:209/255. green:209/255. blue:209/255. alpha:1.0];
    }
    return _line;
}

@end
