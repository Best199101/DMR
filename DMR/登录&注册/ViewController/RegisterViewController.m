//
//  RegisterViewController.m
//  happigo
//
//  Created by shklxmac111 on 16/2/22.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "RegisterViewController.h"
#import "BorderView.h"
#import "ColorTools.h"
#import "AreaViewController.h"
#import "NSString+PhoneNumber.h"

#import "IsOrNoForRegistAPI.h"
#import "GetIdentifyCodeAPI.h"
#import "RegistByMobileAPI.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<APIRequestManagerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) IsOrNoForRegistAPI *isOrNoForRegistAPI;
@property (nonatomic, strong) GetIdentifyCodeAPI *getIdentifyCodeAPI;
@property (nonatomic, strong) RegistByMobileAPI *registByMobileAPI;

@property (nonatomic, strong) NSString *areaNum;

@property (strong,nonatomic) UIImageView *logoImageView;
@property (strong,nonatomic) UIButton *areaCodeButton;
@property (strong,nonatomic) UITextField *phoneTextField;
@property (strong,nonatomic) UITextField *identifyingCode;

@property (nonatomic, strong) UIButton *areaButton;
@property (nonatomic, strong) BorderView *phoneBgView;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UIImageView *areaImgView;
@property (nonatomic, strong) UILabel *areaVerticalLine;

@property (nonatomic, strong) BorderView *codeBgView;
@property (nonatomic, strong) UILabel *codeTimeLabel;
@property (nonatomic, strong) UILabel *codeVerticalLine;

@property (nonatomic, strong) BorderView *nowPswBgView;
@property (nonatomic, strong) UITextField *settingNowPsw;

@property (nonatomic, strong) UIButton *registButton;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger countTime;

@property (nonatomic, assign) BOOL isCodeing;

@end

@implementation RegisterViewController

- (void)dealloc {
    
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _countTime = 60;
    _areaNum = @"86";
    _isCodeing = NO;
    
    [self initNavData];
    [self initSubviews];
    [self setLayouts];
}

#pragma mark - 初始化

- (void)initNavData {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_top_back"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(back)];
    self.title = @"注册";
}

- (void)initSubviews {
    [self.view addSubview:self.logoImageView];
    
    [self.view addSubview:self.phoneBgView];
    [self.view addSubview:self.areaLabel];
    [self.view addSubview:self.areaImgView];
    [self.view addSubview:self.areaVerticalLine];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.areaButton];
    
    [self.view addSubview:self.codeBgView];
    [self.view addSubview:self.identifyingCode];
    [self.view addSubview:self.codeTimeLabel];
    [self.view addSubview:self.codeVerticalLine];
    [self.view addSubview:self.areaCodeButton];
    
    [self.view addSubview:self.nowPswBgView];
    [self.view addSubview:self.settingNowPsw];
    
    [self.view addSubview:self.registButton];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(25);
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    //手机号
    [_phoneBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_bottom).with.offset(25);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(25);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-25);
        make.height.mas_equalTo(@50);
    }];
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_phoneBgView);
        make.left.equalTo(_phoneBgView.mas_left).with.offset(25);
        make.width.mas_equalTo(@40);
    }];
    [_areaImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_areaVerticalLine.mas_left).with.offset(-10);
        make.left.equalTo(_areaLabel.mas_right).with.offset(10);
        make.centerY.equalTo(_phoneBgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    [_areaVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_phoneBgView.mas_left).with.offset(83);
        make.left.equalTo(_areaImgView.mas_right).with.offset(10);
        make.top.equalTo(_phoneBgView.mas_top).with.offset(10);
        make.bottom.equalTo(_phoneBgView.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@0.5);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaVerticalLine.mas_right).with.offset(20);
        make.top.right.and.bottom.equalTo(_phoneBgView);
    }];
    [_areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.bottom.equalTo(_phoneBgView);
        make.right.equalTo(_areaVerticalLine.mas_left);
    }];
    //验证码
    [_codeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneBgView.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(25);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-25);
        make.height.mas_equalTo(@50);
    }];
    [_identifyingCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeBgView.mas_left).with.offset(25);
        make.top.and.bottom.equalTo(_codeBgView);
        make.right.equalTo(_codeTimeLabel.mas_left).with.offset(-5);
    }];
    [_codeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_codeBgView);
        make.right.equalTo(_codeVerticalLine.mas_left).with.offset(-10);
        make.width.mas_equalTo(@30);
    }];
    [_codeVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeBgView.mas_top).with.offset(10);
        make.bottom.equalTo(_codeBgView.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@0.5);
        make.right.equalTo(_areaCodeButton.mas_left).with.offset(-10);
    }];
    [_areaCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeBgView.mas_top).with.offset(10);
        make.bottom.and.right.equalTo(_codeBgView).with.offset(-10);
        make.width.mas_equalTo(@80);//？？？？？
    }];
    //设置新密码
    [_nowPswBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeBgView.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(25);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-25);
        make.height.mas_equalTo(@50);
    }];
    [_settingNowPsw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nowPswBgView.mas_left).with.offset(25);
        make.top.and.bottom.equalTo(_nowPswBgView);
        make.right.equalTo(_nowPswBgView.mas_right).with.offset(-10);
    }];
    //注册
    [_registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nowPswBgView.mas_bottom).with.offset(50);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(25);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-25);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 私有

