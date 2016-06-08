//
//  LiveGoodsViewController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseViewController.h"

@interface LiveGoodsViewController : BaseViewController

/**
 *  直播商品页初始化
 *
 *  @param products 直播商品数组
 *
 *  @return
 */
-(instancetype)initWithProducts:(NSMutableArray *)products;

@end
