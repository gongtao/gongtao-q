//
//  QFNewsDetailToolBar.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFNewsDetailToolBar.h"

#import "QFCustomButton.h"

@interface QFNewsDetailToolBar ()

- (void)_buttonSelected:(UIButton *)button;

@end

@implementation QFNewsDetailToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = Color_DarkBlue;
        
        _titleArray = @[@"分享", @"收藏", @"评论", @"赞"];
        __block CGFloat x = 0.0;
        [_titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            QFCustomButton *button = [[QFCustomButton alloc] initWithFrame:CGRectMake(x, 0.0, 80.0, frame.size.height)];
            button.imageRect = CGRectMake(28.0, 6.0, 24.0, 24.0);
            button.titleRect = CGRectMake(26.0, 30.0, 28.0, 20.0);
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"底部导航%@.png", obj]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"底部导航%@.png", obj]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(_buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100+idx;
            [self addSubview:button];
            x += 80.0;
        }];
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
