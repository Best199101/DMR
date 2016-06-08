//
//  LoginViewController.m
//  happigo
//
//  Created by shklxmac111 on 16/2/22.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "LoginViewController.h"
#import "BorderView.h"
#import "ColorTools.h"
#import "LoginAPI.h"
#import "LoginModel.h"
#import "LiThirdPartyAuthorizationOBJ.h"
#import "FindPasswordViewController.h"
#import "RegisterViewController.h"
#import "FindPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,APIRequestManagerDelegate,UIScrollViewDelegate>

@property (strong,nonatomic) UIImageView *logoImageView;
@property (strong,nonatomic) UIImageView *userIconView;
@property (strong,nonatomic) UIImageView *passWordIconView;
@property (strong,nonatomic) UIButton *loginButton;
@property (strong,nonatomic) UIButton *registerButton;
@property (strong,nonatomic) UITextField *phoneTextField;
@property (strong,nonatomic) UITextField *passWordTextField;
@property (strong,nonatomic) UILabel *guideLabel;
@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UIView *line2;
@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) UIButton *forgetPassWordButton;

@property (strong,nonatomic) UIButton *wechatButton;
@property (strong,nonatomic) UIButton *weiboButton;
@property (strong,nonatomic) UIButton *qqButton;

@property (strong,nonatomic) BorderView *phoneBackgroundView;
@property (strong,nonatomic) BorderView *passwordBackgroundView;

@property (strong,nonatomic) LoginAPI   *loginAPI;
@property (strong,nonatomic) LoginModel *loginModel;

@property (weak,nonatomic) UIViewController *viewController;

@end

@implementation LoginViewController

-(instancetype)initWithViewController:(UIViewController *)viewController
{
    if (self = [super init])
    {
        _viewController = viewController;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]initWithTarget:self
                                           action:@selector(closeKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_top_back"]
                                    style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(back)];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeTop];
    }
    self.navigationController.navigationBar.translucent = NO;
    _scrollView  = [UIScrollView new];
    _scrollView.frame = CGRectMake(0, 0, Screen_width, Screen_height);
    [self.view addSubview:_scrollView];
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    UIView *containerView = [UIView new];
    [_scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    
    [containerView addSubview:self.phoneBackgroundView];
    [containerView addSubview:self.passwordBackgroundView];
    [containerView addSubview:self.userIconView];
    [containerView addSubview:self.passWordIconView];
    [containerView addSubview:self.logoImageView];
    [containerView addSubview:self.phoneTextField];
    [containerView addSubview:self.passWordTextField];
    [containerView addSubview:self.loginButton];
    [containerView addSubview:self.forgetPassWordButton];
    [containerView addSubview:self.registerButton];
//    [containerView addSubview:self.weiboButton];
//    [containerView addSubview:self.wechatButton];
//    [containerView addSubview:self.qqButton];
//    [containerView addSubview:self.guideLabel];
//    [containerView addSubview:self.line1];
//    [containerView addSubview:self.line2];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).with.offset(25);
        make.centerX.equalTo(containerView);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    [_phoneBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_bottom).with.offset(25);
        make.left.equalTo(containerView.mas_left).with.offset(25);
        make.width.equalTo(@(Screen_width-50));
        make.height.equalTo(@50);
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_phoneBackgroundView).with.offset(2);
        make.right.equalTo(_phoneBackgroundView);
        make.left.equalTo(_phoneBackgroundView.mas_left).with.offset(57);
    }];
    
    [_passwordBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneBackgroundView.mas_bottom).with.offset(15);
        make.left.equalTo(containerView.mas_left).with.offset(25);
        make.width.equalTo(@(Screen_width-50));
        make.height.equalTo(@50);
    }];
    
    [_passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passwordBackgroundView).with.offset(2);
        make.right.equalTo(_passwordBackgroundView);
        make.left.equalTo(_passwordBackgroundView.mas_left).with.offset(57);
    }];
    
    [_userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_phoneBackgroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(_phoneBackgroundView.mas_left).with.offset(25);
    }];
    
    [_passWordIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passwordBackgroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(_passwordBackgroundView.mas_left).with.offset(25);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forgetPassWordButton.mas_bottom).with.offset(10);
        make.left.equalTo(containerView.mas_left).with.offset(25);
        make.width.equalTo(@(Screen_width-50));
        make.height.equalTo(@50);
    }];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.mas_bottom).with.offset(13);
        make.left.equalTo(containerView.mas_left).with.offset(25);
        make.width.equalTo(@(Screen_width-50));
        make.height.equalTo(@50);
    }];
    
    [_forgetPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordBackgroundView.mas_bottom);
        make.right.equalTo(_passwordBackgroundView.mas_right);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
    
