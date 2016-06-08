//
//  UIImageView+LoadingImage.m
//  happigo
//
//  Created by 雨 on 16/1/26.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "UIImageView+LoadingImage.h"
#import "NSString+StringToValue.h"
#import "ColorTools.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (LoadingImage)
- (void)loadingImageWithSourceString:(NSString *)string SourceHeader:(NSString *)header Width:(int)width Height:(int)height PlaceholderImage:(UIImage *)image LoadImageComplete:(loadComplete)complete {
    NSString *newStr = [NSString stringToSourceStringWithString:string
                                                          Width:width
                                                         Height:width];
    if (!header.length) {
        header = @"";
    }
    NSString *imgUrlStr = [header stringByAppendingString:newStr];
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]
            placeholderImage:image
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       complete(image,error);
                   }];
}

- (void)loadingImageWithSourceString:(NSString *)string Width:(int)width Height:(int)height LoadImageComplete:(loadComplete)complete{
    [self loadingImageWithSourceString:string
                          SourceHeader:KResoureURL
                                 Width:width
                                Height:height
                      PlaceholderImage:nil
                     LoadImageComplete:complete];
}

- (void)loadingImageWithSourceString:(NSString *)string SourceHeader:(NSString *)header Width:(int)width Height:(int)height LoadImageComplete:(loadComplete)complete{
    [self loadingImageWithSourceString:string
                          SourceHeader:header
                                 Width:width
                                Height:height
                      PlaceholderImage:nil
                     LoadImageComplete:complete];
}

- (void)loadingImageWithSourceString:(NSString *)string Width:(int)width Height:(int)height PlaceholderImage:(UIImage *)image LoadImageComplete:(loadComplete)complete {
    [self loadingImageWithSourceString:string
                          SourceHeader:KResoureURL
                                 Width:width
                                Height:height
                      PlaceholderImage:image
                     LoadImageComplete:complete];
}

- (void)loadingImageWithRandomColorForSourceString:(NSString *)string Width:(int)width Height:(int)height LoadImageComplete:(loadComplete)complete{
    [self loadingImageWithRandomColorForSourceString:string
                                        SourceHeader:KResoureURL
                                               Width:width Height:height
                                   LoadImageComplete:complete];
}

- (void)loadingImageWithRandomColorForSourceString:(NSString *)string SourceHeader:(NSString *)header Width:(int)width Height:(int)height LoadImageComplete:(loadComplete)complete{
    NSString *newStr = [NSString stringToSourceStringWithString:string
                                                          Width:width
                                                         Height:width];
    if (!header.length) {
        header = @"";
    }
    NSString *imgUrlStr = [header stringByAppendingString:newStr];
    [self loadRandomColor];
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]
            placeholderImage:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        complete(image,error);
    }];
}

-(void)loadRandomColor
{
    int randomValue = 0;
    randomValue = arc4random()%8;
    
    if (randomValue == 0)
    {
        self.backgroundColor = [ColorTools randomColorA];
    }
    else if (randomValue == 1)
    {
        self.backgroundColor = [ColorTools randomColorB];
    }
    else if (randomValue == 2)
    {
        self.backgroundColor = [ColorTools randomColorC];
    }
    else if (randomValue == 3)
    {
        self.backgroundColor = [ColorTools randomColorD];
    }
    else if (randomValue == 4)
    {
        self.backgroundColor = [ColorTools randomColorF];
    }
    else if (randomValue == 5)
    {
        self.backgroundColor = [ColorTools randomColorG];
    }
    else if (randomValue == 6)
    {
        self.backgroundColor = [ColorTools randomColorH];
    }
    else if (randomValue == 7)
    {
        self.backgroundColor = [ColorTools randomColorI];
    }
    else if (randomValue == 8)
    {
        self.backgroundColor = [ColorTools randomColorJ];
    }
}

@end
