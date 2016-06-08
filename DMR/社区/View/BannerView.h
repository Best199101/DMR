//
//  BannerView.h
//  
//
//  Created by shklxjsbmac004 on 15/12/23.
//
//

#import "BaseView.h"

extern NSString *const bannerImageViewTappedZero;
extern NSString *const bannerImageViewTappedOne;
extern NSString *const bannerImageViewTappedTwo;

@interface BannerView : UIView

@property (strong,nonatomic) NSArray *contentArray;

//- (void)setContentWithModelArray:(NSArray*)array;

@end
