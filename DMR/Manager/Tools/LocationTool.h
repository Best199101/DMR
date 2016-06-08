//
//  GetLocationTool.h
//  happigo
//
//  Created by mac110 on 16/4/12.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationTool : NSObject

+ (instancetype) sharedInstance;
- (void) getCityName:(void (^)(NSString *cityName))callBack;

@end
