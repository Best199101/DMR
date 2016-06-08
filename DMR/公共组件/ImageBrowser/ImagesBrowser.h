//
//  ImagesBrowser.h
//  xiaoqu
//
//  Created by steven on 10/9/15.
//  Copyright (c) 2015 Neighbourhood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetListModel.h"
@interface ImagesBrowser : UIView

- (void)setContentWithArray:(NSArray*)array;

+ (CGFloat)heightWithArray:(NSArray*)array;
@end
