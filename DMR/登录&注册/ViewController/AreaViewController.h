//
//  AreaViewController.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AreaNumber)(NSString *areaNumber);

@interface AreaViewController : UIViewController

@property (nonatomic, strong) AreaNumber areaNumber;


@end
