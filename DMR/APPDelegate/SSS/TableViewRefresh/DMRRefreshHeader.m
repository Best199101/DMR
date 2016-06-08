//
//  DMRRefreshHeader.m
//  DMR
//
//  Created by 雨 on 16/6/2.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import "DMRRefreshHeader.h"

@interface DMRRefreshHeader ()
{
    BOOL isDraging;
    BOOL isDraged;
}

@property (nonatomic, strong) UIView *headerBgView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *refreshImgView;

@end
@implementation DMRRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.mj_h = 100;
    
    [self addSubview:self.headerBgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.refreshImgView];
    
    isDraged = NO;
    isDraging = NO;
    
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.headerBgView.frame = CGRectMake(0, 0, self.mj_w, self.mj_h);
    WeakObject(weakSelf);
    [weakSelf.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20);
        make.left.and.right.equalTo(weakSelf);
    }];
    [weakSelf.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textLabel.mas_bottom).with.offset(20);
        make.left.and.right.equalTo(weakSelf);
    }];
    [weakSelf.refreshImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.centerY.equalTo(weakSelf);
    }];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (isDraged) {

        CGPoint newPoint;
        NSValue *newPointValue = change[@"new"];
        [newPointValue getValue:&newPoint];
        CGFloat new = newPoint.y;
        
        CGPoint oldPoint;
        NSValue *oldPointValue = change[@"old"];
        [oldPointValue getValue:&oldPoint];
        CGFloat old = oldPoint.y;
        
    }

}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    isDraged = YES;
}

- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            [self.textLabel setText:@"下拉刷新"];
        }
            break;
        case MJRefreshStatePulling:
        {
            [self.textLabel setText:@"放开我~，我要刷新啦~"];
        }
            break;
        case MJRefreshStateRefreshing:
        {
            [self.textLabel setText:@"正在刷新数据中..."];
        }
            break;
        default:
            break;
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
}

#pragma mark - property

- (UIView *)headerBgView {
    if (_headerBgView == nil) {
        _headerBgView = [[UIView alloc]init];
        _headerBgView.backgroundColor = [UIColor cyanColor];
    }
    return _headerBgView;
}

- (UIImageView *)refreshImgView {
    if (_refreshImgView == nil) {
        _refreshImgView = [[UIImageView alloc]init];
        _refreshImgView.image = [UIImage imageNamed:@"load_common_type1_1"];
        _refreshImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _refreshImgView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.text = @"";
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor magentaColor];
    }
    return _textLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"上次更新时间：无";
        _timeLabel.textColor = [UIColor purpleColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

@end
