//
//  GetNumber.h
//  ZZZ
//
//  Created by zxw on 2018/3/6.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>



@interface GetNumber : NSObject
@property(nonatomic, assign) BOOL isTool;


+ (instancetype)initWithHeard:(NSString *)heard footer:(NSString *)footer itemid:(NSString *)itemid;

- (void)loginGetTokenCompletionHandler:(void (^)(id  data))completionHandler;
- (void)getmobileCompletionHandler:(void (^)(id  data))completionHandler;
- (void)getsmsCompletionHandler:(void (^)(id  data))completionHandler;


@end
