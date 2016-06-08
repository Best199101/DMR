


#import <UIKit/UIKit.h>
#import "PhotoModel.h"
#import "PhotoBroswerType.h"






@interface PhotoBroswerVC : UIViewController


+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock CompleteCallBack:(void (^)(BOOL isFinish))complete;


@end
