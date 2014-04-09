//
//  QFRecommendProductCell.m
//  QuantumFinance
//
//  Created by 龚 涛 on 14-4-6.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFRecommendProductCell.h"

@interface QFRecommendProductCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation QFRecommendProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 4.0, 302.0, 102.0)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"f4f0f7"];
        [self addSubview:bgView];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(19.0, 10.0, 28.0, 28.0)];
        _iconView.image = [UIImage imageNamed:@"首页产品图标.png"];
        [self addSubview:_iconView];
    }
    return self;
}

@end
