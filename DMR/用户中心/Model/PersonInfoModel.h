//
//  PersonInfoModel.h
//  happigo
//
//  Created by fei on 16/2/22.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@class UnreadNotifyModel;

@interface PersonInfoModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *nickname;
@property(nonatomic, strong) NSNumber *update_time;
@property(nonatomic, strong) NSNumber *is_master;
@property(nonatomic, strong) NSNumber *experience;
@property(nonatomic, strong) NSNumber *myFanNum;
@property(nonatomic, strong) NSString *uid;
@property(nonatomic, strong) NSString *qukHostSort;
@property(nonatomic, strong) NSNumber *concernNum;
@property(nonatomic, strong) NSNumber *isQukHost;
@property(nonatomic, strong) NSNumber *age;
@property(nonatomic, strong) NSString *birthday;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSNumber *open_video;
@property(nonatomic, strong) NSNumber *jfNo;
@property(nonatomic, strong) NSNumber *level;
@property(nonatomic, strong) NSNumber *sex;
@property(nonatomic, strong) NSString *head_img_url;
@property(nonatomic, strong) NSNumber *create_time;
@property(nonatomic, strong) NSNumber *topicNum;
@property(nonatomic, strong) NSNumber *topicVideoNum;
@property(nonatomic, strong) NSNumber *qukVideoNum;
@property(nonatomic, strong) NSNumber *myHomepage;
@property(nonatomic, strong) NSNumber *isAdmin;
@property(nonatomic, strong) NSNumber *isSign;
@property(nonatomic, strong) UnreadNotifyModel *notifyCount;

@property (assign,nonatomic) NSInteger attentionActionState; // 0 未操作，1 正在关注中
@property (assign,nonatomic) BOOL isInBlackList;


//设置界面-->个人资料
@property (nonatomic, strong) NSArray *personInfoArray;

@end

@interface UnreadNotifyModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSNumber *praiseCount;
@property(nonatomic, strong) NSNumber *noticeCount;;
@property(nonatomic, strong) NSNumber *atCount;
@property(nonatomic, strong) NSNumber *commentCount;

@end




