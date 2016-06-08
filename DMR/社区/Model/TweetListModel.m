//
//  TweetListModel.m
//  DMR
//
//  Created by shklxmac111 on 15/12/23.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetListModel.h"
#import "ImagesBrowser.h"
#import "CommentModel.h"
#import "TweetCommentView.h"
#import "NSString+Size.h"
#import "TagView.h"
#import "PraiseUserModel.h"
#import "TimeTools.h"
#import "Global.h"

@implementation TweetList

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"data":@"data",
             @"lastTime":@"lastTime"
             };
}

+(NSValueTransformer *)dataJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TweetListModel class]];
}

@end

@implementation TweetListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"topicId":@"_id",
             @"isTop":@"isTop",
             @"uid":@"uid",
             @"ismaster":@"ismaster",
             @"nickname":@"nickname",
             @"headurl":@"headurl",
             @"level":@"level",
             @"location":@"location",
             @"createTime":@"createTime",
             @"updateTime":@"updateTime",
             @"title":@"title",
             @"content":@"content",
             @"type":@"type",
             @"commentCount":@"commentCount",
             @"praiseCount":@"praise",
             @"isPraise":@"isPraise",
             @"tags":@"tags",
             @"pics":@"pic",
             @"commentList":@"commentList",
             @"headIcons":@"headIcons"
             };
}




+ (NSValueTransformer*)locationJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *location) {
        if (location == nil)
            return @"";
        else
            return location;
    }];
}

+ (NSValueTransformer *)createTimeJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSNumber *createTime) {
        return [TimeTools getTimeStringByTimeInterval:createTime.longValue];
    }];
}

+ (NSValueTransformer *)titleJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *title) {
        if ([title isEqual:[NSNull null]]
            ||title == nil)
        {
            title = @"";
        }
        return title;
    }];
}


+(NSValueTransformer *)commentListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CommentModel class]];
}

+(NSValueTransformer *)headIconsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PraiseUserModel class]];
}


-(CGFloat)userInfoHeight
{
    _userInfoHeight = 35;
    return _userInfoHeight;
}

-(CGFloat)titleHeight
{
    if (_titleHeight == 0)
    {
        if (_title.length > 0)
        {
            _titleHeight = 25;
        }
        else
        {
            _titleHeight = 0;
        }
    }
    return _titleHeight;
}

-(CGFloat)contentHeight
{
    if (_contentHeight == 0)
    {
        _contentHeight = [_content SizeWithFont:[UIFont systemFontOfSize:14]
                                           Size:CGSizeMake(DeviceWidth - 62.5, 85)].height + 6;
    }
    return _contentHeight;
}

-(CGFloat)tagHeight
{
    if (_tagHeight == 0)
    {
        //        _tagHeight = [TagView HeightWithTags:_tags];
        if (_tags.count > 0)
        {
            _tagHeight = 20;
        }
        else
        {
            _tagHeight = 0;
        }
    }
    return _tagHeight;
}

-(CGFloat)imagesHeight
{
    if (_imagesHeight == 0)
    {
        _imagesHeight = [ImagesBrowser heightWithArray:_pics];
    }
    return _imagesHeight;
}

-(CGFloat)commentHeight
{
    if (_commentHeight == 0)
    {
        if (_type.integerValue == 3)
        {
            _commentHeight = 0;
        }
        else
        {
            _commentHeight = [TweetCommentView heightWithArray:_commentList];
        }
    }
    return _commentHeight;
}

-(CGFloat)userListHeight
{
    if (_userListHeight == 0)
    {
        if (_type.integerValue == 3)
        {
            _userListHeight = 35;
        }
        else
        {
            _userListHeight = 0;
        }
    }
    return _userListHeight;
}

-(CGFloat)totalHeight
{
    if (_totalHeight == 0)
    {
        _totalHeight =
        self.titleHeight
        + self.contentHeight
        + self.imagesHeight
        + self.commentHeight
        + self.userInfoHeight
        + self.userListHeight
        + self.tagHeight + 50;
    }
    return _totalHeight;
}

@end
