//
//  UIButton+Block.h
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/21.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIButton (Block)


- (void)removeAllTargets;


- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;


- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;


- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end
