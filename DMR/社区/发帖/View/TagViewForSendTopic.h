//
//  tagViewForSendTopic.h
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTagViewHeight      45

@interface TagViewForSendTopic : UIView

@property (nonatomic, strong) NSMutableArray *tags;

-(void)addTags:(NSArray *)tags;

+(CGFloat)HeightWithTags:(NSArray *)tags;



@end
