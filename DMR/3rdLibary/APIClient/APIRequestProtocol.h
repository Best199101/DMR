//
//  APIRequestManager.h
//  xiaoqu
//
//  Created by steven on 6/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConfigHelper.h"
@protocol APIRequestProtocol <NSObject>
@required
- (NSString*)APIReqeustURL;
- (NSString*)APIHTTPMethod;
@optional
- (NSString*)APITaskIndentifier;
//- (NSString*)APIRequestIsResponseSerializer;
//- (NSString*)APIRequestIsRequestSerializer;
- (void)APIManagerConfigHelper:(APIConfigHelper*)configHelper;
@end
