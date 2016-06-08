//
//  Emoji.m
//  xiaoqu
//
//  Created by shenhai on 15/3/3.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmoji.h"
#import "SHEmojiPeople.h"
#import "SHEmojiNature.h"
#import "SHEmojiObjects.h"
#import "SHEmojiPlaces.h"
#import "SHEmojiSymbols.h"

@implementation SHEmoji
+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}
+ (NSArray *)allEmoji {
    NSMutableArray *array = [NSMutableArray new];

    [array addObjectsFromArray:[SHEmojiPeople allPeople]];
    [array addObjectsFromArray:[SHEmojiNature allNature]];
    [array addObjectsFromArray:[SHEmojiObjects allObjects]];
    [array addObjectsFromArray:[SHEmojiPlaces allPlaces]];
    [array addObjectsFromArray:[SHEmojiSymbols allSymbols]];
    return array;
}
@end
