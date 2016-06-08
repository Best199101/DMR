//
//  ThemeActivitiesModel.h
//  happigo
//
//  Created by fei on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ThemeActivitiesModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSArray *data;

@end

@interface ActivitiesModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) NSString *bannerTarget;
@property(nonatomic, strong) NSString *shareUrl;
@property(nonatomic, strong) NSString *shareTitle;
@property(nonatomic, strong) NSString *shareContent;
@property(nonatomic, strong) NSString *sharePic;
//1-H5
//2-点播详情
//3-直播详情
//4-美人课堂
//5-社区问答
//6-社区晒图
//7-标签提取视频
@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, strong) NSNumber *isPublish;
@property(nonatomic, strong) NSNumber *deleteFlag;
@property(nonatomic, strong) NSNumber *createTime;
@property(nonatomic, strong) NSString *updateTime;
@property(nonatomic, strong) NSString *publishTime;


@end

