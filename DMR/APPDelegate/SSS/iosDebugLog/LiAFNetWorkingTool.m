////
////  LiAFNetWorkingTool.m
////  happigo
////
////  Created by klx on 15/3/13.
////  Copyright (c) 2015年 klx.iOS. All rights reserved.
////
//
//#import "LiAFNetWorkingTool.h"
//#import "NSString+PhoneNumber.h"
//#import <AFNetworking.h>
//
//@implementation LiAFNetWorkingTool
//
//+(void)GET:(NSString *)URLString parameters:(id)parameters
//   success:(void (^)(id responseObject))success
//   failure:(void (^)(NSString *))failure
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager POST:URLString
//       parameters:[NSString signWithSourceParameters:parameters]
//          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableLeaves error:nil];
//        success(responseDic);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        failure([error.domain stringByAppendingString:error.description]);
//    }];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager POST:URLString parameters:[NSString signWithSourceParameters:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //[TNToast hideLoadingToast];
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        success(responseDic);
//    }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //[TNToast hideLoadingToast];
//        [TNToast showNetworkError];
//        failure([error.domain stringByAppendingString:error.description]);
//    }];
//}
//
//
//+(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *))failure  {
//    //[TNToast showLoadingToast];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager POST:URLString parameters:[NSString signWithSourceParameters:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //[TNToast hideLoadingToast];
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        success(responseDic);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //[TNToast hideLoadingToast];
//        [TNToast showNetworkError];
//        failure([error.domain stringByAppendingString:error.description]);
//    }];
//}
//
//
//+(void)GETS:(NSString *)URLString parameters:(id)parameters
//   success:(void (^)(id responseObject))success
//   failure:(void (^)(NSString *))failure
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager POST:URLString parameters:[NSString signWithSourceParameters:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //[TNToast hideLoadingToast];
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        success(responseDic);
//    }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              //[TNToast hideLoadingToast];
////              [TNToast showNetworkError];
//              failure([error.domain stringByAppendingString:error.description]);
//          }];
//}
//
//
//
//
//
//@end
