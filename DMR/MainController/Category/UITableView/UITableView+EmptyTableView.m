//
//  UITableView+EmptyTableView.m
//  LX001
//
//  Created by 雨 on 16/2/22.
//  Copyright © 2016年 shklx. All rights reserved.
//

#import "UITableView+EmptyTableView.h"
#import "ColorTools.h"
#import <Masonry.h>

@implementation UITableView (EmptyTableView)

- (void)emptyTableViewWithImageName:(NSString *)name content:(NSString *)content {
    [self emptyTableViewWithImageName:name content:content distanceForCenterX:0 centerY:0];
}

- (void)emptyTableViewWithImageName:(NSString *)name content:(NSString *)content distanceForCenterX:(CGFloat)xDis centerY:(CGFloat)yDis {
    
//    WeakObject(weakSelf);
    __block EmptyTabelView *emptyView = [[EmptyTabelView alloc]init];
    emptyView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    emptyView.tag = 99;
    [self addSubview:emptyView];
//    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf);
//        make.size.equalTo(weakSelf);
//    }];
//    
//    [emptyView setDistanceForCenterX:xDis centerY:yDis];

    [emptyView configWithImageName:name content:content];
}

- (void)noEmptyTableView {
    
    WeakObject(weakSelf);
    
    UIView *view = (EmptyTabelView *)[weakSelf.superview viewWithTag:99];
    if (view) {
        [view removeFromSuperview];
    }

}

- (void)configTableViewWithDataArray:(NSArray *)array ImageName:(NSString *)name content:(NSString *)content {
    [self configTableViewWithDataArray:array ImageName:name content:content distanceForCenterX:0 centerY:0];
}

- (void)configTableViewWithDataArray:(NSArray *)array ImageName:(NSString *)name content:(NSString *)content distanceForCenterX:(CGFloat)xDis centerY:(CGFloat)yDis {
    if (!array.count) {
        [self emptyTableViewWithImageName:name content:content distanceForCenterX:xDis centerY:yDis];
    } else {
        [self noEmptyTableView];
    }
}

@end

@interface EmptyTabelView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentLabel;

@end
@implementation EmptyTabelView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [ColorTools emptyBgViewColor];
        [self initSubviews];
        [self setLayouts];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.bgView];
    [_bgView addSubview:self.imgView];
    [_bgView addSubview:self.contentLabel];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(_imgView.mas_top);
        make.bottom.equalTo(_contentLabel.mas_bottom);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(_bgView);
        //        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).with.offset(17);
        make.centerX.equalTo(_imgView.mas_centerX);
        //        make.left.equalTo(_imgView.mas_left).with.offset(-20);
        //        make.right.equalTo(_imgView.mas_right).with.offset(20);
        make.width.lessThanOrEqualTo(@200);
    }];
}

- (void)configWithImageName:(NSString *)name content:(NSString *)content {
    if (name.length) {
        _imgView.image = [UIImage imageNamed:name];
    } else{
        _imgView.hidden = YES;
        WeakObject(weakSelf);
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
            //            make.left.equalTo(weakSelf.mas_left).with.offset(30);
            //            make.right.equalTo(weakSelf.mas_right).with.offset(-30);
            make.width.lessThanOrEqualTo(@200);
        }];
    }
    if (content.length) {
        _contentLabel.text = content;
    }
}

- (void)setDistanceForCenterX:(CGFloat)xDis centerY:(CGFloat)yDis {
    //    WeakObject(weakSelf);
    //    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(xDis);
    //        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(yDis);
    //    }];
}

#pragma mark - 属性

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [ColorTools emptyBgViewColor];
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"pic_presonal_center_empty"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [ColorTools emptyAlertColor];
        _contentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
