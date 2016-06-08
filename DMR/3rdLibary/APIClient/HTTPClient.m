//
//  HTTPClient.m
//  xiaoqu
//
//  Created by steven on 4/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import "HTTPClient.h"
#import "SHUDID.h"
#import <UIKit/UIKit.h>
#define GET_RESPONSE_CODE_AND_MESSAGE \
int responseCode = [responseObject[@"status"] intValue]; \
NSString* __unused responseMsg = [responseObject objectForKey:@"message"]; \
if([[responseObject objectForKey:@"serviceCode"] isKindOfClass:[NSNull class]]) { \
    return; \
} \
NSInteger responsServiceCode = [[responseObject objectForKey:@"serviceCode"] integerValue]; \


NSString *const responseErrorMsg = @"responseErrorMsg";


@interface HTTPConfiguration ()
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForRequest;
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForResource;
@property (nonatomic, assign) BOOL isResponseSerializer;
@property (nonatomic, assign) BOOL isRequestSerializer;
@property (nonatomic, strong) NSMutableDictionary *HTTPAdditionalHeaders;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *URLString;
@end

@implementation HTTPConfiguration

@end

@interface BuilderConfiguration ()

@end

@implementation BuilderConfiguration


@end

@interface HTTPClient ()
@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@end

@implementation HTTPClient
+ (instancetype)shareInstance
{
    static HTTPClient *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
            
            shareInstance = [[HTTPClient alloc] init];
        }
    });
    return shareInstance;
}

- (NSInteger)requestWithConfigure:(ConfigurationBuilderBlock)buildConfiguration withParameter:(NSDictionary *)para WithCallBack:(void (^)(NSInteger, id, NSError *, NSString *rspMessage))completeCallBack
{
    BuilderConfiguration *builderConfig = [[BuilderConfiguration alloc] init];
    buildConfiguration(builderConfig);
    HTTPConfiguration *configuration = [[HTTPConfiguration alloc] init];
    configuration.timeoutIntervalForRequest = builderConfig.timeoutIntervalForRequest;
    configuration.timeoutIntervalForResource = builderConfig.timeoutIntervalForResource;
    configuration.isRequestSerializer = builderConfig.isRequestSerializer;
    configuration.isResponseSerializer = builderConfig.isResponseSerializer;
    configuration.HTTPAdditionalHeaders = builderConfig.HTTPAdditionalHeaders;
    configuration.URLString = builderConfig.url;
    configuration.httpMethod = builderConfig.httpMethod;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (configuration.timeoutIntervalForRequest <= 0) {
        configuration.timeoutIntervalForRequest = 30;
    }
    if (configuration.timeoutIntervalForResource <= 0) {
        configuration.timeoutIntervalForResource = 30;
    }
    sessionConfiguration.timeoutIntervalForResource = configuration.timeoutIntervalForResource;
    sessionConfiguration.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest;
    sessionConfiguration.HTTPAdditionalHeaders = configuration.HTTPAdditionalHeaders;
    AFHTTPSessionManager *httSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    if (configuration.isResponseSerializer) {
        httSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else
    {
        httSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    if (configuration.isRequestSerializer) {
        httSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else
    {
        httSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    httSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    __block NSURLSessionDataTask *dataTask = nil;
    self.httpManager = httSessionManager;
    if ([configuration.httpMethod isEqualToString:@"GET"]) {
        dataTask = [self getWithURL:configuration.URLString WithPara:para WithCallBack:completeCallBack];
    }
    if ([configuration.httpMethod isEqualToString:@"POST"]) {
        dataTask = [self postWithURL:configuration.URLString WithPara:para WithCallBack:completeCallBack];
    }
    if ([configuration.httpMethod isEqualToString:@"DELETE"]) {
        dataTask = [self deleteWithURL:configuration.URLString WithPara:para WithCallBack:completeCallBack];

    }
    if ([configuration.httpMethod isEqualToString:@"PUT"]) {
        dataTask = [self putWithURL:configuration.URLString WithPara:para WithCallBack:completeCallBack];
    }
    if (dataTask == nil) {
        return -1;
    }
    return dataTask.taskIdentifier;
}

- (NSURLSessionDataTask*)postWithURL:(NSString *)url WithPara:(NSDictionary *)dic WithCallBack:(void (^)(NSInteger, id, NSError *, NSString*))completeCallBack
{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *postURL = url;//[NSString stringWithFormat:@"%@%@",[self baseURL],[self netWorkURLString:url]];
    NSDate *requestDate = [NSDate date];
    __weak typeof(&*self) weakSelf = self;
    NSURLSessionDataTask *postTask = [self.httpManager POST:postURL
                                                 parameters:dic
                                                    success:^void(NSURLSessionDataTask * __nonnull task, id __nonnull responseObject) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:responseObject
                                   Error:nil
                         WithRequestDate:requestDate
                              WithMethod:@"POST"
                IfNoDelegateWithCallBack:completeCallBack];
        
    } failure:^void(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:nil
                                   Error:error
                         WithRequestDate:requestDate
                              WithMethod:@"POST"
                IfNoDelegateWithCallBack:completeCallBack];
    }];
    self.dispatchTable[@(postTask.taskIdentifier)] = postTask;
    return postTask;
}

- (NSURLSessionDataTask*)deleteWithURL:(NSString *)url WithPara:(NSDictionary *)dic WithCallBack:(void (^)(NSInteger, id, NSError *,NSString*))completeCallBack
{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deleteURL = url;// [NSString stringWithFormat:@"%@%@",[self baseURL],[self netWorkURLString:url]];
    NSDate *requestDate = [NSDate date];
    __weak typeof(&*self) weakSelf = self;
    NSURLSessionDataTask *deleteTask = [self.httpManager DELETE:deleteURL parameters:dic success:^void(NSURLSessionDataTask * __nonnull task, id __nonnull responseObject) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:responseObject
                                   Error:nil
                         WithRequestDate:requestDate
                              WithMethod:@"DELETE"
                IfNoDelegateWithCallBack:completeCallBack];
        
    } failure:^void(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:nil
                                   Error:error
                         WithRequestDate:requestDate
                              WithMethod:@"DELETE"
                IfNoDelegateWithCallBack:completeCallBack];
        
    }];
    self.dispatchTable[@(deleteTask.taskIdentifier)] = deleteTask;
    return deleteTask;
}

