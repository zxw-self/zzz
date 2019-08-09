//
//  TextView.m
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/22.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//


#import "TextView.h"

/*
 @property(nullable,nonatomic,strong) NSString * text;
 @property(nullable,nonatomic,strong) NSString * placeholder;
 @property(nullable,nonatomic,strong) UIFont *font;
 @property(nullable,nonatomic,strong) UIColor *textColor;
 @property(nonatomic) NSTextAlignment textAlignment;    // default is NSLeftTextAlignment
 @property(nonatomic) NSRange selectedRange;
 @property(nonatomic,getter=isEditable) BOOL editable __TVOS_PROHIBITED;
 */
@interface TextView ()<UITextViewDelegate>
{
    
}
@property(nonatomic, strong) UITextView * textView;
@property(nonatomic, strong) UIColor * textCol;
@property(nonatomic, assign) BOOL isNotFirst;

@property(nonatomic, strong) DidEditBlock editBlock;
//@property(nonatomic, strong) BeginEditBlock beginBlock;

@end


@implementation TextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTextviewWithframe:self.bounds];
        _maxCount = 500;
    }
    return self;
}
- (void)addTextviewWithframe:(CGRect)frame{

    self.textView = [[UITextView alloc] initWithFrame:frame];
    self.textView.delegate = self;
    self.textCol =self.textView.textColor;

    [self addSubview:self.textView];
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (!self.isNotFirst) {
        self.textView.text = @"";
        self.textView.textColor = self.textCol;
        self.isNotFirst = YES;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.text.length <= 0) {
        self.textView.text = _placeholder;
        self.textView.textColor = [UIColor lightGrayColor];
        self.isNotFirst = NO;
    }
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
 
    //控制输入的文字量
    if (text.length == 0) return YES;
    NSInteger existedLength = textView.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = text.length;
    if (existedLength - selectedLength + replaceLength > self.maxCount) return NO;

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.editBlock) {
        self.editBlock(textView.text);
    }
}




- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textView.text = placeholder;
    self.textView.textColor = [UIColor lightGrayColor];
    
}

- (void)setText:(NSString *)text{
    self.textView.text = text;
}
- (NSString *)text{
    return self.textView.text;
}
- (void)setFont:(UIFont *)font{
    self.textView.font = font;
}
- (UIFont *)font{
    return self.textView.font;
}
- (void)setTextColor:(UIColor *)textColor{
    self.textView.textColor = textColor;
}

- (UIColor *)textColor{
    return self.textColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.textView.textAlignment = textAlignment;
}
- (NSTextAlignment)textAlignment{
    return self.textView.textAlignment;
}
- (void)setSelectedRange:(NSRange)selectedRange{
    self.textView.selectedRange = selectedRange;
}
- (NSRange)selectedRange{
    return self.textView.selectedRange;
}
- (void)setEditable:(BOOL)editable{
    self.textView.editable = editable;
}
- (BOOL)isEditable{
    return self.textView.isEditable;
}

@end
