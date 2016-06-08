//
//  TagListModel.h
//  happigo
//
//  Created by 李海龙 on 16/1/1.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ListModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSArray *tags;
@property (strong,nonatomic) NSArray *hotTags;

@end

@interface TagListModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSString *tag_name;

@end
