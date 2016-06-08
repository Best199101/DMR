//
//  HTTPClient.h
//  xiaoqu
//
//  Created by steven on 4/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#define SuccessCode 0

@class BuilderConfiguration;
typedef void (^ConfigurationBuilderBlock)(BuilderConfiguration *builder);

@interface HTTPConfiguration : NSObject

@end

@interface BuilderConfiguration : NSObject
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForRequest;
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForResource;
@property (nonatomic, assign) BOOL isResponseSerializer;
@property (nonatomic, assign) BOOL isRequestSerializer;
@property (nonatomic, strong) NSMutableDictionary *HTTPAdditionalHeaders;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *url;
@end

@interface HTTPClient : NSObject

extern NSString *const responseErrorMsg;

+ (instancetype)shareInstance;

- (NSInteger)requestWithConfigure:(ConfigurationBuilderBlock)buildConfiguration withParameter:(NSDictionary*)para WithCallBack:(void(^)(NSInteger responseCode, id responseObject, NSError *error,  NSString *rspMessage))completeCallBack;


- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
