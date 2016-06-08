//
//  ImageEditView.m
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "ImageEditView.h"
#import "CustomImageView.h"
#import "PhotoBroswerVC.h"
#import "UIView+Tools.h"
#import "ImageUploadManager.h"
#import "Global.h"

#define LeftPadding     40
#define RightPadding    40
#define kMargin         10.0f
#define kTagPrefix      10240
#define MaxImageCount   9
#define BaseTagValue    100
#define factor          2

@interface ImageEditView ()

@property (strong,nonatomic) NSMutableArray *reuseArray;
@property (strong,nonatomic) dispatch_group_t uploadGroup;

@end

@implementation ImageEditView

-(void)dealloc
{
    NSLog(@"%s",__func__);
    [_imageDictArray removeAllObjects];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"DeleteImage" object:nil];
}

-(id)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        _imageDictArray = [NSMutableArray new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(Delete:)
                                                     name:@"DeleteImage"
                                                   object:nil];
        _uploadGroup = dispatch_group_create();
        [ImageUploadManager defaultManager].uploadGroup = _uploadGroup;
        [self addSubview:self.addButton];
        _allUploadTaskDone = YES;
    }
    return self;
}

-(void)configLayout
{
    CGFloat width = (self.frame.size.width - kMargin*2)/3;
    for (UIView* view in self.subviews)
    {
        if ([view isKindOfClass:[CustomImageView class]])
        {
            [view removeFromSuperview];
        }
    }
    for (NSDictionary *dic in _imageDictArray)
    {
        
        NSInteger index = [self.imageDictArray indexOfObject:dic];
        CustomImageView* imageView;
        imageView = [[CustomImageView alloc]initWithFrame:
                     CGRectMake((width+kMargin)*(index%3),
                                (width+kMargin)*(index/3),
                                width,
                                width)
                                                   AndTag:index+BaseTagValue];
        imageView.imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageView.imageview.clipsToBounds = YES;
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapped:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        if ([dic[@"name"] isEqualToString:@"0"]) // 上传中的图片
        {
            imageView.imageview.image = dic[@"image"];
            [[ImageUploadManager defaultManager]addNewUploadTask:imageView
                                                  withStateArray:_imageDictArray];
            _allUploadTaskDone = NO;
            dispatch_group_notify(_uploadGroup, dispatch_get_main_queue(), ^{
                _allUploadTaskDone = YES;
            });
        }
        else if ([dic[@"name"] isEqualToString:@"-1"]) // 上传失败
        {
            imageView.imageview.image = [UIImage imageNamed:@"btn_shequ_uploadpic_fail"];
        }
        else if ([dic[@"name"] length] > 1) // 上传成功
        {
            imageView.imageview.image = dic[@"image"];
        }
    
    }
    if (_imageDictArray.count < 9)
    {
        _addButton.hidden = NO;
        _addButton.frame =  CGRectMake((width+kMargin)*(_imageDictArray.count%3),
                                       (width+kMargin)*(_imageDictArray.count/3),
                                       width,
                                       width);
    }
    else
    {
        _addButton.hidden = YES;
    }
}


//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat width = (self.frame.size.width - kMargin*2)/3;
//    for (UIView* view in self.subviews)
//    {
//        if ([view isKindOfClass:[CustomImageView class]])
//        {
//            [view removeFromSuperview];
//        }
//    }
//    for (NSDictionary *dic in _imageDictArray)
//    {
//        
//        NSInteger index = [self.imageDictArray indexOfObject:dic];
//        CustomImageView* imageView;
//        imageView = [[CustomImageView alloc]initWithFrame:
//                     CGRectMake((width+kMargin)*(index%3),
//                                (width+kMargin)*(index/3),
//                                width,
//                                width)
//                                                   AndTag:index+BaseTagValue];
//        imageView.imageview.image = dic[@"image"];
//        imageView.imageview.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.imageview.clipsToBounds = YES;
//        [self addSubview:imageView];
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapped:)];
//        [imageView addGestureRecognizer:tap];
//        imageView.userInteractionEnabled = YES;
//        if ([dic[@"name"] isEqualToString:@"0"])
//        {
//            [[ImageUploadManager defaultManager]addNewUploadTask:imageView withStateArray:_imageDictArray];
//        }
//        
//    }
//    if (_imageDictArray.count < 9)
//    {
//        _addButton.hidden = NO;
//        _addButton.frame =  CGRectMake((width+kMargin)*(_imageDictArray.count%3),
//                                       (width+kMargin)*(_imageDictArray.count/3),
//                                       width,
//                                       width);
//    }
//    else
//    {
//        _addButton.hidden = YES;
//    }
//}

-(void)Delete:(NSNotification*)noti
{
    NSNumber* obj = [noti object];
    for (UIView* view in self.subviews)
    {
        if ([view isKindOfClass:[CustomImageView class]])
        {
            [view removeFromSuperview];
        }
    }
    if (self.imageDictArray.count > obj.integerValue - BaseTagValue)
    {
        NSDictionary *dic = _imageDictArray[obj.integerValue - BaseTagValue];
        // 判断该图片是否已经上传 若已经上传，则删除 正在上传，则取消该任务，若上传失败
        if ([dic[@"name"] isEqualToString:@"0"]) //正在上传
        {
            [[ImageUploadManager defaultManager]cancelUploadTask:obj.integerValue];
        }
        else if ([dic[@"name"] isEqualToString:@"-1"]) // 上传失败
        {
            [[ImageUploadManager defaultManager]deleteFailedImage:obj.integerValue];
        }
        else // 上传成功
        {
            [[ImageUploadManager defaultManager]deleteUploadImage:dic[@"name"]];
        }
        [self.imageDictArray removeObjectAtIndex:obj.integerValue - BaseTagValue];
    }
    [self configLayout];
}

-(void)Tapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"点击大图");
    UIViewController *vc = [self foundCurrentViewController];
    [vc.view endEditing:YES];
    WeakObject(weakSelf);
    [PhotoBroswerVC show:vc type:PhotoBroswerVCTypeZoom index:sender.view.tag-BaseTagValue photoModelBlock:^NSArray *{
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:weakSelf.imageDictArray.count];
        for (int i = 0; i < weakSelf.imageDictArray.count; i++) {
            if (i > 8) {
                break;
            }
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image_HD_U = nil;
            NSDictionary *dic = weakSelf.imageDictArray[i];
            pbModel.image = dic[@"image"];
            if (i < self.imageDictArray.count)
            {
                pbModel.sourceImageView =
                ((CustomImageView *)[self viewWithTag:i+BaseTagValue]).imageview;
                pbModel.sourceImageView.tag = i;
            }
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }CompleteCallBack:^(BOOL isFinish) {
        
    }];
}

-(NSMutableArray *)reuseArray
{
    if (_reuseArray == nil)
    {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            CustomImageView* imageView;
            imageView = [[CustomImageView alloc]initWithFrame:CGRectZero
                                                       AndTag:i+BaseTagValue];
            imageView.imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageView.imageview.clipsToBounds = YES;
            [self addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tapped:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            imageView.isUpload = NO;
        }
        _reuseArray = [[NSMutableArray alloc] initWithArray:mutableArray];
    }
    return _reuseArray;
}

-(UIButton *)addButton
{
    if (_addButton == nil)
    {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"addImage"]
                              forState:UIControlStateNormal];
        _addButton.tag = 1000;
        [self addSubview:_addButton];
    }
    return _addButton;
}

@end
