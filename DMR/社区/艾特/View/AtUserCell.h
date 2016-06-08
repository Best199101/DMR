//
//  AtUserCell.h
//  happigo
//
//  Created by fei on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AtUserModel.h"

@interface AtUserCell : UITableViewCell

-(void)setcontentWithModel1:(AtUserModel *)model;
-(void)setcontentWithModel2:(AtUserModel *)model;
+(CGFloat)heightForCell:(AtUserModel *)model;



@end
