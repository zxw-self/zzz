//
//  ScrollView.h
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/22.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddButBlock)();
typedef void(^ImgTapBlock)(NSInteger index);

@interface ScrollView : UIView

@property(nonatomic, strong) AddButBlock butBlock;
@property(nonatomic, strong) ImgTapBlock imgBlock;

@property(nonatomic, strong) NSArray * arr;
@property(nonatomic, strong) NSArray * contentViewArr;


- (void)setButBlock:(AddButBlock)butBlock;
- (void)setImgBlock:(ImgTapBlock)imgBlock;

@end
