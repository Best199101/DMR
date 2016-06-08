//
//  SegmentView.m
//  DMR
//
//  Created by shklxjsbmac004 on 15/12/28.
//  Copyright © 2015年 wangzitao. All rights reserved.
//

#import "SegmentView.h"
#import "UIResponder+Router.h"
#import "ColorTools.h"
#import "Global.h"

#define k_segmentViewHeight 30
#define k_singleWidth 58
#define k_lineEdge 8

NSString *const titleLabelTap = @"titleLabelTap";

@interface SegmentView ()

@property (strong,nonatomic) NSMutableArray *labelArray;

@end

@implementation SegmentView

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - 初始化

- (instancetype)initSegmentViewWithTitleItems:(NSArray *)items {
    self = [super init];
    if (self) {
        _selectedIndex = 0;
        self.layer.borderColor = [ColorTools segmentViewColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = k_segmentViewHeight/2;
        self.clipsToBounds = YES;
        if (items.count) {
            NSMutableArray *labelArray = [[NSMutableArray alloc]initWithObjects:[NSMutableArray array],[NSMutableArray array], nil];
            for (NSInteger i = 0; i < items.count; i++) {
                //titleLabel数组
                UILabel *titleLabel = [UILabel new];
                titleLabel.tag = 1000 + i;
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.text = items[i];
                titleLabel.textColor = [ColorTools segmentViewColor];
                titleLabel.font = [UIFont systemFontOfSize:20.0];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTap:)]];
                titleLabel.userInteractionEnabled = YES;
                if (i == 0) {
                    titleLabel.backgroundColor = [ColorTools segmentViewColor];
                    titleLabel.textColor = [UIColor whiteColor];
                }
                [labelArray[0] addObject:titleLabel];
                //verticalLine数组
                UILabel *verticalLine = [UILabel new];
                verticalLine.backgroundColor = [ColorTools segmentViewColor];
                if (i == 1) {
                    verticalLine.hidden = YES;
                }
                [labelArray[1] addObject:verticalLine];
                //加到selfview上
                [self addSubview:titleLabel];
                [self addSubview:verticalLine];
            }
            _labelArray = labelArray;
            [self setLayoutsWithItems:items];
        }
    }
    return self;
}

- (void)setLayoutsWithItems:(NSArray*)items {
    WeakObject(weakSelf);
    for (NSInteger i = 0; i < items.count; i++) {
        [((UILabel*)_labelArray[0][i]) mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
            make.left.equalTo(weakSelf.mas_left).with.offset(i*k_singleWidth);
            make.width.mas_equalTo(@(k_singleWidth));
        }];
        [((UILabel*)_labelArray[1][i]) mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(k_lineEdge);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-k_lineEdge);
            make.left.equalTo(weakSelf.mas_left).with.offset(i*k_singleWidth - 0.5);
            make.width.mas_equalTo(@1);
        }];
        [weakSelf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(items.count*k_singleWidth));
            make.height.mas_equalTo(@(k_segmentViewHeight));
        }];
    }
}

#pragma mark - 点击事件

- (void)titleLabelTap:(UITapGestureRecognizer*)tap {
    [self changeOfAttributesWithIndex:tap.view.tag - 1000];
    _selectedIndex = tap.view.tag - 1000;
    [self routerEventWithName:titleLabelTap userInfo:@{@"tap":@(_selectedIndex)}];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        [self changeOfAttributesWithIndex:selectedIndex];
        _selectedIndex = selectedIndex;
    }
}

#pragma mark - segmentView视图属性的变化

- (void)changeOfAttributesWithIndex:(NSInteger)index {
    for (NSInteger i = 0; i < ((NSMutableArray*)_labelArray[0]).count; i++) {
        UILabel *label = (UILabel*)_labelArray[0][i];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [ColorTools segmentViewColor];
        if (i == index) {
            label.backgroundColor = [ColorTools segmentViewColor];
            label.textColor = [UIColor whiteColor];
        }
    }
    for (NSInteger j = 0; j < ((NSMutableArray*)_labelArray[1]).count; j++) {
        ((UILabel*)_labelArray[1][j]).hidden = NO;
        if (j == ((NSMutableArray*)_labelArray[1]).count - 1) {
            ((UILabel*)_labelArray[1][index]).hidden = YES;
            if (index < ((NSMutableArray*)_labelArray[1]).count - 1) {
                ((UILabel*)_labelArray[1][index + 1]).hidden = YES;
            }
        }
    }
}

@end
