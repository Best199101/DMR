//
//  FacialView.m
//  xiaoqu
//
//  Created by shenhai on 15/3/3.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "SHFacialView.h"
#import "Global.h"

#define menuH 40
#define pageH 20

@interface SHFacialView () <UIScrollViewDelegate>
{
    NSArray *allFaces;
    NSArray *faces;
    NSArray *imgNameArray;
    NSArray *img2NameArray;
    
    SHFacialMenu *_menu1;
    SHFacialMenu *_menu2;
    SHFacialMenu *_menu3;
    SHFacialMenu *_menu4;
    SHFacialMenu *_menu5;
    SHFacialMenu *_delete;
    NSArray *_btnArray;
}

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControl;
@end

@implementation SHFacialView

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        imgNameArray = @[@"SHItem_00",@"SHItem_10",@"SHItem_20",@"SHItem_30",@"SHItem_40",@"SHItem_50"];
        img2NameArray = @[@"SHItem_01",@"SHItem_11",@"SHItem_21",@"SHItem_31",@"SHItem_41",@"SHItem_50"];
        allFaces = @[[SHEmojiPeople allPeople],[SHEmojiNature allNature],[SHEmojiObjects allObjects], [SHEmojiPlaces allPlaces],[SHEmojiSymbols allSymbols]];
    }
    return self;
}



-(void)loadFacialView:(int)type
{
    [self loadFacialView:type size:CGSizeMake(40, 40)];
}


-(void)loadFacialView:(int)type size:(CGSize)size
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(6, 0, self.frame.size.width, self.frame.size.height - menuH)];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, pageH)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
    }

    if (!_menu1) {
        CGFloat width = DeviceWidth/6;
        
        _menu1 = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 0, self.frame.size.height - menuH, width, menuH)];
        _menu2 = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 1, self.frame.size.height - menuH, width, menuH)];
        _menu3 = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 2, self.frame.size.height - menuH, width, menuH)];
        _menu4 = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 3, self.frame.size.height - menuH, width, menuH)];
        _menu5 = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 4, self.frame.size.height - menuH, width, menuH)];
        _delete = [[SHFacialMenu alloc]initWithFrame:CGRectMake(width * 5, self.frame.size.height - menuH, width, menuH)];
        _btnArray = @[_menu1, _menu2, _menu3, _menu4, _menu5, _delete];
        for (SHFacialMenu *btn in _btnArray) {
            if ([_btnArray indexOfObject:btn] == 0) {
                btn.backgroundColor = [UIColor whiteColor];
                [btn setImage:[UIImage imageNamed:imgNameArray[[_btnArray indexOfObject:btn]]]  forState:UIControlStateNormal];
            }else {
                btn.backgroundColor = [UIColor lightGrayColor];
                [btn setImage:[UIImage imageNamed:img2NameArray[[_btnArray indexOfObject:btn]]] forState:UIControlStateNormal];
            }
            btn.tag = [_btnArray indexOfObject:btn] + 2000;
            

            [btn addTarget:self action:@selector(clipMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    
    
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    faces = allFaces[type];
    
    int X = 4;
    int Y = DeviceWidth/size.width;
    int Z = (faces.count - 1)/(X*Y)+1;
    
    _scrollView.contentSize = CGSizeMake(DeviceWidth * Z, self.frame.size.height - menuH);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _pageControl.numberOfPages = Z;
    _pageControl.currentPage = 0;
    
    int x,y,z;
    
    for (int i = 0; i<faces.count; i++) {
        z = i/(X*Y);
        x = i%(X*Y)/Y;
        y = i%(X*Y)%Y;
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setFrame:CGRectMake(DeviceWidth*z + size.width*y, pageH - 7 + x*size.height, size.width, size.height)];
        btn.tag = i;
        [btn.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
        [btn setTitle:faces[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }

}

- (void)clipMenu:(SHFacialMenu *)btn
{
    if (btn != _delete) {
        
        for (SHFacialMenu *item in _btnArray) {
            item.backgroundColor = [UIColor lightGrayColor];
            [item setImage:[UIImage imageNamed:img2NameArray[[_btnArray indexOfObject:item]]] forState:UIControlStateNormal];
        }
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:imgNameArray[[_btnArray indexOfObject:btn]]] forState:UIControlStateNormal];
        
        [self loadFacialView:((int)btn.tag - 2000)];
        
    }else {
        [self.delegate selectedFacialView:SHEmojiDelete];
    }
}

-(void)selected:(UIButton*)btn
{
    NSString *str = faces[btn.tag];
    NSLog(@"点击其他%@",str);
    [self.delegate selectedFacialView:str];
}


#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if (scrollView == _scrollView) {
        _pageControl.currentPage = (int)scrollView.contentOffset.x / (int)DeviceWidth;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

@end
