//
//  AttentionModel.h
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AttentionModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headurl;
@property (nonatomic, strong) NSNumber *ismaster;
@property (nonatomic, strong) NSString *desc;

@end
