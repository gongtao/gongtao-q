//
//  BMToolBar.m
//  BananaNews
//
//  Created by 龚涛 on 3/19/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFToolBar.h"

#import "QFCustomButton.h"

@interface QFToolBar ()

- (void)_buttonSelected:(UIButton *)button;

@end

@implementation QFToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_DarkBlue;
        
        _titleArray = @[@"推荐", @"视角", @"历史", @"我的"];
        __block CGFloat x = 0.0;
        [_titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            QFCustomButton *button = [[QFCustomButton alloc] initWithFrame:CGRectMake(x, 0.0, 80.0, frame.size.height)];
            button.imageRect = CGRectMake(28.0, 6.0, 24.0, 24.0);
            button.titleRect = CGRectMake(26.0, 30.0, 28.0, 20.0);
            button.highlightedBgColor = Color_MainBlue;
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
        _lastIndex = -1;
    }
    return self;
}

#pragma mark - Private

- (void)_buttonSelected:(UIButton *)button
{
    [self selectedTagAtIndex:button.tag-100];
}

#pragma mark - Public

- (void)selectedTagAtIndex:(NSUInteger)index
{
    if (_lastIndex != -1) {
        UIButton *lastButton = (UIButton *)[self viewWithTag:_lastIndex+100];
        lastButton.selected = NO;
    }
    if (index != _lastIndex) {
        UIButton *button = (UIButton *)[self viewWithTag:index+100];
        button.selected = YES;
        if ([self.delegate respondsToSelector:@selector(didSelectTagAtIndex:)]) {
            [self.delegate didSelectTagAtIndex:index];
        }
    }
    _lastIndex = index;
}

@end
