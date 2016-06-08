//
//  TweetListCell.h
//  happigo
//
//  Created by shklxmac111 on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const PraiseButtonTapped;
extern NSString *const CommentButtonTapped;
extern NSString *const AttentionButtonTapped;
extern NSString *const CancelAttentionButtonTapped;

@class TweetListModel;

@interface TweetListCell : UITableViewCell

@property (strong,nonatomic) TweetListModel *model;

-(void)setContentWithModel:(TweetListModel *)model;

@end
