//
//  BaseAPIManager.m
//  xiaoqu
//
//  Created by steven on 6/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"
#import "SHUDID.h"
#import "NSString+isNilOrEmpty.h"
#import "NSString+MD5Addition.h"
#import "CacheManager.h"
#import "HTTPClient.h"
#import "Interface.h"

#define __kAPP_KEY                      @"e57d1f86535a9f3307ba7e869687e14f"


NSString * const GETHTTPMethod = @"GET";
NSString * const POSTHTTPMethod = @"POST";
NSString * const DELETEHTTPMethod = @"DELETE";
NSString * const PUTHTTPMethod = @"PUT";


@interface BaseAPIManager ()
@property (nonatomic, weak) id<APIRequestProtocol> child;
@property (nonatomic, copy,readwrite) NSString *taskIndentifier;
@property (nonatomic, copy, readwrite) NSString *taskURL;
@property (nonatomic, copy) NSString *reqeustURL;
@property (nonatomic, copy) NSString *APIHTTPMethod;
@property (nonatomic, strong,readwrite)NSError *error;
@property (nonatomic, assign,readwrite)NSInteger responseCode;
@property (nonatomic, copy, readwrite) NSString *responseMessage;
@property (nonatomic, strong,readwrite)NSDictionary *rawData;
@property (nonatomic, assign, readwrite)NSInteger taskID;
@property (nonatomic, strong) NSMutableArray *requestIdList;
//@property (nonatomic, copy) NSString *responseSerializerType;
//@property (nonatomic, copy) NSString *reqeustSerializerType;
@property (nonatomic, strong) APIConfigHelper *configHelper;
@property (nonatomic, copy, readwrite) NSString *cacheType;

@end

@implementation BaseAPIManager

- (void)dealloc
{
    if (self.apiMangerCallBackDelegate) {
        
        self.apiMangerCallBackDelegate = nil;
    }
    if (self.apiParamSourceDelegate) {
        self.apiParamSourceDelegate = nil;
    }
    self.taskIndentifier = nil;
    self.rawData = nil;
    self.APIHTTPMethod = nil;
    [self cancelAllTasks];
    self.requestIdList = nil;
    self.child = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.apiMangerCallBackDelegate = nil;
        self.apiParamSourceDelegate = nil;
        if ([self conformsToProtocol:@protocol(APIRequestProtocol)])
        {
            self.child = (id<APIRequestProtocol>)self;
        }
        else
        {
            NSAssert(NO, @"子类必须实现APIRequestProtocol这个protocol");
        }
    }
    return self;
}

- (void)apiManageWillRun
{
    //    NSLog(@"请求发出前运行:%@",[self class]);
    if (self.child && [self.child respondsToSelector:@selector(APIHTTPMethod)]) {
        
        self.APIHTTPMethod = [[self.child APIHTTPMethod] uppercaseString];
    }
    if (self.child && [self.child respondsToSelector:@selector(APIReqeustURL)]) {
        self.reqeustURL = [self.child APIReqeustURL];
    }
    if (self.child && [self.child respondsToSelector:@selector(APITaskIndentifier)]) {
        self.taskIndentifier = [self.child APITaskIndentifier];
    }
    //    if (self.child && [self.child respondsToSelector:@selector(APIRequestIsResponseSerializer)]) {
    //        self.responseSerializerType = [self.child APIRequestIsResponseSerializer];
    //    }
    //    if (self.child && [self.child respondsToSelector:@selector(APIRequestIsRequestSerializer)]) {
    //        self.reqeustSerializerType = [self.child APIRequestIsRequestSerializer];
    //    }
    if (self.child && [self.child respondsToSelector:@selector(APIManagerConfigHelper:)]) {
        APIConfigHelper *helper = [[APIConfigHelper alloc] init];
        [self.child APIManagerConfigHelper:helper];
        self.configHelper = helper;
    }
}

