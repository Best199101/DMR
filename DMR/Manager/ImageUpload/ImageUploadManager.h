//
//  ImageUploadManager.h
//  happigo
//
//  Created by shklxmac111 on 16/1/3.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomImageView;

@interface ImageUploadManager : NSObject

@property (strong,nonatomic) dispatch_group_t uploadGroup;

+(ImageUploadManager *)defaultManager;

-(void)addNewUploadTask:(CustomImageView *)customImageView
         withStateArray:(NSMutableArray *)stateArray;

-(void)cancelUploadTask:(NSInteger)taskIdentifier;

-(void)deleteUploadImage:(NSString *)imageName;

-(void)deleteFailedImage:(NSInteger)taskIdentifier;

@end
