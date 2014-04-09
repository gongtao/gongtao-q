//
//  QFProductProgress.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/9/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFProductProgress.h"

@implementation QFProductProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _barView = [[UIView alloc] init];
        _barView.backgroundColor = Color_MainBlue;
        [self addSubview:_barView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    CGRect frame = self.bounds;
    frame.size.width -= 2.0;
    frame.size.height -= 2.0;
    frame.origin = CGPointMake(1.0, 1.0);
    frame.size.width *= progress;
    _barView.frame = frame;
}

@end
