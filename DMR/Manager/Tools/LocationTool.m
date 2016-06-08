//
//  GetLocationTool.m
//  happigo
//
//  Created by mac110 on 16/4/12.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LocationTool.h"
#import "INTULocationManager.h"

@interface LocationTool ()

@property (nonatomic, copy) void (^callBack)(NSString *cityName);

@end
@implementation LocationTool

+ (instancetype)sharedInstance
{
    static LocationTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LocationTool new];
    });
    return _instance;
}

- (void)getCityName:(void (^)(NSString *))callBack {
    self.callBack = callBack;

    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:20.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (error || placemarks.count == 0)
             {
//                 [TNToast showWithText:@"定位失败"];
                 if (callBack) {
                     callBack(nil);
                 }
                 return;
             }
             else
             {
//                 [TNToast showWithText:@"定位成功"];
                 CLPlacemark *myPlacemark = placemarks[0];
                 if (callBack) {
                     callBack(myPlacemark.administrativeArea);
                 }
             }
         }];
    }];
}
@end
