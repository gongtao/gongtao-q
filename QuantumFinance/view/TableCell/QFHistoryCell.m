//
//  QFHistoryCell.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/11/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHistoryCell.h"

@interface QFHistoryCell ()

@property (nonatomic, strong) UIImageView *blueShaftView;

@property (nonatomic, strong) UIImageView *whiteShaftView;

@property (nonatomic, strong) UILabel *productLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation QFHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _whiteShaftView = [[UIImageView alloc] initWithFrame:CGRectMake(85.0, 0.0, 4.0, 59.0)];
        _whiteShaftView.image = [UIImage imageNamed:@"历史时间轴白.png"];
        [self.contentView addSubview:_whiteShaftView];
        
        _blueShaftView = [[UIImageView alloc] initWithFrame:CGRectMake(88.0, 0.0, 4.0, 59.0)];
        _blueShaftView.image = [UIImage imageNamed:@"历史时间轴蓝.png"];
        [self.contentView addSubview:_blueShaftView];
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0, 9.0, 77.0, 41.0)];
        leftView.image = [UIImage imageNamed:@"历史产品蓝色底板.png"];
        [self.contentView addSubview:leftView];
        
        UIImageView *centerView = [[UIImageView alloc] initWithFrame:CGRectMake(91.5, 9.0, 201.0, 41.0)];
        centerView.image = [UIImage imageNamed:@"历史产品白色底板.png"];
        [self.contentView addSubview:centerView];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, 6.5, 28.0, 28.0)];
        [centerView addSubview:_iconView];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(292.0, 9.0, 19.0, 41.0)];
        rightView.image = [UIImage imageNamed:@"历史产品白色底板终.png"];
        [self.contentView addSubview:rightView];
        
        _productLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.0, 147.0, 41.0)];
        _productLabel.font = [UIFont systemFontOfSize:17.0];
        _productLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _productLabel.backgroundColor = [UIColor clearColor];
        [centerView addSubview:_productLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(28.0, 0.0, 49.0, 41.0)];
        _timeLabel.font = [UIFont systemFontOfSize:15.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [leftView addSubview:_timeLabel];
    }
    return self;
}

- (void)setLastRow:(BOOL)isLast
{
    if (isLast) {
        _whiteShaftView.frame = CGRectMake(85.0, 0.0, 4.0, 49.5);
        _blueShaftView.frame = CGRectMake(88.0, 0.0, 4.0, 49.5);
    }
    else {
        _whiteShaftView.frame = CGRectMake(85.0, 0.0, 4.0, 59.0);
        _blueShaftView.frame = CGRectMake(88.0, 0.0, 4.0, 59.0);
    }
    
}

- (void)setProduct:(QFProduct *)product
{
    _productLabel.text = product.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    _timeLabel.text = [formatter stringFromDate:product.time];
    
    [_iconView setImageWithURL:[NSURL URLWithString:product.logo] placeholderImage:[UIImage imageNamed:@"首页产品图标.png"]];
}

@end
