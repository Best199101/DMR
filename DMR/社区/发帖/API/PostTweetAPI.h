//
//  PostTweetAPI.h
//  happigo
//
//  Created by 李海龙 on 15/12/31.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface PostTweetAPI : BaseAPIManager<APIRequestProtocol>

/**
 *  发帖
 *
 *  @param uid      当前用户id
 *  @param title    帖子标题（晒图贴用，预留）
 *  @param content  帖子内容
 *  @param tags     标签，多个标签以;隔开
 *  @param pic      图片名称，多张图片以;隔开
 *  @param location 定位信息
 *  @param ats      被@的用户列表，多个id以;隔开
 */

-(void)startRequestWithUid:(NSString *)uid
                     Title:(NSString *)title
                   Content:(NSString *)content
                      Tags:(NSString *)tags
                       Pic:(NSString *)pic
                  Location:(NSString *)location
                       Ats:(NSString *)ats;

@end
