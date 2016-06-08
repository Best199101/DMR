//
//  TransformRawDataDelegate.h
//  xiaoqu
//
//  Created by steven on 6/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseAPIManager;
@protocol TransformRawDataProtocol <NSObject>
@optional
- (id)apiManager:(BaseAPIManager*)apiManager transformData:(NSDictionary *)data;
@end
