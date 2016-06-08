//
//  ImageEditView.h
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditView : UIView

@property (assign) NSInteger max;
@property (strong,nonatomic) NSMutableArray *imageDictArray;
@property (strong,nonatomic) UIButton* addButton;

@property (nonatomic, weak) UIViewController* superViewController;

@property (nonatomic,assign)BOOL allUploadTaskDone;

-(void)configLayout;


@end
