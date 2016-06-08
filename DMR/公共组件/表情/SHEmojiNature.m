//
//  SHEmojiNature.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmojiNature.h"

@implementation SHEmojiNature

+ (NSArray *)allNature;
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *emojiArray = @[@0x1f436, @0x1f43a, @0x1f431, @0x1f42d, @0x1f439,
                            @0x1f430, @0x1f438, @0x1f42f, @0x1f428, @0x1f43b,
                            @0x1f437, @0x1f43d, @0x1f42e, @0x1f417, @0x1f435,
                            @0x1f412, @0x1f434, @0x1f411, @0x1f418, @0x1f43c,
                            @0x1f427, @0x1f426, @0x1f424, @0x1f425, @0x1f423,
                            @0x1f414, @0x1f40d, @0x1f422, @0x1f41b, @0x1f41d,
                            @0x1f41c, @0x1f41e, @0x1f40c, @0x1f419, @0x1f41a,
                            @0x1f420, @0x1f41f, @0x1f42c, @0x1f433, @0x1f40b,
                            @0x1f404, @0x1f40f
                            ];
    
    
    
    for (NSNumber *num in emojiArray) {
        [array addObject:[SHEmoji emojiWithCode:[num intValue]]];
    }
    return array;
}


EMOJI_METHOD(emoji_1f436,1f436);
EMOJI_METHOD(emoji_1f43a,1f43a);
EMOJI_METHOD(emoji_1f431,1f431);
EMOJI_METHOD(emoji_1f42d,1f42d);
EMOJI_METHOD(emoji_1f439,1f439);
EMOJI_METHOD(emoji_1f430,1f430);
EMOJI_METHOD(emoji_1f438,1f438);
EMOJI_METHOD(emoji_1f42f,1f42f);
EMOJI_METHOD(emoji_1f428,1f428);
EMOJI_METHOD(emoji_1f43b,1f43b);
EMOJI_METHOD(emoji_1f437,1f437);
EMOJI_METHOD(emoji_1f43d,1f43d);
EMOJI_METHOD(emoji_1f42e,1f42e);
EMOJI_METHOD(emoji_1f417,1f417);
EMOJI_METHOD(emoji_1f435,1f435);
EMOJI_METHOD(emoji_1f412,1f412);
EMOJI_METHOD(emoji_1f434,1f434);
EMOJI_METHOD(emoji_1f411,1f411);
EMOJI_METHOD(emoji_1f418,1f418);
EMOJI_METHOD(emoji_1f43c,1f43c);
EMOJI_METHOD(emoji_1f427,1f427);
EMOJI_METHOD(emoji_1f426,1f426);
EMOJI_METHOD(emoji_1f424,1f424);
EMOJI_METHOD(emoji_1f425,1f425);
EMOJI_METHOD(emoji_1f423,1f423);
EMOJI_METHOD(emoji_1f414,1f414);
EMOJI_METHOD(emoji_1f40d,1f40d);
EMOJI_METHOD(emoji_1f422,1f422);
EMOJI_METHOD(emoji_1f41b,1f41b);
EMOJI_METHOD(emoji_1f41d,1f41d);
EMOJI_METHOD(emoji_1f41c,1f41c);
EMOJI_METHOD(emoji_1f41e,1f41e);
EMOJI_METHOD(emoji_1f40c,1f40c);
EMOJI_METHOD(emoji_1f419,1f419);
EMOJI_METHOD(emoji_1f41a,1f41a);

EMOJI_METHOD(emoji_1f420,1f420);
EMOJI_METHOD(emoji_1f41f,1f41f);
EMOJI_METHOD(emoji_1f42c,1f42c);
EMOJI_METHOD(emoji_1f433,1f433);
EMOJI_METHOD(emoji_1f40b,1f40b);
EMOJI_METHOD(emoji_1f404,1f404);
EMOJI_METHOD(emoji_1f40f,1f40f);





@end
