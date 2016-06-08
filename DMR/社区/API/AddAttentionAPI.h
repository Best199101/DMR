//
//  AddAttentionAPI.h
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "TweetListModel.h"

@interface AddAttentionAPI : BaseAPIManager

@property (strong,nonatomic) TweetListModel *model;

-(void)startRequestWithAccount_id:(NSString *)account_id
             Concerned_account_id:(NSString *)concerned_account_id;
@end