- (void)back {

    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)areaButtonClick {
    //选择区号
    AreaViewController *area = [[AreaViewController alloc]init];
    area.areaNumber = ^(NSString *areaNumber) {
        _areaNum = areaNumber;
        NSString *content = [NSString stringWithFormat:@"+ %@",areaNumber];
        CGFloat width = [content boundingRectWithSize:CGSizeMake(Screen_width, 0)
                                               options:NSStringDrawingUsesLineFragmentOrigin |    NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                                            attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}
                                               context:nil].size.width + 1;
        [_areaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(width));
        }];
        _areaLabel.text = content;
    };
    [self.navigationController pushViewController:area animated:YES];
}

- (void)areaCodeButtonClick {
    //获取验证码点击事件
    [self.view endEditing:YES];
    
    if ([_areaNum isEqualToString:@"86"]) {
        if (_phoneTextField.text.length != 11) {
//            [TNToast showWithText:@"请输入正确的手机号码"];
            return;
        }
    }
    
    if (!_phoneTextField.text.length) {
//        [TNToast showWithText:@"请输入正确的手机号码"];
        return;
    } else {
        if (_isCodeing == YES) {
            return;
        }
        _isCodeing = YES;
        [self.isOrNoForRegistAPI startRequestWithAccount:_phoneTextField.text];
    }
}

- (void)registButtonClick {
    //注册点击事件
    [self.view endEditing:YES];
    
    if (!_phoneTextField.text.length) {
        
//        [TNToast showWithText:@"请输入手机号码"];
        return;
        
    }
    
    if (!_identifyingCode.text.length) {
        
//        [TNToast showWithText:@"请输入验证码"];
        return;
    }
    
    if (!(_settingNowPsw.text.length > 5 && _settingNowPsw.text.length < 17)) {
//        [TNToast showWithText:@"请设置密码长度为6-16位"];
        return;
    }
    
    
    [self.registByMobileAPI startRequestWithMobile:_phoneTextField.text password:_settingNowPsw.text code:_identifyingCode.text regSource:0 deviceId:deviceid];
    
}

- (void)configCodeAttrWithTimer {
    if ([_timer isValid]) {
        _areaCodeButton.alpha = 0.5;
        _areaCodeButton.enabled = NO;
    } else {
        [self configCodeAttr];
    }
}

- (void)configCodeAttr {
    if (_phoneTextField.text.length) {
        [self configCodeBtnEnable:YES alpha:1];
    } else {
        [self configCodeBtnEnable:NO alpha:0.5];
    }
}

