//
//  TagListViewController.h
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectTag)(NSString* tagName);

@interface TagListViewController : UIViewController

@property (copy,nonatomic) SelectTag selectTagBlock;

@end
