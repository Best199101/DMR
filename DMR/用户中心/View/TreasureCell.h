//
//  TreasureCell.h
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const TreasurelogoTap;

@interface TreasureCell : UITableViewCell
@property(nonatomic, strong) NSIndexPath *indesPath;
// 指示
@property(nonatomic, strong) UIImageView *arrowView;

-(void)setContentWithModel:(NSString *)title img:(NSString *)img;
-(void)setNotifyNumberHidden:(BOOL)hidden number:(NSString *)str;

@end
