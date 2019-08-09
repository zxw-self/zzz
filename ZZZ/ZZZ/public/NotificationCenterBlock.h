//
//  NotificationCenterBlock.h
//  ZZZ
//
//  Created by zxw on 17/5/4.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NotifBlock)(NSDictionary * info);

@interface NotificationCenterBlock : NSObject

// 发送通知
+ (void)sendNotificationWithKey:(NSString *)key Info:(NSDictionary *)message;

// 接收通知
+ (void)addBlocksObject:(NotifBlock)object WithKey:(NSString *)key;



+ (instancetype)shareNotificationCenterBlockWithKey:(NSString *)key;
+ (instancetype)NotificationCenterBlockWithKey:(NSString *)key;
- (instancetype)initNotificationCenterBlockWithKey:(NSString *)key;

- (void)sendNotificationInfo:(NSDictionary *)message;

- (void)addBlocksObject:(NotifBlock)object;
- (void)removeAllBlocksObject;


+ (void)removeAllBlocksObjectWithKey:(NSString *)key;

@end
