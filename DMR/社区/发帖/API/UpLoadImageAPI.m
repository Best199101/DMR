//
//  UpLoadImageAPI.m
//  happigo
//
//  Created by 李海龙 on 16/1/4.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "UpLoadImageAPI.h"
#import "AFNetworking.h"
#import <UIProgressView+AFNetworking.h>
#import "Global.h"

@interface UpLoadImageAPI ()

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURLSessionUploadTask *task;


@end

@implementation UpLoadImageAPI


-(void)upLoadImageWithView:(CustomImageView *)customImageView
{
    _customImageView = customImageView;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //将Image转化为NSData数据
    NSData * imgData = UIImageJPEGRepresentation(customImageView.imageview.image,1);
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // 时间戳获得上传图片的名字，这是任意取的，后台会返回给我们图片的正确名字
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *imgName = [NSString stringWithFormat:@"%@.JPG",currentDateStr];
    //开始上传图片
    WeakObject(weakSelf);
    _task =
    (NSURLSessionUploadTask *)[manager POST:[KHeaderURL stringByAppendingString:@"new/file/upload.do"]
                                 parameters:@{@"uid": UserId}
                  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:imgData
                                             name:@"pic"
                                         fileName:imgName
                                         mimeType:@"image/png"];

                  } success:^(NSURLSessionDataTask *task, id responseObject) {
                        if ([responseObject[@"status"] intValue] == 0)
                        {
                            NSDictionary *dic = responseObject[@"data"];
                            NSArray *imageNameArray = dic[@"picNames"];
                            if ([weakSelf.delegate respondsToSelector:@selector(upLoadImageSuccessWithImageName:View:Identifier:)])
                            {
                                [weakSelf.delegate upLoadImageSuccessWithImageName:imageNameArray
                                                                              View:_customImageView
                                                                        Identifier:_identifier];
                            }
                          
                        }

                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        if ([weakSelf.delegate respondsToSelector:@selector(upLoadImageFailedWithImageName:View:Identifier:)])
                        {
                            [weakSelf.delegate upLoadImageFailedWithImageName:nil
                                                                         View:_customImageView
                                                                   Identifier:_identifier];
        
                        }

    }];
    [customImageView.progressView setProgressWithUploadProgressOfTask:_task
                                                             animated:YES];
}

-(void)cancelUpload
{
    self.delegate = nil;
    [_task cancel];
}

@end
