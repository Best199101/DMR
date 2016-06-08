//
//  ColorTools.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "ColorTools.h"
#import "UIColor+HEX.h"

@implementation ColorTools

+(UIColor *)separatorLineColor
{
    return [UIColor colorWithRed:225 / 255.0
                           green:225 / 255.0
                            blue:225 / 255.0
                           alpha:1.0];
}

+(UIColor *)themePinkColor
{
    return [UIColor colorWithRed:255 / 255.0
                           green:117 / 255.0
                            blue:159 / 255.0
                           alpha:1.0];
}

+(UIColor *)textColor
{
    return [UIColor colorWithRed:51.0 / 255.0
                           green:51.0 / 255.0
                            blue:51 / 255.0
                           alpha:1.0];
}

+(UIColor *)lightTextColor
{
    return [UIColor colorWithRed:102 / 255.0
                           green:102 / 255.0
                            blue:102 / 255.0
                           alpha:1.0];
}

+(UIColor *)goodsNameTextColor
{
    return [UIColor colorWithRed:51 / 255.0
                           green:51 / 255.0
                            blue:51 / 255.0
                           alpha:1.0];
}

+(UIColor *)officialPriceTextColor
{
    return [UIColor colorWithRed:153 / 255.0
                           green:153 / 255.0
                            blue:153 / 255.0
                           alpha:1.0];
}

+(UIColor *)viewDetailTextColor
{
    return [UIColor colorWithRed:202 / 255.0
                           green:130 / 255.0
                            blue:99  / 255.0
                           alpha:1.0];
}

+(UIColor *)segmentViewColor
{
    return [UIColor colorWithRed:255 / 255.0
                           green:110 / 255.0
                            blue:155 / 255.0
                           alpha:1.0];
}

+(UIColor *)titleColor
{
    return [UIColor colorWithRed:54 / 255.0
                           green:54 / 255.0
                            blue:54 / 255.0
                           alpha:1.0];
}

+(UIColor *)nickNameColor
{
    return [UIColor colorWithHex:0x363636];
}

+(UIColor *)timeColor
{
    return [UIColor colorWithHex:0x666666];
}

+(UIColor *)tableViewBackGroundColor
{
    return [UIColor colorWithRed:237 / 255.0
                           green:237 / 255.0
                            blue:237 / 255.0
                           alpha:1.0];
}

+(UIColor *)tweetOldPriceColor
{
    return [UIColor colorWithRed:153 / 255.0
                           green:153 / 255.0
                            blue:153 / 255.0
                           alpha:1.0];
}

+(UIColor *)borderLineColor
{
    return [UIColor colorWithHex:0xE1E1E1];
}

+(UIColor *)tweetNowPriceColor
{
    return [UIColor colorWithRed:255 / 255.0
                           green:110 / 255.0
                            blue:155 / 255.0
                           alpha:1.0];
}

+(UIColor *)tweetShopDetailColor
{
    return [UIColor colorWithRed:36 / 255.0
                           green:36 / 255.0
                            blue:36 / 255.0
                           alpha:1.0];
}

+(UIColor *)lineColor
{
    return [UIColor colorWithRed:176 / 255.0
                           green:176 / 255.0
                            blue:176 / 255.0
                           alpha:1.0];
}

+ (UIColor *)lineForPersonColor
{
    return [UIColor colorWithHex:0xd1d1d1];
}

+ (UIColor *)goodsDespColor{
    return [UIColor colorWithHex:0x999999];
}

+ (UIColor *)goodsTitleColor{
    return [UIColor colorWithHex:0x363636];
}
+ (UIColor *)goodsBackgroundColor{
    return [UIColor colorWithHex:0xededed];
}

+ (UIColor *)goodsPayBTNColor{
    return [UIColor colorWithHex:0xffffff];
}
+ (UIColor *)goodsPayBTNBackgroundColor{
    return [UIColor colorWithHex:0xff6e9b];
}
+ (UIColor *)goodsBorderColor{
    return [UIColor colorWithHex:0xe1e1e1];
}

