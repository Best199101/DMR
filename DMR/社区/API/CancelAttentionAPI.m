//
//  CancelAttentionAPI.m
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "CancelAttentionAPI.h"
#import "APIRequestProtocol.h"

#define CancelAttention @"concern/delete.do?account_id=%@&concerned_account_id=%@"

@interface CancelAttentionAPI () <APIRequestProtocol>


@property (nonatomic, strong) NSString *account_id; //关注人的主键，关联account_info的主键，若A关注B，则这里是A的主键
@property (nonatomic, strong) NSString *concerned_account_id; //被关注人的主键，关联account_info的主键，若A关注B，则这里是B的主键
@end

@implementation CancelAttentionAPI

#pragma mark - APIRequestProtocol的required方法

- (NSString*)APIReqeustURL
{
    return [NSString stringWithFormat:
            CancelAttention,
            _account_id,
            _concerned_account_id];
}
- (NSString*)APIHTTPMethod
{
    return  GETHTTPMethod ;
}

#pragma mark 公有方法
-(void)startRequestWithAccount_id:(NSString *)account_id
             Concerned_account_id:(NSString *)concerned_account_id{
    _account_id = account_id;
    _concerned_account_id = concerned_account_id;
    
    [self startRequestUsingPara:nil];
}

@end
