//
//  User.m
//  happigo
//
//  Created by klx on 15/3/12.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "User.h"

@implementation User


/*
 +(NSDictionary *)getSourceDictionaryWithUser:(User *)user{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    return dic;
}
*/

+ (id)initWithDictionary:(NSDictionary *)dic {
    User *user = [User new];
    [user setValuesForKeysWithDictionary:dic];
    return user;
}

- (id)valueForUndefinedKey:(NSString *)key {
    return @"";
}

- (NSString *)sexStr  {
    return self.sex.intValue == 2 ? @"女" : self.sex.intValue == 1 ? @"男" : @"未知";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqual:@"description"]) {
        self.signature = value;
    }
    if ([key isEqual:@"is_master"]) {
        self.is_Master = value;
    }
    if ([key isEqual:@"count"]) {
        self.notifyCount = value;
    }
    
}



@end
