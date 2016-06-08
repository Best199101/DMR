//
//  TweetCommentView.h
//  happigo
//
//  Created by 李海龙 on 15/12/28.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCommentView : UIView

-(void)setContentWithArray:(NSArray *)array;

+(CGFloat)heightWithArray:(NSArray *)array;
@end