- (void)configCodeBtnEnable:(BOOL)enable alpha:(CGFloat)alpha {
    _areaCodeButton.alpha = alpha;
    _areaCodeButton.enabled = enable;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDown:) userInfo:nil repeats:YES];
    [_timer fire];
    [self configCodeAttrWithTimer];
}

- (void)timerDown:(NSTimer *)timer {
    _countTime --;
    if (_countTime > -1) {
        _codeTimeLabel.text = [NSString stringWithFormat:@"%lds",(long)_countTime];
        [self configCodeBtnEnable:NO alpha:0.5];
        [self configCodeAttrWithTimer];
    } else {
        [timer invalidate];
        _codeTimeLabel.text = @"60s";
        [self configCodeAttrWithTimer];
        _countTime = 60;
    }
}

- (void)textChanged:(UITextField *)textField {
    if (_phoneTextField.text.length || _identifyingCode.text.length || _settingNowPsw.text.length) {
        _registButton.alpha = 1;
    } else {
        _registButton.alpha = 0.5;
    }
    
    [self configCodeAttrWithTimer];
}

#pragma mark - 网络请求回调

- (void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager {
    if ([apiManager isEqual:_isOrNoForRegistAPI])
    {
        NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
        BOOL isReg = [json[@"data"][@"isReg"] boolValue];
        if (isReg) {
            _isCodeing = NO;
//            [TNToast showWithText:@"手机号已经注册过了，赶紧去登录吧"];
            [self configCodeAttrWithTimer];
        } else {
            _isCodeing = YES;
            [self.getIdentifyCodeAPI startRequestWithMobile:_phoneTextField.text source:1 internationalNo:_areaNum];
        }
        
    } else if ([apiManager isEqual:_getIdentifyCodeAPI])
    {
        _isCodeing = NO;
        [self addTimer];
        
    } else if ([apiManager isEqual:_registByMobileAPI])
    {
//        [TNToast showWithText:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager {
//    [TNToast showWithText:apiManager.responseMessage];
    [self configCodeAttrWithTimer];
    
    if ([apiManager isEqual:_isOrNoForRegistAPI] || [apiManager isEqual:_getIdentifyCodeAPI]) {
        _isCodeing = NO;
    }
    
}

#pragma mark - textField代理

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

#pragma mark - 属性

- (IsOrNoForRegistAPI *)isOrNoForRegistAPI {
    if (_isOrNoForRegistAPI == nil) {
        _isOrNoForRegistAPI = [[IsOrNoForRegistAPI alloc]init];
        _isOrNoForRegistAPI.apiMangerCallBackDelegate = self;
    }
    return _isOrNoForRegistAPI;
}

- (GetIdentifyCodeAPI *)getIdentifyCodeAPI {
    if (_getIdentifyCodeAPI == nil) {
        _getIdentifyCodeAPI = [[GetIdentifyCodeAPI alloc]init];
        _getIdentifyCodeAPI.apiMangerCallBackDelegate = self;
    }
    return _getIdentifyCodeAPI;
}

- (RegistByMobileAPI *)registByMobileAPI {
    if (_registByMobileAPI == nil) {
        _registByMobileAPI = [[RegistByMobileAPI alloc]init];
        _registByMobileAPI.apiMangerCallBackDelegate = self;
    }
    return _registByMobileAPI;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"login_default_img"];
    }
    return _logoImageView;
}

