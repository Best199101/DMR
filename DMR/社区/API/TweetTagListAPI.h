//
//  TweetTagListAPI.h
//  happigo
//
//  Created by 李海龙 on 16/1/1.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface TweetTagListAPI : BaseAPIManager

-(void)startRequestWithTagname:(NSString *)tagname
                      Lasttime:(long)lasttime;

@property (nonatomic, assign) long lasttime ; // 上一次返回数据list中最后一条数据                                               updateTime。等于空默认获取第一页的数据

@end
