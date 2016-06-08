//
//  UpLoadImageAPI.h
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomImageView.h"

@protocol UpLoadImageDelegate <NSObject>

@required

-(void)upLoadImageSuccessWithImageName:(NSArray *)imageName
                                  View:(CustomImageView *)view
                            Identifier:(NSInteger)identifier;

-(void)upLoadImageFailedWithImageName:(NSArray *)imageName
                                 View:(CustomImageView *)view
                           Identifier:(NSInteger)identifier;

@end

@interface UpLoadImageAPI : NSObject

@property (nonatomic, weak) id<UpLoadImageDelegate>delegate;
@property (nonatomic, assign) NSInteger identifier;
@property (strong,nonatomic) CustomImageView *customImageView;

-(void)upLoadImageWithView:(CustomImageView *)customImageView;

-(void)cancelUpload;
@end
