//
//  BannerView.m
//  
//
//  Created by shklxjsbmac004 on 15/12/23.
//
//

#import "BannerView.h"
#import "Global.h"
#import "BannerModel.h"
#import "UIResponder+Router.h"

#define selfW self.frame.size.width
#define selfH self.frame.size.height

NSString *const bannerImageViewTappedZero = @"bannerImageViewTapped0";
NSString *const bannerImageViewTappedOne = @"bannerImageViewTapped1";
NSString *const bannerImageViewTappedTwo = @"bannerImageViewTapped2";

@interface BannerView()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *bannerScrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) BannerModel *bannerModel;
@property (strong,nonatomic) NSMutableArray *bannerModelArray;

@end

@implementation BannerView

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.bannerScrollView];
    [self addSubview:self.pageControl];
}


#pragma mark - 公有

//- (void)setContentArray:(NSArray *)contentArray {
//    
//        if (contentArray.count) {
//            _bannerScrollView.contentSize = CGSizeMake(selfW*contentArray.count, selfH);
//            if (contentArray.count > 1) {
//                _pageControl.numberOfPages = contentArray.count;
//                _pageControl.center = CGPointMake(selfW/2, selfH*3/4);
//            }
//            UITapGestureRecognizer *imgViewTap;
//            for (NSInteger i = 0; i < contentArray.count; i++) {
//                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(selfW*i, 0, selfW, selfH)];
//                imgView.tag = 1000+i;
//                imgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//                BannerModel *bannerModel = [MTLJSONAdapter modelOfClass:[BannerModel class] fromJSONDictionary:contentArray[i] error:nil];
//                [self.bannerModelArray addObject:bannerModel];
//                //图片加载用SDWebimge
//                imgView.image = [UIImage imageNamed:bannerModel.img];
//                imgView.userInteractionEnabled = YES;
//                
//                imgViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewTapEvent:)];
//                [imgView addGestureRecognizer:imgViewTap];
//                
//                [_bannerScrollView addSubview:imgView];
//            }
//            
//        }
//}


//- (void)setContentWithModelArray:(NSArray *)array {
//    
//    if (array.count) {
//        self.bannerScrollView.contentSize = CGSizeMake(selfW*array.count, selfH);
//        if (array.count > 1) {
//            _pageControl.numberOfPages = array.count;
//            _pageControl.center = CGPointMake(selfW/2, selfH*3/4);
//        }
//        UITapGestureRecognizer *imgViewTap;
//        for (NSInteger i = 0; i < array.count; i++) {
//            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(selfW*i, 0, selfW, selfH)];
//            imgView.tag = 1000+i;
//            imgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//            BannerModel *bannerModel = [MTLJSONAdapter modelOfClass:[BannerModel class] fromJSONDictionary:array[i] error:nil];
//            [self.bannerModelArray addObject:bannerModel];
//            //图片加载用SDWebimge
//            imgView.image = [UIImage imageNamed:bannerModel.img];
//            imgView.userInteractionEnabled = YES;
//            
//            imgViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewTapEvent:)];
//            [imgView addGestureRecognizer:imgViewTap];
//            
//            [self.bannerScrollView addSubview:imgView];
//        }
//        
//    }
//}

- (void)imgViewTapEvent:(UITapGestureRecognizer*)tap {
    NSUInteger tagIndex = tap.view.tag - 1000;
    [self routerEventWithName:[NSString stringWithFormat:@"bannerImageViewTapped%ld",tagIndex] userInfo:@{@"tap":self.bannerModelArray[tagIndex]}];
}

#pragma mark - bannerScrollView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x/selfW;
}

#pragma mark - 属性

- (UIScrollView*)bannerScrollView {
    if (_bannerScrollView == nil) {
        _bannerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, selfW, selfH)];
        _bannerScrollView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0f];
        _bannerScrollView.contentSize = CGSizeMake(selfW, selfH);
        _bannerScrollView.delegate = self;
        _bannerScrollView.scrollEnabled = YES;
        _bannerScrollView.pagingEnabled = YES;
    }
    return _bannerScrollView;
}

- (UIPageControl*)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 0;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];//当前pageControl颜色
        _pageControl.pageIndicatorTintColor = [UIColor cyanColor];
    }
    return _pageControl;
}

- (NSMutableArray*)bannerModelArray {
    if (!_bannerModelArray) {
        _bannerModelArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _bannerModelArray;
}


@end
