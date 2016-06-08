//
//  ActivityCell.h
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivitiesModel;


extern NSString *const ActivitybgTap;

@interface ActivityCell : UITableViewCell

@property(nonatomic, strong) NSIndexPath *index;

-(void)setContentWithModel:(ActivitiesModel *)model;

@end