- (void)apiManageDidRun
{
    //    NSLog(@"请求发出后运行%@",[self class]);
    self.configHelper = nil;
}

- (NSUInteger)startRequestConformsParamSourceProtocol
{
    if (self.apiParamSourceDelegate && [self.apiParamSourceDelegate respondsToSelector:@selector(paramsForApiManager:)]) {
        NSDictionary *para = [self.apiParamSourceDelegate paramsForApiManager:self];
        return [self startRequestUsingPara:para].taskID;
    }else
    {
        NSLog(@"必须实现<APIManagerParamSourceDelegate>协议");
    }
    return -1;
}

- (BaseAPIManager*)startRequestUsingPara:(NSDictionary *)para
{
    
    
    [self apiManageWillRun];
    NSString *httpMethod = self.APIHTTPMethod;
    if (httpMethod == nil) {
        httpMethod = @"";
    }
    
    NSString *restHostIP;
    if (restHostIP == nil) {
        restHostIP = KHeaderURL;
    }
    NSString *relateURL = [self netWorkURLString:self.reqeustURL];
    if (relateURL == nil) {
        relateURL = @"";
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",restHostIP,relateURL];
    if ([relateURL isContainSubString:@"http://"]) {
        url = relateURL;
    }
    
    if ([httpMethod isEqualToString:POSTHTTPMethod]) {
        if (para == nil) {
            para = @{};
        }else {
            para = [self addMd5ToBody:para];
        }
    }
    
    NSString *responseSerializerType = self.configHelper.APIResponseSerializerType;
    if (responseSerializerType == nil) {
        responseSerializerType = kJSONResponseSerializer;
    }
    NSString *requestSerializerType = self.configHelper.APIRequestSerializerType;
    if (requestSerializerType == nil) {
        requestSerializerType = kJSONRequestSerializer;
    }
    self.taskURL = url;
    NSTimeInterval timeout = self.configHelper.timeout;
    NSString *dataCacheType = self.configHelper.dataCacheType;
    //    NSString *cacheJSONMD5 = nil;
    self.cacheType = dataCacheType;
    if ([dataCacheType isEqualToString:kURLDataCache]) {
        id JSON = [CacheManager readCacheWithURLKey:url andType:CacheTypeQuestion];
        if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
            if (self.apiMangerCallBackDelegate && [self.apiMangerCallBackDelegate respondsToSelector:@selector(apiRequestManagerDidSuccess:)])
            {
                self.rawData = JSON;
                self.responseCode = 1;
                self.responseMessage = @"";
                [self.apiMangerCallBackDelegate apiRequestManagerDidSuccess:self];
            }
        }
    }
    NSInteger requestID  = [[HTTPClient shareInstance] requestWithConfigure:^(BuilderConfiguration *builder) {
        builder.httpMethod = httpMethod;
        builder.url = url;
        builder.isRequestSerializer = YES;
        builder.timeoutIntervalForRequest = timeout;
        if ([responseSerializerType isEqualToString:kJSONResponseSerializer]) {
            builder.isResponseSerializer = YES;
        }else
        {
            builder.isResponseSerializer = NO;
        }
        if ([requestSerializerType isEqualToString:kJSONRequestSerializer]) {
            builder.isRequestSerializer = YES;
        }else
        {
            builder.isRequestSerializer = NO;
        }
    } withParameter:para WithCallBack:^(NSInteger responseCode, id responseObject, NSError *error, NSString *rspMessage) {
        if (responseCode == SuccessCode)
        {
            if ([dataCacheType isEqualToString:kURLDataCache]) {
                [CacheManager saveCacheWithObject:responseObject ForURLKey:url AndType:CacheTypeQuestion];
                //                NSData *JSONData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                //                NSString *cacheNetMD5 = [[[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding] MD5FromString];
                //                if ([cacheJSONMD5 isEqualToString:cacheNetMD5]) {
                //                    return;
                //                }
            }
            
            if (self.apiMangerCallBackDelegate && [self.apiMangerCallBackDelegate respondsToSelector:@selector(apiRequestManagerDidSuccess:)])
            {
                self.rawData = responseObject;
                self.responseCode = responseCode;
                self.responseMessage = rspMessage;
                [self.apiMangerCallBackDelegate apiRequestManagerDidSuccess:self];
            }
        }
        else
        {
            if (self.apiMangerCallBackDelegate && [self.apiMangerCallBackDelegate respondsToSelector:@selector(apiRequestManagerDidFailed:)])
            {
                self.error = error;
                self.responseCode = responseCode;
                self.responseMessage = rspMessage;
                [self.apiMangerCallBackDelegate apiRequestManagerDidFailed:self];
            }
        }
        
    }];
    self.taskID =requestID;
    [self apiManageDidRun];
    return self;
}

