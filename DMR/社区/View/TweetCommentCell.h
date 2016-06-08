//
//  TweetCommentCell.h
//  happigo
//
//  Created by fei on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCommentModel.h"


extern NSString *const CommentButtonTap;

@interface TweetCommentCell : UITableViewCell

- (void)setContentWithModel:(TweetCommentModel *)model;
+ (CGFloat )heightForModel:(TweetCommentModel *)model;


@end
