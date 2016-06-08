//
//  SHFacialView.h
//  xiaoqu
//
//  Created by shenhai on 15/3/3.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHEmoji.h"
#import "SHEmojiPeople.h"
#import "SHEmojiNature.h"
#import "SHEmojiObjects.h"
#import "SHEmojiPlaces.h"
#import "SHEmojiSymbols.h"
#import "SHFacialMenu.h"


static NSString* const SHEmojiDelete  = @"SHEmojiDelete";

@protocol SHFacialViewDelegate

-(void)selectedFacialView:(NSString*)str;

@end


@interface SHFacialView : UIControl

@property(weak, nonatomic)id<SHFacialViewDelegate>delegate;

-(void)loadFacialView:(int)type;
-(void)loadFacialView:(int)type size:(CGSize)size;

@end
