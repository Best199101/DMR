//
//  SHEmojiSymbols.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHEmojiSymbols.h"

@implementation SHEmojiSymbols

+ (NSArray *)allSymbols;
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *emojiArray = @[@0x1f51f, @0x1f522, @0x1f523, @0x1f520, @0x1f521,
                            @0x1f524, @0x1f504, @0x1f53c, @0x1f53d, @0x1f197,
                            @0x1f500, @0x1f501, @0x1f502, @0x1f195, @0x1f199,
                            @0x1f192, @0x1f193, @0x1f196, @0x1f4f6, @0x1f3a6,
                            @0x1f201, @0x1f22f, @0x1f233, @0x1f235, @0x1f234,
                            @0x1f232, @0x1f250, @0x1f239, @0x1f23a, @0x1f236,
                            @0x1f21a, @0x1f6bb, @0x1f6b9, @0x1f6ba, @0x1f6bc,
                            @0x1f6be, @0x1f6b0, @0x1f6ae
                            ];
    
    for (NSNumber *num in emojiArray) {
        [array addObject:[SHEmoji emojiWithCode:[num intValue]]];
    }
    return array;
}

EMOJI_METHOD(emoji_1f51f,1f51f);
EMOJI_METHOD(emoji_1f522,1f522);
EMOJI_METHOD(emoji_1f523,1f523);
EMOJI_METHOD(emoji_1f520,1f520);
EMOJI_METHOD(emoji_1f521,1f521);
EMOJI_METHOD(emoji_1f524,1f524);
EMOJI_METHOD(emoji_1f504,1f504);
EMOJI_METHOD(emoji_1f53c,1f53c);
EMOJI_METHOD(emoji_1f53d,1f53d);
EMOJI_METHOD(emoji_1f197,1f197);
EMOJI_METHOD(emoji_1f500,1f500);
EMOJI_METHOD(emoji_1f501,1f501);
EMOJI_METHOD(emoji_1f502,1f502);
EMOJI_METHOD(emoji_1f195,1f195);
EMOJI_METHOD(emoji_1f199,1f199);
EMOJI_METHOD(emoji_1f192,1f192);
EMOJI_METHOD(emoji_1f193,1f193);
EMOJI_METHOD(emoji_1f196,1f196);
EMOJI_METHOD(emoji_1f4f6,1f4f6);
EMOJI_METHOD(emoji_1f3a6,1f3a6);
EMOJI_METHOD(emoji_1f201,1f201);
EMOJI_METHOD(emoji_1f22f,1f22f);
EMOJI_METHOD(emoji_1f233,1f233);
EMOJI_METHOD(emoji_1f235,1f235);
EMOJI_METHOD(emoji_1f234,1f234);
EMOJI_METHOD(emoji_1f232,1f232);
EMOJI_METHOD(emoji_1f250,1f250);
EMOJI_METHOD(emoji_1f239,1f239);
EMOJI_METHOD(emoji_1f23a,1f23a);
EMOJI_METHOD(emoji_1f236,1f236);
EMOJI_METHOD(emoji_1f21a,1f21a);
EMOJI_METHOD(emoji_1f6bb,1f6bb);
EMOJI_METHOD(emoji_1f6b9,1f6b9);
EMOJI_METHOD(emoji_1f6ba,1f6ba);
EMOJI_METHOD(emoji_1f6bc,1f6bc);
EMOJI_METHOD(emoji_1f6be,1f6be);
EMOJI_METHOD(emoji_1f6b0,1f6b0);
EMOJI_METHOD(emoji_1f6ae,1f6ae);

@end
