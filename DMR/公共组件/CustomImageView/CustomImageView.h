//
//  CustomImageView.h
//  xiaoqu
//
//  Created by wendy on 15/6/6.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIView  // 可删除的imageview

@property (strong,nonatomic) UIImageView* imageview;
@property (strong,nonatomic) UIButton* deleteButton;
@property (strong,nonatomic) UIProgressView *progressView;
@property (assign,nonatomic) BOOL isUpload;

-(void)deleteSelf;
-(id)initWithFrame:(CGRect)frame AndTag:(NSInteger)tag;

@end
