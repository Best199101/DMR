//
//  SHEmojiObjects.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmojiObjects.h"

@implementation SHEmojiObjects

+ (NSArray *)allObjects;
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *emojiArray = @[@0x1f38d, @0x1f49d, @0x1f38e, @0x1f392, @0x1f393,
                            @0x1f38f, @0x1f386, @0x1f387, @0x1f390, @0x1f391,
                            @0x1f383, @0x1f47b, @0x1f385, @0x1f384, @0x1f381,
                            @0x1f38b, @0x1f389, @0x1f38a, @0x1f388, @0x1f38c,
                            @0x1f52e, @0x1f3a5, @0x1f4f7, @0x1f4f9, @0x1f4fc,
                            @0x1f4bf, @0x1f4c0, @0x1f4bd, @0x1f4be, @0x1f4bb,
                            @0x1f4f1, @0x1f4de, @0x1f4df, @0x1f4e0, @0x1f4e1,
                            @0x1f4fa, @0x1f4fb, @0x1f50a, @0x1f509, @0x1f508,
                            @0x1f507
                            ];
    
    
    
    for (NSNumber *num in emojiArray) {
        [array addObject:[SHEmoji emojiWithCode:[num intValue]]];
    }
    return array;
}



EMOJI_METHOD(emoji_1f38d,1f38d);
EMOJI_METHOD(emoji_1f49d,1f49d);
EMOJI_METHOD(emoji_1f38e,1f38e);
EMOJI_METHOD(emoji_1f392,1f392);
EMOJI_METHOD(emoji_1f393,1f393);
EMOJI_METHOD(emoji_1f38f,1f38f);
EMOJI_METHOD(emoji_1f386,1f386);
EMOJI_METHOD(emoji_1f387,1f387);
EMOJI_METHOD(emoji_1f390,1f390);
EMOJI_METHOD(emoji_1f391,1f391);
EMOJI_METHOD(emoji_1f383,1f383);
EMOJI_METHOD(emoji_1f47b,1f47b);
EMOJI_METHOD(emoji_1f385,1f385);
EMOJI_METHOD(emoji_1f384,1f384);
EMOJI_METHOD(emoji_1f381,1f381);
EMOJI_METHOD(emoji_1f38b,1f38b);
EMOJI_METHOD(emoji_1f389,1f389);
EMOJI_METHOD(emoji_1f38a,1f38a);
EMOJI_METHOD(emoji_1f388,1f388);
EMOJI_METHOD(emoji_1f38c,1f38c);
EMOJI_METHOD(emoji_1f52e,1f52e);
EMOJI_METHOD(emoji_1f3a5,1f3a5);
EMOJI_METHOD(emoji_1f4f7,1f4f7);
EMOJI_METHOD(emoji_1f4f9,1f4f9);
EMOJI_METHOD(emoji_1f4fc,1f4fc);
EMOJI_METHOD(emoji_1f4bf,1f4bf);
EMOJI_METHOD(emoji_1f4c0,1f4c0);
EMOJI_METHOD(emoji_1f4bd,1f4bd);
EMOJI_METHOD(emoji_1f4be,1f4be);
EMOJI_METHOD(emoji_1f4bb,1f4bb);
EMOJI_METHOD(emoji_1f4f1,1f4f1);
EMOJI_METHOD(emoji_1f4de,1f4de);
EMOJI_METHOD(emoji_1f4df,1f4df);
EMOJI_METHOD(emoji_1f4e0,1f4e0);
EMOJI_METHOD(emoji_1f4e1,1f4e1);
EMOJI_METHOD(emoji_1f4fa,1f4fa);
EMOJI_METHOD(emoji_1f4fb,1f4fb);
EMOJI_METHOD(emoji_1f50a,1f50a);
EMOJI_METHOD(emoji_1f509,1f509);
EMOJI_METHOD(emoji_1f508,1f508);
EMOJI_METHOD(emoji_1f507,1f507);



@end
