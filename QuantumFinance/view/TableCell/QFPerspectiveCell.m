//
//  QFPerspectiveCell.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-8.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFPerspectiveCell.h"

@implementation QFPerspectiveCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _button.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    }
    return self;
}

-(void)configPerspectiveCell:(QFNews *)news;
{
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 10, 160, 18)];
    titleLable.backgroundColor=[UIColor clearColor];
    titleLable.textColor=[UIColor colorWithHexString:@"666666"];
    titleLable.font=[UIFont systemFontOfSize:14];
    
    UILabel *synopsisLable=[[UILabel alloc]initWithFrame:CGRectMake(110, 48, 180, 37)];
    synopsisLable.backgroundColor=[UIColor clearColor];
    synopsisLable.textColor=[UIColor colorWithHexString:@"666666"];
    synopsisLable.font=[UIFont systemFontOfSize:12];
    
    UILabel *commentCountLable=[[UILabel alloc]initWithFrame:CGRectMake(160, 100, 60, 15)];
    commentCountLable.backgroundColor=[UIColor clearColor];
    commentCountLable.textColor=[UIColor colorWithHexString:@"666666"];
    commentCountLable.font=[UIFont systemFontOfSize:12];
    
    UILabel *viewCountLable=[[UILabel alloc]initWithFrame:CGRectMake(230, 100, 60, 15)];
    viewCountLable.backgroundColor=[UIColor clearColor];
    viewCountLable.textColor=[UIColor colorWithHexString:@"666666"];
    viewCountLable.font=[UIFont systemFontOfSize:12];

    UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(110, 37, 180, 2)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 135)];
    imageView.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    
    titleLable.text=news.title;
    synopsisLable.text=news.synopsis;
    commentCountLable.text=[NSString stringWithFormat:@"评论：%@",news.commentCount];
    viewCountLable.text=[NSString stringWithFormat:@"浏览：%@",news.viewCount];
    [imageView setImageWithURL:[NSURL URLWithString:news.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){}];
    UIImage *image1=imageView.image;
    UIImage *image2=[UIImage imageNamed:@"视角_阴影.png"];
    UIImage *image3=[UIImage imageNamed:@"视角_左起.png"];
    UIGraphicsBeginImageContext(imageView.frame.size);
    [image1 drawInRect:CGRectMake(10, 10, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(93, 0, image2.size.width, image2.size.height)];
    [image3 drawInRect:CGRectMake(95, 0, image3.size.width, image3.size.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image=newImage;
    
    [_button addSubview:titleLable];
    [_button addSubview:synopsisLable];
    [_button addSubview:commentCountLable];
    [_button addSubview:viewCountLable];
    [_button addSubview:imageView];
    [_button addSubview:lineView];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
