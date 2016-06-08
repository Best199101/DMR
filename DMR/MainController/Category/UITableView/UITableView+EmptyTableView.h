//
//  UITableView+EmptyTableView.h
//  LX001
//
//  Created by 雨 on 16/2/22.
//  Copyright © 2016年 shklx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyTableView)

- (void)emptyTableViewWithImageName:(NSString *)name content:(NSString *)content;
- (void)emptyTableViewWithImageName:(NSString *)name
                            content:(NSString *)content
                 distanceForCenterX:(CGFloat)xDis
                            centerY:(CGFloat)yDis;

- (void)noEmptyTableView;





- (void)configTableViewWithDataArray:(NSArray *)array ImageName:(NSString *)name content:(NSString *)content;
- (void)configTableViewWithDataArray:(NSArray *)array
                           ImageName:(NSString *)name
                             content:(NSString *)content
                  distanceForCenterX:(CGFloat)xDis
                             centerY:(CGFloat)yDis;

@end

@interface EmptyTabelView : UIView

- (void)configWithImageName:(NSString *)name content:(NSString *)content;
- (void)setDistanceForCenterX:(CGFloat)xDis centerY:(CGFloat)yDis;


@end
