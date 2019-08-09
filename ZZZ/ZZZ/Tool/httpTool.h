//
//  httpTool.h
//  ZZZ
//
//  Created by zxw on 2018/3/8.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface httpTool : NSObject

- (void)post_Dic:(NSString *)host POST:(NSString *)post dicData:(NSDictionary *)dic  completionHandler:(void (^)(id  data))completionHandler;

- (void)getJson:(NSString *)host completionHandler:(void (^)(id  data))completionHandler;

- (void)GetImageAndCookies:(NSString *)host completionHandler:(void (^)(UIImage * image,id  cookies))completionHandler;

- (void)GetSmsCookies:(NSString *)host cookies:(NSDictionary *)dic completionHandler:(void (^)(id, id))completionHandler;

- (void)sendMsm:(NSString *)str completionHandler:(void (^)(id  data))completionHandler;
- (void)sendReg:(NSString *)str comMember:(NSString *)comMember msg:(NSString *)sms code:(NSString *)code PHPSESSID:(NSString *)PHPSESSID completionHandler:(void (^)(id  data))completionHandler;
@end
