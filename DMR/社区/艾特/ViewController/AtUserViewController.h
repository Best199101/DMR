//
//  AtUserViewController.h
//  happigo
//
//  Created by fei on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^At)(NSString* nickName,NSString* uid);

@interface AtUserViewController : UIViewController

@property (copy,nonatomic) At AtBlock;

@end
