//
//  NotificationCenterBlock.m
//  ZZZ
//
//  Created by zxw on 17/5/4.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import "NotificationCenterBlock.h"


@interface NotificationCenterBlock ()

@property(nonatomic, strong) NSString * key;
@property(nonatomic, strong) NSMutableDictionary * keyBlockDic;

@end



@implementation NotificationCenterBlock

/* --- 单例创建 --- */
static NotificationCenterBlock *notif = nil;
- (instancetype)init{
    
    if (notif) {
        return notif;
    }
    
    if (self = [super init]) {
        self.keyBlockDic = [NSMutableDictionary dictionary];
        notif = self;
    }
    return self;
}


- (instancetype)initNotificationCenterBlockWithKey:(NSString *)key{
    self = [[NotificationCenterBlock alloc] init];
    self.key = key;
    return self;
}

+ (instancetype)shareNotificationCenterBlockWithKey:(NSString *)key{
    return [NotificationCenterBlock NotificationCenterBlockWithKey:key];
}

+ (instancetype)NotificationCenterBlockWithKey:(NSString *)key{
    return [[NotificationCenterBlock alloc] initNotificationCenterBlockWithKey:key];
}




/* --- 发送通知 --- */
+ (void)sendNotificationWithKey:(NSString *)key Info:(NSDictionary *)message{
    
    NotificationCenterBlock * notif = [NotificationCenterBlock shareNotificationCenterBlockWithKey:key];
    [notif sendNotificationInfo:message];

}

- (void)sendNotificationInfo:(NSDictionary *)message{
    NSMutableArray * arr = [self.keyBlockDic valueForKey:self.key];
    if (!arr) {
        return;
    }
    for (NotifBlock blcok in arr) {
        blcok(message);
    }
    
    self.keyBlockDic[self.key] = arr;
}





/* --- 添加和移除 --- */
+ (void)addBlocksObject:(NotifBlock)object WithKey:(NSString *)key{
     NotificationCenterBlock * notif = [NotificationCenterBlock shareNotificationCenterBlockWithKey:key];
    [notif addBlocksObject:object];
}
+ (void)removeAllBlocksObjectWithKey:(NSString *)key{
    NotificationCenterBlock * notif = [NotificationCenterBlock shareNotificationCenterBlockWithKey:key];
    [notif removeAllBlocksObject];
}


- (void)addBlocksObject:(__autoreleasing NotifBlock)object{
    
    if (!object) return;
    
    NSMutableArray * arr = [self.keyBlockDic valueForKey:self.key];
    if (!arr) {
        arr = [NSMutableArray array];
    }
    [arr addObject:object];
    
    self.keyBlockDic[self.key] = arr;
    
}

- (void)removeAllBlocksObject{
    
    NSMutableArray * arr = [self.keyBlockDic valueForKey:self.key];
    if (arr) {
        [arr removeAllObjects];
    }
    
    self.keyBlockDic[self.key] = arr;
}



@end
