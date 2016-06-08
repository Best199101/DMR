//
//  TweetEditViewController.m
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "TweetEditViewController.h"
#import "PlaceholderTextView.h"
#import "ColorTools.h"
#import "ImageTools.h"
#import "ImageEditView.h"
#import "QBImagePickerController.h"
#import "SayToStringModel.h"
#import "NSString+isNilOrEmpty.h"
#import "tagViewForSendTopic.h"
#import "PostTweetAPI.h"
#import "TagListViewController.h"
#import "AtUserViewController.h"
#import "TagViewForSendTopic.h"
#import "NSMutableArray+toString.h"
#import "PositionView.h"
#import "SHFacialView.h"
#import "UIViewController+HUD.h"
#import "UIViewController+TopStatus.h"
#import "UIBarButtonItem+Badge.h"
#import "UIImage+FixOrientation.h"
#import "IBActionSheet.h"
#import "UIImage+Scale.h"
#import "Global.h"

@interface TweetEditViewController ()
<UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextViewDelegate,
UIScrollViewDelegate,
UIActionSheetDelegate,
QBImagePickerControllerDelegate,
APIRequestManagerDelegate,
SHFacialViewDelegate,
UIAlertViewDelegate,
IBActionSheetDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;
@property (strong,nonatomic) PlaceholderTextView *textView;
@property (strong,nonatomic) NSMutableArray *imageArray;
@property (strong,nonatomic) NSMutableArray *imageNameArray;
@property (strong,nonatomic) NSMutableArray *atArray;
@property (nonatomic,strong) UIToolbar *toolBar;
@property (nonatomic,strong) ImageEditView *imageEditView;
@property (strong,nonatomic) TagViewForSendTopic *tagView;
@property (strong,nonatomic) PositionView *positionView;
@property (strong,nonatomic) SHFacialView *faceView;

@property (assign) NSRange currentRange;

@property (strong,nonatomic) PostTweetAPI *postTweetAPI;

@property (strong,nonatomic) UIImageView *guide1;
@property (strong,nonatomic) UIImageView *guide2;
@property (strong,nonatomic) UIView *guideBackgroundView;

@property (assign,nonatomic) CGFloat keyboardHeight;

@end

#define ToolbarHeight       45
#define MaxPhotoNumber      9
#define PositionViewHeight  40

@implementation TweetEditViewController

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发话题";
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@"提交 "
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(checkTweetData)];
    self.navigationItem.leftBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@" 取消"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(cancel)];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light"size:15],NSForegroundColorAttributeName:[UIColor lightGrayColor]}
                    forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem
     setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light"size:15],NSForegroundColorAttributeName:[ColorTools themePinkColor]}
     forState:UIControlStateNormal];

    _atArray = [NSMutableArray new];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tagView];
    [self.view addSubview:self.positionView];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.imageEditView];
    [self.scrollView addSubview:self.contentView];
    [self.view addSubview:self.toolBar];
    [self setLayouts];
    _scrollView.contentSize = _contentView.bounds.size;
    [self performSelector:@selector(textEdit)
               withObject:nil
               afterDelay:0.1];
    
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(ToolbarHeight));
    }];
    [_positionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_toolBar.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(PositionViewHeight));
    }];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_positionView.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(kTagViewHeight));
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left).with.offset(10);
        make.right.equalTo(_contentView.mas_right).with.offset(-10);
        make.top.equalTo(_contentView.mas_top);
        make.bottom.equalTo(_contentView.mas_bottom);
    }];
    [_imageEditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left).with.offset(30);
        make.right.equalTo(_contentView.mas_right).with.offset(-30);
        make.top.equalTo(_contentView.mas_top).with.offset(60);
        make.height.equalTo(@400);
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollViewTap)
                                                 name:@"textViewTap"
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_textView resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardDidShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"textViewTap"
                                                 object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self performSelector:@selector(guide) withObject:nil afterDelay:0.1];

}

-(void)textEdit
{
    [_textView becomeFirstResponder];
}

#pragma mark - 引导事件

#pragma mark - 输入代理

-(void)textViewDidChange:(UITextView *)textView
{
    NSRange range = textView.selectedRange;
    _currentRange = range;
//    _textView.textColor = [ColorTools titleColor];
    NSString *textString =  _textView.attributedText.string;
    CGFloat height = ceilf([_textView sizeThatFits:_textView.frame.size].height + 10);
    if (height > 60)
    {
        [_imageEditView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentView.mas_top).with.offset(height);
        }];
        _contentView.frame = CGRectMake(0, 0,DeviceWidth, height + _imageEditView.frame.size.height);
        _scrollView.contentSize = CGSizeMake(DeviceWidth, DeviceHeight + height + 300);
    }
    UITextRange *selectedRange = [textView markedTextRange];
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
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
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        [self SetContentAttributesText:textString];
    }
}

