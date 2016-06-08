//
//  SHEmojiPeople.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmojiPeople.h"

@implementation SHEmojiPeople

+ (NSArray *)allPeople;
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *emojiArray = @[@0x1f604, @0x1f603, @0x1f600, @0x1f60a, @0x1f609,
                            @0x1f60d, @0x1f618, @0x1f61a, @0x1f617, @0x1f619,
                            @0x1f61c, @0x1f61d, @0x1f61b, @0x1f633, @0x1f601,
                            @0x1f614, @0x1f60c, @0x1f612, @0x1f61e, @0x1f623,
                            @0x1f622, @0x1f602, @0x1f62d, @0x1f62a, @0x1f625,
                            @0x1f630, @0x1f605, @0x1f613, @0x1f629, @0x1f62b,
                            @0x1f628, @0x1f631, @0x1f620, @0x1f621, @0x1f624,
                            @0x1f616, @0x1f606, @0x1f60b, @0x1f637, @0x1f60e,
                            @0x1f634, @0x1f635, @0x1f632, @0x1f61f, @0x1f626,
                            @0x1f627, @0x1f62e, @0x1f62c, @0x1f610, @0x1f615,
                            @0x1f62f, @0x1f636, @0x1f60f, @0x1f611,
                            ];
    
    
    
    for (NSNumber *num in emojiArray) {
        [array addObject:[SHEmoji emojiWithCode:[num intValue]]];
    }
    return array;
}


// People
EMOJI_METHOD(emoji_1f604,1f604);
EMOJI_METHOD(emoji_1f603,1f603);
EMOJI_METHOD(emoji_1f600,1f600);
EMOJI_METHOD(emoji_1f60a,1f60a);
EMOJI_METHOD(emoji_1f609,1f609);
EMOJI_METHOD(emoji_1f60d,1f60d);
EMOJI_METHOD(emoji_1f618,1f618);
EMOJI_METHOD(emoji_1f61a,1f61a);
EMOJI_METHOD(emoji_1f617,1f617);
EMOJI_METHOD(emoji_1f619,1f619);
EMOJI_METHOD(emoji_1f61c,1f61c);
EMOJI_METHOD(emoji_1f61d,1f61d);
EMOJI_METHOD(emoji_1f61b,1f61b);
EMOJI_METHOD(emoji_1f633,1f633);
EMOJI_METHOD(emoji_1f601,1f601);
EMOJI_METHOD(emoji_1f614,1f614);
EMOJI_METHOD(emoji_1f60c,1f60c);
EMOJI_METHOD(emoji_1f612,1f612);
EMOJI_METHOD(emoji_1f61e,1f61e);
EMOJI_METHOD(emoji_1f623,1f623);
EMOJI_METHOD(emoji_1f622,1f622);
EMOJI_METHOD(emoji_1f602,1f602);
EMOJI_METHOD(emoji_1f62d,1f62d);
EMOJI_METHOD(emoji_1f62a,1f62a);
EMOJI_METHOD(emoji_1f625,1f625);
EMOJI_METHOD(emoji_1f630,1f630);
EMOJI_METHOD(emoji_1f605,1f605);
EMOJI_METHOD(emoji_1f613,1f613);
EMOJI_METHOD(emoji_1f629,1f629);
EMOJI_METHOD(emoji_1f62b,1f62b);
EMOJI_METHOD(emoji_1f628,1f628);
EMOJI_METHOD(emoji_1f631,1f631);
EMOJI_METHOD(emoji_1f620,1f620);
EMOJI_METHOD(emoji_1f621,1f621);
EMOJI_METHOD(emoji_1f624,1f624);
EMOJI_METHOD(emoji_1f616,1f616);
EMOJI_METHOD(emoji_1f606,1f606);
EMOJI_METHOD(emoji_1f60b,1f60b);
EMOJI_METHOD(emoji_1f637,1f637);
EMOJI_METHOD(emoji_1f60e,1f60e);
EMOJI_METHOD(emoji_1f634,1f634);
EMOJI_METHOD(emoji_1f635,1f635);
EMOJI_METHOD(emoji_1f632,1f632);
EMOJI_METHOD(emoji_1f61f,1f61f);
EMOJI_METHOD(emoji_1f626,1f626);
EMOJI_METHOD(emoji_1f627,1f627);
EMOJI_METHOD(emoji_1f62e,1f62e);
EMOJI_METHOD(emoji_1f62c,1f62c);
EMOJI_METHOD(emoji_1f610,1f610);
EMOJI_METHOD(emoji_1f615,1f615);
EMOJI_METHOD(emoji_1f62f,1f62f);
EMOJI_METHOD(emoji_1f636,1f636);
EMOJI_METHOD(emoji_1f60f,1f60f);
EMOJI_METHOD(emoji_1f611,1f611);

@end