- (id)fetchDataWithTransformer:(id<TransformRawDataProtocol>)transformer
{
    if (transformer == nil)
    {
        if ([self.rawData isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        return self.rawData;
    }
    else
    {
        return [transformer apiManager:self transformData:self.rawData];
    }
}


- (NSString *)netWorkURLString:(NSString *)URLString;
{
    
    if (! URLString) return @"";
    
    NSMutableString *url = [URLString mutableCopy];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        
        //        NSUInteger loc = [URLString rangeOfString:@"?"].location;
        //        [url insertString:[NSString stringWithFormat:@"?deviceId=%@",[SHUDID sharedUDID]] atIndex:loc];
        url = [[url stringByAppendingString:[NSString stringWithFormat:@"&deviceId=%@",[SHUDID sharedUDID]]] mutableCopy];
        
    }else {
        //        url = [[[url stringByAppendingPathComponent:[SHUDID sharedUDID]] stringByAppendingString:[NSString stringWithFormat:@"?vname=%@&vcode=%@&type=iOS",version,build]] mutableCopy];
    }
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (void)cancelAllTasks
{
    [[HTTPClient shareInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelTaskWithTaskIdentifier:(NSUInteger)taskIdentifier
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == taskIdentifier) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
    [[HTTPClient shareInstance] cancelRequestWithRequestID:@(taskIdentifier)];
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (NSDictionary *)addMd5ToBody:(NSDictionary *)dict
{
    NSMutableString *md5 = [[NSMutableString alloc]init];
    NSMutableDictionary *destDict = [[NSMutableDictionary alloc]init];
    //    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    for (NSString *key in dict) {
        [destDict setObject:[dict objectForKey:key] forKey:key];
    }
    if (dict != nil) {
        NSError *error = nil;
        NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        if (jsonString) {
            
            [md5 appendString:jsonString];
        }
        if ([SHUDID sharedUDID]) {
            
            [md5 appendString:[SHUDID sharedUDID]];
        }
        
        [md5 appendString:__kAPP_KEY];
    }
    //    if ([SHUDID UDID]) {
    //        [destDict setObject:[SHUDID UDID] forKey:@"deviceId"];
    //    }
    //    [destDict setObject:__kAPP_KEY forKey:@"app_key"];
    
    //    NSArray *allKey = [destDict allKeys];
    //    allKey = [allKey sortedArrayUsingSelector:@selector(compare:)];
    //    for (NSString *key in allKey) {
    //        [md5 appendString:destDict[key]];
    //    }
    NSString *md5Value = [[md5 MD5FromString] copy];
    if (md5Value != nil) {
        [destDict setObject:md5Value forKey:@"md5"];
    }
    return destDict;
    //    NSMutableDictionary * dataDict = [dict mutableCopy];
    //    [dataDict setObject:md5 forKey:@"md5"];
    //    return dataDict;
}

- (APIConfigHelper *)configHelper
{
    if (_configHelper == nil) {
        _configHelper = [[APIConfigHelper alloc] init];
    }
    return _configHelper;
}


@end
