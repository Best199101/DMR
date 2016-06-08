//
//  SayToStringModel.h
//  xiaoqu
//
//  Created by wendy on 15/5/27.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SayToStringModel : NSObject

@property (strong,nonatomic) NSString* uid;
@property (strong,nonatomic) NSString* nickName;
@property (assign) NSInteger startRange;
@property (assign) NSInteger endRange;
@property (strong,nonatomic) NSString* AtString;

@end
