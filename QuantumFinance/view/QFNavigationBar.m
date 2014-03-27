//
//  QFNavigationBar.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFNavigationBar.h"

@implementation QFNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = Color_MainBlue;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, frame.size.height-44.0, frame.size.width, 44.0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