//    [_weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(containerView.mas_left).with.offset(60);
//        make.top.equalTo(_guideLabel.mas_bottom).with.offset(22);
//        make.width.equalTo(@50);
//        make.height.equalTo(@50);
//    }];
//    
//    [_wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_guideLabel.mas_bottom).with.offset(22);
//        make.width.equalTo(@50);
//        make.height.equalTo(@50);
//        make.centerX.equalTo(containerView);
//    }];
//    
//    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_guideLabel.mas_bottom).with.offset(22);
//        make.width.equalTo(@50);
//        make.height.equalTo(@50);
//        make.right.equalTo(containerView.mas_right).with.offset(-60);
//    }];
//    
//    [_guideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(containerView);
//        make.top.equalTo(_registerButton.mas_bottom).with.offset(65);
//        make.width.greaterThanOrEqualTo(@60);
//        make.height.equalTo(@25);
//    }];
//    
//    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_guideLabel);
//        make.height.equalTo(@0.5);
//        make.left.equalTo(_weiboButton.mas_left);
//        make.right.equalTo(_guideLabel.mas_left).with.offset(-15);
//    }];
//    
//    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_guideLabel);
//        make.height.equalTo(@0.5);
//        make.right.equalTo(_qqButton.mas_right);
//        make.left.equalTo(_guideLabel.mas_right).with.offset(15);
//    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make)  {
        make.bottom.equalTo(_registerButton.mas_bottom);
    }];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
}

-(void)closeKeyBoard
{
    [self.view endEditing:YES];
}

-(void)back
{
    [self.view endEditing:YES];
    if (!MainTabBar.currentUser.uid.length) {
        // 发出退出登录的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logOut"
                                                            object:self
                                                          userInfo:nil];
    }
    if ([_viewController isKindOfClass:[FindPasswordViewController class]])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{   
    NSLog(@"%f",scrollView.contentOffset.y);
}

-(void)login{
    if (_phoneTextField.text.length == 0)
    {
//        [TNToast showWithText:@"请输入手机号"];
        return;
    }
    if (_passWordTextField.text.length == 0) {
//        [TNToast showWithText:@"请输入密码"];
        return;
    }
//    [self.loginAPI startRequestWithAccount:_phoneTextField.text
//                                  password:_passWordTextField.text
//                                  clientid:MainTabBar.gexinPusher.clientId];
    [self.view endEditing:YES];
}

-(void)registerAccount
{
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)forgetPassWord
{
    FindPasswordViewController *findPassWordVC = [FindPasswordViewController new];
    [self.navigationController pushViewController:findPassWordVC animated:YES];
}

- (void)logInWithWeiBo
{
    [self.view endEditing:YES];
    [LiThirdPartyAuthorizationOBJ GetWeiBoAuthorizationWithVC:self];
}

- (void)logInWithWeiXin
{
    [self.view endEditing:YES];
    [LiThirdPartyAuthorizationOBJ GetWXAuthorizationWithVC:self];
}

- (void)logInWithQQ
{
    [self.view endEditing:YES];
    [LiThirdPartyAuthorizationOBJ GetQQAuthorizationWithVC:self];
}

#pragma mark - 键盘相关

