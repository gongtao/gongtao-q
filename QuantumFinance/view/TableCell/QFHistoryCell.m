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
    }
    return self;
}

@end
