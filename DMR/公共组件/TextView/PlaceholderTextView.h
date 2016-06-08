//
//  PlaceholderTextView.h
//  Test
//
//  Created by AeternChan on 7/15/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputType){
    keyboardType = 0,
    emojiType = 1
};


@interface PlaceholderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (assign,nonatomic) InputType inputType;


@end
