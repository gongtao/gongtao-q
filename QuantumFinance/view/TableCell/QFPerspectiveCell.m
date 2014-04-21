//
//  QFPerspectiveCell.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-8.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFPerspectiveCell.h"

@interface QFPerspectiveCell ()

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *synopsisLable;

@property (nonatomic, strong) UILabel *commentCountLable;

@property (nonatomic, strong) UILabel *viewCountLable;

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation QFPerspectiveCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView *background=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 110)];
        background.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
        [self addSubview:background];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 5, 160, 18)];
        _titleLable.backgroundColor=[UIColor clearColor];
        _titleLable.textColor=[UIColor colorWithHexString:@"666666"];
        _titleLable.font=[UIFont systemFontOfSize:14];
        _titleLable.textAlignment = NSTextAlignmentRight;
        [background addSubview:_titleLable];
        
        _synopsisLable=[[UILabel alloc]initWithFrame:CGRectMake(120, 34, 170, 37)];
        _synopsisLable.backgroundColor=[UIColor clearColor];
        _synopsisLable.textColor=[UIColor colorWithHexString:@"666666"];
        _synopsisLable.font=[UIFont systemFontOfSize:12];
        _synopsisLable.numberOfLines=0;
        [background addSubview:_synopsisLable];
        
        _commentCountLable=[[UILabel alloc]initWithFrame:CGRectMake(160, 90, 60, 15)];
        _commentCountLable.backgroundColor=[UIColor clearColor];
        _commentCountLable.textColor=[UIColor colorWithHexString:@"666666"];
        _commentCountLable.font=[UIFont systemFontOfSize:12];
        [background addSubview:_commentCountLable];
        
        _viewCountLable=[[UILabel alloc]initWithFrame:CGRectMake(230, 90, 60, 15)];
        _viewCountLable.backgroundColor=[UIColor clearColor];
        _viewCountLable.textColor=[UIColor colorWithHexString:@"666666"];
        _viewCountLable.font=[UIFont systemFontOfSize:12];
        [background addSubview:_viewCountLable];
        
        UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(110, 27, 180, 1)];
        lineView.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
        [background addSubview:lineView];
        
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
        bgView.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
        bgView.clipsToBounds = YES;
        [background addSubview:bgView];
        
        _logoView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 110, 100)];
        _logoView.contentMode=UIViewContentModeScaleAspectFill;
        _logoView.clipsToBounds = YES;
        [bgView addSubview:_logoView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 68, 260)];
        imageView.image = [UIImage imageNamed:@"视角_阴影.png"];
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        imageView.center = CGPointMake(95.0, 65.0);
        [bgView addSubview:imageView];
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 62, 260)];
        imageView.image = [UIImage imageNamed:@"视角_左起.png"];
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        imageView.center = CGPointMake(94.5, 65.0);
        [bgView addSubview:imageView];
    }
    return self;
}

-(void)configPerspectiveCell:(QFNews *)news;
{
    _titleLable.text=news.title;
    _synopsisLable.text=news.synopsis;
    _commentCountLable.text=[NSString stringWithFormat:@"评论：%@",news.commentCount];
    _viewCountLable.text=[NSString stringWithFormat:@"浏览：%@",news.viewCount];
    
    [_logoView setImageWithURL:[NSURL URLWithString:news.logo] placeholderImage:[UIImage imageNamed:@"视角文章默认图.png"]];
}

@end
