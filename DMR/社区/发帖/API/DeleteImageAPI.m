//
//  DeleteImageAPI.m
//  happigo
//
//  Created by 李海龙 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "DeleteImageAPI.h"
#import "APIRequestProtocol.h"

#define DeleteImage @"new/file/delete.do?uid=%@&picname=%@"

@interface DeleteImageAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *uid; //当前用户id
@property (nonatomic, strong) NSString *picname; //需要被删除的图片名字

@end

@implementation DeleteImageAPI

#pragma mark - APIRequestProtocol的required方法
- (NSString*)APIReqeustURL{
    return [NSString stringWithFormat:DeleteImage,_uid,_picname];
}
- (NSString*)APIHTTPMethod;{
    return GETHTTPMethod;
}

#pragma mark 公有方法

-(void)startRequestWithUid:(NSString *)uid Picname:(NSString *)picname{
    _uid = uid;
    _picname = picname;
    [self startRequestUsingPara:nil];
}


@end
