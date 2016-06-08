//
//  TagView.h
//  happigo
//
//  Created by 李海龙 on 15/12/25.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

-(void)setContentWithTags:(NSArray *)tags;

+(CGFloat)HeightWithTags:(NSArray *)tags;

@end
