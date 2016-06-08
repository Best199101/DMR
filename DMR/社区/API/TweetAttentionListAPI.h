//
//  TweetAttentionListAPI.h
//  happigo
//
//  Created by 李海龙 on 15/12/29.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface TweetAttentionListAPI : BaseAPIManager

-(void)startRequestWithLastTime:(long)lastTime uid:(NSString *)uid;
@end
