//
//  GoodsGuideView.h
//  happigo
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "BaseView.h"
@class GoodsModel;

extern NSString *const LiveGoodsDetailButtonTapped;
extern NSString *const LiveGoodsCollectButtonTapped;
extern NSString *const LiveGoodsCancelCollectButtonTapped;

@interface GoodsGuideView : BaseView

@property (strong,nonatomic) GoodsModel *model;

-(void)setContentWithModel:(GoodsModel *)model;


/**
 *  设置收藏按钮状态
 *
 *  @param collected 是否收藏该商品
 */
-(void)setCollectButtonState:(BOOL)collected;

+(CGFloat)heightForModel:(GoodsModel *)model;


@end
