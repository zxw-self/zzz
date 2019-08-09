//
//  TextView.h
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/22.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidEditBlock)(NSString * str);

@interface TextView : UIView

@property(nullable,nonatomic,strong) NSString * text;
@property(nullable,nonatomic,strong) NSString * placeholder;
@property(nullable,nonatomic,strong) UIFont *font;
@property(nullable,nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;    // default is NSLeftTextAlignment
@property(nonatomic) NSRange selectedRange;
@property(nonatomic,getter=isEditable) BOOL editable __TVOS_PROHIBITED;

@property(nonatomic, assign) NSInteger maxCount;        // default is 500

- (void)setPlaceholder:(NSString * _Nullable)placeholder;

- (void)setEditBlock:(DidEditBlock)editBlock;

@end
