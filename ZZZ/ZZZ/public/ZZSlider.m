//
//  ZZSlider.m
//  ZZZ
//
//  Created by zxw on 17/5/11.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import "ZZSlider.h"


@interface ZZSlider ()
{
    
}
@property(nonatomic, strong) UIImageView * imageViewText;
@property(nonatomic, strong) UILabel * labelView;
@property(nonatomic, strong) BlockSlider SliderChangeblock;

@property(nonatomic, strong) UIView * slider;


@end

@implementation ZZSlider


- (instancetype)init{
    if (self = [super init]) {
        [self setThumbImage:[UIImage imageNamed:@"quantity_bar_buttton"] forState:UIControlStateNormal];
        
        [self setMinimumTrackImage:[UIImage imageNamed:@"quantity_bar"] forState:UIControlStateNormal];
        
        [self setMaximumTrackImage:[UIImage imageNamed:@"quantity_progressbar_bg"] forState:UIControlStateNormal];
        
    }
    return self;
}


- (void)setImageViewText:(UIImageView *)imageViewText{
    _imageViewText = imageViewText;
    if (self.labelView) {
        [self.imageViewText addSubview:self.labelView];
    }
    
    
}
- (void)setLabelView:(UILabel *)labelView{
    _labelView = labelView;
    if (self.imageViewText) {
        [self.imageViewText addSubview:self.labelView];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView * view in self.subviews) {
        
        if (![view clipsToBounds] && !_slider) {
            
            CGRect rect = self.imageViewText.frame;
            rect.origin.y = -(view.frame.size.height+3) ;
            rect.origin.x = (view.frame.size.width - rect.size.width)/2.0;
            self.imageViewText.frame = rect;
            [view addSubview:self.imageViewText];
            
            self.slider = view;
            
            [self.slider addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
            
            
            
        }
        
    }
}


static NSString * extracted(NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
    NSString * rect = change[@"new"];
    return rect;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat width =  self.frame.size.width - self.slider.frame.size.width;
    NSString * rect = extracted(change);
    
    rect = [[NSString stringWithFormat:@"%@",rect] stringByReplacingOccurrencesOfString:@"NSRect: {" withString:@"{"];
    CGRect rects = CGRectFromString(rect);
    float value = rects.origin.x/width * self.maximumValue;
    
    if (self.SliderChangeblock) {
        self.SliderChangeblock(value);
    }

}




- (void)setSliderChangeblock:(BlockSlider)block{
    if (block) {
        _SliderChangeblock = block;
    }
}






@end
