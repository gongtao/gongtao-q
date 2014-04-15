//
//  QFProductDetailViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/15/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFProductDetailViewController.h"

#import <CoreText/CoreText.h>

@interface QFProductDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation QFProductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGFloat y = CGRectGetMaxY(self.customNavigationBar.frame);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, y, 320.0, self.view.bounds.size.height-y)];
    [self.view addSubview:_scrollView];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:_product.title];
    [title addAttribute:(NSString *)kCTFontAttributeName
                  value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:17.0].fontName,17.0,NULL))
                  range:NSMakeRange(0, title.length)];
    CGSize size = [title size];
    if (size.width > 231.0) {
        size.width = 231.0;
    }
    
    y = 9.0;
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0, y, size.width+52.0, 41.0)];
    titleBgView.image = [UIImage imageNamed:@"文章详情标题底板.png"];
    [_scrollView addSubview:titleBgView];
    
    UIImageView *titleEndView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleBgView.frame), y, 19.0, 41.0)];
    titleEndView.image = [UIImage imageNamed:@"产品详情名称底板终.png"];
    [_scrollView addSubview:titleEndView];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0, 6.5, 28.0, 28.0)];
    [iconView setImageWithURL:[NSURL URLWithString:_product.logo] placeholderImage:[UIImage imageNamed:@"首页产品图标.png"]];
    [titleBgView addSubview:iconView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.0, size.width, 41.0)];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _product.title;
    [titleBgView addSubview:titleLabel];
    
    y += titleBgView.frame.size.height+9.0;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9.0, y, 302.0, 118.0)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"f4f0f7"];
    [_scrollView addSubview:bgView];
    
    //总额度
    UILabel *infoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 6.0, 85.0, 18.0)];
    infoLabel1.textColor = Color_NewsFont;
    infoLabel1.font = [UIFont systemFontOfSize:14.0];
    infoLabel1.text = @"总额度：";
    infoLabel1.backgroundColor = [UIColor clearColor];
    [bgView addSubview:infoLabel1];
    
    //年化收益率
    UILabel *infoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, CGRectGetMaxY(infoLabel1.frame)+10.0, 85.0, 18.0)];
    infoLabel2.textColor = Color_NewsFont;
    infoLabel2.font = [UIFont systemFontOfSize:14.0];
    infoLabel2.text = @"年化收益率：";
    infoLabel2.backgroundColor = [UIColor clearColor];
    [bgView addSubview:infoLabel2];
    
    //投资期限
    UILabel *infoLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, CGRectGetMaxY(infoLabel2.frame)+10.0, 85.0, 18.0)];
    infoLabel3.textColor = Color_NewsFont;
    infoLabel3.font = [UIFont systemFontOfSize:14.0];
    infoLabel3.text = @"投资期限：";
    infoLabel3.backgroundColor = [UIColor clearColor];
    [bgView addSubview:infoLabel3];
    
    NSMutableAttributedString *deadline = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", _product.deadline]];
    [deadline addAttribute:(NSString *)kCTFontAttributeName
                     value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:15].fontName,15.0,NULL))
                     range:NSMakeRange(0, deadline.string.length)];
    size = [deadline size];
    
    UILabel *deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(95.0, infoLabel3.frame.origin.y-0.5, size.width+1.0, 19.0)];
    deadlineLabel.textColor = Color_MainBlue;
    deadlineLabel.font = [UIFont boldSystemFontOfSize:15.0];
    deadlineLabel.backgroundColor = [UIColor clearColor];
    deadlineLabel.text = deadline.string;
    [bgView addSubview:deadlineLabel];
    
    UILabel *infoLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deadlineLabel.frame), deadlineLabel.frame.origin.y, 32.0, 19.0)];
    infoLabel5.textColor = Color_NewsFont;
    infoLabel5.font = [UIFont systemFontOfSize:15.0];
    infoLabel5.text = @"个月";
    infoLabel5.backgroundColor = [UIColor clearColor];
    [bgView addSubview:infoLabel5];
    
    //进度
    UILabel *infoLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(8.0, CGRectGetMaxY(infoLabel3.frame)+10.0, 85.0, 18.0)];
    infoLabel4.textColor = Color_NewsFont;
    infoLabel4.font = [UIFont systemFontOfSize:14.0];
    infoLabel4.backgroundColor = [UIColor clearColor];
    [bgView addSubview:infoLabel4];
    
    if ([self.product.schedule rangeOfString:@"%"].location == NSNotFound) {
        infoLabel4.text = @"开始时间：";
//        _scheduleLabel.frame = CGRectMake(83.0, 72.0, size.width, 21.0);
//        _progress.hidden = YES;
    }
    else {
        infoLabel4.text = @"当前进度：";
//        _scheduleLabel.frame = CGRectMake(196.0-size.width, 72.0, size.width, 21.0);
//        NSString *progress = [product.schedule stringByReplacingOccurrencesOfString:@"%" withString:@""];
//        _progress.frame = CGRectMake(83.0, _infoLabel2.center.y-3.0, 107.0-size.width, 6.0);
//        [_progress setProgress:progress.floatValue/100.0];
//        _progress.hidden = NO;
    }
//    _scheduleLabel.text = product.schedule;
    
    y += bgView.frame.size.height+9.0;
    if (_product.content && _product.content.length>0) {
        UIImageView *otherBgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0, y, 80.0, 41.0)];
        otherBgView.image = [UIImage imageNamed:@"文章详情标题底板.png"];
        [_scrollView addSubview:otherBgView];
        
        UIImageView *otherEndView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(otherBgView.frame), y, 19.0, 41.0)];
        otherEndView.image = [UIImage imageNamed:@"产品详情名称底板终.png"];
        [_scrollView addSubview:otherEndView];
        
        UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 0.0, 70.0, 41.0)];
        otherLabel.font = [UIFont systemFontOfSize:17.0];
        otherLabel.textColor = [UIColor whiteColor];
        otherLabel.backgroundColor = [UIColor clearColor];
        otherLabel.text = @"其他信息";
        [otherBgView addSubview:otherLabel];
        
        NSString *content = [NSString stringWithFormat:@"介绍：\n       %@", _product.content];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
        size = [content boundingRectWithSize:CGSizeMake(286.0, 0.0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        size.height = (NSInteger)size.height+1.0;
        
        y += otherBgView.frame.size.height+9.0;
        UIView *desBgView = [[UIView alloc] initWithFrame:CGRectMake(9.0, y, 302.0, size.height+16.0)];
        desBgView.backgroundColor = [UIColor colorWithHexString:@"f4f0f7"];
        [_scrollView addSubview:desBgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, 286.0, size.height)];
        label.font = [UIFont systemFontOfSize:14.0];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = Color_NewsFont;
        label.text = content;
        label.numberOfLines = 0;
        [desBgView addSubview:label];
        
        y+= desBgView.frame.size.height+9.0;
    }
    
    _scrollView.contentSize = CGSizeMake(320.0, y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
