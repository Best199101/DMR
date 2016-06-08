//
//  ImagesBrowser.m
//  xiaoqu
//
//  Created by steven on 10/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import "ImagesBrowser.h"
#import "PhotoBroswerVC.h"
#import "CacheManager.h"
#import "UIView+Tools.h"
#import "UIImageView+DMRLoading.h"
#import "Global.h"
#define LeftPadding     40
#define RightPadding    20
#define kMargin         10.0f
#define kTagPrefix      10240
#define MaxImageCount   9

@interface ImagesBrowser ()

@property (nonatomic, strong) NSArray *reuseimages;
@property (nonatomic, strong) NSArray *imagesURLS;

@end

@implementation ImagesBrowser

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setContentWithArray:(NSArray*)array
{
    if (array && array.count > 0)
    {
        if (self.imagesURLS.count > 0 && self.imagesURLS)
        {
            self.imagesURLS = nil;
        }
        self.imagesURLS = array;
        for (UIView *imgView in self.reuseimages)
        {
            if ([imgView isKindOfClass:[UIImageView class]])
            {
                imgView.hidden = YES;
                imgView.frame = CGRectZero;
            }
        }
    }
    else
        return;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imagesURLS && self.imagesURLS.count>0)
    {
        if (self.imagesURLS.count == 1 ||
            self.imagesURLS.count == 2 ||
            self.imagesURLS.count == 4)
        {
            for (int i = 0; i < self.imagesURLS.count; i++) {
                if (i >= self.reuseimages.count) {
                    break;
                }
                UIImageView *imageView = self.reuseimages[i];
                imageView.hidden = NO;
                NSString *url = self.imagesURLS[i];
//                [imageView sd_setImageWithURL:[NSURL URLWithString:url]
//                             placeholderImage:nil];
                CGFloat width = (self.frame.size.width - kMargin)/2;
                imageView.frame = CGRectMake((width+kMargin)*(i%2), (width+kMargin)*(i/2), width, width);
                [imageView loadImageBySourceString:url
                                            Header:KResoureURL
                                             width:width
                                            Height:width];

            }
        }
        else
        {
            for (int i = 0; i < self.imagesURLS.count; i++) {
                if (i >= self.reuseimages.count) {
                    break;
                }
                UIImageView *imageView = self.reuseimages[i];
                imageView.hidden = NO;
                NSString *url = self.imagesURLS[i];
                CGFloat width = (self.frame.size.width - kMargin*2)/3;
                imageView.frame = CGRectMake((width+kMargin)*(i%3), (width+kMargin)*(i/3), width, width);
                [imageView loadImageBySourceString:url
                                            Header:KResoureURL
                                             width:width
                                            Height:width];
            }
        }
    }
}

+ (CGFloat)heightWithArray:(NSArray*)array
{
    int heightFactor = 0;
    if (array && array.count > 0)
    {
        if (array.count == 1||array.count == 2||array.count == 4)
        {
            if (array.count == 1 || array.count == 2)
            {
                heightFactor = 1;
            }
            else if (array.count)
            {
                heightFactor = 2;
            }
            return heightFactor * ((DeviceWidth - LeftPadding - RightPadding - kMargin)/2);
        }
        else if (  array.count == 3
                 ||array.count == 5
                 ||array.count == 6
                 ||array.count == 7
                 ||array.count == 8
                 ||array.count == 9 )
        {
            if (array.count == 3)
            {
                heightFactor = 1;
            }
            else if (array.count == 5||array.count == 6)
            {
                heightFactor = 2;
            }
            else if (array.count == 7||array.count == 8||array.count == 9)
            {
                heightFactor = 3;
            }
            return  // 控件高度等于图片高度+间距高度
            heightFactor *
            ((DeviceWidth - LeftPadding - RightPadding - kMargin*2)/3) +
            kMargin * (heightFactor - 1);
        }
    }
    return 0.0;
}

-(void)Tapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"点击大图");
    WeakObject(weakSelf);
    [PhotoBroswerVC show:[self foundCurrentViewController]
                    type:PhotoBroswerVCTypeZoom
                   index:sender.view.tag-1
         photoModelBlock:^NSArray *{
             NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:weakSelf.imagesURLS.count];
             for (int i = 0; i < weakSelf.imagesURLS.count; i++)
             {
                 if (i > 10)
                 {
                     break;
                 }
                 PhotoModel *pbModel=[[PhotoModel alloc] init];
                 pbModel.mid = i + 1;

                 pbModel.image_HD_U = [NSString stringWithFormat:@"%@%@",KResoureURL,weakSelf.imagesURLS[i]];
                 
                 if (i < self.reuseimages.count)
                 {
                     UIImageView *imageV = self.reuseimages[i];
                     pbModel.sourceImageView = imageV;
                 }
                 [modelsM addObject:pbModel];
             }
             return modelsM;
         }CompleteCallBack:^(BOOL isFinish) {}];
}

- (NSArray *)reuseimages
{
    if (_reuseimages == nil)
    {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [mutableArray addObject:imageView];
            imageView.hidden = YES;
            imageView.tag = i+1;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(Tapped:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
        }
        _reuseimages = [[NSArray alloc] initWithArray:mutableArray];
        
    }
    return _reuseimages;
}

@end
