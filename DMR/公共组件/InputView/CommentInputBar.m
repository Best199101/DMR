/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "CommentInputBar.h"
#import "NSString+isNilOrEmpty.h"
#import "Global.h"

@interface CommentInputBar()<UITextViewDelegate,SHFacialViewDelegate>
{
    CGFloat _previousTextViewContentHeight;//上一次inputTextView的contentSize.height
}

@property (nonatomic) CGFloat version;
@property (assign,nonatomic) NSRange currentRange;
@property (strong,nonatomic) UIButton *sendButton;

/**
 *  背景
 */
@property (strong, nonatomic) UIImageView *toolbarBackgroundImageView;
@property (strong, nonatomic) UIImageView *backgroundImageView;

/**
 *  按钮、输入框、toolbarView
 */
@property (strong, nonatomic) UIView *toolbarView;
//@property (strong, nonatomic) UIButton *styleChangeButton;
//@property (strong, nonatomic) UIButton *moreButton;
//@property (strong, nonatomic) UIButton *faceButton;

/**
 *  底部扩展页面
 */
//@property (nonatomic) BOOL isShowButtomView;
//@property (strong, nonatomic) UIView *activityButtomView;//当前活跃的底部扩展页面

@end

@implementation CommentInputBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.height < (kVerticalPadding * 2 + kInputTextViewMinHeight)) {
        frame.size.height = kVerticalPadding * 2 + kInputTextViewMinHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _atArray = [NSMutableArray new];
        [self setupConfigure];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    NSLog(@"%s",__func__);

    if (frame.size.height < (kVerticalPadding * 2 + kInputTextViewMinHeight)) {
        frame.size.height = kVerticalPadding * 2 + kInputTextViewMinHeight;
    }
    [super setFrame:frame];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"%s",__func__);

    // 当别的地方需要add的时候，就会调用这里
    if (newSuperview) {
        [self setupSubviews];
    }
    
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview
{
    NSLog(@"%s",__func__);

    [super didMoveToSuperview];
}

- (void)dealloc
{
    _delegate = nil;
    _inputTextView.delegate = nil;
    _inputTextView = nil;
}

#pragma mark - getter

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return _backgroundImageView;
}

- (UIImageView *)toolbarBackgroundImageView
{
    if (_toolbarBackgroundImageView == nil) {
        _toolbarBackgroundImageView = [[UIImageView alloc] init];
        _toolbarBackgroundImageView.backgroundColor = [UIColor clearColor];
        _toolbarBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    return _toolbarBackgroundImageView;
}

-(SHFacialView*)faceView
{
    if (_faceView == nil) {
        _faceView = [[SHFacialView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 216)];
        _faceView.backgroundColor = [UIColor whiteColor];
        _faceView.delegate = self;
        [_faceView loadFacialView:0 size:CGSizeMake(40, 40)];
    }
    return _faceView;
}


- (UIView *)toolbarView
{
    if (_toolbarView == nil) {
        _toolbarView = [[UIView alloc] init];
        _toolbarView.backgroundColor = [UIColor clearColor];
    }
    
    return _toolbarView;
}

#pragma mark - setter

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = backgroundImage;
}

- (void)setToolbarBackgroundImage:(UIImage *)toolbarBackgroundImage
{
    _toolbarBackgroundImage = toolbarBackgroundImage;
    self.toolbarBackgroundImageView.image = toolbarBackgroundImage;
}

- (void)setMaxTextInputViewHeight:(CGFloat)maxTextInputViewHeight
{
    if (maxTextInputViewHeight > kInputTextViewMaxHeight) {
        maxTextInputViewHeight = kInputTextViewMaxHeight;
    }
    _maxTextInputViewHeight = maxTextInputViewHeight;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)]) {
        [self.delegate inputTextViewWillBeginEditing:self.inputTextView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%s",__func__);

    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.inputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"%s",__func__);
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([text isEqualToString:@"\n"]) {
//        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
//            [self.delegate didSendText:textView.text];
//            self.inputTextView.text = @"";
//            [self willShowInputTextViewToHeight:[self getTextViewContentH:self.inputTextView]];;
//        }
//        
//        return NO;
//    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%s",__func__);

    [self willShowInputTextViewToHeight:[self getTextViewContentH:textView]];
    
        NSRange range = textView.selectedRange;
        _currentRange = range;
    
        NSString *textString =  _inputTextView.attributedText.string;
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textView markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                [self SetContentAttributesText:textString];
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else
            {
                if ([UIDevice currentDevice].systemVersion.floatValue == 7.0)
                {
                    [self SetContentAttributesText:textString];
                }
            }
        }
        else
        {
            [self SetContentAttributesText:textString];
        }

}

#pragma mark - 表情

-(void)selectedFacialView:(NSString*)str
{
    NSLog(@"%s",__func__);

    XHMessageTextView *textView = self.inputTextView;
    if ([str isEqualToString:SHEmojiDelete])
    {
        [textView deleteBackward];
    }
    else
    {
        [textView insertText:str];
        [self SetContentAttributesText:textView.text];
        
    }
    [self textViewDidChange:self.inputTextView];
}

#pragma mark - private

/**
 *  设置初始属性
 */
