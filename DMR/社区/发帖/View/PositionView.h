//
//  PositionView.h
//  测试commentView
//
//  Created by 李海龙 on 16/1/5.
//  Copyright © 2016年 李海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Location)(NSString *location);

@interface PositionView : UIView
//@property (nonatomic, copy) Location locationBlock;
@property (strong,nonatomic) NSString *location;

-(void)setContentWithNumber:(NSInteger)number;
@end
