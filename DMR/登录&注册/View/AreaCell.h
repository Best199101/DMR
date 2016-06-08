//
//  AreaCell.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaCell : UITableViewCell

@property (nonatomic, strong, readonly) NSString *areaName;
@property (nonatomic, strong, readonly) NSString *areaNumber;

- (void)configCellWithAreaName:(NSString *)areaName areaNumber:(NSString *)areaNumber;

@end
