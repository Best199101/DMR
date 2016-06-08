//
//  ImageUploadManager.m
//  happigo
//
//  Created by shklxmac111 on 16/1/3.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "ImageUploadManager.h"
#import "UpLoadImageAPI.h"
#import "CustomImageView.h"
#import "DeleteImageAPI.h"
#import "Global.h"

@interface ImageUploadManager ()<UpLoadImageDelegate,APIRequestManagerDelegate>

@property (strong,nonatomic) NSMutableArray *stateArray;
@property (strong,nonatomic) NSMutableArray *uploadTaskAPIArray;

@end

static ImageUploadManager *_imageUploadManager = nil;


@implementation ImageUploadManager

+(ImageUploadManager *)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_imageUploadManager == nil)
        {
            _imageUploadManager = [[ImageUploadManager alloc] init];
        }
    });
    return _imageUploadManager;
}

-(instancetype)init
{
    if (self = [super init])
    {
        _uploadTaskAPIArray = [NSMutableArray new];
        
    }
    return self;
}

-(void)addNewUploadTask:(CustomImageView *)customImageView
         withStateArray:(NSMutableArray *)stateArray
{
    _stateArray = stateArray;
    UpLoadImageAPI *uploadImageAPI = [UpLoadImageAPI new];
    uploadImageAPI.delegate = self;
    uploadImageAPI.identifier = customImageView.tag;
    [uploadImageAPI upLoadImageWithView:customImageView];
    [_uploadTaskAPIArray addObject:uploadImageAPI];
    dispatch_group_enter(_uploadGroup);
}

-(void)cancelUploadTask:(NSInteger)taskIdentifier
{
    for (UpLoadImageAPI *api in _uploadTaskAPIArray) {
        if (api.identifier == taskIdentifier)
        {
            [api cancelUpload];
            [_uploadTaskAPIArray removeObject:api];
            break;
        }
    }
    dispatch_group_leave(_uploadGroup);
}

-(void)deleteFailedImage:(NSInteger)taskIdentifier
{
    for (UpLoadImageAPI *api in _uploadTaskAPIArray) {
        if (api.identifier == taskIdentifier)
        {
            [api cancelUpload];
            [_uploadTaskAPIArray removeObject:api];
            break;
        }
    }
    
}

-(void)deleteUploadImage:(NSString *)imageName
{
    DeleteImageAPI *deleteImageAPI = [DeleteImageAPI new];
    deleteImageAPI.apiMangerCallBackDelegate = self;
    [deleteImageAPI startRequestWithUid:UserId
                                Picname:imageName];
}

-(void)upLoadImageSuccessWithImageName:(NSArray *)imageName
                                  View:(CustomImageView *)view
                            Identifier:(NSInteger)identifier
{
    view.progressView.hidden = YES;
    if (_stateArray.count > identifier - 100)
    {
        NSMutableDictionary *dic = _stateArray[identifier - 100];
        [dic setObject:imageName.firstObject forKey:@"name"];
    }
    for (UpLoadImageAPI *api in _uploadTaskAPIArray) {
        if (api.identifier == identifier)
        {
            [_uploadTaskAPIArray removeObject:api];
            break;
        }
    }
    dispatch_group_leave(_uploadGroup);
}

-(void)upLoadImageFailedWithImageName:(NSArray *)imageName
                                 View:(CustomImageView *)view
                           Identifier:(NSInteger)identifier
{
    view.progressView.hidden = NO;
    view.imageview.image = [UIImage imageNamed:@"btn_shequ_uploadpic_fail"];
    if (_stateArray.count > identifier - 100)
    {
        NSMutableDictionary *dic = _stateArray[identifier - 100];
        [dic setObject:@"-1" forKey:@"name"];
    }
    dispatch_group_leave(_uploadGroup);
}

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{

}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{

}

@end
