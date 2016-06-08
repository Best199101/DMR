//
//  ImageTools.h
//  happigo
//
//  Created by shklxmac111 on 16/1/5.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageTools : NSObject

+(UIImage *)fixOrientation:(ALAssetOrientation)orientation
                     Image:(CGImageRef)sourceImage;

@end
