//
//  UIImage+Scale.m
//  xiaoqu
//
//  Created by shenhai on 15/4/17.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)scaleToSizeDataLength:(float)length;
{
    
    return [UIImage imageWithData:[self dataScaleToSizeDataLength:length]];
}

- (NSData *)dataScaleToSizeDataLength:(float)length;
{
    NSDate *dateStart = [NSDate date];
    
    UIImage *image = self;
    
    CGFloat imageQuality = 1;
    NSData *resizeData = UIImageJPEGRepresentation(image, imageQuality);
    if (resizeData.length / 1024 > length) {
        imageQuality = 0.6;
    }
    
    while (resizeData.length / 1024 > length)
    {
        static int i = 0;
        i++;
        
        imageQuality = imageQuality - 0.1;
        resizeData = UIImageJPEGRepresentation(image,imageQuality);
        if (imageQuality < 0.2 || i > 4) {
            break;
        }
    }

    NSLog(@"UIImage+Scale: 大小: %f KB, 时间: %f s", (float)resizeData.length/1024, -[dateStart timeIntervalSinceNow]);
    return resizeData;

}



// 改变图像的尺寸(裁剪)
- (UIImage *)scaleImagetoSize:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *)scaleWithFactor:(CGFloat)factor
{
    CGFloat width = CGImageGetWidth(self.CGImage) * factor;
    CGFloat height = CGImageGetHeight(self.CGImage) * factor;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0,width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//等比例缩放
-(UIImage*)scaleToSomeSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    /***/
//    float radios = 1.0f;
    if (width > height) {
        float horizontalRadio = 800.0/width;
        if (horizontalRadio >= 1) {
            return self;
        }else
        {
            height = (int)(height*horizontalRadio);
            width = 800;
        }
    }else
    {
        float verticalRadio = 800/height;
        if (verticalRadio >= 1) {
            return self;
        }else
        {
            width = (int)(width * verticalRadio);
            height = 800;
        }
    }
     
     
    
    int xPos = (800 - width)/2;
    int yPos = (800 - height)/2;
    if (width > height) {
        yPos = 0.0f;
    }else
    {
        xPos = 0.0f;
    }
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    NSLog(@"当前图片:%@",scaledImage);
    return scaledImage;
}


@end
