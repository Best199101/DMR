//
//  SHUDID.m
//  xiaoqu
//
//  Created by shenhai on 15/1/24.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHUDID.h"
#import <SSKeychain/SSKeychain.h>

#define UDIDService  @"UDIDService"
@implementation SHUDID


+ (id)sharedUDID
{
    static SHUDID *udid = nil;
    @synchronized(self) {
        if (!udid) {
            udid = [[SHUDID alloc]init];
            udid = (id)[SHUDID UDID];
        }
    }
    return udid;
}

//+ (id)openUDID
//{
//    static SHUDID *openUDID = nil;
//    @synchronized(self) {
//        if (!openUDID) {
//            openUDID = (id)[OpenUDID value];
//        }
//    }
//    return openUDID;
//}


+ (NSString *)UDID
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *identifierStr = device.identifierForVendor.UUIDString;
    NSString * const KEY_USERNAME = @"com.66xiaoqu.iOS.xiaoqu.udid.username";
//    NSString * const KEY_PASSWORD = @"com.66xiaoqu.iOS.xiaoqu.udid.password";
    NSString * const KEY_SERVICE = @"com.66xiaoqu.iOS.xiaoqu.udid.password";

//    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary new];
//    [usernamepasswordKVPairs setObject:identifierStr forKey:KEY_PASSWORD];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usernamepasswordKVPairs];
    
    if (![SSKeychain passwordForService:KEY_SERVICE account:KEY_USERNAME]) {
        [SSKeychain setPassword:identifierStr forService:KEY_SERVICE account:KEY_USERNAME];
    }
    NSError *error = nil;
    NSString *udid = [SSKeychain passwordForService:KEY_SERVICE account:KEY_USERNAME error:&error];
    if (error) {
        NSLog(@"error:%@",error);
        udid = identifierStr;
    }
    
    return udid;
//    if (![SHUDID load:KEY_USERNAME]) {
//        [SHUDID save:KEY_USERNAME data:usernamepasswordKVPairs];
//    }
//    NSMutableDictionary *readUserPwd = (NSMutableDictionary *)[SHUDID load:KEY_USERNAME];
    
    //[readUserPwd objectForKey:KEY_PASSWORD];
}




//存
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

//取
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}


+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end
