//
//  UITextField+NumLimit.m
//  
//
//  Created by 雨 on 16/5/12.
//
//

#import "UITextField+NumLimit.h"

@implementation UITextField (NumLimit)

- (void)limitWithMax:(NSInteger)maxNum {
    NSString *toBeString = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];
    
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position || !selectedRange)
        {
            if (toBeString.length > maxNum)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxNum];
                if (rangeIndex.length == 1)
                {
                    self.text = [toBeString substringToIndex:maxNum];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxNum)];
                    self.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > maxNum)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxNum];
            if (rangeIndex.length == 1)
            {
                self.text = [toBeString substringToIndex:maxNum];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxNum)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

@end