- (UIButton *)areaButton {
    if (_areaButton == nil) {
        _areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaButton addTarget:self action:@selector(areaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaButton;
}

- (BorderView *)phoneBgView {
    if (_phoneBgView == nil) {
        _phoneBgView = [[BorderView alloc]init];
    }
    return _phoneBgView;
}

- (UILabel *)areaLabel {
    if (_areaLabel == nil) {
        _areaLabel = [[UILabel alloc]init];
        _areaLabel.text = @"+ 86";
        _areaLabel.textColor = [ColorTools phoneColor];
        _areaLabel.font = [UIFont systemFontOfSize:18];
    }
    return _areaLabel;
}

- (UIImageView *)areaImgView {
    if (_areaImgView == nil) {
        _areaImgView = [[UIImageView alloc]init];
        _areaImgView.image = [UIImage imageNamed:@"ico_login_arrow"];
    }
    return _areaImgView;
}

- (UILabel *)areaVerticalLine {
    if (_areaVerticalLine == nil) {
        _areaVerticalLine = [[UILabel alloc]init];
        _areaVerticalLine.backgroundColor = [ColorTools lightBorderColor];
    }
    return _areaVerticalLine;
}

- (UITextField *)phoneTextField {
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.textColor = [ColorTools phoneColor];
        _phoneTextField.font = [UIFont systemFontOfSize:18];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"请输入手机号";
        [_phoneTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (BorderView *)codeBgView {
    if (_codeBgView == nil) {
        _codeBgView = [[BorderView alloc]init];
    }
    return _codeBgView;
}

- (UITextField *)identifyingCode {
    if (_identifyingCode == nil) {
        _identifyingCode = [[UITextField alloc]init];
        _identifyingCode.textColor = [ColorTools phoneColor];
        _identifyingCode.font = [UIFont systemFontOfSize:14];
        _identifyingCode.placeholder = @"请输入验证码";
        _identifyingCode.delegate = self;
        _identifyingCode.keyboardType = UIKeyboardTypeNumberPad;
        [_identifyingCode addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _identifyingCode;
}

- (UILabel *)codeTimeLabel {
    if (_codeTimeLabel == nil) {
        _codeTimeLabel = [[UILabel alloc]init];
        _codeTimeLabel.text = @"60s";
        _codeTimeLabel.textColor = [ColorTools lightBorderColor];
        _codeTimeLabel.textAlignment = NSTextAlignmentRight;
        _codeTimeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _codeTimeLabel;
}

- (UILabel *)codeVerticalLine {
    if (_codeVerticalLine == nil) {
        _codeVerticalLine = [[UILabel alloc]init];
        _codeVerticalLine.backgroundColor = [ColorTools lightBorderColor];
    }
    return _codeVerticalLine;
}

- (UIButton *)areaCodeButton {
    if (_areaCodeButton == nil) {
        _areaCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_areaCodeButton setTitleColor:[ColorTools areaCodeColor] forState:UIControlStateNormal];
        _areaCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_areaCodeButton addTarget:self action:@selector(areaCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _areaCodeButton.backgroundColor = [ColorTools segmentViewColor];
        
        _areaCodeButton.alpha = 0.5;
        _areaCodeButton.enabled = NO;

        _areaCodeButton.layer.cornerRadius = 7.5;
        _areaCodeButton.clipsToBounds = YES;
    }
    return _areaCodeButton;
}

- (BorderView *)nowPswBgView {
    if (_nowPswBgView == nil) {
        _nowPswBgView = [[BorderView alloc]init];
    }
    return _nowPswBgView;
}

- (UITextField *)settingNowPsw {
    if (_settingNowPsw == nil) {
        _settingNowPsw = [[UITextField alloc]init];
        _settingNowPsw.textColor = [ColorTools phoneColor];
        _settingNowPsw.font = [UIFont systemFontOfSize:14];
        _settingNowPsw.placeholder = @"设置新密码";
        _settingNowPsw.delegate = self;
        _settingNowPsw.keyboardType = UIKeyboardTypeASCIICapable;
        _settingNowPsw.secureTextEntry = YES;
        [_settingNowPsw addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _settingNowPsw;
}

- (UIButton *)registButton {
    if (_registButton == nil) {
        _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registButton.backgroundColor = [ColorTools segmentViewColor];
        _registButton.alpha = 0.5;
        [_registButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _registButton.layer.cornerRadius = 7.5;
        _registButton.clipsToBounds = YES;
    }
    return _registButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
