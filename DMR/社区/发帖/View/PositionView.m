//
//  PositionView.m
//  测试commentView
//
//  Created by 李海龙 on 16/1/5.
//  Copyright © 2016年 李海龙. All rights reserved.
//

#import "PositionView.h"
#import "INTULocationManager.h"


#import "Masonry.h"


#define kHeight 24

@interface PositionView ()

@property (nonatomic, strong) UIView *lineView;
//未定位时显示的View及子元素
@property (nonatomic, strong) UIView *notShowPositionView;
@property (nonatomic, strong) UIButton *notShowPositionButton;
//定位时显示的View及子元素
@property (nonatomic, strong) UIView *showPositionView;
@property (nonatomic, strong) UIButton *showPositionButton;
@property (nonatomic, strong) UIView *showPositionLineView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation PositionView


-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubViews];
        [self setLayouts];
        _location = @"";
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    [self addSubview:self.lineView];
    [self addSubview:self.numberLabel];
    [self.notShowPositionView addSubview:self.notShowPositionButton];
    [self.notShowPositionView addSubview:self.activityIndicatorView];
    [self addSubview:self.notShowPositionView];
    [self addSubview:self.showPositionView];
    [self.showPositionView addSubview:self.showPositionButton];
    [self.showPositionView addSubview:self.showPositionLineView];
    [self.showPositionView addSubview:self.cancelButton];
    
    // 李海龙
    
//    if ([MainTabBar.location isEqualToString:@""]) {
//        self.notShowPositionView.hidden = NO;
//        self.showPositionView.hidden = YES;
//    }else{
//        [self.showPositionButton setTitle:MainTabBar.location forState:UIControlStateNormal];
//        self.notShowPositionView.hidden = YES;
//        self.showPositionView.hidden = NO;
//    }
}

-(void)setLayouts{
    __weak typeof(self)weakSelf = self;
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(.5);
    }];
    // 未显示位置
    [self.notShowPositionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.notShowPositionView.mas_top).offset(2);
        make.left.equalTo(weakSelf.notShowPositionView.mas_left).offset(10);
        make.bottom.equalTo(weakSelf.notShowPositionView.mas_bottom).offset(-2);
        make.width.lessThanOrEqualTo(@(200));
        make.right.equalTo(weakSelf.notShowPositionView.mas_right).offset(-10);
    }];
    
    [self.notShowPositionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(7.5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-7.5);
        make.right.equalTo(weakSelf.notShowPositionButton.mas_right).offset(+10);
    }];
    
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.notShowPositionView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //显示位置
    [self.showPositionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showPositionView.mas_left).offset(10);
        make.centerY.equalTo(weakSelf.showPositionView);
        make.height.mas_equalTo(18);
        make.width.lessThanOrEqualTo(@(200));
    }];
    
    [self.showPositionLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showPositionView.mas_top);
        make.left.equalTo(weakSelf.showPositionButton.mas_right).offset(3);
        make.bottom.equalTo(weakSelf.showPositionView.mas_bottom);
        make.width.equalTo(@(0.5));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.showPositionView);
        make.left.equalTo(weakSelf.showPositionLineView.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    [self.showPositionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(24);
        make.right.equalTo(weakSelf.cancelButton.mas_right).offset(+8);
    }];
    
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(7.5);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-7.5);
        make.width.lessThanOrEqualTo(@(100));
    }];
}

#pragma mark - 公有方法

-(void)setContentWithNumber:(NSInteger)number
{
    NSString *numberString = [NSString stringWithFormat:@"%ld/1000",number];
    NSMutableAttributedString *numberAttrString =
    [[NSMutableAttributedString alloc]initWithString:numberString];
    NSRange range1 = [numberString rangeOfString:[NSString stringWithFormat:@"%ld",number]];
    NSRange range2 = [numberString rangeOfString:@"1000"];

    if (number > 1000)
    {
        [numberAttrString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                                  range:range1];
        [numberAttrString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                                  range:range2];
    }
    else
    {
        [numberAttrString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                                  range:range1];
        [numberAttrString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                                  range:range2];
    }
    self.numberLabel.attributedText = numberAttrString;
}

