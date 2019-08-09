//
//  ScoketTool.h
//  ZZZ
//
//  Created by zxw on 2018/3/5.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

@protocol ScoketToolDelegate <NSObject>

- (void)SRWebSocketDidClose;
- (void)SRWebSocketDidOpen;
- (void)SRWebSocketDidReceiveMsg:(NSObject *)obj;

@end

@interface ScoketTool : NSObject

// 获取连接状态
@property (nonatomic,assign,readonly) SRReadyState socketReadyState;
@property(nonatomic, weak) NSObject<ScoketToolDelegate> * delegate;

+ (ScoketTool *)instance;

-(void)SRWebSocketOpen;//开启连接
-(void)SRWebSocketClose;//关闭连接
- (void)sendData:(id)data;//发送数据


@end