- (void)keyboardWillShow:(NSNotification *)notification
{
    WeakObject(weakSelf);
    [UIView animateWithDuration:.25
                     animations:^{
        weakSelf.view.frame = CGRectMake(0, -25, Screen_width, Screen_height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    WeakObject(weakSelf);
    [UIView animateWithDuration:.25
                     animations:^{
                         weakSelf.view.frame = CGRectMake(0, 64, Screen_width, Screen_height - 64);
                     }];
}

#pragma mark - 网络

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
//    NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
//    _loginModel = [MTLJSONAdapter modelOfClass:[LoginModel class]
//                            fromJSONDictionary:json
//                                         error:nil];
//    
//    if ([json[@"status"] intValue] == 0) {
//        NSDictionary *dataDic = json[@"data"];
//        NSString *picHeader = dataDic[@"picIp"];
//        NSDictionary *bindMobileDic = dataDic[@"bindMobile"];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic[@"userInfo"]];
//        [dic setObject:picHeader forKey:@"picHeader"];
//        MainTabBar.currentUser = [User initWithDictionary:dic];
//        MainTabBar.currentUser.uid = json[@"data"][@"uid"];
//        MainTabBar.userDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//        if ([bindMobileDic allKeys].count)  {
//            MainTabBar.currentUser.phoneNum = bindMobileDic[@"bind_mobile_no"];
//            [MainTabBar.userDic setObject:MainTabBar.currentUser.phoneNum forKey:@"phoneNum"];
//        }
//        [MainTabBar saveCurrentUser];
//        [self cloudPush];
//        [TNToast showWithText:@"登录成功"];
//        // 发出登录成功的通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"login"
//                                                            object:self
//                                                          userInfo:nil];
//        [self back];
//    }
}

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
//    [TNToast showWithText:apiManager.responseMessage];
}

#pragma mark - 属性

-(UIButton *)loginButton
{
    if (_loginButton == nil)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [ColorTools themePinkColor];
        _loginButton.layer.borderColor = [ColorTools themePinkColor].CGColor;
        _loginButton.layer.borderWidth = 0.5;
        _loginButton.layer.cornerRadius = 7.5;
        _loginButton.clipsToBounds = YES;
        [_loginButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self
                         action:@selector(login)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIButton *)registerButton
{
    if (_registerButton == nil)
    {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor whiteColor];
        _registerButton.layer.borderColor = [ColorTools titleColor].CGColor;
        _registerButton.layer.borderWidth = 0.5;
        _registerButton.layer.cornerRadius = 7.5;
        _registerButton.clipsToBounds = YES;
        [_registerButton setTitleColor:[ColorTools titleColor]
                              forState:UIControlStateNormal];
        [_registerButton setTitle:@"新用户注册"
                         forState:UIControlStateNormal];
        [_registerButton addTarget:self
                            action:@selector(registerAccount)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

-(UIButton *)forgetPassWordButton
{
    if (_forgetPassWordButton == nil)
    {
        _forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPassWordButton setTitle:@"忘记密码"
                               forState:UIControlStateNormal];
        [_forgetPassWordButton setTitleColor:[ColorTools themePinkColor]
                                    forState:UIControlStateNormal];
        _forgetPassWordButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetPassWordButton addTarget:self
                                  action:@selector(forgetPassWord)
                        forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassWordButton;
}

-(UIButton *)wechatButton
{
    if (_wechatButton == nil)
    {
        _wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatButton setImage:[UIImage imageNamed:@"btn_login_weixin"]
                       forState:UIControlStateNormal];
        [_wechatButton addTarget:self
                         action:@selector(logInWithWeiXin)
               forControlEvents:UIControlEventTouchUpInside];

    }
    return _wechatButton;
}

-(UIButton *)weiboButton
{
    if (_weiboButton == nil)
    {
        _weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboButton setImage:[UIImage imageNamed:@"btn_login_sina"]
                      forState:UIControlStateNormal];
        [_weiboButton addTarget:self
                      action:@selector(logInWithWeiBo)
            forControlEvents:UIControlEventTouchUpInside];

    }
    return _weiboButton;
}

-(UIButton *)qqButton
{
    if (_qqButton == nil)
    {
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqButton setImage:[UIImage imageNamed:@"btn_login_qq"]
                   forState:UIControlStateNormal];
        [_qqButton addTarget:self
                      action:@selector(logInWithQQ)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}

-(UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"login_default_img"];
    }
    return _logoImageView;
}

-(UITextField *)phoneTextField
{
    if (_phoneTextField == nil)
    {
        _phoneTextField = [UITextField new];
        _phoneTextField.delegate = self;
        _phoneTextField.placeholder = @"手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

-(UITextField *)passWordTextField
{
    if (_passWordTextField == nil)
    {
        _passWordTextField = [UITextField new];
        _passWordTextField.delegate = self;
        _passWordTextField.placeholder = @"密码";
        _passWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passWordTextField.secureTextEntry = YES;
    }
    return _passWordTextField;
}

- (BorderView *)phoneBackgroundView
{
    if (_phoneBackgroundView == nil)
    {
        _phoneBackgroundView = [[BorderView alloc]init];
    }
    return _phoneBackgroundView;
}

- (BorderView *)passwordBackgroundView
{
    if (_passwordBackgroundView == nil)
    {
        _passwordBackgroundView = [[BorderView alloc]init];
    }
    return _passwordBackgroundView;
}

-(UIImageView *)userIconView
{
    if (_userIconView == nil)
    {
        _userIconView = [UIImageView new];
        _userIconView.image = [UIImage imageNamed:@"ico_login_user"];
    }
    return _userIconView;
}

-(UIImageView *)passWordIconView
{
    if (_passWordIconView == nil)
    {
        _passWordIconView = [UIImageView new];
        _passWordIconView.image = [UIImage imageNamed:@"ico_login_password"];
    }
    return _passWordIconView;
}

-(UILabel *)guideLabel
{
    if (_guideLabel == nil)
    {
        _guideLabel = [UILabel new];
        _guideLabel.font = [UIFont systemFontOfSize:15];
        _guideLabel.textColor = [ColorTools lightTextColor];
        _guideLabel.textAlignment = NSTextAlignmentCenter;
        _guideLabel.text = @"其它方式登录";
    }
    return _guideLabel;
}

-(UIView *)line1
{
    if (_line1 == nil)
    {
        _line1 = [UIView new];
        _line1.backgroundColor = [ColorTools lightBorderColor];
    }
    return _line1;
}

-(UIView *)line2
{
    if (_line2 == nil)
    {
        _line2 = [UIView new];
        _line2.backgroundColor = [ColorTools lightBorderColor];
    }
    return _line2;
}

-(LoginAPI *)loginAPI
{
    if (_loginAPI == nil)
    {
        _loginAPI = [LoginAPI new];
        _loginAPI.apiMangerCallBackDelegate = self;
    }
    return _loginAPI;
}

- (void)cloudPush   {
//    NSString *clintID = [MainTabBar.gexinPusher clientId];
//    clintID = clintID.length ? clintID : @"";
//    [LiAFNetWorkingTool GET:[KHeaderURL stringByAppendingString:@"push/cloudPushBind.do"] parameters:@{@"uid": MainTabBar.currentUser.uid, @"clientId": clintID} success:^(id responseObject) {
//        
//    } failure:^(NSString *error) {  }];
}


@end
