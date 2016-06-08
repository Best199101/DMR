//
//  TweetGuessYouLikeCell.h
//  happigo
//
//  Created by fei on 15/12/25.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetGuessYouLikeModel.h"

@interface TweetGuessYouLikeCell : UITableViewCell

- (void)setContentWithModel:(TweetGuessYouLikeModel *)model;
+ (CGFloat)heightForModel:(TweetGuessYouLikeModel *)model;

@end
