//
//  BorderView.m
//  happigo
//
//  Created by 雨 on 16/2/22.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BorderView.h"
#import "ColorTools.h"

@interface BorderView ()

@property (nonatomic, strong) UIView *borderView;

@end
@implementation BorderView

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

-  (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 初始化

- (void)initSubviews {
    [self addSubview:self.borderView];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 属性

- (UIView *)borderView {
    if (_borderView == nil) {
        _borderView = [[UIView alloc]init];
        _borderView.layer.borderColor = [ColorTools lightBorderColor].CGColor;
        _borderView.layer.borderWidth = 0.5;
        _borderView.layer.cornerRadius = 7.5;
        _borderView.clipsToBounds = YES;
        _borderView.backgroundColor = [UIColor whiteColor];
    }
    return _borderView;
}

@end
