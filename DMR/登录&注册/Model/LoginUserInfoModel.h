//
//  LoginUserInfoModel.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LoginUserInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *head_img_url;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *jfNo;
@property (nonatomic, strong) NSString *gold;
@property (nonatomic, strong) NSString *is_master;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *_description;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSNumber *isAdmin;
@property (nonatomic, strong) NSString *open_video;

@end
