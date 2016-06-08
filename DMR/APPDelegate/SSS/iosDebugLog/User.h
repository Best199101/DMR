//
//  User.h
//  happigo
//
//  Created by klx on 15/3/12.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *head_img_url;
@property (strong, nonatomic) NSNumber *sex;
@property (strong, nonatomic) NSString *sexStr;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSNumber *level;
@property (strong, nonatomic) NSNumber *experience;
@property (strong, nonatomic) NSNumber *jfNo;
@property (strong, nonatomic) NSNumber *gold;
@property (strong, nonatomic) NSNumber *is_Master;
@property (strong, nonatomic) NSNumber *create_time;
@property (strong, nonatomic) NSNumber *update_time;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *signature;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSArray  *tags;
@property (strong, nonatomic) NSNumber *isAdmin;
@property (strong, nonatomic) NSString *open_video;
@property (strong, nonatomic) NSNumber *isSign;
@property (strong, nonatomic) NSDictionary *notifyCount;
@property (strong, nonatomic) NSNumber *myFanNum;
@property (strong, nonatomic) NSNumber *concernNum;
@property (strong, nonatomic) NSNumber *topicNum;
@property (strong, nonatomic) NSNumber *topicVideoNum;
@property (strong, nonatomic) NSNumber *qukVideoNum;

@property (strong, nonatomic) NSNumber *experience_from;
@property (strong, nonatomic) NSNumber *experience_to;


@property (strong, nonatomic) NSString *phoneNum;

@property (strong, nonatomic) NSString *picHeader;

@property (assign, nonatomic) BOOL hasConcerned;

+ (id)initWithDictionary:(NSDictionary *)dic;
@end
