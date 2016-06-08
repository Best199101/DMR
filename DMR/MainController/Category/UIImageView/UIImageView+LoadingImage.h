//
//  UIImageView+LoadingImage.h
//  happigo
//
//  Created by 雨 on 16/1/26.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadComplete)(UIImage *image,NSError *error);

@interface UIImageView (LoadingImage)

/*
 *  加载图片
 *
 */
- (void)loadingImageWithSourceString:(NSString *)string
                               Width:(int)width
                              Height:(int)height
                   LoadImageComplete:(loadComplete)complete;

- (void)loadingImageWithSourceString:(NSString *)string
                        SourceHeader:(NSString *)header
                               Width:(int)width
                              Height:(int)height
                   LoadImageComplete:(loadComplete)complete;

- (void)loadingImageWithSourceString:(NSString *)string
                               Width:(int)width
                              Height:(int)height
                    PlaceholderImage:(UIImage *)image
                   LoadImageComplete:(loadComplete)complete;

- (void)loadingImageWithSourceString:(NSString *)string
                        SourceHeader:(NSString *)header
                               Width:(int)width
                              Height:(int)height
                    PlaceholderImage:(UIImage *)image
                   LoadImageComplete:(loadComplete)complete;

/*
 *  加载图片之前带默认随机背景色
 *
 */
- (void)loadingImageWithRandomColorForSourceString:(NSString *)string
                               Width:(int)width
                              Height:(int)height
                                 LoadImageComplete:(loadComplete)complete;

- (void)loadingImageWithRandomColorForSourceString:(NSString *)string
                        SourceHeader:(NSString *)header
                               Width:(int)width
                              Height:(int)height
                                 LoadImageComplete:(loadComplete)complete;
@end
