//
//  QFRecommendProductCell.m
//  QuantumFinance
//
//  Created by 龚 涛 on 14-4-6.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFRecommendProductCell.h"

#import <CoreText/CoreText.h>

#import "QFProductProgress.h"

@interface QFRecommendProductCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *deadlineLabel;

@property (nonatomic, strong) UILabel *infoLabel1;

@property (nonatomic, strong) UILabel *infoLabel2;

@property (nonatomic, strong) UILabel *infoLabel3;

@property (nonatomic, strong) UILabel *scheduleLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *eairImageView;

@property (nonatomic, strong) QFProductProgress *progress;

@end

@implementation QFRecommendProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 4.0, 302.0, 100.0)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"f4f0f7"];
        [self addSubview:bgView];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, 8.0, 28.0, 28.0)];
        _iconView.image = [UIImage imageNamed:@"首页产品图标.png"];
        [bgView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0, 13.0, 151.0, 19.0)];
        _titleLabel.textColor = Color_NewsFont;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(44.0, 35.0, 153.0, 1.0)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"660e9fde"];
        [bgView addSubview:_lineView];
        
        _infoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 44.0, 75.0, 18.0)];
        _infoLabel1.textColor = Color_NewsFont;
        _infoLabel1.font = [UIFont systemFontOfSize:14.0];
        _infoLabel1.text = @"理财期限：";
        _infoLabel1.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_infoLabel1];
        
        _deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0, 43.0, 17.0, 21.0)];
        _deadlineLabel.textColor = Color_MainBlue;
        _deadlineLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _deadlineLabel.text = @"4";
        _deadlineLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_deadlineLabel];
        
        _infoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 73.0, 75.0, 18.0)];
        _infoLabel2.textColor = Color_NewsFont;
        _infoLabel2.font = [UIFont systemFontOfSize:14.0];
        _infoLabel2.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_infoLabel2];
        
        _infoLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 44.0, 32.0, 18.0)];
        _infoLabel3.textColor = Color_NewsFont;
        _infoLabel3.font = [UIFont systemFontOfSize:14.0];
        _infoLabel3.text = @"个月";
        _infoLabel3.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_infoLabel3];
        
        _scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0, 72.0, 103.0, 21.0)];
        _scheduleLabel.textColor = Color_MainBlue;
        _scheduleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _scheduleLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_scheduleLabel];
        
        _progress = [[QFProductProgress alloc] initWithFrame:CGRectZero];
        _progress.backgroundColor = [UIColor clearColor];
        _progress.layer.borderColor = [UIColor colorWithHexString:@"66666666"].CGColor;
        _progress.layer.borderWidth = 1.0;
        [bgView addSubview:_progress];
        
        _eairImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 230.0, 204.0)];
        _eairImageView.image = [[UIImage imageNamed:@"首页年化收益底板.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(102.0, 107.0, 102.0, 1.0)];
        _eairImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        _eairImageView.center = CGPointMake(249.0, 50.0);
        [bgView addSubview:_eairImageView];
    }
    return self;
}

- (void)setProduct:(QFProduct *)product
{
    self.titleLabel.text = product.title;
    
    NSMutableAttributedString *deadline = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", product.deadline]];
    [deadline addAttribute:(NSString *)kCTFontAttributeName
                     value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:17].fontName,17.0,NULL))
                     range:NSMakeRange(0, deadline.string.length)];
    CGSize size = [deadline size];
    _deadlineLabel.frame = CGRectMake(83.0, 43.0, size.width+1.0, 21.0);
    _deadlineLabel.text = deadline.string;
    
    _infoLabel3.frame = CGRectMake(CGRectGetMaxX(_deadlineLabel.frame), 44.0, 32.0, 18.0);
    
    NSMutableAttributedString *schedule = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", product.schedule]];
    [schedule addAttribute:(NSString *)kCTFontAttributeName
                     value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:17].fontName,17.0,NULL))
                     range:NSMakeRange(0, schedule.string.length)];
    size = [schedule size];
    size.width += 1.0;
    
    if ([product.schedule rangeOfString:@"%"].location == NSNotFound) {
        _infoLabel2.text = @"开始时间：";
        _scheduleLabel.frame = CGRectMake(83.0, 72.0, size.width, 21.0);
        _progress.hidden = YES;
    }
    else {
        _infoLabel2.text = @"当前进度：";
        _scheduleLabel.frame = CGRectMake(196.0-size.width, 72.0, size.width, 21.0);
        NSString *progress = [product.schedule stringByReplacingOccurrencesOfString:@"%" withString:@""];
        _progress.frame = CGRectMake(83.0, _infoLabel2.center.y-3.0, 107.0-size.width, 6.0);
        [_progress setProgress:progress.floatValue/100.0];
        _progress.hidden = NO;
    }
    _scheduleLabel.text = product.schedule;
}

@end
