//
//  NSString+Emoji.h
//  happigo
//
//  Created by mac110 on 16/4/11.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

+ (BOOL) isContainEmoji: (NSString *) string;
- (BOOL) isContainEmoji;

@end