#pragma mark - 警告框代理

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 滚动收起键盘

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 富文本字符串

-(void)SetContentAttributesText:(NSString*)newStr
{
    if (![NSString isNilOrEmpty:newStr])
    {
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:newStr];
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"STHeitiSC-Light" size:18]
                       range:NSMakeRange(0, newStr.length)];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[ColorTools titleColor]
                       range:NSMakeRange(0, newStr.length)];

        for (SayToStringModel* model in _atArray)
        {
            NSRange atStringRange = [newStr rangeOfString:model.AtString];
            [string addAttribute:NSForegroundColorAttributeName
                           value:[ColorTools themePinkColor]
                           range:atStringRange];
        }
        if (string.length >= 1) {
            [string addAttribute:NSForegroundColorAttributeName
                           value:[ColorTools titleColor]
                           range:NSMakeRange(newStr.length - 1, 1)];
        }
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        if (IOS_SYSTEM < 9.0) {
            [paragraphStyle1 setLineSpacing:4];
        }
        else
        {
            [paragraphStyle1 setLineSpacing:0.1];
        }
        [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string.string length])];
        [_textView setAttributedText:string];
    }
    NSInteger currentLength = [_textView.attributedText.string length];
    [_positionView setContentWithNumber:currentLength];
    _textView.selectedRange = _currentRange;
    [_textView becomeFirstResponder];
    
    CGFloat height = ceilf([_textView sizeThatFits:_textView.frame.size].height + 10);
    if (height > 60)
    {
        [_imageEditView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentView.mas_top).with.offset(height);
        }];
        _contentView.frame = CGRectMake(0, 0,DeviceWidth, height + _imageEditView.frame.size.height);
        _scrollView.contentSize = CGSizeMake(DeviceWidth, DeviceHeight + height + 300);
    }

    
    if (currentLength > 0)
    {
        [self.navigationItem.rightBarButtonItem
         setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light"size:15],NSForegroundColorAttributeName:[ColorTools themePinkColor]}
         forState:UIControlStateNormal];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem
         setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light"size:15],NSForegroundColorAttributeName:[UIColor lightGrayColor]}
         forState:UIControlStateNormal];
    }
}

#pragma mark - 编辑tweet代理

-(void)selectedFacialView:(NSString*)str
{
    PlaceholderTextView *textView = _textView;
    if ([str isEqualToString:SHEmojiDelete])
    {
        [textView deleteBackward];
    }
    else
    {
        [textView insertText:str];
        [self SetContentAttributesText:textView.text];
    }
    [self textViewDidChange:_textView];
}

#pragma mark - 发布

-(void)checkTweetData
{
    [self.view endEditing:YES];
    NSString *trimmedString = [_textView.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmedString.length == 0)
    {
        return;
    }
    if (_textView.attributedText.string.length > 1000)
    {
        return;
    }
    if (_imageEditView.allUploadTaskDone == NO)
    {
        return;
    }
    [self pubTweet];
}

-(void)pubTweet
{
    [self showHudInView:self.view hint:@"发布中..."];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSMutableString *replyString = [NSMutableString stringWithString:_textView.attributedText.string];
    
    NSMutableArray *UploaduListArray = [NSMutableArray new];
    for (SayToStringModel* model in _atArray) {
        NSRange atRange =  [replyString rangeOfString:model.AtString];
        if (atRange.location == NSNotFound)
        {
            
        }
        else
        {
            [UploaduListArray addObject:model.uid];
        }
    }
    
//    [self.postTweetAPI startRequestWithUid:MainTabBar.currentUser.uid
//                                     Title:@""
//                                   Content:[_textView.attributedText.string stringByTrimmingCharactersInSet:
//                                            [NSCharacterSet whitespaceAndNewlineCharacterSet]]
//                                      Tags:[_tagView.tags toString]
//                                       Pic:[_imageEditView.imageDictArray toString]
//                                  Location:_positionView.location
//                                       Ats:[UploaduListArray toString]];
}

-(void)scrollViewTap
{
    _textView.inputView = nil;
    [_textView reloadInputViews];
    [_textView becomeFirstResponder];
    _textView.inputType = keyboardType;
    UIButton *button = (UIButton *)((UIBarButtonItem *)_toolBar.items[2]).customView;
    [button setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"emojitap"] forState:UIControlStateHighlighted];
    [_textView becomeFirstResponder];
}

