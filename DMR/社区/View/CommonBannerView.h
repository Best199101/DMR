//
//  CommonBannerView.h
//  happigo
//
//  Created by shklxmac111 on 15/12/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonBannerModel;

extern NSString *const bannerImageViewLeft;
extern NSString *const bannerImageViewRight;


@interface CommonBannerView : UIView

-(void)setContentWithModel:(CommonBannerModel *)model;

+(CGFloat)heightForCommonBannerView;

@end
