//
//  QFHistorySectionView.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/11/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHistorySectionView.h"

#import <CoreText/CoreText.h>

@interface QFHistorySectionView ()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *blueShaftView;

@property (nonatomic, strong) UIImageView *whiteShaftView;

@property (nonatomic, strong) CATextLayer *timeLayer;

@end

@implementation QFHistorySectionView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _whiteShaftView = [[UIImageView alloc] initWithFrame:CGRectMake(85.0, 0.0, 4.0, 49.0)];
        _whiteShaftView.image = [UIImage imageNamed:@"历史时间轴白.png"];
        [self.contentView addSubview:_whiteShaftView];
        
        _blueShaftView = [[UIImageView alloc] initWithFrame:CGRectMake(88.0, 0.0, 4.0, 49.0)];
        _blueShaftView.image = [UIImage imageNamed:@"历史时间轴蓝.png"];
        [self.contentView addSubview:_blueShaftView];
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0, 9.0, 80.0, 31.0)];
        leftView.image = [UIImage imageNamed:@"历史时间白色底板.png"];
        [self.contentView addSubview:leftView];
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 31.0)];
        _leftLabel.font = [UIFont systemFontOfSize:14.0];
        _leftLabel.textColor = [UIColor colorWithHexString:@"0d9fde"];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment = NSTextAlignmentRight;
        [leftView addSubview:_leftLabel];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(88.0, 9.0, 80.0, 31.0)];
        rightView.image = [UIImage imageNamed:@"历史时间蓝色底板.png"];
        [self.contentView addSubview:rightView];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 31.0)];
        _rightLabel.font = [UIFont systemFontOfSize:14.0];
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.backgroundColor = [UIColor clearColor];
        [rightView addSubview:_rightLabel];
    }
    return self;
}

- (void)setFirstSection:(BOOL)isFirst
{
    if (isFirst) {
        _whiteShaftView.frame = CGRectMake(85.0, 10.0, 4.0, 39.0);
        _blueShaftView.frame = CGRectMake(88.0, 10.0, 4.0, 39.0);
    }
    else {
        _whiteShaftView.frame = CGRectMake(85.0, 0.0, 4.0, 49.0);
        _blueShaftView.frame = CGRectMake(88.0, 0.0, 4.0, 49.0);
    }
    
}

- (void)setSectionTitle:(NSString *)title
{
    _leftLabel.text = [title substringToIndex:5];
    _rightLabel.text = [title substringFromIndex:5];
}

@end