-(void)cancel
{
    [self hideHud];
    if (_textView.text.length > 0
        || _imageEditView.imageDictArray.count > 0) {
        UIAlertView *alertView =
        [[UIAlertView alloc]initWithTitle:@"你还有内容没有提交，确定返回吗？"
                                  message:nil
                                 delegate:self
                        cancelButtonTitle:@"取消"
                        otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    [_postTweetAPI cancelTaskWithTaskID:1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"switchToNew" object:nil];
    }];
}

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
    [self hideHud];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark - 工具栏事件

-(void)addImage
{
    [self.view endEditing:YES];
    IBActionSheet *action = [[IBActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"拍照",@"从相册选取",nil];
    [action setFont:[UIFont systemFontOfSize:15.0f]];
    [action setButtonTextColor:[ColorTools themePinkColor]];
    [action showInView:self.navigationController.view];
}

-(void)switchInputView
{
    if (_textView.inputType == keyboardType)
    {
        _textView.inputView = self.faceView;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        _textView.inputType = emojiType;
        UIButton *button = (UIButton *)((UIBarButtonItem *)_toolBar.items[2]).customView;
        [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyboardtap"] forState:UIControlStateHighlighted];
    }
    else if (_textView.inputType == emojiType)
    {
        _textView.inputView = nil;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        _textView.inputType = keyboardType;
        UIButton *button = (UIButton *)((UIBarButtonItem *)_toolBar.items[2]).customView;
        [button setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"emojitap"] forState:UIControlStateHighlighted];
    }
}

-(void)mentionSomenone
{
    WeakObject(weakSelf);
    AtUserViewController *atUserVC = [AtUserViewController new];
    atUserVC.AtBlock = ^(NSString* nickName,NSString* uid){
        SayToStringModel* model = [SayToStringModel new];
        model.nickName = nickName;
        model.uid = uid;
        model.AtString = [NSString stringWithFormat:@"@%@ ",nickName];
        BOOL isExsit = NO;
        for (SayToStringModel *oldModel in _atArray)
        {
            if ([oldModel.uid isEqualToString:model.uid])
            {
                isExsit = YES;
                break;
            }
        }
        if (isExsit ==  NO)
        {
            [_atArray addObject:model];
        }
        NSString* textString = [NSString stringWithFormat:@"%@%@",_textView.text,model.AtString];
        _currentRange = NSMakeRange(_currentRange.location + textString.length, 0);
        [weakSelf SetContentAttributesText:textString];
    };
    [self.navigationController pushViewController:atUserVC animated:YES];
    
}

-(void)addTag
{
    if (_tagView.tags.count == 3)
    {
        [self.view endEditing:YES];
        return;
    }
    TagListViewController *tagListVC = [TagListViewController new];
    tagListVC.selectTagBlock = ^(NSString * tagName){
        [_tagView addTags:@[tagName]];
    };
    [self.navigationController pushViewController:tagListVC animated:YES];
}

#pragma mark - 选图代理

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self openCamera:@"Camera"];
    }
    else if (buttonIndex == 1) {
        [self openCamera:@"PhotosAlbum"];
    }

}

- (void)openCamera:(NSString *)source
{
    if ([source isEqualToString:@"Camera"])
    {
        if (_imageEditView.imageDictArray.count == MaxPhotoNumber)
        {
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = YES;
        picker.delegate = self;

        [self presentViewController:picker animated:YES completion:nil];

    }
    else if ([source isEqualToString:@"PhotosAlbum"])
    {
        if (_imageEditView.imageDictArray.count == MaxPhotoNumber)
        {
            return;
        }

        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.maximumNumberOfSelection = MaxPhotoNumber - _imageEditView.imageDictArray.count;
        imagePickerController.delegate = self;
        [self.navigationController presentViewController:imagePickerController
                                                animated:YES
                                              completion:NULL];
    }
}

#pragma mark - QB代理

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    [imagePickerController showHudInView:imagePickerController.view hint:@""];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ALAsset *set in assets)
        {
            ALAssetRepresentation* representation = [set defaultRepresentation];
            //            UIImage *image = [ImageTools fixOrientation:representation.orientation
            //                                                  Image:representation.fullScreenImage];
//            CGFloat width = CGImageGetWidth(representation.fullResolutionImage);
//            CGFloat height = CGImageGetHeight(representation.fullResolutionImage);
            UIImage *image = [UIImage imageWithCGImage:representation.fullScreenImage];
            UIImage *thumbnailImage = [UIImage imageWithCGImage:set.thumbnail];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
            [dic setObject:image forKey:@"image"];
            [dic setObject:thumbnailImage forKey:@"imageThumbnail"];
            [dic setObject:@"0" forKey:@"name"];
            [_imageEditView.imageDictArray addObject:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_imageEditView configLayout];
            [self dismissViewControllerAnimated:YES completion:^{
                [imagePickerController hideHud];
            }];
        });
    });
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker showHudInView:picker.view hint:@""];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:[[original fixOrientation] scaleWithFactor:0.3]forKey:@"image"];
        [dict setObject:@"0" forKey:@"name"];
        [_imageEditView.imageDictArray addObject:dict];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_imageEditView configLayout];
            [picker dismissViewControllerAnimated:YES completion:^{
                [picker hideHud];
            }];
        });
    });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - 键盘相关

