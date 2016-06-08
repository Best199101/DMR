//
//  UIImageView+DMRLoading.h
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DMRLoading)

-(void)loadImageBySourceString:(NSString *)string
                        Header:(NSString *)header
                         width:(int)width
                        Height:(int)height;

-(void)loadImageWithOutRandomColorBySourceString:(NSString *)string
                                          Header:(NSString *)header
                                           width:(int)width
                                          Height:(int)height;

-(void)loadImageWithRandomColorBySourceString:(NSString *)string
                                          Header:(NSString *)header
                                           width:(int)width
                                          Height:(int)height;


@end