- (NSURLSessionDataTask*)getWithURL:(NSString *)url WithPara:(NSDictionary *)dic  WithCallBack:(void (^)(NSInteger, id, NSError *, NSString*))completeCallBack
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *getURL = url;//[NSString stringWithFormat:@"%@%@",[self baseURL],[self netWorkURLString:url]];
    NSDate *requestDate = [NSDate date];
    __weak typeof(&*self) weakSelf = self;
    NSURLSessionDataTask *getTask = [self.httpManager GET:getURL
                                               parameters:dic
                                                  success:^void(NSURLSessionDataTask * __nonnull task, id __nonnull responseObject) {
                                                      
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:responseObject
                                   Error:nil
                         WithRequestDate:requestDate
                              WithMethod:@"GET"
                IfNoDelegateWithCallBack:completeCallBack];
        
    } failure:^void(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:nil
                                   Error:error
                         WithRequestDate:requestDate
                              WithMethod:@"GET"
                IfNoDelegateWithCallBack:completeCallBack];
    }];
    self.dispatchTable[@(getTask.taskIdentifier)] = getTask;
    return getTask;
}

- (NSURLSessionDataTask*)putWithURL:(NSString *)url WithPara:(NSDictionary *)dic  WithCallBack:(void (^)(NSInteger, id, NSError *, NSString*))completeCallBack
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *putURL = url;// [NSString stringWithFormat:@"%@%@",[self baseURL],[self netWorkURLString:url]];
    NSDate *requestDate = [NSDate date];
    __weak typeof(&*self) weakSelf = self;
    NSURLSessionDataTask *putDataTask = [self.httpManager PUT:putURL
                                                   parameters:dic
                                                      success:^void(NSURLSessionDataTask * __nonnull task, id __nonnull responseObject) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:responseObject
                                   Error:nil
                         WithRequestDate:requestDate
                              WithMethod:@"PUT"
                IfNoDelegateWithCallBack:completeCallBack];
        
        
    } failure:^void(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        [weakSelf handleResponseWithTask:task
                               withClass:nil
                            repsonseObjc:nil
                                   Error:error
                         WithRequestDate:requestDate
                              WithMethod:@"PUT"
                IfNoDelegateWithCallBack:completeCallBack];
        
    }];
    self.dispatchTable[@(putDataTask.taskIdentifier)] = putDataTask;
    return putDataTask;
}


- (void)handleResponseWithTask:(NSURLSessionDataTask*)dataTask withClass:(Class)modelClass repsonseObjc:(id)responseObject Error:(NSError*)error WithRequestDate:(NSDate*)date WithMethod:(NSString*)method IfNoDelegateWithCallBack:(void (^)(NSInteger errorCode, id responseObject, NSError * error, NSString* respMessage))completeCallBack
{
    NSDate *reponseDate = [NSDate date];
    NSTimeInterval time = [reponseDate timeIntervalSinceDate:date];
    NSHTTPURLResponse *responseTask = (NSHTTPURLResponse*)dataTask.response;
    NSInteger httpStatus = responseTask.statusCode;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"\n\n请求URL:%@\n接口请求返回时间:%@",dataTask.originalRequest.URL.absoluteString,@(time));
    if (error) {
        
        NSString *rsp = @"网络不给力啊，请稍后再试下";//error.userInfo[NSLocalizedDescriptionKey];
        NSError *customerror = [NSError errorWithDomain:error.domain code:error.code userInfo:@{responseErrorMsg:@"网络不给力啊，请稍后再试下"}];
        completeCallBack(customerror.code,nil,customerror,rsp);
    }else
    {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            GET_RESPONSE_CODE_AND_MESSAGE
            if (responseCode == SuccessCode) {
                completeCallBack(responseCode,responseObject,nil,responseMsg);
                
            }else
            {
                if (responseMsg) {
                    NSError *error = [NSError errorWithDomain:dataTask.taskDescription code:responseCode userInfo:@{responseErrorMsg:responseMsg}];
                    completeCallBack(responseCode,nil,error,responseMsg);
                }
            }
        }else
        {
            completeCallBack(1,responseObject,error,nil);
        }
    }
    
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    if (requestID) {
        NSURLSessionTask *task = self.dispatchTable[requestID];
        [task cancel];
        [self.dispatchTable removeObjectForKey:requestID];
    }
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
        
    }
    return _dispatchTable;
}
@end
