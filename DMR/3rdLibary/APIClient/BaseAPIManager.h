//
//  BaseAPIManager.h
//  xiaoqu
//
//  Created by steven on 6/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransformRawDataProtocol.h"


extern NSString * const GETHTTPMethod;
extern NSString * const POSTHTTPMethod;
extern NSString * const DELETEHTTPMethod;
extern NSString * const PUTHTTPMethod;


@class BaseAPIManager;
@protocol APIRequestManagerDelegate <NSObject>

- (void)apiRequestManagerDidSuccess:(BaseAPIManager*)apiManager;
- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager;

@end

@protocol APIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApiManager:(BaseAPIManager *)manager;
@end



@interface BaseAPIManager : NSObject

@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, assign, readonly)NSInteger responseCode;
@property (nonatomic, copy, readonly) NSString *taskURL;
@property (nonatomic, copy, readonly) NSString *taskIndentifier;
@property (nonatomic, copy, readonly) NSString *responseMessage;
@property (nonatomic, assign, readonly) NSInteger taskID;
@property (nonatomic, copy, readonly) NSString *cacheType;
@property (nonatomic, weak) id<APIRequestManagerDelegate>apiMangerCallBackDelegate;
@property (nonatomic, weak) id<APIManagerParamSourceDelegate>apiParamSourceDelegate;
- (BaseAPIManager*)startRequestUsingPara:(NSDictionary*)para;
- (NSUInteger)startRequestConformsParamSourceProtocol;
- (id)fetchDataWithTransformer:(id<TransformRawDataProtocol>)transformer;
- (void)cancelAllTasks;
- (void)cancelTaskWithTaskID:(NSUInteger)taskID;

@end