- (void)keyboardWillShow:(NSNotification *)notification
{
    WeakObject(weakSelf);
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(ToolbarHeight));
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(-keyboardBounds.size.height);
    }];
    [self updateBarHeight];
    _keyboardHeight = keyboardBounds.size.height;
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardBounds.size.height;
    NSLog(@"%f",_keyboardHeight);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    WeakObject(weakSelf);
    [_toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(ToolbarHeight));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    [self updateBarHeight];
}

- (void)updateBarHeight
{
    [self.view setNeedsUpdateConstraints];
    [UIView animateKeyframesWithDuration:0.25       //animationDuration
                                   delay:0
                                 options:7 << 16    //animationOptions
                              animations:^{
                                  [self.view layoutIfNeeded];
                              } completion:nil];
}

-(UIToolbar *)toolBar
{
    if (_toolBar == nil)
    {
        _toolBar = [UIToolbar new];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:self
                                          action:nil];
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:self
                                       action:nil];
        fixedSpace.width = 15.0f;
        NSMutableArray *barButtonItems = [[NSMutableArray alloc] initWithObjects:fixedSpace, nil];
        NSArray *iconName = @[@"addphoto",@"emoji",@"@", @"addtag"];
        NSArray *iconSelectName = @[@"addphototap",@"emojitap",@"@tap", @"addtagtap"];
        NSArray *action   = @[@"addImage",@"switchInputView", @"mentionSomenone",@"addTag"];
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self
                    action:NSSelectorFromString(action[i])
          forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:iconName[i]]
                 forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:iconSelectName[i]]
                 forState:UIControlStateHighlighted];
            btn.frame = CGRectMake(0, 0, 40, 40);
            UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:btn];
            _toolBar.barTintColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0];
            button.tintColor = [UIColor clearColor];
            [barButtonItems addObject:button];
            if (i < 3) {[barButtonItems addObject:flexibleSpace];}
        }
        [barButtonItems removeObjectAtIndex:0];
        [_toolBar setItems:barButtonItems];
        
        // 底部添加border
        
        UIView *bottomBorder = [UIView new];
        bottomBorder.backgroundColor = [UIColor lightGrayColor];
        bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
        [_toolBar addSubview:bottomBorder];
        _toolBar.backgroundColor = [UIColor colorWithRed:235.0/255
                                                   green:235.0/255
                                                    blue:243.0/255
                                                   alpha:1.0];
    }
    return _toolBar;
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
    }
    return _scrollView;
}

-(UIView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[UIView alloc] initWithFrame:_scrollView.bounds];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

-(PlaceholderTextView *)textView
{
    if (_textView == nil)
    {
        _textView = [PlaceholderTextView new];
        _textView.placeholder = @"说点什么吧...";
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.enablesReturnKeyAutomatically = YES;
        _textView.scrollEnabled = NO;
        _textView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
        _textView.autocorrectionType = UITextAutocorrectionTypeDefault;
        _textView.inputType = keyboardType;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = [ColorTools titleColor];
    }
    return _textView;
}

-(ImageEditView *)imageEditView
{
    if (_imageEditView == nil)
    {
        _imageEditView = [ImageEditView new];
        [_imageEditView.addButton addTarget:self
                                     action:@selector(addImage)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageEditView;
}

-(TagViewForSendTopic *)tagView
{
    if (_tagView == nil)
    {
        _tagView = [TagViewForSendTopic new];
        _tagView.backgroundColor = [UIColor clearColor];
    }
    return _tagView;
}

-(PostTweetAPI *)postTweetAPI
{
    if (_postTweetAPI == nil)
    {
        _postTweetAPI = [PostTweetAPI new];
        _postTweetAPI.apiMangerCallBackDelegate = self;
    }
    return _postTweetAPI;
}

-(PositionView *)positionView
{
    if (_positionView == nil)
    {
        _positionView = [PositionView new];
    }
    return _positionView;
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


@end
