//
//  ScrollView.m
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/22.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()
{
    
}




@property(nonatomic, strong) UIScrollView * ScrollView;
@property(nonatomic, strong) UIButton * addButton;

@property(nonatomic, assign) CGFloat heigthS;
@property(nonatomic, assign) CGFloat widthS;

@end


@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatScrollViewWithFrame:frame];
        
        
    }
    return self;
}

- (void)creatScrollViewWithFrame:(CGRect)frame{
    
    // scrollerView 不可以成为第一个子视图 不然会往下平移64位
    [self addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    
    CGFloat heightS = frame.size.height;
    CGFloat widthS = frame.size.width;
    self.heigthS = heightS;
    self.widthS = widthS;
    
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(heightS, 0, widthS - heightS, heightS)];
    _ScrollView.backgroundColor = [UIColor greenColor];
    [self addSubview:_ScrollView];
    
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, heightS, heightS)];
    [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    
}
- (void)addButtonAction:(UIButton *)sender{
    if (self.butBlock) {
        self.butBlock();
    }
}

- (void)setContentViewArr:(NSArray *)ContentViewArr{
    _contentViewArr = ContentViewArr;
    NSInteger count = ContentViewArr.count;
    
    [self.ScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ((CGFloat)count*self.heigthS > self.widthS - self.heigthS  ) {
        self.ScrollView.contentSize = CGSizeMake((CGFloat)count*self.heigthS, self.heigthS);
    }
    
    for (int i =0; i < count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + i*self.heigthS, 5, self.heigthS - 10, self.heigthS - 10)];
        imageView.tag = 100 +i;
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        imageView.image = ContentViewArr[i];
        [self.ScrollView addSubview:imageView];
    
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    if (self.imgBlock) {
        self.imgBlock(tap.view.tag - 100);
    }
}





@end
