//
//  APIConfigHelper.h
//  xiaoqu
//
//  Created by steven on 10/24/15.
//  Copyright © 2015 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kJSONResponseSerializer;
extern NSString * const kDataStreamResponseSerializer;

extern NSString * const kJSONRequestSerializer;
extern NSString * const kDataStreamRequestSerializer;

extern NSString * const kURLDataCache;
extern NSString * const kModelDataCache;
extern NSString * const kNotCache;

@interface APIConfigHelper : NSObject
@property (nonatomic, copy)NSString *dataCacheType;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, copy)NSString *APIRequestSerializerType;
@property (nonatomic, copy)NSString *APIResponseSerializerType;
@end
