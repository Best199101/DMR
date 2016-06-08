//
//  SHEmojiPlaces.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmojiPlaces.h"

@implementation SHEmojiPlaces

+ (NSArray *)allPlaces;
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *emojiArray = @[@0x1f3e0, @0x1f3e1, @0x1f3eb, @0x1f3e2, @0x1f3e3,
                            @0x1f3e5, @0x1f3e6, @0x1f3ea, @0x1f3e9, @0x1f3e8,
                            @0x1f492, @0x1f3ec, @0x1f3e4, @0x1f307, @0x1f306,
                            @0x1f3ef, @0x1f3f0, @0x1f3ed, @0x1f5fc, @0x1f5fe,
                            @0x1f5fb, @0x1f304, @0x1f305, @0x1f303, @0x1f5fd,
                            @0x1f309, @0x1f3a0, @0x1f3a1, @0x1f3a2, @0x1f6a2,
                            @0x1f6a4, @0x1f6a3, @0x1f680, @0x1f4ba, @0x1f681,
                            @0x1f682
                            ];
    
    for (NSNumber *num in emojiArray) {
        [array addObject:[SHEmoji emojiWithCode:[num intValue]]];
    }
    return array;
}


EMOJI_METHOD(emoji_1f3e0,1f3e0);
EMOJI_METHOD(emoji_1f3e1,1f3e1);
EMOJI_METHOD(emoji_1f3eb,1f3eb);
EMOJI_METHOD(emoji_1f3e2,1f3e2);
EMOJI_METHOD(emoji_1f3e3,1f3e3);
EMOJI_METHOD(emoji_1f3e5,1f3e5);
EMOJI_METHOD(emoji_1f3e6,1f3e6);
EMOJI_METHOD(emoji_1f3ea,1f3ea);
EMOJI_METHOD(emoji_1f3e9,1f3e9);
EMOJI_METHOD(emoji_1f3e8,1f3e8);
EMOJI_METHOD(emoji_1f492,1f492);
EMOJI_METHOD(emoji_1f3ec,1f3ec);
EMOJI_METHOD(emoji_1f3e4,1f3e4);
EMOJI_METHOD(emoji_1f307,1f307);
EMOJI_METHOD(emoji_1f306,1f306);
EMOJI_METHOD(emoji_1f3ef,1f3ef);
EMOJI_METHOD(emoji_1f3f0,1f3f0);
EMOJI_METHOD(emoji_1f3ed,1f3ed);
EMOJI_METHOD(emoji_1f5fc,1f5fc);
EMOJI_METHOD(emoji_1f5fe,1f5fe);
EMOJI_METHOD(emoji_1f5fb,1f5fb);
EMOJI_METHOD(emoji_1f304,1f304);
EMOJI_METHOD(emoji_1f305,1f305);
EMOJI_METHOD(emoji_1f303,1f303);
EMOJI_METHOD(emoji_1f5fd,1f5fd);
EMOJI_METHOD(emoji_1f309,1f309);
EMOJI_METHOD(emoji_1f3a0,1f3a0);
EMOJI_METHOD(emoji_1f3a1,1f3a1);
EMOJI_METHOD(emoji_1f3a2,1f3a2);
EMOJI_METHOD(emoji_1f6a2,1f6a2);
EMOJI_METHOD(emoji_1f6a4,1f6a4);
EMOJI_METHOD(emoji_1f6a3,1f6a3);
EMOJI_METHOD(emoji_1f680,1f680);
EMOJI_METHOD(emoji_1f4ba,1f4ba);
EMOJI_METHOD(emoji_1f681,1f681);
EMOJI_METHOD(emoji_1f682,1f682);

@end
