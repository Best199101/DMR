//
//  SHFacialMenu.m
//  xiaoqu
//
//  Created by shenhai on 15/4/1.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHFacialMenu.h"

@implementation SHFacialMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //...
    }
    return self;
}


//覆盖父类的方法,取消高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
    
}
//返回图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width - 26)/2, (contentRect.size.height - 26)/2, 26, 26);
}

//返回标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, 0, 0);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
