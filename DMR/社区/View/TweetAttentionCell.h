//
//  TweetAttentionCell.h
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AttentionModel;

@interface TweetAttentionCell : UITableViewCell

-(void)setContentWithModel:(AttentionModel *)attentionModel;
-(CGFloat)getHeightWithModel:(AttentionModel *)attentionModel;
@end
