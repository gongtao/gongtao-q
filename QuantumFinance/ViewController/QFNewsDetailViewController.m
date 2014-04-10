//
//  QFNewsDetailViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFNewsDetailViewController.h"

#import "QFNewsDetailToolBar.h"

@interface QFNewsDetailViewController ()
{
    
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,strong)NSString *logo;

@property(nonatomic,strong)NSNumber *commentCount;

@property(nonatomic,strong)NSNumber *viewCount;

@property(nonatomic,strong)NSNumber *contentHeight;



@end

@implementation QFNewsDetailViewController

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
    //[self configNews];
    UIImageView *imageViewLogo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 180)];
    [imageViewLogo setImageWithURL:[NSURL URLWithString:_news.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){}];
    
    UILabel *LabelTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 82, 40)];
    //LabelTitle.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"xx.png"]];
    LabelTitle.backgroundColor=[UIColor colorWithHexString:@"0f9fde"];
    LabelTitle.font=[UIFont systemFontOfSize:14];
    LabelTitle.textColor=[UIColor colorWithHexString:@"ffffff"];
    LabelTitle.text=_news.title;

    
    UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
    [labelContent setNumberOfLines:0];  //必须是这组值

    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(300,3000);
    NSString *newContent=[NSString stringWithFormat:@"%@\n\n评论：%@ 浏览：%@ %@",_news.content,_news.commentCount,_news.viewCount,_news.date];
    CGSize labelsize = [newContent sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeWordWrap:以空格为界,保留整个单词
    labelContent.frame = CGRectMake(10, 240, labelsize.width, labelsize.height );
    labelContent.backgroundColor = [UIColor colorWithHexString:@"f0f4f7"];
    labelContent.textColor = [UIColor colorWithHexString:@"666666"];
    labelContent.text = newContent;
    labelContent.font = font;
    _contentHeight=[NSNumber numberWithFloat:labelsize.height];
    
    
    
    
}

-(void)configNews
{
    _title=_news.title;
    _content=_news.content;
    _date=_news.date;
    _logo=_news.logo;
    _commentCount=_news.commentCount;
    _viewCount=_news.viewCount;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
