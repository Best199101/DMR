//
//  DeleteImageAPI.h
//  happigo
//
//  Created by 李海龙 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface DeleteImageAPI : BaseAPIManager

-(void)startRequestWithUid:(NSString *)uid Picname:(NSString *)picname;
@end