#pragma mark - 事件

-(void)cancelSelectedLocation{
    self.notShowPositionView.hidden = NO;
    self.showPositionView.hidden = YES;
}

-(void)selectedLocation{
    [self.activityIndicatorView startAnimating];
    [self getLocation];
    self.notShowPositionButton.enabled = NO;
}

#pragma mark - 定位

-(void)getLocation{
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:20.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (error)
             {
                 self.notShowPositionView.hidden = NO;
                 self.notShowPositionButton.enabled = YES;
                 [self.activityIndicatorView stopAnimating];
                 self.showPositionView.hidden = YES;
//                 [TNToast showWithText:@"定位失败"];
                 
                 return;
             }
             if(placemarks.count > 0)
             {
                 CLPlacemark *myPlacemark = placemarks[0];
                 NSString *zone = myPlacemark.subLocality;
                 NSString *city1 = myPlacemark.administrativeArea;
                 
                 // 李海龙
//                 [self.showPositionButton setTitleForNormalState:city1 && zone ? [NSString stringWithFormat:@"%@",city1] : @""];
                 self.notShowPositionView.hidden = YES;
                 self.notShowPositionButton.enabled = YES;
                 [self.activityIndicatorView stopAnimating];
                 self.showPositionView.hidden = NO;
                 _location = city1 && zone ? [NSString stringWithFormat:@"%@",city1] : @"";
             }
         }];
    }];
}


#pragma mark - 属性
-(UIActivityIndicatorView *)activityIndicatorView{
    if (nil == _activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityIndicatorView;
}

-(UIView *)lineView{
    if (nil == _lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

-(UIButton *)notShowPositionButton{
    if (nil == _notShowPositionButton) {
        _notShowPositionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notShowPositionButton setImage:[UIImage imageNamed:@"icon_whitelog_location"] forState:UIControlStateNormal];
        [_notShowPositionButton setTitle:@"显示位置" forState:UIControlStateNormal];
        [_notShowPositionButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_notShowPositionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_notShowPositionButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
        [_notShowPositionButton addTarget:self action:@selector(selectedLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notShowPositionButton;
}

-(UIView *)notShowPositionView{
    if (nil == _notShowPositionView) {
        _notShowPositionView = [UIView new];
        _notShowPositionView.layer.cornerRadius = 12.5;
        _notShowPositionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _notShowPositionView.layer.borderWidth = 0.5f;
    }
    return _notShowPositionView;
}
-(UIButton *)showPositionButton{
    if (nil == _showPositionButton) {
        _showPositionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showPositionButton setImage:[UIImage imageNamed:@"ico_shequ_location_pre"] forState:UIControlStateNormal];
        [_showPositionButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        // 李海龙
//        [_showPositionButton setTitleColor:KPurpleColor forState:UIControlStateNormal];
        [_showPositionButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
    }
    return _showPositionButton;
}

-(UIView *)showPositionLineView{
    if (nil == _showPositionLineView) {
        _showPositionLineView = [UIView new];
        _showPositionLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _showPositionLineView;
}

-(UIView *)showPositionView{
    if (nil == _showPositionView) {
        _showPositionView = [UIView new];
        _showPositionView.layer.cornerRadius = 12.5f;
        _showPositionView.layer.borderWidth = 0.5f;
        _showPositionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _showPositionView;
}

-(UIButton *)cancelButton{
    if (nil == _cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"ico_shequ_location_close"] forState:UIControlStateNormal];
        [_cancelButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        _cancelButton.layer.cornerRadius = 7.5f;
        [_cancelButton addTarget:self action:@selector(cancelSelectedLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UILabel *)numberLabel{
    if (nil == _numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _numberLabel;
}

@end
