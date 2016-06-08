//
//  CommonBannerModel.h
//  happigo
//
//  Created by shklxjsbmac004 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CommonBannerModel : MTLModel<MTLJSONSerializing>
//社区首页公共信息  --banner以及公告
@property (strong,nonatomic) NSString *banner_left;
@property (strong,nonatomic) NSString *banner_right;
@property (strong,nonatomic) NSString *broadcast;
@property (strong,nonatomic) NSArray *banners;

@end