- (void)setupConfigure
{
    self.version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    self.maxTextInputViewHeight = kInputTextViewMaxHeight;
    
    self.backgroundImageView.image = [[UIImage imageNamed:@"messageToolbarBg"]
                                      stretchableImageWithLeftCapWidth:0.5 topCapHeight:10];
    [self addSubview:self.backgroundImageView];
    
    self.toolbarView.frame = CGRectMake(0, 0, self.frame.size.width, kVerticalPadding * 2 + kInputTextViewMinHeight);
    self.toolbarBackgroundImageView.frame = self.toolbarView.bounds;
    [self.toolbarView addSubview:self.toolbarBackgroundImageView];
    [self addSubview:self.toolbarView];
}

- (void)setupSubviews
{
    NSLog(@"%s",__func__);

    CGFloat allButtonWidth = 0.0;
    CGFloat textViewLeftMargin = 6.0;
    [self.toolbarView addSubview:self.sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_toolbarView.mas_right);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        make.bottom.equalTo(_toolbarView.mas_bottom).with.offset(-5);
    }];
    allButtonWidth += 60;
    // 输入框的高度和宽度
    CGFloat width = DeviceWidth - 100 - 20;
    // 初始化输入框
    self.inputTextView = [[XHMessageTextView  alloc] initWithFrame:CGRectMake(textViewLeftMargin, kVerticalPadding, width, kInputTextViewMinHeight)];
    self.inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputTextView.layoutManager.allowsNonContiguousLayout = NO;
    //    self.inputTextView.contentMode = UIViewContentModeCenter;
    _inputTextView.scrollEnabled = YES;
    _inputTextView.returnKeyType = UIReturnKeyDefault;
//    _inputTextView.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
    _inputTextView.placeHolder = @"说点什么吧...";
    _inputTextView.delegate = self;
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    _inputTextView.layer.borderWidth = 0.65f;
    _inputTextView.layer.cornerRadius = 6.0f;
    _previousTextViewContentHeight = [self getTextViewContentH:_inputTextView];
    
    if (!self.faceView)
    {
        self.faceView = [[SHFacialView alloc] initWithFrame:CGRectMake(0, (kVerticalPadding * 2 + kInputTextViewMinHeight), self.frame.size.width, 200)];
        [(SHFacialView *)self.faceView setDelegate:self];
        self.faceView.backgroundColor = [UIColor lightGrayColor];
        self.faceView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    [self.toolbarView addSubview:self.inputTextView];
}

#pragma mark - change frame

- (void)willShowInputTextViewToHeight:(CGFloat)toHeight
{
    NSLog(@"%s",__func__);

    if (toHeight < kInputTextViewMinHeight) {
        toHeight = kInputTextViewMinHeight;
    }
    if (toHeight > self.maxTextInputViewHeight) {
        toHeight = self.maxTextInputViewHeight;
    }
    
    if (toHeight == _previousTextViewContentHeight)
    {
        return;
    }
    else
    {
        CGFloat changeHeight = toHeight - _previousTextViewContentHeight;
        
        CGRect rect = self.frame;
        rect.size.height += changeHeight;
        rect.origin.y -= changeHeight;
        self.frame = rect;
        
        rect = self.toolbarView.frame;
        rect.size.height += changeHeight;
        self.toolbarView.frame = rect;
        
        _previousTextViewContentHeight = toHeight;
        
    }
}

- (CGFloat)getTextViewContentH:(UITextView *)textView
{
    NSLog(@"%s",__func__);

    return ceilf([textView sizeThatFits:textView.frame.size].height);
}

-(void)SetContentAttributesText:(NSString*)newStr
{

    if (![NSString  isNilOrEmpty:newStr]) {
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:newStr];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, newStr.length)];

//        for (SayToStringModel* model in _atArray)
//        {
//            NSRange atStringRange = [newStr rangeOfString:model.AtString];
//            [string addAttribute:NSForegroundColorAttributeName value:[UIColor themeOrangeColor] range:atStringRange];
//        }
        [_inputTextView setAttributedText:string];
    }
    else
    {
        [self DisableSend];
    }
    _inputTextView.selectedRange = _currentRange;
    if (_inputTextView.attributedText.length > 0)
    {
        [self EnableSend];
    }
    else
    {
        [self DisableSend];
    }

}

#pragma mark - action

-(void)EnableSend
{
    NSLog(@"%s",__func__);

    _sendButton.enabled = YES;
    [_sendButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
}

-(void)DisableSend
{
    NSLog(@"%s",__func__);

    _sendButton.enabled = NO;
    [_sendButton setTitleColor:[UIColor darkGrayColor]
                      forState:UIControlStateNormal];
}

-(void)send
{
    [self.delegate didSendText];
    self.inputTextView.text = @"";
    [self willShowInputTextViewToHeight:[self getTextViewContentH:self.inputTextView]];
}

-(void)emoji
{
    NSLog(@"%s",__func__);

    _inputTextView.inputView = self.faceView;
    [_inputTextView reloadInputViews];
    [_inputTextView becomeFirstResponder];
}

-(void)keyboard
{
    NSLog(@"%s",__func__);

    _inputTextView.inputView = nil;
    [_inputTextView reloadInputViews];
    [_inputTextView becomeFirstResponder];
}

-(UIButton *)sendButton
{
    if (_sendButton == nil)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.backgroundColor = [UIColor clearColor];
        [_sendButton addTarget:self
                        action:@selector(send)
              forControlEvents:UIControlEventTouchUpInside];
        [self DisableSend];
    }
    return _sendButton;
}


+ (CGFloat)defaultHeight
{
    NSLog(@"%s",__func__);

    return kVerticalPadding * 2 + kInputTextViewMinHeight;
}

@end
