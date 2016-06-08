//
//  AdvertisementViewController.m
//  DMR
//
//  Created by 李海龙 on 15/12/22.
//  Copyright © 2015年 wangzitao. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "Global.h"
#import "UIColor+HEX.h"
#import "AdvertisementAPI.h"

#define DetailButtonWidth           130
#define DetailButtonHeight          34
#define DetailButtonBottomPadding   45

@interface AdvertisementViewController ()<APIRequestManagerDelegate>

@property (nonatomic, strong) UIButton *advertisementButton;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) AdvertisementAPI *advertisementAPI;
@end

@implementation AdvertisementViewController


-(instancetype)init{
    if (self = [super init]) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.advertisementAPI startRequestWithParameters:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有

-(void)initSubViews{
    [self.view addSubview:self.advertisementButton];
    [self.view addSubview:self.detailButton];
    [self.view addSubview:self.skipButton];
}

-(void)setLayouts{
    
    __weak typeof(self)weakSelf = self;
    [self.advertisementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(DetailButtonWidth, DetailButtonHeight));
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-DetailButtonBottomPadding);
    }];
    
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(55, 34));
    }];
    
}

#pragma mark - 私有代理

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
    NSLog(@"%s",__FUNCTION__);
    if (apiManager == _advertisementAPI)
    {
        NSDictionary *JSON = [apiManager fetchDataWithTransformer:nil];
        NSLog(@"%@",JSON);
    }
    else
    {
    
    }
}

#pragma mark - 点击事件

-(void)selectAdvertisement{
    
}

-(void)checkAdvertisement{
    
}

-(void)skipAdvertisement{
    
}

#pragma mark - 属性

-(UIButton *)advertisementImageView{
    if (nil == _advertisementButton) {
        _advertisementButton = [UIButton new];
        [_advertisementButton addTarget:self
                          action:@selector(selectAdvertisement)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _advertisementButton;
}

-(UIButton *)detailButton{
    if (nil == _detailButton) {
        _detailButton = [UIButton new];
        [_detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_detailButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        _detailButton.layer.cornerRadius = 5.0f;
        _detailButton.layer.borderWidth = 1.0f;
        _detailButton.layer.borderColor = [UIColor grayColor].CGColor;
        
        [_detailButton addTarget:self
                                 action:@selector(checkAdvertisement)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

-(UIButton *)skipButton{
    if (nil == _skipButton) {
        _skipButton = [UIButton new];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipAdvertisement) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
    
}

-(AdvertisementAPI *)advertisementAPI
{
    if (_advertisementAPI == nil)
    {
        _advertisementAPI = [AdvertisementAPI new];
        _advertisementAPI.apiMangerCallBackDelegate = self;
    }
    return _advertisementAPI;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
