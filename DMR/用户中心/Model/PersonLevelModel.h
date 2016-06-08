//
//  PersonLevelModel.h
//  happigo
//
//  Created by fei on 16/3/2.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PersonLevelModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSNumber *level;
@property(nonatomic, strong) NSString *update_time;
@property(nonatomic, strong) NSString *level_key;
@property(nonatomic, strong) NSNumber *create_time;
@property(nonatomic, strong) NSNumber *experience_from;
@property(nonatomic, strong) NSNumber *experience_to;
@property(nonatomic, strong) NSString *level_description;

@end
