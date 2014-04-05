//
//  QFSettingViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-5.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFSettingViewController.h"

#import "QFSettingTableViewController.h"

@interface QFSettingViewController ()

@end

@implementation QFSettingViewController

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
    CGFloat y=IS_IPhone5_or_5s?170:140;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 225, 90)];
    imageView.center=CGPointMake(self.view.frame.size.width/2, y);
    imageView.image=[UIImage imageNamed:@"头像底板.png"];
    [self.view addSubview:imageView];
    QFSettingTableViewController *tableVc=[[QFSettingTableViewController alloc]initWithStyle:UITableViewAutomaticDimension];
    //tableVc.view.frame=CGRectMake(0, 0, 300, 200);
    tableVc.tableView.frame=CGRectMake(0, 0, 300, 200);
    //tableVc.view.center=CGPointMake(self.view.frame.size.width/2, y+180);
    tableVc.tableView.center=CGPointMake(self.view.frame.size.width/2, y+140);
    [self addChildViewController:tableVc];
    [self.view addSubview:tableVc.view];
    
    UIButton *exitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, y+260, 300, 30)];
    //exitButton.center=CGPointMake(self.view.frame.size.width/2, y+260);
    exitButton.backgroundColor=[UIColor colorWithHexString:@"ff0000"];
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    //[exitButton setTitle:@"退出登录" forState:UIControlStateHighlighted];
    [exitButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    //[exitButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateHighlighted];
    exitButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [exitButton addTarget:self action:@selector(exitButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitButton];
    //NSLog(@"%f,%f",self.view.frame.size.width,self.view.frame.size.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)exitButtonTap:(id)sender
{}

@end
