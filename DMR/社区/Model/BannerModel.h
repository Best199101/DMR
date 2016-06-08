//
//  BannerModel.h
//  
//
//  Created by shklxjsbmac004 on 15/12/23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@interface BannerModel : MTLModel<MTLJSONSerializing>
//banner详细信息
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *pic;
@property (strong,nonatomic) NSNumber *bannerTargetType;
@property (strong,nonatomic) NSString *bannerTarget;
@property (strong,nonatomic) NSString *bannerChannel;
@property (strong,nonatomic) NSString *bannerChannelDesc;
@property (strong,nonatomic) NSString *bannerNumber;
@property (strong,nonatomic) NSString *shareContent;
@property (strong,nonatomic) NSString *sharePic;
@property (strong,nonatomic) NSString *shareUrl;
@property (strong,nonatomic) NSString *shareTitle;

@end
