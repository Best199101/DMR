//
//  UIImageView+DMRLoading.m
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "UIImageView+DMRLoading.h"
#import "UIImageView+AFNetworking.h"
#import "ColorTools.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (DMRLoading)


-(void)loadImageBySourceString:(NSString *)string
                        Header:(NSString *)header
                         width:(int)width Height:(int)height
{
    // 图片urlString添加width和height参数
    if ([string isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    if (!string.length || !header.length)  {
        string = @"";
        return;
    }
    
    NSString *str = @"";
    NSString *key = @"";
    
    if (width > 0 && height > 0) {
        
        if ([string rangeOfString:@".png"].location != NSNotFound)  {
            key = @".png";
            str = [NSString stringWithFormat:@"_%d-%d.png", width, height];
        }
        if ([string rangeOfString:@".jpeg"].location != NSNotFound)  {
            key = @".jpeg";
            str = [NSString stringWithFormat:@"_%d-%d.jpeg", width, height];
        }
        if ([string rangeOfString:@".JPG"].location != NSNotFound)  {
            key = @".JPG";
            str = [NSString stringWithFormat:@"_%d-%d.JPG", width, height];
        }
        if ([string rangeOfString:@".jpg"].location != NSNotFound)  {
            key = @".jpg";
            str = [NSString stringWithFormat:@"_%d-%d.jpg", width, height];
        }
    }
    NSString *temStr = [string stringByReplacingOccurrencesOfString:key withString:str];
    NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",header, temStr];
    
    // 处理placeHolder图片和加载失败的图片
//    int imageValue = (arc4random() % 9) + 1;
//    [self loadRandomColor:imageValue];
    UIImage *loadFailedImage = [UIImage imageNamed:@"loadFailedImage.jpg"];
    
    //去服务器请求图片
    WeakObject(weakSelf);
    [self sd_setImageWithURL:[NSURL URLWithString:imgURLStr]
            placeholderImage:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (error) {
                           weakSelf.image = loadFailedImage;
                       }
        
    }];
}

-(void)loadImageWithOutRandomColorBySourceString:(NSString *)string
                                          Header:(NSString *)header
                                           width:(int)width
                                          Height:(int)height
{
    // 图片urlString添加width和height参数
    if ([string isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    if (!string.length || !header.length)  {
        string = @"";
        return;
    }
    
    NSString *str = @"";
    NSString *key = @"";
    
    if (width > 0 && height > 0) {
        
        if ([string rangeOfString:@".png"].location != NSNotFound)  {
            key = @".png";
            str = [NSString stringWithFormat:@"_%d-%d.png", width, height];
        }
        else if ([string rangeOfString:@".jpeg"].location != NSNotFound)  {
            key = @".jpeg";
            str = [NSString stringWithFormat:@"_%d-%d.jpeg", width, height];
        }
        else if ([string rangeOfString:@".JPG"].location != NSNotFound)  {
            key = @".JPG";
            str = [NSString stringWithFormat:@"_%d-%d.JPG", width, height];
        }
        else if ([string rangeOfString:@".jpg"].location != NSNotFound)  {
            key = @".jpg";
            str = [NSString stringWithFormat:@"_%d-%d.jpg", width, height];
        }
    }
    NSString *temStr = [string stringByReplacingOccurrencesOfString:key withString:str];
    NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",header, temStr];
//     处理placeHolder图片和加载失败的图片
//        int imageValue = (arc4random() % 9) + 1;
//        [self loadRandomColor:imageValue];
    //去服务器请求图片
    [self sd_setImageWithURL:[NSURL URLWithString:imgURLStr]
            placeholderImage:[UIImage imageNamed:@"avatar_shequ_default_headimg"]];
}

-(void)loadRandomColor:(int)randomValue
{
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
    else if (randomValue == 8)
    {
        self.backgroundColor = [ColorTools randomColorJ];
    }
    else if (randomValue == 9)
    {
        self.backgroundColor = [ColorTools randomColorA];
    }
    else if (randomValue == 10)
    {
        self.backgroundColor = [ColorTools randomColorB];
    }
    else if (randomValue == 11)
    {
        self.backgroundColor = [ColorTools randomColorC];
    }

}



-(void)loadImageWithRandomColorBySourceString:(NSString *)string
                                          Header:(NSString *)header
                                           width:(int)width
                                          Height:(int)height
{
    int imageValue = (arc4random() % 9) + 1;

    // 图片urlString添加width和height参数
    if ([string isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    if (!string.length || !header.length)
    {
        string = @"";
        [self loadRandomColor:imageValue];
        return;
    }
    
    NSString *str = @"";
    NSString *key = @"";
    
    if (width > 0 && height > 0) {
        
        if ([string rangeOfString:@".png"].location != NSNotFound)  {
            key = @".png";
            str = [NSString stringWithFormat:@"_%d-%d.png", width, height];
        }
        if ([string rangeOfString:@".jpeg"].location != NSNotFound)  {
            key = @".jpeg";
            str = [NSString stringWithFormat:@"_%d-%d.jpeg", width, height];
        }
        if ([string rangeOfString:@".JPG"].location != NSNotFound)  {
            key = @".JPG";
            str = [NSString stringWithFormat:@"_%d-%d.JPG", width, height];
        }
        if ([string rangeOfString:@".jpg"].location != NSNotFound)  {
            key = @".jpg";
            str = [NSString stringWithFormat:@"_%d-%d.jpg", width, height];
        }
    }
    NSString *temStr = [string stringByReplacingOccurrencesOfString:key withString:str];
    NSString *imageURLStr;
    if ([temStr rangeOfString:@"http://"].location != NSNotFound)
    {
        imageURLStr = temStr;
    }
    else
    {
        imageURLStr = [NSString stringWithFormat:@"%@%@",header, temStr];
    }
    [self loadRandomColor:imageValue];
    //去服务器请求图片
//    [self sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
    [self sd_setImageWithURL:[NSURL URLWithString:imageURLStr]
            placeholderImage:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [self loadRandomColor:imageValue];
        }
    }];
}


@end
