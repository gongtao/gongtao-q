//
//  QFHistorySectionView.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/11/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHistorySectionView.h"

@implementation QFHistorySectionView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor greenColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
