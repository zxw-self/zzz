//
//  ZZSlider.h
//  ZZZ
//
//  Created by zxw on 17/5/11.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockSlider)(float value);

@interface ZZSlider : UISlider


- (void)setLabelView:(UILabel *)labelView;
- (void)setImageViewText:(UIImageView *)imageViewText;

- (void)setSliderChangeblock:(BlockSlider)block;

@end
