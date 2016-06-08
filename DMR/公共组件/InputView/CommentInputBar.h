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

#import <UIKit/UIKit.h>

#import "XHMessageTextView.h"

#import "SHFacialView.h"
#define kInputTextViewMinHeight 36
#define kInputTextViewMaxHeight 100
#define kHorizontalPadding 8
#define kVerticalPadding 5

/**
 *  类说明：
 *  1、推荐使用[initWithFrame:...]方法进行初始化
 *  2、提供默认的录音，表情，更多按钮的附加页面
 *  3、可自定义以上的附加页面
 */


@protocol CommentInputBarDelegate;
@interface CommentInputBar : UIView

@property (nonatomic, weak) id <CommentInputBarDelegate> delegate;
@property (strong, nonatomic) UIImage *toolbarBackgroundImage;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong,nonatomic) SHFacialView *faceView;
@property (strong, nonatomic) XHMessageTextView *inputTextView;
@property (strong,nonatomic) NSMutableArray *atArray;
@property (nonatomic) CGFloat maxTextInputViewHeight;
- (instancetype)initWithFrame:(CGRect)frame;

-(void)emoji;
-(void)keyboard;
-(void)EnableSend;
-(void)DisableSend;
-(void)SetContentAttributesText:(NSString*)newStr;
+ (CGFloat)defaultHeight;

@end

@protocol CommentInputBarDelegate <NSObject>

@optional

- (void)inputTextViewDidBeginEditing:(XHMessageTextView *)messageInputTextView;
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView;
- (void)didSendText;

@required
/**
 *  高度变到toHeight
 */
- (void)didChangeFrameToHeight:(CGFloat)toHeight;

@end
