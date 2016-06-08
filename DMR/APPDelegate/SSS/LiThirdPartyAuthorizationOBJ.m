//
//  LiThirdPartyAuthorizationOBJ.m
//  happigo
//
//  Created by klx on 15/4/10.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "LiThirdPartyAuthorizationOBJ.h"
//#import "TencentOpenAPI/TencentOAuth.h"
#import "NSString+PhoneNumber.h"
//#import "PCUserInfoCell.h"
//#import "PCLoginVC.h"
#import "UMSocial.h"
#import "WeiboUser.h"
#import "WXApi.h"

@interface LiThirdPartyAuthorizationOBJ ()

@end

@implementation LiThirdPartyAuthorizationOBJ

//+ (void)GetWeiBoAuthorizationWithVC:(UIViewController *)vc  {
//    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            snsAccount != nil ? [[self new] logInWithUid:snsAccount.usid Type:0 NickName:snsAccount.userName AndToken:snsAccount.accessToken AndViewController:vc] : nil;
////            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//        }});
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
////        NSLog(@"SnsInformation is %@",response.data);
//    }];
//    
//    
//    
////    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
////    request.redirectURI = @"http://www.dameiren.com";
////    request.scope = @"all";
////    [WeiboSDK sendRequest:request];
//}
//
//+ (void)GetWXAuthorizationWithVC:(UIViewController *)vc  {
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//            [[self new] logInWithUid:snsAccount.usid Type:1 NickName:snsAccount.userName AndToken:snsAccount.accessToken AndViewController:vc];
////            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//        }
//    });
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
////        NSLog(@"SnsInformation is %@",response.data);
//    }];
//}
//
//+ (void)GetQQAuthorizationWithVC:(UIViewController *)vc  {
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//            [[self new] logInWithUid:snsAccount.usid Type:2 NickName:snsAccount.userName AndToken:snsAccount.accessToken AndViewController:vc];
////            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//        }});
//        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
//            //        NSLog(@"SnsInformation is %@",response.data);
//        }];
//}
//
//+ (void)loginWithWeiBo:(WBBaseResponse *)response  {
//    [WBHttpRequest requestForUserProfile:response.userInfo[@"uid"] withAccessToken:response.userInfo[@"access_token"] andOtherProperties:nil queue:[NSOperationQueue mainQueue] withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        WeiboUser *user;
//        if (error == nil) {
//            user = result;
//        }
////        [[self new] logInWithUid:response.userInfo[@"uid"] Type:0 NickName:error != nil ? @"" : user.name AndToken:response.userInfo[@"access_token"] AndViewController:;
//    }];
//    
//}
//
//- (void)logInWithUid:(NSString *)uid Type:(int)type NickName:(NSString *)nickName AndToken:(NSString *)token AndViewController:(UIViewController *)vc  {
//    //[TNToast showLoadingToast];
//    NSString *clintID = [MainTabBar.gexinPusher clientId];
//    clintID = clintID.length ? clintID : @"";
//
//    NSString *url = [NSString stringWithFormat:@"%@user/thirdBind.do", KHeaderURL];
//    NSDictionary *parameters = @{@"nickname": nickName, @"authUid": uid, @"authToken": token, @"authId": @(type), @"regSource":@(0),@"clientId": clintID};
//    
//    void (^success)(NSDictionary *dic) = ^(NSDictionary *responseDic)  {
//        [TNToast showWithText:@"登录成功"];
//        NSDictionary *dataDic = responseDic[@"data"];
////        NSDictionary *dic = dataDic[@"userInfo"];
//        NSString *picHeader = dataDic[@"picIp"];
//        NSDictionary *bindMobileDic = dataDic[@"bindMobile"];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic[@"userInfo"]];
//        [dic setObject:picHeader forKey:@"picHeader"];
//        
//        [dic setObject:dataDic[@"isNewReg"] forKey:@"isNewReg"];
//        [dic setObject:dataDic[@"message"] forKey:@"message"];
//        [dic setObject:dataDic[@"uid"] forKey:@"uid"];
//        
//        MainTabBar.currentUser = [User initWithDictionary:dic];
//        MainTabBar.userDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//        if ([bindMobileDic allKeys].count)  {
//            MainTabBar.currentUser.phoneNum = bindMobileDic[@"bind_mobile_no"];
//            [MainTabBar.userDic setObject:MainTabBar.currentUser.phoneNum forKey:@"phoneNum"];
//        }
//        [MainTabBar saveCurrentUser];
//        PCUserInfoCell *cell = (PCUserInfoCell *)(((UITableView *)[MainTabBar.view viewWithTag:999]).tableHeaderView);
//        [cell setViewAfterLogIn];
//        [PCLoginVC cloudPush];
//        [vc.navigationController popViewControllerAnimated:YES];
//    };
//    void (^failure)(NSString *error) = ^(NSString *error)  {
//    };
//    [LiAFNetWorkingTool GET:url parameters:parameters success:success failure:failure];
//}
//
//+ (void)loginWithWX:(NSString *)code  {
//    NSString *url = @"https://api.weixin.qq.com/sns/oauth2/access_token";
//    NSDictionary *parameters = @{@"appid":@"wx382eaad790b61b88", @"secret":@"b98f065924e67a8944f09e913883d3c8", @"code":code, @"grant_type":@"authorization_code"};
//    void (^success)(NSDictionary *dic) = ^(NSDictionary *responseDic)  {
//        if (responseDic[@"access_token"]) {
//            [[self new] getWXUserInfoByToken:responseDic[@""] AndOpenID:responseDic[@"openid"]];
//        }  else if (responseDic[@"errcode"])  {
//            [TNToast showWithText:responseDic[@"errmsg"]];
//        }
//    };
//    //失败了在此没有做失败的提示信息。
//    void (^failure)(NSString *error) = ^(NSString *error){};
//    [LiAFNetWorkingTool GET:url parameters:parameters success:success failure:failure];
//}
//
//- (NSDictionary *)getWXUserInfoByToken:(NSString *)token AndOpenID:(NSString *)openID  {
//    NSString *url = @"https://api.weixin.qq.com/sns/userinfo";
//    NSDictionary *parameters = @{@"access_token":token, @"openid":openID};
//    void (^success)(NSDictionary *dic) = ^(NSDictionary *responseDic)  {
//        
//    };
//    void (^failure)(NSString *error) = ^(NSString *error){};
//    [LiAFNetWorkingTool GET:url parameters:parameters success:success failure:failure];
//    
//    return nil;
//}

@end







