//
//  TagListCell.h
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagListModel.h"

@interface TagListCell : UITableViewCell

//- (void)setContentWithArray:(NSArray *)array atIndex:(NSInteger)index;
- (void)setContentWithModel:(TagListModel *)model;

@end
