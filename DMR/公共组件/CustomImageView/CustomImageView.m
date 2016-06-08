//
//  CustomImageView.m
//  xiaoqu
//
//  Created by wendy on 15/6/6.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "CustomImageView.h"
#import "ColorTools.h"
#import "Global.h"
@implementation CustomImageView

-(id)initWithFrame:(CGRect)frame AndTag:(NSInteger)tag
{
    if (self = [super initWithFrame:frame])
    {
        WeakObject(weakSelf);
        self.clipsToBounds = NO;
        self.tag = tag;
        _imageview = [UIImageView new];
        _imageview.userInteractionEnabled = YES;
        _imageview.clipsToBounds = NO;
        [self addSubview:_imageview];
        [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self
                          action:@selector(deleteSelf)
                forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.tag = tag;
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@20);
        }];
        [self addSubview:self.progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(5);
            make.right.equalTo(weakSelf.mas_right).with.offset(-5);
            make.height.equalTo(@2);
            make.centerY.equalTo(weakSelf);
        }];
    }
    return self;
}

-(void)deleteSelf
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DeleteImage"
                                                       object:[NSNumber numberWithInteger:self.tag]];
    
}

-(UIProgressView *)progressView
{
    if (_progressView == nil)
    {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.progressTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

@end
