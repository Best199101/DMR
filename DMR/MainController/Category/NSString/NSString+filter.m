//
//  NSString+filter.m
//  ADIDAS
//
//  Created by wendy on 14-6-4.
//
//

#import "NSString+filter.h"

@implementation NSString (filter)

- (NSString*) mk_urlEncodedString
{
    CFStringRef encodedCFString =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                    (__bridge CFStringRef) self,
                                                            nil,
                       CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                          kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:
                               (__bridge_transfer NSString*) encodedCFString];
    if(!encodedString)
    {
        encodedString = @"";
    }
    return encodedString;
}

- (NSUInteger) unicodeLengthOfString
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++)
    {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2)
    {
        unicodeLength++;
    }
    return unicodeLength;
}


@end
