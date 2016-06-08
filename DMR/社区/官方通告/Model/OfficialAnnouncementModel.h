//
//  OfficialAnnouncementModel.h
//  happigo
//
//  Created by shklxmac111 on 16/1/3.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OfficialAnnouncementModel : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSArray *banners;

@end
