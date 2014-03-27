//
//  BMCustomButton.m
//  BananaNews
//
//  Created by 龚 涛 on 14-1-2.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFCustomButton.h"

@implementation QFCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleRect = CGRectZero;
        _imageRect = CGRectZero;
        
        self.bgColor = [UIColor clearColor];
        self.highlightedBgColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.selected || self.highlighted) {
        self.backgroundColor = self.highlightedBgColor;
    }
    else {
        self.backgroundColor = self.bgColor;
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return _titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return _imageRect;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsLayout];
}

#pragma mark - Property

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    [self setSelected:self.selected];
}

- (void)setHighlightedBgColor:(UIColor *)highlightedBgColor
{
    _highlightedBgColor = highlightedBgColor;
    [self setSelected:self.selected];
}

@end
