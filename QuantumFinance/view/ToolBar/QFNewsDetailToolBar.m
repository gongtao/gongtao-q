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

-(void)dingButtonDidClick:(UIButton *)button;


@end

@implementation QFNewsDetailToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = Color_DarkBlue;
        
        _titleArray = @[@"分享", @"收藏", @"评论", @"点赞"];
        __block CGFloat x = 0.0;
        [_titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            QFCustomButton *button = [[QFCustomButton alloc] initWithFrame:CGRectMake(x, 0.0, 80.0, frame.size.height)];
            button.imageRect = CGRectMake(28.0, 6.0, 24.0, 24.0);
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if (obj==@"点赞" ) {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"文章详情_%@按钮.png", obj]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"文章详情_%@按钮_点击态.png", obj]] forState:UIControlStateHighlighted];
        
                [button setTitle:@"赞" forState:UIControlStateNormal];
                button.titleRect = CGRectMake(34.0, 30.0, 28.0, 20.0);
                
            }
            else{
                button.titleRect = CGRectMake(26.0, 30.0, 28.0, 20.0);
                [button setTitle:obj forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"文章详情_%@按钮.png", obj]] forState:UIControlStateNormal];
            }
                        
            if (obj==@"收藏")
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"文章详情_%@按钮_点击态.png", obj]] forState:UIControlStateHighlighted];
            }            
            [button addTarget:self action:@selector(_buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100+idx;
            [self addSubview:button];
            x += 80.0;
        }];
    }
    return self;
}

- (void)_buttonSelected:(UIButton *)button
{
    int index=button.tag-100;
    switch (index) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(shareButtonClicked)]) {
                [self.delegate shareButtonClicked];
            }
            break;
        case 1:
            [self collectButtonDidClick:button];
            break;
        case 2:
            if ([self.delegate respondsToSelector:@selector(commentButtonClicked)]) {
                [self.delegate commentButtonClicked];
            }
            
            break;
        case 3:
            [self dingButtonDidClick:button];
            break;
            
        default:
            break;
    }
}

-(void)checkDingButton:(BOOL)isGood
{
    if (isGood) {
        UIButton *button=(UIButton *)[self viewWithTag:103 ];
        [button setImage:[UIImage imageNamed:@"文章详情_点赞按钮_点击态.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"文章详情_点赞按钮_点击态.png"] forState:UIControlStateHighlighted];
        //[button setUserInteractionEnabled:NO];
    }
}

-(void)checkCollectButton:(BOOL)Collected
{
    if (Collected) {
        UIButton *button=(UIButton *)[self viewWithTag:101 ];
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮_点击态.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮_点击态.png"] forState:UIControlStateHighlighted];
        //[button setUserInteractionEnabled:NO];
    }
}

-(void)collectButtonDidClick:(UIButton *)button
{
    if (![_delegate isCollected]) {
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮_点击态.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮_点击态.png"] forState:UIControlStateHighlighted];
        if ([self.delegate respondsToSelector:@selector(collectButtonClicked:)])
        {
            [self.delegate collectButtonClicked:YES];
        }
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"文章详情_收藏按钮_点击态.png"] forState:UIControlStateHighlighted];
        if ([self.delegate respondsToSelector:@selector(collectButtonClicked:)])
        {
            [self.delegate collectButtonClicked:NO];
        }
    }    
    
}

-(void)dingButtonDidClick:(UIButton *)button
{
    if (![_delegate isGood]) {
        [button setImage:[UIImage imageNamed:@"文章详情_点赞按钮_点击态.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"文章详情_点赞按钮_点击态.png"] forState:UIControlStateHighlighted];
        //[button setUserInteractionEnabled:NO];
        if ([self.delegate respondsToSelector:@selector(dingButtonClicked)])
        {
            [self.delegate dingButtonClicked];
        }
    }    
    
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
