//
//  ColorTools.h
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorTools : NSObject

/**
 *  列表分割线
 *
 *  @return
 */
+(UIColor *)separatorLineColor;

/**
 *  APP主色
 *
 *  @return
 */
+(UIColor *)themePinkColor;

/**
 *  APP 深黑字体
 *
 *  @return
 */
+(UIColor *)textColor;

/**
 *  APP 浅色字体
 *
 *  @return
 */
+(UIColor *)lightTextColor;

/**
 *  商品名称
 *
 *  @return
 */
+(UIColor *)goodsNameTextColor;

/**
 *  官方参考价
 *
 *  @return
 */
+(UIColor *)officialPriceTextColor;

/**
 *  帖子列表查看详情字体颜色
 *
 *  @return
 */
+(UIColor *)viewDetailTextColor;
/**
 *  社区首页精选、最新、关注
 *
 *  @return
 */
+(UIColor *)segmentViewColor;

/**
 *  用户昵称颜色
 *
 *  @return 
 */
+(UIColor *)nickNameColor;

/**
 *  时间颜色
 *
 *  @return 
 */
+(UIColor *)timeColor;

/**
 *  社区列表背景色
 */
+(UIColor *)tableViewBackGroundColor;

/**
 *  帖子详情商品市场价格字体颜色
 *
 *  @return
 */
+(UIColor *)tweetOldPriceColor;

/**
 *  边框颜色
 *
 *  @return
 */
+(UIColor *)borderLineColor;

/**
 *  帖子详情商品现在价格字体颜色
 *
 *  @return
 */
+(UIColor *)tweetNowPriceColor;

/**
 *  帖子详情商品详情字体颜色
 *
 *  @return
 */
+(UIColor *)tweetShopDetailColor;

/**
 *  帖子标题颜色
 *
 *  @return
 */
+(UIColor *)titleColor;

/**
 *  白色背景上的分割线颜色
 *
 *  @return
 */
+(UIColor *)lineColor;

/**
 *  个人资料的分割线颜色
 *
 *  @return
 */
+(UIColor *)lineForPersonColor;

/**
 *  清除缓存提示框分割线颜色
 *
 *  @return
 */
+(UIColor *)lineForAlertColor;

/**
 *  背景颜色--白色
 *
 *  @return
 */
+(UIColor *)backgroundWhiteColor;

/**
 *  个人资料->选择性别背景颜色
 *
 *  @return
 */
+(UIColor *)backgroundForSexColor;

/**
 *  个人资料->选择性别->woman背景颜色
 *
 *  @return
 */
+(UIColor *)backgroundForWomanColor;

/**
 *  个人资料->选择性别->man背景颜色
 *
 *  @return
 */
+(UIColor *)backgroundForManColor;

/**
 *  关于大美人->新版本更新字体颜色
 *
 *  @return
 */
+(UIColor *)aboutUSColor;

/**
 *  tableView为空界面字体颜色
 *
 *  @return
 */
+(UIColor *)emptyAlertColor;

/**
 *  tableView为空界面背景颜色
 *
 *  @return
 */
+(UIColor *)emptyBgViewColor;

/**
 *  评论输入框背景颜色
 *
 *  @return
 */
+(UIColor *)commentBackgroundColor;

/**
 *  区号/手机号字体颜色
 *
 *  @return
 */
+(UIColor *)phoneColor;

/**
 *  浅灰色边框
 *
 *  @return
 */
+(UIColor *)lightBorderColor;

/**
 *  验证码字体颜色
 *
 *  @return
 */
+(UIColor *)areaCodeColor;

/**
 *  地区字体颜色
 *
 *  @return
 */
+(UIColor *)areaColor;

/**
 *  个人中心->评论背景颜色
 *
 *  @return
 */
+(UIColor *)commentBgColor;

/**
 *  退出登录字体颜色
 *
 *  @return
 */
+(UIColor *)exitLoginColor;

/**
 *  随机颜色
 *
 *  @return 
 */

+(UIColor *)collectedColor;


+(UIColor *)randomColorA;
+(UIColor *)randomColorB;
+(UIColor *)randomColorC;
+(UIColor *)randomColorD;
+(UIColor *)randomColorF;
+(UIColor *)randomColorG;
+(UIColor *)randomColorH;
+(UIColor *)randomColorI;
+(UIColor *)randomColorJ;


// 进入房间提示颜色
+(UIColor *)UserEnterTipColor;

// 商品描述颜色
+ (UIColor *)goodsDespColor;
// 商品title颜色
+ (UIColor *)goodsTitleColor;
// 商品背景颜色
+ (UIColor *)goodsBackgroundColor;
// 支付button颜色
+ (UIColor *)goodsPayBTNColor;
+ (UIColor *)goodsPayBTNBackgroundColor;
// 半透明颜色
+(UIColor *)translucentColor;
// 边框颜色
+ (UIColor *)goodsBorderColor;

@end