+(UIColor *)lineForAlertColor
{
    return [UIColor colorWithHex:0xb0b0b0];
}

+(UIColor *)backgroundWhiteColor
{
    return [UIColor colorWithRed:237 / 255.0
                           green:237 / 255.0
                            blue:237 / 255.0
                           alpha:1.0];
}

+ (UIColor *)backgroundForSexColor
{
    return [UIColor colorWithHex:0xededed];
}

+ (UIColor *)backgroundForWomanColor
{
    return [UIColor colorWithHex:0xff6e9b];
}

+ (UIColor *)backgroundForManColor
{
    return [UIColor colorWithHex:0x87e2d4];
}

+ (UIColor *)aboutUSColor
{
    return [UIColor colorWithHex:0Xff6e9b];
}

+ (UIColor *)emptyAlertColor
{
    return [UIColor colorWithRed:102 / 255.0
                           green:102 / 255.0
                            blue:102 / 255.0
                           alpha:1.0];
}

+ (UIColor *)emptyBgViewColor
{
    return [UIColor colorWithHex:0xffffff];
}

+(UIColor *)commentBackgroundColor
{
    return [UIColor colorWithRed:246 / 255.0
                           green:246 / 255.0
                            blue:246 / 255.0
                           alpha:1.0];
}

+(UIColor *)phoneColor
{
    return [UIColor colorWithRed:54 / 255.0
                           green:54 / 255.0
                            blue:54 / 255.0
                           alpha:1.0];
}

+(UIColor *)lightBorderColor
{
    return [UIColor colorWithRed:153 / 255.0
                           green:153 / 255.0
                            blue:153 / 255.0
                           alpha:1.0];
}

+(UIColor *)areaCodeColor
{
    return [UIColor colorWithRed:255 / 255.0
                           green:255 / 255.0
                            blue:255 / 255.0
                           alpha:1.0];
}

+(UIColor *)areaColor
{
    return [UIColor colorWithRed:51 / 255.0
                           green:51 / 255.0
                            blue:51 / 255.0
                           alpha:1.0];
}

+ (UIColor *)commentBgColor
{
    return [UIColor colorWithHex:0xf9f9f9];
}

+(UIColor *)exitLoginColor
{
    return [UIColor colorWithHex:0xff6e9b];
}

#pragma mark - 随机颜色

+(UIColor *)randomColorA
{
    return [UIColor colorWithHex:0xf0cac8];
}

+(UIColor *)randomColorB
{
    return [UIColor colorWithHex:0xdfd3b9];
}

+(UIColor *)randomColorC
{
    return [UIColor colorWithHex:0xb9c5df];
}

+(UIColor *)randomColorD
{
    return [UIColor colorWithHex:0x817673];
}

+(UIColor *)randomColorE
{
    return [UIColor colorWithHex:0x94a9d0];
}

+(UIColor *)randomColorF
{
    return [UIColor colorWithHex:0xaba596];
}

+(UIColor *)randomColorG
{
    return [UIColor colorWithHex:0xc9d4d3];
}

+(UIColor *)randomColorH
{
    return [UIColor colorWithHex:0xf7e2ef];
}

+(UIColor *)randomColorI
{
    return [UIColor colorWithHex:0xd2c9d4];
}

+(UIColor *)randomColorJ
{
    return [UIColor colorWithHex:0xaba596];
}

+(UIColor *)collectedColor{
    return [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.0];
}
+(UIColor *)translucentColor{
    return [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.3];
}

+(UIColor *)UserEnterTipColor{
//    颜色数组
        UIColor *one = RGB(80, 138, 225, 0.8);
        UIColor *two = RGB(93, 201, 103, 0.8);
        UIColor *three = RGB(108, 118, 109, 0.8);
        UIColor *four = RGB(166, 123, 184, 0.8);
        UIColor *five = RGB(205, 187, 89, 0.8);
        UIColor *six = RGB(238, 107, 43, 0.8);
    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:one, two, three, four, five, six, nil];
    return colorArray[arc4random()%6];
}



@end
