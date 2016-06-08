//
//  APIConfigHelper.m
//  xiaoqu
//
//  Created by steven on 10/24/15.
//  Copyright © 2015 Neighbourhood. All rights reserved.
//

#import "APIConfigHelper.h"

NSString * const kJSONResponseSerializer = @"JSONResponseSerializer";
NSString * const kDataStreamResponseSerializer = @"DataStreamResponseSerializer";

NSString * const kJSONRequestSerializer = @"JSONRequestSerializer";
NSString * const kDataStreamRequestSerializer = @"DataStreamRequestSerializer";

NSString * const kURLDataCache = @"ULRDataCache";
NSString * const kModelDataCache = @"ModelDataCache";
NSString * const kNotCache = @"kNotCache";

@implementation APIConfigHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeout = 30.0f;
        self.APIRequestSerializerType = kJSONRequestSerializer;
        self.APIResponseSerializerType = kJSONResponseSerializer;
        self.dataCacheType = kNotCache;
    }
    return self;
}

@end
