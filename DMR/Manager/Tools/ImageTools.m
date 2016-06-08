//
//  ImageTools.m
//  happigo
//
//  Created by shklxmac111 on 16/1/5.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "ImageTools.h"

@implementation ImageTools

+(UIImage *)fixOrientation:(ALAssetOrientation)orientation
                     Image:(CGImageRef)sourceImage
{
    UIImage *image;
    if (orientation == ALAssetOrientationDown)
    {
            image = [UIImage imageWithCGImage:sourceImage
                                        scale:1
                                  orientation:UIImageOrientationDown];
    }
    else if (orientation == ALAssetOrientationLeft)
    {
        image = [UIImage imageWithCGImage:sourceImage
                                    scale:1
                              orientation:UIImageOrientationLeft];
    }
    else if (orientation == ALAssetOrientationRight)
    {
        image = [UIImage imageWithCGImage:sourceImage
                                    scale:1
                              orientation:UIImageOrientationRight];
    }
    else if (orientation == ALAssetOrientationUp)
    {
        image = [UIImage imageWithCGImage:sourceImage
                                    scale:1
                              orientation:UIImageOrientationUp];
    }
    return image;

}

@end
