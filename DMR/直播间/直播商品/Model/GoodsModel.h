//
//  GoodsModel.h
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GoodsModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSString *pTitle;
@property (strong,nonatomic) NSString *pUrl;
@property (strong,nonatomic) NSString *pPic;
@property (strong,nonatomic) NSString *pPrice;
@property (strong,nonatomic) NSString *oPrice;

/**
 *  商品名称文字高度
 */
@property (assign,nonatomic) CGFloat titleHeight;

@end
