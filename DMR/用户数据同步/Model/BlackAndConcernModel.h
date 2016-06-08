//
//  BlackAndConcernModel.h
//  happigo
//
//  Created by fei on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BlackAndConcernModel : MTLModel<MTLJSONSerializing>

@property(strong,nonatomic) NSMutableArray *blacklist;
@property(strong,nonatomic) NSMutableArray *concernlist;

@end



