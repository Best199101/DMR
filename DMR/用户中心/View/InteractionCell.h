//
//  InteractionCell.h
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonInfoModel;

extern NSString *const InteractionlogoTap;

@interface InteractionCell : UITableViewCell

@property(nonatomic, strong) NSIndexPath *indesPath;
-(void)setContentWithModel:(NSString *)title img:(NSString *)img;

-(void)setNotifyNumberHidden:(BOOL)hidden number:(NSString *)str;

@end
